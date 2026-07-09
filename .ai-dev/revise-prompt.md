# AI Dev Revise Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.
이전 리뷰에서 지적된 사항만 수정한다.

## Goal

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
- Verification:
- 제한값이 없을 때 기본값으로 동작하는지 확인한다.
- goal 생성 실패 시 state 또는 log에 사유가 남는지 확인한다.
- 기존 단일 goal 실행 흐름이 유지되는지 확인한다.

## Review Result

- Decision: revise
- Severity: medium
- Next step: revise_with_codex
- Summary: autopilot 후보 중복 방지 범위가 현재 실행 중 메모리로만 제한되어, 직전에 완료된 goal과 같은 backlog 항목을 다음 goal로 다시 생성할 수 있습니다.

## Required Changes

- File: scripts/ai-dev-autopilot.ps1
  - Reason: `Get-CurrentGoalGate`에서 이전 goal title을 읽어오지만, 후보 필터는 `$usedTitles`만 확인합니다. `$usedTitles`는 현재 프로세스 안에서만 유지되므로 다음 autopilot 실행 때 `.ai-dev/queue.json`의 방금 완료된 `goalTitle`과 같은 backlog 첫 항목을 다시 선택할 수 있습니다.
  - Suggestion: 후보 생성 시 `$gate.goalTitle`도 제외하거나, 최소한 현재/직전 완료 goal title과 같은 후보를 건너뛰고 남은 후보가 없으면 명확한 `goal_candidate_not_found` 사유를 기록하도록 수정하세요.

## Optional Suggestions

- optional_suggestions는 참고만 하며 구현하지 않는다.
- File: scripts/ai-dev-autopilot.ps1
  - Suggestion: 중복 후보를 건너뛰는 경우 step message나 failure message에 제외된 title을 포함하면 반복 중단 원인 추적이 쉬워집니다.

## Diff Context

# AI Dev Diff

## Generated At

2026-06-28 21:13:22

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
 scripts/ai-dev-autopilot.ps1 | 555 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 555 insertions(+)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-autopilot.ps1 b/scripts/ai-dev-autopilot.ps1
new file mode 100644
index 0000000..fcdab4e
--- /dev/null
+++ b/scripts/ai-dev-autopilot.ps1
@@ -0,0 +1,555 @@
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
+function Test-IsReadableBacklogText {
+    param([string]$Text)
+
+    if (-not (Test-IsUsableBacklogText $Text)) {
+        return $false
+    }
+
+    $trimmed = $Text.Trim()
+
+    if ($trimmed -match [string][char]0xFFFD) {
+        return $false
+    }
+
+    if ($trimmed -match '\?{2,}') {
+        return $false
+    }
+
+    return $true
+}
+
+function New-FallbackBacklogCandidate {
+    param(
+        [int]$ReadItemCount,
+        [int]$FilteredItemCount,
+        [int]$ReadableItemCount,
+        [int]$UsableItemCount,
+        [string]$Why
+    )
+
+    $reason = "No clean backlog candidate could be generated from file content. backlog=$backlogRelativePath, readItemCount=$ReadItemCount, filteredItemCount=$FilteredItemCount, usableItemCount=$UsableItemCount, readableItemCount=$ReadableItemCount. Fallback was used because $Why"
+
+    return [PSCustomObject][ordered]@{
+        title = "Prepare the next local autopilot development task"
+        description = "Create the smallest safe next goal for the PlanPilot local repository from the current autopilot context. Preserve repository limits, avoid app source changes unless a task explicitly requires them, and keep the current goal completion gate intact."
+        priority = "fallback"
+        source = $backlogRelativePath
+        fallbackReason = $reason
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
+        $description = "Prepare the smallest actionable development goal from the $priority backlog item for the current repository state: $title"
+        $candidate = [PSCustomObject][ordered]@{
+            title = $title
+            description = $description
+            priority = $priority
+            source = $backlogRelativePath
+        }
+
+        $usableCandidates += $candidate
+
+        if (Test-IsReadableBacklogText $title) {
+            $readableCandidates += $candidate
+        }
+    }
+
+    if ($readableCandidates.Count -gt 0) {
+        return @($readableCandidates)
+    }
+
+    if ($usableCandidates.Count -gt 0) {
+        $fallback = New-FallbackBacklogCandidate $readItemCount $filteredItemCount $readableCandidates.Count $usableCandidates.Count "the backlog items were usable but no clean, readable title was available for a generated goal title."
+        return @($fallback)
+    }
+
+    $fallbackReason = if ($readItemCount -eq 0) {
+        "the backlog priority sections did not contain bullet items."
+    } else {
+        "all backlog bullet items were empty, too short, or did not contain letters or numbers."
+    }
+
+    $fallbackCandidate = New-FallbackBacklogCandidate $readItemCount $filteredItemCount $readableCandidates.Count $usableCandidates.Count $fallbackReason
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
+        $candidates = @(Get-BacklogCandidates | Where-Object { $usedTitles -notcontains ([string]$_.title) })
+    } catch {
+        $message = $_.Exception.Message
+        $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $false 1 $message
+        Stop-Autopilot $steps "goal_candidate_generation_failed" $false 1 $preparedGoals $message
+    }
+
+    if ($candidates.Count -eq 0) {
+        $message = "No actionable next goal candidate was found in the backlog. Check backlog encoding, empty items, and completed or deferred sections."
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

## Test Result

# AI Dev Test Result

## 2026-06-28 20:50:40

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

[32m✓ built in 238ms[39m
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

## 2026-06-28 21:18:00

- Overall result: passed for T002 review-required script checks
- Current task: T002
- Mode: Non-destructive PowerShell verification only
- Target files checked:
  - scripts/ai-dev-autopilot.ps1
  - .ai-dev/test-result.md

### PowerShell parse check

- Command: PowerShell parser check for `scripts/ai-dev-autopilot.ps1`
- Status: passed
- Evidence: `Parse OK`

### Basic limit behavior

- Command: `powershell -ExecutionPolicy Bypass -File scripts/ai-dev-autopilot.ps1 -MaxGoals 0 -DryRun -Json`
- Status: passed as safe failure-condition check
- Exit code: 1
- Evidence:
  - `message`: `MaxGoals must be at least 1.`
  - `stoppedReason`: `max_goals_must_be_at_least_1`
  - `preparedGoals`: 0

### Current goal safety gate

- Command: `powershell -ExecutionPolicy Bypass -File scripts/ai-dev-autopilot.ps1 -DryRun -Json`
- Status: passed as safe failure-condition check
- Exit code: 1
- Evidence:
  - `stoppedReason`: `current_goal_not_completed`
  - `message`: `Current goal is not completed, so autopilot will not create the next goal. goalStatus=in_progress, currentTaskId=T002, openTaskCount=2`
  - `preparedGoals`: 0

### Backlog candidate fallback reason

- Command: loaded only the candidate-generation functions from `scripts/ai-dev-autopilot.ps1` and mocked `Get-Content` in the test scope; repository files were not modified.
- Status: passed
- Evidence for unusable backlog bullets:
  - fallback title: `Prepare the next local autopilot development task`
  - fallback reason includes `backlog=.ai-dev/backlog.md, readItemCount=2, filteredItemCount=2, usableItemCount=0, readableItemCount=0`
  - fallback reason explains: `all backlog bullet items were empty, too short, or did not contain letters or numbers.`
- Evidence for mojibake-looking but usable backlog title:
  - fallback title: `Prepare the next local autopilot development task`
  - fallback reason includes `backlog=.ai-dev/backlog.md, readItemCount=1, filteredItemCount=0, usableItemCount=1, readableItemCount=0`
  - fallback reason explains: `the backlog items were usable but no clean, readable title was available for a generated goal title.`
- Evidence for current real backlog:
  - generated readable candidate: `Codex CLI 완전 자동화 정책 문서화`
  - source: `.ai-dev/backlog.md`
  - priority: `P0`

### Existing single-goal flow

- Status: unchanged by this review fix
- Evidence: `scripts/ai-dev-auto-goal.ps1` was not modified. This review-required change only updates `scripts/ai-dev-autopilot.ps1`, so the existing single-goal script flow remains unchanged.

### npm run test

- Status: skipped
- Reason: `package.json` has no `test` script.


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