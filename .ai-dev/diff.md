# AI Dev Diff

## Generated At

2026-06-14 22:26:45

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
 scripts/ai-dev-auto-cycle-full.ps1 | 20 +++++++++++++++++---
 scripts/ai-dev-auto-goal.ps1       | 30 ++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 3 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 7e86eff..4746b7b 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -307,12 +307,14 @@ function Get-ChangedAiDevOperationalFiles {
 function Get-ReviewGate {
     $state = Read-JsonFile $statePath $stateRelativePath
     $nextStep = $null
+    $normalizedNextStep = $null
 
     if (Test-Path -LiteralPath $reviewResponsePath -PathType Leaf) {
         $reviewResponse = Read-JsonFile $reviewResponsePath $reviewResponseRelativePath
 
         if (Test-HasValue $reviewResponse.next_step) {
             $nextStep = [string]$reviewResponse.next_step
+            $normalizedNextStep = $nextStep.Trim().ToLowerInvariant().Replace("-", "_")
         }
     }
 
@@ -320,6 +322,7 @@ function Get-ReviewGate {
         lastCommandStatus = [string]$state.lastCommandStatus
         decision = [string]$state.lastReviewDecision
         nextStep = $nextStep
+        normalizedNextStep = $normalizedNextStep
     }
 }
 
@@ -474,6 +477,7 @@ try {
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
         commit = Get-ScriptPath "ai-dev-commit.ps1"
         completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
+        status = Get-ScriptPath "ai-dev-status.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Message
@@ -493,7 +497,8 @@ $plannedSteps = @(
     "commit",
     "commit-result-gate",
     "complete-task",
-    "meta-commit"
+    "meta-commit",
+    "final-status"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -600,6 +605,8 @@ while ($completedTaskCount -lt $MaxTasks) {
         $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료`" -CommitHash <commit-hash>" $false $true 0 "DryRun: task 완료 처리를 실행하지 않았습니다."
         $stepNumber++
         $script:steps += New-StepResult $stepNumber "meta-commit" "direct meta commit: git add scoped .ai-dev files, git commit -m 'chore(ai-dev): record task completion', git status --short" $false $true 0 "DryRun: .ai-dev 메타 상태 직접 커밋을 실행하지 않았습니다."
+        $stepNumber++
+        $script:steps += New-StepResult $stepNumber "final-status" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1" $false $true 0 "DryRun: 최종 작업 상태 확인을 실행하지 않았습니다."
         Stop-Cycle $script:steps "dry_run" $false 0
     }
 
@@ -620,12 +627,16 @@ while ($completedTaskCount -lt $MaxTasks) {
         Stop-Cycle $script:steps "review_not_pass" $false 0
     }
 
-    if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    if (Test-HasValue $reviewGate.nextStep -and $reviewGate.normalizedNextStep -ne "complete_task") {
         $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_step 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.nextStep)"
         Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
     }
 
-    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $false 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+    if (Test-HasValue $reviewGate.nextStep) {
+        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 및 $reviewResponseRelativePath next_step 확인" $false $false 0 "리뷰 pass 및 next_step complete_task 수락: 원본='$($reviewGate.nextStep)', 정규화='$($reviewGate.normalizedNextStep)'. commit/commit-result-gate/complete-task/meta-commit으로 계속 진행합니다."
+    } else {
+        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $false 0 "리뷰 pass 확인. next_step 값이 없어 기존 동작대로 커밋 게이트로 진행합니다."
+    }
     $stepNumber++
 
     try {
@@ -700,6 +711,9 @@ while ($completedTaskCount -lt $MaxTasks) {
     Invoke-DirectMetaCommit $stepNumber
     $stepNumber++
 
+    Invoke-CycleCommand $stepNumber "final-status" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1" $scriptPaths.status @()
+    $stepNumber++
+
     $completedTaskCount++
 
     $stateAfterComplete = Read-JsonFile $statePath $stateRelativePath
diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 787e997..1efa594 100644
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -727,6 +727,22 @@ function Get-FullCycleArguments {
     return $arguments
 }
 
+function Get-CurrentGoalStatus {
+    $statePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $stateRelativePath))
+
+    try {
+        $state = Get-Content -Raw -Encoding UTF8 -LiteralPath $statePath | ConvertFrom-Json
+    } catch {
+        throw "$stateRelativePath JSON 파싱에 실패했습니다: $($_.Exception.Message)"
+    }
+
+    if ($null -eq $state -or -not ($state.PSObject.Properties.Name -contains "goalStatus")) {
+        throw "$stateRelativePath 파일에서 goalStatus를 찾을 수 없습니다."
+    }
+
+    return [string]$state.goalStatus
+}
+
 Set-Location $repoRoot
 
 $script:steps = @()
@@ -885,5 +901,19 @@ if (-not $shouldRunFullCycle) {
 
 Invoke-CycleCommand 7 "auto-cycle-full" $fullCycleCommandText $autoCycleFullPath $fullCycleArguments
 
+try {
+    $goalStatusAfterFullCycle = Get-CurrentGoalStatus
+} catch {
+    $script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $false 1 $_.Exception.Message
+    Stop-AutoGoal $script:steps "goal_status_verify_failed" $false 1
+}
+
+if ($goalStatusAfterFullCycle -ne "completed") {
+    $script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $true 0 "auto-cycle-full은 성공 종료했지만 goalStatus가 completed가 아닙니다: $goalStatusAfterFullCycle"
+    Stop-AutoGoal $script:steps "auto_cycle_incomplete" $false 0
+}
+
+$script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $false 0 "auto-cycle-full 성공 후 goalStatus completed 확인."
+
 Stop-AutoGoal $script:steps "completed" $true 0
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```