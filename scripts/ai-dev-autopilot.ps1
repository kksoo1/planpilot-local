param(
    [int]$MaxGoals = 1,
    [int]$MaxTasks = 1,
    [int]$MaxSteps = 22,
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowRun,
    [switch]$AllowCodex,
    [switch]$AllowReviewCodex,
    [switch]$AllowCommit,
    [switch]$AllowDirty,
    [string[]]$CommitFiles
)

. "$PSScriptRoot\ai-dev-env.ps1"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$goalRelativePath = ".ai-dev/goal.md"
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$backlogRelativePath = ".ai-dev/backlog.md"
$loopLogRelativePath = ".ai-dev/loop-log.md"
$goalHistoryRelativePath = ".ai-dev/autopilot-goal-history.json"
$autopilotMetaCommitRelativePaths = @(
    ".ai-dev/codex-result.md",
    ".ai-dev/current-task-prompt.md",
    ".ai-dev/goal.md",
    ".ai-dev/queue.json",
    ".ai-dev/state.json",
    ".ai-dev/test-result.md",
    $loopLogRelativePath,
    $goalHistoryRelativePath
)
$goalPath = Join-Path $repoRoot $goalRelativePath
$queuePath = Join-Path $repoRoot $queueRelativePath
$statePath = Join-Path $repoRoot $stateRelativePath
$backlogPath = Join-Path $repoRoot $backlogRelativePath
$loopLogPath = Join-Path $repoRoot $loopLogRelativePath
$goalHistoryPath = Join-Path $repoRoot $goalHistoryRelativePath
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
$script:autopilotOperationalFileSnapshots = @{}
$script:autopilotBaselineDirtyPaths = @()

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
        throw "Failed to parse JSON file $($RelativePath): $($_.Exception.Message)"
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

function New-EmptyGoalHistory {
    return [PSCustomObject][ordered]@{
        version = 1
        updatedAt = ""
        goals = @()
    }
}

function Read-AutopilotGoalHistory {
    if (-not (Test-Path -LiteralPath $goalHistoryPath -PathType Leaf)) {
        return New-EmptyGoalHistory
    }

    $history = Read-JsonFile $goalHistoryPath $goalHistoryRelativePath

    if ($null -eq $history) {
        return New-EmptyGoalHistory
    }

    if ($history -is [array]) {
        $normalized = New-EmptyGoalHistory
        $normalized.goals = @($history)
        return $normalized
    }

    if ($history.PSObject.Properties.Name -notcontains "goals" -or $null -eq $history.goals) {
        Set-ObjectProperty $history "goals" @()
    }

    if ($history.PSObject.Properties.Name -notcontains "version") {
        Set-ObjectProperty $history "version" 1
    }

    if ($history.PSObject.Properties.Name -notcontains "updatedAt") {
        Set-ObjectProperty $history "updatedAt" ""
    }

    return $history
}

function Get-AutopilotGoalHistoryTitles {
    try {
        $history = Read-AutopilotGoalHistory
    } catch {
        throw "Failed to read durable autopilot goal history: $($_.Exception.Message)"
    }

    $titles = @()

    foreach ($goal in @($history.goals)) {
        if ($null -eq $goal) {
            continue
        }

        if ($goal -is [string]) {
            $titles = @(Add-UniqueTitle $titles $goal)
            continue
        }

        if ($goal.PSObject.Properties.Name -contains "title") {
            $titles = @(Add-UniqueTitle $titles ([string]$goal.title))
        }
    }

    return @($titles)
}

function Add-AutopilotGoalHistoryTitle {
    param(
        [string]$Title,
        [string]$Event
    )

    if ($DryRun -or -not (Test-HasValue $Title)) {
        return
    }

    if (Test-IsAutopilotBaselineDirtyPath $goalHistoryRelativePath) {
        return
    }

    $now = [DateTimeOffset]::UtcNow.ToString("o")
    $trimmedTitle = $Title.Trim()
    $history = Read-AutopilotGoalHistory
    $goals = @($history.goals)
    $existingGoal = $null

    foreach ($goal in $goals) {
        if ($null -eq $goal) {
            continue
        }

        $goalTitle = ""

        if ($goal -is [string]) {
            $goalTitle = [string]$goal
        } elseif ($goal.PSObject.Properties.Name -contains "title") {
            $goalTitle = [string]$goal.title
        }

        if ($goalTitle.Trim() -eq $trimmedTitle) {
            $existingGoal = $goal
            break
        }
    }

    if ($null -eq $existingGoal -or $existingGoal -is [string]) {
        $events = @([PSCustomObject][ordered]@{
            event = $Event
            at = $now
        })

        $goalEntry = [PSCustomObject][ordered]@{
            title = $trimmedTitle
            firstSeenAt = $now
            lastSeenAt = $now
            lastEvent = $Event
            events = $events
        }

        $goals = @($goals | Where-Object { -not ($_ -is [string] -and $_.Trim() -eq $trimmedTitle) })
        $goals = @($goals) + @($goalEntry)
    } else {
        if ($existingGoal.PSObject.Properties.Name -notcontains "firstSeenAt" -or -not (Test-HasValue $existingGoal.firstSeenAt)) {
            Set-ObjectProperty $existingGoal "firstSeenAt" $now
        }

        Set-ObjectProperty $existingGoal "lastSeenAt" $now
        Set-ObjectProperty $existingGoal "lastEvent" $Event

        $events = @()
        if ($existingGoal.PSObject.Properties.Name -contains "events" -and $null -ne $existingGoal.events) {
            $events = @($existingGoal.events)
        }

        $events = @($events) + @([PSCustomObject][ordered]@{
            event = $Event
            at = $now
        })

        Set-ObjectProperty $existingGoal "events" $events
    }

    Set-ObjectProperty $history "version" 1
    Set-ObjectProperty $history "updatedAt" $now
    Set-ObjectProperty $history "goals" @($goals)
    Write-JsonFile $goalHistoryPath $history
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

function Add-LoopLogEntry {
    param(
        [string]$Title,
        [string[]]$Lines
    )

    if ($DryRun) {
        return
    }

    if (Test-IsAutopilotBaselineDirtyPath $loopLogRelativePath) {
        return
    }

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $entryLines = @("", "## $timestamp - $Title", "")
    $entryLines += @($Lines)
    $entryLines += ""
    [System.IO.File]::AppendAllText($loopLogPath, ($entryLines -join "`r`n"), $utf8WithBom)
}

function Test-IsExpectedAutopilotNonWorkStop {
    param([string]$StoppedReason)

    return @(
        "all_goal_candidates_excluded",
        "baseline_output_conflict",
        "dirty_worktree",
        "goal_candidate_not_found",
        "current_goal_not_completed",
        "max_steps_too_small_for_full_cycle"
    ) -contains $StoppedReason
}

function Get-StoppedReasonFromOutput {
    param([string]$Output)

    if (-not (Test-HasValue $Output)) {
        return ""
    }

    if ($Output -match '(?m)^\s*Stopped reason:\s*(\S+)\s*$') {
        return $Matches[1]
    }

    if ($Output -match '(?m)"stoppedReason"\s*:\s*"([^"]+)"') {
        return $Matches[1]
    }

    return ""
}

function ConvertTo-NormalizedChangedPath {
    param([string]$RelativePath)

    if (-not (Test-HasValue $RelativePath)) {
        return $null
    }

    return $RelativePath.Trim().Trim('"').Replace('\', '/')
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

function Get-AutopilotBaselineDirtyPaths {
    $statusOutput = & git status --porcelain 2>&1

    if ($LASTEXITCODE -ne 0) {
        throw "git status --porcelain failed while capturing autopilot baseline dirty paths: $($statusOutput -join "`n")"
    }

    return @(
        $statusOutput |
            ForEach-Object { Convert-ToChangedPath $_ } |
            Where-Object { Test-HasValue $_ } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Select-Object -Unique
    )
}

function Test-IsAutopilotBaselineDirtyPath {
    param([string]$RelativePath)

    $normalizedRelativePath = ConvertTo-NormalizedChangedPath $RelativePath
    return @($script:autopilotBaselineDirtyPaths) -contains $normalizedRelativePath
}

function Initialize-AutopilotOperationalFileSnapshots {
    $script:autopilotOperationalFileSnapshots = @{}

    foreach ($relativePath in @($stateRelativePath, $loopLogRelativePath, $goalHistoryRelativePath)) {
        $fullPath = [System.IO.Path]::GetFullPath((Join-Path $repoRoot $relativePath))

        if (-not $fullPath.StartsWith($repoRoot.TrimEnd("\") + "\", [System.StringComparison]::OrdinalIgnoreCase)) {
            continue
        }

        $exists = [System.IO.File]::Exists($fullPath)
        $bytes = $null

        if ($exists) {
            $bytes = [System.IO.File]::ReadAllBytes($fullPath)
        }

        $script:autopilotOperationalFileSnapshots[$relativePath] = [PSCustomObject][ordered]@{
            path = $fullPath
            existed = $exists
            bytes = $bytes
        }
    }
}

function Restore-AutopilotCurrentRunOperationalChanges {
    param([string[]]$RelativePaths = @())

    $restoredPaths = @()

    if ($null -eq $script:autopilotOperationalFileSnapshots) {
        return @($restoredPaths)
    }

    $targetPaths = @($RelativePaths | ForEach-Object { ConvertTo-NormalizedChangedPath $_ } | Where-Object { Test-HasValue $_ } | Select-Object -Unique)

    foreach ($entry in @($script:autopilotOperationalFileSnapshots.GetEnumerator())) {
        $relativePath = ConvertTo-NormalizedChangedPath ([string]$entry.Key)
        $snapshot = $entry.Value

        if ($targetPaths.Count -gt 0 -and $targetPaths -notcontains $relativePath) {
            continue
        }

        if (Test-IsAutopilotBaselineDirtyPath $relativePath) {
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
            Write-Warning "Failed to restore autopilot operational file snapshot: $fullPath"
        }
    }

    return @($restoredPaths | Select-Object -Unique)
}

function Add-AutopilotExpectedNonWorkLogEntry {
    param(
        [string]$StoppedReason,
        [string]$Message,
        [int]$PreparedGoals
    )

    $resultMessage = if (Test-HasValue $Message) { $Message } else { "Autopilot stopped before implementation work." }

    Add-LoopLogEntry "Autopilot expected non-work stop" @(
        "- Reason: $StoppedReason",
        "- Outcome category: expected_non_work",
        "- Result: $resultMessage",
        "- Prepared goals: $PreparedGoals/$MaxGoals",
        "- Failure counter: not incremented",
        "- Cleanup: restored current-run autopilot operational file snapshots before writing this meta log entry"
    )
}

function Invoke-AutopilotLoopLogMetaCommit {
    param([int]$StepNumber)

    if ($DryRun) {
        return New-StepResult $StepNumber "autopilot-meta-commit" $false $true 0 "DryRun: autopilot loop-log/history meta commit was not executed."
    }

    if (-not $AllowCommit) {
        return New-StepResult $StepNumber "autopilot-meta-commit" $false $true 0 "AllowCommit is not set, so autopilot loop-log/history meta commit was not executed."
    }

    $skippedBaselinePaths = @(
        @($loopLogRelativePath, $goalHistoryRelativePath) |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Where-Object { Test-IsAutopilotBaselineDirtyPath $_ } |
            Select-Object -Unique
    )
    $currentRunMetaPaths = @(
        $loopLogRelativePath,
        $goalHistoryRelativePath
    ) |
        ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
        Where-Object { -not (Test-IsAutopilotBaselineDirtyPath $_) } |
        Select-Object -Unique

    if ($currentRunMetaPaths.Count -eq 0) {
        return New-StepResult $StepNumber "autopilot-meta-commit" $false $true 0 "Autopilot meta commit skipped because all meta files were baseline dirty and protected: $($skippedBaselinePaths -join ', ')"
    }

    $statusOutput = & git status --short -- $currentRunMetaPaths 2>&1 | Out-String
    $statusExitCode = $LASTEXITCODE

    if ($statusExitCode -ne 0) {
        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "git status for autopilot meta files failed. exit code: $statusExitCode`n$statusOutput"
    }

    if (-not (Test-HasValue $statusOutput)) {
        $message = "Autopilot meta files had no changes to commit."
        if ($skippedBaselinePaths.Count -gt 0) {
            $message = "$message Baseline dirty files skipped: $($skippedBaselinePaths -join ', ')"
        }
        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 0 $message
    }

    $addOutput = & git add -- $currentRunMetaPaths 2>&1 | Out-String
    $addExitCode = $LASTEXITCODE

    if ($addExitCode -ne 0) {
        & git restore --staged -- $currentRunMetaPaths 2>&1 | Out-String | Out-Null
        $restoredPaths = @(Restore-AutopilotCurrentRunOperationalChanges $currentRunMetaPaths)
        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot meta files git add failed. exit code: $addExitCode`n$addOutput`nRestored run-owned files: $($restoredPaths -join ', ')"
    }

    $metaCommitMessage = "chore(ai-dev): record autopilot progress"
    $commitOutput = & git commit -m $metaCommitMessage -- $currentRunMetaPaths 2>&1 | Out-String
    $commitExitCode = $LASTEXITCODE

    if ($commitExitCode -ne 0) {
        & git restore --staged -- $currentRunMetaPaths 2>&1 | Out-String | Out-Null
        $restoredPaths = @(Restore-AutopilotCurrentRunOperationalChanges $currentRunMetaPaths)
        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot meta commit failed. exit code: $commitExitCode`n$commitOutput`nRestored run-owned files: $($restoredPaths -join ', ')"
    }

    $remainingStatus = & git status --short -- $currentRunMetaPaths 2>&1 | Out-String
    $remainingStatusExitCode = $LASTEXITCODE

    if ($remainingStatusExitCode -ne 0) {
        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot meta clean verification failed because git status failed. exit code: $remainingStatusExitCode`n$remainingStatus"
    }

    if (Test-HasValue $remainingStatus) {
        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot meta clean verification failed: git status --short still reports meta changes after the autopilot meta commit.`n$remainingStatus"
    }

    $message = ($commitOutput.Trim(), "Baseline dirty files skipped: $($skippedBaselinePaths -join ', ')", "Autopilot meta clean verification: git status --short returned no autopilot meta changes.") -join "`n"
    return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 0 $message
}

function Save-AutopilotFailureState {
    param(
        [string]$StoppedReason,
        [string]$Message
    )

    if ($DryRun) {
        return
    }

    try {
        $state = Read-JsonFile $statePath $stateRelativePath
        $previousReason = if (Test-HasValue $state.stopReason) { [string]$state.stopReason } else { "" }
        $previousRepeatedFailureCount = 0

        if (Test-HasValue $state.repeatedFailureCount) {
            $previousRepeatedFailureCount = [int]$state.repeatedFailureCount
        }

        $nextRepeatedFailureCount = if ($previousReason -eq $StoppedReason) { $previousRepeatedFailureCount + 1 } else { 1 }

        Set-ObjectProperty $state "lastCommand" "autopilot"
        Set-ObjectProperty $state "lastCommandStatus" "failed"
        Set-ObjectProperty $state "lastErrorSummary" $Message
        Set-ObjectProperty $state "repeatedFailureCount" $nextRepeatedFailureCount
        Set-ObjectProperty $state "stopReason" $StoppedReason
        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
        Write-JsonFile $statePath $state
    } catch {
        Write-Warning "Failed to record autopilot failure state: $($_.Exception.Message)"
    }
}

function New-StepResult {
    param(
        [int]$Step,
        [string]$Name,
        [bool]$Executed,
        [bool]$Skipped,
        [int]$ExitCode,
        [string]$Message,
        [object]$GoalCandidate = $null
    )

    return [PSCustomObject][ordered]@{
        step = $Step
        name = $Name
        executed = $Executed
        skipped = $Skipped
        exitCode = $ExitCode
        message = $Message
        goalCandidate = $GoalCandidate
    }
}

function New-AutopilotResult {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode,
        [int]$PreparedGoals,
        [bool]$OperationalCleanupPerformed = $false,
        [bool]$MetaCommitCreated = $false,
        [bool]$NextRunWithoutManualRestore = $false
    )

    $outcomeCategory = if (Test-IsExpectedAutopilotNonWorkStop $StoppedReason) {
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
        maxGoals = $MaxGoals
        preparedGoals = $PreparedGoals
        operationalCleanupPerformed = $OperationalCleanupPerformed
        metaCommitCreated = $MetaCommitCreated
        nextRunWithoutManualRestore = $NextRunWithoutManualRestore
    }
}

function Write-AutopilotResult {
    param([object]$Result)

    if ($Json) {
        $Result | ConvertTo-Json -Depth 30
        return
    }

    foreach ($step in @($Result.steps)) {
        Write-Host "Step $($step.step): $($step.name)"
        Write-Host "  Executed: $($step.executed)"
        Write-Host "  Skipped: $($step.skipped)"
        Write-Host "  Exit code: $($step.exitCode)"
        Write-Host "  Message: $($step.message)"

        if ($null -ne $step.goalCandidate) {
            Write-Host "  Goal candidate: $($step.goalCandidate.title)"
        }
    }

    Write-Host "Stopped reason: $($Result.stoppedReason)"
    Write-Host "Outcome category: $($Result.outcomeCategory)"
    Write-Host "Operational cleanup performed: $($Result.operationalCleanupPerformed)"
    Write-Host "Meta commit created: $($Result.metaCommitCreated)"
    Write-Host "Next run without manual restore: $($Result.nextRunWithoutManualRestore)"
    Write-Host "Completed: $($Result.completed)"
    Write-Host "Prepared goals: $($Result.preparedGoals)/$($Result.maxGoals)"
    Write-Host "Exit code: $($Result.exitCode)"
}

function Stop-Autopilot {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode,
        [int]$PreparedGoals,
        [string]$FailureMessage = ""
    )

    $isExpectedNonWorkStop = Test-IsExpectedAutopilotNonWorkStop $StoppedReason
    $operationalCleanupPerformed = $false
    $metaCommitCreated = $false
    $nextRunWithoutManualRestore = ($ExitCode -eq 0)

    if ($ExitCode -ne 0 -and (Test-HasValue $FailureMessage) -and -not $isExpectedNonWorkStop) {
        Save-AutopilotFailureState $StoppedReason $FailureMessage
        Add-LoopLogEntry "Autopilot stopped" @(
            "- Reason: $StoppedReason",
            "- Result: $FailureMessage",
            "- Prepared goals: $PreparedGoals/$MaxGoals"
        )
    }

    if ($ExitCode -ne 0 -and $isExpectedNonWorkStop -and -not $DryRun) {
        $cleanedRunOwnedPaths = @(Restore-AutopilotCurrentRunOperationalChanges)
        $operationalCleanupPerformed = $true
        $metaCommitMessage = "skipped (-AllowCommit not set)"
        $nextRunWithoutManualRestore = $true
        $skippedBaselineMetaPaths = @(
            @($loopLogRelativePath, $goalHistoryRelativePath) |
                ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
                Where-Object { Test-IsAutopilotBaselineDirtyPath $_ } |
                Select-Object -Unique
        )

        if ($AllowCommit) {
            Add-AutopilotExpectedNonWorkLogEntry $StoppedReason $FailureMessage $PreparedGoals
            $metaCommitStep = Invoke-AutopilotLoopLogMetaCommit ($Steps.Count + 1)
            $metaCommitCreated = ($metaCommitStep.exitCode -eq 0 -and $metaCommitStep.executed -and -not $metaCommitStep.skipped -and $metaCommitStep.message -notmatch 'had no changes to commit')
            $metaCommitMessage = if ($metaCommitCreated) { "created" } else { "not created: $($metaCommitStep.message)" }

            if ($metaCommitStep.exitCode -ne 0) {
                $cleanedRunOwnedPaths = @(Restore-AutopilotCurrentRunOperationalChanges)
                $operationalCleanupPerformed = $true
                $nextRunWithoutManualRestore = $true
                $Steps += $metaCommitStep
                $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-cleanup" $true $false 0 "Classification: expected_non_work. Original stopped reason: $StoppedReason. Baseline dirty files skipped: $($skippedBaselineMetaPaths -join ', '). Cleaned run-owned files: $($cleanedRunOwnedPaths -join ', '). Meta commit created: false. Next run without manual git restore: $nextRunWithoutManualRestore."
                $result = New-AutopilotResult $Steps "autopilot_expected_non_work_meta_commit_failed" $false 1 $PreparedGoals $operationalCleanupPerformed $false $nextRunWithoutManualRestore
                Write-AutopilotResult $result
                exit 1
            }

            $Steps += $metaCommitStep
        }

        $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-cleanup" $true $false 0 "Classification: expected_non_work. Original stopped reason: $StoppedReason. Baseline dirty files skipped: $($skippedBaselineMetaPaths -join ', '). Cleaned run-owned files: $($cleanedRunOwnedPaths -join ', '). Meta commit created: $metaCommitCreated ($metaCommitMessage). Next run without manual git restore: $nextRunWithoutManualRestore. Restored only autopilot operational files captured at run start; baseline user changes were preserved."
    }

    $result = New-AutopilotResult $Steps $StoppedReason $Completed $ExitCode $PreparedGoals $operationalCleanupPerformed $metaCommitCreated $nextRunWithoutManualRestore
    Write-AutopilotResult $result
    exit $ExitCode
}

function Get-CurrentGoalGate {
    $queue = Read-JsonFile $queuePath $queueRelativePath
    $state = Read-JsonFile $statePath $stateRelativePath
    $tasks = @($queue.tasks)
    $openTasks = @($tasks | Where-Object { @("pending", "in_progress", "review_required", "failed", "blocked") -contains ([string]$_.status) })
    $goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { "" }
    $currentTaskId = if (Test-HasValue $state.currentTaskId) { [string]$state.currentTaskId } elseif (Test-HasValue $queue.currentTaskId) { [string]$queue.currentTaskId } else { "" }

    return [PSCustomObject][ordered]@{
        passed = ($goalStatus -eq "completed" -and -not (Test-HasValue $currentTaskId) -and $openTasks.Count -eq 0)
        goalTitle = if (Test-HasValue $queue.goalTitle) { [string]$queue.goalTitle } else { "" }
        goalStatus = $goalStatus
        currentTaskId = $currentTaskId
        openTaskCount = $openTasks.Count
    }
}

function Test-IsUsableBacklogText {
    param([string]$Text)

    if (-not (Test-HasValue $Text)) {
        return $false
    }

    $trimmed = $Text.Trim()

    if ($trimmed.Length -lt 4) {
        return $false
    }

    if ($trimmed -notmatch '[\p{L}\p{N}]') {
        return $false
    }

    return $true
}

function Get-BacklogTitleSuspicionReason {
    param([string]$Text)

    if (-not (Test-IsUsableBacklogText $Text)) {
        return "not_usable"
    }

    $trimmed = $Text.Trim()

    if ($trimmed -match [string][char]0xFFFD) {
        return "contains_replacement_character"
    }

    if ($trimmed -match '\?{2,}') {
        return "contains_repeated_question_marks"
    }

    if ($trimmed.Length -le 80 -and $trimmed -match '[\u4E00-\u9FFF]' -and $trimmed -match '[\uAC00-\uD7A3]') {
        return "mixed_cjk_ideographs_and_hangul_in_short_title"
    }

    $mojibakePattern = '([\u00C2\u00C3\u00E2\u00EC\u00ED\u00EB][\u0080-\u00BF\u00A0-\u00FF]{1,})|(\uC392[\uAC00-\uD7A3])|(\u6FE1\u63F4|\u5A9B\u5AC4|\u8ADB)'

    if ($trimmed -match $mojibakePattern) {
        return "contains_common_mojibake_fragment"
    }

    return ""
}

function Test-IsReadableBacklogText {
    param([string]$Text)

    $reason = Get-BacklogTitleSuspicionReason $Text
    return (-not (Test-HasValue $reason))
}

function Join-UniqueReasons {
    param([string[]]$Reasons)

    $uniqueReasons = @($Reasons | Where-Object { Test-HasValue $_ } | Select-Object -Unique)

    if ($uniqueReasons.Count -eq 0) {
        return ""
    }

    return ($uniqueReasons -join ", ")
}

function New-ReadableBacklogCandidate {
    param(
        [string]$Title,
        [string]$Priority
    )

    $description = "Prepare the smallest actionable development goal from the $Priority backlog item for the current repository state: $Title"

    return [PSCustomObject][ordered]@{
        title = $Title
        description = $description
        priority = $Priority
        source = $backlogRelativePath
        candidateKind = "backlog"
        suspiciousTitleReason = ""
    }
}

function New-UnreadableBacklogCandidate {
    param(
        [string]$Title,
        [string]$Priority,
        [string]$SuspiciousTitleReason
    )

    return [PSCustomObject][ordered]@{
        title = $Title
        priority = $Priority
        source = $backlogRelativePath
        candidateKind = "rejected_backlog"
        suspiciousTitleReason = $SuspiciousTitleReason
    }
}

function New-FallbackBacklogCandidate {
    param(
        [int]$ReadItemCount,
        [int]$FilteredItemCount,
        [int]$ReadableItemCount,
        [int]$UsableItemCount,
        [string]$Why,
        [string]$SuspiciousTitleReason = ""
    )

    $suspicion = if (Test-HasValue $SuspiciousTitleReason) { $SuspiciousTitleReason } else { "none" }
    $reason = "No clean backlog candidate could be generated from file content. backlog=$backlogRelativePath, readItemCount=$ReadItemCount, filteredItemCount=$FilteredItemCount, usableItemCount=$UsableItemCount, readableItemCount=$ReadableItemCount, suspiciousTitleReason=$suspicion. Fallback was used because $Why"

    return [PSCustomObject][ordered]@{
        title = "Prepare the next local autopilot development task"
        description = "Create the smallest safe next goal for the PlanPilot local repository from the current autopilot context. Preserve repository limits, avoid app source changes unless a task explicitly requires them, and keep the current goal completion gate intact."
        priority = "fallback"
        source = $backlogRelativePath
        candidateKind = "fallback"
        suspiciousTitleReason = $suspicion
        fallbackReason = $reason
        fallbackContext = [PSCustomObject][ordered]@{
            backlogPath = $backlogRelativePath
            readItemCount = $ReadItemCount
            filteredItemCount = $FilteredItemCount
            usableItemCount = $UsableItemCount
            readableItemCount = $ReadableItemCount
            suspiciousTitleReason = $suspicion
        }
    }
}

function Get-BacklogCandidates {
    if (-not (Test-Path -LiteralPath $backlogPath -PathType Leaf)) {
        throw "Required backlog file is missing: $backlogRelativePath"
    }

    $lines = @(Get-Content -Encoding UTF8 -LiteralPath $backlogPath)
    $readableCandidates = @()
    $usableCandidates = @()
    $suspiciousTitleReasons = @()
    $readItemCount = 0
    $filteredItemCount = 0
    $priority = ""
    $isBacklogPrioritySection = $false

    foreach ($line in $lines) {
        if ($line -match '^##\s*(P[0-2])\s*$') {
            $priority = $Matches[1]
            $isBacklogPrioritySection = $true
            continue
        }

        if ($line -match '^##\s+') {
            $priority = ""
            $isBacklogPrioritySection = $false
            continue
        }

        if (-not $isBacklogPrioritySection) {
            continue
        }

        if ($line -notmatch '^\s*-\s+(.+)$') {
            continue
        }

        $title = $Matches[1].Trim()
        $readItemCount++

        if (-not (Test-IsUsableBacklogText $title)) {
            $filteredItemCount++
            continue
        }

        $suspiciousTitleReason = Get-BacklogTitleSuspicionReason $title

        if (Test-HasValue $suspiciousTitleReason) {
            $usableCandidates += New-UnreadableBacklogCandidate $title $priority $suspiciousTitleReason
            $suspiciousTitleReasons += $suspiciousTitleReason
            $filteredItemCount++
            continue
        }

        $candidate = New-ReadableBacklogCandidate $title $priority
        $usableCandidates += $candidate
        $readableCandidates += $candidate
    }

    if ($readableCandidates.Count -gt 0) {
        return @($readableCandidates)
    }

    $joinedSuspiciousTitleReasons = Join-UniqueReasons $suspiciousTitleReasons

    if ($usableCandidates.Count -gt 0) {
        $fallbackWhy = "the backlog items were usable but no clean, readable title was available for a generated goal title."
        $fallback = New-FallbackBacklogCandidate $readItemCount $filteredItemCount $readableCandidates.Count $usableCandidates.Count $fallbackWhy $joinedSuspiciousTitleReasons
        return @($fallback)
    }

    $fallbackReason = if ($readItemCount -eq 0) {
        "the backlog priority sections did not contain bullet items."
    } else {
        "all backlog bullet items were empty, too short, or did not contain letters or numbers."
    }

    $fallbackCandidate = New-FallbackBacklogCandidate $readItemCount $filteredItemCount $readableCandidates.Count $usableCandidates.Count $fallbackReason $joinedSuspiciousTitleReasons
    return @($fallbackCandidate)
}

function Add-UniqueTitle {
    param(
        [string[]]$Titles,
        [string]$Title
    )

    if (-not (Test-HasValue $Title)) {
        return @($Titles)
    }

    $trimmedTitle = $Title.Trim()

    if ($Titles -contains $trimmedTitle) {
        return @($Titles)
    }

    return @($Titles + $trimmedTitle)
}

function Get-PreparedGoalTitlesFromLoopLog {
    if (-not (Test-Path -LiteralPath $loopLogPath -PathType Leaf)) {
        return @()
    }

    $titles = @()
    $isAutopilotPreparedEntry = $false
    $lines = @(Get-Content -Encoding UTF8 -LiteralPath $loopLogPath)

    foreach ($line in $lines) {
        if ($line -match '^##\s+.+\s+-\s+(.+)$') {
            $isAutopilotPreparedEntry = ($Matches[1].Trim() -eq "Autopilot goal prepared")
            continue
        }

        if (-not $isAutopilotPreparedEntry) {
            continue
        }

        if ($line -match '^\s*-\s+Goal:\s+(.+)$') {
            $titles = @(Add-UniqueTitle $titles $Matches[1])
        }
    }

    return @($titles)
}

function Get-CompletedCurrentGoalTitleFromQueueState {
    $queue = Read-JsonFile $queuePath $queueRelativePath
    $state = Read-JsonFile $statePath $stateRelativePath
    $goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { "" }

    if ($goalStatus -ne "completed") {
        return @()
    }

    if (-not (Test-HasValue $queue.goalTitle)) {
        return @()
    }

    return @([string]$queue.goalTitle)
}

function Get-HistoricalGoalTitles {
    $titles = @()

    foreach ($title in @(Get-PreparedGoalTitlesFromLoopLog)) {
        $titles = @(Add-UniqueTitle $titles $title)
    }

    foreach ($title in @(Get-CompletedCurrentGoalTitleFromQueueState)) {
        $titles = @(Add-UniqueTitle $titles $title)
    }

    foreach ($title in @(Get-AutopilotGoalHistoryTitles)) {
        $titles = @(Add-UniqueTitle $titles $title)
    }

    return @($titles)
}

function Get-ExcludedGoalTitles {
    param(
        [string[]]$UsedTitles,
        [object]$Gate
    )

    $titles = @()

    foreach ($title in @($UsedTitles)) {
        $titles = @(Add-UniqueTitle $titles $title)
    }

    if ($null -ne $Gate -and (Test-HasValue $Gate.goalTitle)) {
        $titles = @(Add-UniqueTitle $titles ([string]$Gate.goalTitle))
    }

    foreach ($title in @(Get-HistoricalGoalTitles)) {
        $titles = @(Add-UniqueTitle $titles $title)
    }

    return @($titles)
}

function Format-ExcludedGoalTitles {
    param([string[]]$Titles)

    $filteredTitles = @($Titles | Where-Object { Test-HasValue $_ } | Select-Object -Unique)

    if ($filteredTitles.Count -eq 0) {
        return "none"
    }

    return ($filteredTitles -join "; ")
}

function Invoke-AutoGoal {
    param(
        [object]$Candidate,
        [int]$StepNumber
    )

    $autoGoalPath = Join-Path $PSScriptRoot "ai-dev-auto-goal.ps1"

    if (-not (Test-Path -LiteralPath $autoGoalPath -PathType Leaf)) {
        throw "Required script is missing: scripts/ai-dev-auto-goal.ps1"
    }

    $arguments = @(
        "-GoalTitle", [string]$Candidate.title,
        "-GoalDescription", [string]$Candidate.description,
        "-MaxTasks", [string]$MaxTasks,
        "-MaxSteps", [string]$MaxSteps
    )

    if ($DryRun) {
        $arguments += "-DryRun"
    }

    if ($Json) {
        $arguments += "-Json"
    }

    if ($AllowRun) {
        $arguments += "-AllowRun"
    }

    if ($AllowCodex) {
        $arguments += "-AllowCodex"
    }

    if ($AllowReviewCodex) {
        $arguments += "-AllowReviewCodex"
    }

    if ($AllowCommit) {
        $arguments += "-AllowCommit"
    }

    if ($AllowDirty) {
        $arguments += "-AllowDirty"
    }

    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { Test-HasValue $_ })

        if ($normalizedFiles.Count -gt 0) {
            $arguments += "-CommitFiles"
            $arguments += ($normalizedFiles -join ",")
        }
    }

    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File $autoGoalPath @arguments 2>&1 | Out-String
    $exitCode = $LASTEXITCODE
    $message = $output.Trim()

    if (-not (Test-HasValue $message)) {
        $message = "ai-dev-auto-goal.ps1 completed without output."
    }

    return New-StepResult $StepNumber "auto-goal" $true $false $exitCode $message $Candidate
}

Set-Location $repoRoot
$script:autopilotBaselineDirtyPaths = @(Get-AutopilotBaselineDirtyPaths)
Initialize-AutopilotOperationalFileSnapshots

$steps = @()
$preparedGoals = 0
$usedTitles = @()
$durableHistoryTitles = @()

if ($MaxGoals -lt 1) {
    $message = "MaxGoals must be at least 1."
    $steps += New-StepResult 0 "validate-input" $false $false 1 $message
    Stop-Autopilot $steps "max_goals_must_be_at_least_1" $false 1 $preparedGoals $message
}

if ($MaxTasks -lt 1) {
    $message = "MaxTasks must be at least 1."
    $steps += New-StepResult 0 "validate-input" $false $false 1 $message
    Stop-Autopilot $steps "max_tasks_must_be_at_least_1" $false 1 $preparedGoals $message
}

if ($MaxSteps -lt 1) {
    $message = "MaxSteps must be at least 1."
    $steps += New-StepResult 0 "validate-input" $false $false 1 $message
    Stop-Autopilot $steps "max_steps_must_be_at_least_1" $false 1 $preparedGoals $message
}

foreach ($requiredPath in @($goalPath, $queuePath, $statePath, $backlogPath)) {
    if (-not (Test-Path -LiteralPath $requiredPath -PathType Leaf)) {
        $message = "Required file is missing: $requiredPath"
        $steps += New-StepResult 0 "prepare" $false $false 1 $message
        Stop-Autopilot $steps "required_file_missing" $false 1 $preparedGoals $message
    }
}

$steps += New-StepResult 1 "validate-input" $false $false 0 "Autopilot input validation completed. MaxGoals=$MaxGoals, MaxTasks=$MaxTasks, MaxSteps=$MaxSteps"

for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
    try {
        $gate = Get-CurrentGoalGate
    } catch {
        $message = $_.Exception.Message
        $steps += New-StepResult ($steps.Count + 1) "current-goal-gate" $false $false 1 $message
        Stop-Autopilot $steps "current_goal_gate_failed" $false 1 $preparedGoals $message
    }

    if (-not $gate.passed) {
        $message = "Current goal is not completed, so autopilot will not create the next goal. goalStatus=$($gate.goalStatus), currentTaskId=$($gate.currentTaskId), openTaskCount=$($gate.openTaskCount)"
        $steps += New-StepResult ($steps.Count + 1) "current-goal-gate" $false $true 1 $message
        Stop-Autopilot $steps "current_goal_not_completed" $false 1 $preparedGoals $message
    }

    $steps += New-StepResult ($steps.Count + 1) "current-goal-gate" $false $false 0 "Current goal is completed. Previous goal: $($gate.goalTitle)"

    try {
        Add-AutopilotGoalHistoryTitle ([string]$gate.goalTitle) "completed"
    } catch {
        $message = $_.Exception.Message
        $steps += New-StepResult ($steps.Count + 1) "goal-history" $false $false 1 $message
        Stop-Autopilot $steps "goal_history_update_failed" $false 1 $preparedGoals $message
    }

    try {
        $excludedTitles = @(Get-ExcludedGoalTitles $usedTitles $gate)
        $durableHistoryTitles = @(Get-AutopilotGoalHistoryTitles)
        $allCandidates = @(Get-BacklogCandidates)
        $candidates = @($allCandidates | Where-Object { $excludedTitles -notcontains ([string]$_.title) })
    } catch {
        $message = $_.Exception.Message
        $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $false 1 $message
        Stop-Autopilot $steps "goal_candidate_generation_failed" $false 1 $preparedGoals $message
    }

    if ($candidates.Count -eq 0) {
        $excludedTitleSummary = Format-ExcludedGoalTitles $excludedTitles
        $candidateTitles = @($allCandidates | ForEach-Object { [string]$_.title } | Where-Object { Test-HasValue $_ } | Select-Object -Unique)
        $candidateTitleSummary = Format-ExcludedGoalTitles $candidateTitles
        $historyTitleSummary = Format-ExcludedGoalTitles $durableHistoryTitles
        $candidateCount = $allCandidates.Count
        $excludedCandidateCount = @($allCandidates | Where-Object { $excludedTitles -contains ([string]$_.title) }).Count
        $currentGoalTitle = if (Test-HasValue $gate.goalTitle) { [string]$gate.goalTitle } else { "none" }

        if ($allCandidates.Count -gt 0) {
            $message = "Autopilot 후보가 모두 소진되었습니다. 현재 상태: goalStatus=$($gate.goalStatus), currentTaskId=$($gate.currentTaskId), openTaskCount=$($gate.openTaskCount), currentGoal=$currentGoalTitle. 제외된 backlog 후보 수: $excludedCandidateCount/$candidateCount. 모든 후보가 현재 goal, 준비 이력, 완료 이력 또는 durable history와 중복되어 신규 goal을 자동 생성하지 않습니다. 다음 행동: 1. .ai-dev/backlog.md에 새로운 backlog 항목을 추가합니다. 2. 이미 완료된 후보를 다시 진행해야 한다면 durable history와 완료 이력을 사람이 먼저 검토합니다. 3. 지금은 자동 진행을 멈추고 현재 상태를 유지합니다. 계속 진행하려면 새 backlog 항목이 필요합니다. 제외된 후보: $candidateTitleSummary. 제외 기준 title: $excludedTitleSummary. Durable history title: $historyTitleSummary."
            $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $true 1 $message
            Stop-Autopilot $steps "all_goal_candidates_excluded" $false 1 $preparedGoals $message
        }

        $message = "No actionable next goal candidate was found in the backlog after excluding current, prepared, completed, or durable history goal titles. Excluded goal titles: $excludedTitleSummary. Durable history goal titles: $historyTitleSummary. Check backlog encoding, empty items, completed or deferred sections, and duplicate backlog titles."
        $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $true 1 $message
        Stop-Autopilot $steps "goal_candidate_not_found" $false 1 $preparedGoals $message
    }

    $candidate = $candidates | Select-Object -First 1
    $usedTitles += [string]$candidate.title
    $candidateMessage = "Next goal candidate generated from $($candidate.source) priority $($candidate.priority)."

    try {
        Add-AutopilotGoalHistoryTitle ([string]$candidate.title) "selected"
    } catch {
        $message = $_.Exception.Message
        $steps += New-StepResult ($steps.Count + 1) "goal-history" $false $false 1 $message $candidate
        Stop-Autopilot $steps "goal_history_update_failed" $false 1 $preparedGoals $message
    }

    if (Test-HasValue $candidate.fallbackReason) {
        $candidateMessage = "$candidateMessage $($candidate.fallbackReason)"
    }

    $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $false 0 $candidateMessage $candidate

    if ($AllowCommit) {
        $metaCommitStep = Invoke-AutopilotLoopLogMetaCommit ($steps.Count + 1)
        $steps += $metaCommitStep

        if ($metaCommitStep.exitCode -ne 0) {
            Stop-Autopilot $steps "autopilot_meta_commit_failed" $false 1 $preparedGoals $metaCommitStep.message
        }
    }

    try {
        $autoGoalStep = Invoke-AutoGoal $candidate ($steps.Count + 1)
    } catch {
        $message = "Auto-goal failed before completion: $($_.Exception.Message)"
        $steps += New-StepResult ($steps.Count + 1) "auto-goal" $false $false 1 $message $candidate
        Stop-Autopilot $steps "auto_goal_failed" $false 1 $preparedGoals $message
    }

    $steps += $autoGoalStep

    if ($autoGoalStep.exitCode -ne 0) {
        $childStoppedReason = Get-StoppedReasonFromOutput $autoGoalStep.message
        $stoppedReason = if (Test-IsExpectedAutopilotNonWorkStop $childStoppedReason) { $childStoppedReason } else { "auto_goal_failed" }
        $failureMessage = "Auto-goal failed with exit code $($autoGoalStep.exitCode): $($autoGoalStep.message)"

        if (Test-HasValue $candidate.fallbackReason) {
            $failureMessage = "$failureMessage Fallback context: $($candidate.fallbackReason)"
        }

        Stop-Autopilot $steps $stoppedReason $false 1 $preparedGoals $failureMessage
    }

    $preparedGoals++
    $loopLogLines = @(
        "- Goal: $($candidate.title)",
        "- Source: $($candidate.source) / $($candidate.priority)",
        "- Prepared goals: $preparedGoals/$MaxGoals"
    )

    if (Test-HasValue $candidate.fallbackReason) {
        $loopLogLines += "- Fallback reason: $($candidate.fallbackReason)"
    }

    try {
        Add-AutopilotGoalHistoryTitle ([string]$candidate.title) "prepared"
    } catch {
        $message = $_.Exception.Message
        $steps += New-StepResult ($steps.Count + 1) "goal-history" $false $false 1 $message $candidate
        Stop-Autopilot $steps "goal_history_update_failed" $false 1 $preparedGoals $message
    }

    Add-LoopLogEntry "Autopilot goal prepared" $loopLogLines

    if ($AllowCommit) {
        $metaCommitStep = Invoke-AutopilotLoopLogMetaCommit ($steps.Count + 1)
        $steps += $metaCommitStep

        if ($metaCommitStep.exitCode -ne 0) {
            Stop-Autopilot $steps "autopilot_meta_commit_failed" $false 1 $preparedGoals $metaCommitStep.message
        }
    }

    if (-not ($AllowRun -or $AllowCodex -or $AllowReviewCodex -or $AllowCommit)) {
        Stop-Autopilot $steps "prepared_without_full_cycle" $true 0 $preparedGoals
    }
}

Stop-Autopilot $steps "max_goals_reached" $true 0 $preparedGoals
