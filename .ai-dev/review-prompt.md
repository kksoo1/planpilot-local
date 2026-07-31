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
- Depends on:
- 없음
- Verification:
- `npm test`가 테스트 스크립트를 실행한다.
- MaxSteps 기본값과 사용자 지정 값 전달이 검증된다.
- `expected_non_work`, baseline 사용자 변경 보존, 실행 후 작업 트리 청결성이 검증된다.
- 실패 시 0이 아닌 종료 코드와 명확한 실패 출력이 제공된다.

## Test Result

# AI Dev Test Result

## 2026-07-31 17:02:16

- Overall result: passed
- Current task: T001
- Mode: standard
- Commands:
  - npm run build: passed
  - npm run test: passed
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

[32m✓ built in 202ms[39m
```
### npm run test

- Status: passed
- Exit code: 0

```text

> planpilot-local@0.0.0 test
> powershell -ExecutionPolicy Bypass -File scripts/ai-dev-test.ps1

AI Dev automation tests
Repository: D:\ai-apps\planpilot-local

[PASS] auto-goal MaxSteps default is at least 40
       Detected=40
[PASS] auto-goal forwards user MaxSteps
       Accepted forms: direct argument, array argument, or splatted helper arguments
[PASS] all-goal-candidates-excluded stopped reason
       Expected=all_goal_candidates_excluded ExitCode=1
[PASS] all-goal-candidates-excluded expected_non_work classification
[PASS] all-goal-candidates-excluded custom MaxSteps value forwarding
       Expected output fragment: MaxSteps=7
[PASS] all-goal-candidates-excluded baseline marker preservation
[PASS] all-goal-candidates-excluded no new dirty paths
       NewDirtyPaths=
[PASS] all-goal-candidates-excluded no staged paths
       StagedPaths=
[PASS] dirty-worktree stopped reason
       Expected=dirty_worktree ExitCode=1
[PASS] dirty-worktree expected_non_work classification
[PASS] dirty-worktree baseline marker preservation
[PASS] dirty-worktree no new dirty paths
       NewDirtyPaths=
[PASS] dirty-worktree no staged paths
       StagedPaths=
[PASS] baseline-output-conflict stopped reason
       Expected=baseline_output_conflict ExitCode=1
[PASS] baseline-output-conflict expected_non_work classification
[PASS] baseline-output-conflict baseline marker preservation
[PASS] baseline-output-conflict no new dirty paths
       NewDirtyPaths=
[PASS] baseline-output-conflict no staged paths
       StagedPaths=

Test summary: Passed=18, Failed=0
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

2026-07-31 17:02:27

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
- .ai-dev/revise-prompt.md
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

## Untracked File Content

내용을 포함할 추적되지 않은 텍스트 파일이 없습니다.

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