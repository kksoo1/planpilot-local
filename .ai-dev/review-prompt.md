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

AI Dev Loop Autopilot이 이미 준비했거나 완료한 backlog goal title을 다음 실행에서 다시 선택하지 않도록 개선한다.

## 배경

현재 `scripts/ai-dev-autopilot.ps1`은 현재 goal, 직전 goal, 현재 프로세스의 `usedTitles`만 제외한다. 이 때문에 이전 Autopilot 실행에서 이미 완료한 backlog 항목이 이후 실행에서 다시 후보로 선택될 수 있다.

## 성공 기준

- Autopilot은 과거 prepared 로그, 완료된 queue/goal 상태, 또는 별도 history 파일을 기준으로 이미 준비했거나 완료한 goal title을 후보에서 제외한다.
- 중복 후보를 제외한 뒤 남은 후보가 없으면 중단 사유와 제외된 title 목록을 state, loop-log, 출력 중 적절한 위치에 남긴다.
- 정상 한국어 backlog title은 계속 후보로 허용된다.
- 기존 mojibake fallback 로직은 유지된다.
- DryRun 실행에서는 파일을 수정하지 않는다.
- AllowCommit이 있는 성공 실행은 작업 종료 상태를 명확히 검증할 수 있다.

## 제약사항

- 앱 `src` 파일은 수정하지 않는다.
- 변경 범위는 Autopilot 스크립트와 AI Dev Loop 상태 파일에 한정한다.
- 기존 backlog 선택 흐름과 fallback 동작을 불필요하게 재작성하지 않는다.
- 한 번에 하나의 작은 구현 단위로 진행한다.

## 범위 제외

- 앱 UI 변경은 하지 않는다.
- IndexedDB schema 변경은 하지 않는다.
- 새로운 외부 의존성은 추가하지 않는다.
- 알림, 계정, 원격 동기화 기능은 다루지 않는다.

## 수동 검증

- 과거 완료 title이 있는 상태에서 Autopilot 후보 선택을 실행해 해당 title이 제외되는지 확인한다.
- 제외 후 후보가 없을 때 중단 사유와 제외 title 목록이 남는지 확인한다.
- DryRun에서 상태 파일이 변경되지 않는지 확인한다.
- 한국어 backlog title과 mojibake fallback 처리가 기존처럼 동작하는지 확인한다.


## Current Task

- Task ID: T001
- Title: 완료된 Autopilot goal 제외 처리 구현
- Description: Autopilot backlog 후보 선택 시 과거에 준비했거나 완료한 goal title을 수집해 중복 후보를 제외하고, 남은 후보가 없을 때 읽을 수 있는 중단 사유와 제외 목록을 기록한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- DryRun에서 파일 변경이 발생하지 않는지 확인한다.
- 이전 완료 title이 후보에서 제외되는지 확인한다.
- 모든 후보가 제외된 경우 중단 사유와 제외 title 목록이 기록되는지 확인한다.
- 정상 한국어 backlog title과 기존 mojibake fallback 동작이 유지되는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-12 22:55:13

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

[32m✓ built in 234ms[39m
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

2026-07-12 22:55:22

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
 scripts/ai-dev-autopilot.ps1 | 133 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 125 insertions(+), 8 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-autopilot.ps1 b/scripts/ai-dev-autopilot.ps1
index 47d8acc..20d4d35 100644
--- a/scripts/ai-dev-autopilot.ps1
+++ b/scripts/ai-dev-autopilot.ps1
@@ -502,6 +502,117 @@ function Get-BacklogCandidates {
     return @($fallbackCandidate)
 }
 
+function Add-UniqueTitle {
+    param(
+        [string[]]$Titles,
+        [string]$Title
+    )
+
+    if (-not (Test-HasValue $Title)) {
+        return @($Titles)
+    }
+
+    $trimmedTitle = $Title.Trim()
+
+    if ($Titles -contains $trimmedTitle) {
+        return @($Titles)
+    }
+
+    return @($Titles + $trimmedTitle)
+}
+
+function Get-PreparedGoalTitlesFromLoopLog {
+    if (-not (Test-Path -LiteralPath $loopLogPath -PathType Leaf)) {
+        return @()
+    }
+
+    $titles = @()
+    $isAutopilotPreparedEntry = $false
+    $lines = @(Get-Content -Encoding UTF8 -LiteralPath $loopLogPath)
+
+    foreach ($line in $lines) {
+        if ($line -match '^##\s+.+\s+-\s+(.+)$') {
+            $isAutopilotPreparedEntry = ($Matches[1].Trim() -eq "Autopilot goal prepared")
+            continue
+        }
+
+        if (-not $isAutopilotPreparedEntry) {
+            continue
+        }
+
+        if ($line -match '^\s*-\s+Goal:\s+(.+)$') {
+            $titles = @(Add-UniqueTitle $titles $Matches[1])
+        }
+    }
+
+    return @($titles)
+}
+
+function Get-CompletedCurrentGoalTitleFromQueueState {
+    $queue = Read-JsonFile $queuePath $queueRelativePath
+    $state = Read-JsonFile $statePath $stateRelativePath
+    $goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { "" }
+
+    if ($goalStatus -ne "completed") {
+        return @()
+    }
+
+    if (-not (Test-HasValue $queue.goalTitle)) {
+        return @()
+    }
+
+    return @([string]$queue.goalTitle)
+}
+
+function Get-HistoricalGoalTitles {
+    $titles = @()
+
+    foreach ($title in @(Get-PreparedGoalTitlesFromLoopLog)) {
+        $titles = @(Add-UniqueTitle $titles $title)
+    }
+
+    foreach ($title in @(Get-CompletedCurrentGoalTitleFromQueueState)) {
+        $titles = @(Add-UniqueTitle $titles $title)
+    }
+
+    return @($titles)
+}
+
+function Get-ExcludedGoalTitles {
+    param(
+        [string[]]$UsedTitles,
+        [object]$Gate
+    )
+
+    $titles = @()
+
+    foreach ($title in @($UsedTitles)) {
+        $titles = @(Add-UniqueTitle $titles $title)
+    }
+
+    if ($null -ne $Gate -and (Test-HasValue $Gate.goalTitle)) {
+        $titles = @(Add-UniqueTitle $titles ([string]$Gate.goalTitle))
+    }
+
+    foreach ($title in @(Get-HistoricalGoalTitles)) {
+        $titles = @(Add-UniqueTitle $titles $title)
+    }
+
+    return @($titles)
+}
+
+function Format-ExcludedGoalTitles {
+    param([string[]]$Titles)
+
+    $filteredTitles = @($Titles | Where-Object { Test-HasValue $_ } | Select-Object -Unique)
+
+    if ($filteredTitles.Count -eq 0) {
+        return "none"
+    }
+
+    return ($filteredTitles -join "; ")
+}
+
 function Invoke-AutoGoal {
     param(
         [object]$Candidate,
@@ -621,13 +732,9 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
     $steps += New-StepResult ($steps.Count + 1) "current-goal-gate" $false $false 0 "Current goal is completed. Previous goal: $($gate.goalTitle)"
 
     try {
-        $excludedTitles = @($usedTitles)
-
-        if (Test-HasValue $gate.goalTitle) {
-            $excludedTitles += [string]$gate.goalTitle
-        }
-
-        $candidates = @(Get-BacklogCandidates | Where-Object { $excludedTitles -notcontains ([string]$_.title) })
+        $excludedTitles = @(Get-ExcludedGoalTitles $usedTitles $gate)
+        $allCandidates = @(Get-BacklogCandidates)
+        $candidates = @($allCandidates | Where-Object { $excludedTitles -notcontains ([string]$_.title) })
     } catch {
         $message = $_.Exception.Message
         $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $false 1 $message
@@ -635,7 +742,17 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
     }
 
     if ($candidates.Count -eq 0) {
-        $message = "No actionable next goal candidate was found in the backlog after excluding the current or already prepared goal titles. Check backlog encoding, empty items, completed or deferred sections, and duplicate backlog titles."
+        $excludedTitleSummary = Format-ExcludedGoalTitles $excludedTitles
+        $candidateTitles = @($allCandidates | ForEach-Object { [string]$_.title } | Where-Object { Test-HasValue $_ } | Select-Object -Unique)
+        $candidateTitleSummary = Format-ExcludedGoalTitles $candidateTitles
+
+        if ($allCandidates.Count -gt 0) {
+            $message = "All backlog goal candidates were already completed or prepared, so autopilot will not create a duplicate goal. Excluded goal titles: $excludedTitleSummary. Candidate goal titles: $candidateTitleSummary."
+            $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $true 1 $message
+            Stop-Autopilot $steps "all_goal_candidates_excluded" $false 1 $preparedGoals $message
+        }
+
+        $message = "No actionable next goal candidate was found in the backlog after excluding current, prepared, or completed goal titles. Excluded goal titles: $excludedTitleSummary. Check backlog encoding, empty items, completed or deferred sections, and duplicate backlog titles."
         $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $true 1 $message
         Stop-Autopilot $steps "goal_candidate_not_found" $false 1 $preparedGoals $message
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