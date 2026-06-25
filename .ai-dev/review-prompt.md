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
AI Dev Loop 상태 출력에서 새 goal 또는 새 task가 `not_started` 상태일 때 이전 작업의 테스트 결과나 리뷰 응답 요약이 섞여 보이지 않도록 개선한다.

## 배경
현재 자동 개발 루프 상태 표시에서 오래된 test-result 또는 review-response 요약이 현재 task의 `lastCommand`, `lastReviewDecision`, `currentTaskId`, goal 상태와 맞지 않게 노출될 수 있다. 이로 인해 새 작업이 시작되지 않았거나 초기 상태인데도 이전 작업 결과가 현재 상태처럼 보이는 혼선이 생긴다.

## 성공 기준
- 현재 task가 `not_started` 또는 초기 상태일 때 이전 task의 리뷰/테스트 요약이 현재 결과처럼 표시되지 않는다.
- `currentTaskId`, goal 상태, `lastCommand`, `lastReviewDecision`과 맞지 않는 오래된 요약은 숨기거나 stale 상태로 구분된다.
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
- Description: ai-dev-status 출력 로직에서 현재 task와 goal 상태에 맞지 않는 이전 리뷰 또는 테스트 요약이 표시되지 않도록 작은 범위로 개선한다.
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

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

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
+    $currentTaskLine = $Lines | Where-Object { $_ -match '^- Current task:\s*(.+)$' } | Select-Object -First 1
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
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 test-result 요약을 숨겼습니다." "숨김"
+        }
+
+        if ((Test-HasValue $CurrentTaskId) -and (Test-HasValue $resultTaskId) -and $resultTaskId -ne $CurrentTaskId) {
+            return New-SummaryStatus "stale" "test-result의 task($resultTaskId)가 현재 task($CurrentTaskId)와 다릅니다." "숨김"
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." (($lines | Select-Object -Last 30) -join "`r`n")
     } catch {
-        return "읽기 실패: $($_.Exception.Message)"
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" "읽기 실패: $($_.Exception.Message)"
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
         $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } else { $null }
         $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or (Test-HasValue $nextStep) -or (Test-HasValue $summary)
 
-        return [PSCustomObject]@{
+        $review = [PSCustomObject]@{
             available = $true
             decision = $decision
             severity = $severity
@@ -113,8 +156,22 @@ function Get-ReviewSummary {
             summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
             fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object -Last 30) -join "`r`n") }
         }
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." $review
+        }
+
+        if ((Test-HasValue $LastReviewDecision) -and $LastReviewDecision -ne "not_started" -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
+            return New-SummaryStatus "stale" "review decision($decision)이 state lastReviewDecision($LastReviewDecision)와 다릅니다." $review
+        }
+
+        if (-not (Test-HasValue $LastReviewDecision) -or $LastReviewDecision -eq "not_started") {
+            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 요약을 숨겼습니다." $review
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
 
+$currentTaskStatus = if ($null -ne $currentTask) { [string]$currentTask.status } else { $null }
+$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastCommandStatus } else { $null }
+$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastReviewDecision } else { $null }
+$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { $null }
+$initialTaskStatuses = @("not_started", "pending")
+$isTaskInitialState = ($initialTaskStatuses -contains $currentTaskStatus) -or ($goalStatus -eq "not_started")
+$isTestResultInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $state.lastCommand) -and ($lastCommandStatus -eq "not_started" -or -not (Test-HasValue $lastCommandStatus)))
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
+$testResultSummary = Get-TestResultSummary $testResultPath $currentTaskId $isTestResultInitialState
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
+if ($reviewSummary.status -eq "current" -and (Test-HasValue $reviewSummary.content.fallback)) {
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