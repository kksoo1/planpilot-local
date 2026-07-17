# AI Dev Revise Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.
이전 리뷰에서 지적된 사항만 수정한다.

## Goal

# 목표

build/check 실패 후 revise 흐름 자동 안내를 추가한다.

## 배경

현재 full auto-cycle은 build/check 실패 시 중단되지만, 이후 사용자가 어떤 파일을 확인하고 어떤 revise 흐름으로 이어가야 하는지 안내가 충분히 명확하지 않다. 실패 원인을 확인한 뒤 재수정 프롬프트 생성 또는 Codex 재수정 실행으로 이어질 수 있는 다음 행동을 작고 안전하게 안내해야 한다.

## 성공 기준

- build/check 실패 상태에서 다음 행동 안내가 revise 흐름을 명확히 제안한다.
- 안내에는 `.ai-dev/test-result.md` 확인과 필요한 재수정 프롬프트 생성 흐름이 포함된다.
- 기존 pass, review revise, commit, complete-task 흐름은 변경하지 않는다.
- 자동으로 위험한 명령을 실행하지 않고 추천 명령만 제공한다.

## 제약사항

- 한 번에 하나의 작은 구현 변경만 수행한다.
- 기존 자동화 스크립트 구조를 우선 사용한다.
- 사용자-facing 안내 문구는 한국어로 작성한다.
- 서버 API, 로그인, 클라우드 동기화, 대규모 재작성은 포함하지 않는다.
- 검증 명령은 사용자가 허용한 경우에만 실행한다.

## 범위 제외

- 실제 build/check 재실행 자동화 확대는 제외한다.
- 리뷰 JSON 포맷 변경은 제외한다.
- task queue schema 변경은 제외한다.
- 앱 화면 UI 변경은 제외한다.

## 수동 검증

- build/check 실패 상태를 가정한 `state.json` 값에서 `scripts/ai-dev-next.ps1 -Json` 출력의 action, reason, recommendedCommands, notes를 확인한다.
- pass 상태와 review revise 상태의 기존 다음 행동 안내가 유지되는지 확인한다.
- 사용자가 허용하면 관련 PowerShell 스크립트의 문법 또는 DryRun 검증을 실행한다.

## Current Task

- Task ID: T001
- Title: build/check 실패 후 revise 안내 추가
- Description: 현재 다음 행동 안내 스크립트의 실패 상태 판정 흐름을 확인하고, build/check 실패 상태에서 사용자가 `.ai-dev/test-result.md`를 확인한 뒤 revise 흐름으로 이어갈 수 있도록 한국어 안내와 추천 명령을 보강한다.
- Type: implementation
- Status: in_progress
- Priority: P1
- Verification:
- build/check 실패 상태에서 다음 행동 안내가 test-result 확인과 revise 흐름을 제안하는지 확인한다.
- 기존 review revise 상태의 make_revise_prompt 안내가 유지되는지 확인한다.
- 사용자가 허용하면 관련 스크립트 DryRun 또는 문법 검증을 실행한다.

## Review Result

- Decision: revise
- Severity: medium
- Next step: revise_with_codex
- Summary: build/check 실패 안내 방향은 맞지만, 실패 상태 감지가 구현 변경 존재 여부에 묶여 있고 full auto-cycle 재실행을 추천해 안전한
 re
vise 안내 요구와 일부 충돌합니다.

## Required Changes

- File: scripts/ai-dev-next.ps1
  - Reason: build/check 실패 안내가 $hasImplementationGitChanges 조건에 묶여 있
어, lastCommand가 check/build/
lint이고 lastCommandStatus가 failed인 상태라도 구현 변경이 없거나 git 상태를 확인하지 못하면 실패
 안내 대신 inspect_status 등으로 떨어질 수 
있습니다.
  - Suggestion: check 실패 판정은 우선 lastCommand가 check 계열이고 lastCommandS
tatus가 passed가 아닌 상태를 기준으로 분
리하고, 구현 변경 존재 여부는 notes에서 보조 설명으로만 사용하세요.
- File: scripts/ai-dev-next.ps1
  - Reason: build/check 실패 직후 recommendedCommands에 ai-dev-auto-cycle
-full.ps1이 포함되어 있어, 작고 안전한 다
음 행동 안내와 실제 build/check 재실행 자동화 확대 제외 조건에 비해 과합니다.
  - Suggestion: 실패 분기에서는 test-result 확인, save-diff, review prompt 생성
, review 저장, revise prompt 생
성/실행 안내까지만 추천하고 auto-cycle-full 재실행 추천은 제거하세요.

## Optional Suggestions

- optional_suggestions는 참고만 하며 구현하지 않는다.
- File: scripts/ai-dev-next.ps1
  - Suggestion: review-response.json 파싱 결과는 현재 revise notes에만 쓰이
므로, 이번 task에 꼭 필요하지 않다면 변경 범위를 줄
이기 위해 제거하거나 별도 후속 작업으로 분리하는 편이 더 단순합니다.

## Diff Context

# AI Dev Diff

## Generated At

2026-07-17 22:52:57

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
- .ai-dev/next-review-revise-compat-fix-prompt.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-next.ps1 | 81 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 4 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-next.ps1 b/scripts/ai-dev-next.ps1
index 5c2d172..e7a1904 100644
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
 
@@ -211,12 +226,61 @@ $lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$stat
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
+$hasCheckFailure = $isCheckCommand -and $lastCommandStatus -ne "passed"
+$hasStateReviseReview = $lastReviewDecision -eq "revise"
+$hasReviewResponseReviseSignal = $reviewResponseExists -and $reviewResponseDecision -eq "revise" -and $reviewResponseNextStep -eq "revise_with_codex"
+$hasReviewResponseMismatch = $reviewResponseExists -and -not $hasReviewResponseReviseSignal
+$canMakeRevisePrompt = $hasStateReviseReview
+
+$checkFailureRecommendedCommands = @()
+$checkFailureRecommendedCommands += "Get-Content -LiteralPath .ai-dev/test-result.md"
+$checkFailureRecommendedCommands += "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1"
+$checkFailureRecommendedCommands += "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict"
+$checkFailureRecommendedCommands += "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview"
+$checkFailureRecommendedCommands += "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1"
+$checkFailureRecommendedCommands += "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md"
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
 
@@ -230,11 +294,19 @@ if (-not (Test-HasValue $currentTaskId) -and $goalStatus -eq "completed") {
     ) @("프롬프트 생성 후 현재 task만 수행하세요.")
 } elseif ($lastReviewDecision -eq "blocked") {
     $nextAction = New-NextAction "stop_for_user" "리뷰가 blocked 상태입니다." @() @("사용자 판단이 필요하므로 자동 진행을 중단하세요.")
-} elseif ($lastReviewDecision -eq "revise") {
+} elseif ($canMakeRevisePrompt) {
     $nextAction = New-NextAction "make_revise_prompt" "리뷰에서 수정이 필요하다고 판정했습니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1"
-    ) @(
-        $(if ($revisePromptExists) { "기존 revise-prompt.md는 현재 리뷰 기준으로 덮어씁니다." } else { "required changes만 반영하세요." })
+    ) $revisePromptNotes
+} elseif ($hasCheckFailure) {
+    $nextAction = New-NextAction "prepare_review_after_check_failure" "build/check가 실패했습니다. 실패 원인을 반영한 리뷰를 먼저 생성해야 합니다." $checkFailureRecommendedCommands @(
+        $(if ($testResultExists) { ".ai-dev/test-result.md에서 실패 원인을 먼저 확인하세요." } else { ".ai-dev/test-result.md가 없으므로 실패 로그를 먼저 확보하세요." }),
+        $(if ($hasImplementationGitChanges) { "구현 변경사항이 있으므로 실패 원인과 함께 현재 diff를 리뷰에 포함하세요." } elseif ($hasNoImplementationGitChanges) { "현재 감지된 구현 변경사항은 없지만 state.json 기준 build/check 실패 상태이므로 실패 로그 확인을 우선하세요." } else { "git 상태를 확인할 수 없지만 state.json 기준 build/check 실패 상태이므로 실패 로그 확인을 우선하세요." }),
+        "save-diff로 현재 변경사항을 저장하고, make-review-prompt -Strict로 실패 결과 기준 리뷰 프롬프트를 생성하세요.",
+        "run-review-codex -AllowDirty -SaveReview로 실패 원인을 반영한 리뷰를 저장하세요.",
+        "리뷰 결과가 revise이면 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1 를 실행합니다.",
+        "그 후 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md 를 실행합니다.",
+        "위 revise 단계는 리뷰 결과가 revise인 경우의 다음 단계이며, build/check 실패 직후에는 먼저 diff와 review를 생성하세요."
     )
 } elseif ($lastReviewDecision -eq "pass" -and $lastCommandStatus -eq "passed" -and $hasImplementationGitChanges) {
     $nextAction = New-NextAction "commit" "검증과 리뷰가 통과했고 커밋할 변경사항이 있습니다." @(
@@ -300,6 +372,7 @@ $output = [ordered]@{
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

## Test Result

# AI Dev Test Result

## 2026-07-17 22:52:50

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
dist/assets/index-DtLVvPCG.js   317.50 kB │ gzip: 100.16 kB

[32m✓ built in 197ms[39m
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

## Allowed Scope

- required_changes에 필요한 최소 수정만 허용한다.
- 현재 task 범위를 벗어나지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 새 기능 추가보다 리뷰 지적사항 해결을 우선한다.

## Hard Rules

- `package.json`과 `package-lock.json`은 수정하지 않는다. 꼭 필요하면 중단하고 이유만 기록한다.
- 실제 DB 삭제 또는 초기화를 하지 않는다.
- 사용자 데이터 복원 또는 덮어쓰기를 하지 않는다.
- 대규모 리팩터링을 하지 않는다.
- git commit을 실행하지 않는다.
- git reset, git checkout, git clean을 실행하지 않는다.
- npm install을 실행하지 않는다.
- optional_suggestions는 기본적으로 구현하지 않는다.

## Required Output

- 반영한 required_changes 목록
- 수정한 파일 목록
- 검증 방법
- 반영하지 못한 항목과 이유
- 남은 위험
- `.ai-dev/loop-log.md`에 기록할 재수정 요약