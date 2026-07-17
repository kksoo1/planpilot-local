# AI Dev Revise Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.
이전 리뷰에서 지적된 사항만 수정한다.

## Goal

# 목표
Autopilot durable history 기록 이후 nested auto-goal dirty-worktree-gate가 `.ai-dev/autopilot-goal-history.json` 때문에 중단되는 문제를 수정한다.

## 배경
현재 Autopilot 연속 실행 중 selected/prepared/completed durable history가 기록된 직후 nested `ai-dev-auto-goal.ps1` 호출에서 작업 트리가 dirty로 판단되어 `auto_goal_failed`로 중단된다. 특히 `.ai-dev/autopilot-goal-history.json`이 새로 생성되거나 변경된 상태가 dirty gate에 걸린다.

## 성공 기준
- Autopilot이 durable history를 기록해도 nested auto-goal dirty gate가 자기 자신의 history 파일만으로 실패하지 않는다.
- `AllowRun + AllowCommit` 경로에서 history/loop-log가 필요한 시점에 안전하게 meta commit되거나 nested auto-goal 호출 전 작업 트리가 깨끗하게 유지된다.
- DryRun에서는 파일 변경이 발생하지 않는다.
- durable history 중복 방지 기능이 유지된다.
- `.ai-dev/autopilot-goal-history.json`이 장기 추적 대상이면 자동화 commit 대상에 포함된다.
- 실제 Autopilot 연속 실행 명령이 최소 1개 goal을 준비/실행 단계로 넘길 수 있다.
- 앱 `src` 파일은 수정하지 않는다.
- build/lint 검증을 통과한다.

## 제약사항
- 변경은 Autopilot/auto-goal 스크립트와 `.ai-dev` 자동화 상태 파일 범위로 제한한다.
- 기존 durable history 중복 방지 로직을 제거하지 않는다.
- DryRun 경로는 어떤 파일도 쓰지 않도록 유지한다.
- 앱 UI와 `src` 파일은 변경하지 않는다.

## 범위 제외
- 앱 기능 변경
- 대규모 스크립트 재작성
- 저장소 구조 변경
- 알림 또는 외부 연동 추가

## 수동 검증
- DryRun 실행 후 파일 변경이 없는지 확인한다.
- `AllowRun + AllowCommit` Autopilot 연속 실행이 최소 1개 goal을 준비/실행 단계로 넘기는지 확인한다.
- build와 lint를 실행해 통과 여부를 확인한다.

## Current Task

- Task ID: T001
- Title: Autopilot history dirty gate 흐름 수정
- Description: Autopilot durable history 기록 후 nested auto-goal 호출 전에 history/loop-log 변경이 dirty gate에 걸리지 않도록 작은 범위로 수정하고, DryRun 무변경 및 history 중복 방지 동작을 유지한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Verification:
- DryRun 실행 후 파일 변경이 발생하지 않는지 확인
- AllowRun + AllowCommit Autopilot 연속 실행이 최소 1개 goal을 준비/실행 단계로 넘기는지 확인
- durable history 중복 방지 동작이 유지되는지 확인
- npm run build 실행
- npm run lint 실행

## Review Result

- Decision: revise
- Severity: medium
- Next step: revise_with_codex
- Summary: nested auto-goal 전 meta commit 추가 방향은 맞지만, commit 대상은 loop-log/history로 제한하면서 최종 검증은 전체
 작업 트리에 걸려 현재 자동화 산출물 변경이 남으면 auto-goal 진입 전에 실패할 수 있다. 수동 검증도 프롬프트 성공 기준을 충분히 입증하지 못했다.

## Required Changes

- File: scripts/ai-dev-autopilot.ps1
  - Reason: Invoke-AutopilotLoopLogMetaCommit는 .ai-dev/loop-log.md와 .ai-dev/autopilot-goal-histo
ry.json만 add/commit한 뒤 282-290행에서 전체 git status를 검사한다. 현재 리뷰 입력에도 .ai-dev 운영 산출물 변경이 남아 있어 이 경로가 auto
pilot_meta_commit_failed로 중단될 수 있으며, nested auto-goal을 준비/실행 단계로 넘긴다는 성공 기준에 불확실성이 있다.
  - Suggestion: nested auto-goal 직전 dirty gate 목적에 맞게 전체 clean 검증 전에 자동화 산출물 처리 정책을 명확히 하라. 최소 수
정으로는 AllowCommit 경로에서 nested 호출 전에 dirty로 남을 수 있는 자동화 메타 파일을 함께 안전하게 처리하거나, 이 함수의 최종 검증 범위를 dirty gat
e에서 허용/처리되는 자동화 파일 정책과 일치시키고 실제 AllowRun + AllowCommit 연속 실행으로 확인하라.
- File: unknown
  - Reason: 성공 기준의 수동 검증인 DryRun 무변경, AllowRun + AllowCommit 연속 실행 최소 1개 goal 준비/실행, durable his
tory 중복 방지 유지가 결과에 명확히 기록되어 있지 않다. test script도 없어 npm run test는 skipped 상태다.
  - Suggestion: 프롬프트에 명시된 수동 검증 결과를 실행/기록하고, 테스트 스크립트가 없는 점은 잔여 리스크로 명시하라.

## Optional Suggestions

- optional_suggestions는 참고만 하며 구현하지 않는다.
- 없음

## Diff Context

# AI Dev Diff

## Generated At

2026-07-17 18:04:01

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-autopilot.ps1
```

## App Change Files

- scripts/ai-dev-autopilot.ps1

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-autopilot.ps1 | 9 +++++++++
 1 file changed, 9 insertions(+)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-autopilot.ps1 b/scripts/ai-dev-autopilot.ps1
index 1468b7b..0b9945e 100644
--- a/scripts/ai-dev-autopilot.ps1
+++ b/scripts/ai-dev-autopilot.ps1
@@ -937,6 +937,15 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
 
     $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $false 0 $candidateMessage $candidate
 
+    if ($AllowCommit) {
+        $metaCommitStep = Invoke-AutopilotLoopLogMetaCommit ($steps.Count + 1)
+        $steps += $metaCommitStep
+
+        if ($metaCommitStep.exitCode -ne 0) {
+            Stop-Autopilot $steps "autopilot_meta_commit_failed" $false 1 $preparedGoals $metaCommitStep.message
+        }
+    }
+
     try {
         $autoGoalStep = Invoke-AutoGoal $candidate ($steps.Count + 1)
     } catch {
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

## 2026-07-17 18:03:54

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

[32m✓ built in 212ms[39m
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