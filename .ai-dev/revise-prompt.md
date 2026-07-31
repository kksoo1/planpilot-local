# AI Dev Revise Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.
이전 리뷰에서 지적된 사항만 수정한다.

## Goal

# 목표

AI Dev 자동화 테스트 체계를 추가한다.

## 배경

현재 `package.json`에 `test` 스크립트가 없어 `ai-dev-check.ps1` 실행 시 테스트 단계가 항상 skipped 처리된다. PowerShell 5.1에서 실행 가능한 자동화 검증을 추가해 AI Dev Loop의 핵심 동작을 반복 확인할 수 있게 한다.

## 성공 기준

- `npm test`로 실행되는 테스트 스크립트가 추가된다.
- PowerShell 5.1에서 실행 가능한 단위 및 통합 smoke test가 포함된다.
- 테스트는 임시 Git worktree 또는 임시 디렉터리를 사용해 실제 저장소를 오염시키지 않는다.
- auto-goal MaxSteps 기본값과 사용자 지정 값 전달을 검증한다.
- `all_goal_candidates_excluded`의 `expected_non_work` 분류를 검증한다.
- `dirty_worktree`와 `baseline_output_conflict` 상황에서 baseline 사용자 변경이 보존되는지 검증한다.
- 실행 후 새로운 staged 또는 dirty 운영 파일이 남지 않는지 검증한다.
- 테스트 실패 시 0이 아닌 종료 코드를 반환한다.
- 성공 및 실패 항목이 명확히 출력된다.
- 기존 build와 lint 흐름은 유지된다.

## 제약사항

- PowerShell 5.1 호환성을 유지한다.
- 저장소 운영 파일을 테스트 과정에서 오염시키지 않는다.
- 기존 스크립트 구조와 파일 배치를 우선 따른다.
- 한 번에 필요한 최소 파일만 변경한다.
- 기존 build와 lint 동작을 변경하지 않는다.

## 범위 제외

- 앱 기능 변경은 포함하지 않는다.
- UI 변경은 포함하지 않는다.
- 데이터 저장 구조 변경은 포함하지 않는다.
- 대규모 스크립트 재작성은 포함하지 않는다.

## 수동 검증

- `npm test` 실행 결과가 성공하는지 확인한다.
- `ai-dev-check.ps1` 실행 시 테스트 단계가 skipped되지 않는지 확인한다.
- 테스트 실행 후 작업 트리에 의도하지 않은 운영 파일 변경이 남지 않는지 확인한다.

## Current Task

- Task ID: T001
- Title: AI Dev 테스트 스크립트 추가
- Description: 현재 AI Dev 관련 스크립트 구조를 확인한 뒤 PowerShell 5.1에서 실행 가능한 자동화 테스트를 추가하고 `npm test`로 연결한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Verification:
- `npm test`가 테스트 스크립트를 실행한다.
- MaxSteps 기본값과 사용자 지정 값 전달이 검증된다.
- `expected_non_work`, baseline 사용자 변경 보존, 실행 후 작업 트리 청결성이 검증된다.
- 실패 시 0이 아닌 종료 코드와 명확한 실패 출력이 제공된다.

## Review Result

- Decision: revise
- Severity: medium
- Next step: revise_with_codex
- Summary: 앱 변경 자체에서 명확한 결함은 보이지 않지만, 제공된 검증 결과에서 npm test가 skipped라 현재 
task의 핵심 성공 기준이 검증되지 않았다.

## Required Changes

- File: unknown
  - Reason: Test Result에 npm run test가 BuildOnly 옵션으로 skipped 처리되어 `np
m test` 실행 성공, 실패 시 non-zero exit, 새 dirty/staged 파일 미발생 조건이 실제 검증되지 않았다.
  - Suggestion: `npm test` 또는 테스트 단계를 포함한 ai-dev-check를 실행하고, 성공 결과와 작
업 트리 오염 여부를 갱신된 검증 결과에 반영한다.

## Optional Suggestions

- optional_suggestions는 참고만 하며 구현하지 않는다.
- 없음

## Diff Context

# AI Dev Diff

## Generated At

2026-07-31 16:45:38

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
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-test.ps1
```

## App Change Files

- scripts/ai-dev-test.ps1

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
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-test.ps1 | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-test.ps1 b/scripts/ai-dev-test.ps1
index 018cddc..bf077de 100644
--- a/scripts/ai-dev-test.ps1
+++ b/scripts/ai-dev-test.ps1
@@ -275,6 +275,12 @@ function Invoke-IsolatedScenario {
             "expected_non_work"
         )
 
+        $customMaxStepsMatched = $true
+
+        if ($Name -eq "all-goal-candidates-excluded") {
+            $customMaxStepsMatched = $outputText.Contains("MaxSteps=7")
+        }
+
         $markerPreserved = $true
 
         if ($null -ne $markerPath) {
@@ -294,6 +300,13 @@ function Invoke-IsolatedScenario {
             -Name "$Name expected_non_work classification" `
             -Passed $classificationMatched
 
+        if ($Name -eq "all-goal-candidates-excluded") {
+            Write-TestResult `
+                -Name "$Name custom MaxSteps value forwarding" `
+                -Passed $customMaxStepsMatched `
+                -Detail "Expected output fragment: MaxSteps=7"
+        }
+
         Write-TestResult `
             -Name "$Name baseline marker preservation" `
             -Passed $markerPreserved
@@ -368,7 +381,7 @@ Invoke-IsolatedScenario `
         "-AllowDirty",
         "-MaxGoals", "1",
         "-MaxTasks", "1",
-        "-MaxSteps", "40"
+        "-MaxSteps", "7"
     )
 
 Invoke-IsolatedScenario `
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

## 2026-07-31 16:45:27

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

[32m✓ built in 213ms[39m
```
### npm run test

- Status: skipped
- Exit code: 없음

```text
-BuildOnly 옵션으로 건너뛰었습니다.
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