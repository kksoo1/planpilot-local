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
- Depends on:
- 없음
- Verification:
- 변경된 로그 구조가 기존 사용 지점과 충돌하지 않는지 확인한다.
- 허용된 경우 빌드 또는 lint를 실행해 정적 오류를 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-17 20:11:42

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

[32m✓ built in 185ms[39m
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

## Diff To Review

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