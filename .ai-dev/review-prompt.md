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

AI Dev Loop auto-goal 완료 직전의 최종 상태 검증을 보강하여, completed 상태로 종료된 뒤에도 .ai-dev 운영 파일 변경이 남지 않도록 한다.

## 배경

현재 ai-dev-auto-goal 실행이 goal completed로 끝난 뒤 .ai-dev/auto-goal-planning-prompt.md 삭제 같은 후처리 변경이 남아 작업 트리가 변경된 상태가 될 수 있다. 완료 상태의 의미와 실제 저장소 상태가 어긋나므로, auto-cycle-full의 메타 커밋 이후 또는 auto-goal 종료 직전에 최종 변경 상태를 확인하는 보호 장치가 필요하다.

## 성공 기준

- auto-goal이 completed 상태로 종료되기 직전에 최종 변경 상태를 확인한다.
- 남은 변경이 .ai-dev 운영 파일의 후처리 변경이면 메타 커밋 흐름에 포함되도록 처리한다.
- 메타 커밋에 포함할 수 없는 남은 변경이 있으면 completed로 종료하지 않고 실패로 처리한다.
- completed 상태에서는 후속 실행자가 즉시 확인해도 남은 변경이 없는 상태다.
- 기존 사용자 변경 사항을 되돌리거나 무시하지 않는다.

## 제약사항

- 한 번에 하나의 작은 구현 변경으로 처리한다.
- 기존 AI Dev Loop 흐름과 파일 구조를 우선 따른다.
- 사용자 변경 사항을 되돌리지 않는다.
- 서버 API, 로그인, 클라우드 동기화, DB 구조 변경은 다루지 않는다.
- 광범위한 재작성 없이 종료 검증과 메타 커밋 흐름 주변만 수정한다.

## 범위 제외

- AI Dev Loop 전체 구조 재설계
- 새로운 저장소 관리 정책 도입
- UI 변경
- 앱 런타임 기능 변경
- 데이터베이스 마이그레이션

## 수동 검증

- auto-goal 완료 직전 후처리 변경이 생기는 상황을 재현하거나 시뮬레이션한다.
- completed 종료 후 남은 변경 상태가 없는지 확인한다.
- 남은 변경을 메타 커밋에 포함할 수 없는 경우 completed가 아닌 실패 상태로 종료되는지 확인한다.

## Current Task

- Task ID: T001
- Title: auto-goal 종료 전 최종 변경 상태 검증 보강
- Description: auto-cycle-full의 메타 커밋 이후 또는 auto-goal 종료 직전에 남은 .ai-dev 운영 변경을 확인하고, 처리 가능한 변경은 메타 커밋 흐름에 포함하며 처리할 수 없는 변경은 완료가 아닌 실패로 종료하도록 보강한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- 완료 직전 남은 .ai-dev 운영 변경이 메타 커밋 흐름에 포함되는지 확인한다.
- 처리할 수 없는 남은 변경이 있을 때 completed로 종료하지 않는지 확인한다.
- 기존 사용자 변경 사항을 되돌리지 않는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-06-19 21:30:34

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
dist/index.html                   0.46 kB │ gzip:  0.30 kB
dist/assets/index-DvjxWt30.css    5.69 kB │ gzip:  1.93 kB
dist/assets/index-CJKmMJEA.js   316.50 kB │ gzip: 99.87 kB

[32m✓ built in 173ms[39m
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
## Executable verification: auto-goal final clean gate regression scenarios

- Verification type: isolated temporary git repositories with real git status/add/commit/status commands.
- Temporary root: C:\Users\SECUI\AppData\Local\Temp\planpilot-final-gate-test-d8ec78a422d64575800d8ec76eed8be9
- Important note: this verification was appended after ai-dev-check because ai-dev-check rewrites test-result.md.
- Therefore ai-dev-check must not be rerun before review, or this evidence will be overwritten.

### Actual executed results
- Scenario 1 new .ai-dev operational output => PASS_COMMITTED_AND_CLEAN / final git status: ''
- Scenario 2 non-.ai-dev dirty remains => FAIL_NON_AI_DEV_DIRTY / final git status: ' M src/TaskCard.tsx'
- Scenario 3 baseline dirty .ai-dev/goal.md conflicts with planned output => FAIL_BASELINE_OUTPUT_CONFLICT_BEFORE_WRITE / final git status: '?? .ai-dev/goal.md'
- Scenario 4 baseline dirty ResultPath is protected before failure write => FAIL_BASELINE_OUTPUT_CONFLICT_BEFORE_WRITE / final git status: '?? .ai-dev/codex-result.md'
- Scenario 5 prepared_without_full_cycle .ai-dev outputs => PASS_COMMITTED_AND_CLEAN / final git status: ''
- Scenario 6 .ai-dev output remains but AllowCommit is false => FAIL_ALLOW_COMMIT_REQUIRED / final git status: '?? .ai-dev/codex-result.md'

### Pass/fail interpretation
- Scenario 1 proves new .ai-dev operational output is committed into final meta commit and ends with clean git status.
- Scenario 2 proves remaining non-.ai-dev dirty worktree is rejected and cannot be reported as completed.
- Scenario 3 proves baseline dirty .ai-dev/goal.md is detected as a planned-output conflict before auto-goal writes goal.md.
- Scenario 4 proves baseline dirty ResultPath .ai-dev/codex-result.md is protected before failure-result writing can overwrite it.
- Scenario 5 proves prepared_without_full_cycle-style .ai-dev outputs can use the same final meta commit and end clean.
- Scenario 6 proves .ai-dev output requiring a commit fails when AllowCommit is false instead of reporting completed.

### Final conclusion
- completed=true is valid only after final git status --short is clean.
- New .ai-dev operational changes are eligible for final meta commit only when they were not baseline dirty conflicts.
- Baseline dirty planned-output files are blocked before write/delete operations.
- ResultPath is protected when it is baseline dirty, so failure reporting does not overwrite a user-dirty codex-result.md.
- Non-.ai-dev dirty and missing AllowCommit paths fail instead of completed.


## Diff To Review

# AI Dev Diff

## Generated At

2026-06-19 21:34:04

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
 M scripts/ai-dev-auto-goal.ps1
```

## App Change Files

- scripts/ai-dev-auto-cycle-full.ps1
- scripts/ai-dev-auto-goal.ps1

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
 scripts/ai-dev-auto-cycle-full.ps1 | 149 +++++++++++-
 scripts/ai-dev-auto-goal.ps1       | 455 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 584 insertions(+), 20 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 1697ce8..419656a 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -7,6 +7,7 @@
     [switch]$AllowReviewCodex,
     [switch]$AllowCommit,
     [switch]$AllowDirty,
+    [string[]]$ProtectedBaselineDirtyPaths,
     [string[]]$CommitFiles
 )
 
@@ -185,6 +186,86 @@ function Stop-Cycle {
     exit $ExitCode
 }
 
+function Complete-Cycle {
+    param(
+        [object[]]$Steps,
+        [string]$StoppedReason,
+        [int]$StepNumber
+    )
+
+    try {
+        $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "git status --short"
+
+        if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
+            $changeLines = @($remainingStatus -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
+            $changedPaths = @(
+                $changeLines |
+                    ForEach-Object { Convert-ToChangedPath $_ } |
+                    ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+                    Where-Object { Test-HasValue $_ } |
+                    Select-Object -Unique
+            )
+            $protectedPaths = @($changedPaths | Where-Object { Test-IsProtectedBaselineDirtyPath $_ })
+            $nonAiDevPaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
+            $eligibleAiDevPaths = @($changedPaths | Where-Object { (Test-IsAiDevOperationalPath $_) -and -not (Test-IsProtectedBaselineDirtyPath $_) })
+
+            if ($nonAiDevPaths.Count -gt 0) {
+                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $true $false 1 "Completed clean verification failed: non-.ai-dev changes remain after all full-cycle result/state files were written.`n$remainingStatus"
+                Stop-Cycle $Steps "completed_non_ai_dev_changes" $false 1
+            }
+
+            if ($protectedPaths.Count -gt 0) {
+                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $true $false 1 "Completed clean verification failed: protected baseline dirty .ai-dev paths remain and must not be absorbed into the final meta commit.`n$($protectedPaths -join "`n")`n$remainingStatus"
+                Stop-Cycle $Steps "completed_protected_baseline_dirty" $false 1
+            }
+
+            if ($eligibleAiDevPaths.Count -eq 0) {
+                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $true $false 1 "Completed clean verification failed: worktree still has changes, but none are eligible new .ai-dev operational changes.`n$remainingStatus"
+                Stop-Cycle $Steps "completed_no_eligible_meta_changes" $false 1
+            }
+
+            if (-not $AllowCommit) {
+                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $true $false 1 "Completed clean verification failed: only new .ai-dev operational changes remain, but -AllowCommit is required for the final auto-cycle meta commit.`n$remainingStatus"
+                Stop-Cycle $Steps "completed_ai_dev_changes_require_commit" $false 1
+            }
+
+            $addOutput = & git add -- $eligibleAiDevPaths 2>&1 | Out-String
+            $addExitCode = $LASTEXITCODE
+
+            if ($addExitCode -ne 0) {
+                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git add -- <final .ai-dev files>" $true $false 1 "Final auto-cycle .ai-dev meta add failed. exit code: $addExitCode`n$addOutput"
+                Stop-Cycle $Steps "completed_meta_add_failed" $false 1
+            }
+
+            $metaCommitMessage = "chore(ai-dev): record final auto-cycle state"
+            $commitOutput = & git commit -m $metaCommitMessage -- $eligibleAiDevPaths 2>&1 | Out-String
+            $commitExitCode = $LASTEXITCODE
+
+            if ($commitExitCode -ne 0) {
+                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git commit -m '$metaCommitMessage' -- <final .ai-dev files>" $true $false 1 "Final auto-cycle .ai-dev meta commit failed. exit code: $commitExitCode`n$commitOutput"
+                Stop-Cycle $Steps "completed_meta_commit_failed" $false 1
+            }
+
+            $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "git status --short"
+
+            if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
+                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $true $false 1 "Completed clean verification failed: changes remain after the final auto-cycle .ai-dev meta commit.`n$remainingStatus"
+                Stop-Cycle $Steps "completed_worktree_dirty" $false 1
+            }
+
+            $message = ($commitOutput.Trim(), "Final auto-cycle .ai-dev meta commit created: yes", "Completed clean verification passed: git status --short returned no changes.") -join "`n"
+            $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short; git add/commit final .ai-dev operational changes; git status --short" $true $false 0 $message
+            Stop-Cycle $Steps $StoppedReason $true 0
+        }
+
+        $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $true $false 0 "Completed clean verification passed: git status --short returned no changes."
+        Stop-Cycle $Steps $StoppedReason $true 0
+    } catch {
+        $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $false $false 1 $_.Exception.Message
+        Stop-Cycle $Steps "completed_clean_gate_failed" $false 1
+    }
+}
+
 function Invoke-CycleCommand {
     param(
         [int]$StepNumber,
@@ -271,15 +352,50 @@ function Convert-ToChangedPath {
     return @($pathText)
 }
 
+function ConvertTo-NormalizedChangedPath {
+    param(
+        [string]$RelativePath
+    )
+
+    if (-not (Test-HasValue $RelativePath)) {
+        return $null
+    }
+
+    return $RelativePath.Trim().Trim('"').Replace('\', '/')
+}
+
 function Test-IsAiDevOperationalPath {
     param(
         [string]$RelativePath
     )
 
-    $normalizedRelativePath = $RelativePath.Replace('\', '/')
+    $normalizedRelativePath = ConvertTo-NormalizedChangedPath $RelativePath
     return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::OrdinalIgnoreCase)
 }
 
+function Get-ProtectedBaselineDirtyPaths {
+    if ($null -eq $ProtectedBaselineDirtyPaths -or $ProtectedBaselineDirtyPaths.Count -eq 0) {
+        return @()
+    }
+
+    return @(
+        $ProtectedBaselineDirtyPaths |
+            ForEach-Object { $_ -split "," } |
+            Where-Object { Test-HasValue $_ } |
+            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+            Select-Object -Unique
+    )
+}
+
+function Test-IsProtectedBaselineDirtyPath {
+    param(
+        [string]$RelativePath
+    )
+
+    $normalizedRelativePath = ConvertTo-NormalizedChangedPath $RelativePath
+    return @($script:protectedBaselineDirtyPaths) -contains $normalizedRelativePath
+}
+
 function Get-ChangedNonAiDevFiles {
     $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
     $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
@@ -287,7 +403,8 @@ function Get-ChangedNonAiDevFiles {
     return @(
         $changeLines |
             ForEach-Object { Convert-ToChangedPath $_ } |
-            Where-Object { (Test-HasValue $_) -and -not (Test-IsAiDevOperationalPath $_) } |
+            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+            Where-Object { (Test-HasValue $_) -and -not (Test-IsAiDevOperationalPath $_) -and -not (Test-IsProtectedBaselineDirtyPath $_) } |
             Select-Object -Unique
     )
 }
@@ -299,7 +416,8 @@ function Get-ChangedAiDevOperationalFiles {
     return @(
         $changeLines |
             ForEach-Object { Convert-ToChangedPath $_ } |
-            Where-Object { (Test-HasValue $_) -and (Test-IsAiDevOperationalPath $_) } |
+            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+            Where-Object { (Test-HasValue $_) -and (Test-IsAiDevOperationalPath $_) -and -not (Test-IsProtectedBaselineDirtyPath $_) } |
             Select-Object -Unique
     )
 }
@@ -367,7 +485,13 @@ function Get-CommitArguments {
     $arguments = @()
 
     if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
-        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
+        $normalizedFiles = @(
+            $CommitFiles |
+                ForEach-Object { $_ -split "," } |
+                Where-Object { Test-HasValue $_ } |
+                ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+                Where-Object { -not (Test-IsProtectedBaselineDirtyPath $_) }
+        )
 
         if ($normalizedFiles.Count -gt 0) {
             $arguments += "-Files"
@@ -468,6 +592,11 @@ function Get-CommitGate {
 Set-Location $repoRoot
 
 $script:steps = @()
+$script:protectedBaselineDirtyPaths = @(Get-ProtectedBaselineDirtyPaths)
+
+if ($script:protectedBaselineDirtyPaths.Count -gt 0) {
+    $script:steps += New-StepResult 0 "baseline-dirty-protection" "ProtectedBaselineDirtyPaths" $false $false 0 "Auto-goal baseline dirty paths are protected from implementation and .ai-dev meta commit eligibility: $($script:protectedBaselineDirtyPaths -join ', ')"
+}
 
 if ($MaxTasks -lt 1) {
     Stop-Cycle $script:steps "max_tasks_must_be_at_least_1" $false 1
@@ -488,7 +617,7 @@ try {
     $state = Read-JsonFile $statePath $stateRelativePath
 
     if ($state.goalStatus -eq "completed") {
-        Stop-Cycle $script:steps "goal_completed" $true 0
+        Complete-Cycle $script:steps "goal_completed" 0
     }
 
     if (-not ($queue.PSObject.Properties.Name -contains "tasks") -or $null -eq $queue.tasks) {
@@ -502,7 +631,7 @@ try {
     }
 
     if ($currentTask.status -eq "done") {
-        Stop-Cycle $script:steps "current_task_done" $true 0
+        Complete-Cycle $script:steps "current_task_done" 0
     }
 
     $scriptPaths = @{
@@ -556,7 +685,7 @@ while ($completedTaskCount -lt $MaxTasks) {
     }
 
     if ($state.goalStatus -eq "completed") {
-        Stop-Cycle $script:steps "goal_completed" $true 0
+        Complete-Cycle $script:steps "goal_completed" $stepNumber
     }
 
     if ($null -eq $currentTask) {
@@ -564,7 +693,7 @@ while ($completedTaskCount -lt $MaxTasks) {
     }
 
     if ($currentTask.status -eq "done") {
-        Stop-Cycle $script:steps "current_task_done" $true 0
+        Complete-Cycle $script:steps "current_task_done" $stepNumber
     }
 
     $taskLabel = "$($currentTask.id) $($currentTask.title)"
@@ -781,8 +910,8 @@ while ($completedTaskCount -lt $MaxTasks) {
     $stateAfterComplete = Read-JsonFile $statePath $stateRelativePath
 
     if ($stateAfterComplete.goalStatus -eq "completed") {
-        Stop-Cycle $script:steps "goal_completed" $true 0
+        Complete-Cycle $script:steps "goal_completed" $stepNumber
     }
 }
 
-Stop-Cycle $script:steps "max_tasks_reached" $true 0
+Complete-Cycle $script:steps "max_tasks_reached" $stepNumber
diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index bd06345..594d429 100644
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -27,6 +27,9 @@ $stateRelativePath = ".ai-dev/state.json"
 $promptRelativePath = ".ai-dev/current-task-prompt.md"
 $planningPromptRelativePath = ".ai-dev/auto-goal-planning-prompt.md"
 $legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"
+$aiDevOperationalRoot = ".ai-dev/"
+$script:autoGoalCanWriteResultFile = $true
+$script:autoGoalCanCleanTempArtifacts = $true
 
 function Resolve-RepoPath {
     param([string]$Path)
@@ -146,7 +149,46 @@ function Write-AutoGoalResult {
     Write-Host "Exit code: $($Result.exitCode)"
 }
 
+function Save-AutoGoalResultFile {
+    param(
+        [string]$StoppedReason,
+        [bool]$Completed,
+        [int]$ExitCode
+    )
+
+    $result = New-AutoGoalResult $script:steps $StoppedReason $Completed $ExitCode
+    $stepLines = @()
+
+    foreach ($step in @($result.steps)) {
+        $stepLines += "- Step $($step.step) $($step.name): exitCode=$($step.exitCode), executed=$($step.executed), skipped=$($step.skipped)"
+        if (Test-HasValue $step.message) {
+            $stepLines += "  - Message: $($step.message)"
+        }
+    }
+
+    $content = @"
+# Codex Auto Goal Final Result
+
+## Summary
+
+- Stopped reason: $($result.stoppedReason)
+- Completed: $($result.completed)
+- Exit code: $($result.exitCode)
+- Result path: $($result.resultPath)
+
+## Steps
+
+$($stepLines -join "`r`n")
+"@
+
+    [System.IO.File]::WriteAllText($resolvedResultPath, $content, $utf8WithBom)
+}
+
 function Clear-AutoGoalTempArtifacts {
+    if (-not $script:autoGoalCanCleanTempArtifacts) {
+        return
+    }
+
     $currentResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ResultPath))
 
     foreach ($relativePath in @($planningPromptRelativePath, $legacyAutoGoalResultRelativePath)) {
@@ -179,6 +221,11 @@ function Stop-AutoGoal {
     )
 
     Clear-AutoGoalTempArtifacts
+    if (-not $Completed -or $ExitCode -ne 0) {
+        if ($script:autoGoalCanWriteResultFile) {
+            Save-AutoGoalResultFile $StoppedReason $false $ExitCode
+        }
+    }
     Write-AutoGoalResult (New-AutoGoalResult $Steps $StoppedReason $Completed $ExitCode)
     exit $ExitCode
 }
@@ -203,17 +250,382 @@ function Get-InputPreview {
     return $normalized.Substring(0, 500)
 }
 
-function Get-GitStatusLines {
-    $statusOutput = & git status --short 2>&1
+function Invoke-GitStatusLines {
+    param(
+        [string[]]$Arguments,
+        [string]$CommandText,
+        [int]$FailureStep = 2,
+        [string]$FailureName = "dirty-worktree-gate"
+    )
+
+    $statusOutput = & git @Arguments 2>&1
 
     if ($LASTEXITCODE -ne 0) {
-        $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 1 "git status failed: $($statusOutput -join "`n")"
+        $script:steps += New-StepResult $FailureStep $FailureName $CommandText $false $false 1 "git status failed: $($statusOutput -join "`n")"
         Stop-AutoGoal $script:steps "git_status_failed" $false 1
     }
 
     return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
 }
 
+function Get-GitStatusLines {
+    param(
+        [int]$FailureStep = 2,
+        [string]$FailureName = "dirty-worktree-gate"
+    )
+
+    return @(Invoke-GitStatusLines -Arguments @("status", "--short") -CommandText "git status --short" -FailureStep $FailureStep -FailureName $FailureName)
+}
+
+function Get-GitPorcelainStatusLines {
+    param(
+        [int]$FailureStep = 2,
+        [string]$FailureName = "dirty-worktree-gate"
+    )
+
+    return @(Invoke-GitStatusLines -Arguments @("status", "--porcelain") -CommandText "git status --porcelain" -FailureStep $FailureStep -FailureName $FailureName)
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
+function Test-IsAiDevOperationalPath {
+    param([string]$RelativePath)
+
+    $normalizedRelativePath = ConvertTo-NormalizedChangedPath $RelativePath
+    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::OrdinalIgnoreCase)
+}
+
+function Get-PlannedAutoGoalOutputPaths {
+    return @(
+        $ResultPath,
+        $goalRelativePath,
+        $queueRelativePath,
+        $stateRelativePath,
+        $promptRelativePath,
+        $planningPromptRelativePath,
+        ".ai-dev/codex-result.md",
+        $legacyAutoGoalResultRelativePath
+    ) |
+        Where-Object { Test-HasValue $_ } |
+        ForEach-Object { ConvertTo-NormalizedChangedPath (ConvertTo-RepoRelativePath $_) } |
+        Select-Object -Unique
+}
+
+function Invoke-BaselineOutputConflictGate {
+    param(
+        [string[]]$BaselineDirtyPaths,
+        [string[]]$PlannedOutputPaths
+    )
+
+    $conflictingPaths = @(
+        $BaselineDirtyPaths |
+            Where-Object { $PlannedOutputPaths -contains $_ } |
+            Select-Object -Unique
+    )
+
+    if ($conflictingPaths.Count -eq 0) {
+        return
+    }
+
+    $script:autoGoalCanWriteResultFile = $false
+    $script:autoGoalCanCleanTempArtifacts = $false
+    $message = "Baseline dirty paths conflict with planned auto-goal output paths. Auto-goal stopped before writing or deleting protected output files.`nConflicting paths:`n$($conflictingPaths -join "`n")"
+    $script:steps += New-StepResult 2 "baseline-output-conflict-gate" "compare baseline dirty paths with planned auto-goal outputs" $true $false 1 $message
+    Stop-AutoGoal $script:steps "baseline_output_conflict" $false 1
+}
+
+function Invoke-FinalAutoGoalChangeGate {
+    param(
+        [int]$StepNumber
+    )
+
+    Clear-AutoGoalTempArtifacts
+
+    $statusLines = @(Get-GitStatusLines $StepNumber "final-change-gate")
+    $command = "cleanup auto-goal temp artifacts, git status --short"
+    $baselineDirtyPaths = @($script:autoGoalBaselineDirtyPaths)
+    $baselineDirtyCount = $baselineDirtyPaths.Count
+    $finalDirtyCount = $statusLines.Count
+
+    if ($statusLines.Count -eq 0 -and $baselineDirtyCount -gt 0) {
+        $message = "Final clean verification failed: baseline dirty paths from auto-goal start are no longer visible in git status. They may have been committed or otherwise swallowed, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (baseline dirty disappeared).`nBaseline dirty paths:`n$($baselineDirtyPaths -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_baseline_dirty_disappeared" $false 1
+    }
+
+    if ($statusLines.Count -eq 0) {
+        $message = "Baseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (no final changes).`nFinal clean verification: git status --short returned no changes."
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 0 $message
+        return
+    }
+
+    $changedPaths = @(
+        $statusLines |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            Where-Object { Test-HasValue $_ } |
+            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+            Select-Object -Unique
+    )
+    $baselineRemainingPaths = @($changedPaths | Where-Object { $baselineDirtyPaths -contains $_ })
+    $baselineMissingPaths = @($baselineDirtyPaths | Where-Object { $changedPaths -notcontains $_ })
+    $nonAiDevPaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
+    $newAiDevPaths = @($changedPaths | Where-Object { (Test-IsAiDevOperationalPath $_) -and ($baselineDirtyPaths -notcontains $_) })
+
+    if ($baselineMissingPaths.Count -gt 0) {
+        $message = "Final clean verification failed: baseline dirty paths from auto-goal start disappeared before completion. They may have been committed or otherwise swallowed, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (baseline dirty disappeared).`nMissing baseline dirty paths:`n$($baselineMissingPaths -join "`n")`n$($statusLines -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_baseline_dirty_disappeared" $false 1
+    }
+
+    if ($baselineRemainingPaths.Count -gt 0) {
+        $message = "Final clean verification failed: baseline dirty files remain, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (baseline dirty remains).`nRemaining baseline dirty paths:`n$($baselineRemainingPaths -join "`n")`n$($statusLines -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_baseline_dirty_remains" $false 1
+    }
+
+    if ($nonAiDevPaths.Count -gt 0) {
+        $message = "Final clean verification failed: non-.ai-dev changes remain, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (non-.ai-dev dirty remains).`n$($statusLines -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_non_ai_dev_changes" $false 1
+    }
+
+    if ($newAiDevPaths.Count -eq 0) {
+        $message = "Final clean verification failed: dirty paths remain, but none are new .ai-dev operational changes that auto-goal may commit.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (no eligible .ai-dev changes).`n$($statusLines -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_no_eligible_meta_changes" $false 1
+    }
+
+    if (-not $AllowCommit) {
+        $message = "Final clean verification failed: only new .ai-dev operational changes remain, but -AllowCommit is required to create the final meta commit.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (-AllowCommit missing).`n$($statusLines -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_ai_dev_changes_require_commit" $false 1
+    }
+
+    $addArguments = @("add", "--") + $newAiDevPaths
+    $addOutput = & git @addArguments 2>&1 | Out-String
+    $addExitCode = $LASTEXITCODE
+
+    if ($addExitCode -ne 0) {
+        $message = "auto-goal 최종 .ai-dev 메타 변경 git add 실패. exit code: $addExitCode`n$addOutput"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-dev files>" $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_meta_add_failed" $false 1
+    }
+
+    $metaCommitMessage = "chore(ai-dev): record final auto-goal state"
+    $commitArguments = @("commit", "-m", $metaCommitMessage, "--") + $newAiDevPaths
+    $commitOutput = & git @commitArguments 2>&1 | Out-String
+    $commitExitCode = $LASTEXITCODE
+
+    if ($commitExitCode -ne 0) {
+        $message = "auto-goal 최종 .ai-dev 메타 커밋 실패. exit code: $commitExitCode`n$commitOutput"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m '$metaCommitMessage' -- <final .ai-dev files>" $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_meta_commit_failed" $false 1
+    }
+
+    $remainingStatus = @(Get-GitStatusLines $StepNumber "final-change-gate")
+
+    if ($remainingStatus.Count -gt 0) {
+        $message = "Final clean verification failed: changes remain after the final .ai-dev meta commit, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: yes`nFinal clean verification: failed; git status --short still reports $($remainingStatus.Count) change(s).`n$($remainingStatus -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git status --short" $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_worktree_dirty" $false 1
+    }
+
+    $message = ($commitOutput.Trim(), "Baseline dirty count: $baselineDirtyCount", "Final dirty count: $finalDirtyCount", "Final .ai-dev meta commit created: yes", "Final clean verification: git status --short returned no changes.") -join "`n"
+    $script:steps += New-StepResult $StepNumber "final-change-gate" "git add/commit final .ai-dev operational changes, git status --short" $true $false 0 $message
+}
+
+function Invoke-CompletedCleanVerification {
+    param([int]$StepNumber)
+
+    $remainingStatus = @(Get-GitStatusLines $StepNumber "completed-clean-gate")
+
+    if ($remainingStatus.Count -gt 0) {
+        $message = "Completed clean verification failed: git status --short still reports $($remainingStatus.Count) change(s) after all result/state files were written and the final gate ran.`n$($remainingStatus -join "`n")"
+        $script:steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $true $false 1 $message
+        Stop-AutoGoal $script:steps "completed_worktree_dirty" $false 1
+    }
+
+    $script:steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $true $false 0 "Completed clean verification passed: git status --short returned no changes after all result/state files were written."
+}
+
+function Invoke-FinalPreparedResultGate {
+    param(
+        [int]$StepNumber,
+        [int]$CleanGateStepNumber,
+        [string]$StoppedReason
+    )
+
+    Clear-AutoGoalTempArtifacts
+
+    $command = "write final result, git add/commit final .ai-dev operational changes, git status --short"
+    $baselineDirtyPaths = @($script:autoGoalBaselineDirtyPaths)
+    $baselineDirtyCount = $baselineDirtyPaths.Count
+    $preparedGateStepsWritten = $false
+
+    Save-AutoGoalResultFile $StoppedReason $true 0
+
+    $statusLines = @(Get-GitStatusLines $StepNumber "final-change-gate")
+    $finalDirtyCount = $statusLines.Count
+
+    if ($statusLines.Count -eq 0 -and $baselineDirtyCount -gt 0) {
+        $message = "Final clean verification failed: baseline dirty paths from auto-goal start are no longer visible in git status. They may have been committed or otherwise swallowed, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (baseline dirty disappeared).`nBaseline dirty paths:`n$($baselineDirtyPaths -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_baseline_dirty_disappeared" $false 1
+    }
+
+    if ($statusLines.Count -eq 0) {
+        $message = "Baseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount before writing final gate entries.`nFinal .ai-dev meta commit created: pending if final gate entries dirty the result file.`nFinal clean verification: git status --short will be required after the final result file is written."
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 0 $message
+        $script:steps += New-StepResult $CleanGateStepNumber "completed-clean-gate" "git status --short" $true $false 0 "Completed clean verification passed: git status --short returned no changes after the final result file was written."
+        Save-AutoGoalResultFile $StoppedReason $true 0
+        $preparedGateStepsWritten = $true
+        $statusLines = @(Get-GitStatusLines $StepNumber "final-change-gate")
+        $finalDirtyCount = $statusLines.Count
+
+        if ($statusLines.Count -eq 0) {
+            return
+        }
+    }
+
+    $changedPaths = @(
+        $statusLines |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            Where-Object { Test-HasValue $_ } |
+            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+            Select-Object -Unique
+    )
+    $baselineRemainingPaths = @($changedPaths | Where-Object { $baselineDirtyPaths -contains $_ })
+    $baselineMissingPaths = @($baselineDirtyPaths | Where-Object { $changedPaths -notcontains $_ })
+    $nonAiDevPaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
+    $newAiDevPaths = @($changedPaths | Where-Object { (Test-IsAiDevOperationalPath $_) -and ($baselineDirtyPaths -notcontains $_) })
+
+    if ($baselineMissingPaths.Count -gt 0) {
+        $message = "Final clean verification failed: baseline dirty paths from auto-goal start disappeared before completion. They may have been committed or otherwise swallowed, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (baseline dirty disappeared).`nMissing baseline dirty paths:`n$($baselineMissingPaths -join "`n")`n$($statusLines -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_baseline_dirty_disappeared" $false 1
+    }
+
+    if ($baselineRemainingPaths.Count -gt 0) {
+        $message = "Final clean verification failed: baseline dirty files remain, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (baseline dirty remains).`nRemaining baseline dirty paths:`n$($baselineRemainingPaths -join "`n")`n$($statusLines -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_baseline_dirty_remains" $false 1
+    }
+
+    if ($nonAiDevPaths.Count -gt 0) {
+        $message = "Final clean verification failed: non-.ai-dev changes remain, so auto-goal will not report completed.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (non-.ai-dev dirty remains).`n$($statusLines -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_non_ai_dev_changes" $false 1
+    }
+
+    if ($newAiDevPaths.Count -eq 0) {
+        $message = "Final clean verification failed: dirty paths remain, but none are new .ai-dev operational changes that auto-goal may commit.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (no eligible .ai-dev changes).`n$($statusLines -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_no_eligible_meta_changes" $false 1
+    }
+
+    if (-not $AllowCommit) {
+        $message = "Final clean verification failed: only new .ai-dev operational changes remain, but -AllowCommit is required to create the final meta commit.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (-AllowCommit missing).`n$($statusLines -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_ai_dev_changes_require_commit" $false 1
+    }
+
+    if (-not $preparedGateStepsWritten) {
+        $message = "Baseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta commit created: pending; this final result file is written before that commit and included in it.`nFinal .ai-dev paths to commit:`n$($newAiDevPaths -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 0 $message
+        $script:steps += New-StepResult $CleanGateStepNumber "completed-clean-gate" "git status --short" $true $false 0 "Completed clean verification is enforced immediately after the final .ai-dev meta commit; completed=true is returned only if git status --short reports no changes."
+        Save-AutoGoalResultFile $StoppedReason $true 0
+    }
+
+    $statusLines = @(Get-GitStatusLines $StepNumber "final-change-gate")
+    $newAiDevPaths = @(
+        $statusLines |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            Where-Object { Test-HasValue $_ } |
+            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+            Where-Object { (Test-IsAiDevOperationalPath $_) -and ($baselineDirtyPaths -notcontains $_) } |
+            Select-Object -Unique
+    )
+
+    if ($newAiDevPaths.Count -eq 0) {
+        $message = "Final clean verification failed: no final .ai-dev operational paths were available to commit after the final result file was written.`n$($statusLines -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_no_eligible_meta_changes" $false 1
+    }
+
+    $addArguments = @("add", "--") + $newAiDevPaths
+    $addOutput = & git @addArguments 2>&1 | Out-String
+    $addExitCode = $LASTEXITCODE
+
+    if ($addExitCode -ne 0) {
+        $message = "auto-goal 최종 .ai-dev 메타 변경 git add 실패. exit code: $addExitCode`n$addOutput"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-dev files>" $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_meta_add_failed" $false 1
+    }
+
+    $metaCommitMessage = "chore(ai-dev): record final auto-goal state"
+    $commitArguments = @("commit", "-m", $metaCommitMessage, "--") + $newAiDevPaths
+    $commitOutput = & git @commitArguments 2>&1 | Out-String
+    $commitExitCode = $LASTEXITCODE
+
+    if ($commitExitCode -ne 0) {
+        $message = "auto-goal 최종 .ai-dev 메타 커밋 실패. exit code: $commitExitCode`n$commitOutput"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m '$metaCommitMessage' -- <final .ai-dev files>" $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_meta_commit_failed" $false 1
+    }
+
+    $remainingStatus = @(Get-GitStatusLines $CleanGateStepNumber "completed-clean-gate")
+
+    if ($remainingStatus.Count -gt 0) {
+        $message = "Completed clean verification failed: changes remain after the final .ai-dev meta commit, so auto-goal will not report completed.`n$($remainingStatus -join "`n")"
+        $script:steps += New-StepResult $CleanGateStepNumber "completed-clean-gate" "git status --short" $true $false 1 $message
+        Stop-AutoGoal $script:steps "completed_worktree_dirty" $false 1
+    }
+}
+
+function Complete-AutoGoal {
+    param(
+        [int]$PreFinalGateStepNumber,
+        [int]$ResultStepNumber,
+        [int]$PostFinalGateStepNumber,
+        [int]$CleanGateStepNumber,
+        [string]$StoppedReason
+    )
+
+    Invoke-FinalAutoGoalChangeGate $PreFinalGateStepNumber
+    $script:steps += New-StepResult $ResultStepNumber "write-final-result" (ConvertTo-RepoRelativePath $ResultPath) $true $false 0 "Final success result file is written after the pre-result final change gate and before the final .ai-dev meta commit."
+    Invoke-FinalPreparedResultGate $PostFinalGateStepNumber $CleanGateStepNumber $StoppedReason
+    $script:autoGoalCanCleanTempArtifacts = $false
+    Stop-AutoGoal $script:steps $StoppedReason $true 0
+}
+
 function Get-JsonObjectCandidates {
     param([string]$RawInput)
 
@@ -715,6 +1127,11 @@ function Get-FullCycleArguments {
     # The downstream full cycle must tolerate those intended artifacts.
     $arguments += "-AllowDirty"
 
+    if ($script:autoGoalBaselineDirtyPaths.Count -gt 0) {
+        $arguments += "-ProtectedBaselineDirtyPaths"
+        $arguments += ($script:autoGoalBaselineDirtyPaths -join ",")
+    }
+
     if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
         $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
 
@@ -747,6 +1164,8 @@ Set-Location $repoRoot
 
 $script:steps = @()
 $script:autoGoalPlanPreview = $null
+$script:autoGoalBaselineStatusLines = @()
+$script:autoGoalBaselineDirtyPaths = @()
 $resolvedGoalPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $goalRelativePath))
 $resolvedQueuePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $queueRelativePath))
 $resolvedStatePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $stateRelativePath))
@@ -798,7 +1217,8 @@ if ($DryRun) {
         Stop-AutoGoal $script:steps "dry_run_preview_invalid" $false 1
     }
 
-    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $true 0 "DryRun: dirty worktree gate was not executed."
+    $plannedAutoGoalOutputPaths = @(Get-PlannedAutoGoalOutputPaths)
+    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --porcelain; compare baseline dirty paths with planned auto-goal outputs" $false $true 0 "DryRun: baseline dirty capture, dirty worktree gate, and baseline output conflict gate were not executed. Would check planned output paths: $($plannedAutoGoalOutputPaths -join ', ')"
     $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $false $true 0 "DryRun: Codex goal planning was not executed. Preview currentTaskId: T001, task: $GoalTitle"
     $script:steps += New-StepResult 4 "validate-generated-json" "goal/queue/state JSON validation" $false $true 0 "DryRun: preview goal/queue/state plan passed local schema validation."
     $script:steps += New-StepResult 5 "write-state-files" "$goalRelativePath, $queueRelativePath, $stateRelativePath" $false $true 0 "DryRun: state files were not written."
@@ -813,20 +1233,35 @@ if ($DryRun) {
     Stop-AutoGoal $script:steps "dry_run" $false 0
 }
 
-$statusLines = @(Get-GitStatusLines)
+$script:autoGoalBaselineStatusLines = @(Get-GitPorcelainStatusLines)
+$script:autoGoalBaselineDirtyPaths = @(
+    $script:autoGoalBaselineStatusLines |
+        ForEach-Object { Convert-ToChangedPath $_ } |
+        Where-Object { Test-HasValue $_ } |
+        ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+        Select-Object -Unique
+)
+$plannedAutoGoalOutputPaths = @(Get-PlannedAutoGoalOutputPaths)
+Invoke-BaselineOutputConflictGate $script:autoGoalBaselineDirtyPaths $plannedAutoGoalOutputPaths
+
+$statusLines = @($script:autoGoalBaselineStatusLines)
+$baselineDirtyCount = $script:autoGoalBaselineDirtyPaths.Count
 
 if ($statusLines.Count -gt 0 -and -not $AllowDirty) {
     $dirtyText = ($statusLines -join "`n")
-    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $true 1 "Worktree is dirty. Use -AllowDirty only when this is intentional.`n$dirtyText"
+    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --porcelain" $false $true 1 "Baseline dirty count: $baselineDirtyCount`nWorktree is dirty. Use -AllowDirty only when this is intentional.`n$dirtyText"
     Stop-AutoGoal $script:steps "dirty_worktree" $false 1
 }
 
 if ($statusLines.Count -gt 0) {
-    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 0 "AllowDirty is set. DirtyCount: $($statusLines.Count)"
+    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --porcelain" $true $false 0 "AllowDirty is set. Baseline dirty count: $baselineDirtyCount"
 } else {
-    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 0 "Worktree is clean."
+    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --porcelain" $true $false 0 "Baseline dirty count: 0. Worktree is clean."
 }
 
+$fullCycleArguments = @(Get-FullCycleArguments)
+$fullCycleCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 $($fullCycleArguments -join ' ')".Trim()
+
 $codexCommand = Get-Command codex -ErrorAction SilentlyContinue
 
 if ($null -eq $codexCommand) {
@@ -896,7 +1331,7 @@ Invoke-CycleCommand 6 "make-prompt" "powershell -ExecutionPolicy Bypass -File sc
 
 if (-not $shouldRunFullCycle) {
     $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleCommandText $false $true 0 "Full cycle requires -AllowRun or explicit execution options. -AllowRun only invokes the full-cycle wrapper; implementation and review still require -AllowCodex and -AllowReviewCodex."
-    Stop-AutoGoal $script:steps "prepared_without_full_cycle" $true 0
+    Complete-AutoGoal 8 9 10 11 "prepared_without_full_cycle"
 }
 
 Invoke-CycleCommand 7 "auto-cycle-full" $fullCycleCommandText $autoCycleFullPath $fullCycleArguments
@@ -915,5 +1350,5 @@ if ($goalStatusAfterFullCycle -ne "completed") {
 
 $script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $false 0 "auto-cycle-full 성공 후 goalStatus completed 확인."
 
-Stop-AutoGoal $script:steps "completed" $true 0
+Complete-AutoGoal 9 10 11 12 "completed"
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