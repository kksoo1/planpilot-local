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
AI Dev Loop의 review-gate에서 `decision=revise`, `next_step=revise_with_codex`가 반환될 때 실패로 즉시 중단하지 않고, 자동 revise 재시도 흐름으로 연결되도록 자동화 스크립트를 보강한다.

## 배경
현재 auto-cycle-full 실행 중 리뷰 결과가 revise_with_codex인 경우 review-gate failed로 멈추며, 수정 프롬프트 생성부터 재검증, 재리뷰까지의 자동 흐름이 이어지지 않는다. 이번 작업은 앱 기능 개발이 아니라 자동 개발 루프의 검증 자동화 안정성 개선이 목적이다.

## 성공 기준
- review-gate가 revise_with_codex를 만나면 실패 종료하지 않고 revise 프롬프트 생성, Codex revise 실행, 검증, diff 저장, review prompt 생성, review Codex 재실행, review 저장까지 자동 수행한다.
- 재리뷰가 pass이면 구현 커밋, task 완료 처리, 메타 정보 커밋, 다음 task 진행 흐름이 이어진다.
- 재리뷰가 계속 revise이면 최신 summary, severity, next_step, required_changes를 state와 로그에 남기고 명확히 실패 종료한다.
- pass 전 완료 차단, stale/missing implementation 차단, completed final 정리 상태 확인, DryRun no-mutation 동작은 유지된다.
- DryRun에서는 변경 작업을 실행하지 않고 preview만 출력한다.
- 앱 src 파일은 변경하지 않는다.

## 제약사항
- 작업 중심 파일은 ai-dev 자동화 스크립트로 제한한다.
- 기존 자동화 흐름과 상태 파일 형식을 최대한 유지한다.
- 앱 소스 파일은 수정하지 않는다.
- DryRun 동작은 실제 변경 없이 확인 가능한 출력만 제공해야 한다.

## 범위 제외
- 앱 UI 또는 기능 변경은 제외한다.
- 데이터 저장 구조 변경은 제외한다.
- 대규모 자동화 구조 재작성은 제외한다.

## 수동 검증
- revise_with_codex 리뷰 결과를 재현해 자동 revise 재시도 흐름이 이어지는지 확인한다.
- 재리뷰 pass 시 구현 커밋, task 완료 처리, 메타 커밋 단계가 순서대로 수행되는지 확인한다.
- 재리뷰 revise 반복 시 상태와 로그에 필요한 실패 정보가 남고 완료 처리가 차단되는지 확인한다.
- DryRun에서 Codex 실행, 검증, review, commit, complete-task 같은 변경 작업이 실행되지 않는지 확인한다.

## Current Task

- Task ID: T001
- Title: review-gate revise 자동 재시도 흐름 연결
- Description: ai-dev-auto-cycle-full.ps1을 중심으로 review-gate의 revise_with_codex 결과를 자동 revise 재시도 흐름으로 연결하고, pass 전 완료 차단과 DryRun preview 동작을 유지한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- revise_with_codex 결과에서 revise 프롬프트 생성부터 재리뷰 저장까지 자동으로 이어지는지 확인한다.
- 재리뷰 pass 전에는 commit과 complete-task가 실행되지 않는지 확인한다.
- 재리뷰 revise 반복 시 summary, severity, next_step, required_changes가 state와 로그에 남는지 확인한다.
- DryRun에서 변경 작업 없이 preview만 출력되는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-06-24 09:49:40

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
dist/assets/index-CVTFf3OT.js   317.03 kB │ gzip: 100.03 kB

[32m✓ built in 259ms[39m
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
## Verification: non-DryRun repeated revise scenario

- Verification type: actual non-DryRun execution already completed.
- Command executed: `ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks 5`
- Scenario: review-gate returned `decision=revise` and `next_step=revise_with_codex`; the full auto cycle retried the revise path.
- Observed execution flow:
  - `ai-dev-auto-cycle-full` ran.
  - `.ai-dev/revise-prompt.md` was generated.
  - The cycle reached re-review after the revise retry.
  - Re-review returned `decision=revise` and `next_step=revise_with_codex` again.
  - The cycle stopped at `review-gate` with failed status.
- Observed final state:
  - Last command: `review-gate`
  - Last command status: `failed`
  - Last commit hash: none
  - Task status remained `in_progress`
  - No commit was created.
  - `complete-task` was not executed.
- Last error preservation:
  - `summary` was preserved from the latest review response.
  - `severity=medium` was preserved.
  - `next_step=revise_with_codex` was preserved.
  - `required_changes` was preserved, including the `.ai-dev/test-result.md` required change.
- Interpretation: the repeated revise path was actually exercised in non-DryRun mode. It safely stopped before commit and complete-task, while retaining enough review detail in Last error for the next revise attempt.

### Captured evidence from repeated revise run

- Re-review result: `decision=revise`, `next_step=revise_with_codex`.
- Follow-up behavior: the review gate failed again, no commit was created, and `complete-task` was not executed.
- Last error evidence: the latest review `summary`, `severity=medium`, `next_step=revise_with_codex`, and `required_changes` were preserved for the next revise attempt.
- Scope note: this is actual non-DryRun evidence for the repeated revise path only. It is not evidence that a pass commit happened.

## Verification: re-review pass path gating

- Verification type: fixture/static verification using the stored script flow and expected pass review state.
- Real pass commit status for this current run: not executed. The actual current repeated-revise run ended with another `revise`, so no real non-DryRun pass commit is claimed here.
- Stored pass-path fixture condition: re-review returns `decision=pass`.
- Verified pass-path order after pass re-review:
  - pass-before-complete gating is checked before completion.
  - commit step runs only after pass re-review.
  - commit-result-gate runs after commit.
  - complete-task runs after commit-result-gate.
  - meta-commit runs after complete-task.
  - final-status runs after meta-commit.
  - Complete-Cycle then performs completed-clean-gate.
- Interpretation: the pass branch has explicit gating and ordered post-pass steps for commit, commit result validation, task completion, metadata commit, final status reporting, and final clean-state validation. This section is fixture/static verification only; it does not assert that the current repeated-revise run performed a pass commit.


## Diff To Review

# AI Dev Diff

## Generated At

2026-06-24 10:38:15

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
?? .ai-dev/revise-prompt.md
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
- .ai-dev/revise-prompt.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-auto-cycle-full.ps1 | 190 +++++++++++++++++++++++++++++++++----
 1 file changed, 172 insertions(+), 18 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 5031713..6710fb0 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -1,6 +1,6 @@
 ﻿param(
     [int]$MaxTasks = 1,
-    [int]$MaxSteps = 20,
+    [int]$MaxSteps = 22,
     [switch]$DryRun,
     [switch]$Json,
     [switch]$AllowCodex,
@@ -94,6 +94,18 @@ function Save-CycleFailureState {
             Set-ObjectProperty $state "lastReviewSeverity" ([string]$ReviewGate.severity)
         }
 
+        if ($null -ne $ReviewGate -and (Test-HasValue $ReviewGate.nextStep)) {
+            Set-ObjectProperty $state "lastReviewNextStep" ([string]$ReviewGate.nextStep)
+        }
+
+        if ($null -ne $ReviewGate -and (Test-HasValue $ReviewGate.summary)) {
+            Set-ObjectProperty $state "lastReviewSummary" ([string]$ReviewGate.summary)
+        }
+
+        if ($null -ne $ReviewGate -and ($ReviewGate.PSObject.Properties.Name -contains "requiredChanges")) {
+            Set-ObjectProperty $state "lastReviewRequiredChanges" @($ReviewGate.requiredChanges)
+        }
+
         Set-ObjectProperty $state "lastCommand" $Command
         Set-ObjectProperty $state "lastCommandStatus" "failed"
         Set-ObjectProperty $state "lastErrorSummary" $ErrorSummary
@@ -540,6 +552,8 @@ function Get-ReviewGate {
     $severity = $null
     $nextStep = $null
     $normalizedNextStep = $null
+    $summary = $null
+    $requiredChanges = @()
     $hasNextStep = $false
 
     if (Test-Path -LiteralPath $reviewResponsePath -PathType Leaf) {
@@ -553,11 +567,19 @@ function Get-ReviewGate {
             $severity = [string]$reviewResponse.severity
         }
 
+        if (Test-HasValue $reviewResponse.summary) {
+            $summary = [string]$reviewResponse.summary
+        }
+
         if ($reviewResponse.PSObject.Properties.Name -contains "next_step") {
             $hasNextStep = $true
             $nextStep = [string]$reviewResponse.next_step
             $normalizedNextStep = $nextStep.Trim().ToLowerInvariant().Replace("-", "_")
         }
+
+        if ($reviewResponse.PSObject.Properties.Name -contains "required_changes") {
+            $requiredChanges = @($reviewResponse.required_changes)
+        }
     }
 
     return [PSCustomObject][ordered]@{
@@ -566,9 +588,11 @@ function Get-ReviewGate {
         stateDecision = [string]$state.lastReviewDecision
         decision = $decision
         severity = $severity
+        summary = $summary
         hasNextStep = $hasNextStep
         nextStep = $nextStep
         normalizedNextStep = $normalizedNextStep
+        requiredChanges = @($requiredChanges)
         requiredChangeFiles = @(Get-RequiredReviewChangeFiles $reviewResponse)
     }
 }
@@ -581,6 +605,24 @@ function Test-IsAcceptableReviewNextStep {
     return (-not $ReviewGate.hasNextStep) -or $ReviewGate.normalizedNextStep -eq "complete_task"
 }
 
+function Test-IsReviewReviseWithCodex {
+    param(
+        [object]$ReviewGate
+    )
+
+    return $ReviewGate.decision -eq "revise" -and $ReviewGate.normalizedNextStep -eq "revise_with_codex"
+}
+
+function New-ReviewReviseFailureMessage {
+    param(
+        [object]$ReviewGate,
+        [string]$Prefix
+    )
+
+    $requiredChangesJson = @($ReviewGate.requiredChanges) | ConvertTo-Json -Depth 20
+    return "$Prefix summary=$($ReviewGate.summary), severity=$($ReviewGate.severity), next_step=$($ReviewGate.nextStep), required_changes=$requiredChangesJson"
+}
+
 function Test-IsSavedReviewPassReady {
     param(
         [object]$ReviewGate
@@ -748,6 +790,7 @@ try {
 
     $scriptPaths = @{
         makePrompt = Get-ScriptPath "ai-dev-make-prompt.ps1"
+        makeRevisePrompt = Get-ScriptPath "ai-dev-make-revise-prompt.ps1"
         runCodex = Get-ScriptPath "ai-dev-run-codex.ps1"
         check = Get-ScriptPath "ai-dev-check.ps1"
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
@@ -771,12 +814,20 @@ $plannedSteps = @(
     "make-review-prompt",
     "run-review-codex",
     "review-gate",
+    "make-revise-prompt",
+    "run-codex-revise",
+    "check-revise",
+    "save-diff-revise",
+    "make-review-prompt-revise",
+    "run-review-codex-revise",
+    "review-gate",
     "package-change-gate",
     "commit",
     "commit-result-gate",
     "complete-task",
     "meta-commit",
-    "final-status"
+    "final-status",
+    "completed-clean-gate"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -835,19 +886,16 @@ while ($completedTaskCount -lt $MaxTasks) {
             $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $false 0 "이미 저장된 리뷰 pass와 허용 가능한 next_step 상태를 확인했습니다. 구현/리뷰 재실행 없이 commit/complete/meta-commit으로 계속 진행합니다."
             $stepNumber++
         } elseif ($resumeReviewGate.lastCommand -eq "save-review" -and $resumeReviewGate.lastCommandStatus -eq "passed") {
-            $resumeImplementationGate = Get-ReviewImplementationGate $currentTask $resumeReviewGate
-            $message = "save-review 이후 계속 진행할 수 없습니다. review.decision=$($resumeReviewGate.decision), state.lastReviewDecision=$($resumeReviewGate.stateDecision), next_step=$($resumeReviewGate.nextStep)"
-
-            if (-not $resumeImplementationGate.passed) {
-                $message = $resumeImplementationGate.message
+            if (Test-IsReviewReviseWithCodex $resumeReviewGate) {
+                $resumeFromSavedReview = $true
+                $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $false 0 "저장된 리뷰가 revise + revise_with_codex이므로 구현/초기 리뷰 재실행 없이 revise 자동 재시도 단계로 계속 진행합니다."
+                $stepNumber++
+            } else {
+                $message = "save-review 이후 계속 진행할 수 없습니다. review.decision=$($resumeReviewGate.decision), state.lastReviewDecision=$($resumeReviewGate.stateDecision), next_step=$($resumeReviewGate.nextStep)"
                 Save-CycleFailureState "resume-review-gate" $message $resumeReviewGate
-                $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response required_changes 및 현재 diff 확인" $false $true 1 $message
-                Stop-Cycle $script:steps $resumeImplementationGate.reason $false 1
+                $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $true 1 $message
+                Stop-Cycle $script:steps "saved_review_not_ready_to_complete" $false 1
             }
-
-            Save-CycleFailureState "resume-review-gate" $message $resumeReviewGate
-            $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $true 1 $message
-            Stop-Cycle $script:steps "saved_review_not_ready_to_complete" $false 1
         }
     }
 
@@ -915,6 +963,18 @@ while ($completedTaskCount -lt $MaxTasks) {
     if ($DryRun) {
         $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
         $stepNumber++
+        $script:steps += New-StepResult $stepNumber "make-revise-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1" $false $true 0 "DryRun: review-gate가 revise + revise_with_codex인 경우 생성할 revise 프롬프트를 실제로 만들지 않았습니다."
+        $stepNumber++
+        $script:steps += New-StepResult $stepNumber "run-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $false $true 0 "DryRun: Codex 재수정 실행을 실행하지 않았습니다."
+        $stepNumber++
+        $script:steps += New-StepResult $stepNumber "check-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly" $false $true 0 "DryRun: 재수정 검증을 실행하지 않았습니다."
+        $stepNumber++
+        $script:steps += New-StepResult $stepNumber "save-diff-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $false $true 0 "DryRun: 재수정 diff 저장을 실행하지 않았습니다."
+        $stepNumber++
+        $script:steps += New-StepResult $stepNumber "make-review-prompt-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict" $false $true 0 "DryRun: 재리뷰 프롬프트 생성을 실행하지 않았습니다."
+        $stepNumber++
+        $script:steps += New-StepResult $stepNumber "run-review-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 0 "DryRun: Codex 재리뷰와 save-review를 실행하지 않았습니다."
+        $stepNumber++
         $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
         $stepNumber++
         $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
@@ -942,12 +1002,98 @@ while ($completedTaskCount -lt $MaxTasks) {
         Stop-Cycle $script:steps "review_save_not_passed" $false 1
     }
 
-    $implementationGate = Get-ReviewImplementationGate $currentTask $reviewGate
+    if (Test-IsReviewReviseWithCodex $reviewGate) {
+        $implementationGate = Get-ReviewImplementationGate $currentTask $reviewGate
 
-    if (-not $implementationGate.passed) {
-        Save-CycleFailureState "review-gate" $implementationGate.message $reviewGate
-        $script:steps += New-StepResult $stepNumber "review-gate" "task type, $reviewResponseRelativePath required_changes, 현재 diff 확인" $false $true 1 $implementationGate.message
-        Stop-Cycle $script:steps $implementationGate.reason $false 1
+        if (-not $implementationGate.passed) {
+            Save-CycleFailureState "review-gate" $implementationGate.message $reviewGate
+            $script:steps += New-StepResult $stepNumber "review-gate" "task type, $reviewResponseRelativePath required_changes, 현재 diff 확인" $false $true 1 $implementationGate.message
+            Stop-Cycle $script:steps $implementationGate.reason $false 1
+        }
+
+        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath decision/next_step 확인" $false $false 0 "리뷰 결과가 revise + revise_with_codex입니다. 자동 revise 재시도를 시작합니다. severity=$($reviewGate.severity), summary=$($reviewGate.summary)"
+        $stepNumber++
+
+        Invoke-CycleCommand $stepNumber "make-revise-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1" $scriptPaths.makeRevisePrompt @()
+        $stepNumber++
+
+        if (-not $AllowCodex) {
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
+            $script:steps += New-StepResult $stepNumber "run-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $false $true 1 "Codex 재수정 실행에는 -AllowCodex가 필요합니다. 추천 명령: $command"
+            Stop-Cycle $script:steps "allow_codex_required" $false 1
+        }
+
+        Invoke-CycleCommand $stepNumber "run-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $scriptPaths.runCodex @("-AllowDirty", "-PromptPath", ".ai-dev/revise-prompt.md")
+        $stepNumber++
+
+        Invoke-CycleCommand $stepNumber "check-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly" $scriptPaths.check @("-BuildOnly")
+        $stepNumber++
+
+        Invoke-CycleCommand $stepNumber "save-diff-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
+        $stepNumber++
+
+        Invoke-CycleCommand $stepNumber "make-review-prompt-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
+        $stepNumber++
+
+        if (-not $AllowReviewCodex) {
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
+            $script:steps += New-StepResult $stepNumber "run-review-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 1 "Codex 재리뷰 실행에는 -AllowReviewCodex가 필요합니다. 추천 명령: $command"
+            Stop-Cycle $script:steps "allow_review_codex_required" $false 1
+        }
+
+        Invoke-CycleCommand $stepNumber "run-review-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirty", "-SaveReview")
+        $stepNumber++
+
+        try {
+            $reviewGate = Get-ReviewGate
+        } catch {
+            $script:steps += New-StepResult $stepNumber "review-gate" "재리뷰 state/review-response 확인" $false $false 1 $_.Exception.Message
+            Stop-Cycle $script:steps "review_gate_failed" $false 1
+        }
+
+        if ($reviewGate.lastCommand -ne "save-review" -or $reviewGate.lastCommandStatus -ne "passed") {
+            $message = "재리뷰 이후 최신 state가 save-review passed가 아니므로 자동 커밋하지 않습니다: lastCommand=$($reviewGate.lastCommand), lastCommandStatus=$($reviewGate.lastCommandStatus)"
+            $script:steps += New-StepResult $stepNumber "review-gate" "재리뷰 state.lastCommand/state.lastCommandStatus 확인" $false $true 1 $message
+            Stop-Cycle $script:steps "review_save_not_passed" $false 1
+        }
+
+        if ($reviewGate.decision -eq "revise") {
+            if (Test-IsReviewReviseWithCodex $reviewGate) {
+                $message = New-ReviewReviseFailureMessage $reviewGate "재리뷰도 revise + revise_with_codex를 반환해 자동 revise 재시도를 중단합니다."
+                Save-CycleFailureState "review-gate" $message $reviewGate
+                $script:steps += New-StepResult $stepNumber "review-gate" "재리뷰 decision/next_step/required_changes 확인" $false $true 1 $message
+                Stop-Cycle $script:steps "review_revise_repeated" $false 1
+            }
+
+            $message = New-ReviewReviseFailureMessage $reviewGate "재리뷰가 revise를 반환해 자동 커밋과 complete-task를 실행하지 않습니다."
+            Save-CycleFailureState "review-gate" $message $reviewGate
+            $script:steps += New-StepResult $stepNumber "review-gate" "재리뷰 decision/next_step/required_changes 확인" $false $true 1 $message
+            Stop-Cycle $script:steps "revise_review_not_pass" $false 1
+        }
     }
 
     if ($reviewGate.decision -ne "pass") {
@@ -967,6 +1113,14 @@ while ($completedTaskCount -lt $MaxTasks) {
         Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 1
     }
 
+    $implementationGate = Get-ReviewImplementationGate $currentTask $reviewGate
+
+    if (-not $implementationGate.passed) {
+        Save-CycleFailureState "review-gate" $implementationGate.message $reviewGate
+        $script:steps += New-StepResult $stepNumber "review-gate" "task type, $reviewResponseRelativePath required_changes, 현재 diff 확인" $false $true 1 $implementationGate.message
+        Stop-Cycle $script:steps $implementationGate.reason $false 1
+    }
+
     $script:steps += New-StepResult $stepNumber "review-gate" "최신 state 및 $reviewResponseRelativePath 재확인" $false $false 0 "리뷰 pass 및 허용 가능한 next_step 상태 수락: 존재=$($reviewGate.hasNextStep), 원본='$($reviewGate.nextStep)', 정규화='$($reviewGate.normalizedNextStep)'. commit/commit-result-gate/complete-task/meta-commit으로 계속 진행합니다."
     $stepNumber++
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