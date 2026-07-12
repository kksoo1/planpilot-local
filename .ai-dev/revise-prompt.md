# AI Dev Revise Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.
이전 리뷰에서 지적된 사항만 수정한다.

## Goal

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
- Verification:
- 한국어 goal title이 history에 보존되는지 확인한다.
- history에 있는 goal title이 다음 후보 선택에서 제외되는지 확인한다.
- DryRun 실행 전후 history, state, loop-log 파일이 변경되지 않는지 확인한다.
- task title이 goal title 제외 목록에 섞이지 않는지 확인한다.

## Review Result

- Decision: revise
- Severity: medium
- Next step: revise_with_codex
- Summary: durable history 제외 로직 자체는 추가됐지만, AllowCommit 경로에서 history 파일을 add만 하고 commit pathspec에
 포함하지 않아 성공 실행 후 작업 트리가 깨끗하지 않을 수 있습니다.

## Required Changes

- File: scripts/ai-dev-autopilot.ps1
  - Reason: 라인 268에서 loop-log와 goal history를 함께 git add하지만, 라인 276의 git commit은 loop-log만 paths
pec으로 지정합니다. 이 경우 .ai-dev/autopilot-goal-history.json 변경이 커밋되지 않고 staged 상태로 남아 'AllowCommit이 있는 성공 
실행은 최종 작업 트리가 깨끗한 상태'라는 성공 기준을 위반합니다.
  - Suggestion: git commit 명령에도 $goalHistoryRelativePath를 포함하고, 관련 실패 메시지도 loop-log/history 기준으
로 맞추십시오.

## Optional Suggestions

- optional_suggestions는 참고만 하며 구현하지 않는다.
- File: scripts/ai-dev-autopilot.ps1
  - Suggestion: goal history 업데이트와 meta commit 경로에 대한 수동 검증 결과를 남기면 DryRun/AllowCommit 회귀를 더 명확
히 확인할 수 있습니다.

## Diff Context

# AI Dev Diff

## Generated At

2026-07-12 23:56:07

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-autopilot.ps1
```

## App Change Files

- scripts/ai-dev-autopilot.ps1

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-autopilot.ps1 | 197 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 188 insertions(+), 9 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-autopilot.ps1 b/scripts/ai-dev-autopilot.ps1
index 20d4d35..7c31a90 100644
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
@@ -64,6 +66,152 @@ function Write-JsonFile {
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
+        $goals += $goalEntry
+    } else {
+        if ($existingGoal.PSObject.Properties.Name -notcontains "firstSeenAt" -or -not (Test-HasValue $existingGoal.firstSeenAt)) {
+            Set-ObjectProperty $existingGoal "firstSeenAt" $now
+        }
+
+        Set-ObjectProperty $existingGoal "lastSeenAt" $now
+        Set-ObjectProperty $existingGoal "lastEvent" $Event
+
+        $events = if ($existingGoal.PSObject.Properties.Name -contains "events" -and $null -ne $existingGoal.events) {
+            @($existingGoal.events)
+        } else {
+            @()
+        }
+
+        $events += [PSCustomObject][ordered]@{
+            event = $Event
+            at = $now
+        }
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
@@ -99,29 +247,29 @@ function Invoke-AutopilotLoopLogMetaCommit {
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
@@ -575,6 +723,10 @@ function Get-HistoricalGoalTitles {
         $titles = @(Add-UniqueTitle $titles $title)
     }
 
+    foreach ($title in @(Get-AutopilotGoalHistoryTitles)) {
+        $titles = @(Add-UniqueTitle $titles $title)
+    }
+
     return @($titles)
 }
 
@@ -685,6 +837,7 @@ Set-Location $repoRoot
 $steps = @()
 $preparedGoals = 0
 $usedTitles = @()
+$durableHistoryTitles = @()
 
 if ($MaxGoals -lt 1) {
     $message = "MaxGoals must be at least 1."
@@ -731,8 +884,17 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
 
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
@@ -745,14 +907,15 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
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
@@ -761,6 +924,14 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
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
@@ -798,6 +969,14 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
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

## Test Result

# AI Dev Test Result

## 2026-07-12 23:55:58

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

[32m✓ built in 256ms[39m
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