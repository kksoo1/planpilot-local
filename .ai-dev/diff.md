# AI Dev Diff

## Generated At

2026-06-14 23:19:50

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
 M scripts/ai-dev-auto-goal.ps1
```

## App Change Files

- scripts/ai-dev-auto-cycle-full.ps1
- scripts/ai-dev-auto-goal.ps1

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
 scripts/ai-dev-auto-cycle-full.ps1 | 168 +++++++++++++++++++++++++------------
 scripts/ai-dev-auto-goal.ps1       |   4 +-
 2 files changed, 117 insertions(+), 55 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 4746b7b..1697ce8 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -306,26 +306,63 @@ function Get-ChangedAiDevOperationalFiles {
 
 function Get-ReviewGate {
     $state = Read-JsonFile $statePath $stateRelativePath
+    $reviewResponse = $null
+    $decision = $null
+    $severity = $null
     $nextStep = $null
     $normalizedNextStep = $null
+    $hasNextStep = $false
 
     if (Test-Path -LiteralPath $reviewResponsePath -PathType Leaf) {
         $reviewResponse = Read-JsonFile $reviewResponsePath $reviewResponseRelativePath
 
-        if (Test-HasValue $reviewResponse.next_step) {
+        if (Test-HasValue $reviewResponse.decision) {
+            $decision = [string]$reviewResponse.decision
+        }
+
+        if (Test-HasValue $reviewResponse.severity) {
+            $severity = [string]$reviewResponse.severity
+        }
+
+        if ($reviewResponse.PSObject.Properties.Name -contains "next_step") {
+            $hasNextStep = $true
             $nextStep = [string]$reviewResponse.next_step
             $normalizedNextStep = $nextStep.Trim().ToLowerInvariant().Replace("-", "_")
         }
     }
 
     return [PSCustomObject][ordered]@{
+        lastCommand = [string]$state.lastCommand
         lastCommandStatus = [string]$state.lastCommandStatus
-        decision = [string]$state.lastReviewDecision
+        stateDecision = [string]$state.lastReviewDecision
+        decision = $decision
+        severity = $severity
+        hasNextStep = $hasNextStep
         nextStep = $nextStep
         normalizedNextStep = $normalizedNextStep
     }
 }
 
+function Test-IsAcceptableReviewNextStep {
+    param(
+        [object]$ReviewGate
+    )
+
+    return (-not $ReviewGate.hasNextStep) -or $ReviewGate.normalizedNextStep -eq "complete_task"
+}
+
+function Test-IsSavedReviewPassReady {
+    param(
+        [object]$ReviewGate
+    )
+
+    return $ReviewGate.lastCommand -eq "save-review" `
+        -and $ReviewGate.lastCommandStatus -eq "passed" `
+        -and $ReviewGate.decision -eq "pass" `
+        -and $ReviewGate.stateDecision -eq "pass" `
+        -and (Test-IsAcceptableReviewNextStep $ReviewGate)
+}
+
 function Get-CommitArguments {
     $arguments = @()
 
@@ -534,65 +571,88 @@ while ($completedTaskCount -lt $MaxTasks) {
     $script:steps += New-StepResult $stepNumber "task-start" "MaxTasks=$MaxTasks" $false $false 0 "현재 task 실행 시작: $taskLabel"
     $stepNumber++
 
-    Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
-    $stepNumber++
+    $resumeFromSavedReview = $false
 
-    if (-not $AllowCodex -and -not $DryRun) {
-        $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
-        if ($AllowDirty) {
-            $command = "$command -AllowDirty"
+    if (-not $DryRun) {
+        try {
+            $resumeReviewGate = Get-ReviewGate
+        } catch {
+            $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 확인" $false $false 1 $_.Exception.Message
+            Stop-Cycle $script:steps "resume_review_gate_failed" $false 1
         }
 
-        if ($AllowCommit) {
-            $command = "$command -AllowCommit"
-        }
-
-        if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
-            $command = "$command -CommitFiles $($CommitFiles -join ',')"
+        if (Test-IsSavedReviewPassReady $resumeReviewGate) {
+            $resumeFromSavedReview = $true
+            $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $false 0 "이미 저장된 리뷰 pass와 허용 가능한 next_step 상태를 확인했습니다. 구현/리뷰 재실행 없이 commit/complete/meta-commit으로 계속 진행합니다."
+            $stepNumber++
+        } elseif ($resumeReviewGate.lastCommand -eq "save-review" -and $resumeReviewGate.lastCommandStatus -eq "passed") {
+            $message = "save-review 이후 계속 진행할 수 없습니다. review.decision=$($resumeReviewGate.decision), state.lastReviewDecision=$($resumeReviewGate.stateDecision), next_step=$($resumeReviewGate.nextStep)"
+            $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $true 1 $message
+            Stop-Cycle $script:steps "saved_review_not_ready_to_complete" $false 1
         }
-
-        $script:steps += New-StepResult $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1" $false $true 1 "Codex 구현 실행에는 -AllowCodex가 필요합니다. 추천 명령: $command"
-        Stop-Cycle $script:steps "allow_codex_required" $false 1
     }
 
-    $runCodexArguments = @()
-    if ($AllowDirty) {
-        $runCodexArguments += "-AllowDirty"
-    }
+    if (-not $resumeFromSavedReview) {
+        Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
+        $stepNumber++
 
-    Invoke-CycleCommand $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1" $scriptPaths.runCodex $runCodexArguments
-    $stepNumber++
+        if (-not $AllowCodex -and -not $DryRun) {
+            $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
+            if ($AllowDirty) {
+                $command = "$command -AllowDirty"
+            }
 
-    Invoke-CycleCommand $stepNumber "check" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly" $scriptPaths.check @("-BuildOnly")
-    $stepNumber++
+            if ($AllowCommit) {
+                $command = "$command -AllowCommit"
+            }
 
-    Invoke-CycleCommand $stepNumber "save-diff" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
-    $stepNumber++
+            if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+                $command = "$command -CommitFiles $($CommitFiles -join ',')"
+            }
 
-    Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
-    $stepNumber++
+            $script:steps += New-StepResult $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1" $false $true 1 "Codex 구현 실행에는 -AllowCodex가 필요합니다. 추천 명령: $command"
+            Stop-Cycle $script:steps "allow_codex_required" $false 1
+        }
 
-    if (-not $AllowReviewCodex -and -not $DryRun) {
-        $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
+        $runCodexArguments = @()
         if ($AllowDirty) {
-            $command = "$command -AllowDirty"
+            $runCodexArguments += "-AllowDirty"
         }
 
-        if ($AllowCommit) {
-            $command = "$command -AllowCommit"
-        }
+        Invoke-CycleCommand $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1" $scriptPaths.runCodex $runCodexArguments
+        $stepNumber++
 
-        if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
-            $command = "$command -CommitFiles $($CommitFiles -join ',')"
+        Invoke-CycleCommand $stepNumber "check" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly" $scriptPaths.check @("-BuildOnly")
+        $stepNumber++
+
+        Invoke-CycleCommand $stepNumber "save-diff" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
+        $stepNumber++
+
+        Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
+        $stepNumber++
+
+        if (-not $AllowReviewCodex -and -not $DryRun) {
+            $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
+            if ($AllowDirty) {
+                $command = "$command -AllowDirty"
+            }
+
+            if ($AllowCommit) {
+                $command = "$command -AllowCommit"
+            }
+
+            if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+                $command = "$command -CommitFiles $($CommitFiles -join ',')"
+            }
+
+            $script:steps += New-StepResult $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 1 "Codex 리뷰 실행에는 -AllowReviewCodex가 필요합니다. 추천 명령: $command"
+            Stop-Cycle $script:steps "allow_review_codex_required" $false 1
         }
 
-        $script:steps += New-StepResult $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 1 "Codex 리뷰 실행에는 -AllowReviewCodex가 필요합니다. 추천 명령: $command"
-        Stop-Cycle $script:steps "allow_review_codex_required" $false 1
+        Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirty", "-SaveReview")
+        $stepNumber++
     }
 
-    Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirty", "-SaveReview")
-    $stepNumber++
-
     if ($DryRun) {
         $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
         $stepNumber++
@@ -617,26 +677,28 @@ while ($completedTaskCount -lt $MaxTasks) {
         Stop-Cycle $script:steps "review_gate_failed" $false 1
     }
 
-    if ($reviewGate.lastCommandStatus -ne "passed") {
-        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    if ($reviewGate.lastCommand -ne "save-review" -or $reviewGate.lastCommandStatus -ne "passed") {
+        $message = "최신 state가 save-review passed가 아니므로 자동 커밋하지 않습니다: lastCommand=$($reviewGate.lastCommand), lastCommandStatus=$($reviewGate.lastCommandStatus)"
+        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommand/state.lastCommandStatus 확인" $false $true 1 $message
         Stop-Cycle $script:steps "review_save_not_passed" $false 1
     }
 
     if ($reviewGate.decision -ne "pass") {
-        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
-        Stop-Cycle $script:steps "review_not_pass" $false 0
+        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath decision 확인" $false $true 1 "리뷰 response decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+        Stop-Cycle $script:steps "review_not_pass" $false 1
     }
 
-    if (Test-HasValue $reviewGate.nextStep -and $reviewGate.normalizedNextStep -ne "complete_task") {
-        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_step 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.nextStep)"
-        Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+    if ($reviewGate.stateDecision -ne "pass") {
+        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $true 1 "state.lastReviewDecision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.stateDecision)"
+        Stop-Cycle $script:steps "state_review_not_pass" $false 1
     }
 
-    if (Test-HasValue $reviewGate.nextStep) {
-        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 및 $reviewResponseRelativePath next_step 확인" $false $false 0 "리뷰 pass 및 next_step complete_task 수락: 원본='$($reviewGate.nextStep)', 정규화='$($reviewGate.normalizedNextStep)'. commit/commit-result-gate/complete-task/meta-commit으로 계속 진행합니다."
-    } else {
-        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $false 0 "리뷰 pass 확인. next_step 값이 없어 기존 동작대로 커밋 게이트로 진행합니다."
+    if (-not (Test-IsAcceptableReviewNextStep $reviewGate)) {
+        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_step 확인" $false $true 1 "리뷰 next_step이 존재하지만 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: 원본='$($reviewGate.nextStep)', 정규화='$($reviewGate.normalizedNextStep)'"
+        Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 1
     }
+
+    $script:steps += New-StepResult $stepNumber "review-gate" "최신 state 및 $reviewResponseRelativePath 재확인" $false $false 0 "리뷰 pass 및 허용 가능한 next_step 상태 수락: 존재=$($reviewGate.hasNextStep), 원본='$($reviewGate.nextStep)', 정규화='$($reviewGate.normalizedNextStep)'. commit/commit-result-gate/complete-task/meta-commit으로 계속 진행합니다."
     $stepNumber++
 
     try {
diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 1efa594..bd06345 100644
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -909,8 +909,8 @@ try {
 }
 
 if ($goalStatusAfterFullCycle -ne "completed") {
-    $script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $true 0 "auto-cycle-full은 성공 종료했지만 goalStatus가 completed가 아닙니다: $goalStatusAfterFullCycle"
-    Stop-AutoGoal $script:steps "auto_cycle_incomplete" $false 0
+    $script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $true 1 "auto-cycle-full은 성공 종료했지만 goalStatus가 completed가 아닙니다: $goalStatusAfterFullCycle"
+    Stop-AutoGoal $script:steps "auto_cycle_incomplete" $false 1
 }
 
 $script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $false 0 "auto-cycle-full 성공 후 goalStatus completed 확인."
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```