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
AI Dev Loop의 review revise 자동 재시도 흐름에서 재시도 중단 사유가 일반화되지 않도록 보강한다.

## 배경
현재 재수정 후 재리뷰 결과가 계속 decision=revise인 경우, next_step 값에 따라 최신 리뷰 사유가 충분히 보존되지 않을 수 있다. 특히 revise_with_codex 반복 제한 상황에서도 사용자가 최신 review summary, severity, next_step, lastReviewDecision을 확인할 수 있어야 한다.

## 성공 기준
- 재수정 후 재리뷰 결과가 계속 decision=revise이면 next_step 값과 관계없이 최신 review summary, severity, next_step, lastReviewDecision을 포함한 명확한 중단 메시지와 상태를 남긴다.
- next_step=revise_with_codex가 반복된 경우 기존 1회 재시도 제한 메시지를 유지하면서 최신 리뷰 사유를 함께 포함한다.
- DryRun은 Codex, check, review, commit, complete-task를 실행하지 않고 상태 변경 없이 preview만 출력한다.
- 기존 pass 처리, completed final clean, AllowCommit 처리, non-.ai-dev dirty 실패 동작은 유지한다.
- 앱 src 파일은 변경하지 않는다.
- build/lint 검증, DryRun no-mutation 검증 기록, 리뷰 pass, 구현 커밋, complete-task, .ai-dev 메타 커밋, 최종 clean 상태 확인까지 완료한다.

## 제약사항
- 변경 범위는 AI Dev Loop 스크립트와 관련 메타 파일로 제한한다.
- 기존 동작을 보존하면서 revise 중단 상태 기록만 좁게 보강한다.
- 사용자 변경 사항은 되돌리지 않는다.

## 범위 제외
- 앱 src 파일 변경은 제외한다.
- AI Dev Loop 전체 구조 재작성은 제외한다.
- 신규 기능 추가나 UI 변경은 제외한다.

## 수동 검증
- DryRun 실행 시 실행 예정 작업만 preview되고 실제 상태 변경이 없는지 확인한다.
- 재리뷰 revise 반복 시 최신 리뷰 사유가 상태와 메시지에 남는지 확인한다.
- 기존 pass 및 commit 허용 흐름이 유지되는지 확인한다.

## Current Task

- Task ID: T001
- Title: revise 재시도 중단 사유 보존 보강
- Description: ai-dev-auto-cycle-full.ps1의 review revise 자동 재시도 흐름을 좁게 수정해, 재리뷰가 계속 revise일 때 최신 리뷰 summary, severity, next_step, lastReviewDecision이 중단 메시지와 상태에 보존되도록 한다. DryRun preview-only 동작과 기존 pass, AllowCommit, final clean, dirty 실패 흐름은 유지한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- build 통과 확인
- lint 통과 확인
- DryRun 실행 전후 상태 변경 없음 확인
- revise 반복 시 최신 리뷰 사유가 중단 상태에 기록되는지 확인
- 리뷰 pass 확인
- 최종 clean 상태 확인

## Test Result

# AI Dev Test Result

## 2026-06-19 23:33:09

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

[32m✓ built in 227ms[39m
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
## Executable verification: revise retry stop reason preservation

- Verification target: scripts/ai-dev-auto-cycle-full.ps1
- Goal: AI Dev Loop revise 재시도 중단 사유 보존 보강

### Scenario 1: DryRun no-mutation
- Result: PASS_DRYRUN_NO_MUTATION
- Before dirty count: 13
- After dirty count: 13
- Interpretation: DryRun must not run Codex/check/review/commit/complete-task as mutating steps and must not change git status.

### Scenario 2: revise repeat stop reason preservation
- Result: PASS_REVISE_STOP_REASON_PRESERVED
- Checks:
  - PASS: decision revise branch exists
  - PASS: lastReviewDecision is recorded
  - PASS: severity is included
  - PASS: next_step is included
  - PASS: review summary is included
- Interpretation: when re-review remains decision revise, the script must preserve latest summary, severity, next_step, and lastReviewDecision.

### DryRun output excerpt
DRYRUN OUTPUT BEGIN
Step 1: task-start
  Command: MaxTasks=10
  Executed: False
  Skipped: False
  Exit code: 0
  Message: ?꾩옱 task ?ㅽ뻾 ?쒖옉: T001 revise ?ъ떆??以묐떒 ?ъ쑀 蹂댁〈 蹂닿컯
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
DRYRUN OUTPUT END


## Diff To Review

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