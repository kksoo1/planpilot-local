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
AI Dev PowerShell UTF-8 출력 표준화

## 배경
Windows PowerShell 5.1에서 AI Dev 관련 PowerShell 스크립트와 하위 스크립트 실행 중 한글 출력이 깨지는 문제가 있다. 공통 UTF-8 초기화 방식을 적용해 콘솔 출력, PowerShell 출력, 파일 읽기와 쓰기, 자식 PowerShell 프로세스 및 npm 실행 결과 캡처에서 한글 메시지가 일관되게 보이도록 개선한다.

## 성공 기준
- `ai-dev-autopilot.ps1`, `ai-dev-auto-goal.ps1`, `ai-dev-auto-cycle-full.ps1` 및 관련 하위 스크립트에서 한글 출력이 깨지지 않는다.
- Console OutputEncoding과 PowerShell OutputEncoding이 PowerShell 5.1 호환 방식으로 UTF-8 처리된다.
- 파일 읽기와 쓰기 인코딩이 UTF-8 기준으로 일관되게 처리된다.
- 자식 powershell 프로세스와 npm 실행 결과를 캡처할 때 한글 메시지가 유지된다.
- 기존 영어 고정 토큰 `Stopped reason`, `Outcome category`, `expected_non_work`는 변경하지 않는다.
- 기존 build, test 20개, lint가 모두 통과한다.

## 제약사항
- PowerShell 5.1 호환성을 유지한다.
- UTF-8 적용을 위해 기존 사용자 파일 내용을 불필요하게 전체 재작성하지 않는다.
- 줄바꿈 형식을 대량 변경하지 않는다.
- 한 번에 변경 범위를 작게 유지하고, 기존 스크립트 구조를 우선 따른다.

## 범위 제외
- AI Dev 워크플로우 자체의 기능 변경은 포함하지 않는다.
- 출력 메시지의 의미 변경이나 영어 고정 토큰 변경은 포함하지 않는다.
- 관련 없는 파일 정리나 대규모 리팩터링은 포함하지 않는다.

## 수동 검증
- PowerShell 5.1에서 주요 AI Dev 스크립트를 실행해 한글 출력이 정상 표시되는지 확인한다.
- 자식 PowerShell 실행 결과와 npm 실행 결과 캡처 로그에서 한글이 깨지지 않는지 확인한다.
- 허용된 경우 build, test 20개, lint를 실행해 모두 통과하는지 확인한다.

## Current Task

- Task ID: T001
- Title: PowerShell UTF-8 처리 흐름 점검 및 최소 수정
- Description: AI Dev PowerShell 스크립트의 출력 인코딩 초기화, 파일 입출력 인코딩, 자식 PowerShell 및 npm 결과 캡처 흐름을 확인하고 PowerShell 5.1 호환 방식으로 필요한 최소 변경을 적용한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- PowerShell 5.1에서 한글 출력이 깨지지 않는지 주요 스크립트 실행 결과를 확인한다.
- 자식 powershell 프로세스와 npm 실행 결과 캡처에서 한글 메시지가 유지되는지 확인한다.
- 기존 영어 고정 토큰 `Stopped reason`, `Outcome category`, `expected_non_work`가 유지되는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-08-02 23:18:34

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

[32m✓ built in 183ms[39m
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
[PASS] maxsteps-forwarding forwards MaxSteps 57 to child script
       Expected=57 Actual=57 ExitCode=1 Args=-MaxTasks 3 -MaxSteps 57 -AllowCodex -AllowReviewCodex -AllowCommit -AllowDirty -ProtectedBaselineDirtyPaths scripts/ai-dev-auto-cycle-full.ps1,scripts/ai-dev-auto-goal.ps1
[PASS] maxsteps-forwarding forwards MaxTasks and allow switches
       ExpectedMaxTasks=3 ActualMaxTasks=3 MissingSwitches=
[PASS] maxsteps-forwarding fake child exited successfully
       AutoGoalExitCode=1
[PASS] maxsteps-forwarding child script was invoked
       ExitCode=1 OutputPreview=Step 1: validate-input    Command: check GoalTitle/GoalDescription    Executed: False    Skipped: False    Exit code: 0    Message: Input validation completed: MaxSteps forwarding test  Step 2: dirty-worktree-gate    Command: git status --porcelain    Executed: True    Skipped: False    Exit code: 0    Message: AllowDirty is set. Baseline dirty count: 2  Step 3: plan-goal    Command: codex exec <auto-goal planning prompt>    Executed: True    Skipped: False    Exit code: 0    Message: Codex goal planning completed. Result: .ai-dev/codex-result.md  Step 4: validate-generated-json    Command: goal/queue/state JSON validation    Executed: False    Skipped: False    Exit code: 0    Message: goalMarkdown, queue, and state JSON validation completed. currentTaskId: T001  Step 5: write-state-files    Command: .ai-dev/goal.md, .ai-dev/queue.json, .ai-dev/state.json    Executed: True    Skipped: False    Exit code: 0    Message: New goal, queue, and state files were written.  Step 6: make-prompt    Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1    Executed: True    Skipped: False    Exit code: 0    Message: 생성된 프롬프트 파일: .ai-dev/current-task-prompt.md  Current task id: T001  Current task title: Forwarding test  Step 7: auto-cycle-full    Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -MaxTasks 3 -MaxSteps 57 -AllowCodex -AllowReviewCodex -AllowCommit -AllowDirty -ProtectedBaselineDirtyPaths scripts/ai-dev-auto-cycle-full.ps1,scripts/ai-dev-auto-goal.ps1    Executed: True    Skipped: False    Exit code: 0    Message: completed  Step 8: verify-goal-status    Command: .ai-dev/state.json goalStatus 확인    Executed: False    Skipped: False    Exit code: 0    Message: auto-cycle-full 성공 후 goalStatus completed 확인.  Step 9: final-change-gate    Command: cleanup auto-goal temp artifacts, git status --short    Executed: True    Skipped: False    Exit code: 1    Message: Final clean verification failed: baseline dirty files remain, so auto-goal will not report completed.  Baseline dirty count: 2  Final dirty count: 7  Final .ai-dev meta commit created: skipped (baseline dirty remains).  Remaining baseline dirty paths:  scripts/ai-dev-auto-cycle-full.ps1  scripts/ai-dev-auto-goal.ps1   M .ai-dev/codex-result.md   M .ai-dev/current-task-prompt.md   M .ai-dev/goal.md   M .ai-dev/queue.json   M .ai-dev/state.json   M scripts/ai-dev-auto-cycle-full.ps1   M scripts/ai-dev-auto-goal.ps1  Plan preview:    Goal title: Forwarding test    Current task id: T001    Task T001: Forwarding test      Type: implementation      Status: in_progress      Priority: P0      Likely files: scripts/ai-dev-test.ps1      Verification: Verify MaxSteps forwarding.  Stopped reason: final_baseline_dirty_remains  Outcome category: actual_failure  Completed: False  Exit code: 1
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

Test summary: Passed=20, Failed=0
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

2026-08-02 23:18:44

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
 M .ai-dev/scripts/run-codex-review.ps1
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-auto-cycle-full.ps1
 M scripts/ai-dev-auto-cycle.ps1
 M scripts/ai-dev-auto-goal.ps1
 M scripts/ai-dev-auto-step.ps1
 M scripts/ai-dev-autopilot.ps1
 M scripts/ai-dev-check.ps1
 M scripts/ai-dev-copy-review-prompt.ps1
 M scripts/ai-dev-env.ps1
 M scripts/ai-dev-run-codex.ps1
 M scripts/ai-dev-run-review-codex.ps1
 M scripts/ai-dev-save-diff.ps1
 M scripts/ai-dev-test.ps1
```

## App Change Files

- scripts/ai-dev-auto-cycle-full.ps1
- scripts/ai-dev-auto-cycle.ps1
- scripts/ai-dev-auto-goal.ps1
- scripts/ai-dev-auto-step.ps1
- scripts/ai-dev-autopilot.ps1
- scripts/ai-dev-check.ps1
- scripts/ai-dev-copy-review-prompt.ps1
- scripts/ai-dev-env.ps1
- scripts/ai-dev-run-codex.ps1
- scripts/ai-dev-run-review-codex.ps1
- scripts/ai-dev-save-diff.ps1
- scripts/ai-dev-test.ps1

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
- .ai-dev/scripts/run-codex-review.ps1
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-auto-cycle-full.ps1    |  2 +-
 scripts/ai-dev-auto-cycle.ps1         |  2 +-
 scripts/ai-dev-auto-goal.ps1          |  2 +-
 scripts/ai-dev-auto-step.ps1          |  4 ++--
 scripts/ai-dev-autopilot.ps1          |  2 +-
 scripts/ai-dev-check.ps1              |  2 +-
 scripts/ai-dev-copy-review-prompt.ps1 |  2 +-
 scripts/ai-dev-env.ps1                | 12 +++++++++---
 scripts/ai-dev-run-codex.ps1          |  2 +-
 scripts/ai-dev-run-review-codex.ps1   |  4 ++--
 scripts/ai-dev-save-diff.ps1          | 14 ++++++++++++++
 scripts/ai-dev-test.ps1               |  3 ++-
 12 files changed, 36 insertions(+), 15 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 844d2d6..c116e2b 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -474,7 +474,7 @@ function Invoke-CycleCommand {
         return
     }
 
-    $output = & powershell -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1 | Out-String
+    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1 | Out-String
     $exitCode = $LASTEXITCODE
     $message = $output.Trim()
 
diff --git a/scripts/ai-dev-auto-cycle.ps1 b/scripts/ai-dev-auto-cycle.ps1
index 2d131c2..3e09a44 100644
--- a/scripts/ai-dev-auto-cycle.ps1
+++ b/scripts/ai-dev-auto-cycle.ps1
@@ -455,7 +455,7 @@ for ($index = 1; $index -le $MaxSteps; $index++) {
         $arguments += "-AllowReviewPrompt"
     }
 
-    $autoStepOutput = & powershell -ExecutionPolicy Bypass -File $autoStepPath @arguments 2>&1 | Out-String
+    $autoStepOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File $autoStepPath @arguments 2>&1 | Out-String
     $autoStepExitCode = $LASTEXITCODE
 
     if ($autoStepExitCode -ne 0) {
diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 070042f..0f036a2 100644
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -1316,7 +1316,7 @@ function Invoke-CycleCommand {
         return
     }
 
-    $output = & powershell -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1 | Out-String
+    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1 | Out-String
     $exitCode = $LASTEXITCODE
     $message = $output.Trim()
 
diff --git a/scripts/ai-dev-auto-step.ps1 b/scripts/ai-dev-auto-step.ps1
index 7dcf2c9..b297c30 100644
--- a/scripts/ai-dev-auto-step.ps1
+++ b/scripts/ai-dev-auto-step.ps1
@@ -62,7 +62,7 @@ function Invoke-AiDevScript {
         throw "스크립트를 찾을 수 없습니다: $ScriptName"
     }
 
-    $output = & powershell -ExecutionPolicy Bypass -File $scriptPath @Arguments 2>&1 | Out-String
+    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath @Arguments 2>&1 | Out-String
     $exitCode = $LASTEXITCODE
 
     return [PSCustomObject]@{
@@ -98,7 +98,7 @@ function Write-StepResult {
 }
 
 try {
-    $nextOutput = & powershell -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "ai-dev-next.ps1") -Json 2>&1 | Out-String
+    $nextOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "ai-dev-next.ps1") -Json 2>&1 | Out-String
 
     if ($LASTEXITCODE -ne 0) {
         Stop-WithJsonError "ai-dev-next.ps1 실행에 실패했습니다: $nextOutput"
diff --git a/scripts/ai-dev-autopilot.ps1 b/scripts/ai-dev-autopilot.ps1
index 4c8c3f2..dd9588c 100644
--- a/scripts/ai-dev-autopilot.ps1
+++ b/scripts/ai-dev-autopilot.ps1
@@ -1097,7 +1097,7 @@ function Invoke-AutoGoal {
         }
     }
 
-    $output = & powershell -ExecutionPolicy Bypass -File $autoGoalPath @arguments 2>&1 | Out-String
+    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File $autoGoalPath @arguments 2>&1 | Out-String
     $exitCode = $LASTEXITCODE
     $message = $output.Trim()
 
diff --git a/scripts/ai-dev-check.ps1 b/scripts/ai-dev-check.ps1
index 024cc3d..9264577 100644
--- a/scripts/ai-dev-check.ps1
+++ b/scripts/ai-dev-check.ps1
@@ -84,7 +84,7 @@ function Invoke-NpmCheck {
     }
 
     Write-Host "실행 중: $command"
-    $output = & npm run $Name 2>&1 | Out-String
+    $output = & npm.cmd run $Name 2>&1 | Out-String
     $exitCode = $LASTEXITCODE
     $status = if ($exitCode -eq 0) { "passed" } else { "failed" }
 
diff --git a/scripts/ai-dev-copy-review-prompt.ps1 b/scripts/ai-dev-copy-review-prompt.ps1
index d640570..060934e 100644
--- a/scripts/ai-dev-copy-review-prompt.ps1
+++ b/scripts/ai-dev-copy-review-prompt.ps1
@@ -99,7 +99,7 @@ if (-not (Test-Path -LiteralPath $reviewPromptPath -PathType Leaf)) {
         $arguments += "-Strict"
     }
 
-    $makeReviewOutput = & powershell -ExecutionPolicy Bypass -File $makeReviewPromptPath @arguments 2>&1 | Out-String
+    $makeReviewOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File $makeReviewPromptPath @arguments 2>&1 | Out-String
 
     if ($LASTEXITCODE -ne 0) {
         Write-CopyResult `
diff --git a/scripts/ai-dev-env.ps1 b/scripts/ai-dev-env.ps1
index 39cbe1a..b9bd368 100644
--- a/scripts/ai-dev-env.ps1
+++ b/scripts/ai-dev-env.ps1
@@ -1,8 +1,14 @@
 ﻿try {
+    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
+
     chcp 65001 | Out-Null
-    $OutputEncoding = [System.Text.Encoding]::UTF8
-    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
-    [Console]::InputEncoding = [System.Text.Encoding]::UTF8
+    [Console]::OutputEncoding = $utf8NoBom
+    [Console]::InputEncoding = $utf8NoBom
+    $OutputEncoding = $utf8NoBom
+
+    $env:PYTHONIOENCODING = "utf-8"
+    $env:PYTHONUTF8 = "1"
+    $env:npm_config_unicode = "true"
 } catch {
     # UTF-8 콘솔 설정 실패는 AI Dev 스크립트 실행을 중단하지 않는다.
 }
diff --git a/scripts/ai-dev-run-codex.ps1 b/scripts/ai-dev-run-codex.ps1
index 0556efc..edb7cd0 100644
--- a/scripts/ai-dev-run-codex.ps1
+++ b/scripts/ai-dev-run-codex.ps1
@@ -187,7 +187,7 @@ if (-not (Test-Path -LiteralPath $resolvedPromptPath -PathType Leaf)) {
         Write-RunResult "run_codex" $false 1 "프롬프트 생성 스크립트를 찾을 수 없습니다: scripts/ai-dev-make-prompt.ps1"
     }
 
-    $makePromptOutput = & powershell -ExecutionPolicy Bypass -File $makePromptPath 2>&1 | Out-String
+    $makePromptOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File $makePromptPath 2>&1 | Out-String
 
     if ($LASTEXITCODE -ne 0) {
         Write-RunResult "run_codex" $false 1 "프롬프트 생성에 실패했습니다: $($makePromptOutput.Trim())"
diff --git a/scripts/ai-dev-run-review-codex.ps1 b/scripts/ai-dev-run-review-codex.ps1
index 389f5b4..5799ca6 100644
--- a/scripts/ai-dev-run-review-codex.ps1
+++ b/scripts/ai-dev-run-review-codex.ps1
@@ -355,7 +355,7 @@ if (-not $promptExists -and $GenerateReviewPromptIfMissing) {
         Write-RunResult "run_review_codex" $false 1 "리뷰 프롬프트 생성 스크립트를 찾을 수 없습니다: scripts/ai-dev-make-review-prompt.ps1"
     }
 
-    $makeReviewPromptOutput = & powershell -ExecutionPolicy Bypass -File $makeReviewPromptPath 2>&1 | Out-String
+    $makeReviewPromptOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File $makeReviewPromptPath 2>&1 | Out-String
 
     if ($LASTEXITCODE -ne 0) {
         Write-RunResult "run_review_codex" $false 1 "리뷰 프롬프트 생성에 실패했습니다: $($makeReviewPromptOutput.Trim())"
@@ -421,7 +421,7 @@ if ($SaveReview) {
         Write-RunResult "run_review_codex" $true 1 "리뷰 저장 스크립트를 찾을 수 없습니다: scripts/ai-dev-save-review.ps1"
     }
 
-    $saveReviewOutput = & powershell -ExecutionPolicy Bypass -File $saveReviewPath -ReviewFile $reviewResponseRelativePath 2>&1 | Out-String
+    $saveReviewOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File $saveReviewPath -ReviewFile $reviewResponseRelativePath 2>&1 | Out-String
 
     if ($LASTEXITCODE -ne 0) {
         Write-RunResult "run_review_codex" $true 1 "리뷰 JSON은 저장했지만 save-review 실행에 실패했습니다: $($saveReviewOutput.Trim())"
diff --git a/scripts/ai-dev-save-diff.ps1 b/scripts/ai-dev-save-diff.ps1
index fcaed07..37ff89f 100644
--- a/scripts/ai-dev-save-diff.ps1
+++ b/scripts/ai-dev-save-diff.ps1
@@ -50,6 +50,19 @@ function Set-ObjectProperty {
     }
 }
 
+function Set-ProcessStartInfoUtf8Encoding {
+    param(
+        [System.Diagnostics.ProcessStartInfo]$StartInfo
+    )
+
+    try {
+        $StartInfo.StandardOutputEncoding = [System.Text.Encoding]::UTF8
+        $StartInfo.StandardErrorEncoding = [System.Text.Encoding]::UTF8
+    } catch {
+        Write-Warning "ProcessStartInfo UTF-8 인코딩 속성을 설정할 수 없어 기본 인코딩으로 진행합니다: $($_.Exception.Message)"
+    }
+}
+
 function Save-StateResult {
     param(
         [object]$State,
@@ -87,6 +100,7 @@ function Invoke-GitCapture {
     $startInfo.RedirectStandardOutput = $true
     $startInfo.RedirectStandardError = $true
     $startInfo.CreateNoWindow = $true
+    Set-ProcessStartInfoUtf8Encoding $startInfo
 
     $process = New-Object System.Diagnostics.Process
     $process.StartInfo = $startInfo
diff --git a/scripts/ai-dev-test.ps1 b/scripts/ai-dev-test.ps1
index 5933e25..c789156 100644
--- a/scripts/ai-dev-test.ps1
+++ b/scripts/ai-dev-test.ps1
@@ -254,6 +254,7 @@ exit 0
 
         try {
             $output = & powershell `
+                -NoProfile `
                 -ExecutionPolicy Bypass `
                 -File ".\scripts\ai-dev-auto-goal.ps1" `
                 -GoalTitle "MaxSteps forwarding test" `
@@ -501,7 +502,7 @@ function Invoke-IsolatedScenario {
         Push-Location $tmpRoot
 
         try {
-            $output = & powershell @CommandArguments 2>&1
+            $output = & powershell -NoProfile @CommandArguments 2>&1
             $scenarioExitCode = $LASTEXITCODE
             $outputText = $output | Out-String
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