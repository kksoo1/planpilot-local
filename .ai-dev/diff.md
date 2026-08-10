# AI Dev Diff

## Generated At

2026-08-10 16:27:12

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/revise-prompt.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-commit.ps1
 M scripts/ai-dev-test.ps1
?? .ai-dev/auto-goal-planning-prompt.md
```

## App Change Files

- scripts/ai-dev-commit.ps1
- scripts/ai-dev-test.ps1

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/revise-prompt.md
- .ai-dev/state.json
- .ai-dev/test-result.md
- .ai-dev/auto-goal-planning-prompt.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-commit.ps1 |  63 ++++++++++--
 scripts/ai-dev-test.ps1   | 241 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 294 insertions(+), 10 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-commit.ps1 b/scripts/ai-dev-commit.ps1
index 44338ef..4cb1051 100644
--- a/scripts/ai-dev-commit.ps1
+++ b/scripts/ai-dev-commit.ps1
@@ -150,6 +150,12 @@ function Convert-ToRepoPathspec {
 
     $trimmedPathspec = $Pathspec.Trim()
     $normalizedPathspec = $trimmedPathspec.Replace('\', '/')
+    $pathSegments = @($normalizedPathspec -split "/" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
+
+    if ($pathSegments -contains "..") {
+        Stop-WithError "상위 디렉터리 traversal 경로는 선택할 수 없습니다: $Pathspec"
+    }
+
     $projectRootFullPath = [System.IO.Path]::GetFullPath($projectRoot).TrimEnd('\', '/')
     $projectRootPrefix = $projectRootFullPath + [System.IO.Path]::DirectorySeparatorChar
 
@@ -172,7 +178,49 @@ function Convert-ToRepoPathspec {
         return $relativePath.Replace('\', '/')
     }
 
-    return $normalizedPathspec.TrimStart('/')
+    $relativePathFromFullPath = $fullPath.Substring($projectRootPrefix.Length)
+    return $relativePathFromFullPath.Replace('\', '/').TrimStart('/')
+}
+
+function Test-IsPathInScope {
+    param(
+        [string]$ChangedPath,
+        [string]$ScopePath
+    )
+
+    $normalizedChangedPath = $ChangedPath.Replace('\', '/').TrimStart('/')
+    $normalizedScopePath = $ScopePath.Replace('\', '/').TrimStart('/').TrimEnd('/')
+    $scopePrefix = $normalizedScopePath + "/"
+
+    return (
+        $normalizedChangedPath.Equals($normalizedScopePath, [System.StringComparison]::OrdinalIgnoreCase) -or
+        $normalizedChangedPath.StartsWith($scopePrefix, [System.StringComparison]::OrdinalIgnoreCase)
+    )
+}
+
+function Get-ChangedPathsForScope {
+    param(
+        [string]$ScopePath
+    )
+
+    try {
+        $fileStatus = Invoke-GitCapture -Arguments @("status", "--porcelain", "--untracked-files=all", "--", $ScopePath) -DisplayName "git status --porcelain --untracked-files=all -- $ScopePath"
+    } catch {
+        Stop-WithError $_.Exception.Message
+    }
+
+    if ([string]::IsNullOrWhiteSpace($fileStatus)) {
+        return @()
+    }
+
+    return @(
+        $fileStatus -split "`r?`n" |
+            Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            ForEach-Object { Convert-ToRepoPathspec $_ } |
+            Where-Object { Test-IsPathInScope $_ $ScopePath } |
+            Select-Object -Unique
+    )
 }
 
 function Convert-ToFileList {
@@ -279,19 +327,14 @@ if ($null -ne $Files -and $Files.Count -gt 0) {
             Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
         }
 
-        $normalizedFile = Convert-ToRepoPathspec $file
-
-        try {
-            $fileStatus = Invoke-GitCapture -Arguments @("status", "--porcelain", "--", $normalizedFile) -DisplayName "git status --porcelain -- $normalizedFile"
-        } catch {
-            Stop-WithError $_.Exception.Message
-        }
+        $normalizedScope = Convert-ToRepoPathspec $file
+        $changedPathsInScope = @(Get-ChangedPathsForScope $normalizedScope)
 
-        if ([string]::IsNullOrWhiteSpace($fileStatus)) {
+        if ($changedPathsInScope.Count -eq 0) {
             Stop-WithError "선택한 파일에 커밋할 변경사항이 없습니다: $file"
         }
 
-        $selectedFiles += $normalizedFile
+        $selectedFiles += $changedPathsInScope
     }
 
     $selectedFiles = @($selectedFiles | Select-Object -Unique)
diff --git a/scripts/ai-dev-test.ps1 b/scripts/ai-dev-test.ps1
index 78447f6..2a53635 100644
--- a/scripts/ai-dev-test.ps1
+++ b/scripts/ai-dev-test.ps1
@@ -579,6 +579,176 @@ function Invoke-IsolatedScenario {
     }
 }
 
+function Invoke-CommitScopeScenario {
+    param(
+        [Parameter(Mandatory = $true)]
+        [string]$Name,
+
+        [Parameter(Mandatory = $true)]
+        [string[]]$ScopeArgs,
+
+        [string[]]$ExpectedCommittedFiles = @(),
+
+        [string[]]$ChangedFiles = @(),
+
+        [string[]]$DeletedFiles = @(),
+
+        [string[]]$StagedOutsideFiles = @(),
+
+        [bool]$ExpectSuccess = $true,
+
+        [string]$ExpectedOutputFragment = ""
+    )
+
+    $tmpRoot = Join-Path $env:TEMP (
+        "planpilot-test-" +
+        $Name +
+        "-" +
+        (Get-Date -Format "yyyyMMddHHmmssfff")
+    )
+
+    $scenarioRoot = New-IsolatedScenarioRoot -Name $Name -Root $tmpRoot
+
+    if ($scenarioRoot.Cleanup -eq "none") {
+        Write-TestResult `
+            -Name "$Name isolated repository creation" `
+            -Passed $false `
+            -Detail $scenarioRoot.Error
+
+        return
+    }
+
+    try {
+        Copy-Item `
+            -LiteralPath (
+                Join-Path $repoRoot "scripts\ai-dev-commit.ps1"
+            ) `
+            -Destination (
+                Join-Path $tmpRoot "scripts\ai-dev-commit.ps1"
+            ) `
+            -Force
+
+        & git -C $tmpRoot config user.email "ai-dev-test@example.invalid" | Out-Null
+        & git -C $tmpRoot config user.name "AI Dev Test" | Out-Null
+
+        $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
+
+        foreach ($changedFile in @($ChangedFiles)) {
+            $changedPath = Join-Path $tmpRoot $changedFile
+            $changedDirectory = Split-Path -Parent $changedPath
+
+            if (-not [string]::IsNullOrWhiteSpace($changedDirectory)) {
+                [System.IO.Directory]::CreateDirectory($changedDirectory) | Out-Null
+            }
+
+            [System.IO.File]::WriteAllText(
+                $changedPath,
+                "changed by commit scope test $Name",
+                $utf8WithBom
+            )
+        }
+
+        foreach ($deletedFile in @($DeletedFiles)) {
+            $deletedPath = Join-Path $tmpRoot $deletedFile
+
+            if ([System.IO.File]::Exists($deletedPath)) {
+                [System.IO.File]::Delete($deletedPath)
+            }
+        }
+
+        foreach ($stagedOutsideFile in @($StagedOutsideFiles)) {
+            $stagedPath = Join-Path $tmpRoot $stagedOutsideFile
+            $stagedDirectory = Split-Path -Parent $stagedPath
+
+            if (-not [string]::IsNullOrWhiteSpace($stagedDirectory)) {
+                [System.IO.Directory]::CreateDirectory($stagedDirectory) | Out-Null
+            }
+
+            [System.IO.File]::WriteAllText(
+                $stagedPath,
+                "staged outside commit scope test $Name",
+                $utf8WithBom
+            )
+
+            & git -C $tmpRoot add -- $stagedOutsideFile | Out-Null
+        }
+
+        Push-Location $tmpRoot
+
+        try {
+            $previousErrorActionPreference = $ErrorActionPreference
+            $ErrorActionPreference = "Continue"
+            $output = & powershell `
+                -NoProfile `
+                -ExecutionPolicy Bypass `
+                -File ".\scripts\ai-dev-commit.ps1" `
+                -Message "test: commit scope $Name" `
+                -Files ($ScopeArgs -join ",") `
+                -AllowWithoutPassedCheck `
+                -AllowWithoutPassedReview 2>&1
+            $scenarioExitCode = $LASTEXITCODE
+            $outputText = $output | Out-String
+        }
+        finally {
+            $ErrorActionPreference = $previousErrorActionPreference
+            Pop-Location
+        }
+
+        if ($ExpectSuccess) {
+            $committedFiles = @(
+                & git -C $tmpRoot diff-tree --no-commit-id --name-only -r HEAD |
+                    ForEach-Object { $_.Replace('\', '/') } |
+                    Sort-Object
+            )
+            $expectedFiles = @(
+                $ExpectedCommittedFiles |
+                    ForEach-Object { $_.Replace('\', '/') } |
+                    Sort-Object
+            )
+            $unexpectedCommittedFiles = @($committedFiles | Where-Object { $expectedFiles -notcontains $_ })
+            $missingCommittedFiles = @($expectedFiles | Where-Object { $committedFiles -notcontains $_ })
+
+            Write-TestResult `
+                -Name "$Name commit succeeds" `
+                -Passed ($scenarioExitCode -eq 0) `
+                -Detail "ExitCode=$scenarioExitCode OutputPreview=$((($outputText.Replace("`r", " ").Replace("`n", " ")).Trim()))"
+
+            Write-TestResult `
+                -Name "$Name committed file scope" `
+                -Passed ($unexpectedCommittedFiles.Count -eq 0 -and $missingCommittedFiles.Count -eq 0) `
+                -Detail (
+                    "Expected=" +
+                    ($expectedFiles -join ", ") +
+                    " Actual=" +
+                    ($committedFiles -join ", ") +
+                    " Missing=" +
+                    ($missingCommittedFiles -join ", ") +
+                    " Unexpected=" +
+                    ($unexpectedCommittedFiles -join ", ")
+                )
+        } else {
+            $fragmentMatched = (
+                [string]::IsNullOrWhiteSpace($ExpectedOutputFragment) -or
+                $outputText.Contains($ExpectedOutputFragment)
+            )
+
+            Write-TestResult `
+                -Name "$Name commit blocked" `
+                -Passed ($scenarioExitCode -ne 0 -and $fragmentMatched) `
+                -Detail "ExitCode=$scenarioExitCode ExpectedFragment=$ExpectedOutputFragment OutputPreview=$((($outputText.Replace("`r", " ").Replace("`n", " ")).Trim()))"
+        }
+    }
+    catch {
+        Write-TestResult `
+            -Name "$Name execution" `
+            -Passed $false `
+            -Detail ("Line={0} Message={1}" -f $_.InvocationInfo.ScriptLineNumber, $_.Exception.Message)
+    }
+    finally {
+        Remove-IsolatedScenarioRoot -ScenarioRoot $scenarioRoot
+    }
+}
+
 function Set-JsonFile {
     param(
         [Parameter(Mandatory = $true)]
@@ -1886,6 +2056,77 @@ Invoke-IsolatedScenario `
         "-MaxSteps", "40"
     )
 
+Invoke-CommitScopeScenario `
+    -Name "commit-scope-ai-company-directory" `
+    -ScopeArgs @(".ai-company/") `
+    -ChangedFiles @(
+        ".ai-company/customer-requests.json",
+        ".ai-company/reports/adapter-plan.md",
+        ".ai-company/reports/new-scope-report.md"
+    ) `
+    -DeletedFiles @(".ai-company/customer-decisions.json") `
+    -ExpectedCommittedFiles @(
+        ".ai-company/customer-requests.json",
+        ".ai-company/reports/adapter-plan.md",
+        ".ai-company/reports/new-scope-report.md",
+        ".ai-company/customer-decisions.json"
+    )
+
+Invoke-CommitScopeScenario `
+    -Name "commit-scope-reports-directory" `
+    -ScopeArgs @(".ai-company/reports/") `
+    -ChangedFiles @(".ai-company/reports/adapter-plan.md") `
+    -ExpectedCommittedFiles @(".ai-company/reports/adapter-plan.md")
+
+Invoke-CommitScopeScenario `
+    -Name "commit-scope-new-directory" `
+    -ScopeArgs @("ai-software-company/") `
+    -ChangedFiles @(
+        "ai-software-company/notes.md",
+        "ai-software-company/reports/summary.md"
+    ) `
+    -ExpectedCommittedFiles @(
+        "ai-software-company/notes.md",
+        "ai-software-company/reports/summary.md"
+    )
+
+Invoke-CommitScopeScenario `
+    -Name "commit-scope-file-and-directory" `
+    -ScopeArgs @(".ai-company/reports/", "scripts/ai-dev-status.ps1") `
+    -ChangedFiles @(
+        ".ai-company/reports/adapter-plan.md",
+        "scripts/ai-dev-status.ps1"
+    ) `
+    -ExpectedCommittedFiles @(
+        ".ai-company/reports/adapter-plan.md",
+        "scripts/ai-dev-status.ps1"
+    )
+
+Invoke-CommitScopeScenario `
+    -Name "commit-scope-blocks-outside-staged-file" `
+    -ScopeArgs @(".ai-company/") `
+    -ChangedFiles @(".ai-company/customer-requests.json") `
+    -StagedOutsideFiles @("scripts/ai-dev-status.ps1") `
+    -ExpectedCommittedFiles @() `
+    -ExpectSuccess $false `
+    -ExpectedOutputFragment "선택 파일 외에 이미 staged 된 파일"
+
+Invoke-CommitScopeScenario `
+    -Name "commit-scope-blocks-repo-outside-path" `
+    -ScopeArgs @($env:TEMP) `
+    -ChangedFiles @(".ai-company/customer-requests.json") `
+    -ExpectedCommittedFiles @() `
+    -ExpectSuccess $false `
+    -ExpectedOutputFragment "저장소 밖 파일"
+
+Invoke-CommitScopeScenario `
+    -Name "commit-scope-blocks-traversal-path" `
+    -ScopeArgs @("../outside.txt") `
+    -ChangedFiles @(".ai-company/customer-requests.json") `
+    -ExpectedCommittedFiles @() `
+    -ExpectSuccess $false `
+    -ExpectedOutputFragment "traversal"
+
 Invoke-ReviewRequiredFilesRecoveryScenario `
     -Name "review-required-files-partial-diff" `
     -RequiredFiles @("A.ps1", "B.ps1") `
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```