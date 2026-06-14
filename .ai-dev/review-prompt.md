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

AI Dev Loop의 auto-goal 실행 경로에서 Codex 리뷰가 pass 된 뒤 후속 완료 흐름이 자동으로 이어지도록 개선한다.

## 배경

이미 별도 자동 사이클 스크립트에는 리뷰 pass 이후 구현 변경 커밋, complete-task 호출, 메타 정보 반영 흐름이 포함되어 있다. 현재 목표는 그 흐름을 실제 auto-goal 실행 경로에도 연결해 수동 개입을 줄이는 것이다.

## 성공 기준

- auto-goal 실행 중 Codex 리뷰 결과가 pass이면 구현 변경 커밋 단계가 자동으로 진행된다.
- 생성된 커밋 해시가 complete-task 호출에 전달된다.
- complete-task 이후 .ai-dev 메타 변경 반영 단계가 자동으로 이어진다.
- 모든 단계가 끝난 뒤 작업 상태 확인이 수행되고 결과가 로그로 남는다.
- 기존 실패 처리와 중단 조건은 유지된다.

## 제약사항

- 기존 ai-dev-auto-cycle-full.ps1에 있는 검증된 흐름을 우선 재사용한다.
- 변경 범위는 auto-goal 실행 경로 연결에 한정한다.
- PowerShell 5.1 호환성을 유지한다.
- 사용자 데이터 저장 구조는 변경하지 않는다.
- 불필요한 대규모 구조 변경은 하지 않는다.

## 범위 제외

- 새로운 UI 추가는 제외한다.
- 데이터베이스 스키마 변경은 제외한다.
- 알림 기능 추가는 제외한다.
- 외부 연동 기능 추가는 제외한다.

## 수동 검증

- pass 결과를 반환하는 리뷰 흐름에서 auto-goal을 실행해 후속 단계가 순서대로 진행되는지 확인한다.
- complete-task에 커밋 해시가 전달되는지 로그로 확인한다.
- 마지막 상태 확인 로그가 남는지 확인한다.

## Current Task

- Task ID: T001
- Title: auto-goal pass 이후 완료 흐름 연결
- Description: Codex 리뷰 pass 이후 실제 auto-goal 실행 경로에서 구현 변경 커밋, complete-task 커밋 해시 전달, .ai-dev 메타 반영, 최종 상태 확인이 순서대로 이어지도록 기존 자동 사이클 흐름을 연결한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- pass 리뷰 결과를 기준으로 후속 단계가 자동 실행되는지 확인한다.
- complete-task 호출에 커밋 해시가 포함되는지 확인한다.
- 완료 후 상태 확인 로그가 출력되는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-06-14 22:26:39

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
dist/index.html                   0.46 kB │ gzip:  0.30 kB
dist/assets/index-DvjxWt30.css    5.69 kB │ gzip:  1.93 kB
dist/assets/index-Ct_unKMl.js   316.48 kB │ gzip: 99.86 kB

[32m✓ built in 180ms[39m
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