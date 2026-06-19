# AI Dev Diff

## Generated At

2026-06-19 23:06:50

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
 scripts/ai-dev-auto-cycle-full.ps1 | 191 +++++++++++++++++++++++++++++++++----
 1 file changed, 174 insertions(+), 17 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 476fb1e..7c85988 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -1,6 +1,6 @@
 ﻿param(
     [int]$MaxTasks = 1,
-    [int]$MaxSteps = 20,
+    [int]$MaxSteps = 30,
     [switch]$DryRun,
     [switch]$Json,
     [switch]$AllowCodex,
@@ -435,6 +435,7 @@ function Get-ReviewGate {
     $nextStep = $null
     $normalizedNextStep = $null
     $hasNextStep = $false
+    $summary = $null
 
     if (Test-Path -LiteralPath $reviewResponsePath -PathType Leaf) {
         $reviewResponse = Read-JsonFile $reviewResponsePath $reviewResponseRelativePath
@@ -447,6 +448,10 @@ function Get-ReviewGate {
             $severity = [string]$reviewResponse.severity
         }
 
+        if (Test-HasValue $reviewResponse.summary) {
+            $summary = [string]$reviewResponse.summary
+        }
+
         if ($reviewResponse.PSObject.Properties.Name -contains "next_step") {
             $hasNextStep = $true
             $nextStep = [string]$reviewResponse.next_step
@@ -460,6 +465,7 @@ function Get-ReviewGate {
         stateDecision = [string]$state.lastReviewDecision
         decision = $decision
         severity = $severity
+        summary = $summary
         hasNextStep = $hasNextStep
         nextStep = $nextStep
         normalizedNextStep = $normalizedNextStep
@@ -486,6 +492,93 @@ function Test-IsSavedReviewPassReady {
         -and (Test-IsAcceptableReviewNextStep $ReviewGate)
 }
 
+function Test-IsSavedReviewReviseReady {
+    param(
+        [object]$ReviewGate
+    )
+
+    return $ReviewGate.lastCommand -eq "save-review" `
+        -and $ReviewGate.lastCommandStatus -eq "passed" `
+        -and $ReviewGate.decision -eq "revise" `
+        -and $ReviewGate.stateDecision -eq "revise" `
+        -and $ReviewGate.normalizedNextStep -eq "revise_with_codex"
+}
+
+function Get-AutoCycleResumeCommand {
+    $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
+
+    if ($AllowDirty) {
+        $command = "$command -AllowDirty"
+    }
+
+    if ($AllowCommit) {
+        $command = "$command -AllowCommit"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $command = "$command -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    return $command
+}
+
+function Invoke-ReviseRetry {
+    param(
+        [int]$StepNumber,
+        [object]$ReviewGate
+    )
+
+    $script:steps += New-StepResult $StepNumber "revise-gate" "$reviewResponseRelativePath decision/next_step 확인" $false $false 0 "리뷰 revise 및 revise_with_codex 상태를 확인했습니다. 재수정 루프를 1회 실행합니다: decision=$($ReviewGate.decision), next_step=$($ReviewGate.nextStep)"
+    $StepNumber++
+
+    Invoke-CycleCommand $StepNumber "make-revise-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1" $scriptPaths.makeRevisePrompt @()
+    $StepNumber++
+
+    if (-not $AllowCodex) {
+        $command = Get-AutoCycleResumeCommand
+        $script:steps += New-StepResult $StepNumber "run-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -PromptPath .ai-dev/revise-prompt.md -AllowDirty" $false $true 1 "Codex 재수정 실행에는 -AllowCodex가 필요합니다. 추천 명령: $command"
+        Stop-Cycle $script:steps "allow_codex_required_for_revise" $false 1
+    }
+
+    $runReviseCodexArguments = @("-PromptPath", ".ai-dev/revise-prompt.md", "-AllowDirty")
+
+    Invoke-CycleCommand $StepNumber "run-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -PromptPath .ai-dev/revise-prompt.md -AllowDirty" $scriptPaths.runCodex $runReviseCodexArguments
+    $StepNumber++
+
+    Invoke-CycleCommand $StepNumber "check-after-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly" $scriptPaths.check @("-BuildOnly")
+    $StepNumber++
+
+    Invoke-CycleCommand $StepNumber "save-diff-after-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
+    $StepNumber++
+
+    Invoke-CycleCommand $StepNumber "make-review-prompt-after-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
+    $StepNumber++
+
+    if (-not $AllowReviewCodex) {
+        $command = Get-AutoCycleResumeCommand
+        $script:steps += New-StepResult $StepNumber "run-review-codex-after-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 1 "Codex 리뷰 재실행에는 -AllowReviewCodex가 필요합니다. 추천 명령: $command"
+        Stop-Cycle $script:steps "allow_review_codex_required_for_revise" $false 1
+    }
+
+    Invoke-CycleCommand $StepNumber "run-review-codex-after-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirty", "-SaveReview")
+    $StepNumber++
+
+    try {
+        $nextReviewGate = Get-ReviewGate
+    } catch {
+        $script:steps += New-StepResult $StepNumber "review-gate-after-revise" "state/review-response 확인" $false $false 1 $_.Exception.Message
+        Stop-Cycle $script:steps "review_gate_after_revise_failed" $false 1
+    }
+
+    $script:steps += New-StepResult $StepNumber "review-gate-after-revise" "최신 state 및 $reviewResponseRelativePath 재확인" $false $false 0 "재리뷰 결과: decision=$($nextReviewGate.decision), state.lastReviewDecision=$($nextReviewGate.stateDecision), next_step=$($nextReviewGate.nextStep)"
+    $StepNumber++
+
+    return [PSCustomObject][ordered]@{
+        StepNumber = $StepNumber
+        ReviewGate = $nextReviewGate
+    }
+}
+
 function Get-CommitArguments {
     $arguments = @()
 
@@ -641,6 +734,7 @@ try {
 
     $scriptPaths = @{
         makePrompt = Get-ScriptPath "ai-dev-make-prompt.ps1"
+        makeRevisePrompt = Get-ScriptPath "ai-dev-make-revise-prompt.ps1"
         runCodex = Get-ScriptPath "ai-dev-run-codex.ps1"
         check = Get-ScriptPath "ai-dev-check.ps1"
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
@@ -664,6 +758,14 @@ $plannedSteps = @(
     "make-review-prompt",
     "run-review-codex",
     "review-gate",
+    "revise-gate",
+    "make-revise-prompt",
+    "run-codex-revise",
+    "check-after-revise",
+    "save-diff-after-revise",
+    "make-review-prompt-after-revise",
+    "run-review-codex-after-revise",
+    "review-gate-after-revise",
     "package-change-gate",
     "commit",
     "commit-result-gate",
@@ -706,24 +808,29 @@ while ($completedTaskCount -lt $MaxTasks) {
     $stepNumber++
 
     $resumeFromSavedReview = $false
+    $savedReviewGate = $null
 
-    if (-not $DryRun) {
-        try {
-            $resumeReviewGate = Get-ReviewGate
-        } catch {
-            $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 확인" $false $false 1 $_.Exception.Message
-            Stop-Cycle $script:steps "resume_review_gate_failed" $false 1
-        }
+    try {
+        $resumeReviewGate = Get-ReviewGate
+    } catch {
+        $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 확인" $false $false 1 $_.Exception.Message
+        Stop-Cycle $script:steps "resume_review_gate_failed" $false 1
+    }
 
-        if (Test-IsSavedReviewPassReady $resumeReviewGate) {
-            $resumeFromSavedReview = $true
-            $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $false 0 "이미 저장된 리뷰 pass와 허용 가능한 next_step 상태를 확인했습니다. 구현/리뷰 재실행 없이 commit/complete/meta-commit으로 계속 진행합니다."
-            $stepNumber++
-        } elseif ($resumeReviewGate.lastCommand -eq "save-review" -and $resumeReviewGate.lastCommandStatus -eq "passed") {
-            $message = "save-review 이후 계속 진행할 수 없습니다. review.decision=$($resumeReviewGate.decision), state.lastReviewDecision=$($resumeReviewGate.stateDecision), next_step=$($resumeReviewGate.nextStep)"
-            $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $true 1 $message
-            Stop-Cycle $script:steps "saved_review_not_ready_to_complete" $false 1
-        }
+    if (Test-IsSavedReviewPassReady $resumeReviewGate) {
+        $resumeFromSavedReview = $true
+        $savedReviewGate = $resumeReviewGate
+        $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $false 0 "이미 저장된 리뷰 pass와 허용 가능한 next_step 상태를 확인했습니다. 구현/리뷰 재실행 없이 commit/complete/meta-commit으로 계속 진행합니다."
+        $stepNumber++
+    } elseif (Test-IsSavedReviewReviseReady $resumeReviewGate) {
+        $resumeFromSavedReview = $true
+        $savedReviewGate = $resumeReviewGate
+        $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $false 0 "이미 저장된 리뷰 revise와 revise_with_codex 상태를 확인했습니다. 구현 전체 재실행 없이 revise 루프로 계속 진행합니다."
+        $stepNumber++
+    } elseif ((-not $DryRun) -and $resumeReviewGate.lastCommand -eq "save-review" -and $resumeReviewGate.lastCommandStatus -eq "passed") {
+        $message = "save-review 이후 계속 진행할 수 없습니다. review.decision=$($resumeReviewGate.decision), state.lastReviewDecision=$($resumeReviewGate.stateDecision), next_step=$($resumeReviewGate.nextStep)"
+        $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $true 1 $message
+        Stop-Cycle $script:steps "saved_review_not_ready_to_complete" $false 1
     }
 
     if (-not $resumeFromSavedReview) {
@@ -788,6 +895,38 @@ while ($completedTaskCount -lt $MaxTasks) {
     }
 
     if ($DryRun) {
+        try {
+            $dryRunReviewGate = $savedReviewGate
+
+            if ($null -eq $dryRunReviewGate) {
+                $dryRunReviewGate = Get-ReviewGate
+            }
+
+            if (Test-IsSavedReviewReviseReady $dryRunReviewGate) {
+                $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $true 0 "DryRun: 저장된 리뷰 revise 및 revise_with_codex 상태를 확인했습니다. 일반 구현/리뷰 단계는 실행하지 않습니다."
+                $stepNumber++
+                $script:steps += New-StepResult $stepNumber "revise-gate" "$reviewResponseRelativePath decision/next_step 확인" $false $true 0 "DryRun: 재수정 루프를 1회 실행할 예정입니다."
+                $stepNumber++
+                $script:steps += New-StepResult $stepNumber "make-revise-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1" $false $true 0 "DryRun: revise prompt를 생성하지 않았습니다."
+                $stepNumber++
+                $script:steps += New-StepResult $stepNumber "run-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -PromptPath .ai-dev/revise-prompt.md -AllowDirty" $false $true 0 "DryRun: Codex 재수정을 실행하지 않았습니다."
+                $stepNumber++
+                $script:steps += New-StepResult $stepNumber "check-after-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly" $false $true 0 "DryRun: revise 후 build/lint 검증을 실행하지 않았습니다."
+                $stepNumber++
+                $script:steps += New-StepResult $stepNumber "save-diff-after-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $false $true 0 "DryRun: revise 후 diff를 저장하지 않았습니다."
+                $stepNumber++
+                $script:steps += New-StepResult $stepNumber "make-review-prompt-after-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict" $false $true 0 "DryRun: revise 후 리뷰 프롬프트를 생성하지 않았습니다."
+                $stepNumber++
+                $script:steps += New-StepResult $stepNumber "run-review-codex-after-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 0 "DryRun: revise 후 Codex 리뷰를 재실행하지 않았습니다."
+                $stepNumber++
+                $script:steps += New-StepResult $stepNumber "review-gate-after-revise" "최신 state 및 $reviewResponseRelativePath 재확인" $false $true 0 "DryRun: 재리뷰 결과를 실제 상태에서 다시 읽지 않았습니다."
+                Stop-Cycle $script:steps "dry_run" $false 0
+            }
+        } catch {
+            $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $true 0 "DryRun: 저장된 리뷰 상태 확인을 건너뜁니다. 사유: $($_.Exception.Message)"
+            $stepNumber++
+        }
+
         $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
         $stepNumber++
         $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
@@ -817,6 +956,24 @@ while ($completedTaskCount -lt $MaxTasks) {
         Stop-Cycle $script:steps "review_save_not_passed" $false 1
     }
 
+    if (Test-IsSavedReviewReviseReady $reviewGate) {
+        $reviseResult = Invoke-ReviseRetry $stepNumber $reviewGate
+        $stepNumber = $reviseResult.StepNumber
+        $reviewGate = $reviseResult.ReviewGate
+
+        if ($reviewGate.lastCommand -ne "save-review" -or $reviewGate.lastCommandStatus -ne "passed") {
+            $message = "재수정 후 최신 state가 save-review passed가 아니므로 자동 커밋하지 않습니다: lastCommand=$($reviewGate.lastCommand), lastCommandStatus=$($reviewGate.lastCommandStatus)"
+            $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommand/state.lastCommandStatus 확인" $false $true 1 $message
+            Stop-Cycle $script:steps "review_save_not_passed_after_revise" $false 1
+        }
+
+        if (Test-IsSavedReviewReviseReady $reviewGate) {
+            $message = "재수정 후 리뷰가 계속 revise 상태입니다. 자동 revise 루프는 1회로 제한되어 중단합니다: decision=$($reviewGate.decision), state.lastReviewDecision=$($reviewGate.stateDecision), next_step=$($reviewGate.nextStep), summary=$($reviewGate.summary)"
+            $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath decision/next_step 확인" $false $true 1 $message
+            Stop-Cycle $script:steps "review_still_revise_after_revise" $false 1
+        }
+    }
+
     if ($reviewGate.decision -ne "pass") {
         $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath decision 확인" $false $true 1 "리뷰 response decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
         Stop-Cycle $script:steps "review_not_pass" $false 1
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```