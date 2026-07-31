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

auto-cycle 전체 테스트 실행과 MaxSteps 전달 검증을 보강한다.

## 배경

현재 `scripts/ai-dev-auto-cycle-full.ps1`은 implementation 및 verification task의 check와 check-revise 단계에서 `ai-dev-check.ps1`을 항상 `-BuildOnly`로 실행해 `npm test` 결과가 skipped로 덮어써질 수 있다. 또한 `scripts/ai-dev-test.ps1`의 MaxSteps 사용자 지정 검증은 정규식 확인에 머물러 실제 하위 호출 인수 전달을 충분히 검증하지 못한다.

## 성공 기준

- implementation 및 verification task의 check/check-revise 단계에서 package.json에 test script가 있으면 build, test, lint 전체 검증을 실행한다.
- documentation 또는 analysis task에서 필요한 경우에만 BuildOnly 흐름을 사용한다.
- MaxSteps 사용자 지정 검증은 격리된 임시 작업 공간에서 fake `ai-dev-auto-cycle-full.ps1`을 사용해 `ai-dev-auto-goal.ps1`이 지정된 MaxSteps 값을 실제 하위 호출 인수로 전달했는지 동작 기반으로 확인한다.
- 예시로 MaxSteps 57 지정 시 하위 스크립트가 받은 인수에 57이 기록되는지 검증한다.
- 기존 17개 expected_non_work 테스트와 baseline 보존 테스트를 유지한다.
- 전체 `npm test`가 Failed=0으로 종료되어야 한다.

## 제약사항

- 변경 범위는 관련 PowerShell 스크립트와 테스트에 한정한다.
- 기존 테스트 의도를 유지하고 필요한 검증만 보강한다.
- 로컬 저장소 구조와 기존 AI Dev Loop 상태 파일 형식을 존중한다.
- 큰 구조 변경은 피하고 작은 수정으로 해결한다.

## 범위 제외

- 신규 기능 추가는 제외한다.
- UI 변경은 제외한다.
- 데이터 저장 구조 변경은 제외한다.
- 배포 관련 변경은 제외한다.

## 수동 검증

- 허용된 경우 `npm test`를 실행해 Failed=0인지 확인한다.
- MaxSteps 57 전달 검증 로그 또는 결과가 실제 하위 호출 인수 기반인지 확인한다.

## Current Task

- Task ID: T001
- Title: auto-cycle 검증 흐름 수정
- Description: implementation 및 verification task의 check/check-revise 단계에서 test script가 있으면 build, test, lint 전체 검증을 실행하도록 `scripts/ai-dev-auto-cycle-full.ps1`의 BuildOnly 사용 조건을 조정한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- package.json에 test script가 있는 경우 check/check-revise가 전체 검증 경로를 사용하는지 확인한다.
- analysis 또는 documentation task에서만 필요한 경우 BuildOnly가 유지되는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-31 17:24:41

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

[32m✓ built in 190ms[39m
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

Test summary: Passed=17, Failed=0
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

2026-07-31 17:24:52

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
 M scripts/ai-dev-auto-cycle-full.ps1
```

## App Change Files

- scripts/ai-dev-auto-cycle-full.ps1

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
 scripts/ai-dev-auto-cycle-full.ps1 | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 350b1b2..844d2d6 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -690,6 +690,27 @@ function Get-ReviewImplementationGate {
     }
 }
 
+function Get-CheckCommandSpec {
+    param(
+        [object]$CurrentTask
+    )
+
+    $taskType = if ($null -ne $CurrentTask -and (Test-HasValue $CurrentTask.type)) { [string]$CurrentTask.type } else { "" }
+    $useBuildOnly = $taskType -in @("analysis", "documentation")
+    $arguments = @()
+    $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1"
+
+    if ($useBuildOnly) {
+        $arguments += "-BuildOnly"
+        $command = "$command -BuildOnly"
+    }
+
+    return [PSCustomObject][ordered]@{
+        command = $command
+        arguments = $arguments
+    }
+}
+
 function Get-ChangedAiDevOperationalFiles {
     $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
     $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
@@ -1087,7 +1108,8 @@ while ($script:completedTaskCount -lt $MaxTasks) {
         Invoke-CycleCommand $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty" $scriptPaths.runCodex $runCodexArguments
         $stepNumber++
 
-        Invoke-CycleCommand $stepNumber "check" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly" $scriptPaths.check @("-BuildOnly")
+        $checkSpec = Get-CheckCommandSpec $script:currentTask
+        Invoke-CycleCommand $stepNumber "check" $checkSpec.command $scriptPaths.check $checkSpec.arguments
         $stepNumber++
 
         Invoke-CycleCommand $stepNumber "save-diff" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
@@ -1125,7 +1147,8 @@ while ($script:completedTaskCount -lt $MaxTasks) {
         $stepNumber++
         $script:steps += New-StepResult $stepNumber "run-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $false $true 0 "DryRun: Codex 재수정 실행을 실행하지 않았습니다."
         $stepNumber++
-        $script:steps += New-StepResult $stepNumber "check-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly" $false $true 0 "DryRun: 재수정 검증을 실행하지 않았습니다."
+        $checkSpec = Get-CheckCommandSpec $script:currentTask
+        $script:steps += New-StepResult $stepNumber "check-revise" $checkSpec.command $false $true 0 "DryRun: 재수정 검증을 실행하지 않았습니다."
         $stepNumber++
         $script:steps += New-StepResult $stepNumber "save-diff-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $false $true 0 "DryRun: 재수정 diff 저장을 실행하지 않았습니다."
         $stepNumber++
@@ -1196,7 +1219,8 @@ while ($script:completedTaskCount -lt $MaxTasks) {
         Invoke-CycleCommand $stepNumber "run-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $scriptPaths.runCodex @("-AllowDirty", "-PromptPath", ".ai-dev/revise-prompt.md")
         $stepNumber++
 
-        Invoke-CycleCommand $stepNumber "check-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly" $scriptPaths.check @("-BuildOnly")
+        $checkSpec = Get-CheckCommandSpec $script:currentTask
+        Invoke-CycleCommand $stepNumber "check-revise" $checkSpec.command $scriptPaths.check $checkSpec.arguments
         $stepNumber++
 
         Invoke-CycleCommand $stepNumber "save-diff-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
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