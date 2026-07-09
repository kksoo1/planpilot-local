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
AI Dev Loop에 제한된 autopilot 모드를 추가해, 저장된 프로젝트 비전과 backlog, 현재 상태를 바탕으로 다음 개발 goal을 자동 생성하고 기존 실행 흐름에 전달할 수 있게 한다.

## 배경
현재 AI Dev Loop는 사용자가 매번 목표 제목과 설명을 제공하는 goal 단위 실행에 가깝다. 반복 개발을 줄이려면 로컬 상태 파일을 기준으로 다음 작업을 제안하고 실행 준비까지 이어 주는 자동화 진입점이 필요하다.

## 성공 기준
- autopilot 모드를 실행하는 스크립트 또는 기존 스크립트 옵션이 추가된다.
- autopilot은 최대 실행 goal 수를 제한값으로 받거나 기본 제한값을 사용한다.
- 현재 상태와 완료 조건을 확인한 뒤 다음 goal 후보를 생성한다.
- goal 생성 실패, 검증 실패, 반복 실패, 작업 불가 상태를 state 또는 log에 명확히 기록하고 중단한다.
- 앱 src 기능 코드는 변경하지 않는다.
- 관련 사용법 문서 또는 템플릿이 함께 정리된다.

## 제약사항
- React 앱 기능 개발은 하지 않는다.
- 자동화 스크립트와 필요한 문서, 템플릿만 최소 범위로 수정한다.
- 기존 AI Dev Loop의 상태 파일 형식과 실행 흐름을 우선 재사용한다.
- 무한 반복이 아닌 제한된 반복만 허용한다.
- 실패 시 원인을 추적할 수 있는 상태 기록을 남긴다.

## 범위 제외
- 앱 화면, IndexedDB 스키마, 사용자 데이터 구조 변경은 제외한다.
- 새로운 제품 기능 구현은 제외한다.
- 대규모 구조 변경은 제외한다.

## 수동 검증
- autopilot 모드가 제한값을 인식하는지 확인한다.
- 다음 goal 생성 결과가 `.ai-dev` 상태 파일에 반영되는지 확인한다.
- 실패 조건에서 중단 사유가 기록되는지 확인한다.
- 기존 단일 goal 실행 흐름이 깨지지 않는지 확인한다.

## Current Task

- Task ID: T002
- Title: 제한된 autopilot 실행 흐름 구현
- Description: 최대 goal 수 제한, 상태 확인, 다음 goal 생성, 기존 실행 흐름 호출, 실패 사유 기록을 포함한 작은 autopilot 모드를 추가한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- T001
- Verification:
- 제한값이 없을 때 기본값으로 동작하는지 확인한다.
- goal 생성 실패 시 state 또는 log에 사유가 남는지 확인한다.
- 기존 단일 goal 실행 흐름이 유지되는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-01 21:13:03

- Overall result: passed
- Current task: T002
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

[32m✓ built in 676ms[39m
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

## 2026-07-01 T002 review-required revise verification

- Overall result: passed
- Scope: scripts/ai-dev-autopilot.ps1, .ai-dev/test-result.md only
- npm run test: skipped because package.json has no test script.
- scripts/ai-dev-auto-goal.ps1: not modified, so the existing single-goal flow remains unchanged.

### PowerShell parse check

- Command: PowerShell parser check for scripts/ai-dev-autopilot.ps1
- Status: passed
- Evidence: `parse: passed`

### Safe DryRun/Json MaxGoals limit check

- Command: `powershell -ExecutionPolicy Bypass -File scripts/ai-dev-autopilot.ps1 -MaxGoals 0 -DryRun -Json`
- Status: passed as a safe rejection
- Evidence:
  - stoppedReason: `max_goals_must_be_at_least_1`
  - exitCode: `1`
  - maxGoals: `0`
  - preparedGoals: `0`

### Safe current_goal_not_completed gate check

- Command: `powershell -ExecutionPolicy Bypass -File scripts/ai-dev-autopilot.ps1 -DryRun -Json`
- Status: passed as a safe gate stop
- Evidence:
  - stoppedReason: `current_goal_not_completed`
  - goalStatus: `in_progress`
  - currentTaskId: `T002`
  - openTaskCount: `2`
  - maxGoals default: `1`
  - preparedGoals: `0`

### Mojibake backlog title handling

- Method: loaded only function definitions from scripts/ai-dev-autopilot.ps1 with PowerShell AST, then used an in-process mocked backlog reader. No project files were created for this check.
- Mojibake-looking title sample: `full auto-cycle 濡쒓렇 援ъ“ 媛쒖꽑`
- Status: passed
- Evidence:
  - mojibakeCandidateKind: `fallback`
  - mojibakeGoalTitle: `Prepare the next local autopilot development task`
  - backlogPath: `.ai-dev/backlog.md`
  - readItemCount: `1`
  - filteredItemCount: `1`
  - usableItemCount: `1`
  - readableItemCount: `0`
  - suspiciousTitleReason: `mixed_cjk_ideographs_and_hangul_in_short_title`
- Result: the mojibake-looking Korean title was not passed as a real GoalTitle or GoalDescription; fallback was used instead.

### Normal Korean backlog title handling

- Normal Korean title sample: `Codex CLI 완전 자동화 정책 문서화`
- Status: passed
- Evidence:
  - normalCandidateKind: `backlog`
  - normalGoalTitle: `Codex CLI 완전 자동화 정책 문서화`
  - normalSuspiciousTitleReason: empty
- Result: normal Korean backlog titles remain valid readable backlog candidates.

## 2026-07-08 T002 review-required mojibake pattern revise verification

- Overall result: passed
- Scope: scripts/ai-dev-autopilot.ps1, .ai-dev/test-result.md only
- npm run test: skipped because package.json has no test script.
- scripts/ai-dev-auto-goal.ps1: not modified; this revision only patched scripts/ai-dev-autopilot.ps1 and updated this verification record.
- Build/lint: not run for this review-required patch.

### PowerShell function check

- Method: parsed scripts/ai-dev-autopilot.ps1 with PowerShell AST, loaded only function definitions in-process, and evaluated backlog title candidate handling without creating project files.
- Status: passed
- Evidence:
  - `자동화의 다음 단계 정리`
    - candidateKind: `backlog`
    - suspiciousTitleReason: empty
    - result: normal Korean title containing `의` remains a readable backlog candidate.
  - `Codex CLI 완전 자동화 정책 문서화`
    - candidateKind: `backlog`
    - suspiciousTitleReason: empty
    - result: normal Korean backlog title remains valid.
  - `full auto-cycle 濡쒓렇 援ъ“ 媛쒖꽑`
    - candidateKind: `fallback`
    - fallback title: `Prepare the next local autopilot development task`
    - suspiciousTitleReason: `mixed_cjk_ideographs_and_hangul_in_short_title`
    - result: mixed CJK ideographs plus Hangul mojibake-looking title is not used directly as a real goal title.


## Diff To Review

# AI Dev Diff

## Generated At

2026-07-08 23:25:20

## Git Status

```text
 M .ai-dev/README.md
 M .ai-dev/codex-result.md
 M .ai-dev/codex-review-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/diff.md
 M .ai-dev/loop-log.md
 M .ai-dev/review-prompt.md
 M .ai-dev/review-response.json
 M .ai-dev/review.md
 M .ai-dev/revise-prompt.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 A scripts/ai-dev-autopilot.ps1
```

## App Change Files

- scripts/ai-dev-autopilot.ps1

## AI Dev Operational Artifact Files

- .ai-dev/README.md
- .ai-dev/codex-result.md
- .ai-dev/codex-review-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/diff.md
- .ai-dev/loop-log.md
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
 scripts/ai-dev-autopilot.ps1 | 639 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 639 insertions(+)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-autopilot.ps1 b/scripts/ai-dev-autopilot.ps1
new file mode 100644
index 0000000..cd4812c
--- /dev/null
+++ b/scripts/ai-dev-autopilot.ps1
@@ -0,0 +1,639 @@
+param(
+    [int]$MaxGoals = 1,
+    [int]$MaxTasks = 1,
+    [int]$MaxSteps = 22,
+    [switch]$DryRun,
+    [switch]$Json,
+    [switch]$AllowRun,
+    [switch]$AllowCodex,
+    [switch]$AllowReviewCodex,
+    [switch]$AllowCommit,
+    [switch]$AllowDirty,
+    [string[]]$CommitFiles
+)
+
+. "$PSScriptRoot\ai-dev-env.ps1"
+
+$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
+$goalRelativePath = ".ai-dev/goal.md"
+$queueRelativePath = ".ai-dev/queue.json"
+$stateRelativePath = ".ai-dev/state.json"
+$backlogRelativePath = ".ai-dev/backlog.md"
+$loopLogRelativePath = ".ai-dev/loop-log.md"
+$goalPath = Join-Path $repoRoot $goalRelativePath
+$queuePath = Join-Path $repoRoot $queueRelativePath
+$statePath = Join-Path $repoRoot $stateRelativePath
+$backlogPath = Join-Path $repoRoot $backlogRelativePath
+$loopLogPath = Join-Path $repoRoot $loopLogRelativePath
+$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
+
+function Test-HasValue {
+    param([object]$Value)
+
+    if ($null -eq $Value) {
+        return $false
+    }
+
+    if ($Value -is [string]) {
+        return -not [string]::IsNullOrWhiteSpace($Value)
+    }
+
+    return $true
+}
+
+function Read-JsonFile {
+    param(
+        [string]$Path,
+        [string]$RelativePath
+    )
+
+    try {
+        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | ConvertFrom-Json
+    } catch {
+        throw "Failed to parse JSON file $($RelativePath): $($_.Exception.Message)"
+    }
+}
+
+function Write-JsonFile {
+    param(
+        [string]$Path,
+        [object]$Value
+    )
+
+    $json = $Value | ConvertTo-Json -Depth 20
+    [System.IO.File]::WriteAllText($Path, $json, $utf8WithBom)
+}
+
+function Set-ObjectProperty {
+    param(
+        [object]$InputObject,
+        [string]$Name,
+        [object]$Value
+    )
+
+    if ($InputObject.PSObject.Properties.Name -contains $Name) {
+        $InputObject.$Name = $Value
+    } else {
+        $InputObject | Add-Member -NotePropertyName $Name -NotePropertyValue $Value
+    }
+}
+
+function Add-LoopLogEntry {
+    param(
+        [string]$Title,
+        [string[]]$Lines
+    )
+
+    if ($DryRun) {
+        return
+    }
+
+    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
+    $entryLines = @("", "## $timestamp - $Title", "")
+    $entryLines += @($Lines)
+    $entryLines += ""
+    [System.IO.File]::AppendAllText($loopLogPath, ($entryLines -join "`r`n"), $utf8WithBom)
+}
+
+function Save-AutopilotFailureState {
+    param(
+        [string]$StoppedReason,
+        [string]$Message
+    )
+
+    if ($DryRun) {
+        return
+    }
+
+    try {
+        $state = Read-JsonFile $statePath $stateRelativePath
+        $previousReason = if (Test-HasValue $state.stopReason) { [string]$state.stopReason } else { "" }
+        $previousRepeatedFailureCount = 0
+
+        if (Test-HasValue $state.repeatedFailureCount) {
+            $previousRepeatedFailureCount = [int]$state.repeatedFailureCount
+        }
+
+        $nextRepeatedFailureCount = if ($previousReason -eq $StoppedReason) { $previousRepeatedFailureCount + 1 } else { 1 }
+
+        Set-ObjectProperty $state "lastCommand" "autopilot"
+        Set-ObjectProperty $state "lastCommandStatus" "failed"
+        Set-ObjectProperty $state "lastErrorSummary" $Message
+        Set-ObjectProperty $state "repeatedFailureCount" $nextRepeatedFailureCount
+        Set-ObjectProperty $state "stopReason" $StoppedReason
+        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
+        Write-JsonFile $statePath $state
+    } catch {
+        Write-Warning "Failed to record autopilot failure state: $($_.Exception.Message)"
+    }
+}
+
+function New-StepResult {
+    param(
+        [int]$Step,
+        [string]$Name,
+        [bool]$Executed,
+        [bool]$Skipped,
+        [int]$ExitCode,
+        [string]$Message,
+        [object]$GoalCandidate = $null
+    )
+
+    return [PSCustomObject][ordered]@{
+        step = $Step
+        name = $Name
+        executed = $Executed
+        skipped = $Skipped
+        exitCode = $ExitCode
+        message = $Message
+        goalCandidate = $GoalCandidate
+    }
+}
+
+function New-AutopilotResult {
+    param(
+        [object[]]$Steps,
+        [string]$StoppedReason,
+        [bool]$Completed,
+        [int]$ExitCode,
+        [int]$PreparedGoals
+    )
+
+    return [PSCustomObject][ordered]@{
+        steps = @($Steps)
+        stoppedReason = $StoppedReason
+        completed = $Completed
+        exitCode = $ExitCode
+        maxGoals = $MaxGoals
+        preparedGoals = $PreparedGoals
+    }
+}
+
+function Write-AutopilotResult {
+    param([object]$Result)
+
+    if ($Json) {
+        $Result | ConvertTo-Json -Depth 30
+        return
+    }
+
+    foreach ($step in @($Result.steps)) {
+        Write-Host "Step $($step.step): $($step.name)"
+        Write-Host "  Executed: $($step.executed)"
+        Write-Host "  Skipped: $($step.skipped)"
+        Write-Host "  Exit code: $($step.exitCode)"
+        Write-Host "  Message: $($step.message)"
+
+        if ($null -ne $step.goalCandidate) {
+            Write-Host "  Goal candidate: $($step.goalCandidate.title)"
+        }
+    }
+
+    Write-Host "Stopped reason: $($Result.stoppedReason)"
+    Write-Host "Completed: $($Result.completed)"
+    Write-Host "Prepared goals: $($Result.preparedGoals)/$($Result.maxGoals)"
+    Write-Host "Exit code: $($Result.exitCode)"
+}
+
+function Stop-Autopilot {
+    param(
+        [object[]]$Steps,
+        [string]$StoppedReason,
+        [bool]$Completed,
+        [int]$ExitCode,
+        [int]$PreparedGoals,
+        [string]$FailureMessage = ""
+    )
+
+    if ($ExitCode -ne 0 -and (Test-HasValue $FailureMessage)) {
+        Save-AutopilotFailureState $StoppedReason $FailureMessage
+        Add-LoopLogEntry "Autopilot stopped" @(
+            "- Reason: $StoppedReason",
+            "- Result: $FailureMessage",
+            "- Prepared goals: $PreparedGoals/$MaxGoals"
+        )
+    }
+
+    $result = New-AutopilotResult $Steps $StoppedReason $Completed $ExitCode $PreparedGoals
+    Write-AutopilotResult $result
+    exit $ExitCode
+}
+
+function Get-CurrentGoalGate {
+    $queue = Read-JsonFile $queuePath $queueRelativePath
+    $state = Read-JsonFile $statePath $stateRelativePath
+    $tasks = @($queue.tasks)
+    $openTasks = @($tasks | Where-Object { @("pending", "in_progress", "review_required", "failed", "blocked") -contains ([string]$_.status) })
+    $goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { "" }
+    $currentTaskId = if (Test-HasValue $state.currentTaskId) { [string]$state.currentTaskId } elseif (Test-HasValue $queue.currentTaskId) { [string]$queue.currentTaskId } else { "" }
+
+    return [PSCustomObject][ordered]@{
+        passed = ($goalStatus -eq "completed" -and -not (Test-HasValue $currentTaskId) -and $openTasks.Count -eq 0)
+        goalTitle = if (Test-HasValue $queue.goalTitle) { [string]$queue.goalTitle } else { "" }
+        goalStatus = $goalStatus
+        currentTaskId = $currentTaskId
+        openTaskCount = $openTasks.Count
+    }
+}
+
+function Test-IsUsableBacklogText {
+    param([string]$Text)
+
+    if (-not (Test-HasValue $Text)) {
+        return $false
+    }
+
+    $trimmed = $Text.Trim()
+
+    if ($trimmed.Length -lt 4) {
+        return $false
+    }
+
+    if ($trimmed -notmatch '[\p{L}\p{N}]') {
+        return $false
+    }
+
+    return $true
+}
+
+function Get-BacklogTitleSuspicionReason {
+    param([string]$Text)
+
+    if (-not (Test-IsUsableBacklogText $Text)) {
+        return "not_usable"
+    }
+
+    $trimmed = $Text.Trim()
+
+    if ($trimmed -match [string][char]0xFFFD) {
+        return "contains_replacement_character"
+    }
+
+    if ($trimmed -match '\?{2,}') {
+        return "contains_repeated_question_marks"
+    }
+
+    if ($trimmed.Length -le 80 -and $trimmed -match '[\u4E00-\u9FFF]' -and $trimmed -match '[\uAC00-\uD7A3]') {
+        return "mixed_cjk_ideographs_and_hangul_in_short_title"
+    }
+
+    $mojibakePattern = '([\u00C2\u00C3\u00E2\u00EC\u00ED\u00EB][\u0080-\u00BF\u00A0-\u00FF]{1,})|(\uC392[\uAC00-\uD7A3])|(\u6FE1\u63F4|\u5A9B\u5AC4|\u8ADB)'
+
+    if ($trimmed -match $mojibakePattern) {
+        return "contains_common_mojibake_fragment"
+    }
+
+    return ""
+}
+
+function Test-IsReadableBacklogText {
+    param([string]$Text)
+
+    $reason = Get-BacklogTitleSuspicionReason $Text
+    return (-not (Test-HasValue $reason))
+}
+
+function Join-UniqueReasons {
+    param([string[]]$Reasons)
+
+    $uniqueReasons = @($Reasons | Where-Object { Test-HasValue $_ } | Select-Object -Unique)
+
+    if ($uniqueReasons.Count -eq 0) {
+        return ""
+    }
+
+    return ($uniqueReasons -join ", ")
+}
+
+function New-ReadableBacklogCandidate {
+    param(
+        [string]$Title,
+        [string]$Priority
+    )
+
+    $description = "Prepare the smallest actionable development goal from the $Priority backlog item for the current repository state: $Title"
+
+    return [PSCustomObject][ordered]@{
+        title = $Title
+        description = $description
+        priority = $Priority
+        source = $backlogRelativePath
+        candidateKind = "backlog"
+        suspiciousTitleReason = ""
+    }
+}
+
+function New-UnreadableBacklogCandidate {
+    param(
+        [string]$Title,
+        [string]$Priority,
+        [string]$SuspiciousTitleReason
+    )
+
+    return [PSCustomObject][ordered]@{
+        title = $Title
+        priority = $Priority
+        source = $backlogRelativePath
+        candidateKind = "rejected_backlog"
+        suspiciousTitleReason = $SuspiciousTitleReason
+    }
+}
+
+function New-FallbackBacklogCandidate {
+    param(
+        [int]$ReadItemCount,
+        [int]$FilteredItemCount,
+        [int]$ReadableItemCount,
+        [int]$UsableItemCount,
+        [string]$Why,
+        [string]$SuspiciousTitleReason = ""
+    )
+
+    $suspicion = if (Test-HasValue $SuspiciousTitleReason) { $SuspiciousTitleReason } else { "none" }
+    $reason = "No clean backlog candidate could be generated from file content. backlog=$backlogRelativePath, readItemCount=$ReadItemCount, filteredItemCount=$FilteredItemCount, usableItemCount=$UsableItemCount, readableItemCount=$ReadableItemCount, suspiciousTitleReason=$suspicion. Fallback was used because $Why"
+
+    return [PSCustomObject][ordered]@{
+        title = "Prepare the next local autopilot development task"
+        description = "Create the smallest safe next goal for the PlanPilot local repository from the current autopilot context. Preserve repository limits, avoid app source changes unless a task explicitly requires them, and keep the current goal completion gate intact."
+        priority = "fallback"
+        source = $backlogRelativePath
+        candidateKind = "fallback"
+        suspiciousTitleReason = $suspicion
+        fallbackReason = $reason
+        fallbackContext = [PSCustomObject][ordered]@{
+            backlogPath = $backlogRelativePath
+            readItemCount = $ReadItemCount
+            filteredItemCount = $FilteredItemCount
+            usableItemCount = $UsableItemCount
+            readableItemCount = $ReadableItemCount
+            suspiciousTitleReason = $suspicion
+        }
+    }
+}
+
+function Get-BacklogCandidates {
+    if (-not (Test-Path -LiteralPath $backlogPath -PathType Leaf)) {
+        throw "Required backlog file is missing: $backlogRelativePath"
+    }
+
+    $lines = @(Get-Content -Encoding UTF8 -LiteralPath $backlogPath)
+    $readableCandidates = @()
+    $usableCandidates = @()
+    $suspiciousTitleReasons = @()
+    $readItemCount = 0
+    $filteredItemCount = 0
+    $priority = ""
+    $isBacklogPrioritySection = $false
+
+    foreach ($line in $lines) {
+        if ($line -match '^##\s*(P[0-2])\s*$') {
+            $priority = $Matches[1]
+            $isBacklogPrioritySection = $true
+            continue
+        }
+
+        if ($line -match '^##\s+') {
+            $priority = ""
+            $isBacklogPrioritySection = $false
+            continue
+        }
+
+        if (-not $isBacklogPrioritySection) {
+            continue
+        }
+
+        if ($line -notmatch '^\s*-\s+(.+)$') {
+            continue
+        }
+
+        $title = $Matches[1].Trim()
+        $readItemCount++
+
+        if (-not (Test-IsUsableBacklogText $title)) {
+            $filteredItemCount++
+            continue
+        }
+
+        $suspiciousTitleReason = Get-BacklogTitleSuspicionReason $title
+
+        if (Test-HasValue $suspiciousTitleReason) {
+            $usableCandidates += New-UnreadableBacklogCandidate $title $priority $suspiciousTitleReason
+            $suspiciousTitleReasons += $suspiciousTitleReason
+            $filteredItemCount++
+            continue
+        }
+
+        $candidate = New-ReadableBacklogCandidate $title $priority
+        $usableCandidates += $candidate
+        $readableCandidates += $candidate
+    }
+
+    if ($readableCandidates.Count -gt 0) {
+        return @($readableCandidates)
+    }
+
+    $joinedSuspiciousTitleReasons = Join-UniqueReasons $suspiciousTitleReasons
+
+    if ($usableCandidates.Count -gt 0) {
+        $fallbackWhy = "the backlog items were usable but no clean, readable title was available for a generated goal title."
+        $fallback = New-FallbackBacklogCandidate $readItemCount $filteredItemCount $readableCandidates.Count $usableCandidates.Count $fallbackWhy $joinedSuspiciousTitleReasons
+        return @($fallback)
+    }
+
+    $fallbackReason = if ($readItemCount -eq 0) {
+        "the backlog priority sections did not contain bullet items."
+    } else {
+        "all backlog bullet items were empty, too short, or did not contain letters or numbers."
+    }
+
+    $fallbackCandidate = New-FallbackBacklogCandidate $readItemCount $filteredItemCount $readableCandidates.Count $usableCandidates.Count $fallbackReason $joinedSuspiciousTitleReasons
+    return @($fallbackCandidate)
+}
+
+function Invoke-AutoGoal {
+    param(
+        [object]$Candidate,
+        [int]$StepNumber
+    )
+
+    $autoGoalPath = Join-Path $PSScriptRoot "ai-dev-auto-goal.ps1"
+
+    if (-not (Test-Path -LiteralPath $autoGoalPath -PathType Leaf)) {
+        throw "Required script is missing: scripts/ai-dev-auto-goal.ps1"
+    }
+
+    $arguments = @(
+        "-GoalTitle", [string]$Candidate.title,
+        "-GoalDescription", [string]$Candidate.description,
+        "-MaxTasks", [string]$MaxTasks,
+        "-MaxSteps", [string]$MaxSteps
+    )
+
+    if ($DryRun) {
+        $arguments += "-DryRun"
+    }
+
+    if ($Json) {
+        $arguments += "-Json"
+    }
+
+    if ($AllowRun) {
+        $arguments += "-AllowRun"
+    }
+
+    if ($AllowCodex) {
+        $arguments += "-AllowCodex"
+    }
+
+    if ($AllowReviewCodex) {
+        $arguments += "-AllowReviewCodex"
+    }
+
+    if ($AllowCommit) {
+        $arguments += "-AllowCommit"
+    }
+
+    if ($AllowDirty) {
+        $arguments += "-AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { Test-HasValue $_ })
+
+        if ($normalizedFiles.Count -gt 0) {
+            $arguments += "-CommitFiles"
+            $arguments += ($normalizedFiles -join ",")
+        }
+    }
+
+    $output = & powershell -ExecutionPolicy Bypass -File $autoGoalPath @arguments 2>&1 | Out-String
+    $exitCode = $LASTEXITCODE
+    $message = $output.Trim()
+
+    if (-not (Test-HasValue $message)) {
+        $message = "ai-dev-auto-goal.ps1 completed without output."
+    }
+
+    return New-StepResult $StepNumber "auto-goal" $true $false $exitCode $message $Candidate
+}
+
+Set-Location $repoRoot
+
+$steps = @()
+$preparedGoals = 0
+$usedTitles = @()
+
+if ($MaxGoals -lt 1) {
+    $message = "MaxGoals must be at least 1."
+    $steps += New-StepResult 0 "validate-input" $false $false 1 $message
+    Stop-Autopilot $steps "max_goals_must_be_at_least_1" $false 1 $preparedGoals $message
+}
+
+if ($MaxTasks -lt 1) {
+    $message = "MaxTasks must be at least 1."
+    $steps += New-StepResult 0 "validate-input" $false $false 1 $message
+    Stop-Autopilot $steps "max_tasks_must_be_at_least_1" $false 1 $preparedGoals $message
+}
+
+if ($MaxSteps -lt 1) {
+    $message = "MaxSteps must be at least 1."
+    $steps += New-StepResult 0 "validate-input" $false $false 1 $message
+    Stop-Autopilot $steps "max_steps_must_be_at_least_1" $false 1 $preparedGoals $message
+}
+
+foreach ($requiredPath in @($goalPath, $queuePath, $statePath, $backlogPath)) {
+    if (-not (Test-Path -LiteralPath $requiredPath -PathType Leaf)) {
+        $message = "Required file is missing: $requiredPath"
+        $steps += New-StepResult 0 "prepare" $false $false 1 $message
+        Stop-Autopilot $steps "required_file_missing" $false 1 $preparedGoals $message
+    }
+}
+
+$steps += New-StepResult 1 "validate-input" $false $false 0 "Autopilot input validation completed. MaxGoals=$MaxGoals, MaxTasks=$MaxTasks, MaxSteps=$MaxSteps"
+
+for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
+    try {
+        $gate = Get-CurrentGoalGate
+    } catch {
+        $message = $_.Exception.Message
+        $steps += New-StepResult ($steps.Count + 1) "current-goal-gate" $false $false 1 $message
+        Stop-Autopilot $steps "current_goal_gate_failed" $false 1 $preparedGoals $message
+    }
+
+    if (-not $gate.passed) {
+        $message = "Current goal is not completed, so autopilot will not create the next goal. goalStatus=$($gate.goalStatus), currentTaskId=$($gate.currentTaskId), openTaskCount=$($gate.openTaskCount)"
+        $steps += New-StepResult ($steps.Count + 1) "current-goal-gate" $false $true 1 $message
+        Stop-Autopilot $steps "current_goal_not_completed" $false 1 $preparedGoals $message
+    }
+
+    $steps += New-StepResult ($steps.Count + 1) "current-goal-gate" $false $false 0 "Current goal is completed. Previous goal: $($gate.goalTitle)"
+
+    try {
+        $excludedTitles = @($usedTitles)
+
+        if (Test-HasValue $gate.goalTitle) {
+            $excludedTitles += [string]$gate.goalTitle
+        }
+
+        $candidates = @(Get-BacklogCandidates | Where-Object { $excludedTitles -notcontains ([string]$_.title) })
+    } catch {
+        $message = $_.Exception.Message
+        $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $false 1 $message
+        Stop-Autopilot $steps "goal_candidate_generation_failed" $false 1 $preparedGoals $message
+    }
+
+    if ($candidates.Count -eq 0) {
+        $message = "No actionable next goal candidate was found in the backlog after excluding the current or already prepared goal titles. Check backlog encoding, empty items, completed or deferred sections, and duplicate backlog titles."
+        $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $true 1 $message
+        Stop-Autopilot $steps "goal_candidate_not_found" $false 1 $preparedGoals $message
+    }
+
+    $candidate = $candidates | Select-Object -First 1
+    $usedTitles += [string]$candidate.title
+    $candidateMessage = "Next goal candidate generated from $($candidate.source) priority $($candidate.priority)."
+
+    if (Test-HasValue $candidate.fallbackReason) {
+        $candidateMessage = "$candidateMessage $($candidate.fallbackReason)"
+    }
+
+    $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $false 0 $candidateMessage $candidate
+
+    try {
+        $autoGoalStep = Invoke-AutoGoal $candidate ($steps.Count + 1)
+    } catch {
+        $message = "Auto-goal failed before completion: $($_.Exception.Message)"
+        $steps += New-StepResult ($steps.Count + 1) "auto-goal" $false $false 1 $message $candidate
+        Stop-Autopilot $steps "auto_goal_failed" $false 1 $preparedGoals $message
+    }
+
+    $steps += $autoGoalStep
+
+    if ($autoGoalStep.exitCode -ne 0) {
+        $failureMessage = "Auto-goal failed with exit code $($autoGoalStep.exitCode): $($autoGoalStep.message)"
+
+        if (Test-HasValue $candidate.fallbackReason) {
+            $failureMessage = "$failureMessage Fallback context: $($candidate.fallbackReason)"
+        }
+
+        Stop-Autopilot $steps "auto_goal_failed" $false 1 $preparedGoals $failureMessage
+    }
+
+    $preparedGoals++
+    $loopLogLines = @(
+        "- Goal: $($candidate.title)",
+        "- Source: $($candidate.source) / $($candidate.priority)",
+        "- Prepared goals: $preparedGoals/$MaxGoals"
+    )
+
+    if (Test-HasValue $candidate.fallbackReason) {
+        $loopLogLines += "- Fallback reason: $($candidate.fallbackReason)"
+    }
+
+    Add-LoopLogEntry "Autopilot goal prepared" $loopLogLines
+
+    if (-not ($AllowRun -or $AllowCodex -or $AllowReviewCodex -or $AllowCommit)) {
+        Stop-Autopilot $steps "prepared_without_full_cycle" $true 0 $preparedGoals
+    }
+}
+
+Stop-Autopilot $steps "max_goals_reached" $true 0 $preparedGoals
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```

## Untracked File Content

내용을 포함할 추적되지 않은 텍스트 파일이 없습니다.

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