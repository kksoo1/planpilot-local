# AI Dev Diff

## Generated At

2026-06-10 22:16:40

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
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-commit.ps1
 M scripts/ai-dev-make-review-prompt.ps1
 M scripts/ai-dev-save-diff.ps1
```

## App Change Files

- scripts/ai-dev-commit.ps1
- scripts/ai-dev-make-review-prompt.ps1
- scripts/ai-dev-save-diff.ps1

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
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-commit.ps1             | 64 ++++++++++++++++++++++++++++++++---
 scripts/ai-dev-make-review-prompt.ps1 |  4 +++
 scripts/ai-dev-save-diff.ps1          | 64 +++++++++++++++++++++--------------
 3 files changed, 102 insertions(+), 30 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-commit.ps1 b/scripts/ai-dev-commit.ps1
index fa4ad37..11d1ba9 100644
--- a/scripts/ai-dev-commit.ps1
+++ b/scripts/ai-dev-commit.ps1
@@ -12,6 +12,7 @@ $projectRoot = (Get-Location).Path
 $stateRelativePath = ".ai-dev/state.json"
 $queueRelativePath = ".ai-dev/queue.json"
 $loopLogRelativePath = ".ai-dev/loop-log.md"
+$aiDevOperationalRoot = ".ai-dev/"
 
 $statePath = Join-Path $projectRoot $stateRelativePath
 $queuePath = Join-Path $projectRoot $queueRelativePath
@@ -107,6 +108,47 @@ function Invoke-GitCapture {
     return $output.TrimEnd()
 }
 
+function Test-IsAiDevOperationalPath {
+    param(
+        [string]$RelativePath
+    )
+
+    $normalizedRelativePath = $RelativePath.Replace('\', '/')
+    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::OrdinalIgnoreCase)
+}
+
+function Convert-ToChangedPath {
+    param(
+        [string]$ChangeLine
+    )
+
+    if ([string]::IsNullOrWhiteSpace($ChangeLine)) {
+        return $null
+    }
+
+    if ($ChangeLine.StartsWith("?? ")) {
+        return $ChangeLine.Substring(3)
+    }
+
+    if ($ChangeLine.Length -ge 4 -and $ChangeLine.Substring(2, 1) -eq " ") {
+        return $ChangeLine.Substring(3)
+    }
+
+    return $ChangeLine
+}
+
+function Convert-ToFileList {
+    param(
+        [string[]]$Paths
+    )
+
+    if ($null -eq $Paths -or $Paths.Count -eq 0) {
+        return @("  - 없음")
+    }
+
+    return @($Paths | ForEach-Object { "  - $_" })
+}
+
 foreach ($requiredPath in @($stateRelativePath, $queueRelativePath, $loopLogRelativePath)) {
     $fullPath = Join-Path $projectRoot $requiredPath
 
@@ -259,15 +301,25 @@ $taskText = if ($null -ne $currentTask) {
     "unknown"
 }
 
+$targetChangedPaths = @($targetChangeLines | ForEach-Object { Convert-ToChangedPath $_ } | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique)
+$targetAppChangePaths = @($targetChangedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
+$targetAiDevOperationalPaths = @($targetChangedPaths | Where-Object { Test-IsAiDevOperationalPath $_ })
+
 if ($DryRun) {
     Write-Host "Dry run: git add/commit을 실행하지 않습니다."
     Write-Host "커밋 메시지: $commitMessage"
     Write-Host "현재 task: $taskText"
-    Write-Host "커밋 대상 변경 파일:"
-    foreach ($line in $targetChangeLines) {
-        Write-Host "  - $line"
+    Write-Host "커밋 대상 앱 변경 파일:"
+    foreach ($line in (Convert-ToFileList $targetAppChangePaths)) {
+        Write-Host $line
+    }
+    Write-Host "커밋 대상 AI Dev 운영 산출물:"
+    foreach ($line in (Convert-ToFileList $targetAiDevOperationalPaths)) {
+        Write-Host $line
     }
-    Write-Host "변경 파일 수: $($targetChangeLines.Count)"
+    Write-Host "앱 변경 파일 수: $($targetAppChangePaths.Count)"
+    Write-Host "AI Dev 운영 산출물 수: $($targetAiDevOperationalPaths.Count)"
+    Write-Host "전체 변경 파일 수: $($targetChangedPaths.Count)"
     exit 0
 }
 
@@ -323,5 +375,7 @@ $logEntry = @"
 
 Write-Host "커밋 메시지: $commitMessage"
 Write-Host "커밋 해시: $commitHash"
-Write-Host "변경 파일 수: $($targetChangeLines.Count)"
+Write-Host "앱 변경 파일 수: $($targetAppChangePaths.Count)"
+Write-Host "AI Dev 운영 산출물 수: $($targetAiDevOperationalPaths.Count)"
+Write-Host "전체 변경 파일 수: $($targetChangedPaths.Count)"
 Write-Host "현재 task: $taskText"
diff --git a/scripts/ai-dev-make-review-prompt.ps1 b/scripts/ai-dev-make-review-prompt.ps1
index 91fc240..1ad4d44 100644
--- a/scripts/ai-dev-make-review-prompt.ps1
+++ b/scripts/ai-dev-make-review-prompt.ps1
@@ -242,6 +242,8 @@ $reviewPromptContent = @"
 
 - 현재 task의 변경사항이 목표와 일치하는지 검토한다.
 - 빌드/테스트 결과와 git diff를 함께 검토한다.
+- 리뷰 판단은 `App Change Files`와 diff 본문의 실제 앱 변경 파일을 중심으로 수행한다.
+- `.ai-dev` 파일은 자동화 상태/로그/프롬프트 산출물로 별도 확인하되, 앱 변경 결함으로 과대평가하지 않는다.
 - 다음 task 범위까지 미리 구현했는지 확인한다.
 
 ## Project Goal
@@ -272,6 +274,8 @@ $diffContent
 ## Review Criteria
 
 - 현재 task 요구사항을 충족했는가
+- 실제 앱 변경 파일과 `.ai-dev` 운영 산출물이 구분되어 있는가
+- `.ai-dev` 운영 산출물만 변경된 경우 앱 변경 리뷰로 과대평가하지 않았는가
 - 현재 task 범위를 벗어나지 않았는가
 - 다음 task를 미리 구현하지 않았는가
 - 기존 기능을 깨뜨릴 가능성이 있는가
diff --git a/scripts/ai-dev-save-diff.ps1 b/scripts/ai-dev-save-diff.ps1
index 0ea9af1..fcaed07 100644
--- a/scripts/ai-dev-save-diff.ps1
+++ b/scripts/ai-dev-save-diff.ps1
@@ -11,16 +11,8 @@ $statePath = Join-Path $projectRoot $stateRelativePath
 $diffPath = Join-Path $projectRoot $diffRelativePath
 $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
 $maxUntrackedFileSize = 200KB
-$generatedArtifactRelativePaths = @(
-    ".ai-dev/diff.md",
-    ".ai-dev/review-prompt.md",
-    ".ai-dev/current-task-prompt.md",
-    ".ai-dev/revise-prompt.md",
-    ".ai-dev/test-result.md",
-    ".ai-dev/review.md",
-    ".ai-dev/review-response.json"
-)
-$generatedArtifactPathspecExcludes = @($generatedArtifactRelativePaths | ForEach-Object { ":(exclude)$_" })
+$aiDevOperationalRoot = ".ai-dev/"
+$reviewDiffPathspecExcludes = @(":(exclude).ai-dev/**")
 
 function Stop-WithError {
     param(
@@ -130,7 +122,16 @@ function Convert-ToCodeBlock {
     return "${codeFence}text`r`n$text`r`n$codeFence"
 }
 
-function Get-TrackedGeneratedArtifactPaths {
+function Test-IsAiDevOperationalPath {
+    param(
+        [string]$RelativePath
+    )
+
+    $normalizedRelativePath = $RelativePath.Replace('\', '/')
+    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::OrdinalIgnoreCase)
+}
+
+function Get-ChangedPathsFromPorcelain {
     param(
         [string]$PorcelainStatus
     )
@@ -139,21 +140,34 @@ function Get-TrackedGeneratedArtifactPaths {
     $statusLines = @($PorcelainStatus -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
 
     foreach ($line in $statusLines) {
-        if ($line.Length -lt 4 -or $line.StartsWith("?? ")) {
+        if ($line.StartsWith("?? ")) {
+            $paths += $line.Substring(3)
             continue
         }
 
-        $relativePath = $line.Substring(3)
-        $normalizedRelativePath = $relativePath.Replace('\', '/')
-
-        if ($generatedArtifactRelativePaths -contains $normalizedRelativePath) {
-            $paths += $relativePath
+        if ($line.Length -lt 4) {
+            continue
         }
+
+        $relativePath = $line.Substring(3)
+        $paths += $relativePath
     }
 
     return @($paths | Select-Object -Unique)
 }
 
+function Convert-ToFileList {
+    param(
+        [string[]]$Paths
+    )
+
+    if ($null -eq $Paths -or $Paths.Count -eq 0) {
+        return "- 없음"
+    }
+
+    return ($Paths | ForEach-Object { "- $_" }) -join "`r`n"
+}
+
 function Get-UntrackedFileSections {
     param(
         [string]$RepositoryRoot,
@@ -175,7 +189,7 @@ function Get-UntrackedFileSections {
             continue
         }
 
-        if ($generatedArtifactRelativePaths -contains $normalizedRelativePath) {
+        if (Test-IsAiDevOperationalPath $normalizedRelativePath) {
             $skippedGeneratedArtifacts += $relativePath
             continue
         }
@@ -245,29 +259,29 @@ try {
 try {
     $statusShort = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "git status --short"
     $statusPorcelain = Invoke-GitCapture -Arguments @("status", "--porcelain") -DisplayName "git status --porcelain"
-    $diffPathspecArguments = @("--", ".") + $generatedArtifactPathspecExcludes
+    $diffPathspecArguments = @("--", ".") + $reviewDiffPathspecExcludes
     $unstagedStat = Invoke-GitCapture -Arguments (@("diff", "--stat") + $diffPathspecArguments) -DisplayName "git diff --stat"
     $unstagedDiff = Invoke-GitCapture -Arguments (@("diff") + $diffPathspecArguments) -DisplayName "git diff"
     $stagedStat = Invoke-GitCapture -Arguments (@("diff", "--staged", "--stat") + $diffPathspecArguments) -DisplayName "git diff --staged --stat"
     $stagedDiff = Invoke-GitCapture -Arguments (@("diff", "--staged") + $diffPathspecArguments) -DisplayName "git diff --staged"
-    $skippedTrackedGeneratedArtifacts = Get-TrackedGeneratedArtifactPaths $statusPorcelain
+    $changedPaths = Get-ChangedPathsFromPorcelain $statusPorcelain
+    $appChangePaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
+    $aiDevOperationalPaths = @($changedPaths | Where-Object { Test-IsAiDevOperationalPath $_ })
 
     $generatedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
     $sections = @(
         "# AI Dev Diff",
         "## Generated At`r`n`r`n$generatedAt",
         "## Git Status`r`n`r`n$(Convert-ToCodeBlock $statusShort)",
+        "## App Change Files`r`n`r`n$(Convert-ToFileList $appChangePaths)",
+        "## AI Dev Operational Artifact Files`r`n`r`n$(Convert-ToFileList $aiDevOperationalPaths)",
+        "## Review Diff Scope`r`n`r`n아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 `.ai-dev` 운영 산출물 diff를 제외합니다. `.ai-dev` 변경은 위 운영 산출물 목록에서 별도로 확인합니다.",
         "## Unstaged Diff Stat`r`n`r`n$(Convert-ToCodeBlock $unstagedStat)",
         "## Unstaged Diff`r`n`r`n$(Convert-ToCodeBlock $unstagedDiff)",
         "## Staged Diff Stat`r`n`r`n$(Convert-ToCodeBlock $stagedStat)",
         "## Staged Diff`r`n`r`n$(Convert-ToCodeBlock $stagedDiff)"
     )
 
-    if ($skippedTrackedGeneratedArtifacts.Count -gt 0) {
-        $skippedTrackedArtifactList = $skippedTrackedGeneratedArtifacts | ForEach-Object { "- $_" }
-        $sections += "## Skipped Generated AI Dev Artifact Diffs`r`n`r`n$($skippedTrackedArtifactList -join "`r`n")"
-    }
-
     if ($IncludeUntrackedContent) {
         $untrackedResult = Get-UntrackedFileSections $repositoryRoot $statusPorcelain
         $sections += "## Untracked File Content`r`n`r`n$($untrackedResult.ContentSections -join "`r`n`r`n")"
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```