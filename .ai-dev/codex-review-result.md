# Codex Review Result

## Run

- Started at: 2026-08-02 23:18:48
- Ended at: 2026-08-02 23:20:25
- Exit code: 0
- Review prompt: .ai-dev/review-prompt.md
- Review response: .ai-dev/review-response.json
- Command: codex exec <short wrapper pointing to .ai-dev/review-prompt.md>

## Output

```text
node.exe : OpenAI Codex v0.133.0
위치 C:\Users\SECUI\AppData\Roaming\npm\codex.ps1:24 문자:5
+     & "node$exe"  "$basedir/node_modules/@openai/codex/bin/codex.js"  ...
+     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (OpenAI Codex v0.133.0:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 
--------
workdir: D:\ai-apps\planpilot-local
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: medium
reasoning summaries: none
session id: 019fc2d7-77d2-7081-831f-adea7f9819e6
--------
user
Read and follow the full review prompt at this absolute file path: D:\ai-apps\planpilot-local\.ai-dev
\review-prompt.md
codex
요청하신 리뷰 지침 파일을 먼저 읽고, 그 안의 범위와 출력 형식을 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath '
D:\\ai-apps\\planpilot-local\\.ai-dev\\review-prompt.md'" in D:\ai-apps\planpilot-local
 succeeded in 1900ms:
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
Windows PowerShell 5.1에서 AI Dev 관련 PowerShell 스크립트와 하위 스크립트 실행 중 한글 출력이 깨지는 문제가 있다. 공통 UTF-8 초기화 방식을 
적용해 콘솔 출력, PowerShell 출력, 파일 읽기와 쓰기, 자식 PowerShell 프로세스 및 npm 실행 결과 캡처에서 한글 메시지가 일관되게 보이도록 개선한다.

## 성공 기준
- `ai-dev-autopilot.ps1`, `ai-dev-auto-goal.ps1`, `ai-dev-auto-cycle-full.ps1` 및 관련 하위 스크립트에서 한글 출력이 
깨지지 않는다.
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
- Description: AI Dev PowerShell 스크립트의 출력 인코딩 초기화, 파일 입출력 인코딩, 자식 PowerShell 및 npm 결과 캡처 흐름을 확인하고 Pow
erShell 5.1 호환 방식으로 필요한 최소 변경을 적용한다.
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
       Expected=57 Actual=57 ExitCode=1 Args=-MaxTasks 3 -MaxSteps 57 -AllowCodex -AllowReviewCodex -
AllowCommit -AllowDirty -ProtectedBaselineDirtyPaths scripts/ai-dev-auto-cycle-full.ps1,scripts/ai-de
v-auto-goal.ps1
[PASS] maxsteps-forwarding forwards MaxTasks and allow switches
       ExpectedMaxTasks=3 ActualMaxTasks=3 MissingSwitches=
[PASS] maxsteps-forwarding fake child exited successfully
       AutoGoalExitCode=1
[PASS] maxsteps-forwarding child script was invoked
       ExitCode=1 OutputPreview=Step 1: validate-input    Command: check GoalTitle/GoalDescription   
 Executed: False    Skipped: False    Exit code: 0    Message: Input validation completed: MaxSteps f
orwarding test  Step 2: dirty-worktree-gate    Command: git status --porcelain    Executed: True    S
kipped: False    Exit code: 0    Message: AllowDirty is set. Baseline dirty count: 2  Step 3: plan-go
al    Command: codex exec <auto-goal planning prompt>    Executed: True    Skipped: False    Exit cod
e: 0    Message: Codex goal planning completed. Result: .ai-dev/codex-result.md  Step 4: validate-gen
erated-json    Command: goal/queue/state JSON validation    Executed: False    Skipped: False    Exit
 code: 0    Message: goalMarkdown, queue, and state JSON validation completed. currentTaskId: T001  S
tep 5: write-state-files    Command: .ai-dev/goal.md, .ai-dev/queue.json, .ai-dev/state.json    Execu
ted: True    Skipped: False    Exit code: 0    Message: New goal, queue, and state files were written
.  Step 6: make-prompt    Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-promp
t.ps1    Executed: True    Skipped: False    Exit code: 0    Message: 생성된 프롬프트 파일: .ai-dev/current-ta
sk-prompt.md  Current task id: T001  Current task title: Forwarding test  Step 7: auto-cycle-full    
Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -MaxTasks 3 -Max
Steps 57 -AllowCodex -AllowReviewCodex -AllowCommit -AllowDirty -ProtectedBaselineDirtyPaths scripts/
ai-dev-auto-cycle-full.ps1,scripts/ai-dev-auto-goal.ps1    Executed: True    Skipped: False    Exit c
ode: 0    Message: completed  Step 8: verify-goal-status    Command: .ai-dev/state.json goalStatus 확인
    Executed: False    Skipped: False    Exit code: 0    Message: auto-cycle-full 성공 후 goalStatus com
pleted 확인.  Step 9: final-change-gate    Command: cleanup auto-goal temp artifacts, git status --shor
t    Executed: True    Skipped: False    Exit code: 1    Message: Final clean verification failed: ba
seline dirty files remain, so auto-goal will not report completed.  Baseline dirty count: 2  Final di
rty count: 7  Final .ai-dev meta commit created: skipped (baseline dirty remains).  Remaining baselin
e dirty paths:  scripts/ai-dev-auto-cycle-full.ps1  scripts/ai-dev-auto-goal.ps1   M .ai-dev/codex-re
sult.md   M .ai-dev/current-task-prompt.md   M .ai-dev/goal.md   M .ai-dev/queue.json   M .ai-dev/sta
te.json   M scripts/ai-dev-auto-cycle-full.ps1   M scripts/ai-dev-auto-goal.ps1  Plan preview:    Goa
l title: Forwarding test    Current task id: T001    Task T001: Forwarding test      Type: implementa
tion      Status: in_progress      Priority: P0      Likely files: scripts/ai-dev-test.ps1      Verif
ication: Verify MaxSteps forwarding.  Stopped reason: final_baseline_dirty_remains  Outcome category:
 actual_failure  Completed: False  Exit code: 1
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
+    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1 | Ou
t-String
     $exitCode = $LASTEXITCODE
     $message = $output.Trim()
 
diff --git a/scripts/ai-dev-auto-cycle.ps1 b/scripts/ai-dev-auto-cycle.ps1
index 2d131c2..3e09a44 100644
--- a/scripts/ai-dev-auto-cycle.ps1
+++ b/scripts/ai-dev-auto-cycle.ps1
@@ -455,7 +455,7 @@ for ($index = 1; $index -le $MaxSteps; $index++) {
         $arguments += "-AllowReviewPrompt"
     }
 
-    $autoStepOutput = & powershell -ExecutionPolicy Bypass -File $autoStepPath @arguments 2>&1 | Out
-String
+    $autoStepOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File $autoStepPath @arguments
 2>&1 | Out-String
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
+    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1 | Ou
t-String
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
+    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath @Arguments 2>&1 | Ou
t-String
     $exitCode = $LASTEXITCODE
 
     return [PSCustomObject]@{
@@ -98,7 +98,7 @@ function Write-StepResult {
 }
 
 try {
-    $nextOutput = & powershell -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "ai-dev-next.p
s1") -Json 2>&1 | Out-String
+    $nextOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "ai
-dev-next.ps1") -Json 2>&1 | Out-String
 
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
+    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File $autoGoalPath @arguments 2>&1 | 
Out-String
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
 
-    $makeReviewOutput = & powershell -ExecutionPolicy Bypass -File $makeReviewPromptPath @arguments 
2>&1 | Out-String
+    $makeReviewOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File $makeReviewPromptPath 
@arguments 2>&1 | Out-String
 
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
         Write-RunResult "run_codex" $false 1 "프롬프트 생성 스크립트를 찾을 수 없습니다: scripts/ai-dev-make-prompt.ps
1"
     }
 
-    $makePromptOutput = & powershell -ExecutionPolicy Bypass -File $makePromptPath 2>&1 | Out-String
+    $makePromptOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File $makePromptPath 2>&1 |
 Out-String
 
     if ($LASTEXITCODE -ne 0) {
         Write-RunResult "run_codex" $false 1 "프롬프트 생성에 실패했습니다: $($makePromptOutput.Trim())"
diff --git a/scripts/ai-dev-run-review-codex.ps1 b/scripts/ai-dev-run-review-codex.ps1
index 389f5b4..5799ca6 100644
--- a/scripts/ai-dev-run-review-codex.ps1
+++ b/scripts/ai-dev-run-review-codex.ps1
@@ -355,7 +355,7 @@ if (-not $promptExists -and $GenerateReviewPromptIfMissing) {
         Write-RunResult "run_review_codex" $false 1 "리뷰 프롬프트 생성 스크립트를 찾을 수 없습니다: scripts/ai-dev-make
-review-prompt.ps1"
     }
 
-    $makeReviewPromptOutput = & powershell -ExecutionPolicy Bypass -File $makeReviewPromptPath 2>&1 
| Out-String
+    $makeReviewPromptOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File $makeReviewPromp
tPath 2>&1 | Out-String
 
     if ($LASTEXITCODE -ne 0) {
         Write-RunResult "run_review_codex" $false 1 "리뷰 프롬프트 생성에 실패했습니다: $($makeReviewPromptOutput.T
rim())"
@@ -421,7 +421,7 @@ if ($SaveReview) {
         Write-RunResult "run_review_codex" $true 1 "리뷰 저장 스크립트를 찾을 수 없습니다: scripts/ai-dev-save-revie
w.ps1"
     }
 
-    $saveReviewOutput = & powershell -ExecutionPolicy Bypass -File $saveReviewPath -ReviewFile $revi
ewResponseRelativePath 2>&1 | Out-String
+    $saveReviewOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File $saveReviewPath -Revie
wFile $reviewResponseRelativePath 2>&1 | Out-String
 
     if ($LASTEXITCODE -ne 0) {
         Write-RunResult "run_review_codex" $true 1 "리뷰 JSON은 저장했지만 save-review 실행에 실패했습니다: $($saveRe
viewOutput.Trim())"
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
+        Write-Warning "ProcessStartInfo UTF-8 인코딩 속성을 설정할 수 없어 기본 인코딩으로 진행합니다: $($_.Exception.Messag
e)"
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

codex
리뷰 프롬프트에는 JSON만 최종 출력하라는 형식 제약이 있습니다. 실제 변경 파일 중심으로 확인하되, git 명령은 이 저장소 규칙상 허용되지 않아 프롬프트에 포함된 diff와 필
요한 스크립트 본문 읽기로 판단하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath '
D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-env.ps1'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath '
D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-step.ps1'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath '
D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-save-diff.ps1'" in D:\ai-apps\planpilot-local
 succeeded in 2965ms:
try {
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)

    chcp 65001 | Out-Null
    [Console]::OutputEncoding = $utf8NoBom
    [Console]::InputEncoding = $utf8NoBom
    $OutputEncoding = $utf8NoBom

    $env:PYTHONIOENCODING = "utf-8"
    $env:PYTHONUTF8 = "1"
    $env:npm_config_unicode = "true"
} catch {
    # UTF-8 콘솔 설정 실패는 AI Dev 스크립트 실행을 중단하지 않는다.
}

 succeeded in 2966ms:
param(
    [switch]$Json,
    [switch]$DryRun,
    [switch]$AllowCheck,
    [switch]$AllowReviewPrompt,
    [switch]$AllowSaveDiff
)

. "$PSScriptRoot\ai-dev-env.ps1"

function Stop-WithJsonError {
    param(
        [string]$Message
    )

    $result = [ordered]@{
        action = "error"
        executed = $false
        dryRun = [bool]$DryRun
        exitCode = 1
        message = $Message
        recommendedCommands = @()
    }

    if ($Json) {
        $result | ConvertTo-Json -Depth 10
    } else {
        Write-Error $Message
    }

    exit 1
}

function New-StepResult {
    param(
        [string]$Action,
        [bool]$Executed,
        [int]$ExitCode,
        [string]$Message,
        [string[]]$RecommendedCommands
    )

    return [ordered]@{
        action = $Action
        executed = $Executed
        dryRun = [bool]$DryRun
        exitCode = $ExitCode
        message = $Message
        recommendedCommands = @($RecommendedCommands)
    }
}

function Invoke-AiDevScript {
    param(
        [string]$ScriptName,
        [string[]]$Arguments
    )

    $scriptPath = Join-Path $PSScriptRoot $ScriptName

    if (-not (Test-Path -LiteralPath $scriptPath -PathType Leaf)) {
        throw "스크립트를 찾을 수 없습니다: $ScriptName"
    }

    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath @Arguments 2>&1 | Out
-String
    $exitCode = $LASTEXITCODE

    return [PSCustomObject]@{
        ExitCode = $exitCode
        Output = $output.TrimEnd()
    }
}

function Write-StepResult {
    param(
        [object]$Result
    )

    if ($Json) {
        $Result | ConvertTo-Json -Depth 10
        return
    }

    Write-Host "Action: $($Result.action)"
    Write-Host "Executed: $($Result.executed)"
    Write-Host "Dry run: $($Result.dryRun)"
    Write-Host "Exit code: $($Result.exitCode)"
    Write-Host "Message: $($Result.message)"
    Write-Host "Recommended commands:"

    if ($Result.recommendedCommands.Count -eq 0) {
        Write-Host "  - 없음"
    } else {
        foreach ($command in $Result.recommendedCommands) {
            Write-Host "  - $command"
        }
    }
}

try {
    $nextOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "ai-
dev-next.ps1") -Json 2>&1 | Out-String

    if ($LASTEXITCODE -ne 0) {
        Stop-WithJsonError "ai-dev-next.ps1 실행에 실패했습니다: $nextOutput"
    }

    $next = $nextOutput | ConvertFrom-Json
} catch {
    Stop-WithJsonError "다음 action 판단에 실패했습니다: $($_.Exception.Message)"
}

$action = [string]$next.action
$recommendedCommands = @($next.recommendedCommands)
$commandDisplay = if ($recommendedCommands.Count -gt 0) { $recommendedCommands[0] } else { "" }
$scriptToRun = $null
$scriptArguments = @()
$shouldExecute = $false
$message = ""

switch ($action) {
    "make_task_prompt" {
        $scriptToRun = "ai-dev-make-prompt.ps1"
        $shouldExecute = $true
        $message = "현재 task 프롬프트를 생성합니다."
    }
    "run_check" {
        $scriptToRun = "ai-dev-check.ps1"
        $scriptArguments = @("-BuildOnly")
        $shouldExecute = [bool]$AllowCheck
        $message = if ($AllowCheck) {
            "검증을 실행합니다: ai-dev-check.ps1 -BuildOnly"
        } else {
            "검증 단계는 기본 자동 실행 대상이 아닙니다. 실행하려면 -AllowCheck를 사용하세요."
        }
    }
    "save_diff" {
        $scriptToRun = "ai-dev-save-diff.ps1"
        $scriptArguments = @("-IncludeUntrackedContent")
        $shouldExecute = [bool]$AllowSaveDiff
        $message = if ($AllowSaveDiff) {
            "diff를 저장합니다: ai-dev-save-diff.ps1 -IncludeUntrackedContent"
        } else {
            "diff 저장은 기본 자동 실행 대상이 아닙니다. 실행하려면 -AllowSaveDiff를 사용하세요."
        }
    }
    "make_review_prompt" {
        $scriptToRun = "ai-dev-make-review-prompt.ps1"
        $scriptArguments = @("-Strict")
        $shouldExecute = [bool]$AllowReviewPrompt
        $message = if ($AllowReviewPrompt) {
            "리뷰 프롬프트를 생성합니다: ai-dev-make-review-prompt.ps1 -Strict"
        } else {
            "리뷰 프롬프트 생성은 기본 자동 실행 대상이 아닙니다. 실행하려면 -AllowReviewPrompt를 사용하세요."
        }
    }
    default {
        if ($action -eq "ask_gpt_review") {
            $reviewBridgeCommands = @(
                "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1",
                "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboa
rd"
            )
            $result = New-StepResult `
                -Action $action `
                -Executed $false `
                -ExitCode 0 `
                -Message "GPT API는 호출하지 않습니다. review-prompt를 클립보드에 복사해 ChatGPT 웹 화면에 붙여넣고, JSON 리뷰만 받
은 뒤 JSON 리뷰를 클립보드에 복사해 save-review -FromClipboard를 실행하세요." `
                -RecommendedCommands $reviewBridgeCommands
            Write-StepResult $result
            exit 0
        }

        if ($action -eq "goal_completed") {
            $goalCompletedCommands = @(
                "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1"
            )
            $result = New-StepResult `
                -Action $action `
                -Executed $false `
                -ExitCode 0 `
                -Message "현재 goal은 completed 상태입니다. 더 실행할 task가 없습니다. 다음 목표를 시작하려면 .ai-dev/goal.md, .
ai-dev/queue.json, .ai-dev/state.json을 새 목표로 초기화하세요. 상태 확인 명령: powershell -ExecutionPolicy Bypass -Fi
le scripts/ai-dev-status.ps1" `
                -RecommendedCommands $goalCompletedCommands
            Write-StepResult $result
            exit 0
        }

        $forbiddenActions = @(
            "run_codex_or_cline",
            "ask_gpt_review",
            "make_revise_prompt",
            "commit",
            "complete_task",
            "stop_for_user",
            "blocked",
            "goal_completed",
            "no_task",
            "inspect_status"
        )

        if ($forbiddenActions -contains $action) {
            $result = New-StepResult `
                -Action $action `
                -Executed $false `
                -ExitCode 0 `
                -Message "이 action은 auto-step에서 자동 실행하지 않습니다. 추천 명령 또는 사용자 판단이 필요합니다." `
                -RecommendedCommands $recommendedCommands
            Write-StepResult $result
            exit 0
        }

        $result = New-StepResult `
            -Action $action `
            -Executed $false `
            -ExitCode 0 `
            -Message "알 수 없는 action입니다. 상태를 수동으로 확인하세요." `
            -RecommendedCommands @("powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps
1")
        Write-StepResult $result
        exit 0
    }
}

if ($DryRun -or -not $shouldExecute) {
    $result = New-StepResult `
        -Action $action `
        -Executed $false `
        -ExitCode 0 `
        -Message $message `
        -RecommendedCommands $(if ([string]::IsNullOrWhiteSpace($commandDisplay)) { @() } else { @($c
ommandDisplay) })
    Write-StepResult $result
    exit 0
}

try {
    $childResult = Invoke-AiDevScript -ScriptName $scriptToRun -Arguments $scriptArguments

    if ($childResult.ExitCode -ne 0) {
        $result = New-StepResult `
            -Action $action `
            -Executed $true `
            -ExitCode $childResult.ExitCode `
            -Message "하위 스크립트 실행에 실패했습니다: $($childResult.Output)" `
            -RecommendedCommands $recommendedCommands
        Write-StepResult $result
        exit 1
    }

    $result = New-StepResult `
        -Action $action `
        -Executed $true `
        -ExitCode 0 `
        -Message $message `
        -RecommendedCommands $recommendedCommands
    Write-StepResult $result
    exit 0
} catch {
    $result = New-StepResult `
        -Action $action `
        -Executed $true `
        -ExitCode 1 `
        -Message "auto-step 실행에 실패했습니다: $($_.Exception.Message)" `
        -RecommendedCommands $recommendedCommands
    Write-StepResult $result
    exit 1
}

 succeeded in 3075ms:
param(
    [switch]$IncludeUntrackedContent
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$stateRelativePath = ".ai-dev/state.json"
$diffRelativePath = ".ai-dev/diff.md"
$statePath = Join-Path $projectRoot $stateRelativePath
$diffPath = Join-Path $projectRoot $diffRelativePath
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
$maxUntrackedFileSize = 200KB
$aiDevOperationalRoot = ".ai-dev/"
$reviewDiffPathspecExcludes = @(":(exclude).ai-dev/**")

function Stop-WithError {
    param(
        [string]$Message
    )

    Write-Error $Message
    exit 1
}

function Read-JsonFile {
    param(
        [string]$Path,
        [string]$RelativePath
    )

    try {
        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | ConvertFrom-Json
    } catch {
        Stop-WithError "$RelativePath JSON 파싱에 실패했습니다: $($_.Exception.Message)"
    }
}

function Set-ObjectProperty {
    param(
        [object]$InputObject,
        [string]$Name,
        [object]$Value
    )

    if ($InputObject.PSObject.Properties.Name -contains $Name) {
        $InputObject.$Name = $Value
    } else {
        $InputObject | Add-Member -NotePropertyName $Name -NotePropertyValue $Value
    }
}

function Set-ProcessStartInfoUtf8Encoding {
    param(
        [System.Diagnostics.ProcessStartInfo]$StartInfo
    )

    try {
        $StartInfo.StandardOutputEncoding = [System.Text.Encoding]::UTF8
        $StartInfo.StandardErrorEncoding = [System.Text.Encoding]::UTF8
    } catch {
        Write-Warning "ProcessStartInfo UTF-8 인코딩 속성을 설정할 수 없어 기본 인코딩으로 진행합니다: $($_.Exception.Message
)"
    }
}

function Save-StateResult {
    param(
        [object]$State,
        [string]$Status,
        [string]$ErrorSummary
    )

    Set-ObjectProperty $State "lastCommand" "save-diff"
    Set-ObjectProperty $State "lastCommandStatus" $Status
    Set-ObjectProperty $State "lastErrorSummary" $ErrorSummary
    Set-ObjectProperty $State "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))

    $stateJson = $State | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)
}

function Invoke-GitCapture {
    param(
        [string[]]$Arguments,
        [string]$DisplayName
    )

    $argumentText = ($Arguments | ForEach-Object {
        if ($_ -match '[\s"]') {
            '"' + $_.Replace('"', '\"') + '"'
        } else {
            $_
        }
    }) -join " "

    $startInfo = New-Object System.Diagnostics.ProcessStartInfo
    $startInfo.FileName = "git"
    $startInfo.Arguments = $argumentText
    $startInfo.UseShellExecute = $false
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    $startInfo.CreateNoWindow = $true
    Set-ProcessStartInfoUtf8Encoding $startInfo

    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $startInfo

    if (-not $process.Start()) {
        throw "$DisplayName 실행을 시작하지 못했습니다."
    }

    $output = $process.StandardOutput.ReadToEnd()
    $errorOutput = $process.StandardError.ReadToEnd()
    $process.WaitForExit()
    $exitCode = $process.ExitCode

    if ($exitCode -ne 0) {
        throw "$DisplayName 실행에 실패했습니다. exit code: $exitCode`n$errorOutput"
    }

    if (-not [string]::IsNullOrWhiteSpace($errorOutput)) {
        Write-Warning "$DisplayName 경고: $($errorOutput.Trim())"
    }

    return $output.TrimEnd()
}

function Convert-ToCodeBlock {
    param(
        [string]$Content
    )

    $codeFence = '```'
    $text = if ([string]::IsNullOrWhiteSpace($Content)) { "변경 없음" } else { $Content }

    return "${codeFence}text`r`n$text`r`n$codeFence"
}

function Test-IsAiDevOperationalPath {
    param(
        [string]$RelativePath
    )

    $normalizedRelativePath = $RelativePath.Replace('\', '/')
    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::Ordin
alIgnoreCase)
}

function Get-ChangedPathsFromPorcelain {
    param(
        [string]$PorcelainStatus
    )

    $paths = @()
    $statusLines = @($PorcelainStatus -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpa
ce($_) })

    foreach ($line in $statusLines) {
        if ($line.StartsWith("?? ")) {
            $paths += $line.Substring(3)
            continue
        }

        if ($line.Length -lt 4) {
            continue
        }

        $relativePath = $line.Substring(3)
        $paths += $relativePath
    }

    return @($paths | Select-Object -Unique)
}

function Convert-ToFileList {
    param(
        [string[]]$Paths
    )

    if ($null -eq $Paths -or $Paths.Count -eq 0) {
        return "- 없음"
    }

    return ($Paths | ForEach-Object { "- $_" }) -join "`r`n"
}

function Get-UntrackedFileSections {
    param(
        [string]$RepositoryRoot,
        [string]$PorcelainStatus
    )

    $sections = @()
    $skippedGeneratedArtifacts = @()
    $repositoryRootFullPath = [System.IO.Path]::GetFullPath($RepositoryRoot).TrimEnd('\', '/') + [Sys
tem.IO.Path]::DirectorySeparatorChar
    $untrackedLines = @($PorcelainStatus -split "`r?`n" | Where-Object { $_.StartsWith("?? ") })

    foreach ($line in $untrackedLines) {
        $relativePath = $line.Substring(3)
        $sectionTitle = "### $relativePath"
        $normalizedRelativePath = $relativePath.Replace('\', '/')

        if ($relativePath.StartsWith('"') -and $relativePath.EndsWith('"')) {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 따옴표로 인코딩된 경로는 자동 읽기 대상에서 제외합니다."
            continue
        }

        if (Test-IsAiDevOperationalPath $normalizedRelativePath) {
            $skippedGeneratedArtifacts += $relativePath
            continue
        }

        try {
            $fullPath = [System.IO.Path]::GetFullPath((Join-Path $RepositoryRoot $relativePath))
        } catch {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 경로를 해석할 수 없습니다."
            continue
        }

        if (-not $fullPath.StartsWith($repositoryRootFullPath, [System.StringComparison]::OrdinalIgno
reCase)) {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 저장소 밖 경로입니다."
            continue
        }

        if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 파일이 아니거나 읽을 수 없습니다."
            continue
        }

        try {
            $fileInfo = Get-Item -LiteralPath $fullPath

            if ($fileInfo.Length -gt $maxUntrackedFileSize) {
                $sections += "$sectionTitle`r`n`r`n내용 생략: 파일 크기가 200KB를 초과합니다."
                continue
            }

            $bytes = [System.IO.File]::ReadAllBytes($fullPath)

            if ($bytes -contains 0) {
                $sections += "$sectionTitle`r`n`r`n내용 생략: 바이너리 파일로 판단했습니다."
                continue
            }

            $content = [System.Text.Encoding]::UTF8.GetString($bytes)
            $sections += "$sectionTitle`r`n`r`n$(Convert-ToCodeBlock $content)"
        } catch {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 파일 읽기에 실패했습니다."
        }
    }

    if ($sections.Count -eq 0) {
        $sections = @("내용을 포함할 추적되지 않은 텍스트 파일이 없습니다.")
    }

    return [PSCustomObject]@{
        ContentSections = $sections
        SkippedGeneratedArtifacts = $skippedGeneratedArtifacts
    }
}

if (-not (Test-Path -LiteralPath $statePath -PathType Leaf)) {
    Stop-WithError "필수 파일이 없습니다: $stateRelativePath"
}

$state = Read-JsonFile $statePath $stateRelativePath

try {
    $repositoryRoot = Invoke-GitCapture -Arguments @("rev-parse", "--show-toplevel") -DisplayName "gi
t rev-parse --show-toplevel"
} catch {
    Save-StateResult $state "failed" $_.Exception.Message
    Stop-WithError "현재 위치가 git repository가 아닙니다."
}

try {
    $statusShort = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "git status --sho
rt"
    $statusPorcelain = Invoke-GitCapture -Arguments @("status", "--porcelain") -DisplayName "git stat
us --porcelain"
    $diffPathspecArguments = @("--", ".") + $reviewDiffPathspecExcludes
    $unstagedStat = Invoke-GitCapture -Arguments (@("diff", "--stat") + $diffPathspecArguments) -Disp
layName "git diff --stat"
    $unstagedDiff = Invoke-GitCapture -Arguments (@("diff") + $diffPathspecArguments) -DisplayName "g
it diff"
    $stagedStat = Invoke-GitCapture -Arguments (@("diff", "--staged", "--stat") + $diffPathspecArgume
nts) -DisplayName "git diff --staged --stat"
    $stagedDiff = Invoke-GitCapture -Arguments (@("diff", "--staged") + $diffPathspecArguments) -Disp
layName "git diff --staged"
    $changedPaths = Get-ChangedPathsFromPorcelain $statusPorcelain
    $appChangePaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
    $aiDevOperationalPaths = @($changedPaths | Where-Object { Test-IsAiDevOperationalPath $_ })

    $generatedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $sections = @(
        "# AI Dev Diff",
        "## Generated At`r`n`r`n$generatedAt",
        "## Git Status`r`n`r`n$(Convert-ToCodeBlock $statusShort)",
        "## App Change Files`r`n`r`n$(Convert-ToFileList $appChangePaths)",
        "## AI Dev Operational Artifact Files`r`n`r`n$(Convert-ToFileList $aiDevOperationalPaths)",
        "## Review Diff Scope`r`n`r`n아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 `.ai-dev` 운영 산출물 diff를 제외합니다. 
`.ai-dev` 변경은 위 운영 산출물 목록에서 별도로 확인합니다.",
        "## Unstaged Diff Stat`r`n`r`n$(Convert-ToCodeBlock $unstagedStat)",
        "## Unstaged Diff`r`n`r`n$(Convert-ToCodeBlock $unstagedDiff)",
        "## Staged Diff Stat`r`n`r`n$(Convert-ToCodeBlock $stagedStat)",
        "## Staged Diff`r`n`r`n$(Convert-ToCodeBlock $stagedDiff)"
    )

    if ($IncludeUntrackedContent) {
        $untrackedResult = Get-UntrackedFileSections $repositoryRoot $statusPorcelain
        $sections += "## Untracked File Content`r`n`r`n$($untrackedResult.ContentSections -join "`r`n
`r`n")"

        if ($untrackedResult.SkippedGeneratedArtifacts.Count -gt 0) {
            $skippedArtifactList = $untrackedResult.SkippedGeneratedArtifacts | ForEach-Object { "- $
_" }
            $sections += "## Skipped Generated AI Dev Artifacts`r`n`r`n$($skippedArtifactList -join "
`r`n")"
        }
    }

    $diffContent = $sections -join "`r`n`r`n"
    [System.IO.File]::WriteAllText($diffPath, $diffContent, $utf8WithBom)
    Save-StateResult $state "passed" ""
} catch {
    Save-StateResult $state "failed" $_.Exception.Message
    Stop-WithError "git diff 저장에 실패했습니다: $($_.Exception.Message)"
}

Write-Host "git diff 저장 완료: $diffRelativePath"
Write-Host "상태 저장 완료: $stateRelativePath"

if (-not $IncludeUntrackedContent) {
    Write-Host "untracked 파일 내용이 필요하면 -IncludeUntrackedContent 옵션을 사용하세요."
}

codex
지금은 변경 자체보다 누락된 호출 경로가 있는지 보는 단계입니다. 특히 하위 PowerShell이 `-NoProfile`로 실행될 때 각 스크립트가 공통 UTF-8 초기화를 직접 로
드하는지 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "rg -n \"ai-dev-env|powersh
ell|npm(\\.cmd)? run|Get-Content|Set-Content|WriteAllText|ReadAllText|Out-File\" scripts" in D:\ai-ap
ps\planpilot-local
 succeeded in 2348ms:
scripts\ai-dev-auto-cycle.ps1:10:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-auto-cycle.ps1:89:        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | 
ConvertFrom-Json
scripts\ai-dev-auto-cycle.ps1:117:    [System.IO.File]::WriteAllText($Path, $json, $utf8WithBom)
scripts\ai-dev-auto-cycle.ps1:458:    $autoStepOutput = & powershell -NoProfile -ExecutionPolicy Bypa
ss -File $autoStepPath @arguments 2>&1 | Out-String
scripts\ai-dev-auto-step.ps1:9:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-auto-step.ps1:65:    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File $
scriptPath @Arguments 2>&1 | Out-String
scripts\ai-dev-auto-step.ps1:101:    $nextOutput = & powershell -NoProfile -ExecutionPolicy Bypass -F
ile (Join-Path $PSScriptRoot "ai-dev-next.ps1") -Json 2>&1 | Out-String
scripts\ai-dev-auto-step.ps1:159:                "powershell -ExecutionPolicy Bypass -File scripts/ai
-dev-copy-review-prompt.ps1",
scripts\ai-dev-auto-step.ps1:160:                "powershell -ExecutionPolicy Bypass -File scripts/ai
-dev-save-review.ps1 -FromClipboard"
scripts\ai-dev-auto-step.ps1:174:                "powershell -ExecutionPolicy Bypass -File scripts/ai
-dev-status.ps1"
scripts\ai-dev-auto-step.ps1:180:                -Message "현재 goal은 completed 상태입니다. 더 실행할 task가 없습니다
. 다음 목표를 시작하려면 .ai-dev/goal.md, .ai-dev/queue.json, .ai-dev/state.json을 새 목표로 초기화하세요. 상태 확인 명령: power
shell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1" `
scripts\ai-dev-auto-step.ps1:215:            -RecommendedCommands @("powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-status.ps1")
scripts\ai-dev-auto-goal.ps1:19:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-auto-goal.ps1:196:    [System.IO.File]::WriteAllText($resolvedResultPath, $content, $u
tf8WithBom)
scripts\ai-dev-auto-goal.ps1:1180:                        "필요한 경우 npm run build를 별도로 실행한다."
scripts\ai-dev-auto-goal.ps1:1319:    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File
 $ScriptPath @Arguments 2>&1 | Out-String
scripts\ai-dev-auto-goal.ps1:1376:        $state = Get-Content -Raw -Encoding UTF8 -LiteralPath $stat
ePath | ConvertFrom-Json
scripts\ai-dev-auto-goal.ps1:1433:$fullCycleCommandText = "powershell -ExecutionPolicy Bypass -File s
cripts/ai-dev-auto-cycle-full.ps1 $($fullCycleArguments -join ' ')".Trim()
scripts\ai-dev-auto-goal.ps1:1451:    $script:steps += New-StepResult 6 "make-prompt" "powershell -Ex
ecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1" $false $true 0 "DryRun: current-task-promp
t.md was not generated."
scripts\ai-dev-auto-goal.ps1:1489:$fullCycleCommandText = "powershell -ExecutionPolicy Bypass -File s
cripts/ai-dev-auto-cycle-full.ps1 $($fullCycleArguments -join ' ')".Trim()
scripts\ai-dev-auto-goal.ps1:1501:[System.IO.File]::WriteAllText($resolvedPlanningPromptPath, $planne
rPrompt, $utf8WithBom)
scripts\ai-dev-auto-goal.ps1:1526:[System.IO.File]::WriteAllText($resolvedResultPath, $resultContent,
 $utf8WithBom)
scripts\ai-dev-auto-goal.ps1:1550:[System.IO.File]::WriteAllText($resolvedGoalPath, $goalMarkdown, $u
tf8WithBom)
scripts\ai-dev-auto-goal.ps1:1551:[System.IO.File]::WriteAllText($resolvedQueuePath, $queueJson, $utf
8WithBom)
scripts\ai-dev-auto-goal.ps1:1552:[System.IO.File]::WriteAllText($resolvedStatePath, $stateJson, $utf
8WithBom)
scripts\ai-dev-auto-goal.ps1:1556:Invoke-CycleCommand 6 "make-prompt" "powershell -ExecutionPolicy By
pass -File scripts/ai-dev-make-prompt.ps1" $makePromptPath @()
scripts\ai-dev-auto-cycle-full.ps1:14:. $PSScriptRoot\ai-dev-env.ps1
scripts\ai-dev-auto-cycle-full.ps1:49:        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Pa
th | ConvertFrom-Json
scripts\ai-dev-auto-cycle-full.ps1:76:    [System.IO.File]::WriteAllText($Path, $json, $utf8WithBom)
scripts\ai-dev-auto-cycle-full.ps1:477:    $output = & powershell -NoProfile -ExecutionPolicy Bypass 
-File $ScriptPath @Arguments 2>&1 | Out-String
scripts\ai-dev-auto-cycle-full.ps1:701:    $command = "powershell -ExecutionPolicy Bypass -File scrip
ts/ai-dev-check.ps1"
scripts\ai-dev-auto-cycle-full.ps1:1085:        Invoke-CycleCommand $stepNumber "make-prompt" "powers
hell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
scripts\ai-dev-auto-cycle-full.ps1:1089:            $command = "powershell -ExecutionPolicy Bypass -F
ile scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
scripts\ai-dev-auto-cycle-full.ps1:1102:            $script:steps += New-StepResult $stepNumber "run-
codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty" $false $tr
ue 1 "Codex 구현 실행에는 -AllowCodex가 필요합니다. 추천 명령: $command"
scripts\ai-dev-auto-cycle-full.ps1:1108:        Invoke-CycleCommand $stepNumber "run-codex" "powershe
ll -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty" $scriptPaths.runCodex $run
CodexArguments
scripts\ai-dev-auto-cycle-full.ps1:1115:        Invoke-CycleCommand $stepNumber "save-diff" "powershe
ll -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
scripts\ai-dev-auto-cycle-full.ps1:1118:        Invoke-CycleCommand $stepNumber "make-review-prompt" 
"powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths
.makeReviewPrompt @("-Strict")
scripts\ai-dev-auto-cycle-full.ps1:1122:            $command = "powershell -ExecutionPolicy Bypass -F
ile scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
scripts\ai-dev-auto-cycle-full.ps1:1135:            $script:steps += New-StepResult $stepNumber "run-
review-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDir
ty -SaveReview" $false $true 1 "Codex 리뷰 실행에는 -AllowReviewCodex가 필요합니다. 추천 명령: $command"
scripts\ai-dev-auto-cycle-full.ps1:1139:        Invoke-CycleCommand $stepNumber "run-review-codex" "p
owershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" 
$scriptPaths.runReviewCodex @("-AllowDirty", "-SaveReview")
scripts\ai-dev-auto-cycle-full.ps1:1146:        $script:steps += New-StepResult $stepNumber "make-rev
ise-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1" $false $
true 0 "DryRun: review-gate가 revise + revise_with_codex인 경우 생성할 revise 프롬프트를 실제로 만들지 않았습니다."
scripts\ai-dev-auto-cycle-full.ps1:1148:        $script:steps += New-StepResult $stepNumber "run-code
x-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptP
ath .ai-dev/revise-prompt.md" $false $true 0 "DryRun: Codex 재수정 실행을 실행하지 않았습니다."
scripts\ai-dev-auto-cycle-full.ps1:1153:        $script:steps += New-StepResult $stepNumber "save-dif
f-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $false $true 0 "Dry
Run: 재수정 diff 저장을 실행하지 않았습니다."
scripts\ai-dev-auto-cycle-full.ps1:1155:        $script:steps += New-StepResult $stepNumber "make-rev
iew-prompt-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -S
trict" $false $true 0 "DryRun: 재리뷰 프롬프트 생성을 실행하지 않았습니다."
scripts\ai-dev-auto-cycle-full.ps1:1157:        $script:steps += New-StepResult $stepNumber "run-revi
ew-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -Allow
Dirty -SaveReview" $false $true 0 "DryRun: Codex 재리뷰와 save-review를 실행하지 않았습니다."
scripts\ai-dev-auto-cycle-full.ps1:1161:        $script:steps += New-StepResult $stepNumber "commit" 
"powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/
commit을 실행하지 않았습니다."
scripts\ai-dev-auto-cycle-full.ps1:1165:        $script:steps += New-StepResult $stepNumber "complete
-task" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"자동
 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료`" -CommitHash <commit-hash>" $false $true 0 "DryR
un: task 완료 처리를 실행하지 않았습니다."
scripts\ai-dev-auto-cycle-full.ps1:1169:        $script:steps += New-StepResult $stepNumber "final-st
atus" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1" $false $true 0 "DryRun: 최종
 작업 상태 확인을 실행하지 않았습니다."
scripts\ai-dev-auto-cycle-full.ps1:1198:        Invoke-CycleCommand $stepNumber "make-revise-prompt" 
"powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1" $scriptPaths.makeRev
isePrompt @()
scripts\ai-dev-auto-cycle-full.ps1:1202:            $command = "powershell -ExecutionPolicy Bypass -F
ile scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
scripts\ai-dev-auto-cycle-full.ps1:1215:            $script:steps += New-StepResult $stepNumber "run-
codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -Pro
mptPath .ai-dev/revise-prompt.md" $false $true 1 "Codex 재수정 실행에는 -AllowCodex가 필요합니다. 추천 명령: $command"
scripts\ai-dev-auto-cycle-full.ps1:1219:        Invoke-CycleCommand $stepNumber "run-codex-revise" "p
owershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/
revise-prompt.md" $scriptPaths.runCodex @("-AllowDirty", "-PromptPath", ".ai-dev/revise-prompt.md")
scripts\ai-dev-auto-cycle-full.ps1:1226:        Invoke-CycleCommand $stepNumber "save-diff-revise" "p
owershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
scripts\ai-dev-auto-cycle-full.ps1:1229:        Invoke-CycleCommand $stepNumber "make-review-prompt-r
evise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict" $scri
ptPaths.makeReviewPrompt @("-Strict")
scripts\ai-dev-auto-cycle-full.ps1:1233:            $command = "powershell -ExecutionPolicy Bypass -F
ile scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
scripts\ai-dev-auto-cycle-full.ps1:1246:            $script:steps += New-StepResult $stepNumber "run-
review-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -A
llowDirty -SaveReview" $false $true 1 "Codex 재리뷰 실행에는 -AllowReviewCodex가 필요합니다. 추천 명령: $command"
scripts\ai-dev-auto-cycle-full.ps1:1250:        Invoke-CycleCommand $stepNumber "run-review-codex-rev
ise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveR
eview" $scriptPaths.runReviewCodex @("-AllowDirty", "-SaveReview")
scripts\ai-dev-auto-cycle-full.ps1:1323:        $commitCommand = "powershell -ExecutionPolicy Bypass 
-File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTas
ks"
scripts\ai-dev-auto-cycle-full.ps1:1332:        $script:steps += New-StepResult $stepNumber "commit" 
"powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCo
mmit이 필요합니다. 추천 명령: $commitCommand"
scripts\ai-dev-auto-cycle-full.ps1:1369:        $commitCommandText = "powershell -ExecutionPolicy Byp
ass -File scripts/ai-dev-commit.ps1"
scripts\ai-dev-auto-cycle-full.ps1:1405:    $completeTaskCommand = "powershell -ExecutionPolicy Bypas
s -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"$resultSummary`""
scripts\ai-dev-auto-cycle-full.ps1:1422:    Invoke-CycleCommand $stepNumber "final-status" "powershel
l -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1" $scriptPaths.status @()
scripts\ai-dev-autopilot.ps1:15:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-autopilot.ps1:65:        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | C
onvertFrom-Json
scripts\ai-dev-autopilot.ps1:78:    [System.IO.File]::WriteAllText($Path, $json, $utf8WithBom)
scripts\ai-dev-autopilot.ps1:855:    $lines = @(Get-Content -Encoding UTF8 -LiteralPath $backlogPath)
scripts\ai-dev-autopilot.ps1:955:    $lines = @(Get-Content -Encoding UTF8 -LiteralPath $loopLogPath)
scripts\ai-dev-autopilot.ps1:1100:    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File
 $autoGoalPath @arguments 2>&1 | Out-String
scripts\ai-dev-check.ps1:10:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-check.ps1:38:        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | Conve
rtFrom-Json
scripts\ai-dev-check.ps1:74:    $command = "npm run $Name"
scripts\ai-dev-check.ps1:87:    $output = & npm.cmd run $Name 2>&1 | Out-String
scripts\ai-dev-check.ps1:138:  - npm run build: skipped
scripts\ai-dev-check.ps1:139:  - npm run test: skipped
scripts\ai-dev-check.ps1:140:  - npm run lint: skipped
scripts\ai-dev-check.ps1:149:    [System.IO.File]::WriteAllText($testResultPath, $testResultContent, 
$utf8WithBom)
scripts\ai-dev-check.ps1:158:    [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)
scripts\ai-dev-check.ps1:252:[System.IO.File]::WriteAllText($testResultPath, $testResultContent, $utf
8WithBom)
scripts\ai-dev-check.ps1:277:[System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)
scripts\ai-dev-commit.ps1:9:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-commit.ps1:38:        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | Conv
ertFrom-Json
scripts\ai-dev-commit.ps1:92:    [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)
scripts\ai-dev-copy-review-prompt.ps1:7:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-copy-review-prompt.ps1:13:$saveReviewCommand = "powershell -ExecutionPolicy Bypass -Fi
le scripts/ai-dev-save-review.ps1 -FromClipboard"
scripts\ai-dev-copy-review-prompt.ps1:58:        $content = Get-Content -Raw -Encoding UTF8 -LiteralP
ath $Path
scripts\ai-dev-copy-review-prompt.ps1:75:            "powershell -ExecutionPolicy Bypass -File script
s/ai-dev-make-review-prompt.ps1",
scripts\ai-dev-copy-review-prompt.ps1:76:            "powershell -ExecutionPolicy Bypass -File script
s/ai-dev-copy-review-prompt.ps1"
scripts\ai-dev-copy-review-prompt.ps1:102:    $makeReviewOutput = & powershell -NoProfile -ExecutionP
olicy Bypass -File $makeReviewPromptPath @arguments 2>&1 | Out-String
scripts\ai-dev-current-task.ps1:5:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-current-task.ps1:29:        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path 
| ConvertFrom-Json
scripts\ai-dev-init.ps1:5:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-init.ps1:70:    [System.IO.File]::WriteAllText($targetPath, $Content, $utf8WithoutBom)
scripts\ai-dev-make-prompt.ps1:5:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-make-prompt.ps1:34:        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path |
 ConvertFrom-Json
scripts\ai-dev-make-prompt.ps1:111:$goalContent = Get-Content -Raw -Encoding UTF8 -LiteralPath $goalP
ath
scripts\ai-dev-make-prompt.ps1:184:        $extraInstructionsContent = Get-Content -Raw -Encoding UTF
8 -LiteralPath $resolvedExtraInstructionsPath
scripts\ai-dev-make-prompt.ps1:225:- 필요한 경우 ``npm run build``는 사람이 별도로 실행한다.
scripts\ai-dev-make-prompt.ps1:269:[System.IO.File]::WriteAllText($promptPath, $promptContent, $utf8W
ithBom)
scripts\ai-dev-complete-task.ps1:8:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-complete-task.ps1:36:        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path
 | ConvertFrom-Json
scripts\ai-dev-complete-task.ps1:79:    [System.IO.File]::WriteAllText($Path, $json, $utf8WithBom)
scripts\ai-dev-make-review-prompt.ps1:5:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-make-review-prompt.ps1:39:        return Get-Content -Raw -Encoding UTF8 -LiteralPath 
$Path | ConvertFrom-Json
scripts\ai-dev-make-review-prompt.ps1:122:$goalContent = Get-Content -Raw -Encoding UTF8 -LiteralPath
 $goalPath
scripts\ai-dev-make-review-prompt.ps1:125:$testResultContent = Get-Content -Raw -Encoding UTF8 -Liter
alPath $testResultPath
scripts\ai-dev-make-review-prompt.ps1:126:$diffContent = Get-Content -Raw -Encoding UTF8 -LiteralPath
 $diffPath
scripts\ai-dev-make-review-prompt.ps1:305:[System.IO.File]::WriteAllText($reviewPromptPath, $reviewPr
omptContent, $utf8WithBom)
scripts\ai-dev-make-revise-prompt.ps1:5:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-make-revise-prompt.ps1:41:        return Get-Content -Raw -Encoding UTF8 -LiteralPath 
$Path | ConvertFrom-Json
scripts\ai-dev-make-revise-prompt.ps1:199:$reviewContent = Get-Content -Raw -Encoding UTF8 -LiteralPa
th $reviewPath
scripts\ai-dev-make-revise-prompt.ps1:200:$goalContent = Get-Content -Raw -Encoding UTF8 -LiteralPath
 $goalPath
scripts\ai-dev-make-revise-prompt.ps1:203:$diffContent = Get-Content -Raw -Encoding UTF8 -LiteralPath
 $diffPath
scripts\ai-dev-make-revise-prompt.ps1:204:$testResultContent = Get-Content -Raw -Encoding UTF8 -Liter
alPath $testResultPath
scripts\ai-dev-make-revise-prompt.ps1:395:[System.IO.File]::WriteAllText($revisePromptPath, $revisePr
omptContent, $utf8WithBom)
scripts\ai-dev-next.ps1:5:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-next.ps1:29:        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | Conver
tFrom-Json
scripts\ai-dev-next.ps1:78:        -or $commandText -like "npm run build*" `
scripts\ai-dev-next.ps1:79:        -or $commandText -like "npm run test*" `
scripts\ai-dev-next.ps1:80:        -or $commandText -like "npm run lint*"
scripts\ai-dev-next.ps1:235:        $reviewResponse = Get-Content -Raw -Encoding UTF8 -LiteralPath $r
eviewResponsePath | ConvertFrom-Json
scripts\ai-dev-next.ps1:257:$checkFailureRecommendedCommands += "Get-Content -LiteralPath .ai-dev/tes
t-result.md"
scripts\ai-dev-next.ps1:258:$checkFailureRecommendedCommands += "powershell -ExecutionPolicy Bypass -
File scripts/ai-dev-save-diff.ps1"
scripts\ai-dev-next.ps1:259:$checkFailureRecommendedCommands += "powershell -ExecutionPolicy Bypass -
File scripts/ai-dev-make-review-prompt.ps1 -Strict"
scripts\ai-dev-next.ps1:290:        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-pro
mpt.ps1"
scripts\ai-dev-next.ps1:300:        "리뷰 결과를 받은 뒤 decision이 revise이면 powershell -ExecutionPolicy Bypas
s -File scripts/ai-dev-make-revise-prompt.ps1 를 실행합니다.",
scripts\ai-dev-next.ps1:301:        "revise-prompt가 생성된 뒤 powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md 로 재수정할 수 있습니다.",
scripts\ai-dev-next.ps1:306:        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-rev
ise-prompt.ps1"
scripts\ai-dev-next.ps1:310:        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.p
s1"
scripts\ai-dev-next.ps1:314:        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete
-task.ps1 -ResultSummary `"리뷰 및 커밋 완료`" -CommitHash $lastCommitHash"
scripts\ai-dev-next.ps1:318:        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-pro
mpt.ps1"
scripts\ai-dev-next.ps1:322:        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-rev
iew-prompt.ps1 -Strict"
scripts\ai-dev-next.ps1:326:        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-rev
iew.ps1 -FromClipboard"
scripts\ai-dev-next.ps1:330:        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-dif
f.ps1"
scripts\ai-dev-next.ps1:334:        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps
1 -BuildOnly"
scripts\ai-dev-next.ps1:338:        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-rev
iew-prompt.ps1 -Strict"
scripts\ai-dev-next.ps1:342:        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-rev
iew.ps1 -FromClipboard"
scripts\ai-dev-next.ps1:346:        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.p
s1"
scripts\ai-dev-manual-cycle.ps1:5:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-save-diff.ps1:5:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-save-diff.ps1:33:        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | C
onvertFrom-Json
scripts\ai-dev-save-diff.ps1:79:    [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithB
om)
scripts\ai-dev-save-diff.ps1:310:    [System.IO.File]::WriteAllText($diffPath, $diffContent, $utf8Wit
hBom)
scripts\ai-dev-run-review-codex.ps1:12:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-run-review-codex.ps1:87:        $state = Get-Content -Raw -Encoding UTF8 -LiteralPath 
$statePath | ConvertFrom-Json
scripts\ai-dev-run-review-codex.ps1:100:        [System.IO.File]::WriteAllText($statePath, $stateJson
, $utf8WithBom)
scripts\ai-dev-run-review-codex.ps1:325:    $message = "리뷰 프롬프트 파일이 없습니다: $reviewPromptRelativePath`n
먼저 다음 명령을 실행하세요: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1"
scripts\ai-dev-run-review-codex.ps1:330:$saveReviewCommandText = "powershell -ExecutionPolicy Bypass 
-File scripts/ai-dev-save-review.ps1 -ReviewFile $reviewResponseRelativePath"
scripts\ai-dev-run-review-codex.ps1:358:    $makeReviewPromptOutput = & powershell -NoProfile -Execut
ionPolicy Bypass -File $makeReviewPromptPath 2>&1 | Out-String
scripts\ai-dev-run-review-codex.ps1:400:[System.IO.File]::WriteAllText($resolvedResultPath, $resultCo
ntent, $utf8WithBom)
scripts\ai-dev-run-review-codex.ps1:415:[System.IO.File]::WriteAllText($resolvedReviewResponsePath, $
reviewResult.JsonText, $utf8WithBom)
scripts\ai-dev-run-review-codex.ps1:424:    $saveReviewOutput = & powershell -NoProfile -ExecutionPol
icy Bypass -File $saveReviewPath -ReviewFile $reviewResponseRelativePath 2>&1 | Out-String
scripts\ai-dev-status.ps1:5:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-status.ps1:34:        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | Conv
ertFrom-Json
scripts\ai-dev-status.ps1:96:        $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)
scripts\ai-dev-status.ps1:139:        $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)
scripts\ai-dev-run-codex.ps1:10:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-run-codex.ps1:159:    return "powershell $($arguments -join ' ')"
scripts\ai-dev-run-codex.ps1:180:        $message = "프롬프트 파일이 없습니다: $promptRelativePath`n먼저 다음 명령을 실행
하세요: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1"
scripts\ai-dev-run-codex.ps1:190:    $makePromptOutput = & powershell -NoProfile -ExecutionPolicy Byp
ass -File $makePromptPath 2>&1 | Out-String
scripts\ai-dev-run-codex.ps1:249:[System.IO.File]::WriteAllText($resolvedResultPath, $resultContent, 
$utf8WithBom)
scripts\ai-dev-save-review.ps1:8:. "$PSScriptRoot\ai-dev-env.ps1"
scripts\ai-dev-save-review.ps1:34:        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path |
 ConvertFrom-Json
scripts\ai-dev-save-review.ps1:87:    [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8Wit
hBom)
scripts\ai-dev-save-review.ps1:107:        Write-Host "  powershell -ExecutionPolicy Bypass -File scr
ipts/ai-dev-save-review.ps1 -ReviewFile .ai-dev/review-response.json"
scripts\ai-dev-save-review.ps1:108:        Write-Host '  powershell -ExecutionPolicy Bypass -File scr
ipts/ai-dev-save-review.ps1 -ReviewJson ''{"decision":"pass","severity":"none","summary":"OK","requir
ed_changes":[],"optional_suggestions":[],"next_step":"complete_task"}'''
scripts\ai-dev-save-review.ps1:109:        Write-Host "  powershell -ExecutionPolicy Bypass -File scr
ipts/ai-dev-save-review.ps1 -FromClipboard"
scripts\ai-dev-save-review.ps1:133:            return Get-Content -Raw -Encoding UTF8 -LiteralPath $r
eviewFilePath
scripts\ai-dev-save-review.ps1:389:    [System.IO.File]::WriteAllText($reviewPath, $content, $utf8Wit
hBom)
scripts\ai-dev-save-review.ps1:466:[System.IO.File]::WriteAllText($reviewPath, $reviewContent, $utf8W
ithBom)
scripts\ai-dev-save-review.ps1:470:    "pass + complete_task: 다음 명령을 실행해 현재 task 완료 처리를 검토하세요. powers
hell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 통과`""
scripts\ai-dev-save-review.ps1:472:    "revise + make_revise_prompt: 다음 명령으로 재수정 프롬프트를 생성한 뒤 Codex/Cl
ine에 전달하세요. powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1"
scripts\ai-dev-test.ps1:211:        [System.IO.File]::WriteAllText(
scripts\ai-dev-test.ps1:232:[System.IO.File]::WriteAllText('$escapedChildStatusPath', 'exit 0', [Syst
em.Text.Encoding]::ASCII)
scripts\ai-dev-test.ps1:235:`$state = Get-Content -LiteralPath `$statePath -Raw | ConvertFrom-Json
scripts\ai-dev-test.ps1:239:[System.IO.File]::WriteAllText(`$statePath, `$stateJson, `$utf8WithBom)
scripts\ai-dev-test.ps1:244:        [System.IO.File]::WriteAllText(
scripts\ai-dev-test.ps1:256:            $output = & powershell `
scripts\ai-dev-test.ps1:280:            $forwardedArgs = @(Get-Content -LiteralPath $forwardedArgsPat
h)
scripts\ai-dev-test.ps1:332:                ((Get-Content -LiteralPath $childStatusPath -Raw).Trim() 
-eq "exit 0")
scripts\ai-dev-test.ps1:474:            [System.IO.File]::WriteAllText(
scripts\ai-dev-test.ps1:479:            [System.IO.File]::WriteAllText(
scripts\ai-dev-test.ps1:484:            [System.IO.File]::WriteAllText(
scripts\ai-dev-test.ps1:505:            $output = & powershell -NoProfile @CommandArguments 2>&1
scripts\ai-dev-test.ps1:535:            $markerContent = Get-Content `
scripts\ai-dev-test.ps1:587:$autoGoalContent = Get-Content -LiteralPath $autoGoalPath -Raw
scripts\monitor-and-dev-loop.ps1:26:  return Get-Content $StatePath -Raw | ConvertFrom-Json
scripts\monitor-and-dev-loop.ps1:32:  $State | ConvertTo-Json -Depth 20 | Set-Content -Encoding UTF8 
$StatePath
scripts\monitor-and-dev-loop.ps1:196:- npm run build는 최종 변경 후 실행한다.
scripts\monitor-and-dev-loop.ps1:205:- npm run build
scripts\monitor-and-dev-loop.ps1:223:- npm run dev
scripts\monitor-and-dev-loop.ps1:224:- npm run preview

codex
검색 결과 변경된 주요 스크립트들은 공통 `ai-dev-env.ps1`를 로드하고 있고, 파일 I/O는 대체로 `-Encoding UTF8` 또는 `WriteAllText`로 맞춰져
 있습니다. 남은 의심 지점은 외부 프로세스 캡처 방식이 PowerShell 5.1에서 실제로 UTF-8을 강제하는지입니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath '
D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-run-review-codex.ps1'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath '
D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-check.ps1'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath '
D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-run-codex.ps1'" in D:\ai-apps\planpilot-local
 succeeded in 2989ms:
param(
    [switch]$BuildOnly,
    [switch]$SkipBuild,
    [switch]$SkipTest,
    [switch]$SkipLint,
    [switch]$ManualSummaryOnly,
    [string]$ManualSummary
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$packageRelativePath = "package.json"
$stateRelativePath = ".ai-dev/state.json"
$testResultRelativePath = ".ai-dev/test-result.md"

$packagePath = Join-Path $projectRoot $packageRelativePath
$statePath = Join-Path $projectRoot $stateRelativePath
$testResultPath = Join-Path $projectRoot $testResultRelativePath
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)

function Stop-WithError {
    param(
        [string]$Message
    )

    Write-Error $Message
    exit 1
}

function Read-JsonFile {
    param(
        [string]$Path,
        [string]$RelativePath
    )

    try {
        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | ConvertFrom-Json
    } catch {
        Stop-WithError "$RelativePath JSON 파싱에 실패했습니다: $($_.Exception.Message)"
    }
}

function Test-HasScript {
    param(
        [object]$Package,
        [string]$Name
    )

    return $null -ne $Package.scripts -and ($Package.scripts.PSObject.Properties.Name -contains $Name
)
}

function Set-ObjectProperty {
    param(
        [object]$InputObject,
        [string]$Name,
        [object]$Value
    )

    if ($InputObject.PSObject.Properties.Name -contains $Name) {
        $InputObject.$Name = $Value
    } else {
        $InputObject | Add-Member -NotePropertyName $Name -NotePropertyValue $Value
    }
}

function Invoke-NpmCheck {
    param(
        [string]$Name,
        [bool]$ShouldRun,
        [string]$SkipReason
    )

    $command = "npm run $Name"

    if (-not $ShouldRun) {
        return [PSCustomObject]@{
            Name = $Name
            Command = $command
            Status = "skipped"
            ExitCode = $null
            Log = $SkipReason
        }
    }

    Write-Host "실행 중: $command"
    $output = & npm.cmd run $Name 2>&1 | Out-String
    $exitCode = $LASTEXITCODE
    $status = if ($exitCode -eq 0) { "passed" } else { "failed" }

    return [PSCustomObject]@{
        Name = $Name
        Command = $command
        Status = $status
        ExitCode = $exitCode
        Log = $output.TrimEnd()
    }
}

$requiredPaths = if ($ManualSummaryOnly) {
    @($stateRelativePath, $testResultRelativePath)
} else {
    @($packageRelativePath, $stateRelativePath, $testResultRelativePath)
}

foreach ($requiredPath in $requiredPaths) {
    $fullPath = Join-Path $projectRoot $requiredPath

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        Stop-WithError "필수 파일이 없습니다: $requiredPath"
    }
}

$state = Read-JsonFile $statePath $stateRelativePath

if ($ManualSummaryOnly) {
    if ([string]::IsNullOrWhiteSpace($ManualSummary)) {
        Stop-WithError "-ManualSummaryOnly를 사용할 때는 -ManualSummary 내용을 입력해야 합니다."
    }

    $currentTaskId = if ($null -ne $state.currentTaskId -and -not [string]::IsNullOrWhiteSpace([strin
g]$state.currentTaskId)) {
        [string]$state.currentTaskId
    } else {
        "없음"
    }

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $codeFence = '```'
    $testResultContent = @"
# AI Dev Test Result

## $timestamp

- Overall result: recorded
- Current task: $currentTaskId
- Mode: manual-summary
- Commands:
  - npm run build: skipped
  - npm run test: skipped
  - npm run lint: skipped

### Manual Verification Summary

${codeFence}text
$ManualSummary
$codeFence
"@

    [System.IO.File]::WriteAllText($testResultPath, $testResultContent, $utf8WithBom)

    $now = [DateTimeOffset]::UtcNow.ToString("o")
    Set-ObjectProperty $state "lastCommand" "manual-summary"
    Set-ObjectProperty $state "lastCommandStatus" "passed"
    Set-ObjectProperty $state "lastErrorSummary" ""
    Set-ObjectProperty $state "updatedAt" $now

    $stateJson = $state | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)

    Write-Host "수동 검증 요약 기록 완료: $testResultRelativePath"
    Write-Host "상태 저장 완료: $stateRelativePath"
    exit 0
}

$package = Read-JsonFile $packagePath $packageRelativePath

$hasBuild = Test-HasScript $package "build"
$hasTest = Test-HasScript $package "test"
$hasLint = Test-HasScript $package "lint"

$runBuild = $hasBuild -and -not $SkipBuild
$runTest = $hasTest -and -not $SkipTest -and -not $BuildOnly
$runLint = $hasLint -and -not $SkipLint

$buildSkipReason = if (-not $hasBuild) {
    "package.json에 build script가 없습니다."
} elseif ($SkipBuild) {
    "-SkipBuild 옵션으로 건너뛰었습니다."
} else {
    ""
}

$testSkipReason = if (-not $hasTest) {
    "package.json에 test script가 없습니다."
} elseif ($SkipTest) {
    "-SkipTest 옵션으로 건너뛰었습니다."
} elseif ($BuildOnly) {
    "-BuildOnly 옵션으로 건너뛰었습니다."
} else {
    ""
}

$lintSkipReason = if (-not $hasLint) {
    "package.json에 lint script가 없습니다."
} elseif ($SkipLint) {
    "-SkipLint 옵션으로 건너뛰었습니다."
} else {
    ""
}

$results = @(
    Invoke-NpmCheck "build" $runBuild $buildSkipReason
    Invoke-NpmCheck "test" $runTest $testSkipReason
    Invoke-NpmCheck "lint" $runLint $lintSkipReason
)

$failedResults = @($results | Where-Object { $_.Status -eq "failed" })
$executedResults = @($results | Where-Object { $_.Status -ne "skipped" })
$overallResult = if ($failedResults.Count -gt 0) { "failed" } else { "passed" }
$currentTaskId = if ($null -ne $state.currentTaskId -and -not [string]::IsNullOrWhiteSpace([string]$s
tate.currentTaskId)) {
    [string]$state.currentTaskId
} else {
    "없음"
}

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$modeText = if ($BuildOnly) { "BuildOnly (build + lint when available)" } else { "standard" }
$commandSummary = ($results | ForEach-Object { "  - $($_.Command): $($_.Status)" }) -join "`r`n"
$detailSections = @()
$codeFence = '```'

foreach ($result in $results) {
    $logText = if ([string]::IsNullOrWhiteSpace($result.Log)) { "출력 없음" } else { $result.Log }
    $exitCodeText = if ($null -eq $result.ExitCode) { "없음" } else { [string]$result.ExitCode }

    $detailSections += @"
### $($result.Command)

- Status: $($result.Status)
- Exit code: $exitCodeText

${codeFence}text
$logText
$codeFence
"@
}

$testResultContent = @"
# AI Dev Test Result

## $timestamp

- Overall result: $overallResult
- Current task: $currentTaskId
- Mode: $modeText
- Commands:
$commandSummary

$($detailSections -join "`r`n")
"@

[System.IO.File]::WriteAllText($testResultPath, $testResultContent, $utf8WithBom)

$now = [DateTimeOffset]::UtcNow.ToString("o")
$lastCommand = if ($executedResults.Count -gt 0) {
    $executedResults[-1].Command
} else {
    "ai-dev-check"
}
$lastCommandStatus = if ($executedResults.Count -eq 0) {
    "skipped"
} else {
    $overallResult
}
$lastErrorSummary = if ($failedResults.Count -gt 0) {
    ($failedResults | ForEach-Object { "$($_.Command) exit code $($_.ExitCode)" }) -join "; "
} else {
    ""
}

Set-ObjectProperty $state "lastCommand" $lastCommand
Set-ObjectProperty $state "lastCommandStatus" $lastCommandStatus
Set-ObjectProperty $state "lastErrorSummary" $lastErrorSummary
Set-ObjectProperty $state "updatedAt" $now

$stateJson = $state | ConvertTo-Json -Depth 20
[System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)

Write-Host "검증 결과: $overallResult"
foreach ($result in $results) {
    Write-Host "  - $($result.Command): $($result.Status)"
}
Write-Host "기록 완료: $testResultRelativePath"
Write-Host "상태 저장 완료: $stateRelativePath"

if ($overallResult -eq "failed") {
    exit 1
}

exit 0

 succeeded in 3040ms:
param(
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowDirty,
    [switch]$GeneratePromptIfMissing,
    [string]$PromptPath = ".ai-dev/current-task-prompt.md",
    [string]$ResultPath = ".ai-dev/codex-result.md"
)

. "$PSScriptRoot\ai-dev-env.ps1"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
$codeFence = '```'

function Resolve-RepoPath {
    param(
        [string]$Path
    )

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return $Path
    }

    return Join-Path $repoRoot $Path
}

function ConvertTo-RepoRelativePath {
    param(
        [string]$Path
    )

    $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $Path))
    $rootWithSeparator = $repoRoot.TrimEnd("\") + "\"

    if ($fullPath.StartsWith($rootWithSeparator, [System.StringComparison]::OrdinalIgnoreCase)) {
        return $fullPath.Substring($rootWithSeparator.Length).Replace("\", "/")
    }

    return $fullPath.Replace("\", "/")
}

function Write-RunResult {
    param(
        [string]$Action,
        [bool]$Executed,
        [int]$ExitCode,
        [string]$Message
    )

    if ($Json) {
        [ordered]@{
            action = $Action
            executed = $Executed
            exitCode = $ExitCode
            resultPath = (ConvertTo-RepoRelativePath $ResultPath)
            message = $Message
        } | ConvertTo-Json -Depth 10
    } else {
        Write-Host $Message
    }

    exit $ExitCode
}

function Get-GitStatusLines {
    $statusOutput = & git status --short 2>&1

    if ($LASTEXITCODE -ne 0) {
        $message = "git status 확인에 실패했습니다: $($statusOutput -join "`n")"
        Write-RunResult "run_codex" $false 1 $message
    }

    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
}

function Get-GitStatusPath {
    param(
        [string]$StatusLine
    )

    if ($StatusLine.Length -lt 4) {
        return $StatusLine.Trim().Replace("\", "/")
    }

    $path = $StatusLine.Substring(3).Trim()

    if ($path.Contains(" -> ")) {
        $path = ($path -split " -> ")[-1].Trim()
    }

    return $path.Replace("\", "/")
}

function Test-OnlyAllowedPromptDirty {
    param(
        [string[]]$StatusLines,
        [string]$PromptRelativePath
    )

    if ($StatusLines.Count -eq 0) {
        return $true
    }

    foreach ($line in $StatusLines) {
        $statusPath = Get-GitStatusPath $line

        if ($statusPath -ne $PromptRelativePath) {
            return $false
        }
    }

    return $true
}

function New-CodexPrompt {
    param(
        [string]$PromptFilePath
    )

    return @"
Read and follow the full task prompt at this absolute file path: $PromptFilePath

Additional safety rules for this local AI Dev Loop run:
- Do not run git commit, git reset, git checkout, git clean, git rebase, git merge, or git push.
- Do not run npm install.
- Do not modify package.json, package-lock.json, node_modules, dist, or .git.
- Do not broaden the current task scope beyond the prompt file.
- If the task requirements conflict with repository rules, stop and report the conflict.
"@
}

function New-RunCommandText {
    $arguments = @(
        "-ExecutionPolicy",
        "Bypass",
        "-File",
        "scripts/ai-dev-run-codex.ps1"
    )

    if ($PromptPath -ne ".ai-dev/current-task-prompt.md") {
        $arguments += "-PromptPath"
        $arguments += $promptRelativePath
    }

    if ($ResultPath -ne ".ai-dev/codex-result.md") {
        $arguments += "-ResultPath"
        $arguments += $resultRelativePath
    }

    if ($AllowDirty) {
        $arguments += "-AllowDirty"
    }

    if ($GeneratePromptIfMissing) {
        $arguments += "-GeneratePromptIfMissing"
    }

    return "powershell $($arguments -join ' ')"
}

Set-Location $repoRoot

$promptRelativePath = ConvertTo-RepoRelativePath $PromptPath
$resultRelativePath = ConvertTo-RepoRelativePath $ResultPath
$resolvedPromptPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $PromptPath))
$resolvedResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ResultPath))
$statusLines = @(Get-GitStatusLines)

if ($statusLines.Count -gt 0 -and -not $AllowDirty) {
    if (-not (Test-OnlyAllowedPromptDirty $statusLines $promptRelativePath)) {
        $dirtyText = ($statusLines -join "`n")
        $message = "작업 트리가 dirty 상태라 Codex 실행을 중단합니다. 계속하려면 변경사항을 정리하거나 -AllowDirty를 명시하세요.`n$dirtyTe
xt"
        Write-RunResult "run_codex" $false 1 $message
    }
}

if (-not (Test-Path -LiteralPath $resolvedPromptPath -PathType Leaf)) {
    if (-not $GeneratePromptIfMissing) {
        $message = "프롬프트 파일이 없습니다: $promptRelativePath`n먼저 다음 명령을 실행하세요: powershell -ExecutionPolicy 
Bypass -File scripts/ai-dev-make-prompt.ps1"
        Write-RunResult "run_codex" $false 1 $message
    }

    $makePromptPath = Join-Path $PSScriptRoot "ai-dev-make-prompt.ps1"

    if (-not (Test-Path -LiteralPath $makePromptPath -PathType Leaf)) {
        Write-RunResult "run_codex" $false 1 "프롬프트 생성 스크립트를 찾을 수 없습니다: scripts/ai-dev-make-prompt.ps1
"
    }

    $makePromptOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File $makePromptPath 2>&1 | 
Out-String

    if ($LASTEXITCODE -ne 0) {
        Write-RunResult "run_codex" $false 1 "프롬프트 생성에 실패했습니다: $($makePromptOutput.Trim())"
    }
}

if (-not (Test-Path -LiteralPath $resolvedPromptPath -PathType Leaf)) {
    Write-RunResult "run_codex" $false 1 "프롬프트 파일을 찾을 수 없습니다: $promptRelativePath"
}

$codexPrompt = New-CodexPrompt $resolvedPromptPath
$commandText = New-RunCommandText

if ($DryRun) {
    $message = @"
Codex 구현 실행 DryRun입니다.
- EntryPoint: scripts/ai-dev-run-codex.ps1
- Repository: $repoRoot
- Prompt: $promptRelativePath
- Result: $resultRelativePath
- Command: $commandText
- CodexCommand: codex exec <wrapper prompt reading $promptRelativePath>
- AllowDirty: $([bool]$AllowDirty)
- DirtyCount: $($statusLines.Count)
"@

    Write-RunResult "run_codex" $false 0 $message
}

$codexCommand = Get-Command codex -ErrorAction SilentlyContinue

if ($null -eq $codexCommand) {
    Write-RunResult "run_codex" $false 1 "Codex CLI를 찾을 수 없습니다. codex 명령을 사용할 수 있는지 확인하세요."
}

$startedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$codexOutput = & codex exec $codexPrompt 2>&1 | Out-String
$codexExitCode = $LASTEXITCODE
$endedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$resultContent = @"
# Codex Implementation Result

## Run

- Started at: $startedAt
- Ended at: $endedAt
- Exit code: $codexExitCode
- Prompt: $promptRelativePath
- Command: $commandText

## Output

${codeFence}text
$codexOutput
$codeFence
"@

[System.IO.File]::WriteAllText($resolvedResultPath, $resultContent, $utf8WithBom)

if ($codexExitCode -ne 0) {
    Write-RunResult "run_codex" $true 1 "Codex 실행에 실패했습니다. 결과 파일을 확인하세요: $resultRelativePath"
}

Write-RunResult "run_codex" $true 0 "Codex 실행이 완료되었습니다. 결과 파일: $resultRelativePath"

 succeeded in 3109ms:
param(
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowDirty,
    [switch]$GenerateReviewPromptIfMissing,
    [switch]$SaveReview,
    [string]$ReviewPromptPath = ".ai-dev/review-prompt.md",
    [string]$ReviewResponsePath = ".ai-dev/review-response.json",
    [string]$ResultPath = ".ai-dev/codex-review-result.md"
)

. "$PSScriptRoot\ai-dev-env.ps1"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
$codeFence = '```'
$stateRelativePath = ".ai-dev/state.json"
$statePath = Join-Path $repoRoot $stateRelativePath

function Resolve-RepoPath {
    param(
        [string]$Path
    )

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return $Path
    }

    return Join-Path $repoRoot $Path
}

function ConvertTo-RepoRelativePath {
    param(
        [string]$Path
    )

    $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $Path))
    $rootWithSeparator = $repoRoot.TrimEnd("\") + "\"

    if ($fullPath.StartsWith($rootWithSeparator, [System.StringComparison]::OrdinalIgnoreCase)) {
        return $fullPath.Substring($rootWithSeparator.Length).Replace("\", "/")
    }

    return $fullPath.Replace("\", "/")
}

function Test-HasValue {
    param(
        [object]$Value
    )

    if ($null -eq $Value) {
        return $false
    }

    if ($Value -is [string]) {
        return -not [string]::IsNullOrWhiteSpace($Value)
    }

    return $true
}

function Set-ObjectProperty {
    param(
        [object]$InputObject,
        [string]$Name,
        [object]$Value
    )

    if ($InputObject.PSObject.Properties.Name -contains $Name) {
        $InputObject.$Name = $Value
    } else {
        $InputObject | Add-Member -NotePropertyName $Name -NotePropertyValue $Value
    }
}

function Write-ReviewExtractionFailureState {
    param(
        [string]$ErrorSummary
    )

    if (-not (Test-Path -LiteralPath $statePath -PathType Leaf)) {
        return
    }

    try {
        $state = Get-Content -Raw -Encoding UTF8 -LiteralPath $statePath | ConvertFrom-Json
        $failureCount = if ($state.stopReason -eq "review_json_extraction_failed" -and (Test-HasValue
 $state.repeatedFailureCount)) { [int]$state.repeatedFailureCount + 1 } else { 1 }

        Set-ObjectProperty $state "lastCommand" "run-review-codex"
        Set-ObjectProperty $state "lastCommandStatus" "failed"
        Set-ObjectProperty $state "lastErrorSummary" $ErrorSummary
        Set-ObjectProperty $state "lastReviewDecision" "blocked"
        Set-ObjectProperty $state "lastReviewSeverity" "critical"
        Set-ObjectProperty $state "repeatedFailureCount" $failureCount
        Set-ObjectProperty $state "stopReason" "review_json_extraction_failed"
        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))

        $stateJson = $state | ConvertTo-Json -Depth 20
        [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)
    } catch {
        Write-Warning "$stateRelativePath에 리뷰 JSON 추출 실패 상태를 기록하지 못했습니다: $($_.Exception.Message)"
    }
}

function Write-RunResult {
    param(
        [string]$Action,
        [bool]$Executed,
        [int]$ExitCode,
        [string]$Message
    )

    if ($Json) {
        [ordered]@{
            action = $Action
            executed = $Executed
            exitCode = $ExitCode
            reviewResponsePath = (ConvertTo-RepoRelativePath $ReviewResponsePath)
            resultPath = (ConvertTo-RepoRelativePath $ResultPath)
            message = $Message
        } | ConvertTo-Json -Depth 10
    } else {
        Write-Host $Message
    }

    exit $ExitCode
}

function Get-GitStatusLines {
    $statusOutput = & git status --short 2>&1

    if ($LASTEXITCODE -ne 0) {
        $message = "git status 확인에 실패했습니다: $($statusOutput -join "`n")"
        Write-RunResult "run_review_codex" $false 1 $message
    }

    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
}

function Get-InputPreview {
    param(
        [string]$RawInput
    )

    if ($null -eq $RawInput) {
        return "<null>"
    }

    $normalized = $RawInput.Replace("`r", " ").Replace("`n", " ").Trim()

    if ($normalized.Length -eq 0) {
        return "<empty>"
    }

    if ($normalized.Length -le 500) {
        return $normalized
    }

    return $normalized.Substring(0, 500)
}

function Get-JsonObjectCandidates {
    param(
        [string]$RawInput
    )

    $candidates = @()

    for ($start = 0; $start -lt $RawInput.Length; $start++) {
        if ($RawInput[$start] -ne "{") {
            continue
        }

        $depth = 0
        $inString = $false
        $escaped = $false

        for ($index = $start; $index -lt $RawInput.Length; $index++) {
            $char = $RawInput[$index]

            if ($escaped) {
                $escaped = $false
                continue
            }

            if ($char -eq "\") {
                $escaped = $true
                continue
            }

            if ($char -eq '"') {
                $inString = -not $inString
                continue
            }

            if ($inString) {
                continue
            }

            if ($char -eq "{") {
                $depth++
                continue
            }

            if ($char -eq "}") {
                $depth--

                if ($depth -eq 0) {
                    $candidates += $RawInput.Substring($start, $index - $start + 1).Trim()
                    break
                }
            }
        }
    }

    return @($candidates | Select-Object -Unique)
}

function Get-ValidationErrors {
    param(
        [object]$Review
    )

    $errors = @()
    $requiredFields = @(
        "decision",
        "severity",
        "summary",
        "required_changes",
        "optional_suggestions",
        "next_step"
    )

    foreach ($field in $requiredFields) {
        if (-not ($Review.PSObject.Properties.Name -contains $field)) {
            $errors += "필수 필드 누락: $field"
        }
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (@("pass", "revise", "blocked") -notcontains $Review.decision) {
        $errors += "허용되지 않은 decision: $($Review.decision)"
    }

    if (@("none", "low", "medium", "high", "critical") -notcontains $Review.severity) {
        $errors += "허용되지 않은 severity: $($Review.severity)"
    }

    if (@("complete_task", "revise_with_codex", "stop_for_user") -notcontains $Review.next_step) {
        $errors += "허용되지 않은 next_step: $($Review.next_step)"
    }

    if ($Review.required_changes -isnot [System.Collections.IEnumerable] -or $Review.required_changes
 -is [string]) {
        $errors += "required_changes는 배열이어야 합니다."
    }

    if ($Review.optional_suggestions -isnot [System.Collections.IEnumerable] -or $Review.optional_sug
gestions -is [string]) {
        $errors += "optional_suggestions는 배열이어야 합니다."
    }

    return $errors
}

function ConvertFrom-CodexReviewOutput {
    param(
        [string]$RawInput
    )

    foreach ($candidate in Get-JsonObjectCandidates $RawInput) {
        try {
            $parsed = $candidate | ConvertFrom-Json

            if ($null -eq $parsed -or $parsed -is [System.Array]) {
                continue
            }

            $validationErrors = @(Get-ValidationErrors $parsed)

            if ($validationErrors.Count -gt 0) {
                continue
            }

            return [PSCustomObject]@{
                Parsed = $parsed
                JsonText = ($parsed | ConvertTo-Json -Depth 20)
            }
        } catch {
        }
    }

    throw "Codex 출력에서 필수 필드를 포함한 유효한 JSON 리뷰 객체를 찾지 못했습니다."
}

function New-CodexReviewPrompt {
    param(
        [string]$PromptFilePath
    )

    return "Read and follow the full review prompt at this absolute file path: $PromptFilePath"
}

Set-Location $repoRoot

$reviewPromptRelativePath = ConvertTo-RepoRelativePath $ReviewPromptPath
$reviewResponseRelativePath = ConvertTo-RepoRelativePath $ReviewResponsePath
$resultRelativePath = ConvertTo-RepoRelativePath $ResultPath
$resolvedReviewPromptPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ReviewPromptPath))
$resolvedReviewResponsePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ReviewResponsePath))
$resolvedResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ResultPath))
$statusLines = @(Get-GitStatusLines)

if ($statusLines.Count -gt 0 -and -not $AllowDirty) {
    $dirtyText = ($statusLines -join "`n")
    $message = "작업 트리가 dirty 상태라 Codex 리뷰 실행을 중단합니다. 계속하려면 변경사항을 정리하거나 -AllowDirty를 명시하세요.`n$dirtyTex
t"
    Write-RunResult "run_review_codex" $false 1 $message
}

$promptExists = Test-Path -LiteralPath $resolvedReviewPromptPath -PathType Leaf

if (-not $promptExists -and -not $GenerateReviewPromptIfMissing) {
    $message = "리뷰 프롬프트 파일이 없습니다: $reviewPromptRelativePath`n먼저 다음 명령을 실행하세요: powershell -ExecutionPo
licy Bypass -File scripts/ai-dev-make-review-prompt.ps1"
    Write-RunResult "run_review_codex" $false 1 $message
}

$commandText = "codex exec <short wrapper pointing to $reviewPromptRelativePath>"
$saveReviewCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -Re
viewFile $reviewResponseRelativePath"

if ($DryRun) {
    $message = @"
Codex 리뷰 실행 DryRun입니다.
- Repository: $repoRoot
- Review prompt: $reviewPromptRelativePath
- Review response: $reviewResponseRelativePath
- Result: $resultRelativePath
- Command: $commandText
- SaveReview: $([bool]$SaveReview)
- SaveReviewCommand: $saveReviewCommandText
- GenerateReviewPromptIfMissing: $([bool]$GenerateReviewPromptIfMissing)
- WouldGenerateReviewPrompt: $(-not $promptExists -and [bool]$GenerateReviewPromptIfMissing)
- AllowDirty: $([bool]$AllowDirty)
- DirtyCount: $($statusLines.Count)
"@

    Write-RunResult "run_review_codex" $false 0 $message
}

if (-not $promptExists -and $GenerateReviewPromptIfMissing) {
    $makeReviewPromptPath = Join-Path $PSScriptRoot "ai-dev-make-review-prompt.ps1"

    if (-not (Test-Path -LiteralPath $makeReviewPromptPath -PathType Leaf)) {
        Write-RunResult "run_review_codex" $false 1 "리뷰 프롬프트 생성 스크립트를 찾을 수 없습니다: scripts/ai-dev-make-
review-prompt.ps1"
    }

    $makeReviewPromptOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File $makeReviewPrompt
Path 2>&1 | Out-String

    if ($LASTEXITCODE -ne 0) {
        Write-RunResult "run_review_codex" $false 1 "리뷰 프롬프트 생성에 실패했습니다: $($makeReviewPromptOutput.Tr
im())"
    }
}

if (-not (Test-Path -LiteralPath $resolvedReviewPromptPath -PathType Leaf)) {
    Write-RunResult "run_review_codex" $false 1 "리뷰 프롬프트 파일을 찾을 수 없습니다: $reviewPromptRelativePath"
}

$codexCommand = Get-Command codex -ErrorAction SilentlyContinue

if ($null -eq $codexCommand) {
    Write-RunResult "run_review_codex" $false 1 "Codex CLI를 찾을 수 없습니다. codex 명령을 사용할 수 있는지 확인하세요."
}

$codexPrompt = New-CodexReviewPrompt $resolvedReviewPromptPath
$startedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$codexOutput = & codex exec $codexPrompt 2>&1 | Out-String
$codexExitCode = $LASTEXITCODE
$endedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$resultContent = @"
# Codex Review Result

## Run

- Started at: $startedAt
- Ended at: $endedAt
- Exit code: $codexExitCode
- Review prompt: $reviewPromptRelativePath
- Review response: $reviewResponseRelativePath
- Command: $commandText

## Output

${codeFence}text
$codexOutput
$codeFence
"@

[System.IO.File]::WriteAllText($resolvedResultPath, $resultContent, $utf8WithBom)

if ($codexExitCode -ne 0) {
    Write-RunResult "run_review_codex" $true 1 "Codex 리뷰 실행에 실패했습니다. 결과 파일을 확인하세요: $resultRelativePat
h"
}

try {
    $reviewResult = ConvertFrom-CodexReviewOutput $codexOutput
} catch {
    $preview = Get-InputPreview $codexOutput
    $errorSummary = "Codex 리뷰 JSON 추출에 실패했습니다: $($_.Exception.Message) 출력 preview: $preview"
    Write-ReviewExtractionFailureState $errorSummary
    Write-RunResult "run_review_codex" $true 1 $errorSummary
}

[System.IO.File]::WriteAllText($resolvedReviewResponsePath, $reviewResult.JsonText, $utf8WithBom)

if ($SaveReview) {
    $saveReviewPath = Join-Path $PSScriptRoot "ai-dev-save-review.ps1"

    if (-not (Test-Path -LiteralPath $saveReviewPath -PathType Leaf)) {
        Write-RunResult "run_review_codex" $true 1 "리뷰 저장 스크립트를 찾을 수 없습니다: scripts/ai-dev-save-review
.ps1"
    }

    $saveReviewOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File $saveReviewPath -Review
File $reviewResponseRelativePath 2>&1 | Out-String

    if ($LASTEXITCODE -ne 0) {
        Write-RunResult "run_review_codex" $true 1 "리뷰 JSON은 저장했지만 save-review 실행에 실패했습니다: $($saveRev
iewOutput.Trim())"
    }
}

$saveReviewMessage = if ($SaveReview) {
    " save-review 흐름까지 실행했습니다."
} else {
    " save-review를 실행하려면 -SaveReview를 사용하세요."
}

Write-RunResult "run_review_codex" $true 0 "Codex 리뷰 실행이 완료되었습니다. 리뷰 JSON: $reviewResponseRelativePat
h 결과 파일: $resultRelativePath$saveReviewMessage"

codex
한 가지 실질적 누락 가능성이 보입니다. 변경 대상에 `ai-dev-test.ps1`가 포함되어 있지만 이 파일 자체가 공통 인코딩 초기화를 로드하는지 별도로 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath '
D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-test.ps1' -TotalCount 80" in D:\ai-apps\planpilot-local
 succeeded in 1798ms:
$ErrorActionPreference = "Stop"

[Console]::OutputEncoding = New-Object System.Text.UTF8Encoding($false)
$OutputEncoding = [Console]::OutputEncoding

$repoRoot = Split-Path -Parent $PSScriptRoot

$script:PassedCount = 0
$script:FailedCount = 0

function Write-TestResult {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [bool]$Passed,

        [string]$Detail = ""
    )

    if ($Passed) {
        $script:PassedCount++
        Write-Host "[PASS] $Name"

        if (-not [string]::IsNullOrWhiteSpace($Detail)) {
            Write-Host "       $Detail"
        }

        return
    }

    $script:FailedCount++
    Write-Host "[FAIL] $Name"

    if (-not [string]::IsNullOrWhiteSpace($Detail)) {
        Write-Host "       $Detail"
    }
}

function Get-ChangedPaths {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Root
    )

    $statusLines = @(& git -C $Root status --porcelain)

    return @(
        $statusLines |
            Where-Object { $_.Length -ge 4 } |
            ForEach-Object { $_.Substring(3).Trim() }
    )
}

function New-IsolatedScenarioRoot {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [string]$Root
    )

    $previousErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = "Continue"

    try {
        $worktreeOutput = & git -C $repoRoot worktree add --detach $Root HEAD 2>&1 | Out-String
        $worktreeExitCode = $LASTEXITCODE
    }
    finally {
        $ErrorActionPreference = $previousErrorActionPreference
    }

    if ($worktreeExitCode -eq 0) {
        return [PSCustomObject][ordered]@{
            Path = $Root
            Cleanup = "worktree"
            Error = ""

codex
`ai-dev-test.ps1`도 최소 출력 인코딩은 자체 설정하고 있어, 변경 범위의 핵심 결함으로 보기는 어렵습니다. 최종 판단은 프롬프트의 JSON 형식에 맞춰 바로 반환하겠습
니다.
codex
{
  "decision": "pass",
  "severity": "none",
  "summary": "현재 task 범위 안에서 PowerShell 5.1 호환 UTF-8 초기화, 하위 PowerShell 실행의 -NoProfile 적용, npm.cmd 실행
, git diff 캡처 UTF-8 디코딩 보강이 최소 변경으로 적용되었고 build/test/lint가 모두 통과했다.",
  "required_changes": [],
  "optional_suggestions": [
    {
      "file": "scripts/ai-dev-auto-cycle-full.ps1",
      "suggestion": "사용자에게 보여주는 추천 명령 문자열에도 -NoProfile을 포함하면 실제 실행 경로와 안내가 더 일관된다."
    },
    {
      "file": "scripts/ai-dev-run-codex.ps1",
      "suggestion": "향후 Codex CLI 출력에도 한글이 포함되는 경우가 많다면, npm/git처럼 별도 ProcessStartInfo 기반 UTF-8 캡처 헬퍼
로 통일하는 방안을 검토할 수 있다."
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
  "next_step": "complete_task"
}
tokens used
59,017
{
  "decision": "pass",
  "severity": "none",
  "summary": "현재 task 범위 안에서 PowerShell 5.1 호환 UTF-8 초기화, 하위 PowerShell 실행의 -NoProfile 적용, npm.cmd 실행, git diff 캡처 UTF-8 디코딩 보강이 최소 변경으로 적용되었고 build/test/lint가 모두 통과했다.",
  "required_changes": [],
  "optional_suggestions": [
    {
      "file": "scripts/ai-dev-auto-cycle-full.ps1",
      "suggestion": "사용자에게 보여주는 추천 명령 문자열에도 -NoProfile을 포함하면 실제 실행 경로와 안내가 더 일관된다."
    },
    {
      "file": "scripts/ai-dev-run-codex.ps1",
      "suggestion": "향후 Codex CLI 출력에도 한글이 포함되는 경우가 많다면, npm/git처럼 별도 ProcessStartInfo 기반 UTF-8 캡처 헬퍼로 통일하는 방안을 검토할 수 있다."
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
  "next_step": "complete_task"
}

```