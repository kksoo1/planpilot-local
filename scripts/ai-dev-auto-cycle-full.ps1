param(
    [int]$MaxTasks = 1,
    [int]$MaxSteps = 22,
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowCodex,
    [switch]$AllowReviewCodex,
    [switch]$AllowCommit,
    [switch]$AllowDirty,
    [string[]]$ProtectedBaselineDirtyPaths,
    [string[]]$CommitFiles
)

. $PSScriptRoot\ai-dev-env.ps1

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$reviewResponseRelativePath = ".ai-dev/review-response.json"
$aiDevOperationalRoot = ".ai-dev/"
$queuePath = Join-Path $repoRoot $queueRelativePath
$statePath = Join-Path $repoRoot $stateRelativePath
$reviewResponsePath = Join-Path $repoRoot $reviewResponseRelativePath
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)

function Test-HasValue {
    param(
        [object]$Value
    )

    if ($null -eq $Value) {
        return $false
    }

    if ($Value -is [string]) {
        return -not [string]::IsNullOrWhiteSpace($Value)
    }

    return $true
}

function Read-JsonFile {
    param(
        [string]$Path,
        [string]$RelativePath
    )

    try {
        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | ConvertFrom-Json
    } catch {
        throw "$RelativePath JSON 파싱에 실패했습니다: $($_.Exception.Message)"
    }
}

function Set-ObjectProperty {
    param(
        [object]$InputObject,
        [string]$Name,
        [object]$Value
    )

    if ($InputObject.PSObject.Properties.Name -contains $Name) {
        $InputObject.$Name = $Value
    } else {
        $InputObject | Add-Member -NotePropertyName $Name -NotePropertyValue $Value
    }
}

function Write-JsonFile {
    param(
        [string]$Path,
        [object]$Value
    )

    $json = $Value | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($Path, $json, $utf8WithBom)
}

function Save-CycleFailureState {
    param(
        [string]$Command,
        [string]$ErrorSummary,
        [object]$ReviewGate = $null,
        [string]$StopReason = $null
    )

    try {
        $state = Read-JsonFile $statePath $stateRelativePath

        if ($null -ne $ReviewGate -and (Test-HasValue $ReviewGate.decision)) {
            Set-ObjectProperty $state "lastReviewDecision" ([string]$ReviewGate.decision)
        }

        if ($null -ne $ReviewGate -and (Test-HasValue $ReviewGate.severity)) {
            Set-ObjectProperty $state "lastReviewSeverity" ([string]$ReviewGate.severity)
        }

        if ($null -ne $ReviewGate -and (Test-HasValue $ReviewGate.nextStep)) {
            Set-ObjectProperty $state "lastReviewNextStep" ([string]$ReviewGate.nextStep)
        }

        if ($null -ne $ReviewGate -and (Test-HasValue $ReviewGate.summary)) {
            Set-ObjectProperty $state "lastReviewSummary" ([string]$ReviewGate.summary)
        }

        if ($null -ne $ReviewGate -and ($ReviewGate.PSObject.Properties.Name -contains "requiredChanges")) {
            Set-ObjectProperty $state "lastReviewRequiredChanges" @($ReviewGate.requiredChanges)
        }

        Set-ObjectProperty $state "lastCommand" $Command
        Set-ObjectProperty $state "lastCommandStatus" "failed"
        Set-ObjectProperty $state "lastErrorSummary" $ErrorSummary
        if (Test-HasValue $StopReason) {
            Set-ObjectProperty $state "stopReason" $StopReason
        }
        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
        Write-JsonFile $statePath $state
    } catch {
        Write-Warning "상태 파일에 실패 사유를 기록하지 못했습니다: $($_.Exception.Message)"
    }
}

function Get-CurrentTaskIdForRecovery {
    $state = Read-JsonFile $statePath $stateRelativePath

    if (Test-HasValue $state.currentTaskId) {
        return [string]$state.currentTaskId
    }

    if ($null -ne $script:currentTask -and (Test-HasValue $script:currentTask.id)) {
        return [string]$script:currentTask.id
    }

    return "unknown"
}

function Ensure-RecoveryState {
    param(
        [object]$State
    )

    if (-not ($State.PSObject.Properties.Name -contains "autoRecovery") -or $null -eq $State.autoRecovery) {
        Set-ObjectProperty $State "autoRecovery" ([PSCustomObject][ordered]@{})
    }

    return $State.autoRecovery
}

function Ensure-RecoveryTaskState {
    param(
        [object]$RecoveryState,
        [string]$TaskId
    )

    if (-not ($RecoveryState.PSObject.Properties.Name -contains $TaskId) -or $null -eq $RecoveryState.$TaskId) {
        $RecoveryState | Add-Member -NotePropertyName $TaskId -NotePropertyValue ([PSCustomObject][ordered]@{
            counts = [PSCustomObject][ordered]@{}
            lastStoppedReason = $null
        })
    }

    if (-not ($RecoveryState.$TaskId.PSObject.Properties.Name -contains "counts") -or $null -eq $RecoveryState.$TaskId.counts) {
        Set-ObjectProperty $RecoveryState.$TaskId "counts" ([PSCustomObject][ordered]@{})
    }

    return $RecoveryState.$TaskId
}

function Get-RecoveryCount {
    param(
        [string]$Reason
    )

    $state = Read-JsonFile $statePath $stateRelativePath
    $taskId = Get-CurrentTaskIdForRecovery
    $recoveryState = Ensure-RecoveryState $state
    $taskState = Ensure-RecoveryTaskState $recoveryState $taskId

    if ($taskState.counts.PSObject.Properties.Name -contains $Reason) {
        return [int]$taskState.counts.$Reason
    }

    return 0
}

function Add-RecoveryAttempt {
    param(
        [string]$Reason
    )

    $state = Read-JsonFile $statePath $stateRelativePath
    $taskId = Get-CurrentTaskIdForRecovery
    $recoveryState = Ensure-RecoveryState $state
    $taskState = Ensure-RecoveryTaskState $recoveryState $taskId
    $currentCount = 0

    if ($taskState.counts.PSObject.Properties.Name -contains $Reason) {
        $currentCount = [int]$taskState.counts.$Reason
        $taskState.counts.$Reason = $currentCount + 1
    } else {
        $taskState.counts | Add-Member -NotePropertyName $Reason -NotePropertyValue 1
    }

    Set-ObjectProperty $taskState "lastStoppedReason" $Reason
    Set-ObjectProperty $state "stopReason" $Reason
    Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
    Write-JsonFile $statePath $state

    return ($currentCount + 1)
}

function Save-StoppedReason {
    param(
        [string]$StoppedReason
    )

    try {
        $state = Read-JsonFile $statePath $stateRelativePath
        $taskId = if (Test-HasValue $state.currentTaskId) { [string]$state.currentTaskId } else { "unknown" }
        $recoveryState = Ensure-RecoveryState $state
        $taskState = Ensure-RecoveryTaskState $recoveryState $taskId

        Set-ObjectProperty $taskState "lastStoppedReason" $StoppedReason
        Set-ObjectProperty $state "stopReason" $StoppedReason
        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
        Write-JsonFile $statePath $state
    } catch {
        Write-Warning "상태 파일에 stopped reason을 기록하지 못했습니다: $($_.Exception.Message)"
    }
}

function Get-CurrentTask {
    param(
        [object]$Queue,
        [object]$State
    )

    $tasks = @($Queue.tasks)
    $currentTaskId = $null

    if (Test-HasValue $State.currentTaskId) {
        $currentTaskId = [string]$State.currentTaskId
    } elseif (Test-HasValue $Queue.currentTaskId) {
        $currentTaskId = [string]$Queue.currentTaskId
    } else {
        $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-Object -First 1

        if ($null -ne $inProgressTask) {
            $currentTaskId = [string]$inProgressTask.id
        } else {
            $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Object -First 1

            if ($null -ne $pendingTask) {
                $currentTaskId = [string]$pendingTask.id
            }
        }
    }

    if (-not (Test-HasValue $currentTaskId)) {
        return $null
    }

    return $tasks | Where-Object { $_.id -eq $currentTaskId } | Select-Object -First 1
}

function Get-NextTask {
    param(
        [object]$Queue,
        [object]$State,
        [object]$CompletedTask
    )

    $currentTask = Get-CurrentTask $Queue $State
    $completedTaskId = if ($null -ne $CompletedTask -and (Test-HasValue $CompletedTask.id)) { [string]$CompletedTask.id } else { $null }

    if ($null -ne $currentTask -and $currentTask.status -ne "done" -and $currentTask.id -ne $completedTaskId) {
        return $currentTask
    }

    return @($Queue.tasks) |
        Where-Object { $_.status -in @("in_progress", "pending") -and $_.id -ne $completedTaskId } |
        Select-Object -First 1
}

function Update-PostCompleteTaskContext {
    param(
        [object]$CompletedTask
    )

    $completedTaskForContext = $null
    $completedTaskId = $null

    if ($null -ne $CompletedTask) {
        $completedTaskId = if (Test-HasValue $CompletedTask.id) { [string]$CompletedTask.id } else { $null }
        $completedTaskForContext = [PSCustomObject][ordered]@{
            id = [string]$CompletedTask.id
            title = [string]$CompletedTask.title
            status = "done"
            type = [string]$CompletedTask.type
        }
    }

    $script:completedTask = $completedTaskForContext
    $script:completedTaskCount++
    $script:currentTask = $null
    $script:nextTask = $null

    try {
        $queueAfterComplete = Read-JsonFile $queuePath $queueRelativePath
        $stateAfterComplete = Read-JsonFile $statePath $stateRelativePath

        if (Test-HasValue $completedTaskId) {
            $refreshedCompletedTask = @($queueAfterComplete.tasks) |
                Where-Object { $_.id -eq $completedTaskId } |
                Select-Object -First 1

            if ($null -ne $refreshedCompletedTask) {
                $script:completedTask = $refreshedCompletedTask
            }
        }

        $currentTaskAfterComplete = Get-CurrentTask $queueAfterComplete $stateAfterComplete

        if ($null -ne $currentTaskAfterComplete -and $currentTaskAfterComplete.status -ne "done" -and $currentTaskAfterComplete.id -ne $completedTaskId) {
            $script:currentTask = $currentTaskAfterComplete
        }

        $script:nextTask = Get-NextTask $queueAfterComplete $stateAfterComplete $script:completedTask
    } catch {
        Write-Warning "complete-task 이후 task context를 최신 queue/state로 갱신하지 못했습니다: $($_.Exception.Message)"
    }
}

function ConvertTo-TaskContext {
    param(
        [object]$Task
    )

    if ($null -eq $Task) {
        return $null
    }

    return [PSCustomObject][ordered]@{
        id = [string]$Task.id
        title = [string]$Task.title
        status = [string]$Task.status
        type = [string]$Task.type
    }
}

function New-StepResult {
    param(
        [int]$Step,
        [string]$Name,
        [string]$Command,
        [bool]$Executed,
        [bool]$Skipped,
        [int]$ExitCode,
        [string]$Message
    )

    return [PSCustomObject][ordered]@{
        step = $Step
        name = $Name
        command = $Command
        executed = $Executed
        skipped = $Skipped
        exitCode = $ExitCode
        message = $Message
    }
}

function New-CycleResult {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    $lastStep = @($Steps) | Select-Object -Last 1
    $currentTask = $script:currentTask
    $completedTask = $script:completedTask
    $nextTask = $script:nextTask
    $currentTaskContext = ConvertTo-TaskContext $currentTask
    $completedTaskContext = ConvertTo-TaskContext $completedTask
    $nextTaskContext = ConvertTo-TaskContext $nextTask
    $taskContext = $currentTaskContext
    $lastStepContext = $null

    if ($null -eq $taskContext -and $null -ne $completedTaskContext) {
        $taskContext = $completedTaskContext
    }

    if ($null -ne $lastStep) {
        $lastStepContext = [PSCustomObject][ordered]@{
            step = $lastStep.step
            name = $lastStep.name
            executed = $lastStep.executed
            skipped = $lastStep.skipped
            exitCode = $lastStep.exitCode
        }
    }

    return [PSCustomObject][ordered]@{
        steps = @($Steps)
        stoppedReason = $StoppedReason
        completed = $Completed
        exitCode = $ExitCode
        context = [PSCustomObject][ordered]@{
            task = $taskContext
            completedTask = $completedTaskContext
            currentTask = $currentTaskContext
            nextTask = $nextTaskContext
            completedTaskCount = $script:completedTaskCount
            maxTasks = $MaxTasks
            maxSteps = $MaxSteps
            stepCount = @($Steps).Count
            lastStep = $lastStepContext
        }
    }
}

function Write-CycleResult {
    param(
        [object]$Result
    )

    if ($Json) {
        $Result | ConvertTo-Json -Depth 20
        return
    }

    foreach ($step in @($Result.steps)) {
        Write-Host "Step $($step.step): $($step.name)"
        Write-Host "  Command: $($step.command)"
        Write-Host "  Executed: $($step.executed)"
        Write-Host "  Skipped: $($step.skipped)"
        Write-Host "  Exit code: $($step.exitCode)"
        Write-Host "  Message: $($step.message)"
    }

    Write-Host "Stopped reason: $($Result.stoppedReason)"
    Write-Host "Completed: $($Result.completed)"
    Write-Host "Exit code: $($Result.exitCode)"
    Write-Host "Context:"
    if ($null -ne $Result.context.task) {
        Write-Host "  Task: $($Result.context.task.id) $($Result.context.task.title)"
        Write-Host "  Task status: $($Result.context.task.status)"
    } else {
        Write-Host "  Task: none"
    }
    if ($null -ne $Result.context.completedTask) {
        Write-Host "  Completed task: $($Result.context.completedTask.id) $($Result.context.completedTask.title)"
    } else {
        Write-Host "  Completed task: none"
    }
    if ($null -ne $Result.context.currentTask) {
        Write-Host "  Current task: $($Result.context.currentTask.id) $($Result.context.currentTask.title)"
    } else {
        Write-Host "  Current task: none"
    }
    if ($null -ne $Result.context.nextTask) {
        Write-Host "  Next task: $($Result.context.nextTask.id) $($Result.context.nextTask.title)"
    } else {
        Write-Host "  Next task: none"
    }
    Write-Host "  Completed tasks: $($Result.context.completedTaskCount) / $($Result.context.maxTasks)"
    Write-Host "  Steps recorded: $($Result.context.stepCount) / $($Result.context.maxSteps)"
    if ($null -ne $Result.context.lastStep) {
        Write-Host "  Last step: $($Result.context.lastStep.step) $($Result.context.lastStep.name) exit=$($Result.context.lastStep.exitCode)"
    } else {
        Write-Host "  Last step: none"
    }

}

function Stop-Cycle {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    if (-not $Completed -and -not $DryRun) {
        Save-StoppedReason $StoppedReason
    }

    $result = New-CycleResult $Steps $StoppedReason $Completed $ExitCode
    Write-CycleResult $result
    exit $ExitCode
}

function Complete-Cycle {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [int]$StepNumber
    )

    try {
        $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "git status --short"

        if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
            $changeLines = @($remainingStatus -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
            $changedPaths = @(
                $changeLines |
                    ForEach-Object { Convert-ToChangedPath $_ } |
                    ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
                    Where-Object { Test-HasValue $_ } |
                    Select-Object -Unique
            )
            $protectedPaths = @($changedPaths | Where-Object { Test-IsProtectedBaselineDirtyPath $_ })
            $nonAiDevPaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
            $eligibleAiDevPaths = @($changedPaths | Where-Object { (Test-IsAiDevOperationalPath $_) -and -not (Test-IsProtectedBaselineDirtyPath $_) })

            if ($nonAiDevPaths.Count -gt 0) {
                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $true $false 1 "Completed clean verification failed: non-.ai-dev changes remain after all full-cycle result/state files were written.`n$remainingStatus"
                Stop-Cycle $Steps "completed_non_ai_dev_changes" $false 1
            }

            if ($protectedPaths.Count -gt 0) {
                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $true $false 1 "Completed clean verification failed: protected baseline dirty .ai-dev paths remain and must not be absorbed into the final meta commit.`n$($protectedPaths -join "`n")`n$remainingStatus"
                Stop-Cycle $Steps "completed_protected_baseline_dirty" $false 1
            }

            if ($eligibleAiDevPaths.Count -eq 0) {
                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $true $false 1 "Completed clean verification failed: worktree still has changes, but none are eligible new .ai-dev operational changes.`n$remainingStatus"
                Stop-Cycle $Steps "completed_no_eligible_meta_changes" $false 1
            }

            if (-not $AllowCommit) {
                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $true $false 1 "Completed clean verification failed: only new .ai-dev operational changes remain, but -AllowCommit is required for the final auto-cycle meta commit.`n$remainingStatus"
                Stop-Cycle $Steps "completed_ai_dev_changes_require_commit" $false 1
            }

            if ($DryRun) {
                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short; git add/commit final .ai-dev operational changes; git status --short" $false $true 0 "DryRun: only new .ai-dev operational changes remain, but the final auto-cycle meta commit was not created.`n$remainingStatus"
                Stop-Cycle $Steps "dry_run" $false 0
            }

            $addOutput = & git add -- $eligibleAiDevPaths 2>&1 | Out-String
            $addExitCode = $LASTEXITCODE

            if ($addExitCode -ne 0) {
                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git add -- <final .ai-dev files>" $true $false 1 "Final auto-cycle .ai-dev meta add failed. exit code: $addExitCode`n$addOutput"
                Stop-Cycle $Steps "completed_meta_add_failed" $false 1
            }

            $metaCommitMessage = "chore(ai-dev): record final auto-cycle state"
            $commitOutput = & git commit -m $metaCommitMessage -- $eligibleAiDevPaths 2>&1 | Out-String
            $commitExitCode = $LASTEXITCODE

            if ($commitExitCode -ne 0) {
                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git commit -m '$metaCommitMessage' -- <final .ai-dev files>" $true $false 1 "Final auto-cycle .ai-dev meta commit failed. exit code: $commitExitCode`n$commitOutput"
                Stop-Cycle $Steps "completed_meta_commit_failed" $false 1
            }

            $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "git status --short"

            if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $true $false 1 "Completed clean verification failed: changes remain after the final auto-cycle .ai-dev meta commit.`n$remainingStatus"
                Stop-Cycle $Steps "completed_worktree_dirty" $false 1
            }

            $message = ($commitOutput.Trim(), "Final auto-cycle .ai-dev meta commit created: yes", "Completed clean verification passed: git status --short returned no changes.") -join "`n"
            $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short; git add/commit final .ai-dev operational changes; git status --short" $true $false 0 $message
            Stop-Cycle $Steps $StoppedReason $true 0
        }

        $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $true $false 0 "Completed clean verification passed: git status --short returned no changes."
        Stop-Cycle $Steps $StoppedReason $true 0
    } catch {
        $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $false $false 1 $_.Exception.Message
        Stop-Cycle $Steps "completed_clean_gate_failed" $false 1
    }
}

function Invoke-CycleCommand {
    param(
        [int]$StepNumber,
        [string]$Name,
        [string]$Command,
        [string]$ScriptPath,
        [string[]]$Arguments
    )

    if ($DryRun) {
        $script:steps += New-StepResult $StepNumber $Name $Command $false $true 0 "DryRun: 하위 스크립트를 실행하지 않았습니다."
        return
    }

    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1 | Out-String
    $exitCode = $LASTEXITCODE
    $message = $output.Trim()

    if ([string]::IsNullOrWhiteSpace($message)) {
        $message = "완료"
    }

    $script:steps += New-StepResult $StepNumber $Name $Command $true $false $exitCode $message

    if ($exitCode -ne 0) {
        Stop-Cycle $script:steps "$Name`_failed" $false 1
    }
}

function Invoke-CycleCommandCapture {
    param(
        [int]$StepNumber,
        [string]$Name,
        [string]$Command,
        [string]$ScriptPath,
        [string[]]$Arguments
    )

    if ($DryRun) {
        $step = New-StepResult $StepNumber $Name $Command $false $true 0 "DryRun: 하위 스크립트를 실행하지 않았습니다."
        $script:steps += $step
        return $step
    }

    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1 | Out-String
    $exitCode = $LASTEXITCODE
    $message = $output.Trim()

    if ([string]::IsNullOrWhiteSpace($message)) {
        $message = "완료"
    }

    $step = New-StepResult $StepNumber $Name $Command $true $false $exitCode $message
    $script:steps += $step
    return $step
}

function Get-TextFileOrEmpty {
    param(
        [string]$Path
    )

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        return ""
    }

    return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path
}

function Write-TestFailureRevisePrompt {
    param(
        [string]$CheckMessage
    )

    $testResultPath = Join-Path $repoRoot ".ai-dev/test-result.md"
    $promptPath = Join-Path $repoRoot ".ai-dev/revise-prompt.md"
    $testResult = Get-TextFileOrEmpty $testResultPath
    $taskTitle = if ($null -ne $script:currentTask -and (Test-HasValue $script:currentTask.title)) { [string]$script:currentTask.title } else { "" }

    $content = @"
# Test Failure Recovery Prompt

현재 task 검증이 실패했습니다. 실패 항목과 test-result를 기준으로 필요한 최소 수정만 수행하세요.

## Task

$taskTitle

## Failure Summary

```text
$CheckMessage
```

## Test Result

$testResult

## Rules

- 현재 task 범위 밖 수정은 하지 않습니다.
- package.json, package-lock.json, node_modules, dist, .git은 수정하지 않습니다.
- PowerShell 5.1 호환성을 유지합니다.
- 수정 후 실패한 검증이 통과하도록 필요한 코드만 조정합니다.
"@

    [System.IO.File]::WriteAllText($promptPath, $content, $utf8WithBom)
}

function Write-MissingRequiredFilesRevisePrompt {
    param(
        [object]$ReviewGate,
        [string[]]$MissingRequiredFiles,
        [string]$ReasonMessage
    )

    $promptPath = Join-Path $repoRoot ".ai-dev/revise-prompt.md"
    $requiredChangesJson = @($ReviewGate.requiredChanges) | ConvertTo-Json -Depth 20
    $missingText = if ($MissingRequiredFiles.Count -gt 0) { $MissingRequiredFiles -join "`r`n" } else { "없음" }

    $content = @"
# Required Files Recovery Prompt

리뷰 required_changes와 실제 changedFiles 비교에서 누락 파일이 확인되었습니다. 아래 누락 파일만 대상으로 현재 task 범위 안에서 최소 수정하세요.

## Reason

```text
$ReasonMessage
```

## Missing Required Files

```text
$missingText
```

## Latest required_changes

```json
$requiredChangesJson
```

## Rules

- 위 누락 파일과 직접 관련된 변경만 수행합니다.
- 기존 사용자 변경과 baseline 변경을 되돌리지 않습니다.
- package.json, package-lock.json, node_modules, dist, .git은 수정하지 않습니다.
"@

    [System.IO.File]::WriteAllText($promptPath, $content, $utf8WithBom)
}

function Preserve-ReviewJsonFailureResponse {
    $sourcePath = Join-Path $repoRoot ".ai-dev/codex-review-result.md"

    if (-not (Test-Path -LiteralPath $sourcePath -PathType Leaf)) {
        return
    }

    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $targetPath = Join-Path $repoRoot ".ai-dev/codex-review-result.review_json_extraction_failed.$timestamp.raw.md"
    [System.IO.File]::Copy($sourcePath, $targetPath, $true)
}

function Invoke-CheckWithTestRecovery {
    param(
        [int]$StepNumber,
        [string]$Name,
        [string]$Command,
        [string]$ScriptPath,
        [string[]]$Arguments
    )

    $step = Invoke-CycleCommandCapture $StepNumber $Name $Command $ScriptPath $Arguments

    if ($step.exitCode -eq 0) {
        return $StepNumber + 1
    }

    Save-CycleFailureState $Name $step.message $null "test_failed"

    if ((Get-RecoveryCount "test_failed") -ge 1) {
        Stop-Cycle $script:steps "test_failed" $false 1
    }

    if (-not $AllowCodex) {
        $script:steps += New-StepResult ($StepNumber + 1) "test-failure-recovery" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $false $true 1 "test_failed 자동 복구에는 -AllowCodex가 필요합니다."
        Stop-Cycle $script:steps "test_failed" $false 1
    }

    Add-RecoveryAttempt "test_failed" | Out-Null
    Write-TestFailureRevisePrompt $step.message
    $script:steps += New-StepResult ($StepNumber + 1) "test-failure-recovery" ".ai-dev/revise-prompt.md 생성" $false $false 0 "test_failed 복구 프롬프트를 생성했습니다. task별 자동 복구 1회로 기록했습니다."

    $runStepNumber = $StepNumber + 2
    Invoke-CycleCommand $runStepNumber "run-codex-test-recovery" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $scriptPaths.runCodex @("-AllowDirty", "-PromptPath", ".ai-dev/revise-prompt.md")

    $retryStepNumber = $StepNumber + 3
    $retryStep = Invoke-CycleCommandCapture $retryStepNumber "$Name-retry" $Command $ScriptPath $Arguments

    if ($retryStep.exitCode -ne 0) {
        Save-CycleFailureState "$Name-retry" $retryStep.message $null "test_failed"
        Stop-Cycle $script:steps "test_failed" $false 1
    }

    return $StepNumber + 4
}

function Invoke-ReviewCodexWithJsonRecovery {
    param(
        [int]$StepNumber,
        [string]$Name,
        [string]$Command,
        [string]$ScriptPath,
        [string[]]$Arguments
    )

    $stateBeforeStep = Read-JsonFile $statePath $stateRelativePath
    $step = Invoke-CycleCommandCapture $StepNumber $Name $Command $ScriptPath $Arguments

    if ($step.exitCode -eq 0) {
        return $StepNumber + 1
    }

    $stateAfterFailure = Read-JsonFile $statePath $stateRelativePath
    $currentTaskId = if ($null -ne $script:currentTask -and (Test-HasValue $script:currentTask.id)) { [string]$script:currentTask.id } else { $null }
    $stateTaskId = if (Test-HasValue $stateAfterFailure.currentTaskId) { [string]$stateAfterFailure.currentTaskId } else { $null }
    $sameTask = (Test-HasValue $currentTaskId) -and $stateTaskId -eq $currentTaskId
    $isReviewCommand = ($Name -like "*run-review-codex*") -or ($Command -like "*ai-dev-run-review-codex.ps1*")
    $isSaveReviewFailure = $stateAfterFailure.lastCommand -eq "save-review" -and $stateAfterFailure.lastCommandStatus -eq "failed"
    $isJsonStopReason = $stateAfterFailure.stopReason -eq "review_json_extraction_failed"
    $wasAlreadyJsonFailure = (
        $stateBeforeStep.lastCommand -eq "save-review" -and
        $stateBeforeStep.lastCommandStatus -eq "failed" -and
        $stateBeforeStep.stopReason -eq "review_json_extraction_failed" -and
        $stateBeforeStep.currentTaskId -eq $stateAfterFailure.currentTaskId
    )
    $isReviewJsonFailure = $isReviewCommand -and $sameTask -and $isSaveReviewFailure -and $isJsonStopReason -and (-not $wasAlreadyJsonFailure)

    if (-not $isReviewJsonFailure) {
        Stop-Cycle $script:steps "$Name`_failed" $false 1
    }

    if ((Get-RecoveryCount "review_json_extraction_failed") -ge 1) {
        Stop-Cycle $script:steps "review_json_extraction_failed" $false 1
    }

    if (-not $AllowReviewCodex) {
        $script:steps += New-StepResult ($StepNumber + 1) "review-json-recovery" $Command $false $true 1 "review_json_extraction_failed 자동 복구에는 -AllowReviewCodex가 필요합니다."
        Stop-Cycle $script:steps "review_json_extraction_failed" $false 1
    }

    Add-RecoveryAttempt "review_json_extraction_failed" | Out-Null
    Preserve-ReviewJsonFailureResponse
    $script:steps += New-StepResult ($StepNumber + 1) "review-json-recovery" ".ai-dev/codex-review-result.md 보존 후 리뷰 재시도" $false $false 0 "원본 리뷰 응답을 raw 파일로 보존하고 JSON 추출/리뷰 생성을 task별 1회 재시도합니다."

    $retryStepNumber = $StepNumber + 2
    $retryStep = Invoke-CycleCommandCapture $retryStepNumber "$Name-retry" $Command $ScriptPath $Arguments

    if ($retryStep.exitCode -ne 0) {
        Stop-Cycle $script:steps "review_json_extraction_failed" $false 1
    }

    return $StepNumber + 3
}

function Invoke-RequiredFilesRecovery {
    param(
        [int]$StepNumber,
        [string]$Reason,
        [object]$ReviewGate,
        [object]$ImplementationGate
    )

    if ($Reason -notin @("stale_review_required_file_missing", "review_revise_repeated")) {
        return [PSCustomObject][ordered]@{
            recovered = $false
            stepNumber = $StepNumber
            reviewGate = $ReviewGate
        }
    }

    if ((Get-RecoveryCount $Reason) -ge 1) {
        return [PSCustomObject][ordered]@{
            recovered = $false
            stepNumber = $StepNumber
            reviewGate = $ReviewGate
        }
    }

    if (-not $AllowCodex) {
        $script:steps += New-StepResult $StepNumber "$Reason-recovery" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $false $true 1 "$Reason 자동 복구에는 -AllowCodex가 필요합니다."
        Stop-Cycle $script:steps $Reason $false 1
    }

    if (-not $AllowReviewCodex) {
        $script:steps += New-StepResult $StepNumber "$Reason-recovery" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 1 "$Reason 자동 복구에는 -AllowReviewCodex가 필요합니다."
        Stop-Cycle $script:steps $Reason $false 1
    }

    $missingRequiredFiles = @()

    if ($null -ne $ImplementationGate -and ($ImplementationGate.PSObject.Properties.Name -contains "missingRequiredFiles")) {
        $missingRequiredFiles = @($ImplementationGate.missingRequiredFiles)
    } elseif ($null -ne $ReviewGate -and ($ReviewGate.PSObject.Properties.Name -contains "requiredChangeFiles")) {
        $changedFiles = @(Get-ChangedNonAiDevFiles)
        $missingRequiredFiles = @(
            @($ReviewGate.requiredChangeFiles) |
                Where-Object { -not (Test-ReviewRequiredFileIsChanged $_ $changedFiles) }
        )
    }

    if ($missingRequiredFiles.Count -eq 0) {
        return [PSCustomObject][ordered]@{
            recovered = $false
            stepNumber = $StepNumber
            reviewGate = $ReviewGate
        }
    }

    Add-RecoveryAttempt $Reason | Out-Null
    Write-MissingRequiredFilesRevisePrompt $ReviewGate $missingRequiredFiles $ImplementationGate.message
    $script:steps += New-StepResult $StepNumber "$Reason-recovery" ".ai-dev/revise-prompt.md 생성" $false $false 0 "$Reason 복구 프롬프트를 생성했습니다. 누락 파일: $($missingRequiredFiles -join ', ')"
    $StepNumber++

    Invoke-CycleCommand $StepNumber "$Reason-run-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $scriptPaths.runCodex @("-AllowDirty", "-PromptPath", ".ai-dev/revise-prompt.md")
    $StepNumber++

    $checkSpec = Get-CheckCommandSpec $script:currentTask
    $StepNumber = Invoke-CheckWithTestRecovery $StepNumber "$Reason-check" $checkSpec.command $scriptPaths.check $checkSpec.arguments

    Invoke-CycleCommand $StepNumber "$Reason-save-diff" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
    $StepNumber++

    Invoke-CycleCommand $StepNumber "$Reason-make-review-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
    $StepNumber++

    $StepNumber = Invoke-ReviewCodexWithJsonRecovery $StepNumber "$Reason-run-review-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirty", "-SaveReview")

    $newReviewGate = Get-ReviewGate

    return [PSCustomObject][ordered]@{
        recovered = $true
        stepNumber = $StepNumber
        reviewGate = $newReviewGate
    }
}

function Get-ScriptPath {
    param(
        [string]$Name
    )

    $scriptPath = Join-Path $PSScriptRoot $Name

    if (-not (Test-Path -LiteralPath $scriptPath -PathType Leaf)) {
        throw "필수 스크립트를 찾을 수 없습니다: scripts/$Name"
    }

    return $scriptPath
}

function Invoke-GitCapture {
    param(
        [string[]]$Arguments,
        [string]$DisplayName
    )

    $output = & git @Arguments 2>&1 | Out-String
    $exitCode = $LASTEXITCODE

    if ($exitCode -ne 0) {
        throw "$DisplayName 실행에 실패했습니다. exit code: $exitCode`n$output"
    }

    return $output.TrimEnd()
}

function ConvertTo-CanonicalJson {
    param(
        [object]$Value
    )

    if ($null -eq $Value) {
        return ""
    }

    return ($Value | ConvertTo-Json -Depth 50 -Compress)
}

function Test-PackageJsonScriptsOnlyChanged {
    $headJson = Invoke-GitCapture @("show", "HEAD:package.json") "git show HEAD:package.json"
    $currentJson = Get-Content -Raw -Encoding UTF8 -LiteralPath (Join-Path $repoRoot "package.json")
    $headPackage = $headJson | ConvertFrom-Json
    $currentPackage = $currentJson | ConvertFrom-Json
    $blockedFields = @("dependencies", "devDependencies")

    foreach ($field in $blockedFields) {
        $headValue = if ($headPackage.PSObject.Properties.Name -contains $field) { $headPackage.$field } else { $null }
        $currentValue = if ($currentPackage.PSObject.Properties.Name -contains $field) { $currentPackage.$field } else { $null }

        if ((ConvertTo-CanonicalJson $headValue) -ne (ConvertTo-CanonicalJson $currentValue)) {
            return $false
        }
    }

    $headPackage.PSObject.Properties.Remove("scripts")
    $currentPackage.PSObject.Properties.Remove("scripts")

    return (ConvertTo-CanonicalJson $headPackage) -eq (ConvertTo-CanonicalJson $currentPackage)
}

function Get-PackageChangeGate {
    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.json") "git status --porcelain -- package.json package-lock.json"
    $packageLockChanged = $false
    $packageJsonChanged = $false

    foreach ($line in @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })) {
        $paths = @(Convert-ToChangedPath $line | ForEach-Object { ConvertTo-NormalizedChangedPath $_ })

        if (@($paths | Where-Object { $_ -eq "package-lock.json" }).Count -gt 0) {
            $packageLockChanged = $true
        }

        if (@($paths | Where-Object { $_ -eq "package.json" }).Count -gt 0) {
            $packageJsonChanged = $true
        }
    }

    if ($packageLockChanged) {
        return [PSCustomObject][ordered]@{
            passed = $false
            safeScriptsOnly = $false
            message = "package-lock.json 변경이 감지되어 자동 커밋을 중단합니다."
        }
    }

    if ($packageJsonChanged) {
        $scriptsOnly = Test-PackageJsonScriptsOnlyChanged

        return [PSCustomObject][ordered]@{
            passed = $scriptsOnly
            safeScriptsOnly = $scriptsOnly
            message = if ($scriptsOnly) { "package.json scripts 필드만 변경되어 안전한 package 변경으로 허용합니다." } else { "package.json 변경이 scripts 필드 단독 변경이 아니거나 dependencies/devDependencies 변경을 포함해 자동 커밋을 중단합니다." }
        }
    }

    return [PSCustomObject][ordered]@{
        passed = $true
        safeScriptsOnly = $false
        message = "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
    }
}

function Convert-ToChangedPath {
    param(
        [string]$ChangeLine
    )

    if ([string]::IsNullOrWhiteSpace($ChangeLine)) {
        return @()
    }

    $pathText = $ChangeLine

    if ($ChangeLine.Length -ge 4 -and $ChangeLine.Substring(2, 1) -eq " ") {
        $pathText = $ChangeLine.Substring(3)
    }

    if ($pathText.Contains(" -> ")) {
        return @($pathText -split " -> " | Where-Object { Test-HasValue $_ })
    }

    return @($pathText)
}

function ConvertTo-NormalizedChangedPath {
    param(
        [string]$RelativePath
    )

    if (-not (Test-HasValue $RelativePath)) {
        return $null
    }

    return $RelativePath.Trim().Trim('"').Replace('\', '/')
}

function Test-IsAiDevOperationalPath {
    param(
        [string]$RelativePath
    )

    $normalizedRelativePath = ConvertTo-NormalizedChangedPath $RelativePath
    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::OrdinalIgnoreCase)
}

function Get-ProtectedBaselineDirtyPaths {
    if ($null -eq $ProtectedBaselineDirtyPaths -or $ProtectedBaselineDirtyPaths.Count -eq 0) {
        return @()
    }

    return @(
        $ProtectedBaselineDirtyPaths |
            ForEach-Object { $_ -split "," } |
            Where-Object { Test-HasValue $_ } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Select-Object -Unique
    )
}

function Test-IsProtectedBaselineDirtyPath {
    param(
        [string]$RelativePath
    )

    $normalizedRelativePath = ConvertTo-NormalizedChangedPath $RelativePath
    return @($script:protectedBaselineDirtyPaths) -contains $normalizedRelativePath
}

function Get-ChangedNonAiDevFiles {
    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })

    return @(
        $changeLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Where-Object { (Test-HasValue $_) -and -not (Test-IsAiDevOperationalPath $_) -and -not (Test-IsProtectedBaselineDirtyPath $_) } |
            Select-Object -Unique
    )
}

function Test-HasCodexResultContent {
    $codexResultPath = Join-Path $repoRoot ".ai-dev/codex-result.md"

    if (-not (Test-Path -LiteralPath $codexResultPath -PathType Leaf)) {
        return $false
    }

    $content = Get-Content -Raw -Encoding UTF8 -LiteralPath $codexResultPath
    if ($null -eq $content) {
        return $false
    }

    $content = $content.Trim([char]0xFEFF)
    return -not [string]::IsNullOrWhiteSpace($content)
}

function Get-CurrentTaskId {
    if ($null -ne $script:currentTask -and (Test-HasValue $script:currentTask.id)) {
        return [string]$script:currentTask.id
    }

    $state = Read-JsonFile $statePath $stateRelativePath

    if (Test-HasValue $state.currentTaskId) {
        return [string]$state.currentTaskId
    }

    return ""
}

function Test-TextFileContainsLine {
    param(
        [string]$Path,
        [string]$Pattern
    )

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        return $false
    }

    $content = Get-Content -Raw -Encoding UTF8 -LiteralPath $Path
    return [regex]::IsMatch($content, $Pattern, [System.Text.RegularExpressions.RegexOptions]::Multiline)
}

function Test-CurrentValidationPassed {
    $testResultPath = Join-Path $repoRoot ".ai-dev/test-result.md"
    $currentTaskId = Get-CurrentTaskId

    if (-not (Test-HasValue $currentTaskId)) {
        return $false
    }

    if (-not (Test-Path -LiteralPath $testResultPath -PathType Leaf)) {
        return $false
    }

    $content = Get-Content -Raw -Encoding UTF8 -LiteralPath $testResultPath
    $escapedTaskId = [regex]::Escape($currentTaskId)

    return [regex]::IsMatch($content, "^- Overall result:\s*passed\s*$", [System.Text.RegularExpressions.RegexOptions]::Multiline) `
        -and [regex]::IsMatch($content, "^- Current task:\s*$escapedTaskId\s*$", [System.Text.RegularExpressions.RegexOptions]::Multiline) `
        -and [regex]::IsMatch($content, "^\s*-\s*npm run build:\s*passed\s*$", [System.Text.RegularExpressions.RegexOptions]::Multiline) `
        -and [regex]::IsMatch($content, "^\s*-\s*npm run test:\s*passed\s*$", [System.Text.RegularExpressions.RegexOptions]::Multiline) `
        -and [regex]::IsMatch($content, "^\s*-\s*npm run lint:\s*passed\s*$", [System.Text.RegularExpressions.RegexOptions]::Multiline)
}

function Test-ReviewPromptReferencesCurrentTask {
    $reviewPromptPath = Join-Path $repoRoot ".ai-dev/review-prompt.md"
    $currentTaskId = Get-CurrentTaskId

    if (-not (Test-HasValue $currentTaskId)) {
        return $false
    }

    $escapedTaskId = [regex]::Escape($currentTaskId)
    return Test-TextFileContainsLine $reviewPromptPath "^\s*-\s*Task ID:\s*$escapedTaskId\s*$"
}

function Get-SavedDiffAppChangeFiles {
    $diffPath = Join-Path $repoRoot ".ai-dev/diff.md"

    if (-not (Test-Path -LiteralPath $diffPath -PathType Leaf)) {
        return @()
    }

    $content = Get-Content -Raw -Encoding UTF8 -LiteralPath $diffPath
    $startMarker = "## App Change Files"
    $startIndex = $content.IndexOf($startMarker, [System.StringComparison]::Ordinal)

    if ($startIndex -lt 0) {
        return @()
    }

    $sectionStart = $startIndex + $startMarker.Length
    $endIndex = $content.IndexOf("## ", $sectionStart, [System.StringComparison]::Ordinal)
    $section = if ($endIndex -lt 0) {
        $content.Substring($sectionStart)
    } else {
        $content.Substring($sectionStart, $endIndex - $sectionStart)
    }

    return @(
        $section -split "`r?`n" |
            ForEach-Object { $_.Trim() } |
            Where-Object { $_.StartsWith("- ") } |
            ForEach-Object { $_.Substring(2).Trim() } |
            Where-Object { (Test-HasValue $_) -and $_ -ne "없음" } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Select-Object -Unique
    )
}

function Test-PathSetsEqual {
    param(
        [string[]]$Left,
        [string[]]$Right
    )

    $leftSet = @($Left | ForEach-Object { ConvertTo-NormalizedChangedPath $_ } | Sort-Object -Unique)
    $rightSet = @($Right | ForEach-Object { ConvertTo-NormalizedChangedPath $_ } | Sort-Object -Unique)

    if ($leftSet.Count -ne $rightSet.Count) {
        return $false
    }

    for ($index = 0; $index -lt $leftSet.Count; $index++) {
        if (-not $leftSet[$index].Equals($rightSet[$index], [System.StringComparison]::OrdinalIgnoreCase)) {
            return $false
        }
    }

    return $true
}

function Test-SavedDiffMatchesCurrentChangedFiles {
    $changedFiles = @(Get-ChangedNonAiDevFiles)
    $savedDiffAppFiles = @(Get-SavedDiffAppChangeFiles)

    return Test-PathSetsEqual $changedFiles $savedDiffAppFiles
}

function Test-ReviewRequiredChangesEmpty {
    param(
        [object]$ReviewGate
    )

    $requiredChanges = if ($null -eq $ReviewGate.requiredChanges) { @() } else { @($ReviewGate.requiredChanges) }
    $requiredChangeFiles = if ($null -eq $ReviewGate.requiredChangeFiles) { @() } else { @($ReviewGate.requiredChangeFiles) }

    return $requiredChanges.Count -eq 0 -and $requiredChangeFiles.Count -eq 0
}

function Test-HasCurrentTaskImplementationCommit {
    $state = Read-JsonFile $statePath $stateRelativePath
    $stateCommitHash = $null
    $taskCommitHash = $null

    if (Test-HasValue $state.lastCommitHash) {
        $stateCommitHash = [string]$state.lastCommitHash
    }

    if ($null -ne $script:currentTask -and ($script:currentTask.PSObject.Properties.Name -contains "commitHash") -and (Test-HasValue $script:currentTask.commitHash)) {
        $taskCommitHash = [string]$script:currentTask.commitHash
    }

    if (-not (Test-HasValue $stateCommitHash) -or -not (Test-HasValue $taskCommitHash)) {
        return $false
    }

    if ($stateCommitHash -ne $taskCommitHash) {
        return $false
    }

    $headCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-parse HEAD"

    if ($stateCommitHash -ne $headCommitHash) {
        return $false
    }

    return (Test-CurrentValidationPassed) -and (Test-ReviewPromptReferencesCurrentTask)
}

function Set-CurrentTaskImplementationCommitHash {
    param(
        [Parameter(Mandatory = $true)]
        [string]$CommitHash
    )

    $currentTaskId = Get-CurrentTaskId

    if (-not (Test-HasValue $currentTaskId)) {
        throw "현재 task id가 없어 구현 커밋 메타데이터를 저장할 수 없습니다."
    }

    $queue = Read-JsonFile $queuePath $queueRelativePath
    $tasks = @($queue.tasks)
    $task = $tasks | Where-Object { $_.id -eq $currentTaskId } | Select-Object -First 1

    if ($null -eq $task) {
        throw "현재 task를 queue에서 찾을 수 없어 구현 커밋 메타데이터를 저장할 수 없습니다: $currentTaskId"
    }

    Set-ObjectProperty $task "commitHash" $CommitHash
    Set-ObjectProperty $queue "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
    Write-JsonFile $queuePath $queue

    if ($null -ne $script:currentTask -and $script:currentTask.id -eq $currentTaskId) {
        Set-ObjectProperty $script:currentTask "commitHash" $CommitHash
    }
}

function Get-RequiredReviewChangeFiles {
    param(
        [object]$ReviewResponse
    )

    if ($null -eq $ReviewResponse -or -not ($ReviewResponse.PSObject.Properties.Name -contains "required_changes")) {
        return @()
    }

    return @(
        @($ReviewResponse.required_changes) |
            Where-Object { $null -ne $_ -and ($_.PSObject.Properties.Name -contains "file") -and (Test-HasValue $_.file) } |
            ForEach-Object { ConvertTo-NormalizedChangedPath ([string]$_.file) } |
            Where-Object { (Test-HasValue $_) -and $_ -ne "unknown" -and -not (Test-IsAiDevOperationalPath $_) -and -not (Test-IsProtectedBaselineDirtyPath $_) } |
            Select-Object -Unique
    )
}

function Test-ReviewRequiredFileIsChanged {
    param(
        [string]$RequiredFile,
        [string[]]$ChangedFiles
    )

    foreach ($changedFile in @($ChangedFiles)) {
        if ($changedFile.Equals($RequiredFile, [System.StringComparison]::OrdinalIgnoreCase)) {
            return $true
        }
    }

    return $false
}

function Get-ReviewImplementationGate {
    param(
        [object]$CurrentTask,
        [object]$ReviewGate
    )

    $taskType = if ($null -ne $CurrentTask -and (Test-HasValue $CurrentTask.type)) { [string]$CurrentTask.type } else { "" }
    $requiredFiles = @($ReviewGate.requiredChangeFiles)
    $changedFiles = @(Get-ChangedNonAiDevFiles)
    $isVerificationReviseWithCodex = $taskType -eq "verification" -and $ReviewGate.decision -eq "revise" -and $ReviewGate.normalizedNextStep -eq "revise_with_codex"
    $missingRequiredFiles = @(
        $requiredFiles |
            Where-Object { -not (Test-ReviewRequiredFileIsChanged $_ $changedFiles) }
    )

    if ($ReviewGate.decision -eq "revise" -and $taskType -ne "implementation" -and -not $isVerificationReviseWithCodex) {
        return [PSCustomObject][ordered]@{
            passed = $false
            reason = "non_implementation_revise"
            message = "현재 task type이 implementation이 아닌데 review decision=revise입니다. 구현 없는 revise 반복을 성공 처리하지 않도록 중단합니다. taskType='$taskType', requiredFiles=$($requiredFiles -join ', '), changedFiles=$($changedFiles -join ', ')"
        }
    }

    if ($isVerificationReviseWithCodex) {
        return [PSCustomObject][ordered]@{
            passed = $true
            reason = "verification_revise_with_codex"
            message = "verification task의 revise + revise_with_codex는 구현 파일 변경이 없는 검증 산출물 보강 흐름일 수 있으므로 implementation 전용 required files 검사를 건너뜁니다. requiredFiles=$($requiredFiles -join ', '), changedFiles=$($changedFiles -join ', ')"
        }
    }

    $hasCodexResultContent = Test-HasCodexResultContent
    $hasCurrentTaskImplementationCommit = Test-HasCurrentTaskImplementationCommit

    if ($taskType -eq "implementation" -and $changedFiles.Count -eq 0 -and -not $hasCodexResultContent -and -not $hasCurrentTaskImplementationCommit) {
        return [PSCustomObject][ordered]@{
            passed = $false
            reason = "missing_implementation"
            message = "Codex 결과와 현재 diff에 구현 변경이 없고 현재 task 구현 커밋도 없어 missing_implementation으로 중단합니다. requiredFiles=$($requiredFiles -join ', ')"
            missingRequiredFiles = @($requiredFiles)
        }
    }

    if ($missingRequiredFiles.Count -gt 0 -or ($requiredFiles.Count -gt 0 -and $changedFiles.Count -eq 0)) {
        $missingFilesForMessage = if ($missingRequiredFiles.Count -gt 0) { @($missingRequiredFiles) } else { @($requiredFiles) }
        return [PSCustomObject][ordered]@{
            passed = $false
            reason = "stale_review_required_file_missing"
            message = "review-response.json이 요구한 구현 파일 변경이 현재 diff에 없습니다. stale review 또는 missing implementation으로 보고 완료 흐름을 차단합니다. missingRequiredFiles=$($missingFilesForMessage -join ', '), changedFiles=$($changedFiles -join ', ')"
            missingRequiredFiles = @($missingFilesForMessage)
        }
    }

    return [PSCustomObject][ordered]@{
        passed = $true
        reason = "ok"
        message = "review-response.json required_changes와 현재 diff 파일 목록이 일치합니다."
    }
}

function Get-CheckCommandSpec {
    param(
        [object]$CurrentTask
    )

    $taskType = if ($null -ne $CurrentTask -and (Test-HasValue $CurrentTask.type)) { [string]$CurrentTask.type } else { "" }
    $useBuildOnly = $taskType -in @("analysis", "documentation")
    $arguments = @()
    $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1"

    if ($useBuildOnly) {
        $arguments += "-BuildOnly"
        $command = "$command -BuildOnly"
    }

    return [PSCustomObject][ordered]@{
        command = $command
        arguments = $arguments
    }
}

function Get-ChangedAiDevOperationalFiles {
    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })

    return @(
        $changeLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Where-Object { (Test-HasValue $_) -and (Test-IsAiDevOperationalPath $_) -and -not (Test-IsProtectedBaselineDirtyPath $_) } |
            Select-Object -Unique
    )
}

function Get-ReviewGate {
    $state = Read-JsonFile $statePath $stateRelativePath
    $reviewResponse = $null
    $decision = $null
    $severity = $null
    $nextStep = $null
    $normalizedNextStep = $null
    $summary = $null
    $requiredChanges = @()
    $hasNextStep = $false

    if (Test-Path -LiteralPath $reviewResponsePath -PathType Leaf) {
        $reviewResponse = Read-JsonFile $reviewResponsePath $reviewResponseRelativePath

        if (Test-HasValue $reviewResponse.decision) {
            $decision = [string]$reviewResponse.decision
        }

        if (Test-HasValue $reviewResponse.severity) {
            $severity = [string]$reviewResponse.severity
        }

        if (Test-HasValue $reviewResponse.summary) {
            $summary = [string]$reviewResponse.summary
        }

        if ($reviewResponse.PSObject.Properties.Name -contains "next_step") {
            $hasNextStep = $true
            $nextStep = [string]$reviewResponse.next_step
            $normalizedNextStep = $nextStep.Trim().ToLowerInvariant().Replace("-", "_")
        }

        if ($reviewResponse.PSObject.Properties.Name -contains "required_changes") {
            $requiredChanges = @($reviewResponse.required_changes)
        }
    }

    return [PSCustomObject][ordered]@{
        lastCommand = [string]$state.lastCommand
        lastCommandStatus = [string]$state.lastCommandStatus
        stateDecision = [string]$state.lastReviewDecision
        decision = $decision
        severity = $severity
        summary = $summary
        hasNextStep = $hasNextStep
        nextStep = $nextStep
        normalizedNextStep = $normalizedNextStep
        requiredChanges = @($requiredChanges)
        requiredChangeFiles = @(Get-RequiredReviewChangeFiles $reviewResponse)
    }
}

function Test-IsAcceptableReviewNextStep {
    param(
        [object]$ReviewGate
    )

    return (-not $ReviewGate.hasNextStep) -or $ReviewGate.normalizedNextStep -eq "complete_task"
}

function Test-IsReviewReviseWithCodex {
    param(
        [object]$ReviewGate
    )

    return $ReviewGate.decision -eq "revise" -and $ReviewGate.normalizedNextStep -eq "revise_with_codex"
}

function New-ReviewReviseFailureMessage {
    param(
        [object]$ReviewGate,
        [string]$Prefix
    )

    $requiredChangesJson = @($ReviewGate.requiredChanges) | ConvertTo-Json -Depth 20
    return "$Prefix summary=$($ReviewGate.summary), severity=$($ReviewGate.severity), next_step=$($ReviewGate.nextStep), required_changes=$requiredChangesJson"
}

function Test-IsSavedReviewPassReady {
    param(
        [object]$ReviewGate
    )

    return $ReviewGate.lastCommand -eq "save-review" `
        -and $ReviewGate.lastCommandStatus -eq "passed" `
        -and $ReviewGate.decision -eq "pass" `
        -and $ReviewGate.severity -eq "none" `
        -and $ReviewGate.stateDecision -eq "pass" `
        -and (Test-IsAcceptableReviewNextStep $ReviewGate)
}

function Test-IsSavedReviewResumeReady {
    param(
        [object]$ReviewGate
    )

    if (-not (Test-IsSavedReviewPassReady $ReviewGate)) {
        return $false
    }

    if (-not (Test-ReviewRequiredChangesEmpty $ReviewGate)) {
        return $false
    }

    if (-not (Test-CurrentValidationPassed)) {
        return $false
    }

    if (-not (Test-ReviewPromptReferencesCurrentTask)) {
        return $false
    }

    $changedFiles = @(Get-ChangedNonAiDevFiles)

    if ($changedFiles.Count -gt 0) {
        return Test-SavedDiffMatchesCurrentChangedFiles
    }

    return Test-HasCurrentTaskImplementationCommit
}

function Get-CommitArguments {
    $arguments = @()

    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
        $normalizedFiles = @(
            $CommitFiles |
                ForEach-Object { $_ -split "," } |
                Where-Object { Test-HasValue $_ } |
                ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
                Where-Object { -not (Test-IsProtectedBaselineDirtyPath $_) }
        )

        if ($normalizedFiles.Count -gt 0) {
            $arguments += "-Files"
            $arguments += ($normalizedFiles -join ",")
        }

        return $arguments
    }

    $implementationFiles = Get-ChangedNonAiDevFiles

    if ($implementationFiles.Count -gt 0) {
        $arguments += "-Files"
        $arguments += ($implementationFiles -join ",")
    }

    return $arguments
}

function Invoke-DirectMetaCommit {
    param(
        [int]$StepNumber
    )

    $command = "direct meta commit: git add scoped .ai-dev files, git commit -m 'chore(ai-dev): record task completion', git status --short"

    try {
        $changedAiDevFiles = Get-ChangedAiDevOperationalFiles

        if ($changedAiDevFiles.Count -eq 0) {
            $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "git status --short"

            if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
                throw ".ai-dev 메타 변경사항은 없지만 worktree에 변경 파일이 남아 있습니다.`n$remainingStatus"
            }

            $script:steps += New-StepResult $StepNumber "meta-commit" $command $false $true 0 ".ai-dev 메타 상태 변경사항이 없어 meta commit을 건너뜁니다. worktree clean."
            return
        }

        $addOutput = & git add -- $changedAiDevFiles 2>&1 | Out-String
        $addExitCode = $LASTEXITCODE

        if ($addExitCode -ne 0) {
            throw "git add 실행에 실패했습니다. exit code: $addExitCode`n$addOutput"
        }

        $commitOutput = & git commit -m "chore(ai-dev): record task completion" -- $changedAiDevFiles 2>&1 | Out-String
        $commitExitCode = $LASTEXITCODE

        if ($commitExitCode -ne 0) {
            throw "git commit 실행에 실패했습니다. exit code: $commitExitCode`n$commitOutput"
        }

        $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "git status --short"

        if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
            throw "meta commit 이후 worktree에 변경 파일이 남아 있습니다.`n$remainingStatus"
        }

        $message = ($commitOutput.Trim(), "worktree clean") -join "`n"
        $script:steps += New-StepResult $StepNumber "meta-commit" $command $true $false 0 $message
    } catch {
        $script:steps += New-StepResult $StepNumber "meta-commit" $command $true $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "meta_commit_failed" $false 1
    }
}

function Get-CommitGate {
    param(
        [string]$PreviousHeadCommitHash
    )

    $state = Read-JsonFile $statePath $stateRelativePath
    $lastCommitHash = if (Test-HasValue $state.lastCommitHash) { [string]$state.lastCommitHash } else { $null }
    $headCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-parse HEAD"
    $commitHashChanged = (Test-HasValue $headCommitHash) -and $headCommitHash -ne $PreviousHeadCommitHash
    $commitHashMatchesHead = (Test-HasValue $lastCommitHash) -and $lastCommitHash -eq $headCommitHash

    if ($state.lastCommand -eq "commit" -and $state.lastCommandStatus -eq "passed" -and $commitHashChanged -and -not $commitHashMatchesHead) {
        Set-ObjectProperty $state "lastCommitHash" $headCommitHash
        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
        Write-JsonFile $statePath $state

        $lastCommitHash = $headCommitHash
        $commitHashMatchesHead = $true
    }

    return [PSCustomObject][ordered]@{
        lastCommand = [string]$state.lastCommand
        lastCommandStatus = [string]$state.lastCommandStatus
        lastCommitHash = [string]$lastCommitHash
        commitHashChanged = $commitHashChanged
        commitHashMatchesHead = $commitHashMatchesHead
    }
}

Set-Location $repoRoot

$script:steps = @()
$script:currentTask = $null
$script:completedTask = $null
$script:nextTask = $null
$script:completedTaskCount = 0
$script:protectedBaselineDirtyPaths = @(Get-ProtectedBaselineDirtyPaths)

if ($script:protectedBaselineDirtyPaths.Count -gt 0) {
    $script:steps += New-StepResult 0 "baseline-dirty-protection" "ProtectedBaselineDirtyPaths" $false $false 0 "Auto-goal baseline dirty paths are protected from implementation and .ai-dev meta commit eligibility: $($script:protectedBaselineDirtyPaths -join ', ')"
}

if ($MaxTasks -lt 1) {
    Stop-Cycle $script:steps "max_tasks_must_be_at_least_1" $false 1
}

if ($MaxSteps -lt 1) {
    Stop-Cycle $script:steps "max_steps_must_be_at_least_1" $false 1
}

try {
    foreach ($requiredPath in @($queuePath, $statePath)) {
        if (-not (Test-Path -LiteralPath $requiredPath -PathType Leaf)) {
            throw "필수 상태 파일이 없습니다: $requiredPath"
        }
    }

    $queue = Read-JsonFile $queuePath $queueRelativePath
    $state = Read-JsonFile $statePath $stateRelativePath

    if ($state.goalStatus -eq "completed") {
        Complete-Cycle $script:steps "goal_completed" 0
    }

    if (-not ($queue.PSObject.Properties.Name -contains "tasks") -or $null -eq $queue.tasks) {
        Stop-Cycle $script:steps "no_task" $false 0
    }

    $script:currentTask = Get-CurrentTask $queue $state

    if ($null -eq $script:currentTask) {
        Stop-Cycle $script:steps "no_task" $false 0
    }

    if ($script:currentTask.status -eq "done") {
        Complete-Cycle $script:steps "current_task_done" 0
    }

    $scriptPaths = @{
        makePrompt = Get-ScriptPath "ai-dev-make-prompt.ps1"
        makeRevisePrompt = Get-ScriptPath "ai-dev-make-revise-prompt.ps1"
        runCodex = Get-ScriptPath "ai-dev-run-codex.ps1"
        check = Get-ScriptPath "ai-dev-check.ps1"
        saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
        makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
        runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
        commit = Get-ScriptPath "ai-dev-commit.ps1"
        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
        status = Get-ScriptPath "ai-dev-status.ps1"
    }
} catch {
    $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Message
    Stop-Cycle $script:steps "prepare_failed" $false 1
}

$plannedSteps = @(
    "task-start",
    "make-prompt",
    "run-codex",
    "check",
    "save-diff",
    "make-review-prompt",
    "run-review-codex",
    "review-gate",
    "make-revise-prompt",
    "run-codex-revise",
    "check-revise",
    "save-diff-revise",
    "make-review-prompt-revise",
    "run-review-codex-revise",
    "review-gate",
    "package-change-gate",
    "commit",
    "commit-result-gate",
    "complete-task",
    "meta-commit",
    "final-status",
    "completed-clean-gate"
)

if ($plannedSteps.Count -gt $MaxSteps) {
    Stop-Cycle $script:steps "max_steps_too_small_for_full_cycle" $false 1
}

$stepNumber = 1

while ($script:completedTaskCount -lt $MaxTasks) {
    try {
        $queue = Read-JsonFile $queuePath $queueRelativePath
        $state = Read-JsonFile $statePath $stateRelativePath
        $script:currentTask = Get-CurrentTask $queue $state
    } catch {
        $script:steps += New-StepResult $stepNumber "load-task" "state/queue 확인" $false $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "load_task_failed" $false 1
    }

    if ($state.goalStatus -eq "completed") {
        Complete-Cycle $script:steps "goal_completed" $stepNumber
    }

    if ($null -eq $script:currentTask) {
        Stop-Cycle $script:steps "no_task" $false 0
    }

    if ($script:currentTask.status -eq "done") {
        Complete-Cycle $script:steps "current_task_done" $stepNumber
    }

    $taskLabel = "$($script:currentTask.id) $($script:currentTask.title)"
    $script:steps += New-StepResult $stepNumber "task-start" "MaxTasks=$MaxTasks" $false $false 0 "현재 task 실행 시작: $taskLabel"
    $stepNumber++

    $resumeFromSavedReview = $false

    if (-not $DryRun) {
        try {
            $resumeReviewGate = Get-ReviewGate
        } catch {
            $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 확인" $false $false 1 $_.Exception.Message
            Stop-Cycle $script:steps "resume_review_gate_failed" $false 1
        }

        if (Test-IsSavedReviewResumeReady $resumeReviewGate) {
            $resumeImplementationGate = Get-ReviewImplementationGate $script:currentTask $resumeReviewGate

            if (-not $resumeImplementationGate.passed) {
                Save-CycleFailureState "resume-review-gate" $resumeImplementationGate.message $resumeReviewGate ([string]$resumeImplementationGate.reason)
                $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response required_changes 및 현재 diff 확인" $false $true 1 $resumeImplementationGate.message
                Stop-Cycle $script:steps $resumeImplementationGate.reason $false 1
            }

            $resumeFromSavedReview = $true
            $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $false 0 "이미 저장된 리뷰 pass와 허용 가능한 next_step 상태를 확인했습니다. 구현/리뷰 재실행 없이 commit/complete/meta-commit으로 계속 진행합니다."
            $stepNumber++
        } elseif ($resumeReviewGate.lastCommand -eq "save-review" -and $resumeReviewGate.lastCommandStatus -eq "passed") {
            if (Test-IsReviewReviseWithCodex $resumeReviewGate) {
                $resumeFromSavedReview = $true
                $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $false 0 "저장된 리뷰가 revise + revise_with_codex이므로 구현/초기 리뷰 재실행 없이 revise 자동 재시도 단계로 계속 진행합니다."
                $stepNumber++
            } elseif ($resumeReviewGate.decision -eq "pass") {
                $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response current 조건 확인" $false $false 0 "저장된 리뷰 pass가 current 재개 조건을 충족하지 않아 구현/검증/리뷰 흐름을 다시 실행합니다."
                $stepNumber++
            } else {
                $message = "save-review 이후 계속 진행할 수 없습니다. review.decision=$($resumeReviewGate.decision), state.lastReviewDecision=$($resumeReviewGate.stateDecision), next_step=$($resumeReviewGate.nextStep)"
                Save-CycleFailureState "resume-review-gate" $message $resumeReviewGate
                $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $true 1 $message
                Stop-Cycle $script:steps "saved_review_not_ready_to_complete" $false 1
            }
        }
    }

    if (-not $resumeFromSavedReview) {
        Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
        $stepNumber++

        if (-not $AllowCodex -and -not $DryRun) {
            $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
            if ($AllowDirty) {
                $command = "$command -AllowDirty"
            }

            if ($AllowCommit) {
                $command = "$command -AllowCommit"
            }

            if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
                $command = "$command -CommitFiles $($CommitFiles -join ',')"
            }

            $script:steps += New-StepResult $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty" $false $true 1 "Codex 구현 실행에는 -AllowCodex가 필요합니다. 추천 명령: $command"
            Stop-Cycle $script:steps "allow_codex_required" $false 1
        }

        $runCodexArguments = @("-AllowDirty")

        Invoke-CycleCommand $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty" $scriptPaths.runCodex $runCodexArguments
        $stepNumber++

        $checkSpec = Get-CheckCommandSpec $script:currentTask
        $stepNumber = Invoke-CheckWithTestRecovery $stepNumber "check" $checkSpec.command $scriptPaths.check $checkSpec.arguments

        Invoke-CycleCommand $stepNumber "save-diff" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
        $stepNumber++

        Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
        $stepNumber++

        if (-not $AllowReviewCodex -and -not $DryRun) {
            $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
            if ($AllowDirty) {
                $command = "$command -AllowDirty"
            }

            if ($AllowCommit) {
                $command = "$command -AllowCommit"
            }

            if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
                $command = "$command -CommitFiles $($CommitFiles -join ',')"
            }

            $script:steps += New-StepResult $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 1 "Codex 리뷰 실행에는 -AllowReviewCodex가 필요합니다. 추천 명령: $command"
            Stop-Cycle $script:steps "allow_review_codex_required" $false 1
        }

        $stepNumber = Invoke-ReviewCodexWithJsonRecovery $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirty", "-SaveReview")
    }

    if ($DryRun) {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "make-revise-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1" $false $true 0 "DryRun: review-gate가 revise + revise_with_codex인 경우 생성할 revise 프롬프트를 실제로 만들지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "run-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $false $true 0 "DryRun: Codex 재수정 실행을 실행하지 않았습니다."
        $stepNumber++
        $checkSpec = Get-CheckCommandSpec $script:currentTask
        $script:steps += New-StepResult $stepNumber "check-revise" $checkSpec.command $false $true 0 "DryRun: 재수정 검증을 실행하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "save-diff-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $false $true 0 "DryRun: 재수정 diff 저장을 실행하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "make-review-prompt-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict" $false $true 0 "DryRun: 재리뷰 프롬프트 생성을 실행하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "run-review-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 0 "DryRun: Codex 재리뷰와 save-review를 실행하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료`" -CommitHash <commit-hash>" $false $true 0 "DryRun: task 완료 처리를 실행하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "meta-commit" "direct meta commit: git add scoped .ai-dev files, git commit -m 'chore(ai-dev): record task completion', git status --short" $false $true 0 "DryRun: .ai-dev 메타 상태 직접 커밋을 실행하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "final-status" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1" $false $true 0 "DryRun: 최종 작업 상태 확인을 실행하지 않았습니다."
        Stop-Cycle $script:steps "dry_run" $false 0
    }

    try {
        $reviewGate = Get-ReviewGate
    } catch {
        $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "review_gate_failed" $false 1
    }

    if ($reviewGate.lastCommand -ne "save-review" -or $reviewGate.lastCommandStatus -ne "passed") {
        $message = "최신 state가 save-review passed가 아니므로 자동 커밋하지 않습니다: lastCommand=$($reviewGate.lastCommand), lastCommandStatus=$($reviewGate.lastCommandStatus)"
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommand/state.lastCommandStatus 확인" $false $true 1 $message
        Stop-Cycle $script:steps "review_save_not_passed" $false 1
    }

    if (Test-IsReviewReviseWithCodex $reviewGate) {
        $implementationGate = Get-ReviewImplementationGate $script:currentTask $reviewGate

        if (-not $implementationGate.passed) {
            $recoveryResult = Invoke-RequiredFilesRecovery $stepNumber ([string]$implementationGate.reason) $reviewGate $implementationGate

            if ($recoveryResult.recovered) {
                $stepNumber = $recoveryResult.stepNumber
                $reviewGate = $recoveryResult.reviewGate
            } else {
                Save-CycleFailureState "review-gate" $implementationGate.message $reviewGate ([string]$implementationGate.reason)
                $script:steps += New-StepResult $stepNumber "review-gate" "task type, $reviewResponseRelativePath required_changes, 현재 diff 확인" $false $true 1 $implementationGate.message
                Stop-Cycle $script:steps $implementationGate.reason $false 1
            }
        }

        if (-not (Test-IsReviewReviseWithCodex $reviewGate)) {
            $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath decision/next_step 재확인" $false $false 0 "required files 복구 이후 리뷰 상태가 변경되어 일반 review-gate 흐름으로 계속 진행합니다. decision=$($reviewGate.decision), next_step=$($reviewGate.nextStep)"
            $stepNumber++
        } else {
            $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath decision/next_step 확인" $false $false 0 "리뷰 결과가 revise + revise_with_codex입니다. 자동 revise 재시도를 시작합니다. severity=$($reviewGate.severity), summary=$($reviewGate.summary)"
            $stepNumber++

            Invoke-CycleCommand $stepNumber "make-revise-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1" $scriptPaths.makeRevisePrompt @()
            $stepNumber++

            if (-not $AllowCodex) {
                $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
                if ($AllowDirty) {
                    $command = "$command -AllowDirty"
                }

                if ($AllowCommit) {
                    $command = "$command -AllowCommit"
                }

                if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
                    $command = "$command -CommitFiles $($CommitFiles -join ',')"
                }

                $script:steps += New-StepResult $stepNumber "run-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $false $true 1 "Codex 재수정 실행에는 -AllowCodex가 필요합니다. 추천 명령: $command"
                Stop-Cycle $script:steps "allow_codex_required" $false 1
            }

            Invoke-CycleCommand $stepNumber "run-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $scriptPaths.runCodex @("-AllowDirty", "-PromptPath", ".ai-dev/revise-prompt.md")
            $stepNumber++

            $checkSpec = Get-CheckCommandSpec $script:currentTask
            $stepNumber = Invoke-CheckWithTestRecovery $stepNumber "check-revise" $checkSpec.command $scriptPaths.check $checkSpec.arguments

            Invoke-CycleCommand $stepNumber "save-diff-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
            $stepNumber++

            Invoke-CycleCommand $stepNumber "make-review-prompt-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
            $stepNumber++

            if (-not $AllowReviewCodex) {
                $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
                if ($AllowDirty) {
                    $command = "$command -AllowDirty"
                }

                if ($AllowCommit) {
                    $command = "$command -AllowCommit"
                }

                if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
                    $command = "$command -CommitFiles $($CommitFiles -join ',')"
                }

                $script:steps += New-StepResult $stepNumber "run-review-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 1 "Codex 재리뷰 실행에는 -AllowReviewCodex가 필요합니다. 추천 명령: $command"
                Stop-Cycle $script:steps "allow_review_codex_required" $false 1
            }

            $stepNumber = Invoke-ReviewCodexWithJsonRecovery $stepNumber "run-review-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirty", "-SaveReview")
        }

        try {
            $reviewGate = Get-ReviewGate
        } catch {
            $script:steps += New-StepResult $stepNumber "review-gate" "재리뷰 state/review-response 확인" $false $false 1 $_.Exception.Message
            Stop-Cycle $script:steps "review_gate_failed" $false 1
        }

        if ($reviewGate.lastCommand -ne "save-review" -or $reviewGate.lastCommandStatus -ne "passed") {
            $message = "재리뷰 이후 최신 state가 save-review passed가 아니므로 자동 커밋하지 않습니다: lastCommand=$($reviewGate.lastCommand), lastCommandStatus=$($reviewGate.lastCommandStatus)"
            $script:steps += New-StepResult $stepNumber "review-gate" "재리뷰 state.lastCommand/state.lastCommandStatus 확인" $false $true 1 $message
            Stop-Cycle $script:steps "review_save_not_passed" $false 1
        }

        if ($reviewGate.decision -eq "revise") {
            if (Test-IsReviewReviseWithCodex $reviewGate) {
                $message = New-ReviewReviseFailureMessage $reviewGate "재리뷰도 revise + revise_with_codex를 반환해 자동 revise 재시도를 중단합니다."
                $recoveryGate = [PSCustomObject][ordered]@{
                    passed = $false
                    reason = "review_revise_repeated"
                    message = $message
                }
                $recoveryResult = Invoke-RequiredFilesRecovery $stepNumber "review_revise_repeated" $reviewGate $recoveryGate

                if ($recoveryResult.recovered) {
                    $stepNumber = $recoveryResult.stepNumber
                    $reviewGate = $recoveryResult.reviewGate
                } else {
                    Save-CycleFailureState "review-gate" $message $reviewGate "review_revise_repeated"
                    $script:steps += New-StepResult $stepNumber "review-gate" "재리뷰 decision/next_step/required_changes 확인" $false $true 1 $message
                    Stop-Cycle $script:steps "review_revise_repeated" $false 1
                }
            }

            if ($reviewGate.decision -eq "revise") {
                $message = New-ReviewReviseFailureMessage $reviewGate "재리뷰가 revise를 반환해 자동 커밋과 complete-task를 실행하지 않습니다."
                Save-CycleFailureState "review-gate" $message $reviewGate "revise_review_not_pass"
                $script:steps += New-StepResult $stepNumber "review-gate" "재리뷰 decision/next_step/required_changes 확인" $false $true 1 $message
                Stop-Cycle $script:steps "revise_review_not_pass" $false 1
            }
        }
    }

    if ($reviewGate.decision -ne "pass") {
        $message = "리뷰 response decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
        Save-CycleFailureState "review-gate" $message $reviewGate
        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath decision 확인" $false $true 1 $message
        Stop-Cycle $script:steps "review_not_pass" $false 1
    }

    if ($reviewGate.stateDecision -ne "pass") {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $true 1 "state.lastReviewDecision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.stateDecision)"
        Stop-Cycle $script:steps "state_review_not_pass" $false 1
    }

    if (-not (Test-IsAcceptableReviewNextStep $reviewGate)) {
        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_step 확인" $false $true 1 "리뷰 next_step이 존재하지만 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: 원본='$($reviewGate.nextStep)', 정규화='$($reviewGate.normalizedNextStep)'"
        Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 1
    }

    $implementationGate = Get-ReviewImplementationGate $script:currentTask $reviewGate

    if (-not $implementationGate.passed) {
        $recoveryResult = Invoke-RequiredFilesRecovery $stepNumber ([string]$implementationGate.reason) $reviewGate $implementationGate

        if ($recoveryResult.recovered) {
            $stepNumber = $recoveryResult.stepNumber
            $reviewGate = $recoveryResult.reviewGate
            $implementationGate = Get-ReviewImplementationGate $script:currentTask $reviewGate
        }

        if (-not $implementationGate.passed) {
            Save-CycleFailureState "review-gate" $implementationGate.message $reviewGate ([string]$implementationGate.reason)
            $script:steps += New-StepResult $stepNumber "review-gate" "task type, $reviewResponseRelativePath required_changes, 현재 diff 확인" $false $true 1 $implementationGate.message
            Stop-Cycle $script:steps $implementationGate.reason $false 1
        }
    }

    $script:steps += New-StepResult $stepNumber "review-gate" "최신 state 및 $reviewResponseRelativePath 재확인" $false $false 0 "리뷰 pass 및 허용 가능한 next_step 상태 수락: 존재=$($reviewGate.hasNextStep), 원본='$($reviewGate.nextStep)', 정규화='$($reviewGate.normalizedNextStep)'. commit/commit-result-gate/complete-task/meta-commit으로 계속 진행합니다."
    $stepNumber++

    try {
        $packageGate = Get-PackageChangeGate

        if (-not $packageGate.passed) {
            $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json package-lock.json" $false $true 1 $packageGate.message
            Stop-Cycle $script:steps "package_files_changed" $false 1
        }
    } catch {
        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json package-lock.json" $false $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "package_change_gate_failed" $false 1
    }

    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json package-lock.json" $false $false 0 $packageGate.message
    $stepNumber++

    if (-not $AllowCommit) {
        $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
        if ($AllowDirty) {
            $commitCommand = "$commitCommand -AllowDirty"
        }

        if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
            $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
        }

        $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
        Stop-Cycle $script:steps "allow_commit_required" $false 1
    }

    $commitArguments = Get-CommitArguments
    $commitHashForComplete = $null
    $resultSummary = "자동 완료: Codex 구현, build/check, Codex 리뷰 pass"

    if ($commitArguments.Count -eq 0) {
        $script:steps += New-StepResult $stepNumber "commit" "git status --porcelain" $false $true 0 "커밋할 구현 변경사항이 없습니다. 저장된 리뷰 pass 상태를 유지하고 complete-task/meta-commit으로 계속 진행합니다."
        $stepNumber++

        $stateBeforeComplete = Read-JsonFile $statePath $stateRelativePath

        try {
            $currentHeadCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-parse HEAD"
        } catch {
            $script:steps += New-StepResult $stepNumber "commit-result-gate" "git rev-parse HEAD" $false $false 1 $_.Exception.Message
            Stop-Cycle $script:steps "no_change_head_failed" $false 1
        }

        if (Test-HasValue $stateBeforeComplete.lastCommitHash) {
            $savedLastCommitHash = [string]$stateBeforeComplete.lastCommitHash

            if ($savedLastCommitHash -eq $currentHeadCommitHash -and (Test-HasCurrentTaskImplementationCommit)) {
                $commitHashForComplete = $savedLastCommitHash
                $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommitHash/current task commitHash 및 git rev-parse HEAD 확인" $false $true 0 "새 구현 커밋이 없습니다. state.lastCommitHash와 현재 task commitHash가 현재 HEAD와 일치하여 complete-task에 CommitHash를 전달합니다: $commitHashForComplete"
            } else {
                $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommitHash/current task commitHash 및 git rev-parse HEAD 확인" $false $true 0 "새 구현 커밋이 없습니다. stale 또는 다른 task의 state.lastCommitHash를 무시하고 CommitHash 없이 complete-task를 실행합니다. state.lastCommitHash=$savedLastCommitHash, currentHead=$currentHeadCommitHash"
            }
        } else {
            $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommitHash/current task commitHash 및 git rev-parse HEAD 확인" $false $true 0 "새 구현 커밋이 없습니다. state.lastCommitHash가 없어 CommitHash 없이 complete-task를 실행합니다. currentHead=$currentHeadCommitHash"
        }
        $stepNumber++

        $resultSummary = "$resultSummary, 구현 커밋 없음, 저장된 리뷰 pass에서 자동 완료"
    } else {
        $commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
        if ($commitArguments.Count -gt 0) {
            $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
        }

        try {
            $preCommitHeadCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-parse HEAD"
        } catch {
            $script:steps += New-StepResult $stepNumber "commit" "git rev-parse HEAD" $false $false 1 $_.Exception.Message
            Stop-Cycle $script:steps "pre_commit_head_failed" $false 1
        }

        Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
        $stepNumber++

        try {
            $commitGate = Get-CommitGate $preCommitHeadCommitHash
        } catch {
            $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHash 확인" $false $false 1 $_.Exception.Message
            Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
        }

        if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -not $commitGate.commitHashChanged -or -not $commitGate.commitHashMatchesHead) {
            $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastCommand), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCommitHash)"
            $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHash 확인" $false $true 1 $message
            Stop-Cycle $script:steps "commit_not_confirmed" $false 1
        }

        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHash 확인" $false $false 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
        $stepNumber++

        $commitHashForComplete = $commitGate.lastCommitHash
        Set-CurrentTaskImplementationCommitHash $commitHashForComplete
        $resultSummary = "$resultSummary, 자동 커밋 완료"
    }

    $completeTaskArguments = @("-ResultSummary", $resultSummary)
    $completeTaskCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"$resultSummary`""

    if (Test-HasValue $commitHashForComplete) {
        $completeTaskArguments += @("-CommitHash", $commitHashForComplete)
        $completeTaskCommand = "$completeTaskCommand -CommitHash $commitHashForComplete"
    }

    $completedTaskForContext = $script:currentTask

    Invoke-CycleCommand $stepNumber "complete-task" $completeTaskCommand $scriptPaths.completeTask $completeTaskArguments
    $stepNumber++

    Update-PostCompleteTaskContext $completedTaskForContext

    Invoke-DirectMetaCommit $stepNumber
    $stepNumber++

    Invoke-CycleCommand $stepNumber "final-status" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1" $scriptPaths.status @()
    $stepNumber++

    $queueAfterComplete = Read-JsonFile $queuePath $queueRelativePath
    $stateAfterComplete = Read-JsonFile $statePath $stateRelativePath

    if ($stateAfterComplete.goalStatus -eq "completed") {
        Complete-Cycle $script:steps "goal_completed" $stepNumber
    }
}

Complete-Cycle $script:steps "max_tasks_reached" $stepNumber
