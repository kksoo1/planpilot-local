# AI Dev Diff

## Generated At

2026-07-17 20:11:49

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
 M scripts/ai-dev-auto-cycle-full.ps1
?? .ai-dev/completed-task-context-before-final-status-prompt.md
?? .ai-dev/cycle-completed-task-context-fix-prompt.md
?? .ai-dev/required-file-path-match-fix-prompt.md
```

## App Change Files

- scripts/ai-dev-auto-cycle-full.ps1

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
- .ai-dev/completed-task-context-before-final-status-prompt.md
- .ai-dev/cycle-completed-task-context-fix-prompt.md
- .ai-dev/required-file-path-match-fix-prompt.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-auto-cycle-full.ps1 | 183 ++++++++++++++++++++++++++++++++++---
 1 file changed, 169 insertions(+), 14 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 2e8c83a..5d3fa84 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -150,6 +150,91 @@ function Get-CurrentTask {
     return $tasks | Where-Object { $_.id -eq $currentTaskId } | Select-Object -First 1
 }
 
+function Get-NextTask {
+    param(
+        [object]$Queue,
+        [object]$State,
+        [object]$CompletedTask
+    )
+
+    $currentTask = Get-CurrentTask $Queue $State
+    $completedTaskId = if ($null -ne $CompletedTask -and (Test-HasValue $CompletedTask.id)) { [string]$CompletedTask.id } else { $null }
+
+    if ($null -ne $currentTask -and $currentTask.status -ne "done" -and $currentTask.id -ne $completedTaskId) {
+        return $currentTask
+    }
+
+    return @($Queue.tasks) |
+        Where-Object { $_.status -in @("in_progress", "pending") -and $_.id -ne $completedTaskId } |
+        Select-Object -First 1
+}
+
+function Update-PostCompleteTaskContext {
+    param(
+        [object]$CompletedTask
+    )
+
+    $completedTaskForContext = $null
+    $completedTaskId = $null
+
+    if ($null -ne $CompletedTask) {
+        $completedTaskId = if (Test-HasValue $CompletedTask.id) { [string]$CompletedTask.id } else { $null }
+        $completedTaskForContext = [PSCustomObject][ordered]@{
+            id = [string]$CompletedTask.id
+            title = [string]$CompletedTask.title
+            status = "done"
+            type = [string]$CompletedTask.type
+        }
+    }
+
+    $script:completedTask = $completedTaskForContext
+    $script:completedTaskCount++
+    $script:currentTask = $null
+    $script:nextTask = $null
+
+    try {
+        $queueAfterComplete = Read-JsonFile $queuePath $queueRelativePath
+        $stateAfterComplete = Read-JsonFile $statePath $stateRelativePath
+
+        if (Test-HasValue $completedTaskId) {
+            $refreshedCompletedTask = @($queueAfterComplete.tasks) |
+                Where-Object { $_.id -eq $completedTaskId } |
+                Select-Object -First 1
+
+            if ($null -ne $refreshedCompletedTask) {
+                $script:completedTask = $refreshedCompletedTask
+            }
+        }
+
+        $currentTaskAfterComplete = Get-CurrentTask $queueAfterComplete $stateAfterComplete
+
+        if ($null -ne $currentTaskAfterComplete -and $currentTaskAfterComplete.status -ne "done" -and $currentTaskAfterComplete.id -ne $completedTaskId) {
+            $script:currentTask = $currentTaskAfterComplete
+        }
+
+        $script:nextTask = Get-NextTask $queueAfterComplete $stateAfterComplete $script:completedTask
+    } catch {
+        Write-Warning "complete-task 이후 task context를 최신 queue/state로 갱신하지 못했습니다: $($_.Exception.Message)"
+    }
+}
+
+function ConvertTo-TaskContext {
+    param(
+        [object]$Task
+    )
+
+    if ($null -eq $Task) {
+        return $null
+    }
+
+    return [PSCustomObject][ordered]@{
+        id = [string]$Task.id
+        title = [string]$Task.title
+        status = [string]$Task.status
+        type = [string]$Task.type
+    }
+}
+
 function New-StepResult {
     param(
         [int]$Step,
@@ -180,11 +265,46 @@ function New-CycleResult {
         [int]$ExitCode
     )
 
+    $lastStep = @($Steps) | Select-Object -Last 1
+    $currentTask = $script:currentTask
+    $completedTask = $script:completedTask
+    $nextTask = $script:nextTask
+    $currentTaskContext = ConvertTo-TaskContext $currentTask
+    $completedTaskContext = ConvertTo-TaskContext $completedTask
+    $nextTaskContext = ConvertTo-TaskContext $nextTask
+    $taskContext = $currentTaskContext
+    $lastStepContext = $null
+
+    if ($null -eq $taskContext -and $null -ne $completedTaskContext) {
+        $taskContext = $completedTaskContext
+    }
+
+    if ($null -ne $lastStep) {
+        $lastStepContext = [PSCustomObject][ordered]@{
+            step = $lastStep.step
+            name = $lastStep.name
+            executed = $lastStep.executed
+            skipped = $lastStep.skipped
+            exitCode = $lastStep.exitCode
+        }
+    }
+
     return [PSCustomObject][ordered]@{
         steps = @($Steps)
         stoppedReason = $StoppedReason
         completed = $Completed
         exitCode = $ExitCode
+        context = [PSCustomObject][ordered]@{
+            task = $taskContext
+            completedTask = $completedTaskContext
+            currentTask = $currentTaskContext
+            nextTask = $nextTaskContext
+            completedTaskCount = $script:completedTaskCount
+            maxTasks = $MaxTasks
+            maxSteps = $MaxSteps
+            stepCount = @($Steps).Count
+            lastStep = $lastStepContext
+        }
     }
 }
 
@@ -210,6 +330,35 @@ function Write-CycleResult {
     Write-Host "Stopped reason: $($Result.stoppedReason)"
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
+    Write-Host "Context:"
+    if ($null -ne $Result.context.task) {
+        Write-Host "  Task: $($Result.context.task.id) $($Result.context.task.title)"
+        Write-Host "  Task status: $($Result.context.task.status)"
+    } else {
+        Write-Host "  Task: none"
+    }
+    if ($null -ne $Result.context.completedTask) {
+        Write-Host "  Completed task: $($Result.context.completedTask.id) $($Result.context.completedTask.title)"
+    } else {
+        Write-Host "  Completed task: none"
+    }
+    if ($null -ne $Result.context.currentTask) {
+        Write-Host "  Current task: $($Result.context.currentTask.id) $($Result.context.currentTask.title)"
+    } else {
+        Write-Host "  Current task: none"
+    }
+    if ($null -ne $Result.context.nextTask) {
+        Write-Host "  Next task: $($Result.context.nextTask.id) $($Result.context.nextTask.title)"
+    } else {
+        Write-Host "  Next task: none"
+    }
+    Write-Host "  Completed tasks: $($Result.context.completedTaskCount) / $($Result.context.maxTasks)"
+    Write-Host "  Steps recorded: $($Result.context.stepCount) / $($Result.context.maxSteps)"
+    if ($null -ne $Result.context.lastStep) {
+        Write-Host "  Last step: $($Result.context.lastStep.step) $($Result.context.lastStep.name) exit=$($Result.context.lastStep.exitCode)"
+    } else {
+        Write-Host "  Last step: none"
+    }
 
 }
 
@@ -755,6 +904,10 @@ function Get-CommitGate {
 Set-Location $repoRoot
 
 $script:steps = @()
+$script:currentTask = $null
+$script:completedTask = $null
+$script:nextTask = $null
+$script:completedTaskCount = 0
 $script:protectedBaselineDirtyPaths = @(Get-ProtectedBaselineDirtyPaths)
 
 if ($script:protectedBaselineDirtyPaths.Count -gt 0) {
@@ -787,13 +940,13 @@ try {
         Stop-Cycle $script:steps "no_task" $false 0
     }
 
-    $currentTask = Get-CurrentTask $queue $state
+    $script:currentTask = Get-CurrentTask $queue $state
 
-    if ($null -eq $currentTask) {
+    if ($null -eq $script:currentTask) {
         Stop-Cycle $script:steps "no_task" $false 0
     }
 
-    if ($currentTask.status -eq "done") {
+    if ($script:currentTask.status -eq "done") {
         Complete-Cycle $script:steps "current_task_done" 0
     }
 
@@ -844,13 +997,12 @@ if ($plannedSteps.Count -gt $MaxSteps) {
 }
 
 $stepNumber = 1
-$completedTaskCount = 0
 
-while ($completedTaskCount -lt $MaxTasks) {
+while ($script:completedTaskCount -lt $MaxTasks) {
     try {
         $queue = Read-JsonFile $queuePath $queueRelativePath
         $state = Read-JsonFile $statePath $stateRelativePath
-        $currentTask = Get-CurrentTask $queue $state
+        $script:currentTask = Get-CurrentTask $queue $state
     } catch {
         $script:steps += New-StepResult $stepNumber "load-task" "state/queue 확인" $false $false 1 $_.Exception.Message
         Stop-Cycle $script:steps "load_task_failed" $false 1
@@ -860,15 +1012,15 @@ while ($completedTaskCount -lt $MaxTasks) {
         Complete-Cycle $script:steps "goal_completed" $stepNumber
     }
 
-    if ($null -eq $currentTask) {
+    if ($null -eq $script:currentTask) {
         Stop-Cycle $script:steps "no_task" $false 0
     }
 
-    if ($currentTask.status -eq "done") {
+    if ($script:currentTask.status -eq "done") {
         Complete-Cycle $script:steps "current_task_done" $stepNumber
     }
 
-    $taskLabel = "$($currentTask.id) $($currentTask.title)"
+    $taskLabel = "$($script:currentTask.id) $($script:currentTask.title)"
     $script:steps += New-StepResult $stepNumber "task-start" "MaxTasks=$MaxTasks" $false $false 0 "현재 task 실행 시작: $taskLabel"
     $stepNumber++
 
@@ -883,7 +1035,7 @@ while ($completedTaskCount -lt $MaxTasks) {
         }
 
         if (Test-IsSavedReviewPassReady $resumeReviewGate) {
-            $resumeImplementationGate = Get-ReviewImplementationGate $currentTask $resumeReviewGate
+            $resumeImplementationGate = Get-ReviewImplementationGate $script:currentTask $resumeReviewGate
 
             if (-not $resumeImplementationGate.passed) {
                 Save-CycleFailureState "resume-review-gate" $resumeImplementationGate.message $resumeReviewGate
@@ -1009,7 +1161,7 @@ while ($completedTaskCount -lt $MaxTasks) {
     }
 
     if (Test-IsReviewReviseWithCodex $reviewGate) {
-        $implementationGate = Get-ReviewImplementationGate $currentTask $reviewGate
+        $implementationGate = Get-ReviewImplementationGate $script:currentTask $reviewGate
 
         if (-not $implementationGate.passed) {
             Save-CycleFailureState "review-gate" $implementationGate.message $reviewGate
@@ -1119,7 +1271,7 @@ while ($completedTaskCount -lt $MaxTasks) {
         Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 1
     }
 
-    $implementationGate = Get-ReviewImplementationGate $currentTask $reviewGate
+    $implementationGate = Get-ReviewImplementationGate $script:currentTask $reviewGate
 
     if (-not $implementationGate.passed) {
         Save-CycleFailureState "review-gate" $implementationGate.message $reviewGate
@@ -1233,17 +1385,20 @@ while ($completedTaskCount -lt $MaxTasks) {
         $completeTaskCommand = "$completeTaskCommand -CommitHash $commitHashForComplete"
     }
 
+    $completedTaskForContext = $script:currentTask
+
     Invoke-CycleCommand $stepNumber "complete-task" $completeTaskCommand $scriptPaths.completeTask $completeTaskArguments
     $stepNumber++
 
+    Update-PostCompleteTaskContext $completedTaskForContext
+
     Invoke-DirectMetaCommit $stepNumber
     $stepNumber++
 
     Invoke-CycleCommand $stepNumber "final-status" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1" $scriptPaths.status @()
     $stepNumber++
 
-    $completedTaskCount++
-
+    $queueAfterComplete = Read-JsonFile $queuePath $queueRelativePath
     $stateAfterComplete = Read-JsonFile $statePath $stateRelativePath
 
     if ($stateAfterComplete.goalStatus -eq "completed") {
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```