# AI Dev Diff

## Generated At

2026-07-13 00:26:46

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/codex-review-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/diff.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/review-prompt.md
 M .ai-dev/review-response.json
 M .ai-dev/review.md
 M .ai-dev/revise-prompt.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-autopilot.ps1
```

## App Change Files

- scripts/ai-dev-autopilot.ps1

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/codex-review-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/diff.md
- .ai-dev/goal.md
- .ai-dev/queue.json
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
 scripts/ai-dev-autopilot.ps1 | 200 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 189 insertions(+), 11 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-autopilot.ps1 b/scripts/ai-dev-autopilot.ps1
index 20d4d35..1468b7b 100644
--- a/scripts/ai-dev-autopilot.ps1
+++ b/scripts/ai-dev-autopilot.ps1
@@ -20,11 +20,13 @@ $queueRelativePath = ".ai-dev/queue.json"
 $stateRelativePath = ".ai-dev/state.json"
 $backlogRelativePath = ".ai-dev/backlog.md"
 $loopLogRelativePath = ".ai-dev/loop-log.md"
+$goalHistoryRelativePath = ".ai-dev/autopilot-goal-history.json"
 $goalPath = Join-Path $repoRoot $goalRelativePath
 $queuePath = Join-Path $repoRoot $queueRelativePath
 $statePath = Join-Path $repoRoot $stateRelativePath
 $backlogPath = Join-Path $repoRoot $backlogRelativePath
 $loopLogPath = Join-Path $repoRoot $loopLogRelativePath
+$goalHistoryPath = Join-Path $repoRoot $goalHistoryRelativePath
 $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
 
 function Test-HasValue {
@@ -64,6 +66,151 @@ function Write-JsonFile {
     [System.IO.File]::WriteAllText($Path, $json, $utf8WithBom)
 }
 
+function New-EmptyGoalHistory {
+    return [PSCustomObject][ordered]@{
+        version = 1
+        updatedAt = ""
+        goals = @()
+    }
+}
+
+function Read-AutopilotGoalHistory {
+    if (-not (Test-Path -LiteralPath $goalHistoryPath -PathType Leaf)) {
+        return New-EmptyGoalHistory
+    }
+
+    $history = Read-JsonFile $goalHistoryPath $goalHistoryRelativePath
+
+    if ($null -eq $history) {
+        return New-EmptyGoalHistory
+    }
+
+    if ($history -is [array]) {
+        $normalized = New-EmptyGoalHistory
+        $normalized.goals = @($history)
+        return $normalized
+    }
+
+    if ($history.PSObject.Properties.Name -notcontains "goals" -or $null -eq $history.goals) {
+        Set-ObjectProperty $history "goals" @()
+    }
+
+    if ($history.PSObject.Properties.Name -notcontains "version") {
+        Set-ObjectProperty $history "version" 1
+    }
+
+    if ($history.PSObject.Properties.Name -notcontains "updatedAt") {
+        Set-ObjectProperty $history "updatedAt" ""
+    }
+
+    return $history
+}
+
+function Get-AutopilotGoalHistoryTitles {
+    try {
+        $history = Read-AutopilotGoalHistory
+    } catch {
+        throw "Failed to read durable autopilot goal history: $($_.Exception.Message)"
+    }
+
+    $titles = @()
+
+    foreach ($goal in @($history.goals)) {
+        if ($null -eq $goal) {
+            continue
+        }
+
+        if ($goal -is [string]) {
+            $titles = @(Add-UniqueTitle $titles $goal)
+            continue
+        }
+
+        if ($goal.PSObject.Properties.Name -contains "title") {
+            $titles = @(Add-UniqueTitle $titles ([string]$goal.title))
+        }
+    }
+
+    return @($titles)
+}
+
+function Add-AutopilotGoalHistoryTitle {
+    param(
+        [string]$Title,
+        [string]$Event
+    )
+
+    if ($DryRun -or -not (Test-HasValue $Title)) {
+        return
+    }
+
+    $now = [DateTimeOffset]::UtcNow.ToString("o")
+    $trimmedTitle = $Title.Trim()
+    $history = Read-AutopilotGoalHistory
+    $goals = @($history.goals)
+    $existingGoal = $null
+
+    foreach ($goal in $goals) {
+        if ($null -eq $goal) {
+            continue
+        }
+
+        $goalTitle = ""
+
+        if ($goal -is [string]) {
+            $goalTitle = [string]$goal
+        } elseif ($goal.PSObject.Properties.Name -contains "title") {
+            $goalTitle = [string]$goal.title
+        }
+
+        if ($goalTitle.Trim() -eq $trimmedTitle) {
+            $existingGoal = $goal
+            break
+        }
+    }
+
+    if ($null -eq $existingGoal -or $existingGoal -is [string]) {
+        $events = @([PSCustomObject][ordered]@{
+            event = $Event
+            at = $now
+        })
+
+        $goalEntry = [PSCustomObject][ordered]@{
+            title = $trimmedTitle
+            firstSeenAt = $now
+            lastSeenAt = $now
+            lastEvent = $Event
+            events = $events
+        }
+
+        $goals = @($goals | Where-Object { -not ($_ -is [string] -and $_.Trim() -eq $trimmedTitle) })
+        $goals = @($goals) + @($goalEntry)
+    } else {
+        if ($existingGoal.PSObject.Properties.Name -notcontains "firstSeenAt" -or -not (Test-HasValue $existingGoal.firstSeenAt)) {
+            Set-ObjectProperty $existingGoal "firstSeenAt" $now
+        }
+
+        Set-ObjectProperty $existingGoal "lastSeenAt" $now
+        Set-ObjectProperty $existingGoal "lastEvent" $Event
+
+        $events = @()
+        if ($existingGoal.PSObject.Properties.Name -contains "events" -and $null -ne $existingGoal.events) {
+            $events = @($existingGoal.events)
+        }
+
+        $events = @($events) + @([PSCustomObject][ordered]@{
+            event = $Event
+            at = $now
+        })
+
+        Set-ObjectProperty $existingGoal "events" $events
+    }
+
+    Set-ObjectProperty $history "version" 1
+    Set-ObjectProperty $history "updatedAt" $now
+    Set-ObjectProperty $history "goals" @($goals)
+    Write-JsonFile $goalHistoryPath $history
+}
+
 function Set-ObjectProperty {
     param(
         [object]$InputObject,
@@ -99,37 +246,37 @@ function Invoke-AutopilotLoopLogMetaCommit {
     param([int]$StepNumber)
 
     if ($DryRun) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $false $true 0 "DryRun: autopilot loop-log meta commit was not executed."
+        return New-StepResult $StepNumber "autopilot-meta-commit" $false $true 0 "DryRun: autopilot loop-log/history meta commit was not executed."
     }
 
     if (-not $AllowCommit) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $false $true 0 "AllowCommit is not set, so autopilot loop-log meta commit was not executed."
+        return New-StepResult $StepNumber "autopilot-meta-commit" $false $true 0 "AllowCommit is not set, so autopilot loop-log/history meta commit was not executed."
     }
 
-    $statusOutput = & git status --short -- $loopLogRelativePath 2>&1 | Out-String
+    $statusOutput = & git status --short -- $loopLogRelativePath $goalHistoryRelativePath 2>&1 | Out-String
     $statusExitCode = $LASTEXITCODE
 
     if ($statusExitCode -ne 0) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "git status for autopilot loop-log failed. exit code: $statusExitCode`n$statusOutput"
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "git status for autopilot loop-log/history failed. exit code: $statusExitCode`n$statusOutput"
     }
 
     if (-not (Test-HasValue $statusOutput)) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 0 "Autopilot loop-log had no changes to commit."
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 0 "Autopilot loop-log/history had no changes to commit."
     }
 
-    $addOutput = & git add -- $loopLogRelativePath 2>&1 | Out-String
+    $addOutput = & git add -- $loopLogRelativePath $goalHistoryRelativePath 2>&1 | Out-String
     $addExitCode = $LASTEXITCODE
 
     if ($addExitCode -ne 0) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot loop-log git add failed. exit code: $addExitCode`n$addOutput"
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot loop-log/history git add failed. exit code: $addExitCode`n$addOutput"
     }
 
     $metaCommitMessage = "chore(ai-dev): record autopilot progress"
-    $commitOutput = & git commit -m $metaCommitMessage -- $loopLogRelativePath 2>&1 | Out-String
+    $commitOutput = & git commit -m $metaCommitMessage -- $loopLogRelativePath $goalHistoryRelativePath 2>&1 | Out-String
     $commitExitCode = $LASTEXITCODE
 
     if ($commitExitCode -ne 0) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot loop-log meta commit failed. exit code: $commitExitCode`n$commitOutput"
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot loop-log/history meta commit failed. exit code: $commitExitCode`n$commitOutput"
     }
 
     $remainingStatus = & git status --short 2>&1 | Out-String
@@ -575,6 +722,10 @@ function Get-HistoricalGoalTitles {
         $titles = @(Add-UniqueTitle $titles $title)
     }
 
+    foreach ($title in @(Get-AutopilotGoalHistoryTitles)) {
+        $titles = @(Add-UniqueTitle $titles $title)
+    }
+
     return @($titles)
 }
 
@@ -685,6 +836,7 @@ Set-Location $repoRoot
 $steps = @()
 $preparedGoals = 0
 $usedTitles = @()
+$durableHistoryTitles = @()
 
 if ($MaxGoals -lt 1) {
     $message = "MaxGoals must be at least 1."
@@ -731,8 +883,17 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
 
     $steps += New-StepResult ($steps.Count + 1) "current-goal-gate" $false $false 0 "Current goal is completed. Previous goal: $($gate.goalTitle)"
 
+    try {
+        Add-AutopilotGoalHistoryTitle ([string]$gate.goalTitle) "completed"
+    } catch {
+        $message = $_.Exception.Message
+        $steps += New-StepResult ($steps.Count + 1) "goal-history" $false $false 1 $message
+        Stop-Autopilot $steps "goal_history_update_failed" $false 1 $preparedGoals $message
+    }
+
     try {
         $excludedTitles = @(Get-ExcludedGoalTitles $usedTitles $gate)
+        $durableHistoryTitles = @(Get-AutopilotGoalHistoryTitles)
         $allCandidates = @(Get-BacklogCandidates)
         $candidates = @($allCandidates | Where-Object { $excludedTitles -notcontains ([string]$_.title) })
     } catch {
@@ -745,14 +906,15 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
         $excludedTitleSummary = Format-ExcludedGoalTitles $excludedTitles
         $candidateTitles = @($allCandidates | ForEach-Object { [string]$_.title } | Where-Object { Test-HasValue $_ } | Select-Object -Unique)
         $candidateTitleSummary = Format-ExcludedGoalTitles $candidateTitles
+        $historyTitleSummary = Format-ExcludedGoalTitles $durableHistoryTitles
 
         if ($allCandidates.Count -gt 0) {
-            $message = "All backlog goal candidates were already completed or prepared, so autopilot will not create a duplicate goal. Excluded goal titles: $excludedTitleSummary. Candidate goal titles: $candidateTitleSummary."
+            $message = "All backlog goal candidates were already completed, prepared, or recorded in durable history, so autopilot will not create a duplicate goal. Excluded goal titles: $excludedTitleSummary. Candidate goal titles: $candidateTitleSummary. Durable history goal titles: $historyTitleSummary."
             $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $true 1 $message
             Stop-Autopilot $steps "all_goal_candidates_excluded" $false 1 $preparedGoals $message
         }
 
-        $message = "No actionable next goal candidate was found in the backlog after excluding current, prepared, or completed goal titles. Excluded goal titles: $excludedTitleSummary. Check backlog encoding, empty items, completed or deferred sections, and duplicate backlog titles."
+        $message = "No actionable next goal candidate was found in the backlog after excluding current, prepared, completed, or durable history goal titles. Excluded goal titles: $excludedTitleSummary. Durable history goal titles: $historyTitleSummary. Check backlog encoding, empty items, completed or deferred sections, and duplicate backlog titles."
         $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $true 1 $message
         Stop-Autopilot $steps "goal_candidate_not_found" $false 1 $preparedGoals $message
     }
@@ -761,6 +923,14 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
     $usedTitles += [string]$candidate.title
     $candidateMessage = "Next goal candidate generated from $($candidate.source) priority $($candidate.priority)."
 
+    try {
+        Add-AutopilotGoalHistoryTitle ([string]$candidate.title) "selected"
+    } catch {
+        $message = $_.Exception.Message
+        $steps += New-StepResult ($steps.Count + 1) "goal-history" $false $false 1 $message $candidate
+        Stop-Autopilot $steps "goal_history_update_failed" $false 1 $preparedGoals $message
+    }
+
     if (Test-HasValue $candidate.fallbackReason) {
         $candidateMessage = "$candidateMessage $($candidate.fallbackReason)"
     }
@@ -798,6 +968,14 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
         $loopLogLines += "- Fallback reason: $($candidate.fallbackReason)"
     }
 
+    try {
+        Add-AutopilotGoalHistoryTitle ([string]$candidate.title) "prepared"
+    } catch {
+        $message = $_.Exception.Message
+        $steps += New-StepResult ($steps.Count + 1) "goal-history" $false $false 1 $message $candidate
+        Stop-Autopilot $steps "goal_history_update_failed" $false 1 $preparedGoals $message
+    }
+
     Add-LoopLogEntry "Autopilot goal prepared" $loopLogLines
 
     if ($AllowCommit) {
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```