# AI Dev Review Prompt

## Role

너는 이 저장소의 엄격한 코드 리뷰어다.

## Review Goal

- 현재 task의 변경사항이 목표와 일치하는지 검토한다.
- 빌드/테스트 결과와 git diff를 함께 검토한다.
- 리뷰 판단은 App Change Files와 diff 본문의 실제 앱 변경 파일을 중심으로 수행한다.
- .ai-dev 파일은 자동화 상태/로그/프롬프트 산출물로 별도 확인하되, 앱 변경 결함으로 과대평가하지 않는다.
- 다음 task 범위까지 미리 구현했는지 확인한다.

## Project Goal

# 목표

Autopilot 후보 소진 시 자동 안내 개선

## 배경

모든 backlog 후보가 durable history 또는 완료 이력에 의해 제외되는 경우, 현재 흐름이 실패처럼 보이지 않도록 안내를 정리한다. `all_goal_candidates_excluded` 상황에서 신규 goal을 자동 생성하지 않고, 후보가 왜 소진되었는지와 사용자가 다음에 선택할 수 있는 행동을 명확히 보여준다.

## 성공 기준

- `all_goal_candidates_excluded` 상황에서 실패처럼 보이는 표현을 줄이고 정상적인 후보 소진 상태로 안내한다.
- 현재 상태와 제외된 후보 수가 사용자에게 명확히 표시된다.
- 사용자가 선택할 수 있는 다음 행동이 구체적으로 안내된다.
- 새 backlog 항목을 추가해야 계속 진행할 수 있음을 명확히 안내한다.
- 기존 중복 생성 방지 정책을 유지한다.
- 실제 신규 goal 후보가 없을 때 자동으로 goal을 생성하지 않는다.

## 제약사항

- 한 번에 하나의 작은 구현 범위로 진행한다.
- 기존 Autopilot 흐름과 중복 생성 방지 정책을 우선 유지한다.
- 사용자-facing 문구는 한국어를 기본으로 한다.
- 기존 타입과 상태 흐름을 먼저 확인한 뒤 최소 범위로 수정한다.

## 범위 제외

- Autopilot 후보 선정 정책의 대규모 변경은 제외한다.
- durable history 또는 완료 이력 저장 구조 변경은 제외한다.
- 새로운 화면 추가는 제외한다.
- 알림 기능 추가는 제외한다.

## 수동 검증

- backlog 후보가 모두 제외되는 상황을 재현한다.
- `all_goal_candidates_excluded` 결과에서 현재 상태, 제외된 후보 수, 다음 선택지, 새 backlog 추가 안내가 표시되는지 확인한다.
- 신규 goal 후보가 없을 때 자동 생성이 발생하지 않는지 확인한다.
- 기존 중복 생성 방지 동작이 유지되는지 확인한다.

## Current Task

- Task ID: T001
- Title: 후보 소진 안내 개선
- Description: `all_goal_candidates_excluded` 상황의 현재 출력 흐름을 확인하고, 모든 후보가 제외된 상태가 실패처럼 보이지 않도록 한국어 안내를 최소 범위로 개선한다.
- Type: implementation
- Status: in_progress
- Priority: P1
- Depends on:
- 없음
- Verification:
- 모든 후보가 제외된 상황에서 현재 상태와 제외된 후보 수가 표시되는지 확인
- 다음 사용자가 선택할 수 있는 행동과 새 backlog 추가 안내가 표시되는지 확인
- 신규 goal 후보가 없을 때 자동 생성되지 않는지 확인

## Test Result

# AI Dev Test Result

## 2026-07-31 10:55:37

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

[32m✓ built in 263ms[39m
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

## Diff To Review

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

## Review Criteria

- 현재 task 요구사항을 충족했는가
- 실제 앱 변경 파일과 .ai-dev 운영 산출물이 구분되어 있는가
- .ai-dev 운영 산출물만 변경된 경우 앱 변경 리뷰로 과대평가하지 않았는가
- 현재 task 범위를 벗어나지 않았는가
- 다음 task를 미리 구현하지 않았는가
- 기존 기능을 깨뜨릴 가능성이 있는가
- 데이터 삭제, 초기화, 복원 같은 위험 작업이 포함되었는가
- package.json 또는 package-lock.json을 불필요하게 수정했는가
- 검증 결과가 충분한가
- 문서나 수동검증 체크리스트 갱신이 필요한가
- 더 단순한 구현이 가능한가

### Strict Criteria

- 작은 불확실성도 revise로 판정한다.
- 테스트가 없거나 skipped이면 revise 후보로 본다.
- task 범위를 벗어난 파일 수정은 high 이상으로 판정한다.
- package 변경은 기본적으로 blocked 후보로 본다.

## Output Format

리뷰 결과는 아래 JSON 형식만 출력한다. JSON 앞뒤에 설명, Markdown 코드 펜스, 추가 문장을 출력하지 않는다.

{
  "decision": "pass | revise | blocked",
  "severity": "none | low | medium | high | critical",
  "summary": "짧은 요약",
  "required_changes": [
    {
      "file": "파일 경로 또는 unknown",
      "reason": "수정이 필요한 이유",
      "suggestion": "구체적 수정 방향"
    }
  ],
  "optional_suggestions": [
    {
      "file": "파일 경로 또는 unknown",
      "suggestion": "선택 개선 의견"
    }
  ],
  "scope_check": {
    "within_current_task": true,
    "scope_issues": []
  },
  "test_check": {
    "build_passed": true,
    "test_passed": true,
    "lint_passed": true,
    "issues": []
  },
  "next_step": "complete_task | revise_with_codex | stop_for_user"
}

## Decision Rules

- pass: 현재 task 요구사항 충족, 치명적 문제 없음, 다음 task로 넘어가도 됨
- revise: 수정이 필요하지만 자동 수정 가능
- blocked: 요구사항 충돌, 데이터 위험, 패키지 추가, 대규모 리팩터링 등 사용자 판단 필요