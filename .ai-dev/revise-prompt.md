# AI Dev Revise Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.
이전 리뷰에서 지적된 사항만 수정한다.

## Goal

# 목표

AI Dev Loop Autopilot이 이미 준비했거나 완료한 backlog goal title을 다음 실행에서 다시 선택하지 않도록 개선한다.

## 배경

현재 `scripts/ai-dev-autopilot.ps1`은 현재 goal, 직전 goal, 현재 프로세스의 `usedTitles`만 제외한다. 이 때문에 이전 Autopilot 실행에서 이미 완료한 backlog 항목이 이후 실행에서 다시 후보로 선택될 수 있다.

## 성공 기준

- Autopilot은 과거 prepared 로그, 완료된 queue/goal 상태, 또는 별도 history 파일을 기준으로 이미 준비했거나 완료한 goal title을 후보에서 제외한다.
- 중복 후보를 제외한 뒤 남은 후보가 없으면 중단 사유와 제외된 title 목록을 state, loop-log, 출력 중 적절한 위치에 남긴다.
- 정상 한국어 backlog title은 계속 후보로 허용된다.
- 기존 mojibake fallback 로직은 유지된다.
- DryRun 실행에서는 파일을 수정하지 않는다.
- AllowCommit이 있는 성공 실행은 작업 종료 상태를 명확히 검증할 수 있다.

## 제약사항

- 앱 `src` 파일은 수정하지 않는다.
- 변경 범위는 Autopilot 스크립트와 AI Dev Loop 상태 파일에 한정한다.
- 기존 backlog 선택 흐름과 fallback 동작을 불필요하게 재작성하지 않는다.
- 한 번에 하나의 작은 구현 단위로 진행한다.

## 범위 제외

- 앱 UI 변경은 하지 않는다.
- IndexedDB schema 변경은 하지 않는다.
- 새로운 외부 의존성은 추가하지 않는다.
- 알림, 계정, 원격 동기화 기능은 다루지 않는다.

## 수동 검증

- 과거 완료 title이 있는 상태에서 Autopilot 후보 선택을 실행해 해당 title이 제외되는지 확인한다.
- 제외 후 후보가 없을 때 중단 사유와 제외 title 목록이 남는지 확인한다.
- DryRun에서 상태 파일이 변경되지 않는지 확인한다.
- 한국어 backlog title과 mojibake fallback 처리가 기존처럼 동작하는지 확인한다.


## Current Task

- Task ID: T001
- Title: 완료된 Autopilot goal 제외 처리 구현
- Description: Autopilot backlog 후보 선택 시 과거에 준비했거나 완료한 goal title을 수집해 중복 후보를 제외하고, 남은 후보가 없을 때 읽을 수 있는 중단 사유와 제외 목록을 기록한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Verification:
- DryRun에서 파일 변경이 발생하지 않는지 확인한다.
- 이전 완료 title이 후보에서 제외되는지 확인한다.
- 모든 후보가 제외된 경우 중단 사유와 제외 title 목록이 기록되는지 확인한다.
- 정상 한국어 backlog title과 기존 mojibake fallback 동작이 유지되는지 확인한다.

## Review Result

- Decision: revise
- Severity: low
- Next step: revise_with_codex
- Summary: 구현 범위와 코드 흐름은 대체로 현재 task에 맞지만, task 성공 기준에 대한 수동 검증 결과가 기록되지 않았고 npm test도 스크립트 부재로 skipped라서 strict 기준상 보완이 필요하다.

## Required Changes

- File: .ai-dev/test-result.md
  - Reason: 현재 검증은 build/lint 중심이며, DryRun 파일 미변경, 과거 완료 title 제외, 모든 후보 제외 시 중단 사유/제외 목록 기록, 한국어 title 및 mojibake fallback 유지 여부가 실제로 확인됐다는 기록이 없다.
  - Suggestion: 현재 task의 Verification 항목 4가지를 실행하거나 실행 불가 사유를 구체적으로 기록하고, 각 결과를 test-result 또는 동등한 리뷰 입력 산출물에 남긴다.

## Optional Suggestions

- optional_suggestions는 참고만 하며 구현하지 않는다.
- File: scripts/ai-dev-autopilot.ps1
  - Suggestion: Get-PreparedGoalTitlesFromLoopLog의 헤더 매칭은 현재 로그 형식에는 맞지만, 향후 제목에 하이픈이 포함될 가능성을 줄이려면 날짜 패턴을 더 명확히 고정하는 방식도 고려할 수 있다.

## Diff Context

# AI Dev Diff

## Generated At

2026-07-12 22:50:55

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

## Test Result

# AI Dev Test Result

## 2026-07-12 22:50:46

- Overall result: passed
- Current task: T001
- Mode: BuildOnly (build + lint when available)
- Commands:
  - npm run build: passed
  - npm run test: skipped
  - npm run lint: passed

### npm run build

- Status: passed
- Exit code: 0

```text

> planpilot-local@0.0.0 build
> tsc -b && vite build

[36mvite v8.0.10 [32mbuilding client environment for production...[36m[39m
[2K
transforming...✓ 48 modules transformed.
rendering chunks...
computing gzip size...
dist/index.html                   0.46 kB │ gzip:   0.29 kB
dist/assets/index-DvjxWt30.css    5.69 kB │ gzip:   1.93 kB
dist/assets/index-DtLVvPCG.js   317.50 kB │ gzip: 100.16 kB

[32m✓ built in 279ms[39m
```
### npm run test

- Status: skipped
- Exit code: 없음

```text
package.json에 test script가 없습니다.
```
### npm run lint

- Status: passed
- Exit code: 0

```text

> planpilot-local@0.0.0 lint
> eslint .
```

## Allowed Scope

- required_changes에 필요한 최소 수정만 허용한다.
- 현재 task 범위를 벗어나지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 새 기능 추가보다 리뷰 지적사항 해결을 우선한다.

## Hard Rules

- `package.json`과 `package-lock.json`은 수정하지 않는다. 꼭 필요하면 중단하고 이유만 기록한다.
- 실제 DB 삭제 또는 초기화를 하지 않는다.
- 사용자 데이터 복원 또는 덮어쓰기를 하지 않는다.
- 대규모 리팩터링을 하지 않는다.
- git commit을 실행하지 않는다.
- git reset, git checkout, git clean을 실행하지 않는다.
- npm install을 실행하지 않는다.
- optional_suggestions는 기본적으로 구현하지 않는다.

## Required Output

- 반영한 required_changes 목록
- 수정한 파일 목록
- 검증 방법
- 반영하지 못한 항목과 이유
- 남은 위험
- `.ai-dev/loop-log.md`에 기록할 재수정 요약