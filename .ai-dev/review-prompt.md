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
AI Dev Loop의 전체 자동 사이클 스크립트가 리뷰 결과 `decision=revise`, `next_step=revise_with_codex` 상태에서 멈추지 않고 제한된 범위의 자동 수정 루프를 수행하도록 보강한다.

## 배경
현재 `ai-dev-auto-cycle-full.ps1`는 리뷰가 수정 요청 상태로 끝나는 경우 후속 revise 흐름을 자동으로 이어가지 못한다. 저장된 리뷰 결과를 기반으로 revise prompt 생성, Codex 수정, 검증, diff 기록, 리뷰 재실행까지 한 번의 사이클 안에서 처리해야 한다.

## 성공 기준
- 리뷰 결과가 `revise` 및 `revise_with_codex`인 경우 자동 revise 흐름이 실행된다.
- revise 후 build/lint 검증 결과가 `.ai-dev/test-result.md`에 기록된다.
- 검증 후 diff가 저장되고 리뷰가 재실행된다.
- 리뷰가 `pass`로 바뀌면 기존 pass 처리 흐름이 유지된다.
- 리뷰가 계속 `revise`이면 최신 사유를 남기고 명확히 중단한다.
- 기존 pass 처리, completed final clean, DryRun 동작은 깨지지 않는다.

## 제약사항
- 앱 `src` 파일은 변경하지 않는다.
- 변경 범위는 AI Dev Loop 관련 스크립트와 `.ai-dev` 메타 파일로 제한한다.
- 기존 동작을 대체하기보다 현재 흐름에 revise 분기만 작게 추가한다.
- 검증 명령 실행 여부와 결과는 명확히 기록한다.

## 범위 제외
- 앱 기능 변경 및 UI 변경은 포함하지 않는다.
- 저장소 구조의 대규모 재작성은 포함하지 않는다.
- 새로운 외부 의존성 추가는 포함하지 않는다.

## 수동 검증
- DryRun 모드에서 revise 분기가 실제 수정 실행 없이 의도한 단계만 출력되는지 확인한다.
- 저장된 리뷰 결과가 revise인 샘플 상태에서 revise prompt 생성, 검증 기록, diff 저장, 리뷰 재실행 흐름을 확인한다.
- pass 리뷰 결과에서는 기존 완료 흐름이 유지되는지 확인한다.

## Current Task

- Task ID: T001
- Title: review revise 자동 재시도 흐름 보강
- Description: `ai-dev-auto-cycle-full.ps1`의 저장된 리뷰 결과 처리 흐름에 revise 분기를 추가해 prompt 생성, Codex 수정, 검증 기록, diff 저장, 리뷰 재실행까지 제한된 자동 루프를 수행하도록 구현한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- DryRun 모드에서 revise 분기 단계가 안전하게 표시되는지 확인
- revise 결과 상태에서 `.ai-dev/test-result.md`에 검증 기록이 남는지 확인
- pass 결과 상태에서 기존 완료 흐름이 유지되는지 확인

## Test Result

# AI Dev Test Result

## 2026-06-19 23:06:43

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

[32m✓ built in 181ms[39m
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
## Executable verification: revise retry DryRun guard

- Verification type: current dirty repo status comparison before/after auto-cycle-full DryRun.
- Scenario: saved review decision is revise and next_step is revise_with_codex.
- Result: PASS_DRYRUN_NO_MUTATION
- Before dirty count: 12
- After dirty count: 12

### DryRun output excerpt
`	ext
Step 1: task-start
  Command: MaxTasks=10
  Executed: False
  Skipped: False
  Exit code: 0
  Message: ?꾩옱 task ?ㅽ뻾 ?쒖옉: T001 review revise ?먮룞 ?ъ떆???먮쫫 蹂닿컯
Step 2: make-prompt
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: ?섏쐞 ?ㅽ겕由쏀듃瑜??ㅽ뻾?섏? ?딆븯?듬땲??
Step 3: run-codex
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: ?섏쐞 ?ㅽ겕由쏀듃瑜??ㅽ뻾?섏? ?딆븯?듬땲??
Step 4: check
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: ?섏쐞 ?ㅽ겕由쏀듃瑜??ㅽ뻾?섏? ?딆븯?듬땲??
Step 5: save-diff
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: ?섏쐞 ?ㅽ겕由쏀듃瑜??ㅽ뻾?섏? ?딆븯?듬땲??
Step 6: make-review-prompt
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: ?섏쐞 ?ㅽ겕由쏀듃瑜??ㅽ뻾?섏? ?딆븯?듬땲??
Step 7: run-review-codex
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: ?섏쐞 ?ㅽ겕由쏀듃瑜??ㅽ뻾?섏? ?딆븯?듬땲??
Step 8: review-gate
  Command: state.lastReviewDecision ?뺤씤
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: 由щ럭 pass ?щ?瑜??ㅼ젣 ?곹깭?먯꽌 ?쎌? ?딆븯?듬땲??
Step 9: package-change-gate
  Command: git status --porcelain -- package.json package-lock.json
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: package ?뚯씪 蹂寃??щ?瑜??뺤씤?섏? ?딆븯?듬땲??
Step 10: commit
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: git add/commit???ㅽ뻾?섏? ?딆븯?듬땲??
Step 11: commit-result-gate
  Command: state.lastCommand/lastCommitHash ?뺤씤
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: ?ㅼ젣 而ㅻ컠 ?앹꽦 ?щ?瑜??뺤씤?섏? ?딆븯?듬땲??
Step 12: complete-task
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary "?먮룞 ?꾨즺: Codex 援ы쁽, build/check, Codex 由щ럭 pass, ?먮룞 而ㅻ컠 ?꾨즺" -CommitHash <commit-hash>
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: task ?꾨즺 泥섎━瑜??ㅽ뻾?섏? ?딆븯?듬땲??
Step 13: meta-commit
  Command: direct meta commit: git add scoped .ai-dev files, git commit -m 'chore(ai-dev): record task completion', git status --short
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: .ai-dev 硫뷀? ?곹깭 吏곸젒 而ㅻ컠???ㅽ뻾?섏? ?딆븯?듬땲??
Step 14: final-status
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1
`",
  ",
  
- PASS_DRYRUN_NO_MUTATION means DryRun did not run a mutating revise cycle and did not change git status.
- This specifically verifies the review concern that DryRun must not enter the normal implementation/review flow before previewing the revise action.


## Diff To Review

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