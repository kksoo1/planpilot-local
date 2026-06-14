# AI Dev Diff

## Generated At

2026-06-14 21:47:47

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
 M scripts/ai-dev-auto-cycle-full.ps1
 M scripts/ai-dev-commit.ps1
 M scripts/ai-dev-next.ps1
```

## App Change Files

- scripts/ai-dev-auto-cycle-full.ps1
- scripts/ai-dev-commit.ps1
- scripts/ai-dev-next.ps1

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
 scripts/ai-dev-auto-cycle-full.ps1 | 136 ++++++++++++++++++++++++++++++++++++-
 scripts/ai-dev-commit.ps1          |  68 ++++++++++++++-----
 scripts/ai-dev-next.ps1            |  80 +++++++++++++++++++---
 3 files changed, 254 insertions(+), 30 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index a1eb93a..7e86eff 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -16,6 +16,7 @@ $repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
 $queueRelativePath = ".ai-dev/queue.json"
 $stateRelativePath = ".ai-dev/state.json"
 $reviewResponseRelativePath = ".ai-dev/review-response.json"
+$aiDevOperationalRoot = ".ai-dev/"
 $queuePath = Join-Path $repoRoot $queueRelativePath
 $statePath = Join-Path $repoRoot $stateRelativePath
 $reviewResponsePath = Join-Path $repoRoot $reviewResponseRelativePath
@@ -248,6 +249,61 @@ function Test-PackageFileChanged {
     return -not [string]::IsNullOrWhiteSpace($status)
 }
 
+function Convert-ToChangedPath {
+    param(
+        [string]$ChangeLine
+    )
+
+    if ([string]::IsNullOrWhiteSpace($ChangeLine)) {
+        return @()
+    }
+
+    $pathText = $ChangeLine
+
+    if ($ChangeLine.Length -ge 4 -and $ChangeLine.Substring(2, 1) -eq " ") {
+        $pathText = $ChangeLine.Substring(3)
+    }
+
+    if ($pathText.Contains(" -> ")) {
+        return @($pathText -split " -> " | Where-Object { Test-HasValue $_ })
+    }
+
+    return @($pathText)
+}
+
+function Test-IsAiDevOperationalPath {
+    param(
+        [string]$RelativePath
+    )
+
+    $normalizedRelativePath = $RelativePath.Replace('\', '/')
+    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::OrdinalIgnoreCase)
+}
+
+function Get-ChangedNonAiDevFiles {
+    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
+    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
+
+    return @(
+        $changeLines |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            Where-Object { (Test-HasValue $_) -and -not (Test-IsAiDevOperationalPath $_) } |
+            Select-Object -Unique
+    )
+}
+
+function Get-ChangedAiDevOperationalFiles {
+    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
+    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
+
+    return @(
+        $changeLines |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            Where-Object { (Test-HasValue $_) -and (Test-IsAiDevOperationalPath $_) } |
+            Select-Object -Unique
+    )
+}
+
 function Get-ReviewGate {
     $state = Read-JsonFile $statePath $stateRelativePath
     $nextStep = $null
@@ -277,11 +333,69 @@ function Get-CommitArguments {
             $arguments += "-Files"
             $arguments += ($normalizedFiles -join ",")
         }
+
+        return $arguments
+    }
+
+    $implementationFiles = Get-ChangedNonAiDevFiles
+
+    if ($implementationFiles.Count -gt 0) {
+        $arguments += "-Files"
+        $arguments += ($implementationFiles -join ",")
     }
 
     return $arguments
 }
 
+function Invoke-DirectMetaCommit {
+    param(
+        [int]$StepNumber
+    )
+
+    $command = "direct meta commit: git add scoped .ai-dev files, git commit -m 'chore(ai-dev): record task completion', git status --short"
+
+    try {
+        $changedAiDevFiles = Get-ChangedAiDevOperationalFiles
+
+        if ($changedAiDevFiles.Count -eq 0) {
+            $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "git status --short"
+
+            if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
+                throw ".ai-dev 메타 변경사항은 없지만 worktree에 변경 파일이 남아 있습니다.`n$remainingStatus"
+            }
+
+            $script:steps += New-StepResult $StepNumber "meta-commit" $command $false $true 0 ".ai-dev 메타 상태 변경사항이 없어 meta commit을 건너뜁니다. worktree clean."
+            return
+        }
+
+        $addOutput = & git add -- $changedAiDevFiles 2>&1 | Out-String
+        $addExitCode = $LASTEXITCODE
+
+        if ($addExitCode -ne 0) {
+            throw "git add 실행에 실패했습니다. exit code: $addExitCode`n$addOutput"
+        }
+
+        $commitOutput = & git commit -m "chore(ai-dev): record task completion" -- $changedAiDevFiles 2>&1 | Out-String
+        $commitExitCode = $LASTEXITCODE
+
+        if ($commitExitCode -ne 0) {
+            throw "git commit 실행에 실패했습니다. exit code: $commitExitCode`n$commitOutput"
+        }
+
+        $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "git status --short"
+
+        if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
+            throw "meta commit 이후 worktree에 변경 파일이 남아 있습니다.`n$remainingStatus"
+        }
+
+        $message = ($commitOutput.Trim(), "worktree clean") -join "`n"
+        $script:steps += New-StepResult $StepNumber "meta-commit" $command $true $false 0 $message
+    } catch {
+        $script:steps += New-StepResult $StepNumber "meta-commit" $command $true $false 1 $_.Exception.Message
+        Stop-Cycle $script:steps "meta_commit_failed" $false 1
+    }
+}
+
 function Get-CommitGate {
     param(
         [string]$PreviousHeadCommitHash
@@ -367,6 +481,7 @@ try {
 }
 
 $plannedSteps = @(
+    "task-start",
     "make-prompt",
     "run-codex",
     "check",
@@ -377,7 +492,8 @@ $plannedSteps = @(
     "package-change-gate",
     "commit",
     "commit-result-gate",
-    "complete-task"
+    "complete-task",
+    "meta-commit"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -482,6 +598,8 @@ while ($completedTaskCount -lt $MaxTasks) {
         $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
         $stepNumber++
         $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료`" -CommitHash <commit-hash>" $false $true 0 "DryRun: task 완료 처리를 실행하지 않았습니다."
+        $stepNumber++
+        $script:steps += New-StepResult $stepNumber "meta-commit" "direct meta commit: git add scoped .ai-dev files, git commit -m 'chore(ai-dev): record task completion', git status --short" $false $true 0 "DryRun: .ai-dev 메타 상태 직접 커밋을 실행하지 않았습니다."
         Stop-Cycle $script:steps "dry_run" $false 0
     }
 
@@ -538,6 +656,12 @@ while ($completedTaskCount -lt $MaxTasks) {
     }
 
     $commitArguments = Get-CommitArguments
+
+    if ($commitArguments.Count -eq 0) {
+        $script:steps += New-StepResult $stepNumber "commit" "git status --porcelain" $false $true 1 "커밋할 구현 변경사항이 없어 complete-task를 실행하지 않습니다."
+        Stop-Cycle $script:steps "no_implementation_changes" $false 1
+    }
+
     $commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
     if ($commitArguments.Count -gt 0) {
         $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
@@ -572,7 +696,17 @@ while ($completedTaskCount -lt $MaxTasks) {
     $resultSummary = "자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료"
     Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"$resultSummary`" -CommitHash $($commitGate.lastCommitHash)" $scriptPaths.completeTask @("-ResultSummary", $resultSummary, "-CommitHash", $commitGate.lastCommitHash)
     $stepNumber++
+
+    Invoke-DirectMetaCommit $stepNumber
+    $stepNumber++
+
     $completedTaskCount++
+
+    $stateAfterComplete = Read-JsonFile $statePath $stateRelativePath
+
+    if ($stateAfterComplete.goalStatus -eq "completed") {
+        Stop-Cycle $script:steps "goal_completed" $true 0
+    }
 }
 
 Stop-Cycle $script:steps "max_tasks_reached" $true 0
diff --git a/scripts/ai-dev-commit.ps1 b/scripts/ai-dev-commit.ps1
index 11d1ba9..44338ef 100644
--- a/scripts/ai-dev-commit.ps1
+++ b/scripts/ai-dev-commit.ps1
@@ -123,18 +123,56 @@ function Convert-ToChangedPath {
     )
 
     if ([string]::IsNullOrWhiteSpace($ChangeLine)) {
-        return $null
+        return @()
     }
 
-    if ($ChangeLine.StartsWith("?? ")) {
-        return $ChangeLine.Substring(3)
-    }
+    $pathText = $ChangeLine
 
     if ($ChangeLine.Length -ge 4 -and $ChangeLine.Substring(2, 1) -eq " ") {
-        return $ChangeLine.Substring(3)
+        $pathText = $ChangeLine.Substring(3)
+    }
+
+    if ($pathText.Contains(" -> ")) {
+        return @($pathText -split " -> " | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
     }
 
-    return $ChangeLine
+    return @($pathText)
+}
+
+function Convert-ToRepoPathspec {
+    param(
+        [string]$Pathspec
+    )
+
+    if ([string]::IsNullOrWhiteSpace($Pathspec)) {
+        Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
+    }
+
+    $trimmedPathspec = $Pathspec.Trim()
+    $normalizedPathspec = $trimmedPathspec.Replace('\', '/')
+    $projectRootFullPath = [System.IO.Path]::GetFullPath($projectRoot).TrimEnd('\', '/')
+    $projectRootPrefix = $projectRootFullPath + [System.IO.Path]::DirectorySeparatorChar
+
+    if ([System.IO.Path]::IsPathRooted($trimmedPathspec)) {
+        $fullPath = [System.IO.Path]::GetFullPath($trimmedPathspec)
+    } else {
+        $fullPath = [System.IO.Path]::GetFullPath((Join-Path $projectRoot $normalizedPathspec))
+    }
+
+    if ($fullPath.Equals($projectRootFullPath, [System.StringComparison]::OrdinalIgnoreCase)) {
+        Stop-WithError "저장소 루트 전체는 선택할 수 없습니다: $Pathspec"
+    }
+
+    if (-not $fullPath.StartsWith($projectRootPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
+        Stop-WithError "저장소 밖 파일은 선택할 수 없습니다: $Pathspec"
+    }
+
+    if ([System.IO.Path]::IsPathRooted($trimmedPathspec)) {
+        $relativePath = $fullPath.Substring($projectRootPrefix.Length)
+        return $relativePath.Replace('\', '/')
+    }
+
+    return $normalizedPathspec.TrimStart('/')
 }
 
 function Convert-ToFileList {
@@ -241,17 +279,7 @@ if ($null -ne $Files -and $Files.Count -gt 0) {
             Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
         }
 
-        $normalizedFile = $file.Replace('\', '/')
-        $fullPath = [System.IO.Path]::GetFullPath((Join-Path $projectRoot $normalizedFile))
-        $projectRootPrefix = [System.IO.Path]::GetFullPath($projectRoot).TrimEnd('\', '/') + [System.IO.Path]::DirectorySeparatorChar
-
-        if (-not $fullPath.StartsWith($projectRootPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
-            Stop-WithError "저장소 밖 파일은 선택할 수 없습니다: $file"
-        }
-
-        if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
-            Stop-WithError "선택한 파일이 존재하지 않습니다: $file"
-        }
+        $normalizedFile = Convert-ToRepoPathspec $file
 
         try {
             $fileStatus = Invoke-GitCapture -Arguments @("status", "--porcelain", "--", $normalizedFile) -DisplayName "git status --porcelain -- $normalizedFile"
@@ -301,7 +329,11 @@ $taskText = if ($null -ne $currentTask) {
     "unknown"
 }
 
-$targetChangedPaths = @($targetChangeLines | ForEach-Object { Convert-ToChangedPath $_ } | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique)
+if ($selectedFiles.Count -gt 0) {
+    $targetChangedPaths = @($selectedFiles | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique)
+} else {
+    $targetChangedPaths = @($targetChangeLines | ForEach-Object { Convert-ToChangedPath $_ } | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique)
+}
 $targetAppChangePaths = @($targetChangedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
 $targetAiDevOperationalPaths = @($targetChangedPaths | Where-Object { Test-IsAiDevOperationalPath $_ })
 
diff --git a/scripts/ai-dev-next.ps1 b/scripts/ai-dev-next.ps1
index bbb3569..5c2d172 100644
--- a/scripts/ai-dev-next.ps1
+++ b/scripts/ai-dev-next.ps1
@@ -129,6 +129,51 @@ if (Test-HasValue $currentTaskId) {
 
 $gitStatus = "unavailable"
 $gitChangedFilesCount = $null
+$gitImplementationChangedFilesCount = $null
+
+$aiDevOperationalRelativePaths = @(
+    ".ai-dev/state.json",
+    ".ai-dev/queue.json",
+    ".ai-dev/loop-log.md",
+    ".ai-dev/review.md",
+    ".ai-dev/review-response.json",
+    ".ai-dev/diff.md",
+    ".ai-dev/codex-result.md",
+    ".ai-dev/codex-review-result.md",
+    ".ai-dev/current-task-prompt.md",
+    ".ai-dev/test-result.md"
+)
+
+function ConvertTo-GitRelativePath {
+    param(
+        [string]$Path
+    )
+
+    return ($Path -replace "\\", "/").Trim()
+}
+
+function Test-IsAiDevOperationalPath {
+    param(
+        [string]$Path
+    )
+
+    $normalizedPath = ConvertTo-GitRelativePath $Path
+    return $normalizedPath -eq ".ai-dev" -or $normalizedPath -like ".ai-dev/*" -or $aiDevOperationalRelativePaths -contains $normalizedPath
+}
+
+function Get-GitStatusPaths {
+    param(
+        [string]$StatusLine
+    )
+
+    $pathText = $StatusLine.Substring(3).Trim()
+
+    if ($pathText -like "* -> *") {
+        return @($pathText -split " -> " | ForEach-Object { ConvertTo-GitRelativePath $_ })
+    }
+
+    return @(ConvertTo-GitRelativePath $pathText)
+}
 
 try {
     $null = & git rev-parse --show-toplevel 2>&1
@@ -137,7 +182,16 @@ try {
         $gitOutput = & git status --porcelain 2>&1 | Out-String
 
         if ($LASTEXITCODE -eq 0) {
-            $gitChangedFilesCount = @($gitOutput -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }).Count
+            $gitChangedFiles = @($gitOutput -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
+            $gitImplementationChangedFiles = @(
+                $gitChangedFiles | Where-Object {
+                    $changedPaths = @(Get-GitStatusPaths $_)
+                    @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) }).Count -gt 0
+                }
+            )
+
+            $gitChangedFilesCount = $gitChangedFiles.Count
+            $gitImplementationChangedFilesCount = $gitImplementationChangedFiles.Count
             $gitStatus = "available"
         }
     }
@@ -159,6 +213,8 @@ $lastReviewSeverity = if (Test-HasValue $state.lastReviewSeverity) { [string]$st
 $lastCommitHash = if (Test-HasValue $state.lastCommitHash) { [string]$state.lastCommitHash } else { "" }
 $hasGitChanges = $gitStatus -eq "available" -and $gitChangedFilesCount -gt 0
 $hasNoGitChanges = $gitStatus -eq "available" -and $gitChangedFilesCount -eq 0
+$hasImplementationGitChanges = $gitStatus -eq "available" -and $gitImplementationChangedFilesCount -gt 0
+$hasNoImplementationGitChanges = $gitStatus -eq "available" -and $gitImplementationChangedFilesCount -eq 0
 $reviewNotStarted = Test-IsReviewNotStarted $lastReviewDecision
 $isCheckCommand = Test-IsCheckCommand $lastCommand
 
@@ -180,31 +236,31 @@ if (-not (Test-HasValue $currentTaskId) -and $goalStatus -eq "completed") {
     ) @(
         $(if ($revisePromptExists) { "기존 revise-prompt.md는 현재 리뷰 기준으로 덮어씁니다." } else { "required changes만 반영하세요." })
     )
-} elseif ($lastReviewDecision -eq "pass" -and $lastCommandStatus -eq "passed" -and $hasGitChanges) {
+} elseif ($lastReviewDecision -eq "pass" -and $lastCommandStatus -eq "passed" -and $hasImplementationGitChanges) {
     $nextAction = New-NextAction "commit" "검증과 리뷰가 통과했고 커밋할 변경사항이 있습니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
     ) @("먼저 ai-dev-commit.ps1 -DryRun으로 커밋 대상을 확인하는 것을 권장합니다.")
-} elseif ($lastReviewDecision -eq "pass" -and (Test-HasValue $lastCommitHash) -and $hasNoGitChanges) {
-    $nextAction = New-NextAction "complete_task" "리뷰와 커밋이 완료되었고 작업 트리가 깨끗합니다." @(
-        'powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary "리뷰 및 커밋 완료"'
-    ) @("다음 pending task로 이동하기 전에 현재 task 결과를 확인하세요.")
-} elseif ($hasNoGitChanges -and ($lastCommand -eq "" -or $lastCommand -eq "init" -or $lastCommand -eq "current-task")) {
+} elseif ($lastReviewDecision -eq "pass" -and (Test-HasValue $lastCommitHash) -and $hasNoImplementationGitChanges -and $lastCommand -eq "commit" -and $lastCommandStatus -eq "passed") {
+    $nextAction = New-NextAction "complete_task" "리뷰와 커밋이 완료되었고 남은 구현 변경사항이 없습니다." @(
+        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 및 커밋 완료`" -CommitHash $lastCommitHash"
+    ) @("완료 처리 시 구현 커밋 해시를 함께 전달하세요.")
+} elseif ($hasNoImplementationGitChanges -and ($lastCommand -eq "" -or $lastCommand -eq "init" -or $lastCommand -eq "current-task")) {
     $nextAction = New-NextAction "run_codex_or_cline" "현재 task 프롬프트는 준비되었고 아직 변경사항이 없습니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1"
     ) @("current-task-prompt.md를 Codex 또는 Cline에 전달해 현재 task를 수행하세요.")
-} elseif ($hasGitChanges -and $lastCommand -eq "save-diff" -and $reviewNotStarted -and -not $reviewPromptExists) {
+} elseif ($hasImplementationGitChanges -and $lastCommand -eq "save-diff" -and $reviewNotStarted -and -not $reviewPromptExists) {
     $nextAction = New-NextAction "make_review_prompt" "diff가 저장되었고 리뷰 프롬프트가 없습니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict"
     ) @("현재 diff와 검증 결과를 기준으로 리뷰 프롬프트를 생성하세요.")
-} elseif ($hasGitChanges -and $reviewPromptExists -and $reviewNotStarted) {
+} elseif ($hasImplementationGitChanges -and $reviewPromptExists -and $reviewNotStarted) {
     $nextAction = New-NextAction "ask_gpt_review" "리뷰 프롬프트가 준비되었고 아직 리뷰 결과가 없습니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard"
     ) @("review-prompt.md 내용을 GPT Chat에 붙여넣고 JSON 리뷰 결과를 받은 뒤 save-review를 실행하세요.")
-} elseif ($hasGitChanges -and $isCheckCommand -and $lastCommandStatus -eq "passed" -and (-not $diffExists -or $isCheckCommand)) {
+} elseif ($hasImplementationGitChanges -and $isCheckCommand -and $lastCommandStatus -eq "passed" -and (-not $diffExists -or $isCheckCommand)) {
     $nextAction = New-NextAction "save_diff" "검증이 통과했으며 현재 변경사항의 diff 저장이 필요합니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1"
     ) @("diff 저장 후 리뷰 프롬프트를 생성하세요.")
-} elseif ($hasGitChanges -and ($lastCommandStatus -ne "passed" -or -not $isCheckCommand)) {
+} elseif ($hasImplementationGitChanges -and ($lastCommandStatus -ne "passed" -or -not $isCheckCommand)) {
     $nextAction = New-NextAction "run_check" "변경사항이 있으며 최신 검증 통과 상태를 확인해야 합니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly"
     ) @("검증 실패 시 현재 task 범위 안에서만 수정하세요.")
@@ -239,6 +295,7 @@ $output = [ordered]@{
     lastCommitHash = $lastCommitHash
     gitStatus = $gitStatus
     gitChangedFilesCount = $gitChangedFilesCount
+    gitImplementationChangedFilesCount = $gitImplementationChangedFilesCount
     files = [ordered]@{
         currentTaskPromptExists = $currentTaskPromptExists
         testResultExists = $testResultExists
@@ -262,6 +319,7 @@ Write-Host "Goal status: $($output.goalStatus)"
 Write-Host "Last command/status: $($output.lastCommand) / $($output.lastCommandStatus)"
 Write-Host "Last review decision/severity: $($output.lastReviewDecision) / $($output.lastReviewSeverity)"
 Write-Host "Git changed files count: $($output.gitChangedFilesCount)"
+Write-Host "Git implementation changed files count: $($output.gitImplementationChangedFilesCount)"
 Write-Host "Recommended command:"
 
 if ($output.recommendedCommands.Count -eq 0) {
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```