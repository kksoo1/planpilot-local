# Codex Review Result

## Run

- Started at: 2026-07-08 23:25:22
- Ended at: 2026-07-08 23:26:37
- Exit code: 0
- Review prompt: .ai-dev/review-prompt.md
- Review response: .ai-dev/review-response.json
- Command: codex exec <short wrapper pointing to .ai-dev/review-prompt.md>

## Output

```text
node.exe : OpenAI Codex v0.133.0
위치 C:\Users\SECUI\AppData\Roaming\npm\codex.ps1:24 문자:5
+     & "node$exe"  "$basedir/node_modules/@openai/codex/bin/codex.js"  ...
+     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (OpenAI Codex v0.133.0:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 
--------
workdir: D:\ai-apps\planpilot-local
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: medium
reasoning summaries: none
session id: 019f421e-81a7-7f43-a3af-b6473a5f2b9f
--------
user
Read and follow the full review prompt at this absolute file path: D:\ai-apps\planpilot-local\.a
i-dev\review-prompt.md
codex
지정된 리뷰 프롬프트 파일만 읽어서 지시 범위와 출력 형식을 먼저 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\review-prompt.md'" in D:\ai-apps\planpilot-local
 succeeded in 1361ms:
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
AI Dev Loop에 제한된 autopilot 모드를 추가해, 저장된 프로젝트 비전과 backlog, 현재 상태를 바탕으로 다음 개발 goal을 자동 생성하고 기존 실행 
흐름에 전달할 수 있게 한다.

## 배경
현재 AI Dev Loop는 사용자가 매번 목표 제목과 설명을 제공하는 goal 단위 실행에 가깝다. 반복 개발을 줄이려면 로컬 상태 파일을 기준으로 다음 작업을 제안하고 
실행 준비까지 이어 주는 자동화 진입점이 필요하다.

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
- Description: 최대 goal 수 제한, 상태 확인, 다음 goal 생성, 기존 실행 흐름 호출, 실패 사유 기록을 포함한 작은 autopilot 모드를 추가한다
.
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
- scripts/ai-dev-auto-goal.ps1: not modified, so the existing single-goal flow remains unchanged
.

### PowerShell parse check

- Command: PowerShell parser check for scripts/ai-dev-autopilot.ps1
- Status: passed
- Evidence: `parse: passed`

### Safe DryRun/Json MaxGoals limit check

- Command: `powershell -ExecutionPolicy Bypass -File scripts/ai-dev-autopilot.ps1 -MaxGoals 0 -D
ryRun -Json`
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

- Method: loaded only function definitions from scripts/ai-dev-autopilot.ps1 with PowerShell AST
, then used an in-process mocked backlog reader. No project files were created for this check.
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
- Result: the mojibake-looking Korean title was not passed as a real GoalTitle or GoalDescriptio
n; fallback was used instead.

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
- scripts/ai-dev-auto-goal.ps1: not modified; this revision only patched scripts/ai-dev-autopilo
t.ps1 and updated this verification record.
- Build/lint: not run for this review-required patch.

### PowerShell function check

- Method: parsed scripts/ai-dev-autopilot.ps1 with PowerShell AST, loaded only function definiti
ons in-process, and evaluated backlog title candidate handling without creating project files.
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
    - result: mixed CJK ideographs plus Hangul mojibake-looking title is not used directly as a 
real goal title.


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

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니
다.

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
+        $previousReason = if (Test-HasValue $state.stopReason) { [string]$state.stopReason } el
se { "" }
+        $previousRepeatedFailureCount = 0
+
+        if (Test-HasValue $state.repeatedFailureCount) {
+            $previousRepeatedFailureCount = [int]$state.repeatedFailureCount
+        }
+
+        $nextRepeatedFailureCount = if ($previousReason -eq $StoppedReason) { $previousRepeated
FailureCount + 1 } else { 1 }
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
+    $openTasks = @($tasks | Where-Object { @("pending", "in_progress", "review_required", "fail
ed", "blocked") -contains ([string]$_.status) })
+    $goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { "" 
}
+    $currentTaskId = if (Test-HasValue $state.currentTaskId) { [string]$state.currentTaskId } e
lseif (Test-HasValue $queue.currentTaskId) { [string]$queue.currentTaskId } else { "" }
+
+    return [PSCustomObject][ordered]@{
+        passed = ($goalStatus -eq "completed" -and -not (Test-HasValue $currentTaskId) -and $op
enTasks.Count -eq 0)
+        goalTitle = if (Test-HasValue $queue.goalTitle) { [string]$queue.goalTitle } else { "" 
}
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
+    if ($trimmed.Length -le 80 -and $trimmed -match '[\u4E00-\u9FFF]' -and $trimmed -match '[\u
AC00-\uD7A3]') {
+        return "mixed_cjk_ideographs_and_hangul_in_short_title"
+    }
+
+    $mojibakePattern = '([\u00C2\u00C3\u00E2\u00EC\u00ED\u00EB][\u0080-\u00BF\u00A0-\u00FF]{1,}
)|(\uC392[\uAC00-\uD7A3])|(\u6FE1\u63F4|\u5A9B\u5AC4|\u8ADB)'
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
+    $description = "Prepare the smallest actionable development goal from the $Priority backlog
 item for the current repository state: $Title"
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
+    $suspicion = if (Test-HasValue $SuspiciousTitleReason) { $SuspiciousTitleReason } else { "n
one" }
+    $reason = "No clean backlog candidate could be generated from file content. backlog=$backlo
gRelativePath, readItemCount=$ReadItemCount, filteredItemCount=$FilteredItemCount, usableItemCou
nt=$UsableItemCount, readableItemCount=$ReadableItemCount, suspiciousTitleReason=$suspicion. Fal
lback was used because $Why"
+
+    return [PSCustomObject][ordered]@{
+        title = "Prepare the next local autopilot development task"
+        description = "Create the smallest safe next goal for the PlanPilot local repository fr
om the current autopilot context. Preserve repository limits, avoid app source changes unless a 
task explicitly requires them, and keep the current goal completion gate intact."
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
+            $usableCandidates += New-UnreadableBacklogCandidate $title $priority $suspiciousTit
leReason
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
+        $fallbackWhy = "the backlog items were usable but no clean, readable title was availabl
e for a generated goal title."
+        $fallback = New-FallbackBacklogCandidate $readItemCount $filteredItemCount $readableCan
didates.Count $usableCandidates.Count $fallbackWhy $joinedSuspiciousTitleReasons
+        return @($fallback)
+    }
+
+    $fallbackReason = if ($readItemCount -eq 0) {
+        "the backlog priority sections did not contain bullet items."
+    } else {
+        "all backlog bullet items were empty, too short, or did not contain letters or numbers.
"
+    }
+
+    $fallbackCandidate = New-FallbackBacklogCandidate $readItemCount $filteredItemCount $readab
leCandidates.Count $usableCandidates.Count $fallbackReason $joinedSuspiciousTitleReasons
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { T
est-HasValue $_ })
+
+        if ($normalizedFiles.Count -gt 0) {
+            $arguments += "-CommitFiles"
+            $arguments += ($normalizedFiles -join ",")
+        }
+    }
+
+    $output = & powershell -ExecutionPolicy Bypass -File $autoGoalPath @arguments 2>&1 | Out-St
ring
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
+$steps += New-StepResult 1 "validate-input" $false $false 0 "Autopilot input validation complet
ed. MaxGoals=$MaxGoals, MaxTasks=$MaxTasks, MaxSteps=$MaxSteps"
+
+for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
+    try {
+        $gate = Get-CurrentGoalGate
+    } catch {
+        $message = $_.Exception.Message
+        $steps += New-StepResult ($steps.Count + 1) "current-goal-gate" $false $false 1 $messag
e
+        Stop-Autopilot $steps "current_goal_gate_failed" $false 1 $preparedGoals $message
+    }
+
+    if (-not $gate.passed) {
+        $message = "Current goal is not completed, so autopilot will not create the next goal. 
goalStatus=$($gate.goalStatus), currentTaskId=$($gate.currentTaskId), openTaskCount=$($gate.open
TaskCount)"
+        $steps += New-StepResult ($steps.Count + 1) "current-goal-gate" $false $true 1 $message
+        Stop-Autopilot $steps "current_goal_not_completed" $false 1 $preparedGoals $message
+    }
+
+    $steps += New-StepResult ($steps.Count + 1) "current-goal-gate" $false $false 0 "Current go
al is completed. Previous goal: $($gate.goalTitle)"
+
+    try {
+        $excludedTitles = @($usedTitles)
+
+        if (Test-HasValue $gate.goalTitle) {
+            $excludedTitles += [string]$gate.goalTitle
+        }
+
+        $candidates = @(Get-BacklogCandidates | Where-Object { $excludedTitles -notcontains ([s
tring]$_.title) })
+    } catch {
+        $message = $_.Exception.Message
+        $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $false 1 $
message
+        Stop-Autopilot $steps "goal_candidate_generation_failed" $false 1 $preparedGoals $messa
ge
+    }
+
+    if ($candidates.Count -eq 0) {
+        $message = "No actionable next goal candidate was found in the backlog after excluding 
the current or already prepared goal titles. Check backlog encoding, empty items, completed or d
eferred sections, and duplicate backlog titles."
+        $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $true 1 $m
essage
+        Stop-Autopilot $steps "goal_candidate_not_found" $false 1 $preparedGoals $message
+    }
+
+    $candidate = $candidates | Select-Object -First 1
+    $usedTitles += [string]$candidate.title
+    $candidateMessage = "Next goal candidate generated from $($candidate.source) priority $($ca
ndidate.priority)."
+
+    if (Test-HasValue $candidate.fallbackReason) {
+        $candidateMessage = "$candidateMessage $($candidate.fallbackReason)"
+    }
+
+    $steps += New-StepResult ($steps.Count + 1) "generate-goal-candidate" $false $false 0 $cand
idateMessage $candidate
+
+    try {
+        $autoGoalStep = Invoke-AutoGoal $candidate ($steps.Count + 1)
+    } catch {
+        $message = "Auto-goal failed before completion: $($_.Exception.Message)"
+        $steps += New-StepResult ($steps.Count + 1) "auto-goal" $false $false 1 $message $candi
date
+        Stop-Autopilot $steps "auto_goal_failed" $false 1 $preparedGoals $message
+    }
+
+    $steps += $autoGoalStep
+
+    if ($autoGoalStep.exitCode -ne 0) {
+        $failureMessage = "Auto-goal failed with exit code $($autoGoalStep.exitCode): $($autoGo
alStep.message)"
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

codex
프롬프트의 diff만으로도 1차 리뷰는 가능하지만, `MaxGoals` 반복이 기존 실행 흐름과 맞물리는지 확인하려면 기존 `scripts/ai-dev-auto-goal.p
s1`의 호출 의미를 확인해야 합니다. 앱 소스가 아니라 자동화 스크립트 범위라서 해당 파일만 읽겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-goal.ps1'" in D:\ai-apps\planpilot-local
 succeeded in 1580ms:
param(
    [AllowEmptyString()]
    [string]$GoalTitle,
    [AllowEmptyString()]
    [string]$GoalDescription,
    [int]$MaxTasks = 1,
    [int]$MaxSteps = 20,
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowRun,
    [switch]$AllowCodex,
    [switch]$AllowReviewCodex,
    [switch]$AllowCommit,
    [switch]$AllowDirty,
    [string[]]$CommitFiles,
    [string]$ResultPath = ".ai-dev/codex-result.md"
)

. "$PSScriptRoot\ai-dev-env.ps1"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
$codeFence = '```'
$goalRelativePath = ".ai-dev/goal.md"
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$promptRelativePath = ".ai-dev/current-task-prompt.md"
$planningPromptRelativePath = ".ai-dev/auto-goal-planning-prompt.md"
$legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"
$aiDevOperationalRoot = ".ai-dev/"
$script:autoGoalCanWriteResultFile = $true
$script:autoGoalCanCleanTempArtifacts = $true

function Resolve-RepoPath {
    param([string]$Path)

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return $Path
    }

    return Join-Path $repoRoot $Path
}

function ConvertTo-RepoRelativePath {
    param([string]$Path)

    $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $Path))
    $rootWithSeparator = $repoRoot.TrimEnd("\") + "\"

    if ($fullPath.StartsWith($rootWithSeparator, [System.StringComparison]::OrdinalIgnoreCase)) 
{
        return $fullPath.Substring($rootWithSeparator.Length).Replace("\", "/")
    }

    return $fullPath.Replace("\", "/")
}

function Test-HasValue {
    param([object]$Value)

    if ($null -eq $Value) {
        return $false
    }

    if ($Value -is [string]) {
        return -not [string]::IsNullOrWhiteSpace($Value)
    }

    return $true
}

function New-StepResult {
    param(
        [int]$Step,
        [string]$Name,
        [string]$Command,
        [bool]$Executed,
        [bool]$Skipped,
        [int]$ExitCode,
        [string]$Message
    )

    return [PSCustomObject][ordered]@{
        step = $Step
        name = $Name
        command = $Command
        executed = $Executed
        skipped = $Skipped
        exitCode = $ExitCode
        message = $Message
    }
}

function New-AutoGoalResult {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    return [PSCustomObject][ordered]@{
        steps = @($Steps)
        stoppedReason = $StoppedReason
        completed = $Completed
        exitCode = $ExitCode
        plan = $script:autoGoalPlanPreview
        goalPath = $goalRelativePath
        queuePath = $queueRelativePath
        statePath = $stateRelativePath
        promptPath = $promptRelativePath
        resultPath = (ConvertTo-RepoRelativePath $ResultPath)
    }
}

function Write-AutoGoalResult {
    param([object]$Result)

    if ($Json) {
        $Result | ConvertTo-Json -Depth 30
        return
    }

    foreach ($step in @($Result.steps)) {
        Write-Host "Step $($step.step): $($step.name)"
        Write-Host "  Command: $($step.command)"
        Write-Host "  Executed: $($step.executed)"
        Write-Host "  Skipped: $($step.skipped)"
        Write-Host "  Exit code: $($step.exitCode)"
        Write-Host "  Message: $($step.message)"
    }

    if ($null -ne $Result.plan) {
        Write-Host "Plan preview:"
        Write-Host "  Goal title: $($Result.plan.queue.goalTitle)"
        Write-Host "  Current task id: $($Result.plan.queue.currentTaskId)"

        foreach ($task in @($Result.plan.queue.tasks)) {
            Write-Host "  Task $($task.id): $($task.title)"
            Write-Host "    Type: $($task.type)"
            Write-Host "    Status: $($task.status)"
            Write-Host "    Priority: $($task.priority)"
            Write-Host "    Likely files: $((@($task.filesLikelyToChange) -join ', '))"
            Write-Host "    Verification: $((@($task.verification) -join ' / '))"
        }
    }

    Write-Host "Stopped reason: $($Result.stoppedReason)"
    Write-Host "Completed: $($Result.completed)"
    Write-Host "Exit code: $($Result.exitCode)"
}

function Save-AutoGoalResultFile {
    param(
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    $result = New-AutoGoalResult $script:steps $StoppedReason $Completed $ExitCode
    $stepLines = @()

    foreach ($step in @($result.steps)) {
        $stepLines += "- Step $($step.step) $($step.name): exitCode=$($step.exitCode), executed=
$($step.executed), skipped=$($step.skipped)"
        if (Test-HasValue $step.message) {
            $stepLines += "  - Message: $($step.message)"
        }
    }

    $content = @"
# Codex Auto Goal Final Result

## Summary

- Stopped reason: $($result.stoppedReason)
- Completed: $($result.completed)
- Exit code: $($result.exitCode)
- Result path: $($result.resultPath)

## Steps

$($stepLines -join "`r`n")
"@

    [System.IO.File]::WriteAllText($resolvedResultPath, $content, $utf8WithBom)
}

function Clear-AutoGoalTempArtifacts {
    if (-not $script:autoGoalCanCleanTempArtifacts) {
        return
    }

    $currentResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ResultPath))

    foreach ($relativePath in @($planningPromptRelativePath, $legacyAutoGoalResultRelativePath))
 {
        $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $relativePath))

        if (-not $fullPath.StartsWith($repoRoot.TrimEnd("\") + "\", [System.StringComparison]::O
rdinalIgnoreCase)) {
            continue
        }

        if ($fullPath.Equals($currentResultPath, [System.StringComparison]::OrdinalIgnoreCase)) 
{
            continue
        }

        try {
            if ([System.IO.File]::Exists($fullPath)) {
                [System.IO.File]::Delete($fullPath)
            }
        } catch {
            Write-Warning "Failed to clean auto-goal temp artifact: $relativePath"
        }
    }
}

function Stop-AutoGoal {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    Clear-AutoGoalTempArtifacts
    if (-not $Completed -or $ExitCode -ne 0) {
        if ($script:autoGoalCanWriteResultFile) {
            Save-AutoGoalResultFile $StoppedReason $false $ExitCode
        }
    }
    Write-AutoGoalResult (New-AutoGoalResult $Steps $StoppedReason $Completed $ExitCode)
    exit $ExitCode
}

function Get-InputPreview {
    param([string]$RawInput)

    if ($null -eq $RawInput) {
        return "<null>"
    }

    $normalized = $RawInput.Replace("`r", " ").Replace("`n", " ").Trim()

    if ($normalized.Length -eq 0) {
        return "<empty>"
    }

    if ($normalized.Length -le 500) {
        return $normalized
    }

    return $normalized.Substring(0, 500)
}

function Invoke-GitStatusLines {
    param(
        [string[]]$Arguments,
        [string]$CommandText,
        [int]$FailureStep = 2,
        [string]$FailureName = "dirty-worktree-gate"
    )

    $statusOutput = & git @Arguments 2>&1

    if ($LASTEXITCODE -ne 0) {
        $script:steps += New-StepResult $FailureStep $FailureName $CommandText $false $false 1 "
git status failed: $($statusOutput -join "`n")"
        Stop-AutoGoal $script:steps "git_status_failed" $false 1
    }

    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
}

function Get-GitStatusLines {
    param(
        [int]$FailureStep = 2,
        [string]$FailureName = "dirty-worktree-gate"
    )

    return @(Invoke-GitStatusLines -Arguments @("status", "--short") -CommandText "git status --
short" -FailureStep $FailureStep -FailureName $FailureName)
}

function Get-GitPorcelainStatusLines {
    param(
        [int]$FailureStep = 2,
        [string]$FailureName = "dirty-worktree-gate"
    )

    return @(Invoke-GitStatusLines -Arguments @("status", "--porcelain") -CommandText "git statu
s --porcelain" -FailureStep $FailureStep -FailureName $FailureName)
}

function Convert-ToChangedPath {
    param([string]$ChangeLine)

    if ([string]::IsNullOrWhiteSpace($ChangeLine)) {
        return @()
    }

    $pathText = $ChangeLine

    if ($ChangeLine.Length -ge 4 -and $ChangeLine.Substring(2, 1) -eq " ") {
        $pathText = $ChangeLine.Substring(3)
    }

    if ($pathText.Contains(" -> ")) {
        return @($pathText -split " -> " | Where-Object { Test-HasValue $_ })
    }

    return @($pathText)
}

function ConvertTo-NormalizedChangedPath {
    param([string]$RelativePath)

    if (-not (Test-HasValue $RelativePath)) {
        return $null
    }

    return $RelativePath.Trim().Trim('"').Replace('\', '/')
}

function Test-IsAiDevOperationalPath {
    param([string]$RelativePath)

    $normalizedRelativePath = ConvertTo-NormalizedChangedPath $RelativePath
    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::
OrdinalIgnoreCase)
}

function Get-PlannedAutoGoalOutputPaths {
    return @(
        $ResultPath,
        $goalRelativePath,
        $queueRelativePath,
        $stateRelativePath,
        $promptRelativePath,
        $planningPromptRelativePath,
        ".ai-dev/codex-result.md",
        $legacyAutoGoalResultRelativePath
    ) |
        Where-Object { Test-HasValue $_ } |
        ForEach-Object { ConvertTo-NormalizedChangedPath (ConvertTo-RepoRelativePath $_) } |
        Select-Object -Unique
}

function Invoke-BaselineOutputConflictGate {
    param(
        [string[]]$BaselineDirtyPaths,
        [string[]]$PlannedOutputPaths
    )

    $conflictingPaths = @(
        $BaselineDirtyPaths |
            Where-Object { $PlannedOutputPaths -contains $_ } |
            Select-Object -Unique
    )

    if ($conflictingPaths.Count -eq 0) {
        return
    }

    $script:autoGoalCanWriteResultFile = $false
    $script:autoGoalCanCleanTempArtifacts = $false
    $message = "Baseline dirty paths conflict with planned auto-goal output paths. Auto-goal sto
pped before writing or deleting protected output files.`nConflicting paths:`n$($conflictingPaths
 -join "`n")"
    $script:steps += New-StepResult 2 "baseline-output-conflict-gate" "compare baseline dirty pa
ths with planned auto-goal outputs" $true $false 1 $message
    Stop-AutoGoal $script:steps "baseline_output_conflict" $false 1
}

function Invoke-FinalAutoGoalChangeGate {
    param(
        [int]$StepNumber
    )

    Clear-AutoGoalTempArtifacts

    $statusLines = @(Get-GitStatusLines $StepNumber "final-change-gate")
    $command = "cleanup auto-goal temp artifacts, git status --short"
    $baselineDirtyPaths = @($script:autoGoalBaselineDirtyPaths)
    $baselineDirtyCount = $baselineDirtyPaths.Count
    $finalDirtyCount = $statusLines.Count

    if ($statusLines.Count -eq 0 -and $baselineDirtyCount -gt 0) {
        $message = "Final clean verification failed: baseline dirty paths from auto-goal start a
re no longer visible in git status. They may have been committed or otherwise swallowed, so auto
-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: 
$finalDirtyCount`nFinal .ai-dev meta commit created: skipped (baseline dirty disappeared).`nBase
line dirty paths:`n$($baselineDirtyPaths -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 
$message
        Stop-AutoGoal $script:steps "final_baseline_dirty_disappeared" $false 1
    }

    if ($statusLines.Count -eq 0) {
        $message = "Baseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCou
nt`nFinal .ai-dev meta commit created: skipped (no final changes).`nFinal clean verification: gi
t status --short returned no changes."
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 0 
$message
        return
    }

    $changedPaths = @(
        $statusLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            Where-Object { Test-HasValue $_ } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Select-Object -Unique
    )
    $baselineRemainingPaths = @($changedPaths | Where-Object { $baselineDirtyPaths -contains $_ 
})
    $baselineMissingPaths = @($baselineDirtyPaths | Where-Object { $changedPaths -notcontains $_
 })
    $nonAiDevPaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
    $newAiDevPaths = @($changedPaths | Where-Object { (Test-IsAiDevOperationalPath $_) -and ($ba
selineDirtyPaths -notcontains $_) })

    if ($baselineMissingPaths.Count -gt 0) {
        $message = "Final clean verification failed: baseline dirty paths from auto-goal start d
isappeared before completion. They may have been committed or otherwise swallowed, so auto-goal 
will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $final
DirtyCount`nFinal .ai-dev meta commit created: skipped (baseline dirty disappeared).`nMissing ba
seline dirty paths:`n$($baselineMissingPaths -join "`n")`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 
$message
        Stop-AutoGoal $script:steps "final_baseline_dirty_disappeared" $false 1
    }

    if ($baselineRemainingPaths.Count -gt 0) {
        $message = "Final clean verification failed: baseline dirty files remain, so auto-goal w
ill not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalD
irtyCount`nFinal .ai-dev meta commit created: skipped (baseline dirty remains).`nRemaining basel
ine dirty paths:`n$($baselineRemainingPaths -join "`n")`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 
$message
        Stop-AutoGoal $script:steps "final_baseline_dirty_remains" $false 1
    }

    if ($nonAiDevPaths.Count -gt 0) {
        $message = "Final clean verification failed: non-.ai-dev changes remain, so auto-goal wi
ll not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDi
rtyCount`nFinal .ai-dev meta commit created: skipped (non-.ai-dev dirty remains).`n$($statusLine
s -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 
$message
        Stop-AutoGoal $script:steps "final_non_ai_dev_changes" $false 1
    }

    if ($newAiDevPaths.Count -eq 0) {
        $message = "Final clean verification failed: dirty paths remain, but none are new .ai-de
v operational changes that auto-goal may commit.`nBaseline dirty count: $baselineDirtyCount`nFin
al dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (no eligible .ai-de
v changes).`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 
$message
        Stop-AutoGoal $script:steps "final_no_eligible_meta_changes" $false 1
    }

    if (-not $AllowCommit) {
        $message = "Final clean verification failed: only new .ai-dev operational changes remain
, but -AllowCommit is required to create the final meta commit.`nBaseline dirty count: $baseline
DirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (-Al
lowCommit missing).`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 
$message
        Stop-AutoGoal $script:steps "final_ai_dev_changes_require_commit" $false 1
    }

    $addArguments = @("add", "--") + $newAiDevPaths
    $addOutput = & git @addArguments 2>&1 | Out-String
    $addExitCode = $LASTEXITCODE

    if ($addExitCode -ne 0) {
        $message = "auto-goal 최종 .ai-dev 메타 변경 git add 실패. exit code: $addExitCode`n$addOutput"
        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-d
ev files>" $true $false 1 $message
        Stop-AutoGoal $script:steps "final_meta_add_failed" $false 1
    }

    $metaCommitMessage = "chore(ai-dev): record final auto-goal state"
    $commitArguments = @("commit", "-m", $metaCommitMessage, "--") + $newAiDevPaths
    $commitOutput = & git @commitArguments 2>&1 | Out-String
    $commitExitCode = $LASTEXITCODE

    if ($commitExitCode -ne 0) {
        $message = "auto-goal 최종 .ai-dev 메타 커밋 실패. exit code: $commitExitCode`n$commitOutput"
        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m '$metaCom
mitMessage' -- <final .ai-dev files>" $true $false 1 $message
        Stop-AutoGoal $script:steps "final_meta_commit_failed" $false 1
    }

    $remainingStatus = @(Get-GitStatusLines $StepNumber "final-change-gate")

    if ($remainingStatus.Count -gt 0) {
        $message = "Final clean verification failed: changes remain after the final .ai-dev meta
 commit, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFin
al dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: yes`nFinal clean verificati
on: failed; git status --short still reports $($remainingStatus.Count) change(s).`n$($remainingS
tatus -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" "git status --short" $tr
ue $false 1 $message
        Stop-AutoGoal $script:steps "final_worktree_dirty" $false 1
    }

    $message = ($commitOutput.Trim(), "Baseline dirty count: $baselineDirtyCount", "Final dirty 
count: $finalDirtyCount", "Final .ai-dev meta commit created: yes", "Final clean verification: g
it status --short returned no changes.") -join "`n"
    $script:steps += New-StepResult $StepNumber "final-change-gate" "git add/commit final .ai-de
v operational changes, git status --short" $true $false 0 $message
}

function Invoke-CompletedCleanVerification {
    param([int]$StepNumber)

    $remainingStatus = @(Get-GitStatusLines $StepNumber "completed-clean-gate")

    if ($remainingStatus.Count -gt 0) {
        $message = "Completed clean verification failed: git status --short still reports $($rem
ainingStatus.Count) change(s) after all result/state files were written and the final gate ran.`
n$($remainingStatus -join "`n")"
        $script:steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" 
$true $false 1 $message
        Stop-AutoGoal $script:steps "completed_worktree_dirty" $false 1
    }

    $script:steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $tru
e $false 0 "Completed clean verification passed: git status --short returned no changes after al
l result/state files were written."
}

function Invoke-FinalPreparedResultGate {
    param(
        [int]$StepNumber,
        [int]$CleanGateStepNumber,
        [string]$StoppedReason
    )

    Clear-AutoGoalTempArtifacts

    $command = "write final result, git add/commit final .ai-dev operational changes, git status
 --short"
    $baselineDirtyPaths = @($script:autoGoalBaselineDirtyPaths)
    $baselineDirtyCount = $baselineDirtyPaths.Count
    $preparedGateStepsWritten = $false

    Save-AutoGoalResultFile $StoppedReason $true 0

    $statusLines = @(Get-GitStatusLines $StepNumber "final-change-gate")
    $finalDirtyCount = $statusLines.Count

    if ($statusLines.Count -eq 0 -and $baselineDirtyCount -gt 0) {
        $message = "Final clean verification failed: baseline dirty paths from auto-goal start a
re no longer visible in git status. They may have been committed or otherwise swallowed, so auto
-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: 
$finalDirtyCount`nFinal .ai-dev meta commit created: skipped (baseline dirty disappeared).`nBase
line dirty paths:`n$($baselineDirtyPaths -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 
$message
        Stop-AutoGoal $script:steps "final_baseline_dirty_disappeared" $false 1
    }

    if ($statusLines.Count -eq 0) {
        $message = "Baseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCou
nt before writing final gate entries.`nFinal .ai-dev meta commit created: pending if final gate 
entries dirty the result file.`nFinal clean verification: git status --short will be required af
ter the final result file is written."
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 0 
$message
        $script:steps += New-StepResult $CleanGateStepNumber "completed-clean-gate" "git status 
--short" $true $false 0 "Completed clean verification passed: git status --short returned no cha
nges after the final result file was written."
        Save-AutoGoalResultFile $StoppedReason $true 0
        $preparedGateStepsWritten = $true
        $statusLines = @(Get-GitStatusLines $StepNumber "final-change-gate")
        $finalDirtyCount = $statusLines.Count

        if ($statusLines.Count -eq 0) {
            return
        }
    }

    $changedPaths = @(
        $statusLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            Where-Object { Test-HasValue $_ } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Select-Object -Unique
    )
    $baselineRemainingPaths = @($changedPaths | Where-Object { $baselineDirtyPaths -contains $_ 
})
    $baselineMissingPaths = @($baselineDirtyPaths | Where-Object { $changedPaths -notcontains $_
 })
    $nonAiDevPaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
    $newAiDevPaths = @($changedPaths | Where-Object { (Test-IsAiDevOperationalPath $_) -and ($ba
selineDirtyPaths -notcontains $_) })

    if ($baselineMissingPaths.Count -gt 0) {
        $message = "Final clean verification failed: baseline dirty paths from auto-goal start d
isappeared before completion. They may have been committed or otherwise swallowed, so auto-goal 
will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $final
DirtyCount`nFinal .ai-dev meta commit created: skipped (baseline dirty disappeared).`nMissing ba
seline dirty paths:`n$($baselineMissingPaths -join "`n")`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 
$message
        Stop-AutoGoal $script:steps "final_baseline_dirty_disappeared" $false 1
    }

    if ($baselineRemainingPaths.Count -gt 0) {
        $message = "Final clean verification failed: baseline dirty files remain, so auto-goal w
ill not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalD
irtyCount`nFinal .ai-dev meta commit created: skipped (baseline dirty remains).`nRemaining basel
ine dirty paths:`n$($baselineRemainingPaths -join "`n")`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 
$message
        Stop-AutoGoal $script:steps "final_baseline_dirty_remains" $false 1
    }

    if ($nonAiDevPaths.Count -gt 0) {
        $message = "Final clean verification failed: non-.ai-dev changes remain, so auto-goal wi
ll not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDi
rtyCount`nFinal .ai-dev meta commit created: skipped (non-.ai-dev dirty remains).`n$($statusLine
s -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 
$message
        Stop-AutoGoal $script:steps "final_non_ai_dev_changes" $false 1
    }

    if ($newAiDevPaths.Count -eq 0) {
        $message = "Final clean verification failed: dirty paths remain, but none are new .ai-de
v operational changes that auto-goal may commit.`nBaseline dirty count: $baselineDirtyCount`nFin
al dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (no eligible .ai-de
v changes).`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 
$message
        Stop-AutoGoal $script:steps "final_no_eligible_meta_changes" $false 1
    }

    if (-not $AllowCommit) {
        $message = "Final clean verification failed: only new .ai-dev operational changes remain
, but -AllowCommit is required to create the final meta commit.`nBaseline dirty count: $baseline
DirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (-Al
lowCommit missing).`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 
$message
        Stop-AutoGoal $script:steps "final_ai_dev_changes_require_commit" $false 1
    }

    if (-not $preparedGateStepsWritten) {
        $message = "Baseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCou
nt`nFinal .ai-dev meta commit created: pending; this final result file is written before that co
mmit and included in it.`nFinal .ai-dev paths to commit:`n$($newAiDevPaths -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 0 
$message
        $script:steps += New-StepResult $CleanGateStepNumber "completed-clean-gate" "git status 
--short" $true $false 0 "Completed clean verification is enforced immediately after the final .a
i-dev meta commit; completed=true is returned only if git status --short reports no changes."
        Save-AutoGoalResultFile $StoppedReason $true 0
    }

    $statusLines = @(Get-GitStatusLines $StepNumber "final-change-gate")
    $newAiDevPaths = @(
        $statusLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            Where-Object { Test-HasValue $_ } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Where-Object { (Test-IsAiDevOperationalPath $_) -and ($baselineDirtyPaths -notcontai
ns $_) } |
            Select-Object -Unique
    )

    if ($newAiDevPaths.Count -eq 0) {
        $message = "Final clean verification failed: no final .ai-dev operational paths were ava
ilable to commit after the final result file was written.`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 
$message
        Stop-AutoGoal $script:steps "final_no_eligible_meta_changes" $false 1
    }

    $addArguments = @("add", "--") + $newAiDevPaths
    $addOutput = & git @addArguments 2>&1 | Out-String
    $addExitCode = $LASTEXITCODE

    if ($addExitCode -ne 0) {
        $message = "auto-goal 최종 .ai-dev 메타 변경 git add 실패. exit code: $addExitCode`n$addOutput"
        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-d
ev files>" $true $false 1 $message
        Stop-AutoGoal $script:steps "final_meta_add_failed" $false 1
    }

    $metaCommitMessage = "chore(ai-dev): record final auto-goal state"
    $commitArguments = @("commit", "-m", $metaCommitMessage, "--") + $newAiDevPaths
    $commitOutput = & git @commitArguments 2>&1 | Out-String
    $commitExitCode = $LASTEXITCODE

    if ($commitExitCode -ne 0) {
        $message = "auto-goal 최종 .ai-dev 메타 커밋 실패. exit code: $commitExitCode`n$commitOutput"
        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m '$metaCom
mitMessage' -- <final .ai-dev files>" $true $false 1 $message
        Stop-AutoGoal $script:steps "final_meta_commit_failed" $false 1
    }

    $remainingStatus = @(Get-GitStatusLines $CleanGateStepNumber "completed-clean-gate")

    if ($remainingStatus.Count -gt 0) {
        $message = "Completed clean verification failed: changes remain after the final .ai-dev 
meta commit, so auto-goal will not report completed.`n$($remainingStatus -join "`n")"
        $script:steps += New-StepResult $CleanGateStepNumber "completed-clean-gate" "git status 
--short" $true $false 1 $message
        Stop-AutoGoal $script:steps "completed_worktree_dirty" $false 1
    }
}

function Complete-AutoGoal {
    param(
        [int]$PreFinalGateStepNumber,
        [int]$ResultStepNumber,
        [int]$PostFinalGateStepNumber,
        [int]$CleanGateStepNumber,
        [string]$StoppedReason
    )

    Invoke-FinalAutoGoalChangeGate $PreFinalGateStepNumber
    $script:steps += New-StepResult $ResultStepNumber "write-final-result" (ConvertTo-RepoRelati
vePath $ResultPath) $true $false 0 "Final success result file is written after the pre-result fi
nal change gate and before the final .ai-dev meta commit."
    Invoke-FinalPreparedResultGate $PostFinalGateStepNumber $CleanGateStepNumber $StoppedReason
    $script:autoGoalCanCleanTempArtifacts = $false
    Stop-AutoGoal $script:steps $StoppedReason $true 0
}

function Get-JsonObjectCandidates {
    param([string]$RawInput)

    $candidates = @()
    $seen = @{}

    for ($start = 0; $start -lt $RawInput.Length; $start++) {
        if ($RawInput[$start] -ne "{") {
            continue
        }

        $depth = 0
        $inString = $false
        $escaped = $false

        for ($index = $start; $index -lt $RawInput.Length; $index++) {
            $char = $RawInput[$index]

            if ($escaped) {
                $escaped = $false
                continue
            }

            if ($char -eq "\") {
                $escaped = $true
                continue
            }

            if ($char -eq '"') {
                $inString = -not $inString
                continue
            }

            if ($inString) {
                continue
            }

            if ($char -eq "{") {
                $depth++
                continue
            }

            if ($char -eq "}") {
                $depth--

                if ($depth -eq 0) {
                    $candidateText = $RawInput.Substring($start, $index - $start + 1).Trim()

                    if (-not $seen.ContainsKey($candidateText)) {
                        $seen[$candidateText] = $true
                        $candidates += [PSCustomObject]@{
                            Start = $start
                            Text = $candidateText
                            HasPlanShape = ($candidateText -match '"goalMarkdown"\s*:' -and $can
didateText -match '"queue"\s*:' -and $candidateText -match '"state"\s*:')
                        }
                    }

                    break
                }
            }
        }
    }

    return @($candidates | Sort-Object -Property @{ Expression = "HasPlanShape"; Descending = $t
rue }, @{ Expression = "Start"; Descending = $true } | ForEach-Object { $_.Text })
}

function Get-MissingFields {
    param(
        [object]$InputObject,
        [string[]]$RequiredFields
    )

    $missingFields = @()

    foreach ($field in $RequiredFields) {
        if (-not ($InputObject.PSObject.Properties.Name -contains $field)) {
            $missingFields += $field
        }
    }

    return $missingFields
}

function Get-QueueValidationErrors {
    param([object]$Queue)

    $errors = @()
    $requiredFields = @("goalTitle", "goalSource", "createdAt", "updatedAt", "currentTaskId", "t
asks")

    foreach ($field in @(Get-MissingFields $Queue $requiredFields)) {
        $errors += "queue missing field: $field"
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (-not (Test-HasValue $Queue.goalTitle)) {
        $errors += "queue.goalTitle must not be empty."
    }

    if ($Queue.goalSource -ne $goalRelativePath) {
        $errors += "queue.goalSource must be $goalRelativePath."
    }

    if ($Queue.tasks -isnot [System.Collections.IEnumerable] -or $Queue.tasks -is [string]) {
        $errors += "queue.tasks must be an array."
        return $errors
    }

    $tasks = @($Queue.tasks)

    if ($tasks.Count -lt 1) {
        $errors += "queue.tasks must contain at least one task."
        return $errors
    }

    if ($tasks.Count -gt 3) {
        $errors += "queue.tasks must contain no more than three tasks."
    }

    if ($Queue.currentTaskId -ne "T001") {
        $errors += "queue.currentTaskId must be T001."
    }

    $taskIds = @()

    foreach ($task in $tasks) {
        $taskRequiredFields = @("id", "title", "description", "type", "status", "priority", "dep
endsOn", "filesLikelyToChange", "verification", "commitMessage")
        $taskMissingFields = @(Get-MissingFields $task $taskRequiredFields)

        foreach ($field in $taskMissingFields) {
            $errors += "task missing field: $field"
        }

        if ($taskMissingFields.Count -gt 0) {
            continue
        }

        if (-not (Test-HasValue $task.id)) {
            $errors += "task.id must not be empty."
        } else {
            $taskIds += [string]$task.id
        }

        if (-not (Test-HasValue $task.title)) {
            $errors += "task.title must not be empty."
        }

        if (-not (Test-HasValue $task.description)) {
            $errors += "task.description must not be empty."
        }

        if (@("analysis", "implementation", "documentation", "verification") -notcontains $task.
type) {
            $errors += "invalid task.type: $($task.type)"
        }

        if (@("pending", "in_progress", "done", "blocked") -notcontains $task.status) {
            $errors += "invalid task.status: $($task.status)"
        }

        if (@("P0", "P1", "P2") -notcontains $task.priority) {
            $errors += "invalid task.priority: $($task.priority)"
        }

        if ($task.dependsOn -isnot [System.Collections.IEnumerable] -or $task.dependsOn -is [str
ing]) {
            $errors += "task.dependsOn must be an array: $($task.id)"
        }

        if ($task.filesLikelyToChange -isnot [System.Collections.IEnumerable] -or $task.filesLik
elyToChange -is [string]) {
            $errors += "task.filesLikelyToChange must be an array: $($task.id)"
        }

        if ($task.verification -isnot [System.Collections.IEnumerable] -or $task.verification -i
s [string]) {
            $errors += "task.verification must be an array: $($task.id)"
        }
    }

    if ((@($tasks | Where-Object { $_.status -eq "in_progress" })).Count -ne 1) {
        $errors += "queue.tasks must contain exactly one in_progress task."
    }

    if (-not (Test-HasValue $Queue.currentTaskId)) {
        $errors += "queue.currentTaskId must not be empty."
    } elseif ($taskIds -notcontains [string]$Queue.currentTaskId) {
        $errors += "queue.currentTaskId does not match a task: $($Queue.currentTaskId)"
    }

    $firstTask = $tasks | Where-Object { $_.id -eq "T001" } | Select-Object -First 1
    if ($null -eq $firstTask) {
        $errors += "queue.tasks must include T001."
    } elseif ($firstTask.status -ne "in_progress") {
        $errors += "T001 must be in_progress."
    }

    foreach ($laterTask in @($tasks | Where-Object { $_.id -ne "T001" })) {
        if ($laterTask.status -ne "pending") {
            $errors += "later tasks must be pending: $($laterTask.id)"
        }
    }

    return $errors
}

function Get-StateValidationErrors {
    param(
        [object]$State,
        [object]$Queue
    )

    $errors = @()
    $requiredFields = @("goalStatus", "currentTaskId", "currentLoop", "maxLoopsPerTask", "repeat
edFailureCount", "lastCommand", "lastCommandStatus", "lastErrorSummary", "lastReviewDecision", "
lastReviewSeverity", "lastCommitHash", "startedAt", "updatedAt", "stopReason")

    foreach ($field in @(Get-MissingFields $State $requiredFields)) {
        $errors += "state missing field: $field"
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (@("idle", "in_progress", "completed", "blocked") -notcontains $State.goalStatus) {
        $errors += "invalid state.goalStatus: $($State.goalStatus)"
    }

    if ($State.currentTaskId -ne $Queue.currentTaskId) {
        $errors += "state.currentTaskId must match queue.currentTaskId."
    }

    if ($State.currentTaskId -ne "T001") {
        $errors += "state.currentTaskId must be T001."
    }

    if (@("not_started", "passed", "failed", "blocked") -notcontains $State.lastCommandStatus) {
        $errors += "invalid state.lastCommandStatus: $($State.lastCommandStatus)"
    }

    if (@("not_started", "pass", "revise", "blocked") -notcontains $State.lastReviewDecision) {
        $errors += "invalid state.lastReviewDecision: $($State.lastReviewDecision)"
    }

    return $errors
}

function Get-AutoGoalValidationErrors {
    param([object]$Plan)

    $errors = @()

    foreach ($field in @(Get-MissingFields $Plan @("goalMarkdown", "queue", "state"))) {
        $errors += "plan missing field: $field"
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (-not (Test-HasValue $Plan.goalMarkdown)) {
        $errors += "goalMarkdown must not be empty."
    }

    $errors += @(Get-QueueValidationErrors $Plan.queue)
    $errors += @(Get-StateValidationErrors $Plan.state $Plan.queue)

    return $errors
}

function New-DryRunAutoGoalPlan {
    param(
        [string]$Title,
        [string]$Description
    )

    $now = (Get-Date).ToUniversalTime().ToString("o")
    $safeTitle = $Title.Trim()
    $safeDescription = $Description.Trim()

    $plan = [PSCustomObject][ordered]@{
        goalMarkdown = @"
# 목표

$safeTitle

## 배경

$safeDescription

## 성공 기준

- 입력한 목표에서 현재 작업을 준비한다.
- full auto-cycle 실행 전에 현재 작업 프롬프트가 생성된다.
- full auto-cycle은 명시적인 허용 옵션이 있을 때만 실행된다.

## 제약사항

- 서버 API, 로그인, 클라우드 동기화, npm install, 위험한 git 명령은 사용하지 않는다.
- 저장소 정책과 현재 작업 범위를 따른다.

## 범위 제외

- 패키지 변경
- DB 삭제 또는 초기화
- 광범위한 리팩터링

## 수동 검증

- DryRun 계획과 JSON 출력을 검토한다.
- 현재 작업 프롬프트 생성 여부를 확인한다.
- 필요한 경우 빌드와 검증은 별도로 실행한다.
"@
        queue = [PSCustomObject][ordered]@{
            goalTitle = $safeTitle
            goalSource = $goalRelativePath
            createdAt = $now
            updatedAt = $now
            currentTaskId = "T001"
            tasks = @(
                [PSCustomObject][ordered]@{
                    id = "T001"
                    title = $safeTitle
                    description = $safeDescription
                    type = "implementation"
                    status = "in_progress"
                    priority = "P0"
                    dependsOn = @()
                    filesLikelyToChange = @()
                    verification = @(
                        "변경 범위가 현재 목표와 일치하는지 확인한다.",
                        "필요한 경우 npm run build를 별도로 실행한다."
                    )
                    commitMessage = $null
                }
            )
        }
        state = [PSCustomObject][ordered]@{
            goalStatus = "in_progress"
            currentTaskId = "T001"
            currentLoop = 0
            maxLoopsPerTask = 2
            repeatedFailureCount = 0
            lastCommand = $null
            lastCommandStatus = "not_started"
            lastErrorSummary = $null
            lastReviewDecision = "not_started"
            lastReviewSeverity = $null
            lastCommitHash = $null
            startedAt = $now
            updatedAt = $now
            stopReason = $null
        }
    }

    return $plan
}

function ConvertFrom-CodexAutoGoalOutput {
    param([string]$RawInput)

    $validationFailures = @()

    foreach ($candidate in Get-JsonObjectCandidates $RawInput) {
        try {
            $parsed = $candidate | ConvertFrom-Json

            if ($null -eq $parsed -or $parsed -is [System.Array]) {
                continue
            }

            $validationErrors = @(Get-AutoGoalValidationErrors $parsed)

            if ($validationErrors.Count -gt 0) {
                $validationFailures += "Candidate validation failed: $($validationErrors -join '
; ')"
                continue
            }

            return [PSCustomObject]@{
                Parsed = $parsed
                JsonText = ($parsed | ConvertTo-Json -Depth 30)
            }
        } catch {
        }
    }

    if ($validationFailures.Count -gt 0) {
        throw "No valid auto-goal JSON object was found in Codex output. Validation errors: $($v
alidationFailures -join ' | ')"
    }

    throw "No valid auto-goal JSON object was found in Codex output."
}

function New-CodexAutoGoalPrompt {
    param(
        [string]$Title,
        [string]$Description
    )

    return @"
You are preparing local AI Dev Loop state files for the repository at $repoRoot.

Return exactly one JSON object and no markdown fences or commentary.

The user supplied this new goal:
Title: $Title
Description: $Description

Create a small, safe goal plan for this repository. The response object must have these fields:
- goalMarkdown: .ai-dev/goal.md에 작성할 마크다운 문자열입니다. "# 목표", "배경", "성공 기준", "제약사항", "범위 제외", "수동 검증
" 섹션을 한국어로 포함해야 합니다.
- queue: an object for .ai-dev/queue.json.
- state: an object for .ai-dev/state.json.

queue rules:
- goalTitle must equal the supplied title.
- goalSource must be ".ai-dev/goal.md".
- createdAt and updatedAt are required and must be ISO 8601 strings.
- currentTaskId must be "T001".
- tasks must contain one to three tasks.
- T001 must be status "in_progress"; later tasks, if any, must be "pending".
- each task must include id, title, description, type, status, priority, dependsOn, filesLikelyT
oChange, verification, commitMessage.
- type must be one of analysis, implementation, documentation, verification.
- priority must be P0, P1, or P2.
- dependsOn, filesLikelyToChange, and verification must be arrays.
- commitMessage must be null or a short English commit message.

state rules:
- goalStatus must be "in_progress".
- currentTaskId must be "T001".
- currentLoop must be 0.
- maxLoopsPerTask must be 2.
- repeatedFailureCount must be 0.
- lastCommand must be null.
- lastCommandStatus must be "not_started".
- lastErrorSummary must be null.
- lastReviewDecision must be "not_started".
- lastReviewSeverity must be null.
- lastCommitHash must be null.
- startedAt and updatedAt must be ISO 8601 strings.
- stopReason must be null.

Safety rules:
- Do not mention server APIs, login, cloud sync, npm install, git reset, git clean, git push, DB
 deletion, or broad rewrites as implementation steps.
- Prefer one small implementation task when the goal is small.
- Use Korean for user-facing task titles, descriptions, verification, and goalMarkdown.
"@
}

function New-CodexAutoGoalWrapperPrompt {
    param(
        [string]$PromptFilePath
    )

    return "Read and follow the full auto-goal planning prompt at this absolute file path: $Prom
ptFilePath"
}

function Invoke-CycleCommand {
    param(
        [int]$StepNumber,
        [string]$Name,
        [string]$Command,
        [string]$ScriptPath,
        [string[]]$Arguments
    )

    if ($DryRun) {
        $script:steps += New-StepResult $StepNumber $Name $Command $false $true 0 "DryRun: child
 script was not executed."
        return
    }

    $output = & powershell -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1 | Out-Strin
g
    $exitCode = $LASTEXITCODE
    $message = $output.Trim()

    if ([string]::IsNullOrWhiteSpace($message)) {
        $message = "completed"
    }

    $script:steps += New-StepResult $StepNumber $Name $Command $true $false $exitCode $message

    if ($exitCode -ne 0) {
        Stop-AutoGoal $script:steps "$Name`_failed" $false 1
    }
}

function Get-FullCycleArguments {
    $arguments = @("-MaxTasks", ([string]$MaxTasks), "-MaxSteps", ([string]$MaxSteps))

    if ($AllowCodex) {
        $arguments += "-AllowCodex"
    }

    if ($AllowReviewCodex) {
        $arguments += "-AllowReviewCodex"
    }

    if ($AllowCommit) {
        $arguments += "-AllowCommit"
    }

    # auto-goal writes goal/queue/state/current prompt/result files after the initial dirty gate
.
    # The downstream full cycle must tolerate those intended artifacts.
    $arguments += "-AllowDirty"

    if ($script:autoGoalBaselineDirtyPaths.Count -gt 0) {
        $arguments += "-ProtectedBaselineDirtyPaths"
        $arguments += ($script:autoGoalBaselineDirtyPaths -join ",")
    }

    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -n
ot [string]::IsNullOrWhiteSpace($_) })

        if ($normalizedFiles.Count -gt 0) {
            $arguments += "-CommitFiles"
            $arguments += ($normalizedFiles -join ",")
        }
    }

    return $arguments
}

function Get-CurrentGoalStatus {
    $statePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $stateRelativePath))

    try {
        $state = Get-Content -Raw -Encoding UTF8 -LiteralPath $statePath | ConvertFrom-Json
    } catch {
        throw "$stateRelativePath JSON 파싱에 실패했습니다: $($_.Exception.Message)"
    }

    if ($null -eq $state -or -not ($state.PSObject.Properties.Name -contains "goalStatus")) {
        throw "$stateRelativePath 파일에서 goalStatus를 찾을 수 없습니다."
    }

    return [string]$state.goalStatus
}

Set-Location $repoRoot

$script:steps = @()
$script:autoGoalPlanPreview = $null
$script:autoGoalBaselineStatusLines = @()
$script:autoGoalBaselineDirtyPaths = @()
$resolvedGoalPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $goalRelativePath))
$resolvedQueuePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $queueRelativePath))
$resolvedStatePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $stateRelativePath))
$resolvedPlanningPromptPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $planningPromptRel
ativePath))
$resolvedResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ResultPath))

if (-not (Test-HasValue $GoalTitle)) {
    $script:steps += New-StepResult 0 "validate-input" "check GoalTitle" $false $false 1 "GoalTi
tle must not be empty."
    Stop-AutoGoal $script:steps "invalid_goal_title" $false 1
}

if (-not (Test-HasValue $GoalDescription)) {
    $script:steps += New-StepResult 0 "validate-input" "check GoalDescription" $false $false 1 "
GoalDescription must not be empty."
    Stop-AutoGoal $script:steps "invalid_goal_description" $false 1
}

if ($MaxTasks -lt 1) {
    $script:steps += New-StepResult 0 "validate-input" "check MaxTasks" $false $false 1 "MaxTask
s must be at least 1."
    Stop-AutoGoal $script:steps "max_tasks_must_be_at_least_1" $false 1
}

if ($MaxSteps -lt 1) {
    $script:steps += New-StepResult 0 "validate-input" "check MaxSteps" $false $false 1 "MaxStep
s must be at least 1."
    Stop-AutoGoal $script:steps "max_steps_must_be_at_least_1" $false 1
}

$makePromptPath = Join-Path $PSScriptRoot "ai-dev-make-prompt.ps1"
$autoCycleFullPath = Join-Path $PSScriptRoot "ai-dev-auto-cycle-full.ps1"

foreach ($requiredScript in @($makePromptPath, $autoCycleFullPath)) {
    if (-not (Test-Path -LiteralPath $requiredScript -PathType Leaf)) {
        $script:steps += New-StepResult 0 "prepare" "check required scripts" $false $false 1 "Mi
ssing required script: $requiredScript"
        Stop-AutoGoal $script:steps "prepare_failed" $false 1
    }
}

$shouldRunFullCycle = [bool]($AllowRun -or $AllowCodex -or $AllowReviewCodex -or $AllowCommit)
$fullCycleArguments = @(Get-FullCycleArguments)
$fullCycleCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full
.ps1 $($fullCycleArguments -join ' ')".Trim()

$script:steps += New-StepResult 1 "validate-input" "check GoalTitle/GoalDescription" $false $fal
se 0 "Input validation completed: $GoalTitle"

if ($DryRun) {
    $script:autoGoalPlanPreview = New-DryRunAutoGoalPlan $GoalTitle.Trim() $GoalDescription.Trim
()
    $previewValidationErrors = @(Get-AutoGoalValidationErrors $script:autoGoalPlanPreview)

    if ($previewValidationErrors.Count -gt 0) {
        $script:steps += New-StepResult 2 "preview-plan" "local dry-run plan preview" $false $fa
lse 1 "DryRun preview plan validation failed: $($previewValidationErrors -join '; ')"
        Stop-AutoGoal $script:steps "dry_run_preview_invalid" $false 1
    }

    $plannedAutoGoalOutputPaths = @(Get-PlannedAutoGoalOutputPaths)
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --porcelain; compare bas
eline dirty paths with planned auto-goal outputs" $false $true 0 "DryRun: baseline dirty capture
, dirty worktree gate, and baseline output conflict gate were not executed. Would check planned 
output paths: $($plannedAutoGoalOutputPaths -join ', ')"
    $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $fals
e $true 0 "DryRun: Codex goal planning was not executed. Preview currentTaskId: T001, task: $Goa
lTitle"
    $script:steps += New-StepResult 4 "validate-generated-json" "goal/queue/state JSON validatio
n" $false $true 0 "DryRun: preview goal/queue/state plan passed local schema validation."
    $script:steps += New-StepResult 5 "write-state-files" "$goalRelativePath, $queueRelativePath
, $stateRelativePath" $false $true 0 "DryRun: state files were not written."
    $script:steps += New-StepResult 6 "make-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-prompt.ps1" $false $true 0 "DryRun: current-task-prompt.md was not generated."

    if ($shouldRunFullCycle) {
        $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleCommandText $false $true 0
 "DryRun: explicit run option is present, but full cycle was not executed. -AllowRun only invoke
s the full-cycle wrapper; implementation and review still require -AllowCodex and -AllowReviewCo
dex."
    } else {
        $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleCommandText $false $true 0
 "DryRun: full cycle requires -AllowRun or explicit execution options. -AllowRun only invokes th
e full-cycle wrapper; implementation and review still require -AllowCodex and -AllowReviewCodex.
"
    }

    Stop-AutoGoal $script:steps "dry_run" $false 0
}

$script:autoGoalBaselineStatusLines = @(Get-GitPorcelainStatusLines)
$script:autoGoalBaselineDirtyPaths = @(
    $script:autoGoalBaselineStatusLines |
        ForEach-Object { Convert-ToChangedPath $_ } |
        Where-Object { Test-HasValue $_ } |
        ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
        Select-Object -Unique
)
$plannedAutoGoalOutputPaths = @(Get-PlannedAutoGoalOutputPaths)
Invoke-BaselineOutputConflictGate $script:autoGoalBaselineDirtyPaths $plannedAutoGoalOutputPaths

$statusLines = @($script:autoGoalBaselineStatusLines)
$baselineDirtyCount = $script:autoGoalBaselineDirtyPaths.Count

if ($statusLines.Count -gt 0 -and -not $AllowDirty) {
    $dirtyText = ($statusLines -join "`n")
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --porcelain" $false $tru
e 1 "Baseline dirty count: $baselineDirtyCount`nWorktree is dirty. Use -AllowDirty only when thi
s is intentional.`n$dirtyText"
    Stop-AutoGoal $script:steps "dirty_worktree" $false 1
}

if ($statusLines.Count -gt 0) {
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --porcelain" $true $fals
e 0 "AllowDirty is set. Baseline dirty count: $baselineDirtyCount"
} else {
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --porcelain" $true $fals
e 0 "Baseline dirty count: 0. Worktree is clean."
}

$fullCycleArguments = @(Get-FullCycleArguments)
$fullCycleCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full
.ps1 $($fullCycleArguments -join ' ')".Trim()

$codexCommand = Get-Command codex -ErrorAction SilentlyContinue

if ($null -eq $codexCommand) {
    $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $fals
e $false 1 "Codex CLI was not found."
    Stop-AutoGoal $script:steps "codex_not_found" $false 1
}

$plannerPrompt = New-CodexAutoGoalPrompt $GoalTitle.Trim() $GoalDescription.Trim()
$codexPrompt = New-CodexAutoGoalWrapperPrompt $resolvedPlanningPromptPath
$commandText = "codex exec <short wrapper pointing to $planningPromptRelativePath>"
[System.IO.File]::WriteAllText($resolvedPlanningPromptPath, $plannerPrompt, $utf8WithBom)
$startedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$codexOutput = & codex exec $codexPrompt 2>&1 | Out-String
$codexExitCode = $LASTEXITCODE
$endedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$resultContent = @"
# Codex Auto Goal Result

## Run

- Started at: $startedAt
- Ended at: $endedAt
- Exit code: $codexExitCode
- Goal title: $($GoalTitle.Trim())
- Planning prompt: $planningPromptRelativePath
- Command: $commandText

## Output

${codeFence}text
$codexOutput
$codeFence
"@

[System.IO.File]::WriteAllText($resolvedResultPath, $resultContent, $utf8WithBom)

if ($codexExitCode -ne 0) {
    $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $true
 $false 1 "Codex goal planning failed. Result: $(ConvertTo-RepoRelativePath $ResultPath)"
    Stop-AutoGoal $script:steps "codex_plan_failed" $false 1
}

$script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $true $fa
lse 0 "Codex goal planning completed. Result: $(ConvertTo-RepoRelativePath $ResultPath)"

try {
    $autoGoalPlan = ConvertFrom-CodexAutoGoalOutput $codexOutput
} catch {
    $preview = Get-InputPreview $codexOutput
    $script:steps += New-StepResult 4 "validate-generated-json" "goal/queue/state JSON validatio
n" $false $false 1 "Codex plan JSON extraction failed: $($_.Exception.Message) Output preview: $
preview"
    Stop-AutoGoal $script:steps "generated_json_invalid" $false 1
}

$script:steps += New-StepResult 4 "validate-generated-json" "goal/queue/state JSON validation" $
false $false 0 "goalMarkdown, queue, and state JSON validation completed. currentTaskId: $($auto
GoalPlan.Parsed.queue.currentTaskId)"
$script:autoGoalPlanPreview = $autoGoalPlan.Parsed

$goalMarkdown = [string]$autoGoalPlan.Parsed.goalMarkdown
$queueJson = $autoGoalPlan.Parsed.queue | ConvertTo-Json -Depth 30
$stateJson = $autoGoalPlan.Parsed.state | ConvertTo-Json -Depth 30

[System.IO.File]::WriteAllText($resolvedGoalPath, $goalMarkdown, $utf8WithBom)
[System.IO.File]::WriteAllText($resolvedQueuePath, $queueJson, $utf8WithBom)
[System.IO.File]::WriteAllText($resolvedStatePath, $stateJson, $utf8WithBom)

$script:steps += New-StepResult 5 "write-state-files" "$goalRelativePath, $queueRelativePath, $s
tateRelativePath" $true $false 0 "New goal, queue, and state files were written."

Invoke-CycleCommand 6 "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-mak
e-prompt.ps1" $makePromptPath @()

if (-not $shouldRunFullCycle) {
    $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleCommandText $false $true 0 "Fu
ll cycle requires -AllowRun or explicit execution options. -AllowRun only invokes the full-cycle
 wrapper; implementation and review still require -AllowCodex and -AllowReviewCodex."
    Complete-AutoGoal 8 9 10 11 "prepared_without_full_cycle"
}

Invoke-CycleCommand 7 "auto-cycle-full" $fullCycleCommandText $autoCycleFullPath $fullCycleArgum
ents

try {
    $goalStatusAfterFullCycle = Get-CurrentGoalStatus
} catch {
    $script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $f
alse $false 1 $_.Exception.Message
    Stop-AutoGoal $script:steps "goal_status_verify_failed" $false 1
}

if ($goalStatusAfterFullCycle -ne "completed") {
    $script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $f
alse $true 1 "auto-cycle-full은 성공 종료했지만 goalStatus가 completed가 아닙니다: $goalStatusAfterFullCycle"
    Stop-AutoGoal $script:steps "auto_cycle_incomplete" $false 1
}

$script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false
 $false 0 "auto-cycle-full 성공 후 goalStatus completed 확인."

Complete-AutoGoal 9 10 11 12 "completed"


codex
기존 자동 goal 스크립트 확인 결과, `-AllowRun` 계열 옵션이 있으면 full cycle 완료 후 다음 반복으로 이어질 수 있는 구조입니다. 이제 backlog
 형식과 새 파서가 실제 상태 파일을 어떻게 해석하는지 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\backlog.md'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\state.json'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\queue.json'" in D:\ai-apps\planpilot-local
 succeeded in 2650ms:
{
    "goalTitle":  "AI Dev Loop Autopilot 모드 도입",
    "goalSource":  ".ai-dev/goal.md",
    "createdAt":  "2026-06-28T00:00:00+09:00",
    "updatedAt":  "2026-06-28T11:41:18.1442878+00:00",
    "currentTaskId":  "T002",
    "tasks":  [
                  {
                      "id":  "T001",
                      "title":  "기존 AI Dev Loop 자동화 흐름 분석",
                      "description":  "현재 `.ai-dev` 상태 파일, 실행 스크립트, goal 생성 흐름을 확인해 autopilot 진입
점을 어디에 둘지 결정한다.",
                      "type":  "analysis",
                      "status":  "done",
                      "priority":  "P0",
                      "dependsOn":  [

                                    ],
                      "filesLikelyToChange":  [
                                                  ".ai-dev/goal.md",
                                                  ".ai-dev/queue.json",
                                                  ".ai-dev/state.json"
                                              ],
                      "verification":  [
                                           "기존 실행 스크립트와 상태 파일의 역할을 확인한다.",
                                           "autopilot에서 재사용할 수 있는 입력과 출력 파일을 식별한다."
                                       ],
                      "commitMessage":  null,
                      "completedAt":  "2026-06-28T11:41:18.1442878+00:00",
                      "resultSummary":  "자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 구현 커밋 없음, 
저장된 리뷰 pass에서 자동 완료"
                  },
                  {
                      "id":  "T002",
                      "title":  "제한된 autopilot 실행 흐름 구현",
                      "description":  "최대 goal 수 제한, 상태 확인, 다음 goal 생성, 기존 실행 흐름 호출, 실패 사유 기록을 포
함한 작은 autopilot 모드를 추가한다.",
                      "type":  "implementation",
                      "status":  "in_progress",
                      "priority":  "P0",
                      "dependsOn":  [
                                        "T001"
                                    ],
                      "filesLikelyToChange":  [
                                                  ".ai-dev/goal.md",
                                                  ".ai-dev/queue.json",
                                                  ".ai-dev/state.json",
                                                  ".ai-dev/scripts"
                                              ],
                      "verification":  [
                                           "제한값이 없을 때 기본값으로 동작하는지 확인한다.",
                                           "goal 생성 실패 시 state 또는 log에 사유가 남는지 확인한다.",
                                           "기존 단일 goal 실행 흐름이 유지되는지 확인한다."
                                       ],
                      "commitMessage":  "Add AI dev loop autopilot mode"
                  },
                  {
                      "id":  "T003",
                      "title":  "사용법과 검증 기준 문서화",
                      "description":  "autopilot 모드 실행 방법, 제한값, 중단 조건, 수동 검증 절차를 문서나 템플릿에 정리한다."
,
                      "type":  "documentation",
                      "status":  "pending",
                      "priority":  "P1",
                      "dependsOn":  [
                                        "T002"
                                    ],
                      "filesLikelyToChange":  [
                                                  ".ai-dev/goal.md",
                                                  ".ai-dev/queue.json",
                                                  ".ai-dev/state.json",
                                                  ".ai-dev"
                                              ],
                      "verification":  [
                                           "문서에 실행 방법과 제한값 설명이 포함되어 있는지 확인한다.",
                                           "중단 조건과 확인할 상태 파일이 명확히 적혀 있는지 확인한다."
                                       ],
                      "commitMessage":  "Document autopilot mode usage"
                  }
              ]
}

 succeeded in 2776ms:
{
    "goalStatus":  "in_progress",
    "currentTaskId":  "T002",
    "currentLoop":  0,
    "maxLoopsPerTask":  2,
    "repeatedFailureCount":  0,
    "lastCommand":  "save-diff",
    "lastCommandStatus":  "passed",
    "lastErrorSummary":  "",
    "lastReviewDecision":  "revise",
    "lastReviewSeverity":  "low",
    "lastCommitHash":  null,
    "startedAt":  "2026-06-28T00:00:00+09:00",
    "updatedAt":  "2026-07-08T14:25:20.2468897+00:00",
    "stopReason":  null,
    "lastReviewNextStep":  "revise_with_codex",
    "lastReviewSummary":  "autopilot 흐름은 추가됐지만, 현재 backlog의 mojibake 항목을 여전히 정상 후보로 선택할 수 있고 tas
k 요구 수동 검증도 기\r\n록되지 않았습니다.",
    "lastReviewRequiredChanges":  [
                                      {
                                          "file":  "scripts/ai-dev-autopilot.ps1",
                                          "reason":  "현재 .ai-dev/backlog.md에는 깨진 한글 항목이 있고, Test
-IsReadableBacklogText는 U+FFFD 또는 연속 \r\n물음표만 거르기 때문에 \u0027full auto-cycle 濡쒓렇 援ъ“ 媛쒖꽑\u0027 같은
 mojibake 제목을 읽을 수 있는 후보로 통과시킬 수 있습니다. 그러면 다음 goal \r\ntitle/description이 손상되어 \u0027현재 상태와 back
log 기반 goal 생성\u0027 및 실패 추적 품질을 만족하지 못합니다.",
                                          "suggestion":  "backlog 후보 판별에서 mojibake 특유의 깨진 문자 패턴을
 더 엄격히 제외하거나, 후보 제목에 의심 패턴이 있으면 fallb\r\nack 후보를 사용하도록 수정하세요. 최소한 현재 backlog의 깨진 P1/P2 항목이 직접 go
al title로 전달되지 않는지 확인해야 합니다."
                                      },
                                      {
                                          "file":  ".ai-dev/test-result.md",
                                          "reason":  "Current Task의 Verification은 기본 MaxGoals 동작
, goal 생성 실패 기록, 기존 단일 goal 흐름 유지 확인을\r\n 요구하지만, 기록된 검증은 npm build/lint뿐이고 npm test는 스크립트 없음으로 s
kipped입니다.",
                                          "suggestion":  "autopilot DryRun/Json 또는 통제된 실패 케이스 실행
 결과를 수동 검증으로 기록해 제한값 인식, 실패 사유 state/\r\nlog 기록, auto-goal 기존 흐름 보존 여부를 확인하세요."
                                      }
                                  ]
}

 succeeded in 3016ms:
# PlanPilot Local AI 媛쒕컻 Backlog

??臾몄꽌??異뷀썑 AI Dev Loop?먯꽌 寃?좏븷 紐⑺몴 ?꾨낫瑜??곗꽑?쒖쐞蹂꾨줈 ?뺣━?쒕떎.

?꾩옱 ?④퀎?먯꽌??AI媛 ??紐⑸줉?먯꽌 ?ㅼ쓬 紐⑺몴瑜??먮룞 ?좏깮?섏? ?딅뒗?? ?ㅽ뻾????ぉ? ?ъ슜?먭? 寃?좏븳 ??`.ai-dev/goal.md`濡
???릿??

## ?꾩옱 吏꾪뻾 紐⑺몴

- AI Dev Loop Codex CLI ?꾩쟾 ?먮룞???꾩엯

## P0

- Codex CLI ?꾩쟾 ?먮룞???뺤콉 臾몄꽌??- Codex 援ы쁽 ?ㅽ뻾 ?ㅽ겕由쏀듃 異붽?
- Codex 由щ럭 ?ㅽ뻾 ?ㅽ겕由쏀듃 異붽?
- full auto-cycle 珥덉븞 異붽?
- ?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐
- MaxTasks 1 end-to-end 寃利?
## P1

- full auto-cycle 濡쒓렇 援ъ“ 媛쒖꽑
- package 蹂寃?媛먯? 硫붿떆吏 媛쒖꽑
- build/check ?ㅽ뙣 ??revise ?먮쫫 ?먮룞 ?덈궡
- Codex 由щ럭 JSON 異붿텧 ?ㅽ뙣 泥섎━ 蹂닿컯

## P2

- GitHub PR ?곕룞 寃??- Copilot CLI ?먮뒗 gh ?곕룞 ?ш???- ?κ린 ?ㅽ뻾 ?먮룞??紐⑤땲?곕쭅 ?뺤콉
- 蹂묐젹 task ?ㅽ뻾 媛?μ꽦 寃??
## ?좎떆 以묐떒??紐⑺몴

- PlanPilot Local ?낅Т 寃???꾪꽣 UX 媛쒖꽑

## ?꾨즺??紐⑺몴

- JSON 諛깆뾽 import 寃利?諛?誘몃━蹂닿린 湲곕뒫 異붽?
- AI Dev Loop ?댁쁺 ?덉쭏 媛쒖꽑 諛??먮룞??以鍮?- AI Dev Loop ?먮룞 ?ㅽ뻾 ?④퀎 ?꾩엯
- AI Dev Loop ?섎룞 由щ럭 釉뚮━吏 ?먮룞??- AI Dev Loop ?섎룞 ?먮룞??UX 媛쒖꽑

## 愿由??먯튃

- backlog ??ぉ? ?먮룞 ?ㅽ뻾???뺤젙??task媛 ?꾨땲??
- ?꾪뿕?섍굅??踰붿쐞媛 ????ぉ? 癒쇱? ?뺤콉 臾몄꽌??task濡?遺꾨━?쒕떎.
- ?꾩옱 goal怨?吏곸젒 愿?⑤릺吏 ?딆? ??ぉ? ?꾩쓽濡?援ы쁽?섏? ?딅뒗??
- ?꾨즺????ぉ? ?ㅽ뻾 寃곌낵? 臾몄꽌 ?곹깭瑜??뺤씤?????꾨즺 紐⑸줉?쇰줈 ?대룞?쒕떎.

codex
수정된 스크립트 자체는 task 범위에 맞습니다. 남은 통과 여부는 성공 기준의 “사용법 문서/템플릿 정리”가 실제로 반영됐는지에 달려 있어 `.ai-dev/README.m
d`의 관련 부분만 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -Litera
lPath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\README.md' -Pattern 'autopilot|MaxGoals|ai-dev-aut
opilot|자동' -Context 3,5" in D:\ai-apps\planpilot-local
 succeeded in 1704ms:

  .ai-dev\README.md:1:# PlanPilot Local AI 개발 입력 폴더
  .ai-dev\README.md:2:
> .ai-dev\README.md:3:이 폴더는 PlanPilot Local의 Level 5 AI 자동 개발 루프에서 목표와 후속 작업 후보를 관리하기 위한 기본 공간이다
.
  .ai-dev\README.md:4:
> .ai-dev\README.md:5:현재 단계에서는 사용자 입력 템플릿과 수동 AI Dev 루프 보조 스크립트를 제공한다. Codex CLI 완전 자동화 실행기는 다음 
목표에서 단계적으로 도입하며, 각 task
 전환 전에는 `goal.md`, `queue.json`, `state.json`을 확인한다.
  .ai-dev\README.md:6:
  .ai-dev\README.md:7:## 사람이 직접 관리하는 파일
  .ai-dev\README.md:8:
  .ai-dev\README.md:9:### `goal.md`
  .ai-dev\README.md:10:
> .ai-dev\README.md:11:현재 자동 개발 루프가 수행할 하나의 목표를 작성한다.
  .ai-dev\README.md:12:
  .ai-dev\README.md:13:- 목표는 결과 중심으로 작성한다.
  .ai-dev\README.md:14:- 완료 기준, 제약 조건, 범위 밖 항목, 수동 검증 방법을 함께 적는다.
  .ai-dev\README.md:15:- 한 번에 하나의 명확한 목표만 유지한다.
  .ai-dev\README.md:16:- 저장소의 `AGENTS.md`와 `docs/ai-dev-loop-policy.md`를 위반하는 목표는 실행하지 않는다.
  .ai-dev\README.md:19:
  .ai-dev\README.md:20:추후 검토할 목표 후보와 아이디어를 우선순위별로 기록한다.
  .ai-dev\README.md:21:
> .ai-dev\README.md:22:- backlog 항목은 자동 실행이 확정된 task가 아니다.
  .ai-dev\README.md:23:- 기본 흐름에서는 실행할 항목을 사용자가 검토한 뒤 `goal.md`로 옮긴다.
  .ai-dev\README.md:24:- 수동 `ai-dev-auto-goal.ps1` 흐름은 여전히 명시적인 `GoalTitle`과 `GoalDescription`을 
사용한다.
> .ai-dev\README.md:25:- 단, 현재 goal이 완료되었고 open task가 없을 때 `scripts/ai-dev-autopilot.ps1`는 제한된 범
위에서 `.ai-dev/backlog.md
`의 다음 goal 후보를 선택할 수 있다.
> .ai-dev\README.md:26:- autopilot은 `MaxGoals`, `MaxTasks`, `MaxSteps` 제한 안에서만 동작하며 무제한 백그라운드 데몬
이 아니다.
  .ai-dev\README.md:27:
  .ai-dev\README.md:28:## AI가 추후 생성하거나 수정할 파일
  .ai-dev\README.md:29:
> .ai-dev\README.md:30:실제 자동 개발 루프를 구현하는 단계에서는 AI가 다음 파일을 생성하거나 갱신할 수 있다.
  .ai-dev\README.md:31:
  .ai-dev\README.md:32:- `plan.md`
  .ai-dev\README.md:33:- `queue.json`
  .ai-dev\README.md:34:- `state.json`
  .ai-dev\README.md:35:- `test-result.md`
  .ai-dev\README.md:43:## 구조 예시 파일
  .ai-dev\README.md:44:
  .ai-dev\README.md:45:- `queue.example.json`: `goal.md`를 task 단위로 분해한 `queue.json` 구조 예시다.
> .ai-dev\README.md:46:- `state.example.json`: 자동 개발 루프의 현재 진행 상태를 기록할 `state.json` 구조 예시다.
  .ai-dev\README.md:47:
  .ai-dev\README.md:48:예시 파일은 실제 실행 상태가 아니며, 초기화 스크립트가 `queue.json`과 `state.json`을 만들 때 복사 원본으로 
사용한다.
  .ai-dev\README.md:49:
  .ai-dev\README.md:50:## UTF-8 콘솔 설정
  .ai-dev\README.md:51:
> .ai-dev\README.md:52:AI Dev PowerShell 스크립트의 UTF-8 콘솔 설정은 `scripts/ai-dev-env.ps1`에서 자동 처리한다. 
사용자가 매번 `chcp 65001`을 직
접 실행할 필요는 없다.
  .ai-dev\README.md:53:
  .ai-dev\README.md:54:기존에 한글이 깨진 `.ai-dev/*.md` 상태 파일은 필요한 경우 다음 명령으로 재초기화할 수 있다.
  .ai-dev\README.md:55:
  .ai-dev\README.md:56:```powershell
  .ai-dev\README.md:57:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-init.ps1 -Force
  .ai-dev\README.md:123:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps
1 -TaskId T001 -ResultS
ummary "분석 완료"
  .ai-dev\README.md:124:```
  .ai-dev\README.md:125:
> .ai-dev\README.md:126:다음 task로 자동 이동하지 않으려면 `-NoNext` 옵션을 사용한다.
  .ai-dev\README.md:127:
  .ai-dev\README.md:128:```powershell
  .ai-dev\README.md:129:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps
1 -NoNext
  .ai-dev\README.md:130:```
  .ai-dev\README.md:131:
  .ai-dev\README.md:207:
  .ai-dev\README.md:208:## 수동 GPT 리뷰 브리지
  .ai-dev\README.md:209:
> .ai-dev\README.md:210:GPT API 키가 없는 환경에서는 ChatGPT 웹 화면을 사용해 리뷰를 수동으로 진행한다. AI Dev Loop는 prompt
 생성과 저장 흐름만 돕고, ChatGPT
 웹 화면에 자동 접속하거나 GPT API를 직접 호출하지 않는다.
  .ai-dev\README.md:211:
  .ai-dev\README.md:212:기본 흐름:
  .ai-dev\README.md:213:
  .ai-dev\README.md:214:1. `ai-dev-make-review-prompt.ps1 -Strict`로 `.ai-dev/review-prompt.md`를 
생성한다.
  .ai-dev\README.md:215:2. `review-prompt.md` 내용을 클립보드에 복사한다.
  .ai-dev\README.md:239:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prom
pt.ps1 -GenerateIfMissi
ng -Strict
  .ai-dev\README.md:240:```
  .ai-dev\README.md:241:
> .ai-dev\README.md:242:자동화에서 결과만 읽고 싶으면 `-Json` 옵션을 사용한다.
  .ai-dev\README.md:243:
  .ai-dev\README.md:244:```powershell
  .ai-dev\README.md:245:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prom
pt.ps1 -Json
  .ai-dev\README.md:246:```
  .ai-dev\README.md:247:
  .ai-dev\README.md:310:
  .ai-dev\README.md:311:재수정 프롬프트 생성 스크립트는 Codex 실행, GPT API 호출, build/test 실행, git commit을 수행하지 
않는다.
  .ai-dev\README.md:312:
> .ai-dev\README.md:313:## task 단위 자동 커밋
  .ai-dev\README.md:314:
  .ai-dev\README.md:315:검증과 리뷰를 통과한 현재 변경사항을 task 단위로 커밋한다. 먼저 `-DryRun`으로 커밋 대상과 메시지를 확인하는 것을 권
장한다.
  .ai-dev\README.md:316:
  .ai-dev\README.md:317:```powershell
  .ai-dev\README.md:318:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -DryR
un
  .ai-dev\README.md:333:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -Allo
wWithoutPassedCheck -Al
lowWithoutPassedReview
  .ai-dev\README.md:334:```
  .ai-dev\README.md:335:
> .ai-dev\README.md:336:`-Files`를 지정하지 않으면 자동 커밋 스크립트는 기존처럼 `git add -A`로 현재 작업 트리의 모든 변경사항을 sta
ge한다. `-Files`를 지정하면 각 
파일이 존재하고 변경사항이 있는지 확인한 뒤 `git add -- <files>`로 지정 파일만 stage한다. 선택 파일 외에 이미 staged 된 파일이 있으면 안전을 
위해 중단한다.
  .ai-dev\README.md:337:
  .ai-dev\README.md:338:실행 전 예상하지 못한 사용자 변경이 없는지 반드시 확인한다. Codex 실행, GPT API 호출, build/test 실행은 
수행하지 않는다.
  .ai-dev\README.md:339:
  .ai-dev\README.md:340:## 실행 산출물 커밋 기준
  .ai-dev\README.md:341:
  .ai-dev\README.md:352:
  .ai-dev\README.md:353:세부 기준은 `docs/ai-dev-loop-policy.md`의 `.ai-dev` 실행 산출물 커밋/무시 정책을 따른다. 실제 
`.gitignore` 변경은 별도 tas
k에서 검토한다.
  .ai-dev\README.md:354:
> .ai-dev\README.md:355:## 자동 개발 루프 상태 요약
  .ai-dev\README.md:356:
  .ai-dev\README.md:357:현재 queue, state, git 변경사항, 테스트 결과, 리뷰 결과를 한 번에 확인한다.
  .ai-dev\README.md:358:
  .ai-dev\README.md:359:```powershell
  .ai-dev\README.md:360:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1
  .ai-dev\README.md:425:
  .ai-dev\README.md:426:`review-prompt.md`에는 diff, 테스트 결과, 로컬 경로, 민감 정보가 포함될 수 있다. ChatGPT에 붙여넣기
 전에 사용자가 공유 범위를 확인해야 한다
.
  .ai-dev\README.md:427:
> .ai-dev\README.md:428:## 자동 실행 단계 정책
  .ai-dev\README.md:429:
  .ai-dev\README.md:430:`ai-dev-auto-step.ps1`는 현재 상태를 보고 안전한 다음 한 단계만 실행하는 보조 스크립트로 도입할 예정이다. `
ai-dev-next.ps1`처럼 안내만 
하는 명령과 달리, 허용된 로컬 스크립트는 직접 실행할 수 있다.
  .ai-dev\README.md:431:
  .ai-dev\README.md:432:명령 선택 기준:
  .ai-dev\README.md:433:
  .ai-dev\README.md:434:| 상황 | 사용할 명령 | 이유 |
  .ai-dev\README.md:435:| --- | --- | --- |
  .ai-dev\README.md:436:| 현재 상태와 다음 행동을 한 화면에서 보고 싶을 때 | `scripts/ai-dev-manual-cycle.ps1` | 상태 
요약, 다음 action, 관련 파일 존재
 여부를 함께 보여주는 수동 운영 대시보드다. |
> .ai-dev\README.md:437:| 다음 action과 추천 명령만 확인하고 싶을 때 | `scripts/ai-dev-next.ps1` | 읽기/안내용 스크립트이
며 하위 명령을 자동 실행하지 않는다. |
> .ai-dev\README.md:438:| 안전한 다음 한 단계만 자동으로 진행하고 싶을 때 | `scripts/ai-dev-auto-step.ps1` | `next` 
판단 결과를 기반으로 허용된 로컬 스크립트
만 한 번 실행한다. |
  .ai-dev\README.md:439:| 여러 안전 단계를 제한 횟수 안에서 이어가고 싶을 때 | `scripts/ai-dev-auto-cycle.ps1` | auto
-step 반복용이며 사용자 개입 필요 상
태에서 중단한다. |
  .ai-dev\README.md:440:
  .ai-dev\README.md:441:```powershell
  .ai-dev\README.md:442:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1
  .ai-dev\README.md:443:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -D
ryRun
  .ai-dev\README.md:444:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -J
son
  .ai-dev\README.md:445:```
  .ai-dev\README.md:446:
> .ai-dev\README.md:447:검증, diff 저장, 리뷰 프롬프트 생성처럼 기본 자동 실행보다 한 단계 위험한 로컬 작업은 명시적 허용 옵션을 사용한다.
  .ai-dev\README.md:448:
  .ai-dev\README.md:449:```powershell
  .ai-dev\README.md:450:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -A
llowCheck
  .ai-dev\README.md:451:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -A
llowSaveDiff
  .ai-dev\README.md:452:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -A
llowReviewPrompt
  .ai-dev\README.md:453:```
  .ai-dev\README.md:454:
> .ai-dev\README.md:455:초기 auto-step 자동 실행 허용 후보:
  .ai-dev\README.md:456:
  .ai-dev\README.md:457:- `current-task-prompt.md`가 없을 때 `scripts/ai-dev-make-prompt.ps1`
  .ai-dev\README.md:458:- 명시적으로 안전한 옵션이 선택된 경우 `scripts/ai-dev-check.ps1`
  .ai-dev\README.md:459:- diff 저장이 필요한 경우 `scripts/ai-dev-save-diff.ps1`
  .ai-dev\README.md:460:- review prompt 생성이 필요한 경우 `scripts/ai-dev-make-review-prompt.ps1`
  .ai-dev\README.md:484:
  .ai-dev\README.md:485:첫 번째 명령으로 `review-prompt.md`를 클립보드에 복사한 뒤 ChatGPT 웹 화면에 붙여넣는다. ChatGPT가 
JSON 리뷰만 출력하면 그 JSON을 다
시 클립보드에 복사하고 두 번째 명령으로 저장한다.
  .ai-dev\README.md:486:
> .ai-dev\README.md:487:`ai-dev-auto-cycle.ps1`는 제한 횟수 안에서 auto-step을 반복하는 초기 자동화 스크립트다. 사용자 개입이
 필요한 action, 실패, 반복 위험,
 commit 필요 상태에서는 중단한다.
  .ai-dev\README.md:488:
  .ai-dev\README.md:489:```powershell
  .ai-dev\README.md:490:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1
  .ai-dev\README.md:491:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -
DryRun
  .ai-dev\README.md:492:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -
MaxSteps 3
  .ai-dev\README.md:514:
  .ai-dev\README.md:515:명령 역할 구분:
  .ai-dev\README.md:516:
> .ai-dev\README.md:517:- `ai-dev-next.ps1`: 현재 상태를 읽고 다음 추천 action과 명령만 출력한다. 자동 실행하지 않는다.
> .ai-dev\README.md:518:- `ai-dev-manual-cycle.ps1`: `status`와 `next`를 함께 보여주는 수동 운영 대시보드다. 자동 실
행하지 않는다.
> .ai-dev\README.md:519:- `ai-dev-auto-step.ps1`: `next` 판단 결과를 기반으로 안전한 action 한 단계만 자동 실행한다. 위
험 action은 실행하지 않고 안내 후 
중단한다.
  .ai-dev\README.md:520:- `ai-dev-auto-cycle.ps1`: 제한 횟수 안에서 auto-step을 반복한다. 사용자 개입 필요 action에서
 중단한다.
  .ai-dev\README.md:521:
> .ai-dev\README.md:522:auto-step과 auto-cycle은 Codex/GPT API 호출, git commit, git push를 자동 실행하지 않
는다.
  .ai-dev\README.md:523:
> .ai-dev\README.md:524:## 수동 자동화 UX 판단 순서
  .ai-dev\README.md:525:
> .ai-dev\README.md:526:GPT API 없이 수동 자동화 흐름을 운영할 때는 먼저 상태를 읽고, 그 다음 안전한 DryRun으로 다음 행동을 확인한다.
  .ai-dev\README.md:527:
  .ai-dev\README.md:528:```powershell
  .ai-dev\README.md:529:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1
  .ai-dev\README.md:530:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-next.ps1
  .ai-dev\README.md:531:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-manual-cycle.ps1
  .ai-dev\README.md:538:- `goal_completed`: 더 이상 실행할 task가 없으므로 새 goal 초기화가 필요하다.
  .ai-dev\README.md:539:- `ask_gpt_review`: `ai-dev-copy-review-prompt.ps1`와 `ai-dev-save-review
.ps1 -FromClipboard`를 사
용해 수동 리뷰 브리지로 진행한다.
  .ai-dev\README.md:540:- `revise`: `ai-dev-make-revise-prompt.ps1`로 재수정 프롬프트를 만든다.
> .ai-dev\README.md:541:- `blocked`: 사용자 판단이 필요하므로 자동 진행을 멈춘다.
> .ai-dev\README.md:542:- `commit`: 자동 실행하지 않고 커밋 조건과 대상 파일을 사람이 확인한다.
  .ai-dev\README.md:543:
  .ai-dev\README.md:544:`goal_completed` 상태에서 `auto-step`은 추가 작업을 실행하지 않고 현재 goal이 완료되었으며 더 실행할 
task가 없다고 안내한다. 추천 명령에는
 상태 확인용 `ai-dev-status.ps1`만 포함한다.
  .ai-dev\README.md:545:
  .ai-dev\README.md:546:`auto-cycle`이 `goal_completed`로 멈추면 텍스트 출력에서는 “목표 완료로 종료” 의미를 표시하고, JSON
 출력에서는 `completed: true
`, `stoppedReason: "goal_completed"`를 유지한다. 다음 목표를 시작하려면 `.ai-dev/goal.md`, `.ai-dev/queue.json`
, `.ai-dev/state.json`을
 새 목표 기준으로 초기화한다.
  .ai-dev\README.md:547:
  .ai-dev\README.md:549:
  .ai-dev\README.md:550:최종 검증 task에서는 PowerShell 문법 검증, `auto-step`/`auto-cycle` DryRun, `save-r
eview` 성공/실패 흐름 확인 결과를 
`test-result.md`에 남기는 것을 원칙으로 한다. 실행하지 않은 검증은 통과로 기록하지 않는다.
  .ai-dev\README.md:551:
> .ai-dev\README.md:552:## Codex CLI 완전 자동화 준비
  .ai-dev\README.md:553:
> .ai-dev\README.md:554:다음 자동화 단계에서는 Codex CLI를 구현자와 리뷰어로 사용한다. GPT API Key, Cline, Copilot CLI,
 `gh` 없이 Codex CLI만 사용한
다.
  .ai-dev\README.md:555:
  .ai-dev\README.md:556:현재 전제:
  .ai-dev\README.md:557:
  .ai-dev\README.md:558:- `codex-cli 0.133.0` 사용 가능
  .ai-dev\README.md:559:- `codex exec` 동작 확인 완료
  .ai-dev\README.md:569:- `scripts/ai-dev-run-review-codex.ps1`: `.ai-dev/review-prompt.md`를 Cod
ex CLI에 전달해 JSON 리뷰를 생성
하고 저장 흐름에 연결한다.
  .ai-dev\README.md:570:- `scripts/ai-dev-auto-cycle-full.ps1`: prompt 생성, Codex 구현, check, diff
 저장, Codex 리뷰, save-rev
iew, pass 시 commit/complete-task를 연결한다.
  .ai-dev\README.md:571:- `scripts/ai-dev-auto-goal.ps1`: 사용자가 `GoalTitle`과 `GoalDescription`만 입
력하면 goal/queue/state 생성
, current-task-prompt 생성, full auto-cycle 실행까지 이어지게 한다.
> .ai-dev\README.md:572:- `scripts/ai-dev-autopilot.ps1`: 완료된 현재 goal과 backlog를 기준으로 다음 goal 후보를
 고르고 `ai-dev-auto-goal.
ps1` 흐름에 전달한다.
  .ai-dev\README.md:573:
  .ai-dev\README.md:574:초기 안전 기준:
  .ai-dev\README.md:575:
  .ai-dev\README.md:576:- full cycle은 처음에 `MaxTasks 1` 중심으로 제한한다.
  .ai-dev\README.md:577:- Codex 구현 실행은 `AllowCodex`가 있을 때만 수행한다.
  .ai-dev\README.md:578:- Codex 리뷰 실행은 `AllowReviewCodex`가 있을 때만 수행한다.
  .ai-dev\README.md:579:- git commit은 `AllowCommit`이 있을 때만 수행한다.
  .ai-dev\README.md:580:- auto-goal에서 실제 full cycle 실행은 `AllowRun` 또는 명시적 실행 옵션이 있을 때만 수행한다.
> .ai-dev\README.md:581:- autopilot은 기본 `MaxGoals 1`로 제한하며, 현재 goal이 완료되지 않았거나 후보 생성에 실패하면 state
와 loop-log에 중단 사유를 기록한다
.
  .ai-dev\README.md:582:- git status가 dirty이면 Codex 구현 실행을 기본 중단한다.
> .ai-dev\README.md:583:- build/check 실패, package 파일 변경, 리뷰 decision이 `pass`가 아닌 경우 자동 커밋하지 않는다.
> .ai-dev\README.md:584:- `git reset`, `git clean`, `npm install`, `git push`는 자동 실행하지 않는다.
  .ai-dev\README.md:585:
> .ai-dev\README.md:586:자동화 로그와 결과 파일:
  .ai-dev\README.md:587:
  .ai-dev\README.md:588:- `.ai-dev/codex-result.md`: Codex 구현 실행 결과
  .ai-dev\README.md:589:- `.ai-dev/review-response.json`: Codex 리뷰 JSON 원문
  .ai-dev\README.md:590:- `.ai-dev/review.md`: 저장된 리뷰 요약
  .ai-dev\README.md:591:- `.ai-dev/test-result.md`: check/build 또는 수동 검증 요약
  .ai-dev\README.md:608:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1
  .ai-dev\README.md:609:```
  .ai-dev\README.md:610:
> .ai-dev\README.md:611:`current-task-prompt.md`가 없을 때 자동 생성까지 허용하려면 `-GeneratePromptIfMissing`을
 사용한다.
  .ai-dev\README.md:612:
  .ai-dev\README.md:613:```powershell
  .ai-dev\README.md:614:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -G
eneratePromptIfMissing
  .ai-dev\README.md:615:```
  .ai-dev\README.md:616:
> .ai-dev\README.md:617:자동화에서 결과만 읽고 싶으면 `-Json`을 함께 사용할 수 있다.
  .ai-dev\README.md:618:
  .ai-dev\README.md:619:```powershell
  .ai-dev\README.md:620:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -D
ryRun -Json
  .ai-dev\README.md:621:```
  .ai-dev\README.md:622:
  .ai-dev\README.md:644:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex
.ps1
  .ai-dev\README.md:645:```
  .ai-dev\README.md:646:
> .ai-dev\README.md:647:`review-prompt.md`가 없을 때 자동 생성까지 허용하려면 `-GenerateReviewPromptIfMissing`를
 사용한다.
  .ai-dev\README.md:648:
  .ai-dev\README.md:649:```powershell
  .ai-dev\README.md:650:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex
.ps1 -GenerateReviewPro
mptIfMissing
  .ai-dev\README.md:651:```
  .ai-dev\README.md:652:
  .ai-dev\README.md:656:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex
.ps1 -AllowDirty -SaveR
eview
  .ai-dev\README.md:657:```
  .ai-dev\README.md:658:
> .ai-dev\README.md:659:자동화에서 결과만 읽고 싶으면 `-Json`을 함께 사용할 수 있다.
  .ai-dev\README.md:660:
  .ai-dev\README.md:661:```powershell
  .ai-dev\README.md:662:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex
.ps1 -DryRun -Json
  .ai-dev\README.md:663:```
  .ai-dev\README.md:664:
  .ai-dev\README.md:667:- Codex 리뷰 실행 프롬프트에는 파일 수정 금지, git 명령 금지, build/test/lint 실행 금지, JSON 객체
만 출력하라는 안전 규칙을 추가한다.
  .ai-dev\README.md:668:- JSON 리뷰에는 `decision`, `severity`, `summary`, `required_changes`, `opti
onal_suggestions`, `nex
t_step` 필드가 필요하다.
  .ai-dev\README.md:669:- JSON 추출에 실패하면 출력 preview를 보여주고 종료 코드 1로 종료한다.
> .ai-dev\README.md:670:- `-AllowDirty`는 구현 변경사항을 리뷰해야 할 때만 사용한다. 사용자 변경과 자동화 산출물이 섞여 있으면 리뷰 결과와
 후속 저장 상태가 혼동될 수 있다.
  .ai-dev\README.md:671:- 이 스크립트는 git add, git commit, build/test/lint, GPT API 호출을 수행하지 않는다.
  .ai-dev\README.md:672:
  .ai-dev\README.md:673:### full auto-cycle 초안
  .ai-dev\README.md:674:
  .ai-dev\README.md:675:`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build ch
eck, diff 저장, strict re
view prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.
  .ai-dev\README.md:683:5. `ai-dev-make-review-prompt.ps1 -Strict`
  .ai-dev\README.md:684:6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`
  .ai-dev\README.md:685:7. 리뷰 게이트 확인: `state.lastCommandStatus`가 `passed`이고 `state.lastReviewDec
ision`이 `pass`여야 한다.
> .ai-dev\README.md:686:8. package 파일 변경 게이트 확인: `package.json` 또는 `package-lock.json` 변경이 있으면 자
동 커밋하지 않는다.
  .ai-dev\README.md:687:9. `-AllowCommit`이 있을 때만 `ai-dev-commit.ps1`을 실행한다. `-CommitFiles`가 있으면 
선택 파일만 커밋 대상으로 전달한다.
  .ai-dev\README.md:688:10. 커밋 결과 게이트 확인: `state.lastCommand`가 `commit`이고 `lastCommitHash`가 있어야 
한다.
  .ai-dev\README.md:689:11. 커밋 성공 후에만 `ai-dev-complete-task.ps1`을 실행한다.
  .ai-dev\README.md:690:12. `MaxTasks`가 1보다 크면 complete-task 성공 후 다음 task를 다시 읽고 같은 흐름을 반복한다.
  .ai-dev\README.md:691:
  .ai-dev\README.md:695:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.
ps1 -DryRun
  .ai-dev\README.md:696:```
  .ai-dev\README.md:697:
> .ai-dev\README.md:698:자동화 도구에서 결과만 파싱해야 하면 `-Json`을 함께 사용한다.
  .ai-dev\README.md:699:
  .ai-dev\README.md:700:```powershell
  .ai-dev\README.md:701:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.
ps1 -DryRun -Json
  .ai-dev\README.md:702:```
  .ai-dev\README.md:703:
  .ai-dev\README.md:725:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.
ps1 -AllowCodex -AllowR
eviewCodex -MaxTasks 1
  .ai-dev\README.md:726:```
  .ai-dev\README.md:727:
> .ai-dev\README.md:728:리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`을 
함께 지정한다. 커밋 메시지는 기본적으로 
현재 task의 `commitMessage`를 사용한다.
  .ai-dev\README.md:729:
  .ai-dev\README.md:730:```powershell
  .ai-dev\README.md:731:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.
ps1 -AllowCodex -AllowR
eviewCodex -AllowCommit -MaxTasks 1
  .ai-dev\README.md:732:```
  .ai-dev\README.md:733:
  .ai-dev\README.md:749:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.
ps1 -AllowCodex -AllowR
eviewCodex -AllowDirty -MaxTasks 1
  .ai-dev\README.md:750:```
  .ai-dev\README.md:751:
> .ai-dev\README.md:752:리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete
_task`가 아니면 자동 커밋과 comp
lete-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `pac
kage-lock.json` 변경이 감지되
면 `package_files_changed`로 중단한다. 커밋 스크립트가 변경사항 없음 등으로 실제 commit hash를 기록하지 못하면 `commit_not_confi
rmed`로 중단하고 complete-ta
sk를 실행하지 않는다.
  .ai-dev\README.md:753:
> .ai-dev\README.md:754:### 목표 입력 기반 자동 실행
  .ai-dev\README.md:755:
  .ai-dev\README.md:756:최종 목표는 사용자가 goal 파일과 queue 파일을 직접 편집하지 않고도 한 줄 명령으로 작은 앱 기능 task를 시작할 수 
있게 하는 것이다.
  .ai-dev\README.md:757:
  .ai-dev\README.md:758:먼저 DryRun으로 생성될 goal/task 계획과 실행 단계를 확인한다.
  .ai-dev\README.md:759:
  .ai-dev\README.md:761:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 
-GoalTitle "업무 검색 결과 하이
라이트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -DryRun
  .ai-dev\README.md:762:```
  .ai-dev\README.md:763:
> .ai-dev\README.md:764:자동화 도구에서 결과만 파싱해야 하면 `-Json`을 함께 사용한다. JSON 출력은 사람이 읽는 텍스트와 섞지 않는다.
  .ai-dev\README.md:765:DryRun JSON에는 `plan.goalMarkdown`, `plan.queue`, `plan.state` 미리보기가 포함되므
로 파일 작성 전에 생성될 goal/tas
k 계획을 검토할 수 있다.
  .ai-dev\README.md:766:
  .ai-dev\README.md:767:```powershell
  .ai-dev\README.md:768:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 
-GoalTitle "업무 검색 결과 하이
라이트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -DryRun -Json
  .ai-dev\README.md:769:```
  .ai-dev\README.md:774:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 
-GoalTitle "업무 검색 결과 하이
라이트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다."
  .ai-dev\README.md:775:```
  .ai-dev\README.md:776:
> .ai-dev\README.md:777:생성 후 full auto-cycle 래퍼 호출까지 이어가려면 `-AllowRun` 또는 `-AllowCodex`, `-Allow
ReviewCodex`, `-AllowCo
mmit` 같은 명시적 실행 옵션을 지정한다. `-AllowRun` 단독은 full-cycle 래퍼 호출만 허용하며 Codex 구현이나 Codex 리뷰 권한을 대신하지 않는
다. 실제 구현까지 허용하려면 `-Allo
wCodex`, 리뷰까지 허용하려면 `-AllowReviewCodex`, 자동 커밋과 task 완료까지 허용하려면 기존 full cycle과 동일하게 `-AllowCodex
 -AllowReviewCodex -All
owCommit`을 함께 지정한다.
  .ai-dev\README.md:778:
  .ai-dev\README.md:779:```powershell
  .ai-dev\README.md:780:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 
-GoalTitle "업무 검색 결과 하이
라이트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -AllowCodex -AllowReviewCodex
 -AllowCommit -MaxTasks
 1
  .ai-dev\README.md:781:```
  .ai-dev\README.md:782:
  .ai-dev\README.md:799:- 생성된 goal/queue/state JSON 파싱 또는 필드 검증에 실패하면 파일 작성과 full cycle 실행으로 넘어가
지 않는다.
  .ai-dev\README.md:800:- full cycle 호출은 `-AllowRun`, `-AllowCodex`, `-AllowReviewCodex`, `-Allo
wCommit` 중 하나가 있을 때만 수행
한다.
  .ai-dev\README.md:801:- `-AllowRun` 단독은 구현, 리뷰, 커밋을 수행한다는 의미가 아니다. 하위 full cycle은 여전히 `-AllowC
odex`, `-AllowReviewCod
ex`, `-AllowCommit` 권한에 따라 각 위험 단계를 허용하거나 중단한다.
> .ai-dev\README.md:802:- package 파일 변경, build/check 실패, 리뷰 `pass` 아님, dirty worktree 위험이 있으면 자동
 커밋하지 않는다.
  .ai-dev\README.md:803:- `git reset`, `git clean`, `npm install`, `git push`는 실행하지 않는다.
  .ai-dev\README.md:804:
> .ai-dev\README.md:805:### 제한된 autopilot 실행
  .ai-dev\README.md:806:
> .ai-dev\README.md:807:`ai-dev-autopilot.ps1`는 현재 goal이 완료되고 open task가 없는 상태인지 확인한 뒤 `.ai-dev/
backlog.md`에서 제한된 다음 go
al 후보를 하나 고르고, 기존 `ai-dev-auto-goal.ps1`에 전달한다. 기본값은 `MaxGoals 1`, `MaxTasks 1`, `MaxSteps 22`이며
 무한 반복하지 않는 제한 실행 흐름이다.
  .ai-dev\README.md:808:
  .ai-dev\README.md:809:먼저 DryRun으로 제한값과 중단 조건을 확인한다.
  .ai-dev\README.md:810:
  .ai-dev\README.md:811:```powershell
> .ai-dev\README.md:812:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-autopilot.ps1 
-DryRun
  .ai-dev\README.md:813:```
  .ai-dev\README.md:814:
  .ai-dev\README.md:815:JSON 출력이 필요하면 `-Json`을 함께 사용한다.
  .ai-dev\README.md:816:
  .ai-dev\README.md:817:```powershell
> .ai-dev\README.md:818:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-autopilot.ps1 
-DryRun -Json
  .ai-dev\README.md:819:```
  .ai-dev\README.md:820:
  .ai-dev\README.md:821:실제 다음 goal 준비까지 수행하려면 `-DryRun`을 제거한다. 이 모드는 goal/queue/state/current-ta
sk-prompt 생성까지만 진행하고 fu
ll cycle은 실행하지 않는다.
  .ai-dev\README.md:822:
  .ai-dev\README.md:823:```powershell
> .ai-dev\README.md:824:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-autopilot.ps1 
-MaxGoals 1
  .ai-dev\README.md:825:```
  .ai-dev\README.md:826:
  .ai-dev\README.md:827:후보 생성 이후 full cycle 래퍼까지 호출하려면 기존 실행 권한 옵션을 명시한다.
  .ai-dev\README.md:828:
  .ai-dev\README.md:829:```powershell
> .ai-dev\README.md:830:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-autopilot.ps1 
-AllowCodex -AllowRevie
wCodex -AllowCommit -MaxGoals 1 -MaxTasks 1
  .ai-dev\README.md:831:```
  .ai-dev\README.md:832:
  .ai-dev\README.md:833:중단 조건:
  .ai-dev\README.md:834:
  .ai-dev\README.md:835:- 현재 `state.json`과 `queue.json`이 완료된 goal 상태가 아니면 `current_goal_not_comp
leted`로 중단한다.
  .ai-dev\README.md:836:- backlog에서 사용할 수 있는 후보를 찾지 못하면 `goal_candidate_not_found`로 중단한다.
  .ai-dev\README.md:837:- `ai-dev-auto-goal.ps1`가 goal 생성, 검증, 실행 흐름에서 실패하면 `auto_goal_failed`로 
중단한다.
  .ai-dev\README.md:838:- build/lint/review 실패, 반복 revise loop, dirty worktree 안전 검사 실패처럼 하위 ful
l cycle 게이트가 실패하면 해당 실패
 사유를 읽을 수 있게 남기고 중단한다.
> .ai-dev\README.md:839:- `MaxGoals`, `MaxTasks`, `MaxSteps`가 1보다 작으면 입력 검증 실패로 중단한다.
  .ai-dev\README.md:840:
  .ai-dev\README.md:841:실패 시 DryRun이 아니면 `state.json`의 `lastCommand`, `lastCommandStatus`, `last
ErrorSummary`, `stopRea
son`, `repeatedFailureCount`, `updatedAt`을 갱신하고 `.ai-dev/loop-log.md`에 중단 사유를 남긴다. DryRun은 파일을 수
정하지 않고 예상 결과만 출력한다.
  .ai-dev\README.md:842:
  .ai-dev\README.md:843:## 운영 원칙
  .ai-dev\README.md:844:
> .ai-dev\README.md:845:- 저장소의 `AGENTS.md`, 사용자 지시, 보안 정책이 자동 개발 루프보다 우선한다.
  .ai-dev\README.md:846:- 한 번에 하나의 task만 수행한다.
  .ai-dev\README.md:847:- task 단위로 구현, 검증, 리뷰, 커밋한다.
  .ai-dev\README.md:848:- task 완료 기준은 build/lint 통과, 리뷰 pass, 구현 커밋, complete-task 수행, `.ai-dev`
 메타 커밋, 최종 git clean 상태
까지 확인된 경우로 한다.
  .ai-dev\README.md:849:- 현재 task 범위 밖 파일을 임의로 수정하지 않는다.
  .ai-dev\README.md:850:- 검증하지 않은 결과를 통과로 기록하지 않는다.
  .ai-dev\README.md:852:
  .ai-dev\README.md:853:## 다음 단계
  .ai-dev\README.md:854:
> .ai-dev\README.md:855:실제 자동 개발 루프 실행기와 상태 갱신 로직은 별도 정책 검토 후 추가한다.
  .ai-dev\README.md:856:
  .ai-dev\README.md:857:세부 기준은 `docs/ai-dev-loop-policy.md`를 따른다.



codex
{"decision":"pass","severity":"none","summary":"T002 요구사항에 맞게 제한된 autopilot 스크립트가 추가됐고, 실패 기록·기본
 제한값·기존 단일 goal 흐름 보존 검증도 기록되어 다음 단계로 진행 가능하다.","required_changes":[],"optional_suggestions":[{"
file":"scripts/ai-dev-autopilot.ps1","suggestion":"향후 backlog 파일 인코딩이 정상화되면 mojibake fallback 로직
의 필요 범위와 오탐 가능성을 별도 task에서 재검토할 수 있다."}],"scope_check":{"within_current_task":true,"scope_issues
":[]},"test_check":{"build_passed":true,"test_passed":true,"lint_passed":true,"issues":["package
.json에 test script가 없어 npm run test는 skipped였지만, 해당 사유와 PowerShell 기반 수동 검증 결과가 .ai-dev/test-res
ult.md에 기록되어 있다.","2026-07-08 review-required patch에서는 build/lint를 다시 실행하지 않았으나 변경 범위가 PowerShel
l 자동화 스크립트와 검증 기록에 한정되어 있고 AST/function 검증이 기록되어 있다."]},"next_step":"complete_task"}
tokens used
46,988
{"decision":"pass","severity":"none","summary":"T002 요구사항에 맞게 제한된 autopilot 스크립트가 추가됐고, 실패 기록·기본 제한값·기존 단일 goal 흐름 보존 검증도 기록되어 다음 단계로 진행 가능하다.","required_changes":[],"optional_suggestions":[{"file":"scripts/ai-dev-autopilot.ps1","suggestion":"향후 backlog 파일 인코딩이 정상화되면 mojibake fallback 로직의 필요 범위와 오탐 가능성을 별도 task에서 재검토할 수 있다."}],"scope_check":{"within_current_task":true,"scope_issues":[]},"test_check":{"build_passed":true,"test_passed":true,"lint_passed":true,"issues":["package.json에 test script가 없어 npm run test는 skipped였지만, 해당 사유와 PowerShell 기반 수동 검증 결과가 .ai-dev/test-result.md에 기록되어 있다.","2026-07-08 review-required patch에서는 build/lint를 다시 실행하지 않았으나 변경 범위가 PowerShell 자동화 스크립트와 검증 기록에 한정되어 있고 AST/function 검증이 기록되어 있다."]},"next_step":"complete_task"}

```