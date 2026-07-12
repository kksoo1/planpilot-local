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

AI Dev Loop Autopilot에 durable goal history를 도입해 이미 선택되었거나 처리된 goal title이 다음 실행에서 다시 후보로 선택되지 않도록 한다.

## 배경

현재 Autopilot은 과거 prepared 로그와 현재 queue/state의 completed goalTitle만 제외하기 때문에, 실패 후 수동 완료된 backlog goal이나 prepared 로그에 남지 않은 goal이 다음 실행에서 다시 선택될 수 있다. 실제로 수동 완료한 backlog goal이 다음 Autopilot 실행에서 다시 선택된 사례가 있었다.

## 성공 기준

- `scripts/ai-dev-autopilot.ps1`에서 Autopilot이 선택/준비/완료한 goal title을 durable history로 보존한다.
- history에 저장된 정상적인 한국어 goal title이 깨지지 않는다.
- 기존 prepared 로그 기반 제외와 현재 completed queue/state goalTitle 제외는 유지한다.
- task title을 goal title로 잘못 취급하지 않는다.
- auto-goal 실패 후 해당 goal이 수동 완료되어도 다음 실행에서 같은 goal title이 다시 선택되지 않는다.
- DryRun 실행은 history, state, loop-log 등 어떤 파일도 수정하지 않는다.
- 모든 후보가 history 때문에 제외되면 `all_goal_candidates_excluded`로 중단하고 제외 title 목록과 후보 title 목록을 state, loop-log, output에 남긴다.
- 앱 `src` 파일은 수정하지 않는다.
- AllowCommit이 있는 성공 실행은 최종 작업 트리가 깨끗한 상태로 끝난다.

## 제약사항

- 변경 범위는 Autopilot 스크립트와 AI Dev Loop 상태/기록 파일 처리에 한정한다.
- 한국어 goal title 보존을 위해 파일 인코딩과 JSON 직렬화 방식을 안전하게 유지한다.
- 기존 로그 기반 제외 로직과 현재 완료 goal 제외 로직을 제거하지 않는다.
- DryRun 경로에서는 파일 쓰기 동작을 추가하지 않는다.

## 범위 제외

- 앱 화면, React 컴포넌트, Zustand 상태, Dexie 저장 구조 변경은 제외한다.
- 알림, 동기화, 인증 같은 제품 기능 추가는 제외한다.
- Autopilot 외 다른 개발 루프 정책의 대규모 재작성은 제외한다.

## 수동 검증

- history가 없는 상태에서 새 goal을 선택하면 durable history에 goal title이 기록되는지 확인한다.
- auto-goal 실패 후 같은 title이 다음 실행 후보에서 제외되는지 확인한다.
- DryRun 실행 전후 관련 파일의 변경이 없는지 확인한다.
- 모든 후보가 history로 제외되는 경우 state, loop-log, output에 후보 title과 제외 title이 남는지 확인한다.
- 한국어 goal title이 history 파일에서 깨지지 않는지 확인한다.

## Current Task

- Task ID: T001
- Title: Autopilot durable history 구현
- Description: Autopilot이 선택하거나 준비한 goal title을 별도 durable history에 기록하고, 다음 후보 선택 시 기존 제외 로직과 함께 history 기반 제외를 적용한다. DryRun에서는 어떤 기록 파일도 수정하지 않도록 분기한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- 한국어 goal title이 history에 보존되는지 확인한다.
- history에 있는 goal title이 다음 후보 선택에서 제외되는지 확인한다.
- DryRun 실행 전후 history, state, loop-log 파일이 변경되지 않는지 확인한다.
- task title이 goal title 제외 목록에 섞이지 않는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-12 23:59:04

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

[32m✓ built in 273ms[39m
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
## 2026-07-13 00:10:00 - Durable autopilot goal history targeted verification

- Overall result: passed
- Current task: T001 Autopilot durable history 구현
- Scope:
  - scripts/ai-dev-autopilot.ps1
  - .ai-dev/test-result.md

### Durable history behavior

- History file path: passed
  - The script defines `.ai-dev/autopilot-goal-history.json` as the durable Autopilot goal history file.

- History creation and recording: passed
  - `New-EmptyGoalHistory`, `Read-AutopilotGoalHistory`, `Get-AutopilotGoalHistoryTitles`, and `Add-AutopilotGoalHistoryTitle` are implemented.
  - Goal titles are recorded with `title`, `firstSeenAt`, `lastSeenAt`, `lastEvent`, and `events`.

- History event coverage: passed
  - The current completed gate goal is recorded with event `completed`.
  - The selected backlog candidate is recorded with event `selected`.
  - The prepared Autopilot goal is recorded with event `prepared`.

- History-based candidate exclusion: passed
  - `Get-HistoricalGoalTitles` includes titles from `Get-AutopilotGoalHistoryTitles`.
  - `Get-ExcludedGoalTitles` uses historical titles when filtering backlog candidates.

- All-candidates-excluded reporting: passed
  - When all backlog candidates are excluded, the message includes:
    - `Excluded goal titles:`
    - `Candidate goal titles:`
    - `Durable history goal titles:`
  - The stop reason remains `all_goal_candidates_excluded`.

### Safety checks

- DryRun non-mutating behavior: passed by code inspection
  - `Add-AutopilotGoalHistoryTitle` returns immediately when `$DryRun` is set.
  - `Add-LoopLogEntry`, `Save-AutopilotFailureState`, and `Invoke-AutopilotLoopLogMetaCommit` keep DryRun write guards.
  - Therefore DryRun does not write history, state, or loop-log.

- Korean goal title preservation: passed by code inspection
  - Goal titles are stored as trimmed strings without encoding conversion or romanization.
  - Normal Korean backlog titles remain valid candidates unless already recorded in history.

- Task title not mixed into goal history: passed by code inspection
  - The durable history path records `[string]$gate.goalTitle` and `[string]$candidate.title`.
  - `Task completed` / `- Task:` log entries are not parsed as durable goal history sources.

- Existing fallback/mojibake handling: passed by code inspection
  - Backlog parsing, suspicious title detection, and fallback candidate creation logic were not changed.

### Build, test, lint

- npm run build: passed in the current BuildOnly verification.
- npm run lint: passed in the current BuildOnly verification.
- npm run test: skipped because package.json has no test script.

## 2026-07-13 00:30:00 - Durable autopilot goal history executed verification

- Overall result: passed
- Current task: T001 Autopilot durable history 구현
- Mode: PowerShell targeted verification using actual functions extracted from scripts/ai-dev-autopilot.ps1

### Executed checks

- History creation and recording: passed
  - Executed Add-AutopilotGoalHistoryTitle against a temporary history file.
  - Verified JSON contains title, firstSeenAt, lastSeenAt, lastEvent, and events fields.
  - Verified selected, prepared, and completed events can be recorded.
  - Verified repeated updates accumulate events without PSObject op_Addition failure.

- History-based candidate exclusion: passed
  - Executed Get-ExcludedGoalTitles against temporary queue/state/loop-log/history files.
  - Verified durable history title is included in excluded titles.
  - Verified Autopilot goal prepared / - Goal value is included in excluded titles.
  - Verified completed queue/state goalTitle is included in excluded titles.

- DryRun non-mutating behavior: passed
  - Executed Add-AutopilotGoalHistoryTitle with DryRun enabled.
  - Verified SHA256 before/after history file hash remained unchanged.
  - Verified DryRun-only title was not recorded.

- Korean goal title preservation: passed
  - Verified Korean goal title 한국어 goal 보존 검증 round-trips through durable history JSON and Get-AutopilotGoalHistoryTitles.

- Task title not mixed into goal history: passed
  - Temporary loop-log included Task completed / - Task: task title should not mix.
  - Verified that value was not included in excluded goal titles.

- All-candidates-excluded reporting support: passed
  - Verified script contains all_goal_candidates_excluded stop reason.
  - Verified script reports Durable history goal titles in the all-candidates-excluded message.

### Build, test, lint

- npm run build: passed in the current BuildOnly verification.
- npm run lint: passed in the current BuildOnly verification.
- npm run test: skipped because package.json has no test script.


## Diff To Review

# AI Dev Diff

## Generated At

2026-07-13 00:26:46

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
 scripts/ai-dev-autopilot.ps1 | 200 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 189 insertions(+), 11 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-autopilot.ps1 b/scripts/ai-dev-autopilot.ps1
index 20d4d35..1468b7b 100644
--- a/scripts/ai-dev-autopilot.ps1
+++ b/scripts/ai-dev-autopilot.ps1
@@ -20,11 +20,13 @@ $queueRelativePath = ".ai-dev/queue.json"
 $stateRelativePath = ".ai-dev/state.json"
 $backlogRelativePath = ".ai-dev/backlog.md"
 $loopLogRelativePath = ".ai-dev/loop-log.md"
+$goalHistoryRelativePath = ".ai-dev/autopilot-goal-history.json"
 $goalPath = Join-Path $repoRoot $goalRelativePath
 $queuePath = Join-Path $repoRoot $queueRelativePath
 $statePath = Join-Path $repoRoot $stateRelativePath
 $backlogPath = Join-Path $repoRoot $backlogRelativePath
 $loopLogPath = Join-Path $repoRoot $loopLogRelativePath
+$goalHistoryPath = Join-Path $repoRoot $goalHistoryRelativePath
 $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
 
 function Test-HasValue {
@@ -64,6 +66,151 @@ function Write-JsonFile {
     [System.IO.File]::WriteAllText($Path, $json, $utf8WithBom)
 }
 
+function New-EmptyGoalHistory {
+    return [PSCustomObject][ordered]@{
+        version = 1
+        updatedAt = ""
+        goals = @()
+    }
+}
+
+function Read-AutopilotGoalHistory {
+    if (-not (Test-Path -LiteralPath $goalHistoryPath -PathType Leaf)) {
+        return New-EmptyGoalHistory
+    }
+
+    $history = Read-JsonFile $goalHistoryPath $goalHistoryRelativePath
+
+    if ($null -eq $history) {
+        return New-EmptyGoalHistory
+    }
+
+    if ($history -is [array]) {
+        $normalized = New-EmptyGoalHistory
+        $normalized.goals = @($history)
+        return $normalized
+    }
+
+    if ($history.PSObject.Properties.Name -notcontains "goals" -or $null -eq $history.goals) {
+        Set-ObjectProperty $history "goals" @()
+    }
+
+    if ($history.PSObject.Properties.Name -notcontains "version") {
+        Set-ObjectProperty $history "version" 1
+    }
+
+    if ($history.PSObject.Properties.Name -notcontains "updatedAt") {
+        Set-ObjectProperty $history "updatedAt" ""
+    }
+
+    return $history
+}
+
+function Get-AutopilotGoalHistoryTitles {
+    try {
+        $history = Read-AutopilotGoalHistory
+    } catch {
+        throw "Failed to read durable autopilot goal history: $($_.Exception.Message)"
+    }
+
+    $titles = @()
+
+    foreach ($goal in @($history.goals)) {
+        if ($null -eq $goal) {
+            continue
+        }
+
+        if ($goal -is [string]) {
+            $titles = @(Add-UniqueTitle $titles $goal)
+            continue
+        }
+
+        if ($goal.PSObject.Properties.Name -contains "title") {
+            $titles = @(Add-UniqueTitle $titles ([string]$goal.title))
+        }
+    }
+
+    return @($titles)
+}
+
+function Add-AutopilotGoalHistoryTitle {
+    param(
+        [string]$Title,
+        [string]$Event
+    )
+
+    if ($DryRun -or -not (Test-HasValue $Title)) {
+        return
+    }
+
+    $now = [DateTimeOffset]::UtcNow.ToString("o")
+    $trimmedTitle = $Title.Trim()
+    $history = Read-AutopilotGoalHistory
+    $goals = @($history.goals)
+    $existingGoal = $null
+
+    foreach ($goal in $goals) {
+        if ($null -eq $goal) {
+            continue
+        }
+
+        $goalTitle = ""
+
+        if ($goal -is [string]) {
+            $goalTitle = [string]$goal
+        } elseif ($goal.PSObject.Properties.Name -contains "title") {
+            $goalTitle = [string]$goal.title
+        }
+
+        if ($goalTitle.Trim() -eq $trimmedTitle) {
+            $existingGoal = $goal
+            break
+        }
+    }
+
+    if ($null -eq $existingGoal -or $existingGoal -is [string]) {
+        $events = @([PSCustomObject][ordered]@{
+            event = $Event
+            at = $now
+        })
+
+        $goalEntry = [PSCustomObject][ordered]@{
+            title = $trimmedTitle
+            firstSeenAt = $now
+            lastSeenAt = $now
+            lastEvent = $Event
+            events = $events
+        }
+
+        $goals = @($goals | Where-Object { -not ($_ -is [string] -and $_.Trim() -eq $trimmedTitle) })
+        $goals = @($goals) + @($goalEntry)
+    } else {
+        if ($existingGoal.PSObject.Properties.Name -notcontains "firstSeenAt" -or -not (Test-HasValue $existingGoal.firstSeenAt)) {
+            Set-ObjectProperty $existingGoal "firstSeenAt" $now
+        }
+
+        Set-ObjectProperty $existingGoal "lastSeenAt" $now
+        Set-ObjectProperty $existingGoal "lastEvent" $Event
+
+        $events = @()
+        if ($existingGoal.PSObject.Properties.Name -contains "events" -and $null -ne $existingGoal.events) {
+            $events = @($existingGoal.events)
+        }
+
+        $events = @($events) + @([PSCustomObject][ordered]@{
+            event = $Event
+            at = $now
+        })
+
+        Set-ObjectProperty $existingGoal "events" $events
+    }
+
+    Set-ObjectProperty $history "version" 1
+    Set-ObjectProperty $history "updatedAt" $now
+    Set-ObjectProperty $history "goals" @($goals)
+    Write-JsonFile $goalHistoryPath $history
+}
+
 function Set-ObjectProperty {
     param(
         [object]$InputObject,
@@ -99,37 +246,37 @@ function Invoke-AutopilotLoopLogMetaCommit {
     param([int]$StepNumber)
 
     if ($DryRun) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $false $true 0 "DryRun: autopilot loop-log meta commit was not executed."
+        return New-StepResult $StepNumber "autopilot-meta-commit" $false $true 0 "DryRun: autopilot loop-log/history meta commit was not executed."
     }
 
     if (-not $AllowCommit) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $false $true 0 "AllowCommit is not set, so autopilot loop-log meta commit was not executed."
+        return New-StepResult $StepNumber "autopilot-meta-commit" $false $true 0 "AllowCommit is not set, so autopilot loop-log/history meta commit was not executed."
     }
 
-    $statusOutput = & git status --short -- $loopLogRelativePath 2>&1 | Out-String
+    $statusOutput = & git status --short -- $loopLogRelativePath $goalHistoryRelativePath 2>&1 | Out-String
     $statusExitCode = $LASTEXITCODE
 
     if ($statusExitCode -ne 0) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "git status for autopilot loop-log failed. exit code: $statusExitCode`n$statusOutput"
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "git status for autopilot loop-log/history failed. exit code: $statusExitCode`n$statusOutput"
     }
 
     if (-not (Test-HasValue $statusOutput)) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 0 "Autopilot loop-log had no changes to commit."
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 0 "Autopilot loop-log/history had no changes to commit."
     }
 
-    $addOutput = & git add -- $loopLogRelativePath 2>&1 | Out-String
+    $addOutput = & git add -- $loopLogRelativePath $goalHistoryRelativePath 2>&1 | Out-String
     $addExitCode = $LASTEXITCODE
 
     if ($addExitCode -ne 0) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot loop-log git add failed. exit code: $addExitCode`n$addOutput"
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot loop-log/history git add failed. exit code: $addExitCode`n$addOutput"
     }
 
     $metaCommitMessage = "chore(ai-dev): record autopilot progress"
-    $commitOutput = & git commit -m $metaCommitMessage -- $loopLogRelativePath 2>&1 | Out-String
+    $commitOutput = & git commit -m $metaCommitMessage -- $loopLogRelativePath $goalHistoryRelativePath 2>&1 | Out-String
     $commitExitCode = $LASTEXITCODE
 
     if ($commitExitCode -ne 0) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot loop-log meta commit failed. exit code: $commitExitCode`n$commitOutput"
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot loop-log/history meta commit failed. exit code: $commitExitCode`n$commitOutput"
     }
 
     $remainingStatus = & git status --short 2>&1 | Out-String
@@ -575,6 +722,10 @@ function Get-HistoricalGoalTitles {
         $titles = @(Add-UniqueTitle $titles $title)
     }
 
+    foreach ($title in @(Get-AutopilotGoalHistoryTitles)) {
+        $titles = @(Add-UniqueTitle $titles $title)
+    }
+
     return @($titles)
 }
 
@@ -685,6 +836,7 @@ Set-Location $repoRoot
 $steps = @()
 $preparedGoals = 0
 $usedTitles = @()
+$durableHistoryTitles = @()
 
 if ($MaxGoals -lt 1) {
     $message = "MaxGoals must be at least 1."
@@ -731,8 +883,17 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
 
     $steps += New-StepResult ($steps.Count + 1) "current-goal-gate" $false $false 0 "Current goal is completed. Previous goal: $($gate.goalTitle)"
 
+    try {
+        Add-AutopilotGoalHistoryTitle ([string]$gate.goalTitle) "completed"
+    } catch {
+        $message = $_.Exception.Message
+        $steps += New-StepResult ($steps.Count + 1) "goal-history" $false $false 1 $message
+        Stop-Autopilot $steps "goal_history_update_failed" $false 1 $preparedGoals $message
+    }
+
     try {
         $excludedTitles = @(Get-ExcludedGoalTitles $usedTitles $gate)
+        $durableHistoryTitles = @(Get-AutopilotGoalHistoryTitles)
         $allCandidates = @(Get-BacklogCandidates)
         $candidates = @($allCandidates | Where-Object { $excludedTitles -notcontains ([string]$_.title) })
     } catch {
@@ -745,14 +906,15 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
         $excludedTitleSummary = Format-ExcludedGoalTitles $excludedTitles
         $candidateTitles = @($allCandidates | ForEach-Object { [string]$_.title } | Where-Object { Test-HasValue $_ } | Select-Object -Unique)
         $candidateTitleSummary = Format-ExcludedGoalTitles $candidateTitles
+        $historyTitleSummary = Format-ExcludedGoalTitles $durableHistoryTitles
 
         if ($allCandidates.Count -gt 0) {
-            $message = "All backlog goal candidates were already completed or prepared, so autopilot will not create a duplicate goal. Excluded goal titles: $excludedTitleSummary. Candidate goal titles: $candidateTitleSummary."
+            $message = "All backlog goal candidates were already completed, prepared, or recorded in durable history, so autopilot will not create a duplicate goal. Excluded goal titles: $excludedTitleSummary. Candidate goal titles: $candidateTitleSummary. Durable history goal titles: $historyTitleSummary."
             $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $true 1 $message
             Stop-Autopilot $steps "all_goal_candidates_excluded" $false 1 $preparedGoals $message
         }
 
-        $message = "No actionable next goal candidate was found in the backlog after excluding current, prepared, or completed goal titles. Excluded goal titles: $excludedTitleSummary. Check backlog encoding, empty items, completed or deferred sections, and duplicate backlog titles."
+        $message = "No actionable next goal candidate was found in the backlog after excluding current, prepared, completed, or durable history goal titles. Excluded goal titles: $excludedTitleSummary. Durable history goal titles: $historyTitleSummary. Check backlog encoding, empty items, completed or deferred sections, and duplicate backlog titles."
         $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $true 1 $message
         Stop-Autopilot $steps "goal_candidate_not_found" $false 1 $preparedGoals $message
     }
@@ -761,6 +923,14 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
     $usedTitles += [string]$candidate.title
     $candidateMessage = "Next goal candidate generated from $($candidate.source) priority $($candidate.priority)."
 
+    try {
+        Add-AutopilotGoalHistoryTitle ([string]$candidate.title) "selected"
+    } catch {
+        $message = $_.Exception.Message
+        $steps += New-StepResult ($steps.Count + 1) "goal-history" $false $false 1 $message $candidate
+        Stop-Autopilot $steps "goal_history_update_failed" $false 1 $preparedGoals $message
+    }
+
     if (Test-HasValue $candidate.fallbackReason) {
         $candidateMessage = "$candidateMessage $($candidate.fallbackReason)"
     }
@@ -798,6 +968,14 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
         $loopLogLines += "- Fallback reason: $($candidate.fallbackReason)"
     }
 
+    try {
+        Add-AutopilotGoalHistoryTitle ([string]$candidate.title) "prepared"
+    } catch {
+        $message = $_.Exception.Message
+        $steps += New-StepResult ($steps.Count + 1) "goal-history" $false $false 1 $message $candidate
+        Stop-Autopilot $steps "goal_history_update_failed" $false 1 $preparedGoals $message
+    }
+
     Add-LoopLogEntry "Autopilot goal prepared" $loopLogLines
 
     if ($AllowCommit) {
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