# AI Dev Diff

## Generated At

2026-07-12 22:55:22

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/codex-review-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/diff.md
 M .ai-dev/goal.md
 M .ai-dev/loop-log.md
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
- .ai-dev/loop-log.md
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
 scripts/ai-dev-autopilot.ps1 | 133 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 125 insertions(+), 8 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-autopilot.ps1 b/scripts/ai-dev-autopilot.ps1
index 47d8acc..20d4d35 100644
--- a/scripts/ai-dev-autopilot.ps1
+++ b/scripts/ai-dev-autopilot.ps1
@@ -502,6 +502,117 @@ function Get-BacklogCandidates {
     return @($fallbackCandidate)
 }
 
+function Add-UniqueTitle {
+    param(
+        [string[]]$Titles,
+        [string]$Title
+    )
+
+    if (-not (Test-HasValue $Title)) {
+        return @($Titles)
+    }
+
+    $trimmedTitle = $Title.Trim()
+
+    if ($Titles -contains $trimmedTitle) {
+        return @($Titles)
+    }
+
+    return @($Titles + $trimmedTitle)
+}
+
+function Get-PreparedGoalTitlesFromLoopLog {
+    if (-not (Test-Path -LiteralPath $loopLogPath -PathType Leaf)) {
+        return @()
+    }
+
+    $titles = @()
+    $isAutopilotPreparedEntry = $false
+    $lines = @(Get-Content -Encoding UTF8 -LiteralPath $loopLogPath)
+
+    foreach ($line in $lines) {
+        if ($line -match '^##\s+.+\s+-\s+(.+)$') {
+            $isAutopilotPreparedEntry = ($Matches[1].Trim() -eq "Autopilot goal prepared")
+            continue
+        }
+
+        if (-not $isAutopilotPreparedEntry) {
+            continue
+        }
+
+        if ($line -match '^\s*-\s+Goal:\s+(.+)$') {
+            $titles = @(Add-UniqueTitle $titles $Matches[1])
+        }
+    }
+
+    return @($titles)
+}
+
+function Get-CompletedCurrentGoalTitleFromQueueState {
+    $queue = Read-JsonFile $queuePath $queueRelativePath
+    $state = Read-JsonFile $statePath $stateRelativePath
+    $goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { "" }
+
+    if ($goalStatus -ne "completed") {
+        return @()
+    }
+
+    if (-not (Test-HasValue $queue.goalTitle)) {
+        return @()
+    }
+
+    return @([string]$queue.goalTitle)
+}
+
+function Get-HistoricalGoalTitles {
+    $titles = @()
+
+    foreach ($title in @(Get-PreparedGoalTitlesFromLoopLog)) {
+        $titles = @(Add-UniqueTitle $titles $title)
+    }
+
+    foreach ($title in @(Get-CompletedCurrentGoalTitleFromQueueState)) {
+        $titles = @(Add-UniqueTitle $titles $title)
+    }
+
+    return @($titles)
+}
+
+function Get-ExcludedGoalTitles {
+    param(
+        [string[]]$UsedTitles,
+        [object]$Gate
+    )
+
+    $titles = @()
+
+    foreach ($title in @($UsedTitles)) {
+        $titles = @(Add-UniqueTitle $titles $title)
+    }
+
+    if ($null -ne $Gate -and (Test-HasValue $Gate.goalTitle)) {
+        $titles = @(Add-UniqueTitle $titles ([string]$Gate.goalTitle))
+    }
+
+    foreach ($title in @(Get-HistoricalGoalTitles)) {
+        $titles = @(Add-UniqueTitle $titles $title)
+    }
+
+    return @($titles)
+}
+
+function Format-ExcludedGoalTitles {
+    param([string[]]$Titles)
+
+    $filteredTitles = @($Titles | Where-Object { Test-HasValue $_ } | Select-Object -Unique)
+
+    if ($filteredTitles.Count -eq 0) {
+        return "none"
+    }
+
+    return ($filteredTitles -join "; ")
+}
+
 function Invoke-AutoGoal {
     param(
         [object]$Candidate,
@@ -621,13 +732,9 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
     $steps += New-StepResult ($steps.Count + 1) "current-goal-gate" $false $false 0 "Current goal is completed. Previous goal: $($gate.goalTitle)"
 
     try {
-        $excludedTitles = @($usedTitles)
-
-        if (Test-HasValue $gate.goalTitle) {
-            $excludedTitles += [string]$gate.goalTitle
-        }
-
-        $candidates = @(Get-BacklogCandidates | Where-Object { $excludedTitles -notcontains ([string]$_.title) })
+        $excludedTitles = @(Get-ExcludedGoalTitles $usedTitles $gate)
+        $allCandidates = @(Get-BacklogCandidates)
+        $candidates = @($allCandidates | Where-Object { $excludedTitles -notcontains ([string]$_.title) })
     } catch {
         $message = $_.Exception.Message
         $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $false 1 $message
@@ -635,7 +742,17 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
     }
 
     if ($candidates.Count -eq 0) {
-        $message = "No actionable next goal candidate was found in the backlog after excluding the current or already prepared goal titles. Check backlog encoding, empty items, completed or deferred sections, and duplicate backlog titles."
+        $excludedTitleSummary = Format-ExcludedGoalTitles $excludedTitles
+        $candidateTitles = @($allCandidates | ForEach-Object { [string]$_.title } | Where-Object { Test-HasValue $_ } | Select-Object -Unique)
+        $candidateTitleSummary = Format-ExcludedGoalTitles $candidateTitles
+
+        if ($allCandidates.Count -gt 0) {
+            $message = "All backlog goal candidates were already completed or prepared, so autopilot will not create a duplicate goal. Excluded goal titles: $excludedTitleSummary. Candidate goal titles: $candidateTitleSummary."
+            $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $true 1 $message
+            Stop-Autopilot $steps "all_goal_candidates_excluded" $false 1 $preparedGoals $message
+        }
+
+        $message = "No actionable next goal candidate was found in the backlog after excluding current, prepared, or completed goal titles. Excluded goal titles: $excludedTitleSummary. Check backlog encoding, empty items, completed or deferred sections, and duplicate backlog titles."
         $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $true 1 $message
         Stop-Autopilot $steps "goal_candidate_not_found" $false 1 $preparedGoals $message
     }
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```