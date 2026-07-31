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
자동화가 구현 시작 전 예상 가능한 사유로 중단될 때, 이번 실행에서 생성하거나 수정한 운영 파일만 안전하게 정리해 다음 auto-goal 실행이 수동 정리 없이 시작될 수 있게 한다.

## 배경
`ai-dev-autopilot.ps1` 또는 `ai-dev-auto-goal.ps1`이 `all_goal_candidates_excluded`, `baseline_output_conflict`, `dirty_worktree`, `max_steps_too_small_for_full_cycle` 같은 사유로 구현 단계 전에 종료되면 `state.json`, `codex-result.md`, `loop-log.md`, `autopilot-goal-history.json` 등 운영 파일이 불필요하게 dirty 상태로 남을 수 있다. 실행 전부터 존재하던 사용자 변경은 보존해야 하며, 자동화가 이번 실행에서 만든 변경만 정리 대상이어야 한다.

## 성공 기준
- 구현 시작 전 예상된 비작업 종료와 실제 실패를 구분해 기록한다.
- 이번 실행에서 만든 운영 파일 변경만 정리하거나 메타 커밋 대상으로 분류한다.
- 실행 전부터 존재하던 사용자 변경은 삭제하거나 복원하지 않는다.
- 다음 auto-goal 실행이 수동 정리 없이 시작될 수 있다.
- 정리 대상과 보존 대상의 판단 근거가 코드상 명확하다.

## 제약사항
- 기존 사용자 변경을 되돌리지 않는다.
- 운영 파일 정리 범위는 자동화 실행 중 생성된 변경으로 제한한다.
- 한 번에 작은 변경으로 구현한다.
- 기존 스크립트 구조와 기록 방식을 우선 따른다.

## 범위 제외
- 자동화 실행 흐름의 대규모 재작성은 제외한다.
- 새로운 저장소 구조 도입은 제외한다.
- UI 기능 추가는 제외한다.
- 알림 기능 추가는 제외한다.

## 수동 검증
- 구현 시작 전 중단 사유별로 운영 파일이 불필요하게 dirty 상태로 남지 않는지 확인한다.
- 실행 전부터 수정되어 있던 운영 파일이 보존되는지 확인한다.
- 성공, 예상된 비작업 종료, 실제 실패 기록이 구분되는지 확인한다.

## Current Task

- Task ID: T001
- Title: 운영 파일 정리 흐름 안정화
- Description: 자동화가 구현 시작 전 예상된 사유로 중단될 때 이번 실행에서 만든 운영 파일 변경만 정리하거나 메타 기록 대상으로 분류하도록 기존 흐름을 점검하고 최소 수정한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- 예상된 비작업 종료 사유에서 운영 파일 변경 처리 경로를 확인한다.
- 실행 전부터 있던 사용자 변경을 보존하는 조건을 확인한다.
- 성공, 예상된 비작업 종료, 실제 실패 기록이 구분되는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-31 15:26:27

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

[32m✓ built in 327ms[39m
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
## Expected non-work cleanup verification

- Environment: isolated real Git worktrees
- Scripts under verification: scripts/ai-dev-auto-goal.ps1 and scripts/ai-dev-autopilot.ps1
- Verified scenarios: dirty_worktree, baseline_output_conflict, all_goal_candidates_excluded

### Scenario: dirty-worktree

- Expected stopped reason: dirty_worktree
- Exit code: 1
- Original stopped reason preserved: True
- expected_non_work classification preserved: True
- Baseline user marker preserved: True
- New dirty paths created: 0
- No new dirty paths: True
- Staged paths left behind: 0
- No staged paths left behind: True
- Manual git restore required for run-owned files: False

Baseline status:
```text
 M .ai-dev/loop-log.md
 M scripts/ai-dev-auto-goal.ps1
 M scripts/ai-dev-autopilot.ps1
```

Status after execution:
```text
 M .ai-dev/loop-log.md
 M scripts/ai-dev-auto-goal.ps1
 M scripts/ai-dev-autopilot.ps1
```

New dirty paths:
```text

```

Captured output:
```text
Step 1: validate-input
  Command: check GoalTitle/GoalDescription
  Executed: False
  Skipped: False
  Exit code: 0
  Message: Input validation completed: Expected non-work verification
Step 2: dirty-worktree-gate
  Command: git status --porcelain
  Executed: False
  Skipped: True
  Exit code: 1
  Message: Baseline dirty count: 3
Worktree is dirty. Use -AllowDirty only when this is intentional.
 M .ai-dev/loop-log.md
 M scripts/ai-dev-auto-goal.ps1
 M scripts/ai-dev-autopilot.ps1
Step 3: expected-non-work-cleanup
  Command: restore current-run .ai-dev operational file snapshots
  Executed: True
  Skipped: False
  Exit code: 0
  Message: Expected pre-implementation stop. Restored only auto-goal operational files captured at run start; baseline user changes were preserved. Cleaned run-owned files: .ai-dev/queue.json, .ai-dev/current-task-prompt.md, .ai-dev/codex-result.md, .ai-dev/auto-goal-planning-prompt.md, .ai-dev/goal.md, .ai-dev/auto-goal-codex-result.md, .ai-dev/state.json
Step 4: expected-non-work-meta-record
  Command: write expected non-work final result
  Executed: False
  Skipped: True
  Exit code: 0
  Message: Expected pre-implementation stop is reported in console output only. -AllowCommit is not set, so no result file or other .ai-dev operational change is left behind.
Stopped reason: dirty_worktree
Outcome category: expected_non_work
Completed: False
Exit code: 1
```

### Scenario: baseline-output-conflict

- Expected stopped reason: baseline_output_conflict
- Exit code: 1
- Original stopped reason preserved: True
- expected_non_work classification preserved: True
- Baseline user marker preserved: True
- New dirty paths created: 0
- No new dirty paths: True
- Staged paths left behind: 0
- No staged paths left behind: True
- Manual git restore required for run-owned files: False

Baseline status:
```text
 M .ai-dev/codex-result.md
 M scripts/ai-dev-auto-goal.ps1
 M scripts/ai-dev-autopilot.ps1
```

Status after execution:
```text
 M .ai-dev/codex-result.md
 M scripts/ai-dev-auto-goal.ps1
 M scripts/ai-dev-autopilot.ps1
```

New dirty paths:
```text

```

Captured output:
```text
Step 1: validate-input
  Command: check GoalTitle/GoalDescription
  Executed: False
  Skipped: False
  Exit code: 0
  Message: Input validation completed: Expected non-work verification
Step 2: baseline-output-conflict-gate
  Command: compare baseline dirty paths with planned auto-goal outputs
  Executed: True
  Skipped: False
  Exit code: 1
  Message: Baseline dirty paths conflict with planned auto-goal output paths. Auto-goal stopped before writing or deleting protected output files.
Conflicting paths:
.ai-dev/codex-result.md
Step 3: expected-non-work-cleanup
  Command: restore current-run .ai-dev operational file snapshots
  Executed: True
  Skipped: False
  Exit code: 0
  Message: Expected pre-implementation stop. Restored only auto-goal operational files captured at run start; baseline user changes were preserved. Cleaned run-owned files: .ai-dev/queue.json, .ai-dev/current-task-prompt.md, .ai-dev/auto-goal-planning-prompt.md, .ai-dev/goal.md, .ai-dev/auto-goal-codex-result.md, .ai-dev/state.json
Stopped reason: baseline_output_conflict
Outcome category: expected_non_work
Completed: False
Exit code: 1
```

### Scenario: all-goal-candidates-excluded

- Expected stopped reason: all_goal_candidates_excluded
- Exit code: 1
- Original stopped reason preserved: True
- expected_non_work classification preserved: True
- Baseline user marker preserved: True
- New dirty paths created: 0
- No new dirty paths: True
- Staged paths left behind: 0
- No staged paths left behind: True
- Manual git restore required for run-owned files: False

Baseline status:
```text
 M scripts/ai-dev-auto-goal.ps1
 M scripts/ai-dev-autopilot.ps1
```

Status after execution:
```text
 M scripts/ai-dev-auto-goal.ps1
 M scripts/ai-dev-autopilot.ps1
```

New dirty paths:
```text

```

Captured output:
```text
Step 1: validate-input
  Executed: False
  Skipped: False
  Exit code: 0
  Message: Autopilot input validation completed. MaxGoals=1, MaxTasks=1, MaxSteps=40
Step 2: current-goal-gate
  Executed: False
  Skipped: False
  Exit code: 0
  Message: Current goal is completed. Previous goal: auto-goal MaxSteps 湲곕낯媛??덉젙??Step 3: generate-goal-candidate
  Executed: False
  Skipped: True
  Exit code: 1
  Message: Autopilot ?꾨낫媛 紐⑤몢 ?뚯쭊?섏뿀?듬땲?? ?꾩옱 ?곹깭: goalStatus=completed, currentTaskId=, openTaskCount=0, currentGoal=auto-goal MaxSteps 湲곕낯媛??덉젙?? ?쒖쇅??backlog ?꾨낫 ?? 14/14. 紐⑤뱺 ?꾨낫媛 ?꾩옱 goal, 以鍮??대젰, ?꾨즺 ?대젰 ?먮뒗 durable history? 以묐났?섏뼱 ?좉퇋 goal???먮룞 ?앹꽦?섏? ?딆뒿?덈떎. ?ㅼ쓬 ?됰룞: 1. .ai-dev/backlog.md???덈줈??backlog ??ぉ??異붽??⑸땲?? 2. ?대? ?꾨즺???꾨낫瑜??ㅼ떆 吏꾪뻾?댁빞 ?쒕떎硫?durable history? ?꾨즺 ?대젰???щ엺??癒쇱? 寃?좏빀?덈떎. 3. 吏湲덉? ?먮룞 吏꾪뻾??硫덉텛怨??꾩옱 ?곹깭瑜??좎??⑸땲?? 怨꾩냽 吏꾪뻾?섎젮硫???backlog ??ぉ???꾩슂?⑸땲?? ?쒖쇅???꾨낫: Codex CLI ?꾩쟾 ?먮룞???뺤콉 臾몄꽌?? Codex 援ы쁽 ?ㅽ뻾 ?ㅽ겕由쏀듃 異붽?; Codex 由щ럭 ?ㅽ뻾 ?ㅽ겕由쏀듃 異붽?; full auto-cycle 珥덉븞 異붽?; ?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐; MaxTasks 1 end-to-end 寃利? full auto-cycle 濡쒓렇 援ъ“ 媛쒖꽑; package 蹂寃?媛먯? 硫붿떆吏 媛쒖꽑; build/check ?ㅽ뙣 ??revise ?먮쫫 ?먮룞 ?덈궡; Codex 由щ럭 JSON 異붿텧 ?ㅽ뙣 泥섎━ 蹂닿컯; GitHub PR ?곕룞 寃?? Copilot CLI ?먮뒗 gh ?곕룞 ?ш??? ?κ린 ?ㅽ뻾 ?먮룞??紐⑤땲?곕쭅 ?뺤콉; 蹂묐젹 task ?ㅽ뻾 媛?μ꽦 寃?? ?쒖쇅 湲곗? title: auto-goal MaxSteps 湲곕낯媛??덉젙?? Codex 援ы쁽 ?ㅽ뻾 ?ㅽ겕由쏀듃 異붽?; Codex CLI ?꾩쟾 ?먮룞???뺤콉 臾몄꽌?? full auto-cycle 珥덉븞 異붽?; Codex 由щ럭 ?ㅽ뻾 ?ㅽ겕由쏀듃 異붽?; package 蹂寃?媛먯? 硫붿떆吏 媛쒖꽑; GitHub PR ?곕룞 寃?? ?κ린 ?ㅽ뻾 ?먮룞??紐⑤땲?곕쭅 ?뺤콉; 蹂묐젹 task ?ㅽ뻾 媛?μ꽦 寃?? Autopilot DryRun codex-result dirty 諛⑹?; ?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐; Autopilot history dirty gate 異⑸룎 ?섏젙; MaxTasks 1 end-to-end 寃利? Verification task revise ?먮룞 泥섎━; full auto-cycle 濡쒓렇 援ъ“ 媛쒖꽑; build/check ?ㅽ뙣 ??revise ?먮쫫 ?먮룞 ?덈궡; Codex 由щ럭 JSON 異붿텧 ?ㅽ뙣 泥섎━ 蹂닿컯; Copilot CLI ?먮뒗 gh ?곕룞 ?ш??? Durable history title: Autopilot DryRun codex-result dirty 諛⑹?; ?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐; Autopilot history dirty gate 異⑸룎 ?섏젙; MaxTasks 1 end-to-end 寃利? Verification task revise ?먮룞 泥섎━; full auto-cycle 濡쒓렇 援ъ“ 媛쒖꽑; package 蹂寃?媛먯? 硫붿떆吏 媛쒖꽑; build/check ?ㅽ뙣 ??revise ?먮쫫 ?먮룞 ?덈궡; Codex 由щ럭 JSON 異붿텧 ?ㅽ뙣 泥섎━ 蹂닿컯; GitHub PR ?곕룞 寃?? Copilot CLI ?먮뒗 gh ?곕룞 ?ш??? ?κ린 ?ㅽ뻾 ?먮룞??紐⑤땲?곕쭅 ?뺤콉; 蹂묐젹 task ?ㅽ뻾 媛?μ꽦 寃?? auto-goal MaxSteps 湲곕낯媛??덉젙??
Step 4: expected-non-work-cleanup
  Executed: True
  Skipped: False
  Exit code: 0
  Message: Classification: expected_non_work. Original stopped reason: all_goal_candidates_excluded. Baseline dirty files skipped: . Cleaned run-owned files: .ai-dev/loop-log.md, .ai-dev/autopilot-goal-history.json, .ai-dev/state.json. Meta commit created: False (skipped (-AllowCommit not set)). Next run without manual git restore: True. Restored only autopilot operational files captured at run start; baseline user changes were preserved.
Stopped reason: all_goal_candidates_excluded
Outcome category: expected_non_work
Operational cleanup performed: True
Meta commit created: False
Next run without manual restore: True
Completed: False
Prepared goals: 0/1
Exit code: 1
```


## Diff To Review

# AI Dev Diff

## Generated At

2026-07-31 15:42:47

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
 M scripts/ai-dev-auto-goal.ps1
 M scripts/ai-dev-autopilot.ps1
```

## App Change Files

- scripts/ai-dev-auto-goal.ps1
- scripts/ai-dev-autopilot.ps1

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

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-auto-goal.ps1 | 235 +++++++++++++++++++++++++++++++++-
 scripts/ai-dev-autopilot.ps1 | 295 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 512 insertions(+), 18 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 5869e33..070042f 100644
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -30,6 +30,7 @@ $legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"
 $aiDevOperationalRoot = ".ai-dev/"
 $script:autoGoalCanWriteResultFile = $true
 $script:autoGoalCanCleanTempArtifacts = $true
+$script:autoGoalOperationalFileSnapshots = @{}
 
 function Resolve-RepoPath {
     param([string]$Path)
@@ -98,9 +99,18 @@ function New-AutoGoalResult {
         [int]$ExitCode
     )
 
+    $outcomeCategory = if (Test-IsExpectedPreImplementationStop $StoppedReason) {
+        "expected_non_work"
+    } elseif ($ExitCode -eq 0) {
+        "success"
+    } else {
+        "actual_failure"
+    }
+
     return [PSCustomObject][ordered]@{
         steps = @($Steps)
         stoppedReason = $StoppedReason
+        outcomeCategory = $outcomeCategory
         completed = $Completed
         exitCode = $ExitCode
         plan = $script:autoGoalPlanPreview
@@ -145,6 +155,7 @@ function Write-AutoGoalResult {
     }
 
     Write-Host "Stopped reason: $($Result.stoppedReason)"
+    Write-Host "Outcome category: $($Result.outcomeCategory)"
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 }
@@ -172,6 +183,7 @@ function Save-AutoGoalResultFile {
 ## Summary
 
 - Stopped reason: $($result.stoppedReason)
+- Outcome category: $($result.outcomeCategory)
 - Completed: $($result.completed)
 - Exit code: $($result.exitCode)
 - Result path: $($result.resultPath)
@@ -184,6 +196,55 @@ $($stepLines -join "`r`n")
     [System.IO.File]::WriteAllText($resolvedResultPath, $content, $utf8WithBom)
 }
 
+function Invoke-AutoGoalExpectedNonWorkMetaCommit {
+    param([int]$StepNumber)
+
+    if ($DryRun) {
+        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git add/commit expected non-work result" $false $true 0 "DryRun: expected non-work result meta commit was not executed."
+    }
+
+    if (-not $AllowCommit) {
+        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git add/commit expected non-work result" $false $true 0 "AllowCommit is not set, so expected non-work result remains an uncommitted meta record."
+    }
+
+    $resultRelativePath = ConvertTo-NormalizedChangedPath (ConvertTo-RepoRelativePath $ResultPath)
+
+    if (@($script:autoGoalBaselineDirtyPaths) -contains $resultRelativePath) {
+        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git add/commit expected non-work result" $false $true 0 "Expected non-work result meta commit skipped because ResultPath was baseline dirty and protected: $resultRelativePath"
+    }
+
+    $statusOutput = & git status --short -- $resultRelativePath 2>&1 | Out-String
+    $statusExitCode = $LASTEXITCODE
+
+    if ($statusExitCode -ne 0) {
+        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git status --short -- <result file>" $true $false 1 "git status for expected non-work result failed. exit code: $statusExitCode`n$statusOutput"
+    }
+
+    if (-not (Test-HasValue $statusOutput)) {
+        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git status --short -- <result file>" $true $false 0 "Expected non-work result file had no changes to commit."
+    }
+
+    $addOutput = & git add -- $resultRelativePath 2>&1 | Out-String
+    $addExitCode = $LASTEXITCODE
+
+    if ($addExitCode -ne 0) {
+        & git restore --staged -- $resultRelativePath 2>&1 | Out-String | Out-Null
+        $restoredPaths = @(Restore-AutoGoalCurrentRunOperationalChanges @($resultRelativePath))
+        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git add -- <result file>" $true $false 1 "Expected non-work result git add failed. exit code: $addExitCode`n$addOutput`nRestored run-owned files: $($restoredPaths -join ', ')"
+    }
+
+    $commitOutput = & git commit -m "chore(ai-dev): record expected non-work stop" -- $resultRelativePath 2>&1 | Out-String
+    $commitExitCode = $LASTEXITCODE
+
+    if ($commitExitCode -ne 0) {
+        & git restore --staged -- $resultRelativePath 2>&1 | Out-String | Out-Null
+        $restoredPaths = @(Restore-AutoGoalCurrentRunOperationalChanges @($resultRelativePath))
+        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git commit -- <result file>" $true $false 1 "Expected non-work result commit failed. exit code: $commitExitCode`n$commitOutput`nRestored run-owned files: $($restoredPaths -join ', ')"
+    }
+
+    return New-StepResult $StepNumber "expected-non-work-meta-commit" "git add/commit expected non-work result" $true $false 0 $commitOutput.Trim()
+}
+
 function Clear-AutoGoalTempArtifacts {
     if (-not $script:autoGoalCanCleanTempArtifacts) {
         return
@@ -192,6 +253,12 @@ function Clear-AutoGoalTempArtifacts {
     $currentResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ResultPath))
 
     foreach ($relativePath in @($planningPromptRelativePath, $legacyAutoGoalResultRelativePath)) {
+        $normalizedRelativePath = ConvertTo-NormalizedChangedPath (ConvertTo-RepoRelativePath $relativePath)
+
+        if (@($script:autoGoalBaselineDirtyPaths) -contains $normalizedRelativePath) {
+            continue
+        }
+
         $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $relativePath))
 
         if (-not $fullPath.StartsWith($repoRoot.TrimEnd("\") + "\", [System.StringComparison]::OrdinalIgnoreCase)) {
@@ -212,6 +279,98 @@ function Clear-AutoGoalTempArtifacts {
     }
 }
 
+function Test-IsExpectedPreImplementationStop {
+    param([string]$StoppedReason)
+
+    return @(
+        "baseline_output_conflict",
+        "dirty_worktree",
+        "max_steps_too_small_for_full_cycle"
+    ) -contains $StoppedReason
+}
+
+function Initialize-AutoGoalOperationalFileSnapshots {
+    $script:autoGoalOperationalFileSnapshots = @{}
+
+    foreach ($relativePath in @(Get-PlannedAutoGoalOutputPaths)) {
+        $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $relativePath))
+
+        if (-not $fullPath.StartsWith($repoRoot.TrimEnd("\") + "\", [System.StringComparison]::OrdinalIgnoreCase)) {
+            continue
+        }
+
+        $exists = [System.IO.File]::Exists($fullPath)
+        $bytes = $null
+
+        if ($exists) {
+            $bytes = [System.IO.File]::ReadAllBytes($fullPath)
+        }
+
+        $script:autoGoalOperationalFileSnapshots[$relativePath] = [PSCustomObject][ordered]@{
+            path = $fullPath
+            existed = $exists
+            bytes = $bytes
+        }
+    }
+}
+
+function Restore-AutoGoalCurrentRunOperationalChanges {
+    param([string[]]$RelativePaths = @())
+
+    $restoredPaths = @()
+
+    if ($null -eq $script:autoGoalOperationalFileSnapshots) {
+        return @($restoredPaths)
+    }
+
+    $targetPaths = @($RelativePaths | ForEach-Object { ConvertTo-NormalizedChangedPath $_ } | Where-Object { Test-HasValue $_ } | Select-Object -Unique)
+    $baselineDirtyPaths = @($script:autoGoalBaselineDirtyPaths)
+
+    foreach ($entry in @($script:autoGoalOperationalFileSnapshots.GetEnumerator())) {
+        $relativePath = ConvertTo-NormalizedChangedPath ([string]$entry.Key)
+        $snapshot = $entry.Value
+
+        if ($targetPaths.Count -gt 0 -and $targetPaths -notcontains $relativePath) {
+            continue
+        }
+
+        if ($baselineDirtyPaths -contains $relativePath) {
+            continue
+        }
+
+        $fullPath = [string]$snapshot.path
+
+        if (-not $fullPath.StartsWith($repoRoot.TrimEnd("\") + "\", [System.StringComparison]::OrdinalIgnoreCase)) {
+            continue
+        }
+
+        try {
+            if ($snapshot.existed) {
+                [System.IO.File]::WriteAllBytes($fullPath, [byte[]]$snapshot.bytes)
+            } elseif ([System.IO.File]::Exists($fullPath)) {
+                [System.IO.File]::Delete($fullPath)
+            }
+            $restoredPaths += $relativePath
+        } catch {
+            Write-Warning "Failed to restore auto-goal operational file snapshot: $fullPath"
+        }
+    }
+
+    return @($restoredPaths | Select-Object -Unique)
+}
+
+function Test-CanWriteExpectedNonWorkResultFile {
+    $resultRelativePath = ConvertTo-NormalizedChangedPath (ConvertTo-RepoRelativePath $ResultPath)
+    $snapshot = $script:autoGoalOperationalFileSnapshots[$resultRelativePath]
+    $baselineDirtyPaths = @($script:autoGoalBaselineDirtyPaths)
+
+    if ($null -ne $snapshot -and $snapshot.existed -and $baselineDirtyPaths -contains $resultRelativePath) {
+        return $false
+    }
+
+    return $true
+}
+
 function Stop-AutoGoal {
     param(
         [object[]]$Steps,
@@ -220,19 +379,72 @@ function Stop-AutoGoal {
         [int]$ExitCode
     )
 
+    $isExpectedPreImplementationStop = Test-IsExpectedPreImplementationStop $StoppedReason
+
     if (-not $DryRun) {
         Clear-AutoGoalTempArtifacts
+
+        if ($isExpectedPreImplementationStop) {
+            $cleanedRunOwnedPaths = @(Restore-AutoGoalCurrentRunOperationalChanges)
+            $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-cleanup" "restore current-run .ai-dev operational file snapshots" $true $false 0 "Expected pre-implementation stop. Restored only auto-goal operational files captured at run start; baseline user changes were preserved. Cleaned run-owned files: $($cleanedRunOwnedPaths -join ', ')"
+        }
     }
 
+    $script:steps = @($Steps)
+
     if (-not $DryRun -and (-not $Completed -or $ExitCode -ne 0)) {
         if ($script:autoGoalCanWriteResultFile) {
-            Save-AutoGoalResultFile $StoppedReason $false $ExitCode
+            if ($isExpectedPreImplementationStop) {
+                if ($AllowCommit) {
+                    if (Test-CanWriteExpectedNonWorkResultFile) {
+                        $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-meta-record" "write expected non-work final result" $true $false 0 "Expected pre-implementation stop is recorded as outcomeCategory=expected_non_work in the final result file because -AllowCommit is set."
+                        $script:steps = @($Steps)
+                        Save-AutoGoalResultFile $StoppedReason $false $ExitCode
+                        $metaCommitStep = Invoke-AutoGoalExpectedNonWorkMetaCommit ($Steps.Count + 1)
+                        $Steps += $metaCommitStep
+                        $script:steps = @($Steps)
+
+                        if ($metaCommitStep.exitCode -ne 0) {
+                            $originalStoppedReason = $StoppedReason
+                            $StoppedReason = "expected_non_work_meta_commit_failed"
+                            $isExpectedPreImplementationStop = $false
+                            $Completed = $false
+                            $ExitCode = 1
+                            $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-meta-failure" "classify expected non-work meta commit failure" $true $false 1 "Expected pre-implementation stop meta commit failed and is reclassified as actual_failure. Original stopped reason: $originalStoppedReason"
+                            $script:steps = @($Steps)
+                        }
+                    } else {
+                        $resultRelativePath = ConvertTo-NormalizedChangedPath (ConvertTo-RepoRelativePath $ResultPath)
+                        $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-meta-record" "write expected non-work final result" $false $true 0 "Expected pre-implementation stop is reported in console output only. ResultPath existed at run start and was baseline dirty, so auto-goal did not overwrite preserved user changes: $resultRelativePath"
+                        $script:steps = @($Steps)
+                    }
+                } else {
+                    $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-meta-record" "write expected non-work final result" $false $true 0 "Expected pre-implementation stop is reported in console output only. -AllowCommit is not set, so no result file or other .ai-dev operational change is left behind."
+                    $script:steps = @($Steps)
+                }
+            } else {
+                Save-AutoGoalResultFile $StoppedReason $false $ExitCode
+            }
         }
     }
     Write-AutoGoalResult (New-AutoGoalResult $Steps $StoppedReason $Completed $ExitCode)
     exit $ExitCode
 }
 
+function Get-StoppedReasonFromOutput {
+    param([string]$Output)
+
+    if (-not (Test-HasValue $Output)) {
+        return ""
+    }
+
+    if ($Output -match '(?m)^\s*Stopped reason:\s*(\S+)\s*$') {
+        return $Matches[1]
+    }
+
+    return ""
+}
+
 function Get-InputPreview {
     param([string]$RawInput)
 
@@ -437,8 +649,10 @@ function Invoke-FinalAutoGoalChangeGate {
     $addExitCode = $LASTEXITCODE
 
     if ($addExitCode -ne 0) {
+        & git restore --staged -- $newAiDevPaths 2>&1 | Out-String | Out-Null
+        $restoredPaths = @(Restore-AutoGoalCurrentRunOperationalChanges $newAiDevPaths)
         $message = "auto-goal 최종 .ai-dev 메타 변경 git add 실패. exit code: $addExitCode`n$addOutput"
-        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-dev files>" $true $false 1 $message
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-dev files>" $true $false 1 "$message`nRestored run-owned files: $($restoredPaths -join ', ')"
         Stop-AutoGoal $script:steps "final_meta_add_failed" $false 1
     }
 
@@ -448,8 +662,10 @@ function Invoke-FinalAutoGoalChangeGate {
     $commitExitCode = $LASTEXITCODE
 
     if ($commitExitCode -ne 0) {
+        & git restore --staged -- $newAiDevPaths 2>&1 | Out-String | Out-Null
+        $restoredPaths = @(Restore-AutoGoalCurrentRunOperationalChanges $newAiDevPaths)
         $message = "auto-goal 최종 .ai-dev 메타 커밋 실패. exit code: $commitExitCode`n$commitOutput"
-        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m '$metaCommitMessage' -- <final .ai-dev files>" $true $false 1 $message
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m '$metaCommitMessage' -- <final .ai-dev files>" $true $false 1 "$message`nRestored run-owned files: $($restoredPaths -join ', ')"
         Stop-AutoGoal $script:steps "final_meta_commit_failed" $false 1
     }
 
@@ -588,8 +804,10 @@ function Invoke-FinalPreparedResultGate {
     $addExitCode = $LASTEXITCODE
 
     if ($addExitCode -ne 0) {
+        & git restore --staged -- $newAiDevPaths 2>&1 | Out-String | Out-Null
+        $restoredPaths = @(Restore-AutoGoalCurrentRunOperationalChanges $newAiDevPaths)
         $message = "auto-goal 최종 .ai-dev 메타 변경 git add 실패. exit code: $addExitCode`n$addOutput"
-        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-dev files>" $true $false 1 $message
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-dev files>" $true $false 1 "$message`nRestored run-owned files: $($restoredPaths -join ', ')"
         Stop-AutoGoal $script:steps "final_meta_add_failed" $false 1
     }
 
@@ -599,8 +817,10 @@ function Invoke-FinalPreparedResultGate {
     $commitExitCode = $LASTEXITCODE
 
     if ($commitExitCode -ne 0) {
+        & git restore --staged -- $newAiDevPaths 2>&1 | Out-String | Out-Null
+        $restoredPaths = @(Restore-AutoGoalCurrentRunOperationalChanges $newAiDevPaths)
         $message = "auto-goal 최종 .ai-dev 메타 커밋 실패. exit code: $commitExitCode`n$commitOutput"
-        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m '$metaCommitMessage' -- <final .ai-dev files>" $true $false 1 $message
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m '$metaCommitMessage' -- <final .ai-dev files>" $true $false 1 "$message`nRestored run-owned files: $($restoredPaths -join ', ')"
         Stop-AutoGoal $script:steps "final_meta_commit_failed" $false 1
     }
 
@@ -1107,7 +1327,9 @@ function Invoke-CycleCommand {
     $script:steps += New-StepResult $StepNumber $Name $Command $true $false $exitCode $message
 
     if ($exitCode -ne 0) {
-        Stop-AutoGoal $script:steps "$Name`_failed" $false 1
+        $childStoppedReason = Get-StoppedReasonFromOutput $message
+        $stoppedReason = if (Test-IsExpectedPreImplementationStop $childStoppedReason) { $childStoppedReason } else { "$Name`_failed" }
+        Stop-AutoGoal $script:steps $stoppedReason $false 1
     }
 }
 
@@ -1174,6 +1396,7 @@ $resolvedQueuePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $queueRelat
 $resolvedStatePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $stateRelativePath))
 $resolvedPlanningPromptPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $planningPromptRelativePath))
 $resolvedResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ResultPath))
+Initialize-AutoGoalOperationalFileSnapshots
 
 if (-not (Test-HasValue $GoalTitle)) {
     $script:steps += New-StepResult 0 "validate-input" "check GoalTitle" $false $false 1 "GoalTitle must not be empty."
diff --git a/scripts/ai-dev-autopilot.ps1 b/scripts/ai-dev-autopilot.ps1
index 52da0ce..4c8c3f2 100644
--- a/scripts/ai-dev-autopilot.ps1
+++ b/scripts/ai-dev-autopilot.ps1
@@ -38,6 +38,8 @@ $backlogPath = Join-Path $repoRoot $backlogRelativePath
 $loopLogPath = Join-Path $repoRoot $loopLogRelativePath
 $goalHistoryPath = Join-Path $repoRoot $goalHistoryRelativePath
 $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
+$script:autopilotOperationalFileSnapshots = @{}
+$script:autopilotBaselineDirtyPaths = @()
 
 function Test-HasValue {
     param([object]$Value)
@@ -153,6 +155,10 @@ function Add-AutopilotGoalHistoryTitle {
         return
     }
 
+    if (Test-IsAutopilotBaselineDirtyPath $goalHistoryRelativePath) {
+        return
+    }
+
     $now = [DateTimeOffset]::UtcNow.ToString("o")
     $trimmedTitle = $Title.Trim()
     $history = Read-AutopilotGoalHistory
@@ -245,6 +251,10 @@ function Add-LoopLogEntry {
         return
     }
 
+    if (Test-IsAutopilotBaselineDirtyPath $loopLogRelativePath) {
+        return
+    }
+
     $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
     $entryLines = @("", "## $timestamp - $Title", "")
     $entryLines += @($Lines)
@@ -252,6 +262,178 @@ function Add-LoopLogEntry {
     [System.IO.File]::AppendAllText($loopLogPath, ($entryLines -join "`r`n"), $utf8WithBom)
 }
 
+function Test-IsExpectedAutopilotNonWorkStop {
+    param([string]$StoppedReason)
+
+    return @(
+        "all_goal_candidates_excluded",
+        "baseline_output_conflict",
+        "dirty_worktree",
+        "goal_candidate_not_found",
+        "current_goal_not_completed",
+        "max_steps_too_small_for_full_cycle"
+    ) -contains $StoppedReason
+}
+
+function Get-StoppedReasonFromOutput {
+    param([string]$Output)
+
+    if (-not (Test-HasValue $Output)) {
+        return ""
+    }
+
+    if ($Output -match '(?m)^\s*Stopped reason:\s*(\S+)\s*$') {
+        return $Matches[1]
+    }
+
+    if ($Output -match '(?m)"stoppedReason"\s*:\s*"([^"]+)"') {
+        return $Matches[1]
+    }
+
+    return ""
+}
+
+function ConvertTo-NormalizedChangedPath {
+    param([string]$RelativePath)
+
+    if (-not (Test-HasValue $RelativePath)) {
+        return $null
+    }
+
+    return $RelativePath.Trim().Trim('"').Replace('\', '/')
+}
+
+function Convert-ToChangedPath {
+    param([string]$ChangeLine)
+
+    if ([string]::IsNullOrWhiteSpace($ChangeLine)) {
+        return @()
+    }
+
+    $pathText = $ChangeLine
+
+    if ($ChangeLine.Length -ge 4 -and $ChangeLine.Substring(2, 1) -eq " ") {
+        $pathText = $ChangeLine.Substring(3)
+    }
+
+    if ($pathText.Contains(" -> ")) {
+        return @($pathText -split " -> " | Where-Object { Test-HasValue $_ })
+    }
+
+    return @($pathText)
+}
+
+function Get-AutopilotBaselineDirtyPaths {
+    $statusOutput = & git status --porcelain 2>&1
+
+    if ($LASTEXITCODE -ne 0) {
+        throw "git status --porcelain failed while capturing autopilot baseline dirty paths: $($statusOutput -join "`n")"
+    }
+
+    return @(
+        $statusOutput |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            Where-Object { Test-HasValue $_ } |
+            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+            Select-Object -Unique
+    )
+}
+
+function Test-IsAutopilotBaselineDirtyPath {
+    param([string]$RelativePath)
+
+    $normalizedRelativePath = ConvertTo-NormalizedChangedPath $RelativePath
+    return @($script:autopilotBaselineDirtyPaths) -contains $normalizedRelativePath
+}
+
+function Initialize-AutopilotOperationalFileSnapshots {
+    $script:autopilotOperationalFileSnapshots = @{}
+
+    foreach ($relativePath in @($stateRelativePath, $loopLogRelativePath, $goalHistoryRelativePath)) {
+        $fullPath = [System.IO.Path]::GetFullPath((Join-Path $repoRoot $relativePath))
+
+        if (-not $fullPath.StartsWith($repoRoot.TrimEnd("\") + "\", [System.StringComparison]::OrdinalIgnoreCase)) {
+            continue
+        }
+
+        $exists = [System.IO.File]::Exists($fullPath)
+        $bytes = $null
+
+        if ($exists) {
+            $bytes = [System.IO.File]::ReadAllBytes($fullPath)
+        }
+
+        $script:autopilotOperationalFileSnapshots[$relativePath] = [PSCustomObject][ordered]@{
+            path = $fullPath
+            existed = $exists
+            bytes = $bytes
+        }
+    }
+}
+
+function Restore-AutopilotCurrentRunOperationalChanges {
+    param([string[]]$RelativePaths = @())
+
+    $restoredPaths = @()
+
+    if ($null -eq $script:autopilotOperationalFileSnapshots) {
+        return @($restoredPaths)
+    }
+
+    $targetPaths = @($RelativePaths | ForEach-Object { ConvertTo-NormalizedChangedPath $_ } | Where-Object { Test-HasValue $_ } | Select-Object -Unique)
+
+    foreach ($entry in @($script:autopilotOperationalFileSnapshots.GetEnumerator())) {
+        $relativePath = ConvertTo-NormalizedChangedPath ([string]$entry.Key)
+        $snapshot = $entry.Value
+
+        if ($targetPaths.Count -gt 0 -and $targetPaths -notcontains $relativePath) {
+            continue
+        }
+
+        if (Test-IsAutopilotBaselineDirtyPath $relativePath) {
+            continue
+        }
+
+        $fullPath = [string]$snapshot.path
+
+        if (-not $fullPath.StartsWith($repoRoot.TrimEnd("\") + "\", [System.StringComparison]::OrdinalIgnoreCase)) {
+            continue
+        }
+
+        try {
+            if ($snapshot.existed) {
+                [System.IO.File]::WriteAllBytes($fullPath, [byte[]]$snapshot.bytes)
+            } elseif ([System.IO.File]::Exists($fullPath)) {
+                [System.IO.File]::Delete($fullPath)
+            }
+            $restoredPaths += $relativePath
+        } catch {
+            Write-Warning "Failed to restore autopilot operational file snapshot: $fullPath"
+        }
+    }
+
+    return @($restoredPaths | Select-Object -Unique)
+}
+
+function Add-AutopilotExpectedNonWorkLogEntry {
+    param(
+        [string]$StoppedReason,
+        [string]$Message,
+        [int]$PreparedGoals
+    )
+
+    $resultMessage = if (Test-HasValue $Message) { $Message } else { "Autopilot stopped before implementation work." }
+
+    Add-LoopLogEntry "Autopilot expected non-work stop" @(
+        "- Reason: $StoppedReason",
+        "- Outcome category: expected_non_work",
+        "- Result: $resultMessage",
+        "- Prepared goals: $PreparedGoals/$MaxGoals",
+        "- Failure counter: not incremented",
+        "- Cleanup: restored current-run autopilot operational file snapshots before writing this meta log entry"
+    )
+}
+
 function Invoke-AutopilotLoopLogMetaCommit {
     param([int]$StepNumber)
 
@@ -263,7 +445,25 @@ function Invoke-AutopilotLoopLogMetaCommit {
         return New-StepResult $StepNumber "autopilot-meta-commit" $false $true 0 "AllowCommit is not set, so autopilot loop-log/history meta commit was not executed."
     }
 
-    $statusOutput = & git status --short -- $autopilotMetaCommitRelativePaths 2>&1 | Out-String
+    $skippedBaselinePaths = @(
+        @($loopLogRelativePath, $goalHistoryRelativePath) |
+            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+            Where-Object { Test-IsAutopilotBaselineDirtyPath $_ } |
+            Select-Object -Unique
+    )
+    $currentRunMetaPaths = @(
+        $loopLogRelativePath,
+        $goalHistoryRelativePath
+    ) |
+        ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+        Where-Object { -not (Test-IsAutopilotBaselineDirtyPath $_) } |
+        Select-Object -Unique
+
+    if ($currentRunMetaPaths.Count -eq 0) {
+        return New-StepResult $StepNumber "autopilot-meta-commit" $false $true 0 "Autopilot meta commit skipped because all meta files were baseline dirty and protected: $($skippedBaselinePaths -join ', ')"
+    }
+
+    $statusOutput = & git status --short -- $currentRunMetaPaths 2>&1 | Out-String
     $statusExitCode = $LASTEXITCODE
 
     if ($statusExitCode -ne 0) {
@@ -271,25 +471,33 @@ function Invoke-AutopilotLoopLogMetaCommit {
     }
 
     if (-not (Test-HasValue $statusOutput)) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 0 "Autopilot meta files had no changes to commit."
+        $message = "Autopilot meta files had no changes to commit."
+        if ($skippedBaselinePaths.Count -gt 0) {
+            $message = "$message Baseline dirty files skipped: $($skippedBaselinePaths -join ', ')"
+        }
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 0 $message
     }
 
-    $addOutput = & git add -- $autopilotMetaCommitRelativePaths 2>&1 | Out-String
+    $addOutput = & git add -- $currentRunMetaPaths 2>&1 | Out-String
     $addExitCode = $LASTEXITCODE
 
     if ($addExitCode -ne 0) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot meta files git add failed. exit code: $addExitCode`n$addOutput"
+        & git restore --staged -- $currentRunMetaPaths 2>&1 | Out-String | Out-Null
+        $restoredPaths = @(Restore-AutopilotCurrentRunOperationalChanges $currentRunMetaPaths)
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot meta files git add failed. exit code: $addExitCode`n$addOutput`nRestored run-owned files: $($restoredPaths -join ', ')"
     }
 
     $metaCommitMessage = "chore(ai-dev): record autopilot progress"
-    $commitOutput = & git commit -m $metaCommitMessage -- $autopilotMetaCommitRelativePaths 2>&1 | Out-String
+    $commitOutput = & git commit -m $metaCommitMessage -- $currentRunMetaPaths 2>&1 | Out-String
     $commitExitCode = $LASTEXITCODE
 
     if ($commitExitCode -ne 0) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot meta commit failed. exit code: $commitExitCode`n$commitOutput"
+        & git restore --staged -- $currentRunMetaPaths 2>&1 | Out-String | Out-Null
+        $restoredPaths = @(Restore-AutopilotCurrentRunOperationalChanges $currentRunMetaPaths)
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot meta commit failed. exit code: $commitExitCode`n$commitOutput`nRestored run-owned files: $($restoredPaths -join ', ')"
     }
 
-    $remainingStatus = & git status --short -- $autopilotMetaCommitRelativePaths 2>&1 | Out-String
+    $remainingStatus = & git status --short -- $currentRunMetaPaths 2>&1 | Out-String
     $remainingStatusExitCode = $LASTEXITCODE
 
     if ($remainingStatusExitCode -ne 0) {
@@ -300,7 +508,7 @@ function Invoke-AutopilotLoopLogMetaCommit {
         return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot meta clean verification failed: git status --short still reports meta changes after the autopilot meta commit.`n$remainingStatus"
     }
 
-    $message = ($commitOutput.Trim(), "Autopilot meta clean verification: git status --short returned no autopilot meta changes.") -join "`n"
+    $message = ($commitOutput.Trim(), "Baseline dirty files skipped: $($skippedBaselinePaths -join ', ')", "Autopilot meta clean verification: git status --short returned no autopilot meta changes.") -join "`n"
     return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 0 $message
 }
 
@@ -365,16 +573,31 @@ function New-AutopilotResult {
         [string]$StoppedReason,
         [bool]$Completed,
         [int]$ExitCode,
-        [int]$PreparedGoals
+        [int]$PreparedGoals,
+        [bool]$OperationalCleanupPerformed = $false,
+        [bool]$MetaCommitCreated = $false,
+        [bool]$NextRunWithoutManualRestore = $false
     )
 
+    $outcomeCategory = if (Test-IsExpectedAutopilotNonWorkStop $StoppedReason) {
+        "expected_non_work"
+    } elseif ($ExitCode -eq 0) {
+        "success"
+    } else {
+        "actual_failure"
+    }
+
     return [PSCustomObject][ordered]@{
         steps = @($Steps)
         stoppedReason = $StoppedReason
+        outcomeCategory = $outcomeCategory
         completed = $Completed
         exitCode = $ExitCode
         maxGoals = $MaxGoals
         preparedGoals = $PreparedGoals
+        operationalCleanupPerformed = $OperationalCleanupPerformed
+        metaCommitCreated = $MetaCommitCreated
+        nextRunWithoutManualRestore = $NextRunWithoutManualRestore
     }
 }
 
@@ -399,6 +622,10 @@ function Write-AutopilotResult {
     }
 
     Write-Host "Stopped reason: $($Result.stoppedReason)"
+    Write-Host "Outcome category: $($Result.outcomeCategory)"
+    Write-Host "Operational cleanup performed: $($Result.operationalCleanupPerformed)"
+    Write-Host "Meta commit created: $($Result.metaCommitCreated)"
+    Write-Host "Next run without manual restore: $($Result.nextRunWithoutManualRestore)"
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Prepared goals: $($Result.preparedGoals)/$($Result.maxGoals)"
     Write-Host "Exit code: $($Result.exitCode)"
@@ -414,7 +641,12 @@ function Stop-Autopilot {
         [string]$FailureMessage = ""
     )
 
-    if ($ExitCode -ne 0 -and (Test-HasValue $FailureMessage)) {
+    $isExpectedNonWorkStop = Test-IsExpectedAutopilotNonWorkStop $StoppedReason
+    $operationalCleanupPerformed = $false
+    $metaCommitCreated = $false
+    $nextRunWithoutManualRestore = ($ExitCode -eq 0)
+
+    if ($ExitCode -ne 0 -and (Test-HasValue $FailureMessage) -and -not $isExpectedNonWorkStop) {
         Save-AutopilotFailureState $StoppedReason $FailureMessage
         Add-LoopLogEntry "Autopilot stopped" @(
             "- Reason: $StoppedReason",
@@ -423,7 +655,42 @@ function Stop-Autopilot {
         )
     }
 
-    $result = New-AutopilotResult $Steps $StoppedReason $Completed $ExitCode $PreparedGoals
+    if ($ExitCode -ne 0 -and $isExpectedNonWorkStop -and -not $DryRun) {
+        $cleanedRunOwnedPaths = @(Restore-AutopilotCurrentRunOperationalChanges)
+        $operationalCleanupPerformed = $true
+        $metaCommitMessage = "skipped (-AllowCommit not set)"
+        $nextRunWithoutManualRestore = $true
+        $skippedBaselineMetaPaths = @(
+            @($loopLogRelativePath, $goalHistoryRelativePath) |
+                ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+                Where-Object { Test-IsAutopilotBaselineDirtyPath $_ } |
+                Select-Object -Unique
+        )
+
+        if ($AllowCommit) {
+            Add-AutopilotExpectedNonWorkLogEntry $StoppedReason $FailureMessage $PreparedGoals
+            $metaCommitStep = Invoke-AutopilotLoopLogMetaCommit ($Steps.Count + 1)
+            $metaCommitCreated = ($metaCommitStep.exitCode -eq 0 -and $metaCommitStep.executed -and -not $metaCommitStep.skipped -and $metaCommitStep.message -notmatch 'had no changes to commit')
+            $metaCommitMessage = if ($metaCommitCreated) { "created" } else { "not created: $($metaCommitStep.message)" }
+
+            if ($metaCommitStep.exitCode -ne 0) {
+                $cleanedRunOwnedPaths = @(Restore-AutopilotCurrentRunOperationalChanges)
+                $operationalCleanupPerformed = $true
+                $nextRunWithoutManualRestore = $true
+                $Steps += $metaCommitStep
+                $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-cleanup" $true $false 0 "Classification: expected_non_work. Original stopped reason: $StoppedReason. Baseline dirty files skipped: $($skippedBaselineMetaPaths -join ', '). Cleaned run-owned files: $($cleanedRunOwnedPaths -join ', '). Meta commit created: false. Next run without manual git restore: $nextRunWithoutManualRestore."
+                $result = New-AutopilotResult $Steps "autopilot_expected_non_work_meta_commit_failed" $false 1 $PreparedGoals $operationalCleanupPerformed $false $nextRunWithoutManualRestore
+                Write-AutopilotResult $result
+                exit 1
+            }
+
+            $Steps += $metaCommitStep
+        }
+
+        $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-cleanup" $true $false 0 "Classification: expected_non_work. Original stopped reason: $StoppedReason. Baseline dirty files skipped: $($skippedBaselineMetaPaths -join ', '). Cleaned run-owned files: $($cleanedRunOwnedPaths -join ', '). Meta commit created: $metaCommitCreated ($metaCommitMessage). Next run without manual git restore: $nextRunWithoutManualRestore. Restored only autopilot operational files captured at run start; baseline user changes were preserved."
+    }
+
+    $result = New-AutopilotResult $Steps $StoppedReason $Completed $ExitCode $PreparedGoals $operationalCleanupPerformed $metaCommitCreated $nextRunWithoutManualRestore
     Write-AutopilotResult $result
     exit $ExitCode
 }
@@ -842,6 +1109,8 @@ function Invoke-AutoGoal {
 }
 
 Set-Location $repoRoot
+$script:autopilotBaselineDirtyPaths = @(Get-AutopilotBaselineDirtyPaths)
+Initialize-AutopilotOperationalFileSnapshots
 
 $steps = @()
 $preparedGoals = 0
@@ -970,13 +1239,15 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
     $steps += $autoGoalStep
 
     if ($autoGoalStep.exitCode -ne 0) {
+        $childStoppedReason = Get-StoppedReasonFromOutput $autoGoalStep.message
+        $stoppedReason = if (Test-IsExpectedAutopilotNonWorkStop $childStoppedReason) { $childStoppedReason } else { "auto_goal_failed" }
         $failureMessage = "Auto-goal failed with exit code $($autoGoalStep.exitCode): $($autoGoalStep.message)"
 
         if (Test-HasValue $candidate.fallbackReason) {
             $failureMessage = "$failureMessage Fallback context: $($candidate.fallbackReason)"
         }
 
-        Stop-Autopilot $steps "auto_goal_failed" $false 1 $preparedGoals $failureMessage
+        Stop-Autopilot $steps $stoppedReason $false 1 $preparedGoals $failureMessage
     }
 
     $preparedGoals++
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