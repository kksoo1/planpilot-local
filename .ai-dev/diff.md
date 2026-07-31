# AI Dev Diff

## Generated At

2026-07-31 15:42:47

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
 M scripts/ai-dev-auto-goal.ps1
 M scripts/ai-dev-autopilot.ps1
```

## App Change Files

- scripts/ai-dev-auto-goal.ps1
- scripts/ai-dev-autopilot.ps1

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

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-auto-goal.ps1 | 235 +++++++++++++++++++++++++++++++++-
 scripts/ai-dev-autopilot.ps1 | 295 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 512 insertions(+), 18 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 5869e33..070042f 100644
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -30,6 +30,7 @@ $legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"
 $aiDevOperationalRoot = ".ai-dev/"
 $script:autoGoalCanWriteResultFile = $true
 $script:autoGoalCanCleanTempArtifacts = $true
+$script:autoGoalOperationalFileSnapshots = @{}
 
 function Resolve-RepoPath {
     param([string]$Path)
@@ -98,9 +99,18 @@ function New-AutoGoalResult {
         [int]$ExitCode
     )
 
+    $outcomeCategory = if (Test-IsExpectedPreImplementationStop $StoppedReason) {
+        "expected_non_work"
+    } elseif ($ExitCode -eq 0) {
+        "success"
+    } else {
+        "actual_failure"
+    }
+
     return [PSCustomObject][ordered]@{
         steps = @($Steps)
         stoppedReason = $StoppedReason
+        outcomeCategory = $outcomeCategory
         completed = $Completed
         exitCode = $ExitCode
         plan = $script:autoGoalPlanPreview
@@ -145,6 +155,7 @@ function Write-AutoGoalResult {
     }
 
     Write-Host "Stopped reason: $($Result.stoppedReason)"
+    Write-Host "Outcome category: $($Result.outcomeCategory)"
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 }
@@ -172,6 +183,7 @@ function Save-AutoGoalResultFile {
 ## Summary
 
 - Stopped reason: $($result.stoppedReason)
+- Outcome category: $($result.outcomeCategory)
 - Completed: $($result.completed)
 - Exit code: $($result.exitCode)
 - Result path: $($result.resultPath)
@@ -184,6 +196,55 @@ $($stepLines -join "`r`n")
     [System.IO.File]::WriteAllText($resolvedResultPath, $content, $utf8WithBom)
 }
 
+function Invoke-AutoGoalExpectedNonWorkMetaCommit {
+    param([int]$StepNumber)
+
+    if ($DryRun) {
+        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git add/commit expected non-work result" $false $true 0 "DryRun: expected non-work result meta commit was not executed."
+    }
+
+    if (-not $AllowCommit) {
+        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git add/commit expected non-work result" $false $true 0 "AllowCommit is not set, so expected non-work result remains an uncommitted meta record."
+    }
+
+    $resultRelativePath = ConvertTo-NormalizedChangedPath (ConvertTo-RepoRelativePath $ResultPath)
+
+    if (@($script:autoGoalBaselineDirtyPaths) -contains $resultRelativePath) {
+        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git add/commit expected non-work result" $false $true 0 "Expected non-work result meta commit skipped because ResultPath was baseline dirty and protected: $resultRelativePath"
+    }
+
+    $statusOutput = & git status --short -- $resultRelativePath 2>&1 | Out-String
+    $statusExitCode = $LASTEXITCODE
+
+    if ($statusExitCode -ne 0) {
+        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git status --short -- <result file>" $true $false 1 "git status for expected non-work result failed. exit code: $statusExitCode`n$statusOutput"
+    }
+
+    if (-not (Test-HasValue $statusOutput)) {
+        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git status --short -- <result file>" $true $false 0 "Expected non-work result file had no changes to commit."
+    }
+
+    $addOutput = & git add -- $resultRelativePath 2>&1 | Out-String
+    $addExitCode = $LASTEXITCODE
+
+    if ($addExitCode -ne 0) {
+        & git restore --staged -- $resultRelativePath 2>&1 | Out-String | Out-Null
+        $restoredPaths = @(Restore-AutoGoalCurrentRunOperationalChanges @($resultRelativePath))
+        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git add -- <result file>" $true $false 1 "Expected non-work result git add failed. exit code: $addExitCode`n$addOutput`nRestored run-owned files: $($restoredPaths -join ', ')"
+    }
+
+    $commitOutput = & git commit -m "chore(ai-dev): record expected non-work stop" -- $resultRelativePath 2>&1 | Out-String
+    $commitExitCode = $LASTEXITCODE
+
+    if ($commitExitCode -ne 0) {
+        & git restore --staged -- $resultRelativePath 2>&1 | Out-String | Out-Null
+        $restoredPaths = @(Restore-AutoGoalCurrentRunOperationalChanges @($resultRelativePath))
+        return New-StepResult $StepNumber "expected-non-work-meta-commit" "git commit -- <result file>" $true $false 1 "Expected non-work result commit failed. exit code: $commitExitCode`n$commitOutput`nRestored run-owned files: $($restoredPaths -join ', ')"
+    }
+
+    return New-StepResult $StepNumber "expected-non-work-meta-commit" "git add/commit expected non-work result" $true $false 0 $commitOutput.Trim()
+}
+
 function Clear-AutoGoalTempArtifacts {
     if (-not $script:autoGoalCanCleanTempArtifacts) {
         return
@@ -192,6 +253,12 @@ function Clear-AutoGoalTempArtifacts {
     $currentResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ResultPath))
 
     foreach ($relativePath in @($planningPromptRelativePath, $legacyAutoGoalResultRelativePath)) {
+        $normalizedRelativePath = ConvertTo-NormalizedChangedPath (ConvertTo-RepoRelativePath $relativePath)
+
+        if (@($script:autoGoalBaselineDirtyPaths) -contains $normalizedRelativePath) {
+            continue
+        }
+
         $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $relativePath))
 
         if (-not $fullPath.StartsWith($repoRoot.TrimEnd("\") + "\", [System.StringComparison]::OrdinalIgnoreCase)) {
@@ -212,6 +279,98 @@ function Clear-AutoGoalTempArtifacts {
     }
 }
 
+function Test-IsExpectedPreImplementationStop {
+    param([string]$StoppedReason)
+
+    return @(
+        "baseline_output_conflict",
+        "dirty_worktree",
+        "max_steps_too_small_for_full_cycle"
+    ) -contains $StoppedReason
+}
+
+function Initialize-AutoGoalOperationalFileSnapshots {
+    $script:autoGoalOperationalFileSnapshots = @{}
+
+    foreach ($relativePath in @(Get-PlannedAutoGoalOutputPaths)) {
+        $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $relativePath))
+
+        if (-not $fullPath.StartsWith($repoRoot.TrimEnd("\") + "\", [System.StringComparison]::OrdinalIgnoreCase)) {
+            continue
+        }
+
+        $exists = [System.IO.File]::Exists($fullPath)
+        $bytes = $null
+
+        if ($exists) {
+            $bytes = [System.IO.File]::ReadAllBytes($fullPath)
+        }
+
+        $script:autoGoalOperationalFileSnapshots[$relativePath] = [PSCustomObject][ordered]@{
+            path = $fullPath
+            existed = $exists
+            bytes = $bytes
+        }
+    }
+}
+
+function Restore-AutoGoalCurrentRunOperationalChanges {
+    param([string[]]$RelativePaths = @())
+
+    $restoredPaths = @()
+
+    if ($null -eq $script:autoGoalOperationalFileSnapshots) {
+        return @($restoredPaths)
+    }
+
+    $targetPaths = @($RelativePaths | ForEach-Object { ConvertTo-NormalizedChangedPath $_ } | Where-Object { Test-HasValue $_ } | Select-Object -Unique)
+    $baselineDirtyPaths = @($script:autoGoalBaselineDirtyPaths)
+
+    foreach ($entry in @($script:autoGoalOperationalFileSnapshots.GetEnumerator())) {
+        $relativePath = ConvertTo-NormalizedChangedPath ([string]$entry.Key)
+        $snapshot = $entry.Value
+
+        if ($targetPaths.Count -gt 0 -and $targetPaths -notcontains $relativePath) {
+            continue
+        }
+
+        if ($baselineDirtyPaths -contains $relativePath) {
+            continue
+        }
+
+        $fullPath = [string]$snapshot.path
+
+        if (-not $fullPath.StartsWith($repoRoot.TrimEnd("\") + "\", [System.StringComparison]::OrdinalIgnoreCase)) {
+            continue
+        }
+
+        try {
+            if ($snapshot.existed) {
+                [System.IO.File]::WriteAllBytes($fullPath, [byte[]]$snapshot.bytes)
+            } elseif ([System.IO.File]::Exists($fullPath)) {
+                [System.IO.File]::Delete($fullPath)
+            }
+            $restoredPaths += $relativePath
+        } catch {
+            Write-Warning "Failed to restore auto-goal operational file snapshot: $fullPath"
+        }
+    }
+
+    return @($restoredPaths | Select-Object -Unique)
+}
+
+function Test-CanWriteExpectedNonWorkResultFile {
+    $resultRelativePath = ConvertTo-NormalizedChangedPath (ConvertTo-RepoRelativePath $ResultPath)
+    $snapshot = $script:autoGoalOperationalFileSnapshots[$resultRelativePath]
+    $baselineDirtyPaths = @($script:autoGoalBaselineDirtyPaths)
+
+    if ($null -ne $snapshot -and $snapshot.existed -and $baselineDirtyPaths -contains $resultRelativePath) {
+        return $false
+    }
+
+    return $true
+}
+
 function Stop-AutoGoal {
     param(
         [object[]]$Steps,
@@ -220,19 +379,72 @@ function Stop-AutoGoal {
         [int]$ExitCode
     )
 
+    $isExpectedPreImplementationStop = Test-IsExpectedPreImplementationStop $StoppedReason
+
     if (-not $DryRun) {
         Clear-AutoGoalTempArtifacts
+
+        if ($isExpectedPreImplementationStop) {
+            $cleanedRunOwnedPaths = @(Restore-AutoGoalCurrentRunOperationalChanges)
+            $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-cleanup" "restore current-run .ai-dev operational file snapshots" $true $false 0 "Expected pre-implementation stop. Restored only auto-goal operational files captured at run start; baseline user changes were preserved. Cleaned run-owned files: $($cleanedRunOwnedPaths -join ', ')"
+        }
     }
 
+    $script:steps = @($Steps)
+
     if (-not $DryRun -and (-not $Completed -or $ExitCode -ne 0)) {
         if ($script:autoGoalCanWriteResultFile) {
-            Save-AutoGoalResultFile $StoppedReason $false $ExitCode
+            if ($isExpectedPreImplementationStop) {
+                if ($AllowCommit) {
+                    if (Test-CanWriteExpectedNonWorkResultFile) {
+                        $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-meta-record" "write expected non-work final result" $true $false 0 "Expected pre-implementation stop is recorded as outcomeCategory=expected_non_work in the final result file because -AllowCommit is set."
+                        $script:steps = @($Steps)
+                        Save-AutoGoalResultFile $StoppedReason $false $ExitCode
+                        $metaCommitStep = Invoke-AutoGoalExpectedNonWorkMetaCommit ($Steps.Count + 1)
+                        $Steps += $metaCommitStep
+                        $script:steps = @($Steps)
+
+                        if ($metaCommitStep.exitCode -ne 0) {
+                            $originalStoppedReason = $StoppedReason
+                            $StoppedReason = "expected_non_work_meta_commit_failed"
+                            $isExpectedPreImplementationStop = $false
+                            $Completed = $false
+                            $ExitCode = 1
+                            $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-meta-failure" "classify expected non-work meta commit failure" $true $false 1 "Expected pre-implementation stop meta commit failed and is reclassified as actual_failure. Original stopped reason: $originalStoppedReason"
+                            $script:steps = @($Steps)
+                        }
+                    } else {
+                        $resultRelativePath = ConvertTo-NormalizedChangedPath (ConvertTo-RepoRelativePath $ResultPath)
+                        $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-meta-record" "write expected non-work final result" $false $true 0 "Expected pre-implementation stop is reported in console output only. ResultPath existed at run start and was baseline dirty, so auto-goal did not overwrite preserved user changes: $resultRelativePath"
+                        $script:steps = @($Steps)
+                    }
+                } else {
+                    $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-meta-record" "write expected non-work final result" $false $true 0 "Expected pre-implementation stop is reported in console output only. -AllowCommit is not set, so no result file or other .ai-dev operational change is left behind."
+                    $script:steps = @($Steps)
+                }
+            } else {
+                Save-AutoGoalResultFile $StoppedReason $false $ExitCode
+            }
         }
     }
     Write-AutoGoalResult (New-AutoGoalResult $Steps $StoppedReason $Completed $ExitCode)
     exit $ExitCode
 }
 
+function Get-StoppedReasonFromOutput {
+    param([string]$Output)
+
+    if (-not (Test-HasValue $Output)) {
+        return ""
+    }
+
+    if ($Output -match '(?m)^\s*Stopped reason:\s*(\S+)\s*$') {
+        return $Matches[1]
+    }
+
+    return ""
+}
+
 function Get-InputPreview {
     param([string]$RawInput)
 
@@ -437,8 +649,10 @@ function Invoke-FinalAutoGoalChangeGate {
     $addExitCode = $LASTEXITCODE
 
     if ($addExitCode -ne 0) {
+        & git restore --staged -- $newAiDevPaths 2>&1 | Out-String | Out-Null
+        $restoredPaths = @(Restore-AutoGoalCurrentRunOperationalChanges $newAiDevPaths)
         $message = "auto-goal 최종 .ai-dev 메타 변경 git add 실패. exit code: $addExitCode`n$addOutput"
-        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-dev files>" $true $false 1 $message
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-dev files>" $true $false 1 "$message`nRestored run-owned files: $($restoredPaths -join ', ')"
         Stop-AutoGoal $script:steps "final_meta_add_failed" $false 1
     }
 
@@ -448,8 +662,10 @@ function Invoke-FinalAutoGoalChangeGate {
     $commitExitCode = $LASTEXITCODE
 
     if ($commitExitCode -ne 0) {
+        & git restore --staged -- $newAiDevPaths 2>&1 | Out-String | Out-Null
+        $restoredPaths = @(Restore-AutoGoalCurrentRunOperationalChanges $newAiDevPaths)
         $message = "auto-goal 최종 .ai-dev 메타 커밋 실패. exit code: $commitExitCode`n$commitOutput"
-        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m '$metaCommitMessage' -- <final .ai-dev files>" $true $false 1 $message
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m '$metaCommitMessage' -- <final .ai-dev files>" $true $false 1 "$message`nRestored run-owned files: $($restoredPaths -join ', ')"
         Stop-AutoGoal $script:steps "final_meta_commit_failed" $false 1
     }
 
@@ -588,8 +804,10 @@ function Invoke-FinalPreparedResultGate {
     $addExitCode = $LASTEXITCODE
 
     if ($addExitCode -ne 0) {
+        & git restore --staged -- $newAiDevPaths 2>&1 | Out-String | Out-Null
+        $restoredPaths = @(Restore-AutoGoalCurrentRunOperationalChanges $newAiDevPaths)
         $message = "auto-goal 최종 .ai-dev 메타 변경 git add 실패. exit code: $addExitCode`n$addOutput"
-        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-dev files>" $true $false 1 $message
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-dev files>" $true $false 1 "$message`nRestored run-owned files: $($restoredPaths -join ', ')"
         Stop-AutoGoal $script:steps "final_meta_add_failed" $false 1
     }
 
@@ -599,8 +817,10 @@ function Invoke-FinalPreparedResultGate {
     $commitExitCode = $LASTEXITCODE
 
     if ($commitExitCode -ne 0) {
+        & git restore --staged -- $newAiDevPaths 2>&1 | Out-String | Out-Null
+        $restoredPaths = @(Restore-AutoGoalCurrentRunOperationalChanges $newAiDevPaths)
         $message = "auto-goal 최종 .ai-dev 메타 커밋 실패. exit code: $commitExitCode`n$commitOutput"
-        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m '$metaCommitMessage' -- <final .ai-dev files>" $true $false 1 $message
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m '$metaCommitMessage' -- <final .ai-dev files>" $true $false 1 "$message`nRestored run-owned files: $($restoredPaths -join ', ')"
         Stop-AutoGoal $script:steps "final_meta_commit_failed" $false 1
     }
 
@@ -1107,7 +1327,9 @@ function Invoke-CycleCommand {
     $script:steps += New-StepResult $StepNumber $Name $Command $true $false $exitCode $message
 
     if ($exitCode -ne 0) {
-        Stop-AutoGoal $script:steps "$Name`_failed" $false 1
+        $childStoppedReason = Get-StoppedReasonFromOutput $message
+        $stoppedReason = if (Test-IsExpectedPreImplementationStop $childStoppedReason) { $childStoppedReason } else { "$Name`_failed" }
+        Stop-AutoGoal $script:steps $stoppedReason $false 1
     }
 }
 
@@ -1174,6 +1396,7 @@ $resolvedQueuePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $queueRelat
 $resolvedStatePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $stateRelativePath))
 $resolvedPlanningPromptPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $planningPromptRelativePath))
 $resolvedResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ResultPath))
+Initialize-AutoGoalOperationalFileSnapshots
 
 if (-not (Test-HasValue $GoalTitle)) {
     $script:steps += New-StepResult 0 "validate-input" "check GoalTitle" $false $false 1 "GoalTitle must not be empty."
diff --git a/scripts/ai-dev-autopilot.ps1 b/scripts/ai-dev-autopilot.ps1
index 52da0ce..4c8c3f2 100644
--- a/scripts/ai-dev-autopilot.ps1
+++ b/scripts/ai-dev-autopilot.ps1
@@ -38,6 +38,8 @@ $backlogPath = Join-Path $repoRoot $backlogRelativePath
 $loopLogPath = Join-Path $repoRoot $loopLogRelativePath
 $goalHistoryPath = Join-Path $repoRoot $goalHistoryRelativePath
 $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
+$script:autopilotOperationalFileSnapshots = @{}
+$script:autopilotBaselineDirtyPaths = @()
 
 function Test-HasValue {
     param([object]$Value)
@@ -153,6 +155,10 @@ function Add-AutopilotGoalHistoryTitle {
         return
     }
 
+    if (Test-IsAutopilotBaselineDirtyPath $goalHistoryRelativePath) {
+        return
+    }
+
     $now = [DateTimeOffset]::UtcNow.ToString("o")
     $trimmedTitle = $Title.Trim()
     $history = Read-AutopilotGoalHistory
@@ -245,6 +251,10 @@ function Add-LoopLogEntry {
         return
     }
 
+    if (Test-IsAutopilotBaselineDirtyPath $loopLogRelativePath) {
+        return
+    }
+
     $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
     $entryLines = @("", "## $timestamp - $Title", "")
     $entryLines += @($Lines)
@@ -252,6 +262,178 @@ function Add-LoopLogEntry {
     [System.IO.File]::AppendAllText($loopLogPath, ($entryLines -join "`r`n"), $utf8WithBom)
 }
 
+function Test-IsExpectedAutopilotNonWorkStop {
+    param([string]$StoppedReason)
+
+    return @(
+        "all_goal_candidates_excluded",
+        "baseline_output_conflict",
+        "dirty_worktree",
+        "goal_candidate_not_found",
+        "current_goal_not_completed",
+        "max_steps_too_small_for_full_cycle"
+    ) -contains $StoppedReason
+}
+
+function Get-StoppedReasonFromOutput {
+    param([string]$Output)
+
+    if (-not (Test-HasValue $Output)) {
+        return ""
+    }
+
+    if ($Output -match '(?m)^\s*Stopped reason:\s*(\S+)\s*$') {
+        return $Matches[1]
+    }
+
+    if ($Output -match '(?m)"stoppedReason"\s*:\s*"([^"]+)"') {
+        return $Matches[1]
+    }
+
+    return ""
+}
+
+function ConvertTo-NormalizedChangedPath {
+    param([string]$RelativePath)
+
+    if (-not (Test-HasValue $RelativePath)) {
+        return $null
+    }
+
+    return $RelativePath.Trim().Trim('"').Replace('\', '/')
+}
+
+function Convert-ToChangedPath {
+    param([string]$ChangeLine)
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
+function Get-AutopilotBaselineDirtyPaths {
+    $statusOutput = & git status --porcelain 2>&1
+
+    if ($LASTEXITCODE -ne 0) {
+        throw "git status --porcelain failed while capturing autopilot baseline dirty paths: $($statusOutput -join "`n")"
+    }
+
+    return @(
+        $statusOutput |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            Where-Object { Test-HasValue $_ } |
+            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+            Select-Object -Unique
+    )
+}
+
+function Test-IsAutopilotBaselineDirtyPath {
+    param([string]$RelativePath)
+
+    $normalizedRelativePath = ConvertTo-NormalizedChangedPath $RelativePath
+    return @($script:autopilotBaselineDirtyPaths) -contains $normalizedRelativePath
+}
+
+function Initialize-AutopilotOperationalFileSnapshots {
+    $script:autopilotOperationalFileSnapshots = @{}
+
+    foreach ($relativePath in @($stateRelativePath, $loopLogRelativePath, $goalHistoryRelativePath)) {
+        $fullPath = [System.IO.Path]::GetFullPath((Join-Path $repoRoot $relativePath))
+
+        if (-not $fullPath.StartsWith($repoRoot.TrimEnd("\") + "\", [System.StringComparison]::OrdinalIgnoreCase)) {
+            continue
+        }
+
+        $exists = [System.IO.File]::Exists($fullPath)
+        $bytes = $null
+
+        if ($exists) {
+            $bytes = [System.IO.File]::ReadAllBytes($fullPath)
+        }
+
+        $script:autopilotOperationalFileSnapshots[$relativePath] = [PSCustomObject][ordered]@{
+            path = $fullPath
+            existed = $exists
+            bytes = $bytes
+        }
+    }
+}
+
+function Restore-AutopilotCurrentRunOperationalChanges {
+    param([string[]]$RelativePaths = @())
+
+    $restoredPaths = @()
+
+    if ($null -eq $script:autopilotOperationalFileSnapshots) {
+        return @($restoredPaths)
+    }
+
+    $targetPaths = @($RelativePaths | ForEach-Object { ConvertTo-NormalizedChangedPath $_ } | Where-Object { Test-HasValue $_ } | Select-Object -Unique)
+
+    foreach ($entry in @($script:autopilotOperationalFileSnapshots.GetEnumerator())) {
+        $relativePath = ConvertTo-NormalizedChangedPath ([string]$entry.Key)
+        $snapshot = $entry.Value
+
+        if ($targetPaths.Count -gt 0 -and $targetPaths -notcontains $relativePath) {
+            continue
+        }
+
+        if (Test-IsAutopilotBaselineDirtyPath $relativePath) {
+            continue
+        }
+
+        $fullPath = [string]$snapshot.path
+
+        if (-not $fullPath.StartsWith($repoRoot.TrimEnd("\") + "\", [System.StringComparison]::OrdinalIgnoreCase)) {
+            continue
+        }
+
+        try {
+            if ($snapshot.existed) {
+                [System.IO.File]::WriteAllBytes($fullPath, [byte[]]$snapshot.bytes)
+            } elseif ([System.IO.File]::Exists($fullPath)) {
+                [System.IO.File]::Delete($fullPath)
+            }
+            $restoredPaths += $relativePath
+        } catch {
+            Write-Warning "Failed to restore autopilot operational file snapshot: $fullPath"
+        }
+    }
+
+    return @($restoredPaths | Select-Object -Unique)
+}
+
+function Add-AutopilotExpectedNonWorkLogEntry {
+    param(
+        [string]$StoppedReason,
+        [string]$Message,
+        [int]$PreparedGoals
+    )
+
+    $resultMessage = if (Test-HasValue $Message) { $Message } else { "Autopilot stopped before implementation work." }
+
+    Add-LoopLogEntry "Autopilot expected non-work stop" @(
+        "- Reason: $StoppedReason",
+        "- Outcome category: expected_non_work",
+        "- Result: $resultMessage",
+        "- Prepared goals: $PreparedGoals/$MaxGoals",
+        "- Failure counter: not incremented",
+        "- Cleanup: restored current-run autopilot operational file snapshots before writing this meta log entry"
+    )
+}
+
 function Invoke-AutopilotLoopLogMetaCommit {
     param([int]$StepNumber)
 
@@ -263,7 +445,25 @@ function Invoke-AutopilotLoopLogMetaCommit {
         return New-StepResult $StepNumber "autopilot-meta-commit" $false $true 0 "AllowCommit is not set, so autopilot loop-log/history meta commit was not executed."
     }
 
-    $statusOutput = & git status --short -- $autopilotMetaCommitRelativePaths 2>&1 | Out-String
+    $skippedBaselinePaths = @(
+        @($loopLogRelativePath, $goalHistoryRelativePath) |
+            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+            Where-Object { Test-IsAutopilotBaselineDirtyPath $_ } |
+            Select-Object -Unique
+    )
+    $currentRunMetaPaths = @(
+        $loopLogRelativePath,
+        $goalHistoryRelativePath
+    ) |
+        ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+        Where-Object { -not (Test-IsAutopilotBaselineDirtyPath $_) } |
+        Select-Object -Unique
+
+    if ($currentRunMetaPaths.Count -eq 0) {
+        return New-StepResult $StepNumber "autopilot-meta-commit" $false $true 0 "Autopilot meta commit skipped because all meta files were baseline dirty and protected: $($skippedBaselinePaths -join ', ')"
+    }
+
+    $statusOutput = & git status --short -- $currentRunMetaPaths 2>&1 | Out-String
     $statusExitCode = $LASTEXITCODE
 
     if ($statusExitCode -ne 0) {
@@ -271,25 +471,33 @@ function Invoke-AutopilotLoopLogMetaCommit {
     }
 
     if (-not (Test-HasValue $statusOutput)) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 0 "Autopilot meta files had no changes to commit."
+        $message = "Autopilot meta files had no changes to commit."
+        if ($skippedBaselinePaths.Count -gt 0) {
+            $message = "$message Baseline dirty files skipped: $($skippedBaselinePaths -join ', ')"
+        }
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 0 $message
     }
 
-    $addOutput = & git add -- $autopilotMetaCommitRelativePaths 2>&1 | Out-String
+    $addOutput = & git add -- $currentRunMetaPaths 2>&1 | Out-String
     $addExitCode = $LASTEXITCODE
 
     if ($addExitCode -ne 0) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot meta files git add failed. exit code: $addExitCode`n$addOutput"
+        & git restore --staged -- $currentRunMetaPaths 2>&1 | Out-String | Out-Null
+        $restoredPaths = @(Restore-AutopilotCurrentRunOperationalChanges $currentRunMetaPaths)
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot meta files git add failed. exit code: $addExitCode`n$addOutput`nRestored run-owned files: $($restoredPaths -join ', ')"
     }
 
     $metaCommitMessage = "chore(ai-dev): record autopilot progress"
-    $commitOutput = & git commit -m $metaCommitMessage -- $autopilotMetaCommitRelativePaths 2>&1 | Out-String
+    $commitOutput = & git commit -m $metaCommitMessage -- $currentRunMetaPaths 2>&1 | Out-String
     $commitExitCode = $LASTEXITCODE
 
     if ($commitExitCode -ne 0) {
-        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot meta commit failed. exit code: $commitExitCode`n$commitOutput"
+        & git restore --staged -- $currentRunMetaPaths 2>&1 | Out-String | Out-Null
+        $restoredPaths = @(Restore-AutopilotCurrentRunOperationalChanges $currentRunMetaPaths)
+        return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot meta commit failed. exit code: $commitExitCode`n$commitOutput`nRestored run-owned files: $($restoredPaths -join ', ')"
     }
 
-    $remainingStatus = & git status --short -- $autopilotMetaCommitRelativePaths 2>&1 | Out-String
+    $remainingStatus = & git status --short -- $currentRunMetaPaths 2>&1 | Out-String
     $remainingStatusExitCode = $LASTEXITCODE
 
     if ($remainingStatusExitCode -ne 0) {
@@ -300,7 +508,7 @@ function Invoke-AutopilotLoopLogMetaCommit {
         return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 1 "Autopilot meta clean verification failed: git status --short still reports meta changes after the autopilot meta commit.`n$remainingStatus"
     }
 
-    $message = ($commitOutput.Trim(), "Autopilot meta clean verification: git status --short returned no autopilot meta changes.") -join "`n"
+    $message = ($commitOutput.Trim(), "Baseline dirty files skipped: $($skippedBaselinePaths -join ', ')", "Autopilot meta clean verification: git status --short returned no autopilot meta changes.") -join "`n"
     return New-StepResult $StepNumber "autopilot-meta-commit" $true $false 0 $message
 }
 
@@ -365,16 +573,31 @@ function New-AutopilotResult {
         [string]$StoppedReason,
         [bool]$Completed,
         [int]$ExitCode,
-        [int]$PreparedGoals
+        [int]$PreparedGoals,
+        [bool]$OperationalCleanupPerformed = $false,
+        [bool]$MetaCommitCreated = $false,
+        [bool]$NextRunWithoutManualRestore = $false
     )
 
+    $outcomeCategory = if (Test-IsExpectedAutopilotNonWorkStop $StoppedReason) {
+        "expected_non_work"
+    } elseif ($ExitCode -eq 0) {
+        "success"
+    } else {
+        "actual_failure"
+    }
+
     return [PSCustomObject][ordered]@{
         steps = @($Steps)
         stoppedReason = $StoppedReason
+        outcomeCategory = $outcomeCategory
         completed = $Completed
         exitCode = $ExitCode
         maxGoals = $MaxGoals
         preparedGoals = $PreparedGoals
+        operationalCleanupPerformed = $OperationalCleanupPerformed
+        metaCommitCreated = $MetaCommitCreated
+        nextRunWithoutManualRestore = $NextRunWithoutManualRestore
     }
 }
 
@@ -399,6 +622,10 @@ function Write-AutopilotResult {
     }
 
     Write-Host "Stopped reason: $($Result.stoppedReason)"
+    Write-Host "Outcome category: $($Result.outcomeCategory)"
+    Write-Host "Operational cleanup performed: $($Result.operationalCleanupPerformed)"
+    Write-Host "Meta commit created: $($Result.metaCommitCreated)"
+    Write-Host "Next run without manual restore: $($Result.nextRunWithoutManualRestore)"
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Prepared goals: $($Result.preparedGoals)/$($Result.maxGoals)"
     Write-Host "Exit code: $($Result.exitCode)"
@@ -414,7 +641,12 @@ function Stop-Autopilot {
         [string]$FailureMessage = ""
     )
 
-    if ($ExitCode -ne 0 -and (Test-HasValue $FailureMessage)) {
+    $isExpectedNonWorkStop = Test-IsExpectedAutopilotNonWorkStop $StoppedReason
+    $operationalCleanupPerformed = $false
+    $metaCommitCreated = $false
+    $nextRunWithoutManualRestore = ($ExitCode -eq 0)
+
+    if ($ExitCode -ne 0 -and (Test-HasValue $FailureMessage) -and -not $isExpectedNonWorkStop) {
         Save-AutopilotFailureState $StoppedReason $FailureMessage
         Add-LoopLogEntry "Autopilot stopped" @(
             "- Reason: $StoppedReason",
@@ -423,7 +655,42 @@ function Stop-Autopilot {
         )
     }
 
-    $result = New-AutopilotResult $Steps $StoppedReason $Completed $ExitCode $PreparedGoals
+    if ($ExitCode -ne 0 -and $isExpectedNonWorkStop -and -not $DryRun) {
+        $cleanedRunOwnedPaths = @(Restore-AutopilotCurrentRunOperationalChanges)
+        $operationalCleanupPerformed = $true
+        $metaCommitMessage = "skipped (-AllowCommit not set)"
+        $nextRunWithoutManualRestore = $true
+        $skippedBaselineMetaPaths = @(
+            @($loopLogRelativePath, $goalHistoryRelativePath) |
+                ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+                Where-Object { Test-IsAutopilotBaselineDirtyPath $_ } |
+                Select-Object -Unique
+        )
+
+        if ($AllowCommit) {
+            Add-AutopilotExpectedNonWorkLogEntry $StoppedReason $FailureMessage $PreparedGoals
+            $metaCommitStep = Invoke-AutopilotLoopLogMetaCommit ($Steps.Count + 1)
+            $metaCommitCreated = ($metaCommitStep.exitCode -eq 0 -and $metaCommitStep.executed -and -not $metaCommitStep.skipped -and $metaCommitStep.message -notmatch 'had no changes to commit')
+            $metaCommitMessage = if ($metaCommitCreated) { "created" } else { "not created: $($metaCommitStep.message)" }
+
+            if ($metaCommitStep.exitCode -ne 0) {
+                $cleanedRunOwnedPaths = @(Restore-AutopilotCurrentRunOperationalChanges)
+                $operationalCleanupPerformed = $true
+                $nextRunWithoutManualRestore = $true
+                $Steps += $metaCommitStep
+                $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-cleanup" $true $false 0 "Classification: expected_non_work. Original stopped reason: $StoppedReason. Baseline dirty files skipped: $($skippedBaselineMetaPaths -join ', '). Cleaned run-owned files: $($cleanedRunOwnedPaths -join ', '). Meta commit created: false. Next run without manual git restore: $nextRunWithoutManualRestore."
+                $result = New-AutopilotResult $Steps "autopilot_expected_non_work_meta_commit_failed" $false 1 $PreparedGoals $operationalCleanupPerformed $false $nextRunWithoutManualRestore
+                Write-AutopilotResult $result
+                exit 1
+            }
+
+            $Steps += $metaCommitStep
+        }
+
+        $Steps += New-StepResult ($Steps.Count + 1) "expected-non-work-cleanup" $true $false 0 "Classification: expected_non_work. Original stopped reason: $StoppedReason. Baseline dirty files skipped: $($skippedBaselineMetaPaths -join ', '). Cleaned run-owned files: $($cleanedRunOwnedPaths -join ', '). Meta commit created: $metaCommitCreated ($metaCommitMessage). Next run without manual git restore: $nextRunWithoutManualRestore. Restored only autopilot operational files captured at run start; baseline user changes were preserved."
+    }
+
+    $result = New-AutopilotResult $Steps $StoppedReason $Completed $ExitCode $PreparedGoals $operationalCleanupPerformed $metaCommitCreated $nextRunWithoutManualRestore
     Write-AutopilotResult $result
     exit $ExitCode
 }
@@ -842,6 +1109,8 @@ function Invoke-AutoGoal {
 }
 
 Set-Location $repoRoot
+$script:autopilotBaselineDirtyPaths = @(Get-AutopilotBaselineDirtyPaths)
+Initialize-AutopilotOperationalFileSnapshots
 
 $steps = @()
 $preparedGoals = 0
@@ -970,13 +1239,15 @@ for ($goalIndex = 1; $goalIndex -le $MaxGoals; $goalIndex++) {
     $steps += $autoGoalStep
 
     if ($autoGoalStep.exitCode -ne 0) {
+        $childStoppedReason = Get-StoppedReasonFromOutput $autoGoalStep.message
+        $stoppedReason = if (Test-IsExpectedAutopilotNonWorkStop $childStoppedReason) { $childStoppedReason } else { "auto_goal_failed" }
         $failureMessage = "Auto-goal failed with exit code $($autoGoalStep.exitCode): $($autoGoalStep.message)"
 
         if (Test-HasValue $candidate.fallbackReason) {
             $failureMessage = "$failureMessage Fallback context: $($candidate.fallbackReason)"
         }
 
-        Stop-Autopilot $steps "auto_goal_failed" $false 1 $preparedGoals $failureMessage
+        Stop-Autopilot $steps $stoppedReason $false 1 $preparedGoals $failureMessage
     }
 
     $preparedGoals++
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```