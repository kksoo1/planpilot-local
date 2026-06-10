# Codex Review Result

## Run

- Started at: 2026-06-10 22:16:43
- Ended at: 2026-06-10 22:17:30
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
session id: 019eb1ad-953a-71a3-9c28-e5bab0b19eb8
--------
user
Read and follow the full review prompt at this absolute file path: D:\ai-apps\planpilot-local\.ai-d
ev\review-prompt.md
codex
요청하신 리뷰 프롬프트 파일만 읽어서 지시사항을 확인하겠습니다. 이후 필요한 범위가 더 있으면 먼저 이유를 짚고 진행하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath
 'D:\\ai-apps\\planpilot-local\\.ai-dev\\review-prompt.md'" in D:\ai-apps\planpilot-local
 succeeded in 1416ms:
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
현재 자동화 상태 파일과 로그 같은 `.ai-dev` 산출물이 앱 변경 diff와 함께 취급되면, Codex 리뷰가 실제 사용자-facing 변경 범위를 판단하기 어려워질 수 있
다. 리뷰는 `src` 등 실제 앱 변경 파일을 중심으로 수행하고, `.ai-dev` 파일은 자동화 메타데이터로 별도 취급해야 한다.

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
+    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::Or
dinalIgnoreCase)
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
 
+$targetChangedPaths = @($targetChangeLines | ForEach-Object { Convert-ToChangedPath $_ } | Where-O
bject { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique)
+$targetAppChangePaths = @($targetChangedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $
_) })
+$targetAiDevOperationalPaths = @($targetChangedPaths | Where-Object { Test-IsAiDevOperationalPath 
$_ })
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
-$generatedArtifactPathspecExcludes = @($generatedArtifactRelativePaths | ForEach-Object { ":(exclu
de)$_" })
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
+    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::Or
dinalIgnoreCase)
+}
+
+function Get-ChangedPathsFromPorcelain {
     param(
         [string]$PorcelainStatus
     )
@@ -139,21 +140,34 @@ function Get-TrackedGeneratedArtifactPaths {
     $statusLines = @($PorcelainStatus -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhite
Space($_) })
 
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
     $statusShort = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "git status --
short"
     $statusPorcelain = Invoke-GitCapture -Arguments @("status", "--porcelain") -DisplayName "git s
tatus --porcelain"
-    $diffPathspecArguments = @("--", ".") + $generatedArtifactPathspecExcludes
+    $diffPathspecArguments = @("--", ".") + $reviewDiffPathspecExcludes
     $unstagedStat = Invoke-GitCapture -Arguments (@("diff", "--stat") + $diffPathspecArguments) -D
isplayName "git diff --stat"
     $unstagedDiff = Invoke-GitCapture -Arguments (@("diff") + $diffPathspecArguments) -DisplayName
 "git diff"
     $stagedStat = Invoke-GitCapture -Arguments (@("diff", "--staged", "--stat") + $diffPathspecArg
uments) -DisplayName "git diff --staged --stat"
     $stagedDiff = Invoke-GitCapture -Arguments (@("diff", "--staged") + $diffPathspecArguments) -D
isplayName "git diff --staged"
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
+        "## AI Dev Operational Artifact Files`r`n`r`n$(Convert-ToFileList $aiDevOperationalPaths)"
,
+        "## Review Diff Scope`r`n`r`n아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 `.ai-dev` 운영 산출물 diff를 제외합니
다. `.ai-dev` 변경은 위 운영 산출물 목록에서 별도로 확인합니다.",
         "## Unstaged Diff Stat`r`n`r`n$(Convert-ToCodeBlock $unstagedStat)",
         "## Unstaged Diff`r`n`r`n$(Convert-ToCodeBlock $unstagedDiff)",
         "## Staged Diff Stat`r`n`r`n$(Convert-ToCodeBlock $stagedStat)",
         "## Staged Diff`r`n`r`n$(Convert-ToCodeBlock $stagedDiff)"
     )
 
-    if ($skippedTrackedGeneratedArtifacts.Count -gt 0) {
-        $skippedTrackedArtifactList = $skippedTrackedGeneratedArtifacts | ForEach-Object { "- $_" 
}
-        $sections += "## Skipped Generated AI Dev Artifact Diffs`r`n`r`n$($skippedTrackedArtifactL
ist -join "`r`n")"
-    }
-
     if ($IncludeUntrackedContent) {
         $untrackedResult = Get-UntrackedFileSections $repositoryRoot $statusPorcelain
         $sections += "## Untracked File Content`r`n`r`n$($untrackedResult.ContentSections -join "`
r`n`r`n")"
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
프롬프트 안의 diff만으로도 주요 검토는 가능하지만, 커밋 스크립트의 주변 문맥에서 새 함수가 실제 입력 형식과 맞는지 확인하겠습니다. 앱 파일이 아니라 지정된 변경 스크립트만
 읽습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath
 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-commit.ps1'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath
 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-save-diff.ps1'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath
 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-make-review-prompt.ps1'" in D:\ai-apps\planpilot-lo
cal
 succeeded in 2028ms:
param(
    [string]$Message,
    [string[]]$Files,
    [switch]$AllowWithoutPassedCheck,
    [switch]$AllowWithoutPassedReview,
    [switch]$DryRun
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$stateRelativePath = ".ai-dev/state.json"
$queueRelativePath = ".ai-dev/queue.json"
$loopLogRelativePath = ".ai-dev/loop-log.md"
$aiDevOperationalRoot = ".ai-dev/"

$statePath = Join-Path $projectRoot $stateRelativePath
$queuePath = Join-Path $projectRoot $queueRelativePath
$loopLogPath = Join-Path $projectRoot $loopLogRelativePath
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)

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

function Set-ObjectProperty {
    param(
        [object]$InputObject,
        [string]$Name,
        [object]$Value
    )

    if ($InputObject.PSObject.Properties.Name -contains $Name) {
        $InputObject.$Name = $Value
    } else {
        $InputObject | Add-Member -NotePropertyName $Name -NotePropertyValue $Value
    }
}

function Save-StateResult {
    param(
        [object]$State,
        [string]$Status,
        [string]$ErrorSummary,
        [string]$CommitHash
    )

    Set-ObjectProperty $State "lastCommand" "commit"
    Set-ObjectProperty $State "lastCommandStatus" $Status
    Set-ObjectProperty $State "lastErrorSummary" $ErrorSummary
    Set-ObjectProperty $State "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))

    if (Test-HasValue $CommitHash) {
        Set-ObjectProperty $State "lastCommitHash" $CommitHash
    }

    $stateJson = $State | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)
}

function Invoke-GitCapture {
    param(
        [string[]]$Arguments,
        [string]$DisplayName
    )

    $output = & git @Arguments 2>&1 | Out-String
    $exitCode = $LASTEXITCODE

    if ($exitCode -ne 0) {
        throw "$DisplayName 실행에 실패했습니다. exit code: $exitCode`n$output"
    }

    return $output.TrimEnd()
}

function Test-IsAiDevOperationalPath {
    param(
        [string]$RelativePath
    )

    $normalizedRelativePath = $RelativePath.Replace('\', '/')
    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::Ord
inalIgnoreCase)
}

function Convert-ToChangedPath {
    param(
        [string]$ChangeLine
    )

    if ([string]::IsNullOrWhiteSpace($ChangeLine)) {
        return $null
    }

    if ($ChangeLine.StartsWith("?? ")) {
        return $ChangeLine.Substring(3)
    }

    if ($ChangeLine.Length -ge 4 -and $ChangeLine.Substring(2, 1) -eq " ") {
        return $ChangeLine.Substring(3)
    }

    return $ChangeLine
}

function Convert-ToFileList {
    param(
        [string[]]$Paths
    )

    if ($null -eq $Paths -or $Paths.Count -eq 0) {
        return @("  - 없음")
    }

    return @($Paths | ForEach-Object { "  - $_" })
}

foreach ($requiredPath in @($stateRelativePath, $queueRelativePath, $loopLogRelativePath)) {
    $fullPath = Join-Path $projectRoot $requiredPath

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        Stop-WithError "필수 파일이 없습니다: $requiredPath"
    }
}

try {
    $null = Invoke-GitCapture -Arguments @("rev-parse", "--show-toplevel") -DisplayName "git rev-pa
rse --show-toplevel"
} catch {
    Stop-WithError "현재 위치가 git repository가 아닙니다."
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
    $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-Object -First 
1

    if ($null -ne $inProgressTask) {
        $currentTaskId = [string]$inProgressTask.id
    } else {
        $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Object -First 1

        if ($null -ne $pendingTask) {
            $currentTaskId = [string]$pendingTask.id
        }
    }
}

$currentTask = $null

if (Test-HasValue $currentTaskId) {
    $currentTask = $tasks | Where-Object { $_.id -eq $currentTaskId } | Select-Object -First 1
}

if ($null -eq $currentTask) {
    Write-Warning "현재 task를 찾지 못했습니다. 기본 커밋 메시지를 사용할 수 있습니다."
}

if (-not $AllowWithoutPassedCheck -and $state.lastCommandStatus -ne "passed") {
    Stop-WithError "state.lastCommandStatus가 passed가 아닙니다. 검증 결과를 확인하거나 -AllowWithoutPassedCheck를 사
용하세요."
}

if (-not $AllowWithoutPassedReview -and $state.lastReviewDecision -ne "pass") {
    Stop-WithError "state.lastReviewDecision이 pass가 아닙니다. 리뷰 결과를 확인하거나 -AllowWithoutPassedReview를 사
용하세요."
}

try {
    $statusPorcelain = Invoke-GitCapture -Arguments @("status", "--porcelain") -DisplayName "git st
atus --porcelain"
} catch {
    Stop-WithError $_.Exception.Message
}

$changeLines = @($statusPorcelain -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace
($_) })

if ($changeLines.Count -eq 0) {
    Write-Host "커밋할 변경사항 없음"
    exit 0
}

$selectedFiles = @()
$targetChangeLines = $changeLines

if ($null -ne $Files -and $Files.Count -gt 0) {
    $requestedFiles = @($Files | ForEach-Object { $_ -split "," } | Where-Object { -not [string]::I
sNullOrWhiteSpace($_) })

    if ($requestedFiles.Count -eq 0) {
        Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
    }

    foreach ($file in $requestedFiles) {
        if ([string]::IsNullOrWhiteSpace($file)) {
            Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
        }

        $normalizedFile = $file.Replace('\', '/')
        $fullPath = [System.IO.Path]::GetFullPath((Join-Path $projectRoot $normalizedFile))
        $projectRootPrefix = [System.IO.Path]::GetFullPath($projectRoot).TrimEnd('\', '/') + [Syste
m.IO.Path]::DirectorySeparatorChar

        if (-not $fullPath.StartsWith($projectRootPrefix, [System.StringComparison]::OrdinalIgnoreC
ase)) {
            Stop-WithError "저장소 밖 파일은 선택할 수 없습니다: $file"
        }

        if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
            Stop-WithError "선택한 파일이 존재하지 않습니다: $file"
        }

        try {
            $fileStatus = Invoke-GitCapture -Arguments @("status", "--porcelain", "--", $normalized
File) -DisplayName "git status --porcelain -- $normalizedFile"
        } catch {
            Stop-WithError $_.Exception.Message
        }

        if ([string]::IsNullOrWhiteSpace($fileStatus)) {
            Stop-WithError "선택한 파일에 커밋할 변경사항이 없습니다: $file"
        }

        $selectedFiles += $normalizedFile
    }

    $selectedFiles = @($selectedFiles | Select-Object -Unique)
    $targetChangeLines = @($selectedFiles)

    try {
        $stagedFiles = Invoke-GitCapture -Arguments @("diff", "--cached", "--name-only") -DisplayNa
me "git diff --cached --name-only"
    } catch {
        Stop-WithError $_.Exception.Message
    }

    $stagedFileList = @($stagedFiles -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSp
ace($_) })
    $unexpectedStagedFiles = @($stagedFileList | Where-Object { $selectedFiles -notcontains $_ })

    if ($unexpectedStagedFiles.Count -gt 0) {
        Stop-WithError "선택 파일 외에 이미 staged 된 파일이 있습니다: $($unexpectedStagedFiles -join ', ')"
    }
}

$commitMessage = if (Test-HasValue $Message) {
    $Message
} elseif ($null -ne $currentTask -and (Test-HasValue $currentTask.commitMessage)) {
    [string]$currentTask.commitMessage
} elseif ($null -ne $currentTask) {
    "chore(ai-dev): complete $($currentTask.id) $($currentTask.title)"
} else {
    "chore(ai-dev): automated task commit"
}

$taskText = if ($null -ne $currentTask) {
    "$($currentTask.id) $($currentTask.title)"
} elseif (Test-HasValue $currentTaskId) {
    "$currentTaskId unknown"
} else {
    "unknown"
}

$targetChangedPaths = @($targetChangeLines | ForEach-Object { Convert-ToChangedPath $_ } | Where-Ob
ject { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique)
$targetAppChangePaths = @($targetChangedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_
) })
$targetAiDevOperationalPaths = @($targetChangedPaths | Where-Object { Test-IsAiDevOperationalPath $
_ })

if ($DryRun) {
    Write-Host "Dry run: git add/commit을 실행하지 않습니다."
    Write-Host "커밋 메시지: $commitMessage"
    Write-Host "현재 task: $taskText"
    Write-Host "커밋 대상 앱 변경 파일:"
    foreach ($line in (Convert-ToFileList $targetAppChangePaths)) {
        Write-Host $line
    }
    Write-Host "커밋 대상 AI Dev 운영 산출물:"
    foreach ($line in (Convert-ToFileList $targetAiDevOperationalPaths)) {
        Write-Host $line
    }
    Write-Host "앱 변경 파일 수: $($targetAppChangePaths.Count)"
    Write-Host "AI Dev 운영 산출물 수: $($targetAiDevOperationalPaths.Count)"
    Write-Host "전체 변경 파일 수: $($targetChangedPaths.Count)"
    exit 0
}

try {
    if ($selectedFiles.Count -gt 0) {
        $addOutput = & git add -- @selectedFiles 2>&1 | Out-String
        $addDisplayName = "git add -- <selected files>"
    } else {
        $addOutput = & git add -A 2>&1 | Out-String
        $addDisplayName = "git add -A"
    }

    if ($LASTEXITCODE -ne 0) {
        throw "$addDisplayName 실행에 실패했습니다. exit code: $LASTEXITCODE`n$addOutput"
    }

    if ($selectedFiles.Count -gt 0) {
        $stagedFilesAfterAdd = Invoke-GitCapture -Arguments @("diff", "--cached", "--name-only") -D
isplayName "git diff --cached --name-only"
        $stagedFileListAfterAdd = @($stagedFilesAfterAdd -split "`r?`n" | Where-Object { -not [stri
ng]::IsNullOrWhiteSpace($_) })
        $unexpectedStagedFilesAfterAdd = @($stagedFileListAfterAdd | Where-Object { $selectedFiles 
-notcontains $_ })

        if ($unexpectedStagedFilesAfterAdd.Count -gt 0) {
            throw "선택 파일 외의 staged 파일이 감지되었습니다: $($unexpectedStagedFilesAfterAdd -join ', ')"
        }
    }

    $commitOutput = & git commit -m $commitMessage 2>&1 | Out-String

    if ($LASTEXITCODE -ne 0) {
        throw "git commit 실행에 실패했습니다. exit code: $LASTEXITCODE`n$commitOutput"
    }

    $commitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-parse H
EAD"
} catch {
    $errorSummary = $_.Exception.Message
    Save-StateResult $state "failed" $errorSummary $null
    Stop-WithError "자동 커밋에 실패했습니다: $errorSummary"
}

Save-StateResult $state "passed" "" $commitHash

$logTimestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$logEntry = @"

## $logTimestamp - Commit created

- Task: $taskText
- Commit: $commitHash
- Message: $commitMessage
"@

[System.IO.File]::AppendAllText($loopLogPath, $logEntry, $utf8WithBom)

Write-Host "커밋 메시지: $commitMessage"
Write-Host "커밋 해시: $commitHash"
Write-Host "앱 변경 파일 수: $($targetAppChangePaths.Count)"
Write-Host "AI Dev 운영 산출물 수: $($targetAiDevOperationalPaths.Count)"
Write-Host "전체 변경 파일 수: $($targetChangedPaths.Count)"
Write-Host "현재 task: $taskText"

 succeeded in 2076ms:
param(
    [switch]$IncludeUntrackedContent
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$stateRelativePath = ".ai-dev/state.json"
$diffRelativePath = ".ai-dev/diff.md"
$statePath = Join-Path $projectRoot $stateRelativePath
$diffPath = Join-Path $projectRoot $diffRelativePath
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
$maxUntrackedFileSize = 200KB
$aiDevOperationalRoot = ".ai-dev/"
$reviewDiffPathspecExcludes = @(":(exclude).ai-dev/**")

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

function Set-ObjectProperty {
    param(
        [object]$InputObject,
        [string]$Name,
        [object]$Value
    )

    if ($InputObject.PSObject.Properties.Name -contains $Name) {
        $InputObject.$Name = $Value
    } else {
        $InputObject | Add-Member -NotePropertyName $Name -NotePropertyValue $Value
    }
}

function Save-StateResult {
    param(
        [object]$State,
        [string]$Status,
        [string]$ErrorSummary
    )

    Set-ObjectProperty $State "lastCommand" "save-diff"
    Set-ObjectProperty $State "lastCommandStatus" $Status
    Set-ObjectProperty $State "lastErrorSummary" $ErrorSummary
    Set-ObjectProperty $State "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))

    $stateJson = $State | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)
}

function Invoke-GitCapture {
    param(
        [string[]]$Arguments,
        [string]$DisplayName
    )

    $argumentText = ($Arguments | ForEach-Object {
        if ($_ -match '[\s"]') {
            '"' + $_.Replace('"', '\"') + '"'
        } else {
            $_
        }
    }) -join " "

    $startInfo = New-Object System.Diagnostics.ProcessStartInfo
    $startInfo.FileName = "git"
    $startInfo.Arguments = $argumentText
    $startInfo.UseShellExecute = $false
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    $startInfo.CreateNoWindow = $true

    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $startInfo

    if (-not $process.Start()) {
        throw "$DisplayName 실행을 시작하지 못했습니다."
    }

    $output = $process.StandardOutput.ReadToEnd()
    $errorOutput = $process.StandardError.ReadToEnd()
    $process.WaitForExit()
    $exitCode = $process.ExitCode

    if ($exitCode -ne 0) {
        throw "$DisplayName 실행에 실패했습니다. exit code: $exitCode`n$errorOutput"
    }

    if (-not [string]::IsNullOrWhiteSpace($errorOutput)) {
        Write-Warning "$DisplayName 경고: $($errorOutput.Trim())"
    }

    return $output.TrimEnd()
}

function Convert-ToCodeBlock {
    param(
        [string]$Content
    )

    $codeFence = '```'
    $text = if ([string]::IsNullOrWhiteSpace($Content)) { "변경 없음" } else { $Content }

    return "${codeFence}text`r`n$text`r`n$codeFence"
}

function Test-IsAiDevOperationalPath {
    param(
        [string]$RelativePath
    )

    $normalizedRelativePath = $RelativePath.Replace('\', '/')
    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::Ord
inalIgnoreCase)
}

function Get-ChangedPathsFromPorcelain {
    param(
        [string]$PorcelainStatus
    )

    $paths = @()
    $statusLines = @($PorcelainStatus -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteS
pace($_) })

    foreach ($line in $statusLines) {
        if ($line.StartsWith("?? ")) {
            $paths += $line.Substring(3)
            continue
        }

        if ($line.Length -lt 4) {
            continue
        }

        $relativePath = $line.Substring(3)
        $paths += $relativePath
    }

    return @($paths | Select-Object -Unique)
}

function Convert-ToFileList {
    param(
        [string[]]$Paths
    )

    if ($null -eq $Paths -or $Paths.Count -eq 0) {
        return "- 없음"
    }

    return ($Paths | ForEach-Object { "- $_" }) -join "`r`n"
}

function Get-UntrackedFileSections {
    param(
        [string]$RepositoryRoot,
        [string]$PorcelainStatus
    )

    $sections = @()
    $skippedGeneratedArtifacts = @()
    $repositoryRootFullPath = [System.IO.Path]::GetFullPath($RepositoryRoot).TrimEnd('\', '/') + [S
ystem.IO.Path]::DirectorySeparatorChar
    $untrackedLines = @($PorcelainStatus -split "`r?`n" | Where-Object { $_.StartsWith("?? ") })

    foreach ($line in $untrackedLines) {
        $relativePath = $line.Substring(3)
        $sectionTitle = "### $relativePath"
        $normalizedRelativePath = $relativePath.Replace('\', '/')

        if ($relativePath.StartsWith('"') -and $relativePath.EndsWith('"')) {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 따옴표로 인코딩된 경로는 자동 읽기 대상에서 제외합니다."
            continue
        }

        if (Test-IsAiDevOperationalPath $normalizedRelativePath) {
            $skippedGeneratedArtifacts += $relativePath
            continue
        }

        try {
            $fullPath = [System.IO.Path]::GetFullPath((Join-Path $RepositoryRoot $relativePath))
        } catch {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 경로를 해석할 수 없습니다."
            continue
        }

        if (-not $fullPath.StartsWith($repositoryRootFullPath, [System.StringComparison]::OrdinalIg
noreCase)) {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 저장소 밖 경로입니다."
            continue
        }

        if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 파일이 아니거나 읽을 수 없습니다."
            continue
        }

        try {
            $fileInfo = Get-Item -LiteralPath $fullPath

            if ($fileInfo.Length -gt $maxUntrackedFileSize) {
                $sections += "$sectionTitle`r`n`r`n내용 생략: 파일 크기가 200KB를 초과합니다."
                continue
            }

            $bytes = [System.IO.File]::ReadAllBytes($fullPath)

            if ($bytes -contains 0) {
                $sections += "$sectionTitle`r`n`r`n내용 생략: 바이너리 파일로 판단했습니다."
                continue
            }

            $content = [System.Text.Encoding]::UTF8.GetString($bytes)
            $sections += "$sectionTitle`r`n`r`n$(Convert-ToCodeBlock $content)"
        } catch {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 파일 읽기에 실패했습니다."
        }
    }

    if ($sections.Count -eq 0) {
        $sections = @("내용을 포함할 추적되지 않은 텍스트 파일이 없습니다.")
    }

    return [PSCustomObject]@{
        ContentSections = $sections
        SkippedGeneratedArtifacts = $skippedGeneratedArtifacts
    }
}

if (-not (Test-Path -LiteralPath $statePath -PathType Leaf)) {
    Stop-WithError "필수 파일이 없습니다: $stateRelativePath"
}

$state = Read-JsonFile $statePath $stateRelativePath

try {
    $repositoryRoot = Invoke-GitCapture -Arguments @("rev-parse", "--show-toplevel") -DisplayName "
git rev-parse --show-toplevel"
} catch {
    Save-StateResult $state "failed" $_.Exception.Message
    Stop-WithError "현재 위치가 git repository가 아닙니다."
}

try {
    $statusShort = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "git status --s
hort"
    $statusPorcelain = Invoke-GitCapture -Arguments @("status", "--porcelain") -DisplayName "git st
atus --porcelain"
    $diffPathspecArguments = @("--", ".") + $reviewDiffPathspecExcludes
    $unstagedStat = Invoke-GitCapture -Arguments (@("diff", "--stat") + $diffPathspecArguments) -Di
splayName "git diff --stat"
    $unstagedDiff = Invoke-GitCapture -Arguments (@("diff") + $diffPathspecArguments) -DisplayName 
"git diff"
    $stagedStat = Invoke-GitCapture -Arguments (@("diff", "--staged", "--stat") + $diffPathspecArgu
ments) -DisplayName "git diff --staged --stat"
    $stagedDiff = Invoke-GitCapture -Arguments (@("diff", "--staged") + $diffPathspecArguments) -Di
splayName "git diff --staged"
    $changedPaths = Get-ChangedPathsFromPorcelain $statusPorcelain
    $appChangePaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
    $aiDevOperationalPaths = @($changedPaths | Where-Object { Test-IsAiDevOperationalPath $_ })

    $generatedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $sections = @(
        "# AI Dev Diff",
        "## Generated At`r`n`r`n$generatedAt",
        "## Git Status`r`n`r`n$(Convert-ToCodeBlock $statusShort)",
        "## App Change Files`r`n`r`n$(Convert-ToFileList $appChangePaths)",
        "## AI Dev Operational Artifact Files`r`n`r`n$(Convert-ToFileList $aiDevOperationalPaths)",
        "## Review Diff Scope`r`n`r`n아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 `.ai-dev` 운영 산출물 diff를 제외합니다
. `.ai-dev` 변경은 위 운영 산출물 목록에서 별도로 확인합니다.",
        "## Unstaged Diff Stat`r`n`r`n$(Convert-ToCodeBlock $unstagedStat)",
        "## Unstaged Diff`r`n`r`n$(Convert-ToCodeBlock $unstagedDiff)",
        "## Staged Diff Stat`r`n`r`n$(Convert-ToCodeBlock $stagedStat)",
        "## Staged Diff`r`n`r`n$(Convert-ToCodeBlock $stagedDiff)"
    )

    if ($IncludeUntrackedContent) {
        $untrackedResult = Get-UntrackedFileSections $repositoryRoot $statusPorcelain
        $sections += "## Untracked File Content`r`n`r`n$($untrackedResult.ContentSections -join "`r
`n`r`n")"

        if ($untrackedResult.SkippedGeneratedArtifacts.Count -gt 0) {
            $skippedArtifactList = $untrackedResult.SkippedGeneratedArtifacts | ForEach-Object { "-
 $_" }
            $sections += "## Skipped Generated AI Dev Artifacts`r`n`r`n$($skippedArtifactList -join
 "`r`n")"
        }
    }

    $diffContent = $sections -join "`r`n`r`n"
    [System.IO.File]::WriteAllText($diffPath, $diffContent, $utf8WithBom)
    Save-StateResult $state "passed" ""
} catch {
    Save-StateResult $state "failed" $_.Exception.Message
    Stop-WithError "git diff 저장에 실패했습니다: $($_.Exception.Message)"
}

Write-Host "git diff 저장 완료: $diffRelativePath"
Write-Host "상태 저장 완료: $stateRelativePath"

if (-not $IncludeUntrackedContent) {
    Write-Host "untracked 파일 내용이 필요하면 -IncludeUntrackedContent 옵션을 사용하세요."
}

 succeeded in 2181ms:
param(
    [switch]$Strict
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$goalRelativePath = ".ai-dev/goal.md"
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$testResultRelativePath = ".ai-dev/test-result.md"
$diffRelativePath = ".ai-dev/diff.md"
$reviewPromptRelativePath = ".ai-dev/review-prompt.md"

$goalPath = Join-Path $projectRoot $goalRelativePath
$queuePath = Join-Path $projectRoot $queueRelativePath
$statePath = Join-Path $projectRoot $stateRelativePath
$testResultPath = Join-Path $projectRoot $testResultRelativePath
$diffPath = Join-Path $projectRoot $diffRelativePath
$reviewPromptPath = Join-Path $projectRoot $reviewPromptRelativePath
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)

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

function Stop-ForMissingFields {
    param(
        [string]$SourceName,
        [string[]]$MissingFields
    )

    if ($MissingFields.Count -eq 0) {
        return
    }

    Write-Host "$SourceName 누락 필드:"
    foreach ($field in $MissingFields) {
        Write-Host "  - $field"
    }

    Stop-WithError "$SourceName 필수 필드가 누락되었습니다."
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

function Convert-ToMarkdownList {
    param(
        [object]$Value
    )

    if ($null -eq $Value -or @($Value).Count -eq 0) {
        return "- 없음"
    }

    return (@($Value) | ForEach-Object { "- $_" }) -join "`r`n"
}

foreach ($requiredPath in @(
    $goalRelativePath,
    $queueRelativePath,
    $stateRelativePath,
    $testResultRelativePath,
    $diffRelativePath
)) {
    $fullPath = Join-Path $projectRoot $requiredPath

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        Stop-WithError "필수 파일이 없습니다: $requiredPath"
    }
}

$goalContent = Get-Content -Raw -Encoding UTF8 -LiteralPath $goalPath
$queue = Read-JsonFile $queuePath $queueRelativePath
$state = Read-JsonFile $statePath $stateRelativePath
$testResultContent = Get-Content -Raw -Encoding UTF8 -LiteralPath $testResultPath
$diffContent = Get-Content -Raw -Encoding UTF8 -LiteralPath $diffPath

$queueRequiredFields = @(
    "goalTitle",
    "currentTaskId",
    "tasks"
)
$stateRequiredFields = @(
    "goalStatus",
    "currentTaskId"
)

Stop-ForMissingFields $queueRelativePath (Get-MissingFields $queue $queueRequiredFields)
Stop-ForMissingFields $stateRelativePath (Get-MissingFields $state $stateRequiredFields)

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
    $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-Object -First 
1

    if ($null -ne $inProgressTask) {
        $currentTaskId = [string]$inProgressTask.id
    } else {
        $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Object -First 1

        if ($null -ne $pendingTask) {
            $currentTaskId = [string]$pendingTask.id
        }
    }
}

if (-not (Test-HasValue $currentTaskId)) {
    Stop-WithError "리뷰할 task가 없습니다."
}

$currentTask = $tasks | Where-Object { $_.id -eq $currentTaskId } | Select-Object -First 1

if ($null -eq $currentTask) {
    Stop-WithError "currentTaskId에 해당하는 task를 찾을 수 없습니다: $currentTaskId"
}

$taskRequiredFields = @(
    "id",
    "title",
    "description",
    "type",
    "status",
    "priority",
    "dependsOn",
    "verification"
)

Stop-ForMissingFields "task $currentTaskId" (Get-MissingFields $currentTask $taskRequiredFields)

$dependsOnText = Convert-ToMarkdownList $currentTask.dependsOn
$verificationText = Convert-ToMarkdownList $currentTask.verification
$strictCriteria = if ($Strict) {
@"
- 작은 불확실성도 revise로 판정한다.
- 테스트가 없거나 skipped이면 revise 후보로 본다.
- task 범위를 벗어난 파일 수정은 high 이상으로 판정한다.
- package 변경은 기본적으로 blocked 후보로 본다.
"@
} else {
    "- Strict 추가 기준 없음"
}

$outputFormat = @'
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
'@

$reviewPromptContent = @"
# AI Dev Review Prompt

## Role

너는 이 저장소의 엄격한 코드 리뷰어다.

## Review Goal

- 현재 task의 변경사항이 목표와 일치하는지 검토한다.
- 빌드/테스트 결과와 git diff를 함께 검토한다.
- 리뷰 판단은 `App Change Files`와 diff 본문의 실제 앱 변경 파일을 중심으로 수행한다.
- `.ai-dev` 파일은 자동화 상태/로그/프롬프트 산출물로 별도 확인하되, 앱 변경 결함으로 과대평가하지 않는다.
- 다음 task 범위까지 미리 구현했는지 확인한다.

## Project Goal

$goalContent

## Current Task

- Task ID: $($currentTask.id)
- Title: $($currentTask.title)
- Description: $($currentTask.description)
- Type: $($currentTask.type)
- Status: $($currentTask.status)
- Priority: $($currentTask.priority)
- Depends on:
$dependsOnText
- Verification:
$verificationText

## Test Result

$testResultContent

## Diff To Review

$diffContent

## Review Criteria

- 현재 task 요구사항을 충족했는가
- 실제 앱 변경 파일과 `.ai-dev` 운영 산출물이 구분되어 있는가
- `.ai-dev` 운영 산출물만 변경된 경우 앱 변경 리뷰로 과대평가하지 않았는가
- 현재 task 범위를 벗어나지 않았는가
- 다음 task를 미리 구현하지 않았는가
- 기존 기능을 깨뜨릴 가능성이 있는가
- 데이터 삭제, 초기화, 복원 같은 위험 작업이 포함되었는가
- package.json 또는 package-lock.json을 불필요하게 수정했는가
- 검증 결과가 충분한가
- 문서나 수동검증 체크리스트 갱신이 필요한가
- 더 단순한 구현이 가능한가

### Strict Criteria

$strictCriteria

## Output Format

리뷰 결과는 아래 JSON 형식만 출력한다. JSON 앞뒤에 설명, Markdown 코드 펜스, 추가 문장을 출력하지 않는다.

$outputFormat

## Decision Rules

- pass: 현재 task 요구사항 충족, 치명적 문제 없음, 다음 task로 넘어가도 됨
- revise: 수정이 필요하지만 자동 수정 가능
- blocked: 요구사항 충돌, 데이터 위험, 패키지 추가, 대규모 리팩터링 등 사용자 판단 필요
"@

[System.IO.File]::WriteAllText($reviewPromptPath, $reviewPromptContent, $utf8WithBom)

Write-Host "생성된 리뷰 프롬프트 파일: $reviewPromptRelativePath"
Write-Host "Current task id: $($currentTask.id)"
Write-Host "Current task title: $($currentTask.title)"
Write-Host "Strict 사용 여부: $($Strict.IsPresent)"

codex
{
  "decision": "pass",
  "severity": "low",
  "summary": "실제 앱 변경 파일과 .ai-dev 운영 산출물 분리 요구사항을 충족하며, diff 본문도 앱 변경 파일 중심으로 제한되어 있습니다.",
  "required_changes": [],
  "optional_suggestions": [
    {
      "file": "scripts/ai-dev-save-diff.ps1",
      "suggestion": "향후 rename/copy 상태까지 정확히 표시하려면 porcelain 경로 파싱에서 `old -> new` 형식을 별도 처리하는 보강을 고
려할 수 있습니다."
    }
  ],
  "scope_check": {
    "within_current_task": true,
    "scope_issues": []
  },
  "test_check": {
    "build_passed": true,
    "test_passed": false,
    "lint_passed": false,
    "issues": [
      "npm run test는 BuildOnly 옵션으로 skipped였습니다.",
      "npm run lint는 BuildOnly 옵션으로 skipped였습니다."
    ]
  },
  "next_step": "complete_task"
}
tokens used
19,999
{
  "decision": "pass",
  "severity": "low",
  "summary": "실제 앱 변경 파일과 .ai-dev 운영 산출물 분리 요구사항을 충족하며, diff 본문도 앱 변경 파일 중심으로 제한되어 있습니다.",
  "required_changes": [],
  "optional_suggestions": [
    {
      "file": "scripts/ai-dev-save-diff.ps1",
      "suggestion": "향후 rename/copy 상태까지 정확히 표시하려면 porcelain 경로 파싱에서 `old -> new` 형식을 별도 처리하는 보강을 고려할 수 있습니다."
    }
  ],
  "scope_check": {
    "within_current_task": true,
    "scope_issues": []
  },
  "test_check": {
    "build_passed": true,
    "test_passed": false,
    "lint_passed": false,
    "issues": [
      "npm run test는 BuildOnly 옵션으로 skipped였습니다.",
      "npm run lint는 BuildOnly 옵션으로 skipped였습니다."
    ]
  },
  "next_step": "complete_task"
}

```