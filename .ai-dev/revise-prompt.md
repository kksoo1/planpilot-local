# AI Dev Revise Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.
이전 리뷰에서 지적된 사항만 수정한다.

## Goal

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
- Verification:
- package.json에 test script가 있는 경우 check/check-revise가 전체 검증 경로를 사용하는지 확인한다.
- analysis 또는 documentation task에서만 필요한 경우 BuildOnly가 유지되는지 확인한다.

## Review Result

- Decision: revise
- Severity: medium
- Next step: revise_with_codex
- Summary: 코드 변경 방향은 현재 task 요구사항과
 대체로 일치하지만, 제공된 검증 결과에서 npm test가 BuildOnly로 skipped 처리되어 Strict Criteria와 
성공 기준을 충족하지 못한다.

## Required Changes

- File: .ai-dev/test-result.md
  - Reason: 이유 없음
  - Suggestion: 현
재 변경 후 check/check-revise 경로가 BuildOnly 없이 실행되는지 검증하고, npm run test가 실제 실행되
어 passed/Failed=0으로 기록된 결과를 갱신한다.

## Optional Suggestions

- optional_suggestions는 참고만 하며 구현하지 않는다.
- File: scrip
ts/ai-dev-auto-cycle-full.ps1
  - Suggestion: Get-CheckCommandSpec 함수는 현재 ta
sk type 기반으로 단순하게 분기해 요구 범위에는 맞는다. 향후 documentation/analysis에서 BuildOnly가 '
필요한 경우'인지 더 세밀히 판단해야 한다면 별도 조건을 추가할 수 있다.

## Diff Context

# AI Dev Diff

## Generated At

2026-07-31 17:12:33

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-auto-cycle-full.ps1
?? .ai-dev/auto-goal-planning-prompt.md
```

## App Change Files

- scripts/ai-dev-auto-cycle-full.ps1

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev/test-result.md
- .ai-dev/auto-goal-planning-prompt.md

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

## Test Result

# AI Dev Test Result

## 2026-07-31 17:12:22

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

[32m✓ built in 258ms[39m
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