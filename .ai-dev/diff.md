# AI Dev Diff

## Generated At

2026-06-19 23:33:16

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
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-auto-cycle-full.ps1 | 72 ++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 6 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 476fb1e..2a69285 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -432,6 +432,7 @@ function Get-ReviewGate {
     $reviewResponse = $null
     $decision = $null
     $severity = $null
+    $summary = $null
     $nextStep = $null
     $normalizedNextStep = $null
     $hasNextStep = $false
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
@@ -460,12 +465,45 @@ function Get-ReviewGate {
         stateDecision = [string]$state.lastReviewDecision
         decision = $decision
         severity = $severity
+        summary = $summary
         hasNextStep = $hasNextStep
         nextStep = $nextStep
         normalizedNextStep = $normalizedNextStep
     }
 }
 
+function Format-ReviewGateStopMessage {
+    param(
+        [object]$ReviewGate,
+        [string]$Prefix
+    )
+
+    $decision = if (Test-HasValue $ReviewGate.decision) { $ReviewGate.decision } else { "<none>" }
+    $stateDecision = if (Test-HasValue $ReviewGate.stateDecision) { $ReviewGate.stateDecision } else { "<none>" }
+    $severity = if (Test-HasValue $ReviewGate.severity) { $ReviewGate.severity } else { "<none>" }
+    $nextStep = if ($ReviewGate.hasNextStep) { $ReviewGate.nextStep } else { "<none>" }
+    $normalizedNextStep = if (Test-HasValue $ReviewGate.normalizedNextStep) { $ReviewGate.normalizedNextStep } else { "<none>" }
+    $summary = if (Test-HasValue $ReviewGate.summary) { $ReviewGate.summary } else { "<none>" }
+
+    return "$Prefix decision=$decision, state.lastReviewDecision=$stateDecision, severity=$severity, next_step=$nextStep, normalized_next_step=$normalizedNextStep, summary=$summary"
+}
+
+function Save-ReviewStopState {
+    param(
+        [object]$ReviewGate,
+        [string]$StoppedReason,
+        [string]$Message
+    )
+
+    $state = Read-JsonFile $statePath $stateRelativePath
+    Set-ObjectProperty $state "lastReviewDecision" $ReviewGate.stateDecision
+    Set-ObjectProperty $state "lastReviewSeverity" $ReviewGate.severity
+    Set-ObjectProperty $state "lastErrorSummary" $Message
+    Set-ObjectProperty $state "stopReason" $StoppedReason
+    Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
+    Write-JsonFile $statePath $state
+}
+
 function Test-IsAcceptableReviewNextStep {
     param(
         [object]$ReviewGate
@@ -720,7 +758,8 @@ while ($completedTaskCount -lt $MaxTasks) {
             $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $false 0 "이미 저장된 리뷰 pass와 허용 가능한 next_step 상태를 확인했습니다. 구현/리뷰 재실행 없이 commit/complete/meta-commit으로 계속 진행합니다."
             $stepNumber++
         } elseif ($resumeReviewGate.lastCommand -eq "save-review" -and $resumeReviewGate.lastCommandStatus -eq "passed") {
-            $message = "save-review 이후 계속 진행할 수 없습니다. review.decision=$($resumeReviewGate.decision), state.lastReviewDecision=$($resumeReviewGate.stateDecision), next_step=$($resumeReviewGate.nextStep)"
+            $message = Format-ReviewGateStopMessage $resumeReviewGate "save-review 이후 계속 진행할 수 없습니다."
+            Save-ReviewStopState $resumeReviewGate "saved_review_not_ready_to_complete" $message
             $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $true 1 $message
             Stop-Cycle $script:steps "saved_review_not_ready_to_complete" $false 1
         }
@@ -818,18 +857,39 @@ while ($completedTaskCount -lt $MaxTasks) {
     }
 
     if ($reviewGate.decision -ne "pass") {
-        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath decision 확인" $false $true 1 "리뷰 response decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
-        Stop-Cycle $script:steps "review_not_pass" $false 1
+        $stoppedReason = "review_not_pass"
+        $prefix = "리뷰 response decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다."
+
+        if ($reviewGate.decision -eq "revise") {
+            $stoppedReason = "review_revise_stopped"
+            $prefix = "재리뷰 결과가 계속 decision=revise이므로 자동 진행을 중단합니다."
+
+            if ($reviewGate.normalizedNextStep -eq "revise_with_codex") {
+                $stoppedReason = "review_revise_with_codex_retry_limit"
+                $prefix = "next_step=revise_with_codex 재시도 제한으로 자동 진행을 중단합니다."
+            }
+        }
+
+        $message = Format-ReviewGateStopMessage $reviewGate $prefix
+        Save-ReviewStopState $reviewGate $stoppedReason $message
+        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath decision 확인" $false $true 1 $message
+        Stop-Cycle $script:steps $stoppedReason $false 1
     }
 
     if ($reviewGate.stateDecision -ne "pass") {
-        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $true 1 "state.lastReviewDecision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.stateDecision)"
+        $stoppedReason = "state_review_not_pass"
+        $message = Format-ReviewGateStopMessage $reviewGate "state.lastReviewDecision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다."
+        Save-ReviewStopState $reviewGate $stoppedReason $message
+        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $true 1 $message
         Stop-Cycle $script:steps "state_review_not_pass" $false 1
     }
 
     if (-not (Test-IsAcceptableReviewNextStep $reviewGate)) {
-        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_step 확인" $false $true 1 "리뷰 next_step이 존재하지만 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: 원본='$($reviewGate.nextStep)', 정규화='$($reviewGate.normalizedNextStep)'"
-        Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 1
+        $stoppedReason = "review_next_step_not_complete_task"
+        $message = Format-ReviewGateStopMessage $reviewGate "리뷰 next_step이 존재하지만 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다."
+        Save-ReviewStopState $reviewGate $stoppedReason $message
+        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_step 확인" $false $true 1 $message
+        Stop-Cycle $script:steps $stoppedReason $false 1
     }
 
     $script:steps += New-StepResult $stepNumber "review-gate" "최신 state 및 $reviewResponseRelativePath 재확인" $false $false 0 "리뷰 pass 및 허용 가능한 next_step 상태 수락: 존재=$($reviewGate.hasNextStep), 원본='$($reviewGate.nextStep)', 정규화='$($reviewGate.normalizedNextStep)'. commit/commit-result-gate/complete-task/meta-commit으로 계속 진행합니다."
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```