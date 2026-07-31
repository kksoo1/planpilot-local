param(
    [AllowEmptyString()]
    [string]$GoalTitle,
    [AllowEmptyString()]
    [string]$GoalDescription,
    [int]$MaxTasks = 1,
    [int]$MaxSteps = 40,
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowRun,
    [switch]$AllowCodex,
    [switch]$AllowReviewCodex,
    [switch]$AllowCommit,
    [switch]$AllowDirty,
    [string[]]$CommitFiles,
    [string]$ResultPath = ".ai-dev/codex-result.md"
)

. "$PSScriptRoot\ai-dev-env.ps1"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
$codeFence = '```'
$goalRelativePath = ".ai-dev/goal.md"
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$promptRelativePath = ".ai-dev/current-task-prompt.md"
$planningPromptRelativePath = ".ai-dev/auto-goal-planning-prompt.md"
$legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"
$aiDevOperationalRoot = ".ai-dev/"
$script:autoGoalCanWriteResultFile = $true
$script:autoGoalCanCleanTempArtifacts = $true
$script:autoGoalOperationalFileSnapshots = @{}

function Resolve-RepoPath {
    param([string]$Path)

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return $Path
    }

    return Join-Path $repoRoot $Path
}

function ConvertTo-RepoRelativePath {
    param([string]$Path)

    $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $Path))
    $rootWithSeparator = $repoRoot.TrimEnd("\") + "\"

    if ($fullPath.StartsWith($rootWithSeparator, [System.StringComparison]::OrdinalIgnoreCase)) {
        return $fullPath.Substring($rootWithSeparator.Length).Replace("\", "/")
    }

    return $fullPath.Replace("\", "/")
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

function New-AutoGoalResult {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    $outcomeCategory = if (Test-IsExpectedPreImplementationStop $StoppedReason) {
        "expected_non_work"
    } elseif ($ExitCode -eq 0) {
        "success"
    } else {
        "actual_failure"
    }

    return [PSCustomObject][ordered]@{
        steps = @($Steps)
        stoppedReason = $StoppedReason
        outcomeCategory = $outcomeCategory
        completed = $Completed
        exitCode = $ExitCode
        plan = $script:autoGoalPlanPreview
        goalPath = $goalRelativePath
        queuePath = $queueRelativePath
        statePath = $stateRelativePath
        promptPath = $promptRelativePath
        resultPath = (ConvertTo-RepoRelativePath $ResultPath)
    }
}

function Write-AutoGoalResult {
    param([object]$Result)

    if ($Json) {
        $Result | ConvertTo-Json -Depth 30
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

    if ($null -ne $Result.plan) {
        Write-Host "Plan preview:"
        Write-Host "  Goal title: $($Result.plan.queue.goalTitle)"
        Write-Host "  Current task id: $($Result.plan.queue.currentTaskId)"

        foreach ($task in @($Result.plan.queue.tasks)) {
            Write-Host "  Task $($task.id): $($task.title)"
            Write-Host "    Type: $($task.type)"
            Write-Host "    Status: $($task.status)"
            Write-Host "    Priority: $($task.priority)"
            Write-Host "    Likely files: $((@($task.filesLikelyToChange) -join ', '))"
            Write-Host "    Verification: $((@($task.verification) -join ' / '))"
        }
    }

    Write-Host "Stopped reason: $($Result.stoppedReason)"
    Write-Host "Outcome category: $($Result.outcomeCategory)"
    Write-Host "Completed: $($Result.completed)"
    Write-Host "Exit code: $($Result.exitCode)"
}

function Save-AutoGoalResultFile {
    param(
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    $result = New-AutoGoalResult $script:steps $StoppedReason $Completed $ExitCode
    $stepLines = @()

    foreach ($step in @($result.steps)) {
        $stepLines += "- Step $($step.step) $($step.name): exitCode=$($step.exitCode), executed=$($step.executed), skipped=$($step.skipped)"
        if (Test-HasValue $step.message) {
            $stepLines += "  - Message: $($step.message)"
        }
    }

    $content = @"
# Codex Auto Goal Final Result

## Summary

- Stopped reason: $($result.stoppedReason)
- Outcome category: $($result.outcomeCategory)
- Completed: $($result.completed)
- Exit code: $($result.exitCode)
- Result path: $($result.resultPath)

## Steps

$($stepLines -join "`r`n")
"@

    [System.IO.File]::WriteAllText($resolvedResultPath, $content, $utf8WithBom)
}

function Invoke-AutoGoalExpectedNonWorkMetaCommit {
    param([int]$StepNumber)

    if ($DryRun) {
        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git add/commit expected non-work result" $false $true 0 "DryRun: expected non-work result meta commit was not executed."
    }

    if (-not $AllowCommit) {
        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git add/commit expected non-work result" $false $true 0 "AllowCommit is not set, so expected non-work result remains an uncommitted meta record."
    }

    $resultRelativePath = ConvertTo-NormalizedChangedPath (ConvertTo-RepoRelativePath $ResultPath)

    if (@($script:autoGoalBaselineDirtyPaths) -contains $resultRelativePath) {
        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git add/commit expected non-work result" $false $true 0 "Expected non-work result meta commit skipped because ResultPath was baseline dirty and protected: $resultRelativePath"
    }

    $statusOutput = & git status --short -- $resultRelativePath 2>&1 | Out-String
    $statusExitCode = $LASTEXITCODE

    if ($statusExitCode -ne 0) {
        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git status --short -- <result file>" $true $false 1 "git status for expected non-work result failed. exit code: $statusExitCode`n$statusOutput"
    }

    if (-not (Test-HasValue $statusOutput)) {
        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git status --short -- <result file>" $true $false 0 "Expected non-work result file had no changes to commit."
    }

    $addOutput = & git add -- $resultRelativePath 2>&1 | Out-String
    $addExitCode = $LASTEXITCODE

    if ($addExitCode -ne 0) {
        & git restore --staged -- $resultRelativePath 2>&1 | Out-String | Out-Null
        $restoredPaths = @(Restore-AutoGoalCurrentRunOperationalChanges @($resultRelativePath))
        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git add -- <result file>" $true $false 1 "Expected non-work result git add failed. exit code: $addExitCode`n$addOutput`nRestored run-owned files: $($restoredPaths -join ', ')"
    }

    $commitOutput = & git commit -m "chore(ai-dev): record expected non-work stop" -- $resultRelativePath 2>&1 | Out-String
    $commitExitCode = $LASTEXITCODE

    if ($commitExitCode -ne 0) {
        & git restore --staged -- $resultRelativePath 2>&1 | Out-String | Out-Null
        $restoredPaths = @(Restore-AutoGoalCurrentRunOperationalChanges @($resultRelativePath))
        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git commit -- <result file>" $true $false 1 "Expected non-work result commit failed. exit code: $commitExitCode`n$commitOutput`nRestored run-owned files: $($restoredPaths -join ', ')"
    }

    return New-StepResult $StepNumber "expected-non-work-meta-commit" "git add/commit expected non-work result" $true $false 0 $commitOutput.Trim()
}

function Clear-AutoGoalTempArtifacts {
    if (-not $script:autoGoalCanCleanTempArtifacts) {
        return
    }

    $currentResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ResultPath))

    foreach ($relativePath in @($planningPromptRelativePath, $legacyAutoGoalResultRelativePath)) {
        $normalizedRelativePath = ConvertTo-NormalizedChangedPath (ConvertTo-RepoRelativePath $relativePath)

        if (@($script:autoGoalBaselineDirtyPaths) -contains $normalizedRelativePath) {
            continue
        }

        $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $relativePath))

        if (-not $fullPath.StartsWith($repoRoot.TrimEnd("\") + "\", [System.StringComparison]::OrdinalIgnoreCase)) {
            continue
        }

        if ($fullPath.Equals($currentResultPath, [System.StringComparison]::OrdinalIgnoreCase)) {
            continue
        }

        try {
            if ([System.IO.File]::Exists($fullPath)) {
                [System.IO.File]::Delete($fullPath)
            }
        } catch {
            Write-Warning "Failed to clean auto-goal temp artifact: $relativePath"
        }
    }
}

function Test-IsExpectedPreImplementationStop {
    param([string]$StoppedReason)

    return @(
        "baseline_output_conflict",
        "dirty_worktree",
        "max_steps_too_small_for_full_cycle"
    ) -contains $StoppedReason
}

function Initialize-AutoGoalOperationalFileSnapshots {
    $script:autoGoalOperationalFileSnapshots = @{}

    foreach ($relativePath in @(Get-PlannedAutoGoalOutputPaths)) {
        $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $relativePath))

        if (-not $fullPath.StartsWith($repoRoot.TrimEnd("\") + "\", [System.StringComparison]::OrdinalIgnoreCase)) {
            continue
        }

        $exists = [System.IO.File]::Exists($fullPath)
        $bytes = $null

        if ($exists) {
            $bytes = [System.IO.File]::ReadAllBytes($fullPath)
        }

        $script:autoGoalOperationalFileSnapshots[$relativePath] = [PSCustomObject][ordered]@{
            path = $fullPath
            existed = $exists
            bytes = $bytes
        }
    }
}

function Restore-AutoGoalCurrentRunOperationalChanges {
    param([string[]]$RelativePaths = @())

    $restoredPaths = @()

    if ($null -eq $script:autoGoalOperationalFileSnapshots) {
        return @($restoredPaths)
    }

    $targetPaths = @($RelativePaths | ForEach-Object { ConvertTo-NormalizedChangedPath $_ } | Where-Object { Test-HasValue $_ } | Select-Object -Unique)
    $baselineDirtyPaths = @($script:autoGoalBaselineDirtyPaths)

    foreach ($entry in @($script:autoGoalOperationalFileSnapshots.GetEnumerator())) {
        $relativePath = ConvertTo-NormalizedChangedPath ([string]$entry.Key)
        $snapshot = $entry.Value

        if ($targetPaths.Count -gt 0 -and $targetPaths -notcontains $relativePath) {
            continue
        }

        if ($baselineDirtyPaths -contains $relativePath) {
            continue
        }

        $fullPath = [string]$snapshot.path

        if (-not $fullPath.StartsWith($repoRoot.TrimEnd("\") + "\", [System.StringComparison]::OrdinalIgnoreCase)) {
            continue
        }

        try {
            if ($snapshot.existed) {
                [System.IO.File]::WriteAllBytes($fullPath, [byte[]]$snapshot.bytes)
            } elseif ([System.IO.File]::Exists($fullPath)) {
                [System.IO.File]::Delete($fullPath)
            }
            $restoredPaths += $relativePath
        } catch {
            Write-Warning "Failed to restore auto-goal operational file snapshot: $fullPath"
        }
    }

    return @($restoredPaths | Select-Object -Unique)
}

function Test-CanWriteExpectedNonWorkResultFile {
    $resultRelativePath = ConvertTo-NormalizedChangedPath (ConvertTo-RepoRelativePath $ResultPath)
    $snapshot = $script:autoGoalOperationalFileSnapshots[$resultRelativePath]
    $baselineDirtyPaths = @($script:autoGoalBaselineDirtyPaths)

    if ($null -ne $snapshot -and $snapshot.existed -and $baselineDirtyPaths -contains $resultRelativePath) {
        return $false
    }

    return $true
}

function Stop-AutoGoal {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    $isExpectedPreImplementationStop = Test-IsExpectedPreImplementationStop $StoppedReason

    if (-not $DryRun) {
        Clear-AutoGoalTempArtifacts

        if ($isExpectedPreImplementationStop) {
            $cleanedRunOwnedPaths = @(Restore-AutoGoalCurrentRunOperationalChanges)
            $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-cleanup" "restore current-run .ai-dev operational file snapshots" $true $false 0 "Expected pre-implementation stop. Restored only auto-goal operational files captured at run start; baseline user changes were preserved. Cleaned run-owned files: $($cleanedRunOwnedPaths -join ', ')"
        }
    }

    $script:steps = @($Steps)

    if (-not $DryRun -and (-not $Completed -or $ExitCode -ne 0)) {
        if ($script:autoGoalCanWriteResultFile) {
            if ($isExpectedPreImplementationStop) {
                if ($AllowCommit) {
                    if (Test-CanWriteExpectedNonWorkResultFile) {
                        $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-meta-record" "write expected non-work final result" $true $false 0 "Expected pre-implementation stop is recorded as outcomeCategory=expected_non_work in the final result file because -AllowCommit is set."
                        $script:steps = @($Steps)
                        Save-AutoGoalResultFile $StoppedReason $false $ExitCode
                        $metaCommitStep = Invoke-AutoGoalExpectedNonWorkMetaCommit ($Steps.Count + 1)
                        $Steps += $metaCommitStep
                        $script:steps = @($Steps)

                        if ($metaCommitStep.exitCode -ne 0) {
                            $originalStoppedReason = $StoppedReason
                            $StoppedReason = "expected_non_work_meta_commit_failed"
                            $isExpectedPreImplementationStop = $false
                            $Completed = $false
                            $ExitCode = 1
                            $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-meta-failure" "classify expected non-work meta commit failure" $true $false 1 "Expected pre-implementation stop meta commit failed and is reclassified as actual_failure. Original stopped reason: $originalStoppedReason"
                            $script:steps = @($Steps)
                        }
                    } else {
                        $resultRelativePath = ConvertTo-NormalizedChangedPath (ConvertTo-RepoRelativePath $ResultPath)
                        $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-meta-record" "write expected non-work final result" $false $true 0 "Expected pre-implementation stop is reported in console output only. ResultPath existed at run start and was baseline dirty, so auto-goal did not overwrite preserved user changes: $resultRelativePath"
                        $script:steps = @($Steps)
                    }
                } else {
                    $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-meta-record" "write expected non-work final result" $false $true 0 "Expected pre-implementation stop is reported in console output only. -AllowCommit is not set, so no result file or other .ai-dev operational change is left behind."
                    $script:steps = @($Steps)
                }
            } else {
                Save-AutoGoalResultFile $StoppedReason $false $ExitCode
            }
        }
    }
    Write-AutoGoalResult (New-AutoGoalResult $Steps $StoppedReason $Completed $ExitCode)
    exit $ExitCode
}

function Get-StoppedReasonFromOutput {
    param([string]$Output)

    if (-not (Test-HasValue $Output)) {
        return ""
    }

    if ($Output -match '(?m)^\s*Stopped reason:\s*(\S+)\s*$') {
        return $Matches[1]
    }

    return ""
}

function Get-InputPreview {
    param([string]$RawInput)

    if ($null -eq $RawInput) {
        return "<null>"
    }

    $normalized = $RawInput.Replace("`r", " ").Replace("`n", " ").Trim()

    if ($normalized.Length -eq 0) {
        return "<empty>"
    }

    if ($normalized.Length -le 500) {
        return $normalized
    }

    return $normalized.Substring(0, 500)
}

function Invoke-GitStatusLines {
    param(
        [string[]]$Arguments,
        [string]$CommandText,
        [int]$FailureStep = 2,
        [string]$FailureName = "dirty-worktree-gate"
    )

    $statusOutput = & git @Arguments 2>&1

    if ($LASTEXITCODE -ne 0) {
        $script:steps += New-StepResult $FailureStep $FailureName $CommandText $false $false 1 "git status failed: $($statusOutput -join "`n")"
        Stop-AutoGoal $script:steps "git_status_failed" $false 1
    }

    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
}

function Get-GitStatusLines {
    param(
        [int]$FailureStep = 2,
        [string]$FailureName = "dirty-worktree-gate"
    )

    return @(Invoke-GitStatusLines -Arguments @("status", "--short") -CommandText "git status --short" -FailureStep $FailureStep -FailureName $FailureName)
}

function Get-GitPorcelainStatusLines {
    param(
        [int]$FailureStep = 2,
        [string]$FailureName = "dirty-worktree-gate"
    )

    return @(Invoke-GitStatusLines -Arguments @("status", "--porcelain") -CommandText "git status --porcelain" -FailureStep $FailureStep -FailureName $FailureName)
}

function Convert-ToChangedPath {
    param([string]$ChangeLine)

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
    param([string]$RelativePath)

    if (-not (Test-HasValue $RelativePath)) {
        return $null
    }

    return $RelativePath.Trim().Trim('"').Replace('\', '/')
}

function Test-IsAiDevOperationalPath {
    param([string]$RelativePath)

    $normalizedRelativePath = ConvertTo-NormalizedChangedPath $RelativePath
    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::OrdinalIgnoreCase)
}

function Get-PlannedAutoGoalOutputPaths {
    return @(
        $ResultPath,
        $goalRelativePath,
        $queueRelativePath,
        $stateRelativePath,
        $promptRelativePath,
        $planningPromptRelativePath,
        ".ai-dev/codex-result.md",
        $legacyAutoGoalResultRelativePath
    ) |
        Where-Object { Test-HasValue $_ } |
        ForEach-Object { ConvertTo-NormalizedChangedPath (ConvertTo-RepoRelativePath $_) } |
        Select-Object -Unique
}

function Invoke-BaselineOutputConflictGate {
    param(
        [string[]]$BaselineDirtyPaths,
        [string[]]$PlannedOutputPaths
    )

    $conflictingPaths = @(
        $BaselineDirtyPaths |
            Where-Object { $PlannedOutputPaths -contains $_ } |
            Select-Object -Unique
    )

    if ($conflictingPaths.Count -eq 0) {
        return
    }

    $script:autoGoalCanWriteResultFile = $false
    $script:autoGoalCanCleanTempArtifacts = $false
    $message = "Baseline dirty paths conflict with planned auto-goal output paths. Auto-goal stopped before writing or deleting protected output files.`nConflicting paths:`n$($conflictingPaths -join "`n")"
    $script:steps += New-StepResult 2 "baseline-output-conflict-gate" "compare baseline dirty paths with planned auto-goal outputs" $true $false 1 $message
    Stop-AutoGoal $script:steps "baseline_output_conflict" $false 1
}

function Invoke-FinalAutoGoalChangeGate {
    param(
        [int]$StepNumber
    )

    Clear-AutoGoalTempArtifacts

    $statusLines = @(Get-GitStatusLines $StepNumber "final-change-gate")
    $command = "cleanup auto-goal temp artifacts, git status --short"
    $baselineDirtyPaths = @($script:autoGoalBaselineDirtyPaths)
    $baselineDirtyCount = $baselineDirtyPaths.Count
    $finalDirtyCount = $statusLines.Count

    if ($statusLines.Count -eq 0 -and $baselineDirtyCount -gt 0) {
        $message = "Final clean verification failed: baseline dirty paths from auto-goal start are no longer visible in git status. They may have been committed or otherwise swallowed, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (baseline dirty disappeared).`nBaseline dirty paths:`n$($baselineDirtyPaths -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
        Stop-AutoGoal $script:steps "final_baseline_dirty_disappeared" $false 1
    }

    if ($statusLines.Count -eq 0) {
        $message = "Baseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (no final changes).`nFinal clean verification: git status --short returned no changes."
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 0 $message
        return
    }

    $changedPaths = @(
        $statusLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            Where-Object { Test-HasValue $_ } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Select-Object -Unique
    )
    $baselineRemainingPaths = @($changedPaths | Where-Object { $baselineDirtyPaths -contains $_ })
    $baselineMissingPaths = @($baselineDirtyPaths | Where-Object { $changedPaths -notcontains $_ })
    $nonAiDevPaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
    $newAiDevPaths = @($changedPaths | Where-Object { (Test-IsAiDevOperationalPath $_) -and ($baselineDirtyPaths -notcontains $_) })

    if ($baselineMissingPaths.Count -gt 0) {
        $message = "Final clean verification failed: baseline dirty paths from auto-goal start disappeared before completion. They may have been committed or otherwise swallowed, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (baseline dirty disappeared).`nMissing baseline dirty paths:`n$($baselineMissingPaths -join "`n")`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
        Stop-AutoGoal $script:steps "final_baseline_dirty_disappeared" $false 1
    }

    if ($baselineRemainingPaths.Count -gt 0) {
        $message = "Final clean verification failed: baseline dirty files remain, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (baseline dirty remains).`nRemaining baseline dirty paths:`n$($baselineRemainingPaths -join "`n")`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
        Stop-AutoGoal $script:steps "final_baseline_dirty_remains" $false 1
    }

    if ($nonAiDevPaths.Count -gt 0) {
        $message = "Final clean verification failed: non-.ai-dev changes remain, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (non-.ai-dev dirty remains).`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
        Stop-AutoGoal $script:steps "final_non_ai_dev_changes" $false 1
    }

    if ($newAiDevPaths.Count -eq 0) {
        $message = "Final clean verification failed: dirty paths remain, but none are new .ai-dev operational changes that auto-goal may commit.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (no eligible .ai-dev changes).`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
        Stop-AutoGoal $script:steps "final_no_eligible_meta_changes" $false 1
    }

    if (-not $AllowCommit) {
        $message = "Final clean verification failed: only new .ai-dev operational changes remain, but -AllowCommit is required to create the final meta commit.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (-AllowCommit missing).`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
        Stop-AutoGoal $script:steps "final_ai_dev_changes_require_commit" $false 1
    }

    $addArguments = @("add", "--") + $newAiDevPaths
    $addOutput = & git @addArguments 2>&1 | Out-String
    $addExitCode = $LASTEXITCODE

    if ($addExitCode -ne 0) {
        & git restore --staged -- $newAiDevPaths 2>&1 | Out-String | Out-Null
        $restoredPaths = @(Restore-AutoGoalCurrentRunOperationalChanges $newAiDevPaths)
        $message = "auto-goal 최종 .ai-dev 메타 변경 git add 실패. exit code: $addExitCode`n$addOutput"
        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-dev files>" $true $false 1 "$message`nRestored run-owned files: $($restoredPaths -join ', ')"
        Stop-AutoGoal $script:steps "final_meta_add_failed" $false 1
    }

    $metaCommitMessage = "chore(ai-dev): record final auto-goal state"
    $commitArguments = @("commit", "-m", $metaCommitMessage, "--") + $newAiDevPaths
    $commitOutput = & git @commitArguments 2>&1 | Out-String
    $commitExitCode = $LASTEXITCODE

    if ($commitExitCode -ne 0) {
        & git restore --staged -- $newAiDevPaths 2>&1 | Out-String | Out-Null
        $restoredPaths = @(Restore-AutoGoalCurrentRunOperationalChanges $newAiDevPaths)
        $message = "auto-goal 최종 .ai-dev 메타 커밋 실패. exit code: $commitExitCode`n$commitOutput"
        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m '$metaCommitMessage' -- <final .ai-dev files>" $true $false 1 "$message`nRestored run-owned files: $($restoredPaths -join ', ')"
        Stop-AutoGoal $script:steps "final_meta_commit_failed" $false 1
    }

    $remainingStatus = @(Get-GitStatusLines $StepNumber "final-change-gate")

    if ($remainingStatus.Count -gt 0) {
        $message = "Final clean verification failed: changes remain after the final .ai-dev meta commit, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: yes`nFinal clean verification: failed; git status --short still reports $($remainingStatus.Count) change(s).`n$($remainingStatus -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" "git status --short" $true $false 1 $message
        Stop-AutoGoal $script:steps "final_worktree_dirty" $false 1
    }

    $message = ($commitOutput.Trim(), "Baseline dirty count: $baselineDirtyCount", "Final dirty count: $finalDirtyCount", "Final .ai-dev meta commit created: yes", "Final clean verification: git status --short returned no changes.") -join "`n"
    $script:steps += New-StepResult $StepNumber "final-change-gate" "git add/commit final .ai-dev operational changes, git status --short" $true $false 0 $message
}

function Invoke-CompletedCleanVerification {
    param([int]$StepNumber)

    $remainingStatus = @(Get-GitStatusLines $StepNumber "completed-clean-gate")

    if ($remainingStatus.Count -gt 0) {
        $message = "Completed clean verification failed: git status --short still reports $($remainingStatus.Count) change(s) after all result/state files were written and the final gate ran.`n$($remainingStatus -join "`n")"
        $script:steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $true $false 1 $message
        Stop-AutoGoal $script:steps "completed_worktree_dirty" $false 1
    }

    $script:steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $true $false 0 "Completed clean verification passed: git status --short returned no changes after all result/state files were written."
}

function Invoke-FinalPreparedResultGate {
    param(
        [int]$StepNumber,
        [int]$CleanGateStepNumber,
        [string]$StoppedReason
    )

    Clear-AutoGoalTempArtifacts

    $command = "write final result, git add/commit final .ai-dev operational changes, git status --short"
    $baselineDirtyPaths = @($script:autoGoalBaselineDirtyPaths)
    $baselineDirtyCount = $baselineDirtyPaths.Count
    $preparedGateStepsWritten = $false

    Save-AutoGoalResultFile $StoppedReason $true 0

    $statusLines = @(Get-GitStatusLines $StepNumber "final-change-gate")
    $finalDirtyCount = $statusLines.Count

    if ($statusLines.Count -eq 0 -and $baselineDirtyCount -gt 0) {
        $message = "Final clean verification failed: baseline dirty paths from auto-goal start are no longer visible in git status. They may have been committed or otherwise swallowed, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (baseline dirty disappeared).`nBaseline dirty paths:`n$($baselineDirtyPaths -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
        Stop-AutoGoal $script:steps "final_baseline_dirty_disappeared" $false 1
    }

    if ($statusLines.Count -eq 0) {
        $message = "Baseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount before writing final gate entries.`nFinal .ai-dev meta commit created: pending if final gate entries dirty the result file.`nFinal clean verification: git status --short will be required after the final result file is written."
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 0 $message
        $script:steps += New-StepResult $CleanGateStepNumber "completed-clean-gate" "git status --short" $true $false 0 "Completed clean verification passed: git status --short returned no changes after the final result file was written."
        Save-AutoGoalResultFile $StoppedReason $true 0
        $preparedGateStepsWritten = $true
        $statusLines = @(Get-GitStatusLines $StepNumber "final-change-gate")
        $finalDirtyCount = $statusLines.Count

        if ($statusLines.Count -eq 0) {
            return
        }
    }

    $changedPaths = @(
        $statusLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            Where-Object { Test-HasValue $_ } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Select-Object -Unique
    )
    $baselineRemainingPaths = @($changedPaths | Where-Object { $baselineDirtyPaths -contains $_ })
    $baselineMissingPaths = @($baselineDirtyPaths | Where-Object { $changedPaths -notcontains $_ })
    $nonAiDevPaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
    $newAiDevPaths = @($changedPaths | Where-Object { (Test-IsAiDevOperationalPath $_) -and ($baselineDirtyPaths -notcontains $_) })

    if ($baselineMissingPaths.Count -gt 0) {
        $message = "Final clean verification failed: baseline dirty paths from auto-goal start disappeared before completion. They may have been committed or otherwise swallowed, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (baseline dirty disappeared).`nMissing baseline dirty paths:`n$($baselineMissingPaths -join "`n")`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
        Stop-AutoGoal $script:steps "final_baseline_dirty_disappeared" $false 1
    }

    if ($baselineRemainingPaths.Count -gt 0) {
        $message = "Final clean verification failed: baseline dirty files remain, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (baseline dirty remains).`nRemaining baseline dirty paths:`n$($baselineRemainingPaths -join "`n")`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
        Stop-AutoGoal $script:steps "final_baseline_dirty_remains" $false 1
    }

    if ($nonAiDevPaths.Count -gt 0) {
        $message = "Final clean verification failed: non-.ai-dev changes remain, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (non-.ai-dev dirty remains).`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
        Stop-AutoGoal $script:steps "final_non_ai_dev_changes" $false 1
    }

    if ($newAiDevPaths.Count -eq 0) {
        $message = "Final clean verification failed: dirty paths remain, but none are new .ai-dev operational changes that auto-goal may commit.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (no eligible .ai-dev changes).`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
        Stop-AutoGoal $script:steps "final_no_eligible_meta_changes" $false 1
    }

    if (-not $AllowCommit) {
        $message = "Final clean verification failed: only new .ai-dev operational changes remain, but -AllowCommit is required to create the final meta commit.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (-AllowCommit missing).`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
        Stop-AutoGoal $script:steps "final_ai_dev_changes_require_commit" $false 1
    }

    if (-not $preparedGateStepsWritten) {
        $message = "Baseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: pending; this final result file is written before that commit and included in it.`nFinal .ai-dev paths to commit:`n$($newAiDevPaths -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 0 $message
        $script:steps += New-StepResult $CleanGateStepNumber "completed-clean-gate" "git status --short" $true $false 0 "Completed clean verification is enforced immediately after the final .ai-dev meta commit; completed=true is returned only if git status --short reports no changes."
        Save-AutoGoalResultFile $StoppedReason $true 0
    }

    $statusLines = @(Get-GitStatusLines $StepNumber "final-change-gate")
    $newAiDevPaths = @(
        $statusLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            Where-Object { Test-HasValue $_ } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Where-Object { (Test-IsAiDevOperationalPath $_) -and ($baselineDirtyPaths -notcontains $_) } |
            Select-Object -Unique
    )

    if ($newAiDevPaths.Count -eq 0) {
        $message = "Final clean verification failed: no final .ai-dev operational paths were available to commit after the final result file was written.`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
        Stop-AutoGoal $script:steps "final_no_eligible_meta_changes" $false 1
    }

    $addArguments = @("add", "--") + $newAiDevPaths
    $addOutput = & git @addArguments 2>&1 | Out-String
    $addExitCode = $LASTEXITCODE

    if ($addExitCode -ne 0) {
        & git restore --staged -- $newAiDevPaths 2>&1 | Out-String | Out-Null
        $restoredPaths = @(Restore-AutoGoalCurrentRunOperationalChanges $newAiDevPaths)
        $message = "auto-goal 최종 .ai-dev 메타 변경 git add 실패. exit code: $addExitCode`n$addOutput"
        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-dev files>" $true $false 1 "$message`nRestored run-owned files: $($restoredPaths -join ', ')"
        Stop-AutoGoal $script:steps "final_meta_add_failed" $false 1
    }

    $metaCommitMessage = "chore(ai-dev): record final auto-goal state"
    $commitArguments = @("commit", "-m", $metaCommitMessage, "--") + $newAiDevPaths
    $commitOutput = & git @commitArguments 2>&1 | Out-String
    $commitExitCode = $LASTEXITCODE

    if ($commitExitCode -ne 0) {
        & git restore --staged -- $newAiDevPaths 2>&1 | Out-String | Out-Null
        $restoredPaths = @(Restore-AutoGoalCurrentRunOperationalChanges $newAiDevPaths)
        $message = "auto-goal 최종 .ai-dev 메타 커밋 실패. exit code: $commitExitCode`n$commitOutput"
        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m '$metaCommitMessage' -- <final .ai-dev files>" $true $false 1 "$message`nRestored run-owned files: $($restoredPaths -join ', ')"
        Stop-AutoGoal $script:steps "final_meta_commit_failed" $false 1
    }

    $remainingStatus = @(Get-GitStatusLines $CleanGateStepNumber "completed-clean-gate")

    if ($remainingStatus.Count -gt 0) {
        $message = "Completed clean verification failed: changes remain after the final .ai-dev meta commit, so auto-goal will not report completed.`n$($remainingStatus -join "`n")"
        $script:steps += New-StepResult $CleanGateStepNumber "completed-clean-gate" "git status --short" $true $false 1 $message
        Stop-AutoGoal $script:steps "completed_worktree_dirty" $false 1
    }
}

function Complete-AutoGoal {
    param(
        [int]$PreFinalGateStepNumber,
        [int]$ResultStepNumber,
        [int]$PostFinalGateStepNumber,
        [int]$CleanGateStepNumber,
        [string]$StoppedReason
    )

    Invoke-FinalAutoGoalChangeGate $PreFinalGateStepNumber
    $script:steps += New-StepResult $ResultStepNumber "write-final-result" (ConvertTo-RepoRelativePath $ResultPath) $true $false 0 "Final success result file is written after the pre-result final change gate and before the final .ai-dev meta commit."
    Invoke-FinalPreparedResultGate $PostFinalGateStepNumber $CleanGateStepNumber $StoppedReason
    $script:autoGoalCanCleanTempArtifacts = $false
    Stop-AutoGoal $script:steps $StoppedReason $true 0
}

function Get-JsonObjectCandidates {
    param([string]$RawInput)

    $candidates = @()
    $seen = @{}

    for ($start = 0; $start -lt $RawInput.Length; $start++) {
        if ($RawInput[$start] -ne "{") {
            continue
        }

        $depth = 0
        $inString = $false
        $escaped = $false

        for ($index = $start; $index -lt $RawInput.Length; $index++) {
            $char = $RawInput[$index]

            if ($escaped) {
                $escaped = $false
                continue
            }

            if ($char -eq "\") {
                $escaped = $true
                continue
            }

            if ($char -eq '"') {
                $inString = -not $inString
                continue
            }

            if ($inString) {
                continue
            }

            if ($char -eq "{") {
                $depth++
                continue
            }

            if ($char -eq "}") {
                $depth--

                if ($depth -eq 0) {
                    $candidateText = $RawInput.Substring($start, $index - $start + 1).Trim()

                    if (-not $seen.ContainsKey($candidateText)) {
                        $seen[$candidateText] = $true
                        $candidates += [PSCustomObject]@{
                            Start = $start
                            Text = $candidateText
                            HasPlanShape = ($candidateText -match '"goalMarkdown"\s*:' -and $candidateText -match '"queue"\s*:' -and $candidateText -match '"state"\s*:')
                        }
                    }

                    break
                }
            }
        }
    }

    return @($candidates | Sort-Object -Property @{ Expression = "HasPlanShape"; Descending = $true }, @{ Expression = "Start"; Descending = $true } | ForEach-Object { $_.Text })
}

function Get-MissingFields {
    param(
        [object]$InputObject,
        [string[]]$RequiredFields
    )

    $missingFields = @()

    foreach ($field in $RequiredFields) {
        if (-not ($InputObject.PSObject.Properties.Name -contains $field)) {
            $missingFields += $field
        }
    }

    return $missingFields
}

function Get-QueueValidationErrors {
    param([object]$Queue)

    $errors = @()
    $requiredFields = @("goalTitle", "goalSource", "createdAt", "updatedAt", "currentTaskId", "tasks")

    foreach ($field in @(Get-MissingFields $Queue $requiredFields)) {
        $errors += "queue missing field: $field"
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (-not (Test-HasValue $Queue.goalTitle)) {
        $errors += "queue.goalTitle must not be empty."
    }

    if ($Queue.goalSource -ne $goalRelativePath) {
        $errors += "queue.goalSource must be $goalRelativePath."
    }

    if ($Queue.tasks -isnot [System.Collections.IEnumerable] -or $Queue.tasks -is [string]) {
        $errors += "queue.tasks must be an array."
        return $errors
    }

    $tasks = @($Queue.tasks)

    if ($tasks.Count -lt 1) {
        $errors += "queue.tasks must contain at least one task."
        return $errors
    }

    if ($tasks.Count -gt 3) {
        $errors += "queue.tasks must contain no more than three tasks."
    }

    if ($Queue.currentTaskId -ne "T001") {
        $errors += "queue.currentTaskId must be T001."
    }

    $taskIds = @()

    foreach ($task in $tasks) {
        $taskRequiredFields = @("id", "title", "description", "type", "status", "priority", "dependsOn", "filesLikelyToChange", "verification", "commitMessage")
        $taskMissingFields = @(Get-MissingFields $task $taskRequiredFields)

        foreach ($field in $taskMissingFields) {
            $errors += "task missing field: $field"
        }

        if ($taskMissingFields.Count -gt 0) {
            continue
        }

        if (-not (Test-HasValue $task.id)) {
            $errors += "task.id must not be empty."
        } else {
            $taskIds += [string]$task.id
        }

        if (-not (Test-HasValue $task.title)) {
            $errors += "task.title must not be empty."
        }

        if (-not (Test-HasValue $task.description)) {
            $errors += "task.description must not be empty."
        }

        if (@("analysis", "implementation", "documentation", "verification") -notcontains $task.type) {
            $errors += "invalid task.type: $($task.type)"
        }

        if (@("pending", "in_progress", "done", "blocked") -notcontains $task.status) {
            $errors += "invalid task.status: $($task.status)"
        }

        if (@("P0", "P1", "P2") -notcontains $task.priority) {
            $errors += "invalid task.priority: $($task.priority)"
        }

        if ($task.dependsOn -isnot [System.Collections.IEnumerable] -or $task.dependsOn -is [string]) {
            $errors += "task.dependsOn must be an array: $($task.id)"
        }

        if ($task.filesLikelyToChange -isnot [System.Collections.IEnumerable] -or $task.filesLikelyToChange -is [string]) {
            $errors += "task.filesLikelyToChange must be an array: $($task.id)"
        }

        if ($task.verification -isnot [System.Collections.IEnumerable] -or $task.verification -is [string]) {
            $errors += "task.verification must be an array: $($task.id)"
        }
    }

    if ((@($tasks | Where-Object { $_.status -eq "in_progress" })).Count -ne 1) {
        $errors += "queue.tasks must contain exactly one in_progress task."
    }

    if (-not (Test-HasValue $Queue.currentTaskId)) {
        $errors += "queue.currentTaskId must not be empty."
    } elseif ($taskIds -notcontains [string]$Queue.currentTaskId) {
        $errors += "queue.currentTaskId does not match a task: $($Queue.currentTaskId)"
    }

    $firstTask = $tasks | Where-Object { $_.id -eq "T001" } | Select-Object -First 1
    if ($null -eq $firstTask) {
        $errors += "queue.tasks must include T001."
    } elseif ($firstTask.status -ne "in_progress") {
        $errors += "T001 must be in_progress."
    }

    foreach ($laterTask in @($tasks | Where-Object { $_.id -ne "T001" })) {
        if ($laterTask.status -ne "pending") {
            $errors += "later tasks must be pending: $($laterTask.id)"
        }
    }

    return $errors
}

function Get-StateValidationErrors {
    param(
        [object]$State,
        [object]$Queue
    )

    $errors = @()
    $requiredFields = @("goalStatus", "currentTaskId", "currentLoop", "maxLoopsPerTask", "repeatedFailureCount", "lastCommand", "lastCommandStatus", "lastErrorSummary", "lastReviewDecision", "lastReviewSeverity", "lastCommitHash", "startedAt", "updatedAt", "stopReason")

    foreach ($field in @(Get-MissingFields $State $requiredFields)) {
        $errors += "state missing field: $field"
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (@("idle", "in_progress", "completed", "blocked") -notcontains $State.goalStatus) {
        $errors += "invalid state.goalStatus: $($State.goalStatus)"
    }

    if ($State.currentTaskId -ne $Queue.currentTaskId) {
        $errors += "state.currentTaskId must match queue.currentTaskId."
    }

    if ($State.currentTaskId -ne "T001") {
        $errors += "state.currentTaskId must be T001."
    }

    if (@("not_started", "passed", "failed", "blocked") -notcontains $State.lastCommandStatus) {
        $errors += "invalid state.lastCommandStatus: $($State.lastCommandStatus)"
    }

    if (@("not_started", "pass", "revise", "blocked") -notcontains $State.lastReviewDecision) {
        $errors += "invalid state.lastReviewDecision: $($State.lastReviewDecision)"
    }

    return $errors
}

function Get-AutoGoalValidationErrors {
    param([object]$Plan)

    $errors = @()

    foreach ($field in @(Get-MissingFields $Plan @("goalMarkdown", "queue", "state"))) {
        $errors += "plan missing field: $field"
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (-not (Test-HasValue $Plan.goalMarkdown)) {
        $errors += "goalMarkdown must not be empty."
    }

    $errors += @(Get-QueueValidationErrors $Plan.queue)
    $errors += @(Get-StateValidationErrors $Plan.state $Plan.queue)

    return $errors
}

function New-DryRunAutoGoalPlan {
    param(
        [string]$Title,
        [string]$Description
    )

    $now = (Get-Date).ToUniversalTime().ToString("o")
    $safeTitle = $Title.Trim()
    $safeDescription = $Description.Trim()

    $plan = [PSCustomObject][ordered]@{
        goalMarkdown = @"
# 목표

$safeTitle

## 배경

$safeDescription

## 성공 기준

- 입력한 목표에서 현재 작업을 준비한다.
- full auto-cycle 실행 전에 현재 작업 프롬프트가 생성된다.
- full auto-cycle은 명시적인 허용 옵션이 있을 때만 실행된다.

## 제약사항

- 서버 API, 로그인, 클라우드 동기화, npm install, 위험한 git 명령은 사용하지 않는다.
- 저장소 정책과 현재 작업 범위를 따른다.

## 범위 제외

- 패키지 변경
- DB 삭제 또는 초기화
- 광범위한 리팩터링

## 수동 검증

- DryRun 계획과 JSON 출력을 검토한다.
- 현재 작업 프롬프트 생성 여부를 확인한다.
- 필요한 경우 빌드와 검증은 별도로 실행한다.
"@
        queue = [PSCustomObject][ordered]@{
            goalTitle = $safeTitle
            goalSource = $goalRelativePath
            createdAt = $now
            updatedAt = $now
            currentTaskId = "T001"
            tasks = @(
                [PSCustomObject][ordered]@{
                    id = "T001"
                    title = $safeTitle
                    description = $safeDescription
                    type = "implementation"
                    status = "in_progress"
                    priority = "P0"
                    dependsOn = @()
                    filesLikelyToChange = @()
                    verification = @(
                        "변경 범위가 현재 목표와 일치하는지 확인한다.",
                        "필요한 경우 npm run build를 별도로 실행한다."
                    )
                    commitMessage = $null
                }
            )
        }
        state = [PSCustomObject][ordered]@{
            goalStatus = "in_progress"
            currentTaskId = "T001"
            currentLoop = 0
            maxLoopsPerTask = 2
            repeatedFailureCount = 0
            lastCommand = $null
            lastCommandStatus = "not_started"
            lastErrorSummary = $null
            lastReviewDecision = "not_started"
            lastReviewSeverity = $null
            lastCommitHash = $null
            startedAt = $now
            updatedAt = $now
            stopReason = $null
        }
    }

    return $plan
}

function ConvertFrom-CodexAutoGoalOutput {
    param([string]$RawInput)

    $validationFailures = @()

    foreach ($candidate in Get-JsonObjectCandidates $RawInput) {
        try {
            $parsed = $candidate | ConvertFrom-Json

            if ($null -eq $parsed -or $parsed -is [System.Array]) {
                continue
            }

            $validationErrors = @(Get-AutoGoalValidationErrors $parsed)

            if ($validationErrors.Count -gt 0) {
                $validationFailures += "Candidate validation failed: $($validationErrors -join '; ')"
                continue
            }

            return [PSCustomObject]@{
                Parsed = $parsed
                JsonText = ($parsed | ConvertTo-Json -Depth 30)
            }
        } catch {
        }
    }

    if ($validationFailures.Count -gt 0) {
        throw "No valid auto-goal JSON object was found in Codex output. Validation errors: $($validationFailures -join ' | ')"
    }

    throw "No valid auto-goal JSON object was found in Codex output."
}

function New-CodexAutoGoalPrompt {
    param(
        [string]$Title,
        [string]$Description
    )

    return @"
You are preparing local AI Dev Loop state files for the repository at $repoRoot.

Return exactly one JSON object and no markdown fences or commentary.

The user supplied this new goal:
Title: $Title
Description: $Description

Create a small, safe goal plan for this repository. The response object must have these fields:
- goalMarkdown: .ai-dev/goal.md에 작성할 마크다운 문자열입니다. "# 목표", "배경", "성공 기준", "제약사항", "범위 제외", "수동 검증" 섹션을 한국어로 포함해야 합니다.
- queue: an object for .ai-dev/queue.json.
- state: an object for .ai-dev/state.json.

queue rules:
- goalTitle must equal the supplied title.
- goalSource must be ".ai-dev/goal.md".
- createdAt and updatedAt are required and must be ISO 8601 strings.
- currentTaskId must be "T001".
- tasks must contain one to three tasks.
- T001 must be status "in_progress"; later tasks, if any, must be "pending".
- each task must include id, title, description, type, status, priority, dependsOn, filesLikelyToChange, verification, commitMessage.
- type must be one of analysis, implementation, documentation, verification.
- priority must be P0, P1, or P2.
- dependsOn, filesLikelyToChange, and verification must be arrays.
- commitMessage must be null or a short English commit message.

state rules:
- goalStatus must be "in_progress".
- currentTaskId must be "T001".
- currentLoop must be 0.
- maxLoopsPerTask must be 2.
- repeatedFailureCount must be 0.
- lastCommand must be null.
- lastCommandStatus must be "not_started".
- lastErrorSummary must be null.
- lastReviewDecision must be "not_started".
- lastReviewSeverity must be null.
- lastCommitHash must be null.
- startedAt and updatedAt must be ISO 8601 strings.
- stopReason must be null.

Safety rules:
- Do not mention server APIs, login, cloud sync, npm install, git reset, git clean, git push, DB deletion, or broad rewrites as implementation steps.
- Prefer one small implementation task when the goal is small.
- Use Korean for user-facing task titles, descriptions, verification, and goalMarkdown.
"@
}

function New-CodexAutoGoalWrapperPrompt {
    param(
        [string]$PromptFilePath
    )

    return "Read and follow the full auto-goal planning prompt at this absolute file path: $PromptFilePath"
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
        $script:steps += New-StepResult $StepNumber $Name $Command $false $true 0 "DryRun: child script was not executed."
        return
    }

    $output = & powershell -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1 | Out-String
    $exitCode = $LASTEXITCODE
    $message = $output.Trim()

    if ([string]::IsNullOrWhiteSpace($message)) {
        $message = "completed"
    }

    $script:steps += New-StepResult $StepNumber $Name $Command $true $false $exitCode $message

    if ($exitCode -ne 0) {
        $childStoppedReason = Get-StoppedReasonFromOutput $message
        $stoppedReason = if (Test-IsExpectedPreImplementationStop $childStoppedReason) { $childStoppedReason } else { "$Name`_failed" }
        Stop-AutoGoal $script:steps $stoppedReason $false 1
    }
}

function Get-FullCycleArguments {
    $arguments = @("-MaxTasks", ([string]$MaxTasks), "-MaxSteps", ([string]$MaxSteps))

    if ($AllowCodex) {
        $arguments += "-AllowCodex"
    }

    if ($AllowReviewCodex) {
        $arguments += "-AllowReviewCodex"
    }

    if ($AllowCommit) {
        $arguments += "-AllowCommit"
    }

    # auto-goal writes goal/queue/state/current prompt/result files after the initial dirty gate.
    # The downstream full cycle must tolerate those intended artifacts.
    $arguments += "-AllowDirty"

    if ($script:autoGoalBaselineDirtyPaths.Count -gt 0) {
        $arguments += "-ProtectedBaselineDirtyPaths"
        $arguments += ($script:autoGoalBaselineDirtyPaths -join ",")
    }

    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })

        if ($normalizedFiles.Count -gt 0) {
            $arguments += "-CommitFiles"
            $arguments += ($normalizedFiles -join ",")
        }
    }

    return $arguments
}

function Get-CurrentGoalStatus {
    $statePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $stateRelativePath))

    try {
        $state = Get-Content -Raw -Encoding UTF8 -LiteralPath $statePath | ConvertFrom-Json
    } catch {
        throw "$stateRelativePath JSON 파싱에 실패했습니다: $($_.Exception.Message)"
    }

    if ($null -eq $state -or -not ($state.PSObject.Properties.Name -contains "goalStatus")) {
        throw "$stateRelativePath 파일에서 goalStatus를 찾을 수 없습니다."
    }

    return [string]$state.goalStatus
}

Set-Location $repoRoot

$script:steps = @()
$script:autoGoalPlanPreview = $null
$script:autoGoalBaselineStatusLines = @()
$script:autoGoalBaselineDirtyPaths = @()
$resolvedGoalPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $goalRelativePath))
$resolvedQueuePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $queueRelativePath))
$resolvedStatePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $stateRelativePath))
$resolvedPlanningPromptPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $planningPromptRelativePath))
$resolvedResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ResultPath))
Initialize-AutoGoalOperationalFileSnapshots

if (-not (Test-HasValue $GoalTitle)) {
    $script:steps += New-StepResult 0 "validate-input" "check GoalTitle" $false $false 1 "GoalTitle must not be empty."
    Stop-AutoGoal $script:steps "invalid_goal_title" $false 1
}

if (-not (Test-HasValue $GoalDescription)) {
    $script:steps += New-StepResult 0 "validate-input" "check GoalDescription" $false $false 1 "GoalDescription must not be empty."
    Stop-AutoGoal $script:steps "invalid_goal_description" $false 1
}

if ($MaxTasks -lt 1) {
    $script:steps += New-StepResult 0 "validate-input" "check MaxTasks" $false $false 1 "MaxTasks must be at least 1."
    Stop-AutoGoal $script:steps "max_tasks_must_be_at_least_1" $false 1
}

if ($MaxSteps -lt 1) {
    $script:steps += New-StepResult 0 "validate-input" "check MaxSteps" $false $false 1 "MaxSteps must be at least 1."
    Stop-AutoGoal $script:steps "max_steps_must_be_at_least_1" $false 1
}

$makePromptPath = Join-Path $PSScriptRoot "ai-dev-make-prompt.ps1"
$autoCycleFullPath = Join-Path $PSScriptRoot "ai-dev-auto-cycle-full.ps1"

foreach ($requiredScript in @($makePromptPath, $autoCycleFullPath)) {
    if (-not (Test-Path -LiteralPath $requiredScript -PathType Leaf)) {
        $script:steps += New-StepResult 0 "prepare" "check required scripts" $false $false 1 "Missing required script: $requiredScript"
        Stop-AutoGoal $script:steps "prepare_failed" $false 1
    }
}

$shouldRunFullCycle = [bool]($AllowRun -or $AllowCodex -or $AllowReviewCodex -or $AllowCommit)
$fullCycleArguments = @(Get-FullCycleArguments)
$fullCycleCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 $($fullCycleArguments -join ' ')".Trim()

$script:steps += New-StepResult 1 "validate-input" "check GoalTitle/GoalDescription" $false $false 0 "Input validation completed: $GoalTitle"

if ($DryRun) {
    $script:autoGoalPlanPreview = New-DryRunAutoGoalPlan $GoalTitle.Trim() $GoalDescription.Trim()
    $previewValidationErrors = @(Get-AutoGoalValidationErrors $script:autoGoalPlanPreview)

    if ($previewValidationErrors.Count -gt 0) {
        $script:steps += New-StepResult 2 "preview-plan" "local dry-run plan preview" $false $false 1 "DryRun preview plan validation failed: $($previewValidationErrors -join '; ')"
        Stop-AutoGoal $script:steps "dry_run_preview_invalid" $false 1
    }

    $plannedAutoGoalOutputPaths = @(Get-PlannedAutoGoalOutputPaths)
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --porcelain; compare baseline dirty paths with planned auto-goal outputs" $false $true 0 "DryRun: baseline dirty capture, dirty worktree gate, and baseline output conflict gate were not executed. Would check planned output paths: $($plannedAutoGoalOutputPaths -join ', ')"
    $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $false $true 0 "DryRun: Codex goal planning was not executed. Preview currentTaskId: T001, task: $GoalTitle"
    $script:steps += New-StepResult 4 "validate-generated-json" "goal/queue/state JSON validation" $false $true 0 "DryRun: preview goal/queue/state plan passed local schema validation."
    $script:steps += New-StepResult 5 "write-state-files" "$goalRelativePath, $queueRelativePath, $stateRelativePath" $false $true 0 "DryRun: state files were not written."
    $script:steps += New-StepResult 6 "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1" $false $true 0 "DryRun: current-task-prompt.md was not generated."

    if ($shouldRunFullCycle) {
        $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleCommandText $false $true 0 "DryRun: explicit run option is present, but full cycle was not executed. -AllowRun only invokes the full-cycle wrapper; implementation and review still require -AllowCodex and -AllowReviewCodex."
    } else {
        $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleCommandText $false $true 0 "DryRun: full cycle requires -AllowRun or explicit execution options. -AllowRun only invokes the full-cycle wrapper; implementation and review still require -AllowCodex and -AllowReviewCodex."
    }

    Stop-AutoGoal $script:steps "dry_run" $false 0
}

$script:autoGoalBaselineStatusLines = @(Get-GitPorcelainStatusLines)
$script:autoGoalBaselineDirtyPaths = @(
    $script:autoGoalBaselineStatusLines |
        ForEach-Object { Convert-ToChangedPath $_ } |
        Where-Object { Test-HasValue $_ } |
        ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
        Select-Object -Unique
)
$plannedAutoGoalOutputPaths = @(Get-PlannedAutoGoalOutputPaths)
Invoke-BaselineOutputConflictGate $script:autoGoalBaselineDirtyPaths $plannedAutoGoalOutputPaths

$statusLines = @($script:autoGoalBaselineStatusLines)
$baselineDirtyCount = $script:autoGoalBaselineDirtyPaths.Count

if ($statusLines.Count -gt 0 -and -not $AllowDirty) {
    $dirtyText = ($statusLines -join "`n")
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --porcelain" $false $true 1 "Baseline dirty count: $baselineDirtyCount`nWorktree is dirty. Use -AllowDirty only when this is intentional.`n$dirtyText"
    Stop-AutoGoal $script:steps "dirty_worktree" $false 1
}

if ($statusLines.Count -gt 0) {
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --porcelain" $true $false 0 "AllowDirty is set. Baseline dirty count: $baselineDirtyCount"
} else {
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --porcelain" $true $false 0 "Baseline dirty count: 0. Worktree is clean."
}

$fullCycleArguments = @(Get-FullCycleArguments)
$fullCycleCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 $($fullCycleArguments -join ' ')".Trim()

$codexCommand = Get-Command codex -ErrorAction SilentlyContinue

if ($null -eq $codexCommand) {
    $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $false $false 1 "Codex CLI was not found."
    Stop-AutoGoal $script:steps "codex_not_found" $false 1
}

$plannerPrompt = New-CodexAutoGoalPrompt $GoalTitle.Trim() $GoalDescription.Trim()
$codexPrompt = New-CodexAutoGoalWrapperPrompt $resolvedPlanningPromptPath
$commandText = "codex exec <short wrapper pointing to $planningPromptRelativePath>"
[System.IO.File]::WriteAllText($resolvedPlanningPromptPath, $plannerPrompt, $utf8WithBom)
$startedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$codexOutput = & codex exec $codexPrompt 2>&1 | Out-String
$codexExitCode = $LASTEXITCODE
$endedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$resultContent = @"
# Codex Auto Goal Result

## Run

- Started at: $startedAt
- Ended at: $endedAt
- Exit code: $codexExitCode
- Goal title: $($GoalTitle.Trim())
- Planning prompt: $planningPromptRelativePath
- Command: $commandText

## Output

${codeFence}text
$codexOutput
$codeFence
"@

[System.IO.File]::WriteAllText($resolvedResultPath, $resultContent, $utf8WithBom)

if ($codexExitCode -ne 0) {
    $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $true $false 1 "Codex goal planning failed. Result: $(ConvertTo-RepoRelativePath $ResultPath)"
    Stop-AutoGoal $script:steps "codex_plan_failed" $false 1
}

$script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $true $false 0 "Codex goal planning completed. Result: $(ConvertTo-RepoRelativePath $ResultPath)"

try {
    $autoGoalPlan = ConvertFrom-CodexAutoGoalOutput $codexOutput
} catch {
    $preview = Get-InputPreview $codexOutput
    $script:steps += New-StepResult 4 "validate-generated-json" "goal/queue/state JSON validation" $false $false 1 "Codex plan JSON extraction failed: $($_.Exception.Message) Output preview: $preview"
    Stop-AutoGoal $script:steps "generated_json_invalid" $false 1
}

$script:steps += New-StepResult 4 "validate-generated-json" "goal/queue/state JSON validation" $false $false 0 "goalMarkdown, queue, and state JSON validation completed. currentTaskId: $($autoGoalPlan.Parsed.queue.currentTaskId)"
$script:autoGoalPlanPreview = $autoGoalPlan.Parsed

$goalMarkdown = [string]$autoGoalPlan.Parsed.goalMarkdown
$queueJson = $autoGoalPlan.Parsed.queue | ConvertTo-Json -Depth 30
$stateJson = $autoGoalPlan.Parsed.state | ConvertTo-Json -Depth 30

[System.IO.File]::WriteAllText($resolvedGoalPath, $goalMarkdown, $utf8WithBom)
[System.IO.File]::WriteAllText($resolvedQueuePath, $queueJson, $utf8WithBom)
[System.IO.File]::WriteAllText($resolvedStatePath, $stateJson, $utf8WithBom)

$script:steps += New-StepResult 5 "write-state-files" "$goalRelativePath, $queueRelativePath, $stateRelativePath" $true $false 0 "New goal, queue, and state files were written."

Invoke-CycleCommand 6 "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1" $makePromptPath @()

if (-not $shouldRunFullCycle) {
    $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleCommandText $false $true 0 "Full cycle requires -AllowRun or explicit execution options. -AllowRun only invokes the full-cycle wrapper; implementation and review still require -AllowCodex and -AllowReviewCodex."
    Complete-AutoGoal 8 9 10 11 "prepared_without_full_cycle"
}

Invoke-CycleCommand 7 "auto-cycle-full" $fullCycleCommandText $autoCycleFullPath $fullCycleArguments

try {
    $goalStatusAfterFullCycle = Get-CurrentGoalStatus
} catch {
    $script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $false 1 $_.Exception.Message
    Stop-AutoGoal $script:steps "goal_status_verify_failed" $false 1
}

if ($goalStatusAfterFullCycle -ne "completed") {
    $script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $true 1 "auto-cycle-full은 성공 종료했지만 goalStatus가 completed가 아닙니다: $goalStatusAfterFullCycle"
    Stop-AutoGoal $script:steps "auto_cycle_incomplete" $false 1
}

$script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $false 0 "auto-cycle-full 성공 후 goalStatus completed 확인."

Complete-AutoGoal 9 10 11 12 "completed"

