# AI Dev Diff

## Generated At

2026-07-08 23:25:20

## Git Status

```text
 M .ai-dev/README.md
 M .ai-dev/codex-result.md
 M .ai-dev/codex-review-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/diff.md
 M .ai-dev/loop-log.md
 M .ai-dev/review-prompt.md
 M .ai-dev/review-response.json
 M .ai-dev/review.md
 M .ai-dev/revise-prompt.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 A scripts/ai-dev-autopilot.ps1
```

## App Change Files

- scripts/ai-dev-autopilot.ps1

## AI Dev Operational Artifact Files

- .ai-dev/README.md
- .ai-dev/codex-result.md
- .ai-dev/codex-review-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/diff.md
- .ai-dev/loop-log.md
- .ai-dev/review-prompt.md
- .ai-dev/review-response.json
- .ai-dev/review.md
- .ai-dev/revise-prompt.md
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-autopilot.ps1 | 639 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 639 insertions(+)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-autopilot.ps1 b/scripts/ai-dev-autopilot.ps1
new file mode 100644
index 0000000..cd4812c
--- /dev/null
+++ b/scripts/ai-dev-autopilot.ps1
@@ -0,0 +1,639 @@
+param(
+    [int]$MaxGoals = 1,
+    [int]$MaxTasks = 1,
+    [int]$MaxSteps = 22,
+    [switch]$DryRun,
+    [switch]$Json,
+    [switch]$AllowRun,
+    [switch]$AllowCodex,
+    [switch]$AllowReviewCodex,
+    [switch]$AllowCommit,
+    [switch]$AllowDirty,
+    [string[]]$CommitFiles
+)
+
+. "$PSScriptRoot\ai-dev-env.ps1"
+
+$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
+$goalRelativePath = ".ai-dev/goal.md"
+$queueRelativePath = ".ai-dev/queue.json"
+$stateRelativePath = ".ai-dev/state.json"
+$backlogRelativePath = ".ai-dev/backlog.md"
+$loopLogRelativePath = ".ai-dev/loop-log.md"
+$goalPath = Join-Path $repoRoot $goalRelativePath
+$queuePath = Join-Path $repoRoot $queueRelativePath
+$statePath = Join-Path $repoRoot $stateRelativePath
+$backlogPath = Join-Path $repoRoot $backlogRelativePath
+$loopLogPath = Join-Path $repoRoot $loopLogRelativePath
+$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
+
+function Test-HasValue {
+    param([object]$Value)
+
+    if ($null -eq $Value) {
+        return $false
+    }
+
+    if ($Value -is [string]) {
+        return -not [string]::IsNullOrWhiteSpace($Value)
+    }
+
+    return $true
+}
+
+function Read-JsonFile {
+    param(
+        [string]$Path,
+        [string]$RelativePath
+    )
+
+    try {
+        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | ConvertFrom-Json
+    } catch {
+        throw "Failed to parse JSON file $($RelativePath): $($_.Exception.Message)"
+    }
+}
+
+function Write-JsonFile {
+    param(
+        [string]$Path,
+        [object]$Value
+    )
+
+    $json = $Value | ConvertTo-Json -Depth 20
+    [System.IO.File]::WriteAllText($Path, $json, $utf8WithBom)
+}
+
+function Set-ObjectProperty {
+    param(
+        [object]$InputObject,
+        [string]$Name,
+        [object]$Value
+    )
+
+    if ($InputObject.PSObject.Properties.Name -contains $Name) {
+        $InputObject.$Name = $Value
+    } else {
+        $InputObject | Add-Member -NotePropertyName $Name -NotePropertyValue $Value
+    }
+}
+
+function Add-LoopLogEntry {
+    param(
+        [string]$Title,
+        [string[]]$Lines
+    )
+
+    if ($DryRun) {
+        return
+    }
+
+    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
+    $entryLines = @("", "## $timestamp - $Title", "")
+    $entryLines += @($Lines)
+    $entryLines += ""
+    [System.IO.File]::AppendAllText($loopLogPath, ($entryLines -join "`r`n"), $utf8WithBom)
+}
+
+function Save-AutopilotFailureState {
+    param(
+        [string]$StoppedReason,
+        [string]$Message
+    )
+
+    if ($DryRun) {
+        return
+    }
+
+    try {
+        $state = Read-JsonFile $statePath $stateRelativePath
+        $previousReason = if (Test-HasValue $state.stopReason) { [string]$state.stopReason } else { "" }
+        $previousRepeatedFailureCount = 0
+
+        if (Test-HasValue $state.repeatedFailureCount) {
+            $previousRepeatedFailureCount = [int]$state.repeatedFailureCount
+        }
+
+        $nextRepeatedFailureCount = if ($previousReason -eq $StoppedReason) { $previousRepeatedFailureCount + 1 } else { 1 }
+
+        Set-ObjectProperty $state "lastCommand" "autopilot"
+        Set-ObjectProperty $state "lastCommandStatus" "failed"
+        Set-ObjectProperty $state "lastErrorSummary" $Message
+        Set-ObjectProperty $state "repeatedFailureCount" $nextRepeatedFailureCount
+        Set-ObjectProperty $state "stopReason" $StoppedReason
+        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
+        Write-JsonFile $statePath $state
+    } catch {
+        Write-Warning "Failed to record autopilot failure state: $($_.Exception.Message)"
+    }
+}
+
+function New-StepResult {
+    param(
+        [int]$Step,
+        [string]$Name,
+        [bool]$Executed,
+        [bool]$Skipped,
+        [int]$ExitCode,
+        [string]$Message,
+        [object]$GoalCandidate = $null
+    )
+
+    return [PSCustomObject][ordered]@{
+        step = $Step
+        name = $Name
+        executed = $Executed
+        skipped = $Skipped
+        exitCode = $ExitCode
+        message = $Message
+        goalCandidate = $GoalCandidate
+    }
+}
+
+function New-AutopilotResult {
+    param(
+        [object[]]$Steps,
+        [string]$StoppedReason,
+        [bool]$Completed,
+        [int]$ExitCode,
+        [int]$PreparedGoals
+    )
+
+    return [PSCustomObject][ordered]@{
+        steps = @($Steps)
+        stoppedReason = $StoppedReason
+        completed = $Completed
+        exitCode = $ExitCode
+        maxGoals = $MaxGoals
+        preparedGoals = $PreparedGoals
+    }
+}
+
+function Write-AutopilotResult {
+    param([object]$Result)
+
+    if ($Json) {
+        $Result | ConvertTo-Json -Depth 30
+        return
+    }
+
+    foreach ($step in @($Result.steps)) {
+        Write-Host "Step $($step.step): $($step.name)"
+        Write-Host "  Executed: $($step.executed)"
+        Write-Host "  Skipped: $($step.skipped)"
+        Write-Host "  Exit code: $($step.exitCode)"
+        Write-Host "  Message: $($step.message)"
+
+        if ($null -ne $step.goalCandidate) {
+            Write-Host "  Goal candidate: $($step.goalCandidate.title)"
+        }
+    }
+
+    Write-Host "Stopped reason: $($Result.stoppedReason)"
+    Write-Host "Completed: $($Result.completed)"
+    Write-Host "Prepared goals: $($Result.preparedGoals)/$($Result.maxGoals)"
+    Write-Host "Exit code: $($Result.exitCode)"
+}
+
+function Stop-Autopilot {
+    param(
+        [object[]]$Steps,
+        [string]$StoppedReason,
+        [bool]$Completed,
+        [int]$ExitCode,
+        [int]$PreparedGoals,
+        [string]$FailureMessage = ""
+    )
+
+    if ($ExitCode -ne 0 -and (Test-HasValue $FailureMessage)) {
+        Save-AutopilotFailureState $StoppedReason $FailureMessage
+        Add-LoopLogEntry "Autopilot stopped" @(
+            "- Reason: $StoppedReason",
+            "- Result: $FailureMessage",
+            "- Prepared goals: $PreparedGoals/$MaxGoals"
+        )
+    }
+
+    $result = New-AutopilotResult $Steps $StoppedReason $Completed $ExitCode $PreparedGoals
+    Write-AutopilotResult $result
+    exit $ExitCode
+}
+
+function Get-CurrentGoalGate {
+    $queue = Read-JsonFile $queuePath $queueRelativePath
+    $state = Read-JsonFile $statePath $stateRelativePath
+    $tasks = @($queue.tasks)
+    $openTasks = @($tasks | Where-Object { @("pending", "in_progress", "review_required", "failed", "blocked") -contains ([string]$_.status) })
+    $goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { "" }
+    $currentTaskId = if (Test-HasValue $state.currentTaskId) { [string]$state.currentTaskId } elseif (Test-HasValue $queue.currentTaskId) { [string]$queue.currentTaskId } else { "" }
+
+    return [PSCustomObject][ordered]@{
+        passed = ($goalStatus -eq "completed" -and -not (Test-HasValue $currentTaskId) -and $openTasks.Count -eq 0)
+        goalTitle = if (Test-HasValue $queue.goalTitle) { [string]$queue.goalTitle } else { "" }
+        goalStatus = $goalStatus
+        currentTaskId = $currentTaskId
+        openTaskCount = $openTasks.Count
+    }
+}
+
+function Test-IsUsableBacklogText {
+    param([string]$Text)
+
+    if (-not (Test-HasValue $Text)) {
+        return $false
+    }
+
+    $trimmed = $Text.Trim()
+
+    if ($trimmed.Length -lt 4) {
+        return $false
+    }
+
+    if ($trimmed -notmatch '[\p{L}\p{N}]') {
+        return $false
+    }
+
+    return $true
+}
+
+function Get-BacklogTitleSuspicionReason {
+    param([string]$Text)
+
+    if (-not (Test-IsUsableBacklogText $Text)) {
+        return "not_usable"
+    }
+
+    $trimmed = $Text.Trim()
+
+    if ($trimmed -match [string][char]0xFFFD) {
+        return "contains_replacement_character"
+    }
+
+    if ($trimmed -match '\?{2,}') {
+        return "contains_repeated_question_marks"
+    }
+
+    if ($trimmed.Length -le 80 -and $trimmed -match '[\u4E00-\u9FFF]' -and $trimmed -match '[\uAC00-\uD7A3]') {
+        return "mixed_cjk_ideographs_and_hangul_in_short_title"
+    }
+
+    $mojibakePattern = '([\u00C2\u00C3\u00E2\u00EC\u00ED\u00EB][\u0080-\u00BF\u00A0-\u00FF]{1,})|(\uC392[\uAC00-\uD7A3])|(\u6FE1\u63F4|\u5A9B\u5AC4|\u8ADB)'
+
+    if ($trimmed -match $mojibakePattern) {
+        return "contains_common_mojibake_fragment"
+    }
+
+    return ""
+}
+
+function Test-IsReadableBacklogText {
+    param([string]$Text)
+
+    $reason = Get-BacklogTitleSuspicionReason $Text
+    return (-not (Test-HasValue $reason))
+}
+
+function Join-UniqueReasons {
+    param([string[]]$Reasons)
+
+    $uniqueReasons = @($Reasons | Where-Object { Test-HasValue $_ } | Select-Object -Unique)
+
+    if ($uniqueReasons.Count -eq 0) {
+        return ""
+    }
+
+    return ($uniqueReasons -join ", ")
+}
+
+function New-ReadableBacklogCandidate {
+    param(
+        [string]$Title,
+        [string]$Priority
+    )
+
+    $description = "Prepare the smallest actionable development goal from the $Priority backlog item for the current repository state: $Title"
+
+    return [PSCustomObject][ordered]@{
+        title = $Title
+        description = $description
+        priority = $Priority
+        source = $backlogRelativePath
+        candidateKind = "backlog"
+        suspiciousTitleReason = ""
+    }
+}
+
+function New-UnreadableBacklogCandidate {
+    param(
+        [string]$Title,
+        [string]$Priority,
+        [string]$SuspiciousTitleReason
+    )
+
+    return [PSCustomObject][ordered]@{
+        title = $Title
+        priority = $Priority
+        source = $backlogRelativePath
+        candidateKind = "rejected_backlog"
+        suspiciousTitleReason = $SuspiciousTitleReason
+    }
+}
+
+function New-FallbackBacklogCandidate {
+    param(
+        [int]$ReadItemCount,
+        [int]$FilteredItemCount,
+        [int]$ReadableItemCount,
+        [int]$UsableItemCount,
+        [string]$Why,
+        [string]$SuspiciousTitleReason = ""
+    )
+
+    $suspicion = if (Test-HasValue $SuspiciousTitleReason) { $SuspiciousTitleReason } else { "none" }
+    $reason = "No clean backlog candidate could be generated from file content. backlog=$backlogRelativePath, readItemCount=$ReadItemCount, filteredItemCount=$FilteredItemCount, usableItemCount=$UsableItemCount, readableItemCount=$ReadableItemCount, suspiciousTitleReason=$suspicion. Fallback was used because $Why"
+
+    return [PSCustomObject][ordered]@{
+        title = "Prepare the next local autopilot development task"
+        description = "Create the smallest safe next goal for the PlanPilot local repository from the current autopilot context. Preserve repository limits, avoid app source changes unless a task explicitly requires them, and keep the current goal completion gate intact."
+        priority = "fallback"
+        source = $backlogRelativePath
+        candidateKind = "fallback"
+        suspiciousTitleReason = $suspicion
+        fallbackReason = $reason
+        fallbackContext = [PSCustomObject][ordered]@{
+            backlogPath = $backlogRelativePath
+            readItemCount = $ReadItemCount
+            filteredItemCount = $FilteredItemCount
+            usableItemCount = $UsableItemCount
+            readableItemCount = $ReadableItemCount
+            suspiciousTitleReason = $suspicion
+        }
+    }
+}
+
+function Get-BacklogCandidates {
+    if (-not (Test-Path -LiteralPath $backlogPath -PathType Leaf)) {
+        throw "Required backlog file is missing: $backlogRelativePath"
+    }
+
+    $lines = @(Get-Content -Encoding UTF8 -LiteralPath $backlogPath)
+    $readableCandidates = @()
+    $usableCandidates = @()
+    $suspiciousTitleReasons = @()
+    $readItemCount = 0
+    $filteredItemCount = 0
+    $priority = ""
+    $isBacklogPrioritySection = $false
+
+    foreach ($line in $lines) {
+        if ($line -match '^##\s*(P[0-2])\s*$') {
+            $priority = $Matches[1]
+            $isBacklogPrioritySection = $true
+            continue
+        }
+
+        if ($line -match '^##\s+') {
+            $priority = ""
+            $isBacklogPrioritySection = $false
+            continue
+        }
+
+        if (-not $isBacklogPrioritySection) {
+            continue
+        }
+
+        if ($line -notmatch '^\s*-\s+(.+)$') {
+            continue
+        }
+
+        $title = $Matches[1].Trim()
+        $readItemCount++
+
+        if (-not (Test-IsUsableBacklogText $title)) {
+            $filteredItemCount++
+            continue
+        }
+
+        $suspiciousTitleReason = Get-BacklogTitleSuspicionReason $title
+
+        if (Test-HasValue $suspiciousTitleReason) {
+            $usableCandidates += New-UnreadableBacklogCandidate $title $priority $suspiciousTitleReason
+            $suspiciousTitleReasons += $suspiciousTitleReason
+            $filteredItemCount++
+            continue
+        }
+
+        $candidate = New-ReadableBacklogCandidate $title $priority
+        $usableCandidates += $candidate
+        $readableCandidates += $candidate
+    }
+
+    if ($readableCandidates.Count -gt 0) {
+        return @($readableCandidates)
+    }
+
+    $joinedSuspiciousTitleReasons = Join-UniqueReasons $suspiciousTitleReasons
+
+    if ($usableCandidates.Count -gt 0) {
+        $fallbackWhy = "the backlog items were usable but no clean, readable title was available for a generated goal title."
+        $fallback = New-FallbackBacklogCandidate $readItemCount $filteredItemCount $readableCandidates.Count $usableCandidates.Count $fallbackWhy $joinedSuspiciousTitleReasons
+        return @($fallback)
+    }
+
+    $fallbackReason = if ($readItemCount -eq 0) {
+        "the backlog priority sections did not contain bullet items."
+    } else {
+        "all backlog bullet items were empty, too short, or did not contain letters or numbers."
+    }
+
+    $fallbackCandidate = New-FallbackBacklogCandidate $readItemCount $filteredItemCount $readableCandidates.Count $usableCandidates.Count $fallbackReason $joinedSuspiciousTitleReasons
+    return @($fallbackCandidate)
+}
+
+function Invoke-AutoGoal {
+    param(
+        [object]$Candidate,
+        [int]$StepNumber
+    )
+
+    $autoGoalPath = Join-Path $PSScriptRoot "ai-dev-auto-goal.ps1"
+
+    if (-not (Test-Path -LiteralPath $autoGoalPath -PathType Leaf)) {
+        throw "Required script is missing: scripts/ai-dev-auto-goal.ps1"
+    }
+
+    $arguments = @(
+        "-GoalTitle", [string]$Candidate.title,
+        "-GoalDescription", [string]$Candidate.description,
+        "-MaxTasks", [string]$MaxTasks,
+        "-MaxSteps", [string]$MaxSteps
+    )
+
+    if ($DryRun) {
+        $arguments += "-DryRun"
+    }
+
+    if ($Json) {
+        $arguments += "-Json"
+    }
+
+    if ($AllowRun) {
+        $arguments += "-AllowRun"
+    }
+
+    if ($AllowCodex) {
+        $arguments += "-AllowCodex"
+    }
+
+    if ($AllowReviewCodex) {
+        $arguments += "-AllowReviewCodex"
+    }
+
+    if ($AllowCommit) {
+        $arguments += "-AllowCommit"
+    }
+
+    if ($AllowDirty) {
+        $arguments += "-AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { Test-HasValue $_ })
+
+        if ($normalizedFiles.Count -gt 0) {
+            $arguments += "-CommitFiles"
+            $arguments += ($normalizedFiles -join ",")
+        }
+    }
+
+    $output = & powershell -ExecutionPolicy Bypass -File $autoGoalPath @arguments 2>&1 | Out-String
+    $exitCode = $LASTEXITCODE
+    $message = $output.Trim()
+
+    if (-not (Test-HasValue $message)) {
+        $message = "ai-dev-auto-goal.ps1 completed without output."
+    }
+
+    return New-StepResult $StepNumber "auto-goal" $true $false $exitCode $message $Candidate
+}
+
+Set-Location $repoRoot
+
+$steps = @()
+$preparedGoals = 0
+$usedTitles = @()
+
+if ($MaxGoals -lt 1) {
+    $message = "MaxGoals must be at least 1."
+    $steps += New-StepResult 0 "validate-input" $false $false 1 $message
+    Stop-Autopilot $steps "max_goals_must_be_at_least_1" $false 1 $preparedGoals $message
+}
+
+if ($MaxTasks -lt 1) {
+    $message = "MaxTasks must be at least 1."
+    $steps += New-StepResult 0 "validate-input" $false $false 1 $message
+    Stop-Autopilot $steps "max_tasks_must_be_at_least_1" $false 1 $preparedGoals $message
+}
+
+if ($MaxSteps -lt 1) {
+    $message = "MaxSteps must be at least 1."
+    $steps += New-StepResult 0 "validate-input" $false $false 1 $message
+    Stop-Autopilot $steps "max_steps_must_be_at_least_1" $false 1 $preparedGoals $message
+}
+
+foreach ($requiredPath in @($goalPath, $queuePath, $statePath, $backlogPath)) {
+    if (-not (Test-Path -LiteralPath $requiredPath -PathType Leaf)) {
+        $message = "Required file is missing: $requiredPath"
+        $steps += New-StepResult 0 "prepare" $false $false 1 $message
+        Stop-Autopilot $steps "required_file_missing" $false 1 $preparedGoals $message
+    }
+}
+
+$steps += New-StepResult 1 "validate-input" $false $false 0 "Autopilot input validation completed. MaxGoals=$MaxGoals, MaxTasks=$MaxTasks, MaxSteps=$MaxSteps"
+
+for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
+    try {
+        $gate = Get-CurrentGoalGate
+    } catch {
+        $message = $_.Exception.Message
+        $steps += New-StepResult ($steps.Count + 1) "current-goal-gate" $false $false 1 $message
+        Stop-Autopilot $steps "current_goal_gate_failed" $false 1 $preparedGoals $message
+    }
+
+    if (-not $gate.passed) {
+        $message = "Current goal is not completed, so autopilot will not create the next goal. goalStatus=$($gate.goalStatus), currentTaskId=$($gate.currentTaskId), openTaskCount=$($gate.openTaskCount)"
+        $steps += New-StepResult ($steps.Count + 1) "current-goal-gate" $false $true 1 $message
+        Stop-Autopilot $steps "current_goal_not_completed" $false 1 $preparedGoals $message
+    }
+
+    $steps += New-StepResult ($steps.Count + 1) "current-goal-gate" $false $false 0 "Current goal is completed. Previous goal: $($gate.goalTitle)"
+
+    try {
+        $excludedTitles = @($usedTitles)
+
+        if (Test-HasValue $gate.goalTitle) {
+            $excludedTitles += [string]$gate.goalTitle
+        }
+
+        $candidates = @(Get-BacklogCandidates | Where-Object { $excludedTitles -notcontains ([string]$_.title) })
+    } catch {
+        $message = $_.Exception.Message
+        $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $false 1 $message
+        Stop-Autopilot $steps "goal_candidate_generation_failed" $false 1 $preparedGoals $message
+    }
+
+    if ($candidates.Count -eq 0) {
+        $message = "No actionable next goal candidate was found in the backlog after excluding the current or already prepared goal titles. Check backlog encoding, empty items, completed or deferred sections, and duplicate backlog titles."
+        $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $true 1 $message
+        Stop-Autopilot $steps "goal_candidate_not_found" $false 1 $preparedGoals $message
+    }
+
+    $candidate = $candidates | Select-Object -First 1
+    $usedTitles += [string]$candidate.title
+    $candidateMessage = "Next goal candidate generated from $($candidate.source) priority $($candidate.priority)."
+
+    if (Test-HasValue $candidate.fallbackReason) {
+        $candidateMessage = "$candidateMessage $($candidate.fallbackReason)"
+    }
+
+    $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $false 0 $candidateMessage $candidate
+
+    try {
+        $autoGoalStep = Invoke-AutoGoal $candidate ($steps.Count + 1)
+    } catch {
+        $message = "Auto-goal failed before completion: $($_.Exception.Message)"
+        $steps += New-StepResult ($steps.Count + 1) "auto-goal" $false $false 1 $message $candidate
+        Stop-Autopilot $steps "auto_goal_failed" $false 1 $preparedGoals $message
+    }
+
+    $steps += $autoGoalStep
+
+    if ($autoGoalStep.exitCode -ne 0) {
+        $failureMessage = "Auto-goal failed with exit code $($autoGoalStep.exitCode): $($autoGoalStep.message)"
+
+        if (Test-HasValue $candidate.fallbackReason) {
+            $failureMessage = "$failureMessage Fallback context: $($candidate.fallbackReason)"
+        }
+
+        Stop-Autopilot $steps "auto_goal_failed" $false 1 $preparedGoals $failureMessage
+    }
+
+    $preparedGoals++
+    $loopLogLines = @(
+        "- Goal: $($candidate.title)",
+        "- Source: $($candidate.source) / $($candidate.priority)",
+        "- Prepared goals: $preparedGoals/$MaxGoals"
+    )
+
+    if (Test-HasValue $candidate.fallbackReason) {
+        $loopLogLines += "- Fallback reason: $($candidate.fallbackReason)"
+    }
+
+    Add-LoopLogEntry "Autopilot goal prepared" $loopLogLines
+
+    if (-not ($AllowRun -or $AllowCodex -or $AllowReviewCodex -or $AllowCommit)) {
+        Stop-Autopilot $steps "prepared_without_full_cycle" $true 0 $preparedGoals
+    }
+}
+
+Stop-Autopilot $steps "max_goals_reached" $true 0 $preparedGoals
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```

## Untracked File Content

내용을 포함할 추적되지 않은 텍스트 파일이 없습니다.