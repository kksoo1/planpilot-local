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