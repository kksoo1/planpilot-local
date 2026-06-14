# AI Dev Diff

## Generated At

2026-06-14 22:05:08

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-check.ps1
?? .ai-dev/auto-goal-planning-prompt.md
```

## App Change Files

- scripts/ai-dev-check.ps1

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev/test-result.md
- .ai-dev/auto-goal-planning-prompt.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-check.ps1 | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-check.ps1 b/scripts/ai-dev-check.ps1
index 8c6fdbd..024cc3d 100644
--- a/scripts/ai-dev-check.ps1
+++ b/scripts/ai-dev-check.ps1
@@ -170,7 +170,7 @@ $hasLint = Test-HasScript $package "lint"
 
 $runBuild = $hasBuild -and -not $SkipBuild
 $runTest = $hasTest -and -not $SkipTest -and -not $BuildOnly
-$runLint = $hasLint -and -not $SkipLint -and -not $BuildOnly
+$runLint = $hasLint -and -not $SkipLint
 
 $buildSkipReason = if (-not $hasBuild) {
     "package.json에 build script가 없습니다."
@@ -180,19 +180,17 @@ $buildSkipReason = if (-not $hasBuild) {
     ""
 }
 
-$testSkipReason = if ($BuildOnly) {
-    "-BuildOnly 옵션으로 건너뛰었습니다."
-} elseif (-not $hasTest) {
+$testSkipReason = if (-not $hasTest) {
     "package.json에 test script가 없습니다."
 } elseif ($SkipTest) {
     "-SkipTest 옵션으로 건너뛰었습니다."
+} elseif ($BuildOnly) {
+    "-BuildOnly 옵션으로 건너뛰었습니다."
 } else {
     ""
 }
 
-$lintSkipReason = if ($BuildOnly) {
-    "-BuildOnly 옵션으로 건너뛰었습니다."
-} elseif (-not $hasLint) {
+$lintSkipReason = if (-not $hasLint) {
     "package.json에 lint script가 없습니다."
 } elseif ($SkipLint) {
     "-SkipLint 옵션으로 건너뛰었습니다."
@@ -216,6 +214,7 @@ $currentTaskId = if ($null -ne $state.currentTaskId -and -not [string]::IsNullOr
 }
 
 $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
+$modeText = if ($BuildOnly) { "BuildOnly (build + lint when available)" } else { "standard" }
 $commandSummary = ($results | ForEach-Object { "  - $($_.Command): $($_.Status)" }) -join "`r`n"
 $detailSections = @()
 $codeFence = '```'
@@ -243,6 +242,7 @@ $testResultContent = @"
 
 - Overall result: $overallResult
 - Current task: $currentTaskId
+- Mode: $modeText
 - Commands:
 $commandSummary
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```