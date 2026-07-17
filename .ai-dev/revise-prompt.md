# AI Dev Revise Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.
이전 리뷰에서 지적된 사항만 수정한다.

## Goal

# 목표
full auto-cycle 로그 구조를 현재 저장소 상태에 맞춰 작고 안전하게 개선한다.

## 배경
현재 AI Dev Loop의 full auto-cycle 진행 기록은 후속 점검과 실패 원인 파악에 필요한 정보가 충분히 구조화되어 있지 않을 수 있다. 이번 목표는 기존 동작을 크게 바꾸지 않고, 로그가 어떤 단계에서 어떤 결과를 남겼는지 더 명확히 확인할 수 있도록 최소 범위로 정리하는 것이다.

## 성공 기준
- full auto-cycle 실행 흐름에서 남기는 로그 항목의 구조가 더 일관되게 정리된다.
- 기존 로그 사용 지점과 충돌하지 않는다.
- 변경 범위가 관련 파일에 한정된다.
- 검증 방법이 명확히 기록된다.

## 제약사항
- 한 번에 하나의 작은 구현 단위만 진행한다.
- 기존 저장 방식과 타입 구조를 우선 확인한 뒤 필요한 최소 변경만 적용한다.
- 사용자 변경 사항을 되돌리지 않는다.
- 사용자 허용 없이 빌드, 테스트, lint, git 명령을 실행하지 않는다.

## 범위 제외
- full auto-cycle 전체 흐름 재작성은 제외한다.
- UI 화면 추가나 대규모 컴포넌트 분리는 제외한다.
- 저장소 전반의 로그 체계 재설계는 제외한다.

## 수동 검증
- 관련 로그 생성 코드를 확인해 변경된 구조가 의도대로 기록되는지 검토한다.
- 타입 오류 가능성이 있는 변경 지점을 정적으로 확인한다.
- 허용된 경우에만 빌드 또는 lint로 최종 검증한다.

## Current Task

- Task ID: T001
- Title: full auto-cycle 로그 구조 확인 및 최소 개선
- Description: 현재 full auto-cycle 로그가 생성되고 소비되는 위치를 확인한 뒤, 후속 분석에 필요한 필드가 일관되게 남도록 최소 범위로 구조를 개선한다.
- Type: implementation
- Status: in_progress
- Priority: P1
- Verification:
- 변경된 로그 구조가 기존 사용 지점과 충돌하지 않는지 확인한다.
- 허용된 경우 빌드 또는 lint를 실행해 정적 오류를 확인한다.

## Review Result

- Decision: revise
- Severity: high
- Next step: revise_with_codex
- Summary: 로그 컨텍스트 구조 개선은 현재 task와 맞지만, required file 경로 정규화 변경이 함께 포함되어 task 범위를 벗어납니다.

## Required Changes

- File: scripts/ai-dev-auto-cycle-full.ps1
  - Reason: 현재 task는 full auto-cycle 로그 구조의 최소 개선인데, ConvertTo-NormalizedChangedPath 및 Test-Revi
ewRequiredFileIsChanged 변경은 리뷰 required file 매칭 로직 수정으로 별도 동작 변경입니다.
  - Suggestion: 이번 task에서는 로그 context, task context, 출력 구조 개선에 필요한 변경만 남기고 경로 정규화 및 required fil
e 매칭 로직 변경은 별도 task로 분리하세요.

## Optional Suggestions

- optional_suggestions는 참고만 하며 구현하지 않는다.
- File: scripts/ai-dev-auto-cycle-full.ps1
  - Suggestion: New-CycleResult에 추가된 context 필드는 기존 steps/stoppedReason/completed/exitCode를 유지하므
로 방향은 적절합니다. 다만 최종 diff가 로그 구조 개선만 남도록 축소되면 리뷰 판단이 더 명확해집니다.

## Diff Context

# AI Dev Diff

## Generated At

2026-07-17 20:00:05

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
- .ai-dev/cycle-completed-task-context-fix-prompt.md
- .ai-dev/required-file-path-match-fix-prompt.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-auto-cycle-full.ps1 | 159 +++++++++++++++++++++++++++++++++----
 1 file changed, 144 insertions(+), 15 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 2e8c83a..2239467 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -150,6 +150,42 @@ function Get-CurrentTask {
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
@@ -180,11 +216,46 @@ function New-CycleResult {
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
+    if ($StoppedReason -eq "goal_completed" -and $null -ne $completedTaskContext) {
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
 
@@ -210,6 +281,35 @@ function Write-CycleResult {
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
 
@@ -406,7 +506,19 @@ function ConvertTo-NormalizedChangedPath {
         return $null
     }
 
-    return $RelativePath.Trim().Trim('"').Replace('\', '/')
+    $normalizedPath = $RelativePath.Trim()
+    $normalizedPath = $normalizedPath.Trim([char[]]@("`r", "`n", "`t", " ", '"', "'", ","))
+    $normalizedPath = $normalizedPath.Replace('\', '/')
+
+    while ($normalizedPath.StartsWith("./", [System.StringComparison]::Ordinal)) {
+        $normalizedPath = $normalizedPath.Substring(2)
+    }
+
+    if (-not (Test-HasValue $normalizedPath)) {
+        return $null
+    }
+
+    return $normalizedPath.ToLowerInvariant()
 }
 
 function Test-IsAiDevOperationalPath {
@@ -478,8 +590,16 @@ function Test-ReviewRequiredFileIsChanged {
         [string[]]$ChangedFiles
     )
 
+    $normalizedRequiredFile = ConvertTo-NormalizedChangedPath $RequiredFile
+
+    if (-not (Test-HasValue $normalizedRequiredFile)) {
+        return $false
+    }
+
     foreach ($changedFile in @($ChangedFiles)) {
-        if ($changedFile.Equals($RequiredFile, [System.StringComparison]::OrdinalIgnoreCase)) {
+        $normalizedChangedFile = ConvertTo-NormalizedChangedPath $changedFile
+
+        if ((Test-HasValue $normalizedChangedFile) -and $normalizedChangedFile.Equals($normalizedRequiredFile, [System.StringComparison]::OrdinalIgnoreCase)) {
             return $true
         }
     }
@@ -755,6 +875,10 @@ function Get-CommitGate {
 Set-Location $repoRoot
 
 $script:steps = @()
+$script:currentTask = $null
+$script:completedTask = $null
+$script:nextTask = $null
+$script:completedTaskCount = 0
 $script:protectedBaselineDirtyPaths = @(Get-ProtectedBaselineDirtyPaths)
 
 if ($script:protectedBaselineDirtyPaths.Count -gt 0) {
@@ -787,13 +911,13 @@ try {
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
 
@@ -844,13 +968,12 @@ if ($plannedSteps.Count -gt $MaxSteps) {
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
@@ -860,15 +983,15 @@ while ($completedTaskCount -lt $MaxTasks) {
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
 
@@ -883,7 +1006,7 @@ while ($completedTaskCount -lt $MaxTasks) {
         }
 
         if (Test-IsSavedReviewPassReady $resumeReviewGate) {
-            $resumeImplementationGate = Get-ReviewImplementationGate $currentTask $resumeReviewGate
+            $resumeImplementationGate = Get-ReviewImplementationGate $script:currentTask $resumeReviewGate
 
             if (-not $resumeImplementationGate.passed) {
                 Save-CycleFailureState "resume-review-gate" $resumeImplementationGate.message $resumeReviewGate
@@ -1009,7 +1132,7 @@ while ($completedTaskCount -lt $MaxTasks) {
     }
 
     if (Test-IsReviewReviseWithCodex $reviewGate) {
-        $implementationGate = Get-ReviewImplementationGate $currentTask $reviewGate
+        $implementationGate = Get-ReviewImplementationGate $script:currentTask $reviewGate
 
         if (-not $implementationGate.passed) {
             Save-CycleFailureState "review-gate" $implementationGate.message $reviewGate
@@ -1119,7 +1242,7 @@ while ($completedTaskCount -lt $MaxTasks) {
         Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 1
     }
 
-    $implementationGate = Get-ReviewImplementationGate $currentTask $reviewGate
+    $implementationGate = Get-ReviewImplementationGate $script:currentTask $reviewGate
 
     if (-not $implementationGate.passed) {
         Save-CycleFailureState "review-gate" $implementationGate.message $reviewGate
@@ -1233,6 +1356,8 @@ while ($completedTaskCount -lt $MaxTasks) {
         $completeTaskCommand = "$completeTaskCommand -CommitHash $commitHashForComplete"
     }
 
+    $completedTaskForContext = $script:currentTask
+
     Invoke-CycleCommand $stepNumber "complete-task" $completeTaskCommand $scriptPaths.completeTask $completeTaskArguments
     $stepNumber++
 
@@ -1242,9 +1367,13 @@ while ($completedTaskCount -lt $MaxTasks) {
     Invoke-CycleCommand $stepNumber "final-status" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1" $scriptPaths.status @()
     $stepNumber++
 
-    $completedTaskCount++
+    $script:completedTaskCount++
+    $script:completedTask = $completedTaskForContext
 
+    $queueAfterComplete = Read-JsonFile $queuePath $queueRelativePath
     $stateAfterComplete = Read-JsonFile $statePath $stateRelativePath
+    $script:currentTask = Get-CurrentTask $queueAfterComplete $stateAfterComplete
+    $script:nextTask = Get-NextTask $queueAfterComplete $stateAfterComplete $completedTaskForContext
 
     if ($stateAfterComplete.goalStatus -eq "completed") {
         Complete-Cycle $script:steps "goal_completed" $stepNumber
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```

## Test Result

# AI Dev Test Result

## 2026-07-17 19:59:58

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
dist/index.html                   0.46 kB │ gzip:   0.29 kB
dist/assets/index-DvjxWt30.css    5.69 kB │ gzip:   1.93 kB
dist/assets/index-DtLVvPCG.js   317.50 kB │ gzip: 100.16 kB

[32m✓ built in 201ms[39m
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

## Allowed Scope

- required_changes에 필요한 최소 수정만 허용한다.
- 현재 task 범위를 벗어나지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 새 기능 추가보다 리뷰 지적사항 해결을 우선한다.

## Hard Rules

- `package.json`과 `package-lock.json`은 수정하지 않는다. 꼭 필요하면 중단하고 이유만 기록한다.
- 실제 DB 삭제 또는 초기화를 하지 않는다.
- 사용자 데이터 복원 또는 덮어쓰기를 하지 않는다.
- 대규모 리팩터링을 하지 않는다.
- git commit을 실행하지 않는다.
- git reset, git checkout, git clean을 실행하지 않는다.
- npm install을 실행하지 않는다.
- optional_suggestions는 기본적으로 구현하지 않는다.

## Required Output

- 반영한 required_changes 목록
- 수정한 파일 목록
- 검증 방법
- 반영하지 못한 항목과 이유
- 남은 위험
- `.ai-dev/loop-log.md`에 기록할 재수정 요약