# AI Dev Diff

## Generated At

2026-07-31 10:55:48

## Git Status

```text
 M .ai-dev/autopilot-goal-history.json
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

- .ai-dev/autopilot-goal-history.json
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
 scripts/ai-dev-autopilot.ps1 | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-autopilot.ps1 b/scripts/ai-dev-autopilot.ps1
index 0f94f17..52da0ce 100644
--- a/scripts/ai-dev-autopilot.ps1
+++ b/scripts/ai-dev-autopilot.ps1
@@ -1,4 +1,4 @@
-param(
+﻿param(
     [int]$MaxGoals = 1,
     [int]$MaxTasks = 1,
     [int]$MaxSteps = 22,
@@ -917,9 +917,12 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
         $candidateTitles = @($allCandidates | ForEach-Object { [string]$_.title } | Where-Object { Test-HasValue $_ } | Select-Object -Unique)
         $candidateTitleSummary = Format-ExcludedGoalTitles $candidateTitles
         $historyTitleSummary = Format-ExcludedGoalTitles $durableHistoryTitles
+        $candidateCount = $allCandidates.Count
+        $excludedCandidateCount = @($allCandidates | Where-Object { $excludedTitles -contains ([string]$_.title) }).Count
+        $currentGoalTitle = if (Test-HasValue $gate.goalTitle) { [string]$gate.goalTitle } else { "none" }
 
         if ($allCandidates.Count -gt 0) {
-            $message = "All backlog goal candidates were already completed, prepared, or recorded in durable history, so autopilot will not create a duplicate goal. Excluded goal titles: $excludedTitleSummary. Candidate goal titles: $candidateTitleSummary. Durable history goal titles: $historyTitleSummary."
+            $message = "Autopilot 후보가 모두 소진되었습니다. 현재 상태: goalStatus=$($gate.goalStatus), currentTaskId=$($gate.currentTaskId), openTaskCount=$($gate.openTaskCount), currentGoal=$currentGoalTitle. 제외된 backlog 후보 수: $excludedCandidateCount/$candidateCount. 모든 후보가 현재 goal, 준비 이력, 완료 이력 또는 durable history와 중복되어 신규 goal을 자동 생성하지 않습니다. 다음 행동: 1. .ai-dev/backlog.md에 새로운 backlog 항목을 추가합니다. 2. 이미 완료된 후보를 다시 진행해야 한다면 durable history와 완료 이력을 사람이 먼저 검토합니다. 3. 지금은 자동 진행을 멈추고 현재 상태를 유지합니다. 계속 진행하려면 새 backlog 항목이 필요합니다. 제외된 후보: $candidateTitleSummary. 제외 기준 title: $excludedTitleSummary. Durable history title: $historyTitleSummary."
             $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $true 1 $message
             Stop-Autopilot $steps "all_goal_candidates_excluded" $false 1 $preparedGoals $message
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