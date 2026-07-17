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
Autopilot durable history 기록 이후 nested auto-goal dirty-worktree-gate가 `.ai-dev/autopilot-goal-history.json` 때문에 중단되는 문제를 수정한다.

## 배경
현재 Autopilot 연속 실행 중 selected/prepared/completed durable history가 기록된 직후 nested `ai-dev-auto-goal.ps1` 호출에서 작업 트리가 dirty로 판단되어 `auto_goal_failed`로 중단된다. 특히 `.ai-dev/autopilot-goal-history.json`이 새로 생성되거나 변경된 상태가 dirty gate에 걸린다.

## 성공 기준
- Autopilot이 durable history를 기록해도 nested auto-goal dirty gate가 자기 자신의 history 파일만으로 실패하지 않는다.
- `AllowRun + AllowCommit` 경로에서 history/loop-log가 필요한 시점에 안전하게 meta commit되거나 nested auto-goal 호출 전 작업 트리가 깨끗하게 유지된다.
- DryRun에서는 파일 변경이 발생하지 않는다.
- durable history 중복 방지 기능이 유지된다.
- `.ai-dev/autopilot-goal-history.json`이 장기 추적 대상이면 자동화 commit 대상에 포함된다.
- 실제 Autopilot 연속 실행 명령이 최소 1개 goal을 준비/실행 단계로 넘길 수 있다.
- 앱 `src` 파일은 수정하지 않는다.
- build/lint 검증을 통과한다.

## 제약사항
- 변경은 Autopilot/auto-goal 스크립트와 `.ai-dev` 자동화 상태 파일 범위로 제한한다.
- 기존 durable history 중복 방지 로직을 제거하지 않는다.
- DryRun 경로는 어떤 파일도 쓰지 않도록 유지한다.
- 앱 UI와 `src` 파일은 변경하지 않는다.

## 범위 제외
- 앱 기능 변경
- 대규모 스크립트 재작성
- 저장소 구조 변경
- 알림 또는 외부 연동 추가

## 수동 검증
- DryRun 실행 후 파일 변경이 없는지 확인한다.
- `AllowRun + AllowCommit` Autopilot 연속 실행이 최소 1개 goal을 준비/실행 단계로 넘기는지 확인한다.
- build와 lint를 실행해 통과 여부를 확인한다.

## Current Task

- Task ID: T001
- Title: Autopilot history dirty gate 흐름 수정
- Description: Autopilot durable history 기록 후 nested auto-goal 호출 전에 history/loop-log 변경이 dirty gate에 걸리지 않도록 작은 범위로 수정하고, DryRun 무변경 및 history 중복 방지 동작을 유지한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- DryRun 실행 후 파일 변경이 발생하지 않는지 확인
- AllowRun + AllowCommit Autopilot 연속 실행이 최소 1개 goal을 준비/실행 단계로 넘기는지 확인
- durable history 중복 방지 동작이 유지되는지 확인
- npm run build 실행
- npm run lint 실행

## Test Result

# AI Dev Test Result

## 2026-07-17 18:09:30

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

[32m✓ built in 188ms[39m
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

2026-07-17 18:09:37

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
 M scripts/ai-dev-autopilot.ps1
```

## App Change Files

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
 scripts/ai-dev-autopilot.ps1 | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-autopilot.ps1 b/scripts/ai-dev-autopilot.ps1
index 1468b7b..0f94f17 100644
--- a/scripts/ai-dev-autopilot.ps1
+++ b/scripts/ai-dev-autopilot.ps1
@@ -21,6 +21,16 @@ $stateRelativePath = ".ai-dev/state.json"
 $backlogRelativePath = ".ai-dev/backlog.md"
 $loopLogRelativePath = ".ai-dev/loop-log.md"
 $goalHistoryRelativePath = ".ai-dev/autopilot-goal-history.json"
+$autopilotMetaCommitRelativePaths = @(
+    ".ai-dev/codex-result.md",
+    ".ai-dev/current-task-prompt.md",
+    ".ai-dev/goal.md",
+    ".ai-dev/queue.json",
+    ".ai-dev/state.json",
+    ".ai-dev/test-result.md",
+    $loopLogRelativePath,
+    $goalHistoryRelativePath
+)
 $goalPath = Join-Path $repoRoot $goalRelativePath
 $queuePath = Join-Path $repoRoot $queueRelativePath
 $statePath = Join-Path $repoRoot $stateRelativePath
@@ -253,44 +263,44 @@ function Invoke-AutopilotLoopLogMetaCommit {
         return New-StepResult $StepNumber "autopilot-meta-commit" $false $true 0 "AllowCommit is not set, so autopilot loop-log/history meta commit was not executed."
     }
 
-    $statusOutput = & git status --short -- $loopLogRelativePath $goalHistoryRelativePath 2>&1 | Out-String
+    $statusOutput = & git status --short -- $autopilotMetaCommitRelativePaths 2>&1 | Out-String
     $statusExitCode = $LASTEXITCODE
 
     if ($statusExitCode -ne 0) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "git status for autopilot loop-log/history failed. exit code: $statusExitCode`n$statusOutput"
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "git status for autopilot meta files failed. exit code: $statusExitCode`n$statusOutput"
     }
 
     if (-not (Test-HasValue $statusOutput)) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 0 "Autopilot loop-log/history had no changes to commit."
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 0 "Autopilot meta files had no changes to commit."
     }
 
-    $addOutput = & git add -- $loopLogRelativePath $goalHistoryRelativePath 2>&1 | Out-String
+    $addOutput = & git add -- $autopilotMetaCommitRelativePaths 2>&1 | Out-String
     $addExitCode = $LASTEXITCODE
 
     if ($addExitCode -ne 0) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot loop-log/history git add failed. exit code: $addExitCode`n$addOutput"
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot meta files git add failed. exit code: $addExitCode`n$addOutput"
     }
 
     $metaCommitMessage = "chore(ai-dev): record autopilot progress"
-    $commitOutput = & git commit -m $metaCommitMessage -- $loopLogRelativePath $goalHistoryRelativePath 2>&1 | Out-String
+    $commitOutput = & git commit -m $metaCommitMessage -- $autopilotMetaCommitRelativePaths 2>&1 | Out-String
     $commitExitCode = $LASTEXITCODE
 
     if ($commitExitCode -ne 0) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot loop-log/history meta commit failed. exit code: $commitExitCode`n$commitOutput"
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot meta commit failed. exit code: $commitExitCode`n$commitOutput"
     }
 
-    $remainingStatus = & git status --short 2>&1 | Out-String
+    $remainingStatus = & git status --short -- $autopilotMetaCommitRelativePaths 2>&1 | Out-String
     $remainingStatusExitCode = $LASTEXITCODE
 
     if ($remainingStatusExitCode -ne 0) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot final clean verification failed because git status failed. exit code: $remainingStatusExitCode`n$remainingStatus"
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot meta clean verification failed because git status failed. exit code: $remainingStatusExitCode`n$remainingStatus"
     }
 
     if (Test-HasValue $remainingStatus) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot final clean verification failed: git status --short still reports changes after the loop-log meta commit.`n$remainingStatus"
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot meta clean verification failed: git status --short still reports meta changes after the autopilot meta commit.`n$remainingStatus"
     }
 
-    $message = ($commitOutput.Trim(), "Autopilot final clean verification: git status --short returned no changes.") -join "`n"
+    $message = ($commitOutput.Trim(), "Autopilot meta clean verification: git status --short returned no autopilot meta changes.") -join "`n"
     return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 0 $message
 }
 
@@ -937,6 +947,15 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
 
     $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $false 0 $candidateMessage $candidate
 
+    if ($AllowCommit) {
+        $metaCommitStep = Invoke-AutopilotLoopLogMetaCommit ($steps.Count + 1)
+        $steps += $metaCommitStep
+
+        if ($metaCommitStep.exitCode -ne 0) {
+            Stop-Autopilot $steps "autopilot_meta_commit_failed" $false 1 $preparedGoals $metaCommitStep.message
+        }
+    }
+
     try {
         $autoGoalStep = Invoke-AutoGoal $candidate ($steps.Count + 1)
     } catch {
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