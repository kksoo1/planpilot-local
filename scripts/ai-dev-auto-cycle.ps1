param(
    [int]$MaxSteps = 5,
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowCheck,
    [switch]$AllowSaveDiff,
    [switch]$AllowReviewPrompt
)

. "$PSScriptRoot\ai-dev-env.ps1"

function Write-CycleResult {
    param(
        [object]$Result
    )

    if ($Json) {
        $Result | ConvertTo-Json -Depth 20
        return
    }

    foreach ($step in $Result.steps) {
        Write-Host "Step $($step.step):"
        Write-Host "  Action: $($step.action)"
        Write-Host "  Executed: $($step.executed)"
        Write-Host "  Message: $($step.message)"
        Write-Host "  Recommended commands:"

        $stepCommands = @($step.recommendedCommands) | Where-Object {
            -not [string]::IsNullOrWhiteSpace([string]$_)
        }

        if ($stepCommands.Count -eq 0) {
            Write-Host "    - 없음"
        } else {
            foreach ($command in $stepCommands) {
                Write-Host "    - $command"
            }
        }
    }

    Write-Host "Stopped reason: $($Result.stoppedReason)"
    Write-Host "Completed: $($Result.completed)"
    Write-Host "Exit code: $($Result.exitCode)"

    if ($Result.stoppedReason -eq "goal_completed") {
        Write-Host "Summary: 목표 완료로 종료되었습니다. 더 실행할 task가 없습니다."
        Write-Host "Next: 다음 목표를 시작하려면 .ai-dev/goal.md, .ai-dev/queue.json, .ai-dev/state.json을 새 목표로 초기화하세요."
    }
}

function New-CycleResult {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    return [ordered]@{
        steps = @($Steps)
        stoppedReason = $StoppedReason
        completed = $Completed
        exitCode = $ExitCode
    }
}

function Test-HasValue {
    param([object]$Value)

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

    $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
    $json = $Value | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($Path, $json, $utf8WithBom)
}

function Save-CycleFailureState {
    param(
        [string]$Command,
        [string]$StoppedReason,
        [string]$Message,
        [string[]]$MissingRequiredFiles = @()
    )

    if ($DryRun) {
        return
    }

    try {
        $stateRelativePath = ".ai-dev/state.json"
        $statePath = Join-Path (Get-Location).Path $stateRelativePath
        $state = Read-JsonFile $statePath $stateRelativePath
        $errorParts = @("stoppedReason=$StoppedReason")

        if ($MissingRequiredFiles.Count -gt 0) {
            $errorParts += "missingRequiredFiles=$($MissingRequiredFiles -join ', ')"
        }

        if (Test-HasValue $Message) {
            $errorParts += $Message
        }

        Set-ObjectProperty $state "lastCommand" $Command
        Set-ObjectProperty $state "lastCommandStatus" "failed"
        Set-ObjectProperty $state "lastErrorSummary" ($errorParts -join "; ")
        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
        Write-JsonFile $statePath $state
    } catch {
        Write-Warning "상태 파일에 실패 사유를 기록하지 못했습니다: $($_.Exception.Message)"
    }
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
    return $normalizedRelativePath.StartsWith(".ai-dev/", [System.StringComparison]::OrdinalIgnoreCase)
}

function Get-ChangedNonAiDevFiles {
    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })

    return @(
        $changeLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Where-Object { (Test-HasValue $_) -and -not (Test-IsAiDevOperationalPath $_) } |
            Select-Object -Unique
    )
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
            Where-Object { (Test-HasValue $_) -and $_ -ne "unknown" -and -not (Test-IsAiDevOperationalPath $_) } |
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

function Test-IsNonImplementationReviseAction {
    param([string]$Action)

    if ($Action -ne "make_revise_prompt") {
        return $false
    }

    $queueRelativePath = ".ai-dev/queue.json"
    $stateRelativePath = ".ai-dev/state.json"
    $queue = Read-JsonFile (Join-Path (Get-Location).Path $queueRelativePath) $queueRelativePath
    $state = Read-JsonFile (Join-Path (Get-Location).Path $stateRelativePath) $stateRelativePath
    $currentTask = Get-CurrentTask $queue $state

    if ($null -eq $currentTask) {
        return $false
    }

    return [string]$currentTask.type -ne "implementation"
}

function Get-ReviewRequiredChangesGate {
    param(
        [switch]$OnlyWhenCurrentTaskIsImplementation
    )

    $queueRelativePath = ".ai-dev/queue.json"
    $stateRelativePath = ".ai-dev/state.json"
    $reviewResponseRelativePath = ".ai-dev/review-response.json"

    if ($OnlyWhenCurrentTaskIsImplementation) {
        $queue = Read-JsonFile (Join-Path (Get-Location).Path $queueRelativePath) $queueRelativePath
        $state = Read-JsonFile (Join-Path (Get-Location).Path $stateRelativePath) $stateRelativePath
        $currentTask = Get-CurrentTask $queue $state

        if ($null -eq $currentTask -or [string]$currentTask.type -ne "implementation") {
            return [PSCustomObject][ordered]@{
                passed = $true
                reason = "ok"
                message = ""
            }
        }
    }

    $reviewResponsePath = Join-Path (Get-Location).Path $reviewResponseRelativePath

    if (-not (Test-Path -LiteralPath $reviewResponsePath -PathType Leaf)) {
        return [PSCustomObject][ordered]@{
            passed = $true
            reason = "ok"
            message = ""
        }
    }

    $reviewResponse = Read-JsonFile $reviewResponsePath $reviewResponseRelativePath
    $requiredFiles = @(Get-RequiredReviewChangeFiles $reviewResponse)

    if ($requiredFiles.Count -eq 0) {
        return [PSCustomObject][ordered]@{
            passed = $true
            reason = "ok"
            message = ""
        }
    }

    $changedFiles = @(Get-ChangedNonAiDevFiles)
    $missingRequiredFiles = @(
        $requiredFiles |
            Where-Object { -not (Test-ReviewRequiredFileIsChanged $_ $changedFiles) }
    )

    if ($requiredFiles.Count -gt 0 -and $changedFiles.Count -eq 0) {
        return [PSCustomObject][ordered]@{
            passed = $false
            reason = "missing_implementation"
            message = "review-response.json이 구현 파일 변경을 요구했지만 현재 non-.ai-dev diff에 구현 변경 파일이 없습니다. missingRequiredFiles=$($requiredFiles -join ', ')"
            missingRequiredFiles = @($requiredFiles)
        }
    }

    if ($missingRequiredFiles.Count -gt 0) {
        return [PSCustomObject][ordered]@{
            passed = $false
            reason = "stale_review_required_file_missing"
            message = "review-response.json이 요구한 구현 파일 변경이 현재 non-.ai-dev diff에 없습니다. missingRequiredFiles=$($missingRequiredFiles -join ', '), changedFiles=$($changedFiles -join ', ')"
            missingRequiredFiles = @($missingRequiredFiles)
        }
    }

    return [PSCustomObject][ordered]@{
        passed = $true
        reason = "ok"
        message = ""
    }
}

function Test-IsAlreadyCompletedGoalState {
    $stateRelativePath = ".ai-dev/state.json"
    $statePath = Join-Path (Get-Location).Path $stateRelativePath

    if (-not (Test-Path -LiteralPath $statePath -PathType Leaf)) {
        return $false
    }

    $state = Read-JsonFile $statePath $stateRelativePath

    return (
        [string]$state.goalStatus -eq "completed" -and
        -not (Test-HasValue $state.currentTaskId) -and
        [string]$state.lastCommand -eq "complete-task" -and
        [string]$state.lastCommandStatus -eq "passed" -and
        (Test-HasValue $state.lastCommitHash)
    )
}

if ($MaxSteps -lt 1) {
    $result = New-CycleResult @() "max_steps_must_be_at_least_1" $false 1
    Write-CycleResult $result
    exit 1
}

$userInterventionActions = @(
    "run_codex_or_cline",
    "ask_gpt_review",
    "make_revise_prompt",
    "commit",
    "complete_task",
    "stop_for_user",
    "blocked",
    "inspect_status"
)
$terminalActions = @(
    "goal_completed",
    "no_task"
)
$steps = @()
$previousAction = $null
$autoStepPath = Join-Path $PSScriptRoot "ai-dev-auto-step.ps1"

if (-not (Test-Path -LiteralPath $autoStepPath -PathType Leaf)) {
    $result = New-CycleResult @() "auto_step_script_not_found" $false 1
    Write-CycleResult $result
    exit 1
}

for ($index = 1; $index -le $MaxSteps; $index++) {
    $arguments = @("-Json")

    if ($DryRun) {
        $arguments += "-DryRun"
    }

    if ($AllowCheck) {
        $arguments += "-AllowCheck"
    }

    if ($AllowSaveDiff) {
        $arguments += "-AllowSaveDiff"
    }

    if ($AllowReviewPrompt) {
        $arguments += "-AllowReviewPrompt"
    }

    $autoStepOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File $autoStepPath @arguments 2>&1 | Out-String
    $autoStepExitCode = $LASTEXITCODE

    if ($autoStepExitCode -ne 0) {
        $step = [ordered]@{
            step = $index
            action = "auto_step_failed"
            executed = $false
            exitCode = $autoStepExitCode
            message = $autoStepOutput.Trim()
        }
        $steps += [PSCustomObject]$step
        $result = New-CycleResult $steps "auto_step_failed" $false 1
        Write-CycleResult $result
        exit 1
    }

    try {
        $autoStep = $autoStepOutput | ConvertFrom-Json
    } catch {
        $step = [ordered]@{
            step = $index
            action = "auto_step_json_parse_failed"
            executed = $false
            exitCode = 1
            message = $_.Exception.Message
        }
        $steps += [PSCustomObject]$step
        $result = New-CycleResult $steps "auto_step_json_parse_failed" $false 1
        Write-CycleResult $result
        exit 1
    }

    $action = [string]$autoStep.action
    $recommendedCommands = @()

    if ($null -ne $autoStep.recommendedCommands) {
        foreach ($command in @($autoStep.recommendedCommands)) {
            if (-not [string]::IsNullOrWhiteSpace([string]$command)) {
                $recommendedCommands += [string]$command
            }
        }
    }

    $stepResult = [ordered]@{
        step = $index
        action = $action
        executed = [bool]$autoStep.executed
        exitCode = [int]$autoStep.exitCode
        message = [string]$autoStep.message
        recommendedCommands = @($recommendedCommands)
    }
    $steps += [PSCustomObject]$stepResult

    try {
        if (Test-IsNonImplementationReviseAction $action) {
            Save-CycleFailureState "non_implementation_revise" "non_implementation_revise" ([string]$autoStep.message)
            $result = New-CycleResult $steps "non_implementation_revise" $false 1
            Write-CycleResult $result
            exit 1
        }

        $reviewRequiredChangesGate = $null

        if ($action -eq "make_revise_prompt") {
            $reviewRequiredChangesGate = Get-ReviewRequiredChangesGate -OnlyWhenCurrentTaskIsImplementation
        } elseif (@("commit", "complete_task", "complete-task") -contains $action) {
            $reviewRequiredChangesGate = Get-ReviewRequiredChangesGate
        }

        if ($null -ne $reviewRequiredChangesGate -and -not $reviewRequiredChangesGate.passed) {
            $step = [ordered]@{
                step = $index
                action = "review_required_changes_gate"
                executed = $false
                exitCode = 1
                message = $reviewRequiredChangesGate.message
                recommendedCommands = @()
            }
            $steps += [PSCustomObject]$step
            Save-CycleFailureState "review_required_changes_gate" ([string]$reviewRequiredChangesGate.reason) ([string]$reviewRequiredChangesGate.message) @($reviewRequiredChangesGate.missingRequiredFiles)
            $result = New-CycleResult $steps $reviewRequiredChangesGate.reason $false 1
            Write-CycleResult $result
            exit 1
        }
    } catch {
        $step = [ordered]@{
            step = $index
            action = "revise_gate_failed"
            executed = $false
            exitCode = 1
            message = $_.Exception.Message
        }
        $steps += [PSCustomObject]$step
        Save-CycleFailureState "review_required_changes_gate" "revise_gate_failed" $_.Exception.Message
        $result = New-CycleResult $steps "revise_gate_failed" $false 1
        Write-CycleResult $result
        exit 1
    }

    if ($terminalActions -contains $action) {
        try {
            $shouldRunTerminalReviewRequiredChangesGate = -not (
                $action -eq "goal_completed" -and (Test-IsAlreadyCompletedGoalState)
            )

            if ($shouldRunTerminalReviewRequiredChangesGate) {
                $terminalReviewRequiredChangesGate = Get-ReviewRequiredChangesGate

                if (-not $terminalReviewRequiredChangesGate.passed) {
                    $step = [ordered]@{
                        step = $index
                        action = "terminal_review_required_changes_gate"
                        executed = $false
                        exitCode = 1
                        message = $terminalReviewRequiredChangesGate.message
                        recommendedCommands = @()
                    }
                    $steps += [PSCustomObject]$step
                    Save-CycleFailureState "terminal_review_required_changes_gate" ([string]$terminalReviewRequiredChangesGate.reason) ([string]$terminalReviewRequiredChangesGate.message) @($terminalReviewRequiredChangesGate.missingRequiredFiles)
                    $result = New-CycleResult $steps $terminalReviewRequiredChangesGate.reason $false 1
                    Write-CycleResult $result
                    exit 1
                }
            }
        } catch {
            $step = [ordered]@{
                step = $index
                action = "terminal_review_required_changes_gate_failed"
                executed = $false
                exitCode = 1
                message = $_.Exception.Message
            }
            $steps += [PSCustomObject]$step
            Save-CycleFailureState "terminal_review_required_changes_gate" "terminal_review_required_changes_gate_failed" $_.Exception.Message
            $result = New-CycleResult $steps "terminal_review_required_changes_gate_failed" $false 1
            Write-CycleResult $result
            exit 1
        }

        $completed = $action -eq "goal_completed"
        $result = New-CycleResult $steps $action $completed 0
        Write-CycleResult $result
        exit 0
    }

    if ($userInterventionActions -contains $action) {
        $result = New-CycleResult $steps "user_intervention_required:$action" $false 0
        Write-CycleResult $result
        exit 0
    }

    if (-not [bool]$autoStep.executed) {
        $result = New-CycleResult $steps "no_automatic_work_remaining:$action" $false 0
        Write-CycleResult $result
        exit 0
    }

    if ($null -ne $previousAction -and $previousAction -eq $action) {
        $result = New-CycleResult $steps "repeated_action_without_progress:$action" $false 0
        Write-CycleResult $result
        exit 0
    }

    $previousAction = $action
}

$finalResult = New-CycleResult $steps "max_steps_reached" $false 0
Write-CycleResult $finalResult
exit 0
