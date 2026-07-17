# AI Dev Diff

## Generated At

2026-07-17 23:01:27

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
 M .ai-dev/revise-prompt.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-next.ps1
?? .ai-dev/build-check-failure-next-stale-review-fix-prompt.md
?? .ai-dev/build-check-failure-revise-next-fix-prompt.md
?? .ai-dev/next-check-failure-command-scope-fix-prompt.md
?? .ai-dev/next-final-review-requirements-prompt.md
?? .ai-dev/next-review-after-check-recommended-commands-fix-prompt.md
?? .ai-dev/next-review-revise-compat-fix-prompt.md
```

## App Change Files

- scripts/ai-dev-next.ps1

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
- .ai-dev/revise-prompt.md
- .ai-dev/state.json
- .ai-dev/test-result.md
- .ai-dev/build-check-failure-next-stale-review-fix-prompt.md
- .ai-dev/build-check-failure-revise-next-fix-prompt.md
- .ai-dev/next-check-failure-command-scope-fix-prompt.md
- .ai-dev/next-final-review-requirements-prompt.md
- .ai-dev/next-review-after-check-recommended-commands-fix-prompt.md
- .ai-dev/next-review-revise-compat-fix-prompt.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-next.ps1 | 80 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 5 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-next.ps1 b/scripts/ai-dev-next.ps1
index 5c2d172..6708ded 100644
--- a/scripts/ai-dev-next.ps1
+++ b/scripts/ai-dev-next.ps1
@@ -65,7 +65,19 @@ function Test-IsCheckCommand {
         return $false
     }
 
-    return $Command -eq "check" -or $Command -like "npm run build*" -or $Command -like "npm run test*" -or $Command -like "npm run lint*"
+    $commandText = [string]$Command
+
+    return $commandText -eq "check" `
+        -or $commandText -eq "build" `
+        -or $commandText -eq "lint" `
+        -or $commandText -eq "check-revise" `
+        -or $commandText -eq "build-revise" `
+        -or $commandText -eq "lint-revise" `
+        -or $commandText -like "check-*" `
+        -or $commandText -like "*-check" `
+        -or $commandText -like "npm run build*" `
+        -or $commandText -like "npm run test*" `
+        -or $commandText -like "npm run lint*"
 }
 
 function New-NextAction {
@@ -202,6 +214,9 @@ try {
 $currentTaskPromptExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/current-task-prompt.md") -PathType Leaf
 $testResultExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/test-result.md") -PathType Leaf
 $diffExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/diff.md") -PathType Leaf
+$reviewResultExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/review.md") -PathType Leaf
+$reviewResponsePath = Join-Path $projectRoot ".ai-dev/review-response.json"
+$reviewResponseExists = Test-Path -LiteralPath $reviewResponsePath -PathType Leaf
 $reviewPromptExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/review-prompt.md") -PathType Leaf
 $revisePromptExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/revise-prompt.md") -PathType Leaf
 
@@ -211,12 +226,58 @@ $lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$stat
 $lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastReviewDecision } else { "" }
 $lastReviewSeverity = if (Test-HasValue $state.lastReviewSeverity) { [string]$state.lastReviewSeverity } else { "" }
 $lastCommitHash = if (Test-HasValue $state.lastCommitHash) { [string]$state.lastCommitHash } else { "" }
+
+$reviewResponseDecision = ""
+$reviewResponseNextStep = ""
+
+if ($reviewResponseExists) {
+    try {
+        $reviewResponse = Get-Content -Raw -Encoding UTF8 -LiteralPath $reviewResponsePath | ConvertFrom-Json
+        $reviewResponseDecision = if (Test-HasValue $reviewResponse.decision) { [string]$reviewResponse.decision } else { "" }
+        $reviewResponseNextStep = if (Test-HasValue $reviewResponse.next_step) { [string]$reviewResponse.next_step } else { "" }
+    } catch {
+        $reviewResponseDecision = ""
+        $reviewResponseNextStep = ""
+    }
+}
+
 $hasGitChanges = $gitStatus -eq "available" -and $gitChangedFilesCount -gt 0
 $hasNoGitChanges = $gitStatus -eq "available" -and $gitChangedFilesCount -eq 0
 $hasImplementationGitChanges = $gitStatus -eq "available" -and $gitImplementationChangedFilesCount -gt 0
 $hasNoImplementationGitChanges = $gitStatus -eq "available" -and $gitImplementationChangedFilesCount -eq 0
 $reviewNotStarted = Test-IsReviewNotStarted $lastReviewDecision
 $isCheckCommand = Test-IsCheckCommand $lastCommand
+$hasCheckFailure = $isCheckCommand -and $lastCommandStatus -eq "failed"
+$hasStateReviseReview = $lastReviewDecision -eq "revise"
+$hasReviewResponseReviseSignal = $reviewResponseExists -and $reviewResponseDecision -eq "revise" -and $reviewResponseNextStep -eq "revise_with_codex"
+$hasReviewResponseMismatch = $reviewResponseExists -and -not $hasReviewResponseReviseSignal
+$canMakeRevisePrompt = $hasStateReviseReview
+
+$checkFailureRecommendedCommands = @()
+$checkFailureRecommendedCommands += "Get-Content -LiteralPath .ai-dev/test-result.md"
+$checkFailureRecommendedCommands += "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1"
+$checkFailureRecommendedCommands += "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict"
+
+$revisePromptNotes = @()
+$revisePromptNotes += $(if ($revisePromptExists) { "기존 revise-prompt.md는 현재 리뷰 기준으로 덮어씁니다." } else { "required changes만 반영하세요." })
+
+if (-not $testResultExists) {
+    $revisePromptNotes += ".ai-dev/test-result.md가 없으면 수정 전 실패/검증 결과를 먼저 확보하세요."
+}
+
+if (-not $diffExists) {
+    $revisePromptNotes += ".ai-dev/diff.md가 없으면 save-diff로 현재 변경사항을 먼저 저장하세요."
+}
+
+if (-not $reviewResultExists) {
+    $revisePromptNotes += ".ai-dev/review.md가 없으면 저장된 리뷰 내용을 먼저 확보하세요."
+}
+
+if (-not $reviewResponseExists) {
+    $revisePromptNotes += "review-response.json이 없어도 state.json의 lastReviewDecision=revise를 기준으로 revise 안내를 유지합니다."
+} elseif ($hasReviewResponseMismatch) {
+    $revisePromptNotes += "review-response.json이 현재 revise 신호와 다르므로 review.md와 state.json의 최신성을 확인하세요."
+}
 
 $nextAction = $null
 
@@ -230,12 +291,20 @@ if (-not (Test-HasValue $currentTaskId) -and $goalStatus -eq "completed") {
     ) @("프롬프트 생성 후 현재 task만 수행하세요.")
 } elseif ($lastReviewDecision -eq "blocked") {
     $nextAction = New-NextAction "stop_for_user" "리뷰가 blocked 상태입니다." @() @("사용자 판단이 필요하므로 자동 진행을 중단하세요.")
-} elseif ($lastReviewDecision -eq "revise") {
+} elseif ($hasCheckFailure) {
+    $nextAction = New-NextAction "prepare_review_after_check_failure" "build/check가 실패했습니다. 실패 원인을 반영한 리뷰를 먼저 생성해야 합니다." $checkFailureRecommendedCommands @(
+        $(if ($testResultExists) { ".ai-dev/test-result.md에서 실패 원인을 먼저 확인하세요." } else { ".ai-dev/test-result.md가 없으므로 실패 로그를 먼저 확보하세요." }),
+        $(if ($hasImplementationGitChanges) { "구현 변경사항이 있으므로 실패 원인과 함께 현재 diff를 리뷰에 포함하세요." } elseif ($hasNoImplementationGitChanges) { "현재 감지된 구현 변경사항은 없지만 state.json 기준 build/check 실패 상태이므로 실패 로그 확인을 우선하세요." } else { "git 상태를 확인할 수 없지만 state.json 기준 build/check 실패 상태이므로 실패 로그 확인을 우선하세요." }),
+        "save-diff로 현재 변경사항을 저장하고, make-review-prompt -Strict로 실패 결과 기준 리뷰 프롬프트를 생성하세요.",
+        "review-prompt.md를 만든 뒤 Codex 리뷰를 실행하거나 리뷰 결과를 저장해야 합니다.",
+        "리뷰 결과를 받은 뒤 decision이 revise이면 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1 를 실행합니다.",
+        "revise-prompt가 생성된 뒤 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md 로 재수정할 수 있습니다.",
+        "이 revise 단계는 리뷰 결과가 revise인 경우에만 해당하며, build/check 실패 직후에는 먼저 실패 로그 확인, diff 저장, review prompt 생성을 진행하세요."
+    )
+} elseif ($canMakeRevisePrompt) {
     $nextAction = New-NextAction "make_revise_prompt" "리뷰에서 수정이 필요하다고 판정했습니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1"
-    ) @(
-        $(if ($revisePromptExists) { "기존 revise-prompt.md는 현재 리뷰 기준으로 덮어씁니다." } else { "required changes만 반영하세요." })
-    )
+    ) $revisePromptNotes
 } elseif ($lastReviewDecision -eq "pass" -and $lastCommandStatus -eq "passed" -and $hasImplementationGitChanges) {
     $nextAction = New-NextAction "commit" "검증과 리뷰가 통과했고 커밋할 변경사항이 있습니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
@@ -300,6 +369,7 @@ $output = [ordered]@{
         currentTaskPromptExists = $currentTaskPromptExists
         testResultExists = $testResultExists
         diffExists = $diffExists
+        reviewResultExists = $reviewResultExists
         reviewPromptExists = $reviewPromptExists
         revisePromptExists = $revisePromptExists
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