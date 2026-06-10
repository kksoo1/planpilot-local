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
AI Dev Loop의 리뷰 및 패키징 흐름에서 실제 앱 변경 diff와 `.ai-dev` 운영 산출물 diff를 분리한다.

## 배경
현재 자동화 상태 파일과 로그 같은 `.ai-dev` 산출물이 앱 변경 diff와 함께 취급되면, Codex 리뷰가 실제 사용자-facing 변경 범위를 판단하기 어려워질 수 있다. 리뷰는 `src` 등 실제 앱 변경 파일을 중심으로 수행하고, `.ai-dev` 파일은 자동화 메타데이터로 별도 취급해야 한다.

## 성공 기준
- 리뷰 대상 diff를 실제 앱 변경 파일과 `.ai-dev` 운영 산출물로 구분한다.
- Codex 리뷰 판단 기준은 실제 앱 변경 파일을 중심으로 정리된다.
- 패키징 또는 요약 단계에서 `.ai-dev` 상태/로그 파일은 자동화 메타데이터로 분리 표시된다.
- 변경 범위가 작고 기존 AI Dev Loop 구조를 해치지 않는다.

## 제약사항
- 한 번에 하나의 작은 구현 변경만 진행한다.
- 기존 자동화 상태 파일의 의미를 유지한다.
- 사용자 변경 사항을 되돌리지 않는다.
- 실제 앱 코드 변경과 운영 메타데이터 변경을 혼동하지 않도록 한다.

## 범위 제외
- 앱 기능 자체 변경은 제외한다.
- 대규모 구조 변경은 제외한다.
- 새로운 저장소 전체 재구성은 제외한다.

## 수동 검증
- 실제 앱 변경 파일과 `.ai-dev` 파일이 함께 변경된 상황을 가정해 리뷰/요약 출력에서 구분되는지 확인한다.
- `.ai-dev` 파일만 변경된 경우 앱 변경 리뷰로 과대평가되지 않는지 확인한다.

## Current Task

- Task ID: T001
- Title: 리뷰 diff 범위 분리 로직 정리
- Description: AI Dev Loop의 리뷰 및 패키징 흐름에서 실제 앱 변경 파일과 `.ai-dev` 운영 산출물을 구분하도록 최소 범위로 조정한다.
- Type: implementation
- Status: in_progress
- Priority: P1
- Depends on:
- 없음
- Verification:
- 실제 앱 변경 파일과 `.ai-dev` 운영 산출물이 별도 범주로 표시되는지 확인한다.
- Codex 리뷰 기준이 실제 앱 변경 파일 중심으로 설명되는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-06-10 22:16:31

- Overall result: passed
- Current task: T001
- Commands:
  - npm run build: passed
  - npm run test: skipped
  - npm run lint: skipped

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
dist/index.html                   0.46 kB │ gzip:  0.29 kB
dist/assets/index-DvjxWt30.css    5.69 kB │ gzip:  1.93 kB
dist/assets/index-BNHocAt1.js   315.73 kB │ gzip: 99.57 kB

[32m✓ built in 553ms[39m
```
### npm run test

- Status: skipped
- Exit code: 없음

```text
-BuildOnly 옵션으로 건너뛰었습니다.
```
### npm run lint

- Status: skipped
- Exit code: 없음

```text
-BuildOnly 옵션으로 건너뛰었습니다.
```

## Diff To Review

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