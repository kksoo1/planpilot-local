# AI Dev Diff

## Generated At

2026-07-18 18:18:49

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
 M scripts/ai-dev-run-review-codex.ps1
?? .ai-dev/review-json-extraction-verification-prompt.md
?? .ai-dev/review-json-failure-count-fix-prompt.md
```

## App Change Files

- scripts/ai-dev-run-review-codex.ps1

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
- .ai-dev/review-json-extraction-verification-prompt.md
- .ai-dev/review-json-failure-count-fix-prompt.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-run-review-codex.ps1 | 65 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-run-review-codex.ps1 b/scripts/ai-dev-run-review-codex.ps1
index 88f9b03..389f5b4 100644
--- a/scripts/ai-dev-run-review-codex.ps1
+++ b/scripts/ai-dev-run-review-codex.ps1
@@ -14,6 +14,8 @@
 $repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
 $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
 $codeFence = '```'
+$stateRelativePath = ".ai-dev/state.json"
+$statePath = Join-Path $repoRoot $stateRelativePath
 
 function Resolve-RepoPath {
     param(
@@ -42,6 +44,65 @@ function ConvertTo-RepoRelativePath {
     return $fullPath.Replace("\", "/")
 }
 
+function Test-HasValue {
+    param(
+        [object]$Value
+    )
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
+function Write-ReviewExtractionFailureState {
+    param(
+        [string]$ErrorSummary
+    )
+
+    if (-not (Test-Path -LiteralPath $statePath -PathType Leaf)) {
+        return
+    }
+
+    try {
+        $state = Get-Content -Raw -Encoding UTF8 -LiteralPath $statePath | ConvertFrom-Json
+        $failureCount = if ($state.stopReason -eq "review_json_extraction_failed" -and (Test-HasValue $state.repeatedFailureCount)) { [int]$state.repeatedFailureCount + 1 } else { 1 }
+
+        Set-ObjectProperty $state "lastCommand" "run-review-codex"
+        Set-ObjectProperty $state "lastCommandStatus" "failed"
+        Set-ObjectProperty $state "lastErrorSummary" $ErrorSummary
+        Set-ObjectProperty $state "lastReviewDecision" "blocked"
+        Set-ObjectProperty $state "lastReviewSeverity" "critical"
+        Set-ObjectProperty $state "repeatedFailureCount" $failureCount
+        Set-ObjectProperty $state "stopReason" "review_json_extraction_failed"
+        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
+
+        $stateJson = $state | ConvertTo-Json -Depth 20
+        [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)
+    } catch {
+        Write-Warning "$stateRelativePath에 리뷰 JSON 추출 실패 상태를 기록하지 못했습니다: $($_.Exception.Message)"
+    }
+}
+
 function Write-RunResult {
     param(
         [string]$Action,
@@ -346,7 +407,9 @@ try {
     $reviewResult = ConvertFrom-CodexReviewOutput $codexOutput
 } catch {
     $preview = Get-InputPreview $codexOutput
-    Write-RunResult "run_review_codex" $true 1 "Codex 리뷰 JSON 추출에 실패했습니다: $($_.Exception.Message) 출력 preview: $preview"
+    $errorSummary = "Codex 리뷰 JSON 추출에 실패했습니다: $($_.Exception.Message) 출력 preview: $preview"
+    Write-ReviewExtractionFailureState $errorSummary
+    Write-RunResult "run_review_codex" $true 1 $errorSummary
 }
 
 [System.IO.File]::WriteAllText($resolvedReviewResponsePath, $reviewResult.JsonText, $utf8WithBom)
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```