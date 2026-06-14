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
AI Dev Loop auto-goal pass 이후 완료 재시도 흐름을 수정한다.

## 배경
ai-dev-auto-goal 실행 중 리뷰 결과가 pass이고 next_step이 complete_task인 상태에서도 구현 커밋, complete-task -CommitHash 처리, .ai-dev 메타 커밋으로 이어지지 않고 멈추는 문제가 있다. 또한 auto-cycle-full이 미완료 상태로 끝났을 때 auto-goal이 성공으로 오판하지 않도록 보완이 필요하다.

## 성공 기준
- 리뷰 결과 pass 이후 next_step 값이 complete_task 또는 complete-task인 경우 모두 완료 처리 흐름으로 이어진다.
- 구현 커밋 해시가 complete-task -CommitHash 단계에 정상 전달된다.
- complete-task 처리 후 .ai-dev 메타 변경 커밋 흐름이 누락되지 않는다.
- auto-cycle-full이 미완료 상태로 끝난 경우 auto-goal이 성공으로 판단하지 않는다.
- 기존 자동 루프의 정상 완료 경로는 유지된다.

## 제약사항
- 한 번에 하나의 작은 구현 변경으로 처리한다.
- 기존 스크립트 구조와 상태 파일 형식을 우선 유지한다.
- 불필요한 대규모 재작성은 하지 않는다.
- 사용자 변경 사항은 되돌리지 않는다.

## 범위 제외
- 새로운 기능 추가는 제외한다.
- UI 변경은 제외한다.
- 저장소 구조 변경은 제외한다.
- 자동 루프 전체 설계 변경은 제외한다.

## 수동 검증
- pass와 complete_task 조합에서 완료 처리 단계가 이어지는지 확인한다.
- pass와 complete-task 조합에서도 동일하게 처리되는지 확인한다.
- auto-cycle-full이 미완료 상태로 끝난 경우 실패 또는 재시도 대상으로 남는지 확인한다.

## Current Task

- Task ID: T001
- Title: auto-goal 완료 판정 흐름 수정
- Description: 리뷰 pass 이후 next_step의 complete_task와 complete-task 표기를 모두 허용하고, auto-cycle-full 미완료 종료를 성공으로 오판하지 않도록 완료 판정 조건을 보강한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- complete_task 표기에서 완료 처리 흐름이 이어지는지 확인
- complete-task 표기에서 완료 처리 흐름이 이어지는지 확인
- auto-cycle-full 미완료 종료 시 auto-goal이 성공으로 처리하지 않는지 확인

## Test Result

# AI Dev Test Result

## 2026-06-14 23:19:44

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
dist/index.html                   0.46 kB │ gzip:  0.29 kB
dist/assets/index-DvjxWt30.css    5.69 kB │ gzip:  1.93 kB
dist/assets/index-CWimiEra.js   316.44 kB │ gzip: 99.85 kB

[32m✓ built in 564ms[39m
```
### npm run test

- Status: skipped
- Exit code: 없음

```text
package.json에 test script가 없습니다.
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