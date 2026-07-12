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
$goalPath = Join-Path $repoRoot $goalRelativePath
$queuePath = Join-Path $repoRoot $queueRelativePath
$statePath = Join-Path $repoRoot $stateRelativePath
$backlogPath = Join-Path $repoRoot $backlogRelativePath
$loopLogPath = Join-Path $repoRoot $loopLogRelativePath
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)

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

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $entryLines = @("", "## $timestamp - $Title", "")
    $entryLines += @($Lines)
    $entryLines += ""
    [System.IO.File]::AppendAllText($loopLogPath, ($entryLines -join "`r`n"), $utf8WithBom)
}

function Invoke-AutopilotLoopLogMetaCommit {
    param([int]$StepNumber)

    if ($DryRun) {
        return New-StepResult $StepNumber "autopilot-meta-commit" $false $true 0 "DryRun: autopilot loop-log meta commit was not executed."
    }

    if (-not $AllowCommit) {
        return New-StepResult $StepNumber "autopilot-meta-commit" $false $true 0 "AllowCommit is not set, so autopilot loop-log meta commit was not executed."
    }

    $statusOutput = & git status --short -- $loopLogRelativePath 2>&1 | Out-String
    $statusExitCode = $LASTEXITCODE

    if ($statusExitCode -ne 0) {
        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "git status for autopilot loop-log failed. exit code: $statusExitCode`n$statusOutput"
    }

    if (-not (Test-HasValue $statusOutput)) {
        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 0 "Autopilot loop-log had no changes to commit."
    }

    $addOutput = & git add -- $loopLogRelativePath 2>&1 | Out-String
    $addExitCode = $LASTEXITCODE

    if ($addExitCode -ne 0) {
        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot loop-log git add failed. exit code: $addExitCode`n$addOutput"
    }

    $metaCommitMessage = "chore(ai-dev): record autopilot progress"
    $commitOutput = & git commit -m $metaCommitMessage -- $loopLogRelativePath 2>&1 | Out-String
    $commitExitCode = $LASTEXITCODE

    if ($commitExitCode -ne 0) {
        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot loop-log meta commit failed. exit code: $commitExitCode`n$commitOutput"
    }

    $remainingStatus = & git status --short 2>&1 | Out-String
    $remainingStatusExitCode = $LASTEXITCODE

    if ($remainingStatusExitCode -ne 0) {
        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot final clean verification failed because git status failed. exit code: $remainingStatusExitCode`n$remainingStatus"
    }

    if (Test-HasValue $remainingStatus) {
        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot final clean verification failed: git status --short still reports changes after the loop-log meta commit.`n$remainingStatus"
    }

    $message = ($commitOutput.Trim(), "Autopilot final clean verification: git status --short returned no changes.") -join "`n"
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
        [int]$PreparedGoals
    )

    return [PSCustomObject][ordered]@{
        steps = @($Steps)
        stoppedReason = $StoppedReason
        completed = $Completed
        exitCode = $ExitCode
        maxGoals = $MaxGoals
        preparedGoals = $PreparedGoals
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

    if ($ExitCode -ne 0 -and (Test-HasValue $FailureMessage)) {
        Save-AutopilotFailureState $StoppedReason $FailureMessage
        Add-LoopLogEntry "Autopilot stopped" @(
            "- Reason: $StoppedReason",
            "- Result: $FailureMessage",
            "- Prepared goals: $PreparedGoals/$MaxGoals"
        )
    }

    $result = New-AutopilotResult $Steps $StoppedReason $Completed $ExitCode $PreparedGoals
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

    $output = & powershell -ExecutionPolicy Bypass -File $autoGoalPath @arguments 2>&1 | Out-String
    $exitCode = $LASTEXITCODE
    $message = $output.Trim()

    if (-not (Test-HasValue $message)) {
        $message = "ai-dev-auto-goal.ps1 completed without output."
    }

    return New-StepResult $StepNumber "auto-goal" $true $false $exitCode $message $Candidate
}

Set-Location $repoRoot

$steps = @()
$preparedGoals = 0
$usedTitles = @()

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
        $excludedTitles = @(Get-ExcludedGoalTitles $usedTitles $gate)
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

        if ($allCandidates.Count -gt 0) {
            $message = "All backlog goal candidates were already completed or prepared, so autopilot will not create a duplicate goal. Excluded goal titles: $excludedTitleSummary. Candidate goal titles: $candidateTitleSummary."
            $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $true 1 $message
            Stop-Autopilot $steps "all_goal_candidates_excluded" $false 1 $preparedGoals $message
        }

        $message = "No actionable next goal candidate was found in the backlog after excluding current, prepared, or completed goal titles. Excluded goal titles: $excludedTitleSummary. Check backlog encoding, empty items, completed or deferred sections, and duplicate backlog titles."
        $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $true 1 $message
        Stop-Autopilot $steps "goal_candidate_not_found" $false 1 $preparedGoals $message
    }

    $candidate = $candidates | Select-Object -First 1
    $usedTitles += [string]$candidate.title
    $candidateMessage = "Next goal candidate generated from $($candidate.source) priority $($candidate.priority)."

    if (Test-HasValue $candidate.fallbackReason) {
        $candidateMessage = "$candidateMessage $($candidate.fallbackReason)"
    }

    $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $false 0 $candidateMessage $candidate

    try {
        $autoGoalStep = Invoke-AutoGoal $candidate ($steps.Count + 1)
    } catch {
        $message = "Auto-goal failed before completion: $($_.Exception.Message)"
        $steps += New-StepResult ($steps.Count + 1) "auto-goal" $false $false 1 $message $candidate
        Stop-Autopilot $steps "auto_goal_failed" $false 1 $preparedGoals $message
    }

    $steps += $autoGoalStep

    if ($autoGoalStep.exitCode -ne 0) {
        $failureMessage = "Auto-goal failed with exit code $($autoGoalStep.exitCode): $($autoGoalStep.message)"

        if (Test-HasValue $candidate.fallbackReason) {
            $failureMessage = "$failureMessage Fallback context: $($candidate.fallbackReason)"
        }

        Stop-Autopilot $steps "auto_goal_failed" $false 1 $preparedGoals $failureMessage
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
