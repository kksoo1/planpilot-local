# Codex Review Result

## Run

- Started at: 2026-06-25 16:32:32
- Ended at: 2026-06-25 16:33:28
- Exit code: 0
- Review prompt: .ai-dev/review-prompt.md
- Review response: .ai-dev/review-response.json
- Command: codex exec <short wrapper pointing to .ai-dev/review-prompt.md>

## Output

```text
node.exe : OpenAI Codex v0.133.0
At C:\Users\SECUI\AppData\Roaming\npm\codex.ps1:24 char:5
+     & "node$exe"  "$basedir/node_modules/@openai/codex/bin/codex.js"  ...
+     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (OpenAI Codex v0.133.0:String) [], RemoteExce 
   ption
    + FullyQualifiedErrorId : NativeCommandError
 
--------
workdir: D:\ai-apps\planpilot-local
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: medium
reasoning summaries: none
session id: 019efdb1-de62-76b1-8b58-65a8d19953c9
--------
user
Read and follow the full review prompt at this absolute file path: D:\ai-apps\planpilot-lo
cal\.ai-dev\review-prompt.md
codex
`.ai-dev\review-prompt.md`의 지시를 읽고, 그 범위 안에서 코드 리뷰 방식으로 진행하겠습니다. 우선 해당 프롬프트만 확인합니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath .ai-dev\\review-prompt.md" in D:\ai-apps\planpilot-local
 succeeded in 1339ms:
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
AI Dev Loop 상태 출력에서 새 goal 또는 새 task가 `not_started` 상태일 때 이전 작업의 테스트 결과나 리뷰 응답 요약이 섞여 보이지 
않도록 개선한다.

## 배경
현재 자동 개발 루프 상태 표시에서 오래된 test-result 또는 review-response 요약이 현재 task의 `lastCommand`, `lastRe
viewDecision`, `currentTaskId`, goal 상태와 맞지 않게 노출될 수 있다. 이로 인해 새 작업이 시작되지 않았거나 초기 상태인데도 이전
 작업 결과가 현재 상태처럼 보이는 혼선이 생긴다.

## 성공 기준
- 현재 task가 `not_started` 또는 초기 상태일 때 이전 task의 리뷰/테스트 요약이 현재 결과처럼 표시되지 않는다.
- `currentTaskId`, goal 상태, `lastCommand`, `lastReviewDecision`과 맞지 않는 오래된 요약은 숨기거나 stale 
상태로 구분된다.
- 상태 출력 로직의 변경 범위가 작고 기존 자동 개발 루프 파일 구조를 유지한다.
- 관련 상태 표시 동작을 검증할 수 있는 최소 확인 절차가 정리된다.

## 제약사항
- 앱 기능 변경이 아니라 자동 개발 루프 운영 상태 표시 개선에만 집중한다.
- 기존 상태 파일 구조와 명명 규칙을 우선 사용한다.
- 불필요한 대규모 재작성이나 추상화는 피한다.
- 사용자 변경 사항은 되돌리지 않는다.

## 범위 제외
- React 앱의 사용자 기능 변경은 포함하지 않는다.
- IndexedDB 스키마 변경은 포함하지 않는다.
- 알림, 동기화, 계정 관련 기능은 포함하지 않는다.

## 수동 검증
- 새 goal 또는 새 task를 `not_started` 상태로 두고 상태 출력에서 이전 리뷰/테스트 요약이 현재 결과처럼 보이지 않는지 확인한다.
- 현재 task와 일치하는 최신 리뷰/테스트 요약은 정상적으로 표시되는지 확인한다.
- 오래된 요약을 stale로 표시하는 경우 현재 상태와 구분 가능한지 확인한다.

## Current Task

- Task ID: T001
- Title: 상태 출력의 오래된 요약 차단
- Description: ai-dev-status 출력 로직에서 현재 task와 goal 상태에 맞지 않는 이전 리뷰 또는 테스트 요약이 표시되지 않도록 작은 
범위로 개선한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- 새 task 초기 상태에서 이전 리뷰/테스트 요약이 현재 결과처럼 표시되지 않는지 확인한다.
- 현재 task와 일치하는 최신 요약은 정상 표시되는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-06-25 16:32:21

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

[32m✓ built in 230ms[39m
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

2026-06-25 16:32:28

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-status.ps1
```

## App Change Files

- scripts/ai-dev-status.ps1

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도
로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-status.ps1 | 114 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 94 insertions(+), 20 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-status.ps1 b/scripts/ai-dev-status.ps1
index 83046c6..ec23aa9 100644
--- a/scripts/ai-dev-status.ps1
+++ b/scripts/ai-dev-status.ps1
@@ -53,36 +53,77 @@ function Test-HasValue {
     return $true
 }
 
-function Get-LastLines {
+function Get-TestResultCurrentTaskId {
+    param(
+        [string[]]$Lines
+    )
+
+    $currentTaskLine = $Lines | Where-Object { $_ -match '^- Current task:\s*(.+)$' } | S
elect-Object -First 1
+
+    if ($currentTaskLine -match '^- Current task:\s*(.+)$') {
+        return $Matches[1].Trim()
+    }
+
+    return $null
+}
+
+function New-SummaryStatus {
+    param(
+        [string]$Status,
+        [string]$Reason,
+        [object]$Content
+    )
+
+    return [PSCustomObject]@{
+        status = $Status
+        reason = $Reason
+        content = $Content
+    }
+}
+
+function Get-TestResultSummary {
     param(
         [string]$Path,
-        [int]$Count = 30
+        [string]$CurrentTaskId,
+        [bool]$IsInitialState
     )
 
     if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
-        return "없음"
+        return New-SummaryStatus "missing" "test-result 파일이 없습니다." "없음"
     }
 
     try {
         $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)
 
         if ($lines.Count -eq 0) {
-            return "없음"
+            return New-SummaryStatus "missing" "test-result 파일이 비어 있습니다." "없음"
         }
 
-        return ($lines | Select-Object -Last $Count) -join "`r`n"
+        $resultTaskId = Get-TestResultCurrentTaskId $lines
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 test-result 요약을 숨겼습니다." 
"숨김"
+        }
+
+        if ((Test-HasValue $CurrentTaskId) -and (Test-HasValue $resultTaskId) -and $resul
tTaskId -ne $CurrentTaskId) {
+            return New-SummaryStatus "stale" "test-result의 task($resultTaskId)가 현재 task($
CurrentTaskId)와 다릅니다." "숨김"
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." (($lines | Select-Object -Last
 30) -join "`r`n")
     } catch {
-        return "읽기 실패: $($_.Exception.Message)"
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" "읽기 실패: $($_.Ex
ception.Message)"
     }
 }
 
 function Get-ReviewSummary {
     param(
-        [string]$Path
+        [string]$Path,
+        [string]$LastReviewDecision,
+        [bool]$IsInitialState
     )
 
     if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
-        return [PSCustomObject]@{
+        $missingSummary = [PSCustomObject]@{
             available = $false
             decision = $null
             severity = $null
@@ -90,6 +131,8 @@ function Get-ReviewSummary {
             summary = "없음"
             fallback = $null
         }
+
+        return New-SummaryStatus "missing" "review 파일이 없습니다." $missingSummary
     }
 
     try {
@@ -105,7 +148,7 @@ function Get-ReviewSummary {
         $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } 
else { $null }
         $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or 
(Test-HasValue $nextStep) -or (Test-HasValue $summary)
 
-        return [PSCustomObject]@{
+        $review = [PSCustomObject]@{
             available = $true
             decision = $decision
             severity = $severity
@@ -113,8 +156,22 @@ function Get-ReviewSummary {
             summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
             fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object 
-Last 30) -join "`r`n") }
         }
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." $revi
ew
+        }
+
+        if ((Test-HasValue $LastReviewDecision) -and $LastReviewDecision -ne "not_started
" -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
+            return New-SummaryStatus "stale" "review decision($decision)이 state lastRevie
wDecision($LastReviewDecision)와 다릅니다." $review
+        }
+
+        if (-not (Test-HasValue $LastReviewDecision) -or $LastReviewDecision -eq "not_sta
rted") {
+            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 
요약을 숨겼습니다." $review
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." $review
     } catch {
-        return [PSCustomObject]@{
+        $errorSummary = [PSCustomObject]@{
             available = $true
             decision = $null
             severity = $null
@@ -122,6 +179,8 @@ function Get-ReviewSummary {
             summary = "읽기 실패: $($_.Exception.Message)"
             fallback = $null
         }
+
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" $errorSummary
     }
 }
 
@@ -182,6 +241,17 @@ $taskCounts = [ordered]@{
     skipped = @($tasks | Where-Object { $_.status -eq "skipped" }).Count
 }
 
+$currentTaskStatus = if ($null -ne $currentTask) { [string]$currentTask.status } else { $
null }
+$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastCom
mandStatus } else { $null }
+$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastR
eviewDecision } else { $null }
+$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { $
null }
+$initialTaskStatuses = @("not_started", "pending")
+$isTaskInitialState = ($initialTaskStatuses -contains $currentTaskStatus) -or ($goalStatu
s -eq "not_started")
+$isTestResultInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $state.lastCommand) -and ($lastCommandStatus -eq "not_started" -
or -not (Test-HasValue $lastCommandStatus)))
+$isReviewInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $lastReviewDecision) -or $lastReviewDecision -eq "not_started")
+
 $gitStatus = "unavailable"
 $gitChangedFilesCount = $null
 $gitStatusLines = @()
@@ -202,8 +272,8 @@ try {
     $gitStatus = "unavailable"
 }
 
-$testResultSummary = Get-LastLines $testResultPath 30
-$reviewSummary = Get-ReviewSummary $reviewPath
+$testResultSummary = Get-TestResultSummary $testResultPath $currentTaskId $isTestResultIn
itialState
+$reviewSummary = Get-ReviewSummary $reviewPath $lastReviewDecision $isReviewInitialState
 
 $statusObject = [ordered]@{
     goalTitle = if (Test-HasValue $queue.goalTitle) { $queue.goalTitle } else { "없음" }
@@ -256,14 +326,18 @@ Write-Host "Git status: $($statusObject.git.status)"
 Write-Host "Git changed files count: $($statusObject.git.changedFilesCount)"
 Write-Host ""
 Write-Host "Test result summary:"
-Write-Host $statusObject.testResultSummary
+Write-Host "  Status: $($testResultSummary.status)"
+Write-Host "  Reason: $($testResultSummary.reason)"
+Write-Host $testResultSummary.content
 Write-Host ""
 Write-Host "Review summary:"
-Write-Host "  Decision: $($reviewSummary.decision)"
-Write-Host "  Severity: $($reviewSummary.severity)"
-Write-Host "  Next step: $($reviewSummary.nextStep)"
-Write-Host "  Summary: $($reviewSummary.summary)"
-
-if (Test-HasValue $reviewSummary.fallback) {
-    Write-Host $reviewSummary.fallback
+Write-Host "  Status: $($reviewSummary.status)"
+Write-Host "  Reason: $($reviewSummary.reason)"
+Write-Host "  Decision: $($reviewSummary.content.decision)"
+Write-Host "  Severity: $($reviewSummary.content.severity)"
+Write-Host "  Next step: $($reviewSummary.content.nextStep)"
+Write-Host "  Summary: $($reviewSummary.content.summary)"
+
+if ($reviewSummary.status -eq "current" -and (Test-HasValue $reviewSummary.content.fallba
ck)) {
+    Write-Host $reviewSummary.content.fallback
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

codex
프롬프트에 diff가 포함되어 있지만, 실제 파일 상태 기준으로 `scripts/ai-dev-status.ps1`의 변경부를 확인해 리뷰 판단을 보강하겠습니다. 
git 명령과 빌드/테스트 실행은 프로젝트 규칙상 새로 실행하지 않습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath scripts\\ai-dev-status.ps1" in D:\ai-apps\planpilot-local
 succeeded in 1329ms:
param(
    [switch]$Json
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$testResultRelativePath = ".ai-dev/test-result.md"
$reviewRelativePath = ".ai-dev/review.md"

$queuePath = Join-Path $projectRoot $queueRelativePath
$statePath = Join-Path $projectRoot $stateRelativePath
$testResultPath = Join-Path $projectRoot $testResultRelativePath
$reviewPath = Join-Path $projectRoot $reviewRelativePath

function Stop-WithError {
    param(
        [string]$Message
    )

    Write-Error $Message
    exit 1
}

function Read-JsonFile {
    param(
        [string]$Path,
        [string]$RelativePath
    )

    try {
        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | ConvertFrom-Json
    } catch {
        Stop-WithError "$RelativePath JSON 파싱에 실패했습니다: $($_.Exception.Message)"
    }
}

function Test-HasValue {
    param(
        [object]$Value
    )

    if ($null -eq $Value) {
        return $false
    }

    if ($Value -is [string]) {
        return -not [string]::IsNullOrWhiteSpace($Value)
    }

    return $true
}

function Get-TestResultCurrentTaskId {
    param(
        [string[]]$Lines
    )

    $currentTaskLine = $Lines | Where-Object { $_ -match '^- Current task:\s*(.+)$' } | Se
lect-Object -First 1

    if ($currentTaskLine -match '^- Current task:\s*(.+)$') {
        return $Matches[1].Trim()
    }

    return $null
}

function New-SummaryStatus {
    param(
        [string]$Status,
        [string]$Reason,
        [object]$Content
    )

    return [PSCustomObject]@{
        status = $Status
        reason = $Reason
        content = $Content
    }
}

function Get-TestResultSummary {
    param(
        [string]$Path,
        [string]$CurrentTaskId,
        [bool]$IsInitialState
    )

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        return New-SummaryStatus "missing" "test-result 파일이 없습니다." "없음"
    }

    try {
        $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)

        if ($lines.Count -eq 0) {
            return New-SummaryStatus "missing" "test-result 파일이 비어 있습니다." "없음"
        }

        $resultTaskId = Get-TestResultCurrentTaskId $lines

        if ($IsInitialState) {
            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 test-result 요약을 숨겼습니다." "
숨김"
        }

        if ((Test-HasValue $CurrentTaskId) -and (Test-HasValue $resultTaskId) -and $result
TaskId -ne $CurrentTaskId) {
            return New-SummaryStatus "stale" "test-result의 task($resultTaskId)가 현재 task($C
urrentTaskId)와 다릅니다." "숨김"
        }

        return New-SummaryStatus "current" "현재 상태와 일치합니다." (($lines | Select-Object -Last 
30) -join "`r`n")
    } catch {
        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" "읽기 실패: $($_.Exc
eption.Message)"
    }
}

function Get-ReviewSummary {
    param(
        [string]$Path,
        [string]$LastReviewDecision,
        [bool]$IsInitialState
    )

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        $missingSummary = [PSCustomObject]@{
            available = $false
            decision = $null
            severity = $null
            nextStep = $null
            summary = "없음"
            fallback = $null
        }

        return New-SummaryStatus "missing" "review 파일이 없습니다." $missingSummary
    }

    try {
        $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)
        $decisionLine = $lines | Where-Object { $_ -match '^- Decision:\s*(.+)$' } | Selec
t-Object -First 1
        $severityLine = $lines | Where-Object { $_ -match '^- Severity:\s*(.+)$' } | Selec
t-Object -First 1
        $nextStepLine = $lines | Where-Object { $_ -match '^- Next step:\s*(.+)$' } | Sele
ct-Object -First 1
        $summaryLine = $lines | Where-Object { $_ -match '^- Summary:\s*(.+)$' } | Select-
Object -First 1

        $decision = if ($decisionLine -match '^- Decision:\s*(.+)$') { $Matches[1].Trim() 
} else { $null }
        $severity = if ($severityLine -match '^- Severity:\s*(.+)$') { $Matches[1].Trim() 
} else { $null }
        $nextStep = if ($nextStepLine -match '^- Next step:\s*(.+)$') { $Matches[1].Trim()
 } else { $null }
        $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } e
lse { $null }
        $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or (
Test-HasValue $nextStep) -or (Test-HasValue $summary)

        $review = [PSCustomObject]@{
            available = $true
            decision = $decision
            severity = $severity
            nextStep = $nextStep
            summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
            fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object -
Last 30) -join "`r`n") }
        }

        if ($IsInitialState) {
            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." $revie
w
        }

        if ((Test-HasValue $LastReviewDecision) -and $LastReviewDecision -ne "not_started"
 -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
            return New-SummaryStatus "stale" "review decision($decision)이 state lastReview
Decision($LastReviewDecision)와 다릅니다." $review
        }

        if (-not (Test-HasValue $LastReviewDecision) -or $LastReviewDecision -eq "not_star
ted") {
            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 요
약을 숨겼습니다." $review
        }

        return New-SummaryStatus "current" "현재 상태와 일치합니다." $review
    } catch {
        $errorSummary = [PSCustomObject]@{
            available = $true
            decision = $null
            severity = $null
            nextStep = $null
            summary = "읽기 실패: $($_.Exception.Message)"
            fallback = $null
        }

        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" $errorSummary
    }
}

foreach ($requiredPath in @($queueRelativePath, $stateRelativePath)) {
    $fullPath = Join-Path $projectRoot $requiredPath

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        Stop-WithError "필수 파일이 없습니다: $requiredPath"
    }
}

$queue = Read-JsonFile $queuePath $queueRelativePath
$state = Read-JsonFile $statePath $stateRelativePath

if (-not ($queue.PSObject.Properties.Name -contains "tasks")) {
    Stop-WithError "$queueRelativePath 필수 필드가 누락되었습니다: tasks"
}

if ($null -eq $queue.tasks -or -not ($queue.tasks -is [System.Collections.IEnumerable])) {
    Stop-WithError "$queueRelativePath tasks 필드는 배열이어야 합니다."
}

$tasks = @($queue.tasks)
$currentTaskId = $null

if (Test-HasValue $state.currentTaskId) {
    $currentTaskId = [string]$state.currentTaskId
} elseif (Test-HasValue $queue.currentTaskId) {
    $currentTaskId = [string]$queue.currentTaskId
} else {
    $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-Objec
t -First 1

    if ($null -ne $inProgressTask) {
        $currentTaskId = [string]$inProgressTask.id
    } else {
        $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Object -
First 1

        if ($null -ne $pendingTask) {
            $currentTaskId = [string]$pendingTask.id
        }
    }
}

$currentTask = $null

if (Test-HasValue $currentTaskId) {
    $currentTask = $tasks | Where-Object { $_.id -eq $currentTaskId } | Select-Object -Fir
st 1
}

$taskCounts = [ordered]@{
    total = $tasks.Count
    pending = @($tasks | Where-Object { $_.status -eq "pending" }).Count
    in_progress = @($tasks | Where-Object { $_.status -eq "in_progress" }).Count
    review_required = @($tasks | Where-Object { $_.status -eq "review_required" }).Count
    done = @($tasks | Where-Object { $_.status -eq "done" }).Count
    failed = @($tasks | Where-Object { $_.status -eq "failed" }).Count
    blocked = @($tasks | Where-Object { $_.status -eq "blocked" }).Count
    skipped = @($tasks | Where-Object { $_.status -eq "skipped" }).Count
}

$currentTaskStatus = if ($null -ne $currentTask) { [string]$currentTask.status } else { $n
ull }
$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastComm
andStatus } else { $null }
$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastRe
viewDecision } else { $null }
$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { $n
ull }
$initialTaskStatuses = @("not_started", "pending")
$isTaskInitialState = ($initialTaskStatuses -contains $currentTaskStatus) -or ($goalStatus
 -eq "not_started")
$isTestResultInitialState = $isTaskInitialState -or `
    (-not (Test-HasValue $state.lastCommand) -and ($lastCommandStatus -eq "not_started" -o
r -not (Test-HasValue $lastCommandStatus)))
$isReviewInitialState = $isTaskInitialState -or `
    (-not (Test-HasValue $lastReviewDecision) -or $lastReviewDecision -eq "not_started")

$gitStatus = "unavailable"
$gitChangedFilesCount = $null
$gitStatusLines = @()

try {
    $null = & git rev-parse --show-toplevel 2>&1

    if ($LASTEXITCODE -eq 0) {
        $gitOutput = & git status --short 2>&1 | Out-String

        if ($LASTEXITCODE -eq 0) {
            $gitStatusLines = @($gitOutput -split "`r?`n" | Where-Object { -not [string]::
IsNullOrWhiteSpace($_) })
            $gitChangedFilesCount = $gitStatusLines.Count
            $gitStatus = "available"
        }
    }
} catch {
    $gitStatus = "unavailable"
}

$testResultSummary = Get-TestResultSummary $testResultPath $currentTaskId $isTestResultIni
tialState
$reviewSummary = Get-ReviewSummary $reviewPath $lastReviewDecision $isReviewInitialState

$statusObject = [ordered]@{
    goalTitle = if (Test-HasValue $queue.goalTitle) { $queue.goalTitle } else { "없음" }
    goalStatus = if (Test-HasValue $state.goalStatus) { $state.goalStatus } else { "없음" }
    currentTask = [ordered]@{
        id = if ($null -ne $currentTask) { $currentTask.id } elseif (Test-HasValue $curren
tTaskId) { $currentTaskId } else { $null }
        title = if ($null -ne $currentTask) { $currentTask.title } else { "없음" }
        status = if ($null -ne $currentTask) { $currentTask.status } else { "없음" }
        type = if ($null -ne $currentTask) { $currentTask.type } else { "없음" }
        priority = if ($null -ne $currentTask) { $currentTask.priority } else { "없음" }
    }
    taskProgress = "$($taskCounts.done)/$($taskCounts.total)"
    taskCounts = $taskCounts
    lastCommand = if (Test-HasValue $state.lastCommand) { $state.lastCommand } else { "없음"
 }
    lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { $state.lastCommandSt
atus } else { "없음" }
    lastErrorSummary = if (Test-HasValue $state.lastErrorSummary) { $state.lastErrorSummar
y } else { "없음" }
    lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { $state.lastReviewD
ecision } else { "없음" }
    lastReviewSeverity = if (Test-HasValue $state.lastReviewSeverity) { $state.lastReviewS
everity } else { "없음" }
    lastCommitHash = if (Test-HasValue $state.lastCommitHash) { $state.lastCommitHash } el
se { "없음" }
    git = [ordered]@{
        status = $gitStatus
        changedFilesCount = $gitChangedFilesCount
        statusLines = $gitStatusLines
    }
    testResultSummary = $testResultSummary
    reviewSummary = $reviewSummary
}

if ($Json) {
    $statusObject | ConvertTo-Json -Depth 20
    exit 0
}

Write-Host "Goal title: $($statusObject.goalTitle)"
Write-Host "Goal status: $($statusObject.goalStatus)"
Write-Host "Current task id: $($statusObject.currentTask.id)"
Write-Host "Current task title: $($statusObject.currentTask.title)"
Write-Host "Current task status: $($statusObject.currentTask.status)"
Write-Host "Current task type: $($statusObject.currentTask.type)"
Write-Host "Current task priority: $($statusObject.currentTask.priority)"
Write-Host "Task progress: $($statusObject.taskProgress)"
Write-Host "Task counts: pending=$($taskCounts.pending), in_progress=$($taskCounts.in_prog
ress), review_required=$($taskCounts.review_required), done=$($taskCounts.done), failed=$(
$taskCounts.failed), blocked=$($taskCounts.blocked), skipped=$($taskCounts.skipped), total
=$($taskCounts.total)"
Write-Host "Last command: $($statusObject.lastCommand)"
Write-Host "Last command status: $($statusObject.lastCommandStatus)"
Write-Host "Last error: $($statusObject.lastErrorSummary)"
Write-Host "Last review decision: $($statusObject.lastReviewDecision)"
Write-Host "Last review severity: $($statusObject.lastReviewSeverity)"
Write-Host "Last commit hash: $($statusObject.lastCommitHash)"
Write-Host "Git status: $($statusObject.git.status)"
Write-Host "Git changed files count: $($statusObject.git.changedFilesCount)"
Write-Host ""
Write-Host "Test result summary:"
Write-Host "  Status: $($testResultSummary.status)"
Write-Host "  Reason: $($testResultSummary.reason)"
Write-Host $testResultSummary.content
Write-Host ""
Write-Host "Review summary:"
Write-Host "  Status: $($reviewSummary.status)"
Write-Host "  Reason: $($reviewSummary.reason)"
Write-Host "  Decision: $($reviewSummary.content.decision)"
Write-Host "  Severity: $($reviewSummary.content.severity)"
Write-Host "  Next step: $($reviewSummary.content.nextStep)"
Write-Host "  Summary: $($reviewSummary.content.summary)"

if ($reviewSummary.status -eq "current" -and (Test-HasValue $reviewSummary.content.fallbac
k)) {
    Write-Host $reviewSummary.content.fallback
}

codex
현재 구현은 요약에 `current/stale` 상태를 붙이는 방향입니다. 이제 상태 파일의 실제 필드 구조를 최소로 확인해, 비교 기준이 현재 자동화 산출물과 
맞는지 보겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath .ai-dev\\state.json" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath .ai-dev\\queue.json" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath .ai-dev\\review.md" in D:\ai-apps\planpilot-local
 succeeded in 2007ms:
# AI Dev Review

## 2026-06-25 15:58:57

- Decision: pass
- Severity: none
- Next step: complete_task
- Summary: 로컬 저장 안내 문구가 작은 범위에서 보강되었고 현재 task 요구사항과 p
rivacy-first 방향에 부합합니다.

### Required Changes

- 없음

### Optional Suggestions

- 없음

### Raw JSON

```json
{
    "decision":  "pass",
    "severity":  "none",
    "summary":  "로컬 저장 안내 문구가 작은 범위에서 보강되었고 현재 task 요구사항과 p\r\nrivacy-first 방향에 부합합니다.",
    "required_changes":  [

                         ],
    "optional_suggestions":  [

                             ],
    "scope_check":  {
                        "w\r\nithin_current_task":  true,
                        "scope_issues":  [

                                         ]
                    },
    "test_check":  {
                       "build_passed":  true,
                       "test_passed\r\n":  false,
                       "lint_passed":  true,
                       "issues":  [
                                      "package.json에 test script가 없어 npm run test는 skipped
 \r\n처리되었습니다."
                                  ]
                   },
    "next_step":  "complete_task"
}
```

 succeeded in 2015ms:
{
    "goalStatus":  "in_progress",
    "currentTaskId":  "T001",
    "currentLoop":  0,
    "maxLoopsPerTask":  2,
    "repeatedFailureCount":  0,
    "lastCommand":  "save-diff",
    "lastCommandStatus":  "passed",
    "lastErrorSummary":  "",
    "lastReviewDecision":  "not_started",
    "lastReviewSeverity":  null,
    "lastCommitHash":  null,
    "startedAt":  "2026-06-25T00:00:00+09:00",
    "updatedAt":  "2026-06-25T07:32:28.4041077+00:00",
    "stopReason":  null
}

 succeeded in 2048ms:
{
    "goalTitle":  "AI Dev Loop status stale summary 차단",
    "goalSource":  ".ai-dev/goal.md",
    "createdAt":  "2026-06-25T00:00:00+09:00",
    "updatedAt":  "2026-06-25T00:00:00+09:00",
    "currentTaskId":  "T001",
    "tasks":  [
                  {
                      "id":  "T001",
                      "title":  "상태 출력의 오래된 요약 차단",
                      "description":  "ai-dev-status 출력 로직에서 현재 task와 goal 상태에 맞지 않는 이전 리뷰
 또는 테스트 요약이 표시되지 않도록 작은 범위로 개선한다.",
                      "type":  "implementation",
                      "status":  "in_progress",
                      "priority":  "P0",
                      "dependsOn":  [

                                    ],
                      "filesLikelyToChange":  [
                                                  ".ai-dev/goal.md",
                                                  ".ai-dev/queue.json",
                                                  ".ai-dev/state.json"
                                              ],
                      "verification":  [
                                           "새 task 초기 상태에서 이전 리뷰/테스트 요약이 현재 결과처럼 표시되지 않는지 
확인한다.",
                                           "현재 task와 일치하는 최신 요약은 정상 표시되는지 확인한다."
                                       ],
                      "commitMessage":  "Hide stale AI dev status summaries"
                  }
              ]
}

codex
{
  "decision": "revise",
  "severity": "medium",
  "summary": "stale review 상태를 표시하더라도 이전 리뷰의 decision/severity/summary를 그대로 출력해 초기 task에서 
오래된 리뷰 요약이 계속 노출될 수 있습니다.",
  "required_changes": [
    {
      "file": "scripts/ai-dev-status.ps1",
      "reason": "Get-ReviewSummary가 stale을 반환한 뒤에도 일반 출력 경로에서 content.decision, content.se
verity, content.nextStep, content.summary를 항상 출력합니다. Reason은 '숨겼습니다'라고 하지만 실제로는 이전 review.
md의 요약이 노출되어 성공 기준과 불일치합니다.",
      "suggestion": "reviewSummary.status가 current일 때만 decision/severity/nextStep/summary/
fallback을 출력하고, stale일 때는 상태와 reason만 출력하거나 summary를 '숨김' 같은 값으로 대체하십시오."
    }
  ],
  "optional_suggestions": [
    {
      "file": "scripts/ai-dev-status.ps1",
      "suggestion": "stale 상태의 JSON 출력에서도 content에 이전 리뷰 상세가 그대로 포함됩니다. 자동 소비자가 JSON을 읽는 경
우까지 고려하면 stale content를 최소 정보로 대체하는 편이 더 명확합니다."
    }
  ],
  "scope_check": {
    "within_current_task": true,
    "scope_issues": []
  },
  "test_check": {
    "build_passed": true,
    "test_passed": false,
    "lint_passed": true,
    "issues": [
      "package.json에 test script가 없어 npm run test가 skipped 처리되었습니다.",
      "새 task 초기 상태와 현재 task 일치 상태에 대한 수동 검증 결과가 diff 내에 별도로 확인되지 않습니다."
    ]
  },
  "next_step": "revise_with_codex"
}
tokens used
17,010
{
  "decision": "revise",
  "severity": "medium",
  "summary": "stale review 상태를 표시하더라도 이전 리뷰의 decision/severity/summary를 그대로 출력해 초기 task에서 오래된 리뷰 요약이 계속 노출될 수 있습니다.",
  "required_changes": [
    {
      "file": "scripts/ai-dev-status.ps1",
      "reason": "Get-ReviewSummary가 stale을 반환한 뒤에도 일반 출력 경로에서 content.decision, content.severity, content.nextStep, content.summary를 항상 출력합니다. Reason은 '숨겼습니다'라고 하지만 실제로는 이전 review.md의 요약이 노출되어 성공 기준과 불일치합니다.",
      "suggestion": "reviewSummary.status가 current일 때만 decision/severity/nextStep/summary/fallback을 출력하고, stale일 때는 상태와 reason만 출력하거나 summary를 '숨김' 같은 값으로 대체하십시오."
    }
  ],
  "optional_suggestions": [
    {
      "file": "scripts/ai-dev-status.ps1",
      "suggestion": "stale 상태의 JSON 출력에서도 content에 이전 리뷰 상세가 그대로 포함됩니다. 자동 소비자가 JSON을 읽는 경우까지 고려하면 stale content를 최소 정보로 대체하는 편이 더 명확합니다."
    }
  ],
  "scope_check": {
    "within_current_task": true,
    "scope_issues": []
  },
  "test_check": {
    "build_passed": true,
    "test_passed": false,
    "lint_passed": true,
    "issues": [
      "package.json에 test script가 없어 npm run test가 skipped 처리되었습니다.",
      "새 task 초기 상태와 현재 task 일치 상태에 대한 수동 검증 결과가 diff 내에 별도로 확인되지 않습니다."
    ]
  },
  "next_step": "revise_with_codex"
}

```