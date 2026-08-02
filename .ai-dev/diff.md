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