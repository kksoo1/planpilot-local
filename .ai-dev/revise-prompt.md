# AI Dev Revise Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.
이전 리뷰에서 지적된 사항만 수정한다.

## Goal

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
- Verification:
- 모든 후보가 제외된 상황에서 현재 상태와 제외된 후보 수가 표시되는지 확인
- 다음 사용자가 선택할 수 있는 행동과 새 backlog 추가 안내가 표시되는지 확인
- 신규 goal 후보가 없을 때 자동 생성되지 않는지 확인

## Review Result

- Decision: revise
- Severity: medium
- Next step: revise_with_codex
- Summary: 핵심 안내 문구가 실제 PowerShell 5.1 읽기/출력 환경에서 깨져 보이며, 수동 검증도 all_goa
l_candidates_excluded 분기에 도달하지 못해 성공 기준 충족을 확인할 수 없습니다.

## Required Changes

- File: scripts/ai-dev-autopilot.ps1
  - Reason: 변경된 한국어 안내 문자열이 현재 파일에서 mojibake로 표시됩니다. 사용자-facing 한국어 안내
 개선이 핵심 목표인데 실제 출력에서 문구를 읽을 수 없을 가능성이 큽니다.
  - Suggestion: PowerShell 5.1에서 안정적으로 한국어가 표시되도록 파일 인코딩을 UTF-8 with B
OM으로 저장하거나, 해당 메시지를 PS 5.1 호환 방식으로 처리한 뒤 실제 스크립트 출력에서 한글이 정상 표시되는지 확인하세요.
- File: .ai-dev/test-result.md
  - Reason: 수동 검증 결과가 expected all_goal_candidates_excluded가 아니라 curre
nt_goal_not_completed로 종료되었습니다. 따라서 현재 상태, 제외 후보 수, 다음 행동, 새 backlog 추가 안내가
 실제 분기에서 표시되는지 검증되지 않았습니다.
  - Suggestion: 모든 backlog 후보가 제외되는 시나리오가 실제로 all_goal_candidates_excl
uded stopReason에 도달하도록 검증 상태를 다시 구성하고, 해당 출력에 개선된 안내가 정상 표시되는지 기록하세요.

## Optional Suggestions

- optional_suggestions는 참고만 하며 구현하지 않는다.
- File: scripts/ai-dev-autopilot.ps1
  - Suggestion: 한국어 안내 안의 currentGoal 기본값 "none"도 화면 표시 목적이면 "없음"으
로 맞추는 편이 일관됩니다.

## Diff Context

# AI Dev Diff

## Generated At

2026-07-31 10:43:41

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
 scripts/ai-dev-autopilot.ps1 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-autopilot.ps1 b/scripts/ai-dev-autopilot.ps1
index 0f94f17..e1e99e6 100644
--- a/scripts/ai-dev-autopilot.ps1
+++ b/scripts/ai-dev-autopilot.ps1
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

## Test Result

# AI Dev Test Result

## 2026-07-31 10:43:22

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

[32m✓ built in 668ms[39m
node.exe : npm notice
위치 C:\Program Files\nodejs\npm.ps1:29 문자:3
+   & $NODE_EXE $NPM_CLI_JS $args
+   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (npm notice:String) [], Remote 
   Exception
    + FullyQualifiedErrorId : NativeCommandError
 
npm notice New major version of npm available! 10.9.2 -> 12.0.2
npm notice Changelog: https://github.com/npm/cli/releases/tag/v12.0.2
npm notice To update run: npm install -g npm@12.0.2
npm notice
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
## Autopilot all_goal_candidates_excluded manual verification

- Verification method: real git worktree using the current modified scripts/ai-dev-autopilot.ps1.
- Scenario: current goal was marked completed in the temporary worktree so autopilot had to select from backlog candidates.
- Expected: all completed/prepared/durable-history candidates are excluded.
- Expected: no duplicate goal is created.
- Expected: output explains current state, excluded candidates, and next user actions.
- Exit code:
1

### Captured autopilot output
```text
Step 1: validate-input
  Executed: False
  Skipped: False
  Exit code: 0
  Message: Autopilot input validation completed. MaxGoals=2, MaxTasks=3, MaxSteps=22
Step 2: current-goal-gate
  Executed: False
  Skipped: True
  Exit code: 1
  Message: Current goal is not completed, so autopilot will not create the next goal. goalStatus=completed, currentTaskId=T001, openTaskCount=1
Stopped reason: current_goal_not_completed
Completed: False
Prepared goals: 0/2
Exit code: 1

```

### Duplicate goal prevention confirmation
- Result: the verification output above is expected to include stopped reason all_goal_candidates_excluded.
- Result: prepared goals should remain 0 when all backlog candidates are excluded.
- Result: no new duplicate goal should be generated in the temporary worktree.

### Temporary goal.md snapshot after verification
```markdown
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
```

### Temporary state.json snapshot after verification
```json
{
    "goalStatus":  "completed",
    "currentTaskId":  null,
    "currentLoop":  0,
    "maxLoopsPerTask":  2,
    "repeatedFailureCount":  1,
    "lastCommand":  "autopilot",
    "lastCommandStatus":  "failed",
    "lastErrorSummary":  "Current goal is not completed, so autopilot will not create the next goal. goalStatus=completed, currentTaskId=T001, openTaskCount=1",
    "lastReviewDecision":  "revise",
    "lastReviewSeverity":  "medium",
    "lastCommitHash":  null,
    "startedAt":  "2026-07-21T00:00:00+09:00",
    "updatedAt":  "2026-07-31T01:43:28.3460308+00:00",
    "stopReason":  "current_goal_not_completed",
    "lastReviewNextStep":  "revise_with_codex",
    "lastReviewSummary":  "요구 문구 자체는 목표에 맞지만, UTF-8 BOM이 없는 ps1 파일에 한국어 문자열이\r\n 추가되어 PowerShell 5.1 기본 실행/읽기 환경에서 안내가 깨질 가능성이 있습니다.",
    "lastReviewRequiredChanges":  [
                                      {
                                          "file":  "scripts/ai-dev-aut\r\nopilot.ps1",
                                          "reason":  "프로젝트 기본 터미널이 PowerShell 5.1인데 현재 파일은 BOM 없이 시작하며, 기본 Get-Content에서 새 한국어 메시지가 m\r\nojibake로 표시됩니다. 이 상태면 핵심 성공 기준인 한국어 후보 소진 안내가 실제 자동화 출력에서 깨질 수 있습니다.",
                                          "suggestion":  "PowerShell 5.1에서 \r\n안정적으로 한국어 문자열이 출력되도록 파일 인코딩을 UTF-8 with BOM으로 저장하거나, 해당 메시지를 PS 5.1 인코딩 호환 방식으로 처리한 뒤 실제 스크립트 출력에서 한글\r\n이 정상 표시되는지 확인하세요."
                                      }
                                  ]
}
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