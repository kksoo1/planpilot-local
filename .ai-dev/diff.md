# AI Dev Diff

## Generated At

2026-06-23 15:26:37

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
 M scripts/ai-dev-auto-cycle.ps1
```

## App Change Files

- scripts/ai-dev-auto-cycle-full.ps1
- scripts/ai-dev-auto-cycle.ps1

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
 scripts/ai-dev-auto-cycle-full.ps1 | 137 +++++++++++-
 scripts/ai-dev-auto-cycle.ps1      | 426 +++++++++++++++++++++++++++++++++++++
 2 files changed, 562 insertions(+), 1 deletion(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 476fb1e..5031713 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -76,6 +76,34 @@ function Write-JsonFile {
     [System.IO.File]::WriteAllText($Path, $json, $utf8WithBom)
 }
 
+function Save-CycleFailureState {
+    param(
+        [string]$Command,
+        [string]$ErrorSummary,
+        [object]$ReviewGate = $null
+    )
+
+    try {
+        $state = Read-JsonFile $statePath $stateRelativePath
+
+        if ($null -ne $ReviewGate -and (Test-HasValue $ReviewGate.decision)) {
+            Set-ObjectProperty $state "lastReviewDecision" ([string]$ReviewGate.decision)
+        }
+
+        if ($null -ne $ReviewGate -and (Test-HasValue $ReviewGate.severity)) {
+            Set-ObjectProperty $state "lastReviewSeverity" ([string]$ReviewGate.severity)
+        }
+
+        Set-ObjectProperty $state "lastCommand" $Command
+        Set-ObjectProperty $state "lastCommandStatus" "failed"
+        Set-ObjectProperty $state "lastErrorSummary" $ErrorSummary
+        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
+        Write-JsonFile $statePath $state
+    } catch {
+        Write-Warning "상태 파일에 실패 사유를 기록하지 못했습니다: $($_.Exception.Message)"
+    }
+}
+
 function Get-CurrentTask {
     param(
         [object]$Queue,
@@ -414,6 +442,84 @@ function Get-ChangedNonAiDevFiles {
     )
 }
 
+function Get-RequiredReviewChangeFiles {
+    param(
+        [object]$ReviewResponse
+    )
+
+    if ($null -eq $ReviewResponse -or -not ($ReviewResponse.PSObject.Properties.Name -contains "required_changes")) {
+        return @()
+    }
+
+    return @(
+        @($ReviewResponse.required_changes) |
+            Where-Object { $null -ne $_ -and ($_.PSObject.Properties.Name -contains "file") -and (Test-HasValue $_.file) } |
+            ForEach-Object { ConvertTo-NormalizedChangedPath ([string]$_.file) } |
+            Where-Object { (Test-HasValue $_) -and $_ -ne "unknown" -and -not (Test-IsAiDevOperationalPath $_) -and -not (Test-IsProtectedBaselineDirtyPath $_) } |
+            Select-Object -Unique
+    )
+}
+
+function Test-ReviewRequiredFileIsChanged {
+    param(
+        [string]$RequiredFile,
+        [string[]]$ChangedFiles
+    )
+
+    foreach ($changedFile in @($ChangedFiles)) {
+        if ($changedFile.Equals($RequiredFile, [System.StringComparison]::OrdinalIgnoreCase)) {
+            return $true
+        }
+    }
+
+    return $false
+}
+
+function Get-ReviewImplementationGate {
+    param(
+        [object]$CurrentTask,
+        [object]$ReviewGate
+    )
+
+    $taskType = if ($null -ne $CurrentTask -and (Test-HasValue $CurrentTask.type)) { [string]$CurrentTask.type } else { "" }
+    $requiredFiles = @($ReviewGate.requiredChangeFiles)
+    $changedFiles = @(Get-ChangedNonAiDevFiles)
+    $missingRequiredFiles = @(
+        $requiredFiles |
+            Where-Object { -not (Test-ReviewRequiredFileIsChanged $_ $changedFiles) }
+    )
+
+    if ($ReviewGate.decision -eq "revise" -and $taskType -ne "implementation") {
+        return [PSCustomObject][ordered]@{
+            passed = $false
+            reason = "non_implementation_revise"
+            message = "현재 task type이 implementation이 아닌데 review decision=revise입니다. 구현 없는 revise 반복을 성공 처리하지 않도록 중단합니다. taskType='$taskType', requiredFiles=$($requiredFiles -join ', '), changedFiles=$($changedFiles -join ', ')"
+        }
+    }
+
+    if ($requiredFiles.Count -gt 0 -and $changedFiles.Count -eq 0) {
+        return [PSCustomObject][ordered]@{
+            passed = $false
+            reason = "missing_implementation"
+            message = "review-response.json이 구현 파일 변경을 요구했지만 현재 diff에 구현 변경 파일이 없습니다. requiredFiles=$($requiredFiles -join ', ')"
+        }
+    }
+
+    if ($missingRequiredFiles.Count -gt 0) {
+        return [PSCustomObject][ordered]@{
+            passed = $false
+            reason = "stale_review_required_file_missing"
+            message = "review-response.json이 요구한 구현 파일 변경이 현재 diff에 없습니다. stale review 또는 missing implementation으로 보고 완료 흐름을 차단합니다. missingRequiredFiles=$($missingRequiredFiles -join ', '), changedFiles=$($changedFiles -join ', ')"
+        }
+    }
+
+    return [PSCustomObject][ordered]@{
+        passed = $true
+        reason = "ok"
+        message = "review-response.json required_changes와 현재 diff 파일 목록이 일치합니다."
+    }
+}
+
 function Get-ChangedAiDevOperationalFiles {
     $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
     $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
@@ -463,6 +569,7 @@ function Get-ReviewGate {
         hasNextStep = $hasNextStep
         nextStep = $nextStep
         normalizedNextStep = $normalizedNextStep
+        requiredChangeFiles = @(Get-RequiredReviewChangeFiles $reviewResponse)
     }
 }
 
@@ -716,11 +823,29 @@ while ($completedTaskCount -lt $MaxTasks) {
         }
 
         if (Test-IsSavedReviewPassReady $resumeReviewGate) {
+            $resumeImplementationGate = Get-ReviewImplementationGate $currentTask $resumeReviewGate
+
+            if (-not $resumeImplementationGate.passed) {
+                Save-CycleFailureState "resume-review-gate" $resumeImplementationGate.message $resumeReviewGate
+                $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response required_changes 및 현재 diff 확인" $false $true 1 $resumeImplementationGate.message
+                Stop-Cycle $script:steps $resumeImplementationGate.reason $false 1
+            }
+
             $resumeFromSavedReview = $true
             $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $false 0 "이미 저장된 리뷰 pass와 허용 가능한 next_step 상태를 확인했습니다. 구현/리뷰 재실행 없이 commit/complete/meta-commit으로 계속 진행합니다."
             $stepNumber++
         } elseif ($resumeReviewGate.lastCommand -eq "save-review" -and $resumeReviewGate.lastCommandStatus -eq "passed") {
+            $resumeImplementationGate = Get-ReviewImplementationGate $currentTask $resumeReviewGate
             $message = "save-review 이후 계속 진행할 수 없습니다. review.decision=$($resumeReviewGate.decision), state.lastReviewDecision=$($resumeReviewGate.stateDecision), next_step=$($resumeReviewGate.nextStep)"
+
+            if (-not $resumeImplementationGate.passed) {
+                $message = $resumeImplementationGate.message
+                Save-CycleFailureState "resume-review-gate" $message $resumeReviewGate
+                $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response required_changes 및 현재 diff 확인" $false $true 1 $message
+                Stop-Cycle $script:steps $resumeImplementationGate.reason $false 1
+            }
+
+            Save-CycleFailureState "resume-review-gate" $message $resumeReviewGate
             $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $true 1 $message
             Stop-Cycle $script:steps "saved_review_not_ready_to_complete" $false 1
         }
@@ -817,8 +942,18 @@ while ($completedTaskCount -lt $MaxTasks) {
         Stop-Cycle $script:steps "review_save_not_passed" $false 1
     }
 
+    $implementationGate = Get-ReviewImplementationGate $currentTask $reviewGate
+
+    if (-not $implementationGate.passed) {
+        Save-CycleFailureState "review-gate" $implementationGate.message $reviewGate
+        $script:steps += New-StepResult $stepNumber "review-gate" "task type, $reviewResponseRelativePath required_changes, 현재 diff 확인" $false $true 1 $implementationGate.message
+        Stop-Cycle $script:steps $implementationGate.reason $false 1
+    }
+
     if ($reviewGate.decision -ne "pass") {
-        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath decision 확인" $false $true 1 "리뷰 response decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+        $message = "리뷰 response decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+        Save-CycleFailureState "review-gate" $message $reviewGate
+        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath decision 확인" $false $true 1 $message
         Stop-Cycle $script:steps "review_not_pass" $false 1
     }
 
diff --git a/scripts/ai-dev-auto-cycle.ps1 b/scripts/ai-dev-auto-cycle.ps1
index c20ee3e..2d131c2 100644
--- a/scripts/ai-dev-auto-cycle.ps1
+++ b/scripts/ai-dev-auto-cycle.ps1
@@ -65,6 +65,347 @@ function New-CycleResult {
     }
 }
 
+function Test-HasValue {
+    param([object]$Value)
+
+    if ($null -eq $Value) {
+        return $false
+    }
+
+    if ($Value -is [string]) {
+        return -not [string]::IsNullOrWhiteSpace($Value)
+    }
+
+    return $true
+}
+
+function Read-JsonFile {
+    param(
+        [string]$Path,
+        [string]$RelativePath
+    )
+
+    try {
+        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | ConvertFrom-Json
+    } catch {
+        throw "$RelativePath JSON 파싱에 실패했습니다: $($_.Exception.Message)"
+    }
+}
+
+function Set-ObjectProperty {
+    param(
+        [object]$InputObject,
+        [string]$Name,
+        [object]$Value
+    )
+
+    if ($InputObject.PSObject.Properties.Name -contains $Name) {
+        $InputObject.$Name = $Value
+    } else {
+        $InputObject | Add-Member -NotePropertyName $Name -NotePropertyValue $Value
+    }
+}
+
+function Write-JsonFile {
+    param(
+        [string]$Path,
+        [object]$Value
+    )
+
+    $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
+    $json = $Value | ConvertTo-Json -Depth 20
+    [System.IO.File]::WriteAllText($Path, $json, $utf8WithBom)
+}
+
+function Save-CycleFailureState {
+    param(
+        [string]$Command,
+        [string]$StoppedReason,
+        [string]$Message,
+        [string[]]$MissingRequiredFiles = @()
+    )
+
+    if ($DryRun) {
+        return
+    }
+
+    try {
+        $stateRelativePath = ".ai-dev/state.json"
+        $statePath = Join-Path (Get-Location).Path $stateRelativePath
+        $state = Read-JsonFile $statePath $stateRelativePath
+        $errorParts = @("stoppedReason=$StoppedReason")
+
+        if ($MissingRequiredFiles.Count -gt 0) {
+            $errorParts += "missingRequiredFiles=$($MissingRequiredFiles -join ', ')"
+        }
+
+        if (Test-HasValue $Message) {
+            $errorParts += $Message
+        }
+
+        Set-ObjectProperty $state "lastCommand" $Command
+        Set-ObjectProperty $state "lastCommandStatus" "failed"
+        Set-ObjectProperty $state "lastErrorSummary" ($errorParts -join "; ")
+        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
+        Write-JsonFile $statePath $state
+    } catch {
+        Write-Warning "상태 파일에 실패 사유를 기록하지 못했습니다: $($_.Exception.Message)"
+    }
+}
+
+function Invoke-GitCapture {
+    param(
+        [string[]]$Arguments,
+        [string]$DisplayName
+    )
+
+    $output = & git @Arguments 2>&1 | Out-String
+    $exitCode = $LASTEXITCODE
+
+    if ($exitCode -ne 0) {
+        throw "$DisplayName 실행에 실패했습니다. exit code: $exitCode`n$output"
+    }
+
+    return $output.TrimEnd()
+}
+
+function Get-CurrentTask {
+    param(
+        [object]$Queue,
+        [object]$State
+    )
+
+    $tasks = @($Queue.tasks)
+    $currentTaskId = $null
+
+    if (Test-HasValue $State.currentTaskId) {
+        $currentTaskId = [string]$State.currentTaskId
+    } elseif (Test-HasValue $Queue.currentTaskId) {
+        $currentTaskId = [string]$Queue.currentTaskId
+    } else {
+        $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-Object -First 1
+
+        if ($null -ne $inProgressTask) {
+            $currentTaskId = [string]$inProgressTask.id
+        } else {
+            $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Object -First 1
+
+            if ($null -ne $pendingTask) {
+                $currentTaskId = [string]$pendingTask.id
+            }
+        }
+    }
+
+    if (-not (Test-HasValue $currentTaskId)) {
+        return $null
+    }
+
+    return $tasks | Where-Object { $_.id -eq $currentTaskId } | Select-Object -First 1
+}
+
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
+function Test-IsAiDevOperationalPath {
+    param(
+        [string]$RelativePath
+    )
+
+    $normalizedRelativePath = ConvertTo-NormalizedChangedPath $RelativePath
+    return $normalizedRelativePath.StartsWith(".ai-dev/", [System.StringComparison]::OrdinalIgnoreCase)
+}
+
+function Get-ChangedNonAiDevFiles {
+    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
+    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
+
+    return @(
+        $changeLines |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+            Where-Object { (Test-HasValue $_) -and -not (Test-IsAiDevOperationalPath $_) } |
+            Select-Object -Unique
+    )
+}
+
+function Get-RequiredReviewChangeFiles {
+    param(
+        [object]$ReviewResponse
+    )
+
+    if ($null -eq $ReviewResponse -or -not ($ReviewResponse.PSObject.Properties.Name -contains "required_changes")) {
+        return @()
+    }
+
+    return @(
+        @($ReviewResponse.required_changes) |
+            Where-Object { $null -ne $_ -and ($_.PSObject.Properties.Name -contains "file") -and (Test-HasValue $_.file) } |
+            ForEach-Object { ConvertTo-NormalizedChangedPath ([string]$_.file) } |
+            Where-Object { (Test-HasValue $_) -and $_ -ne "unknown" -and -not (Test-IsAiDevOperationalPath $_) } |
+            Select-Object -Unique
+    )
+}
+
+function Test-ReviewRequiredFileIsChanged {
+    param(
+        [string]$RequiredFile,
+        [string[]]$ChangedFiles
+    )
+
+    foreach ($changedFile in @($ChangedFiles)) {
+        if ($changedFile.Equals($RequiredFile, [System.StringComparison]::OrdinalIgnoreCase)) {
+            return $true
+        }
+    }
+
+    return $false
+}
+
+function Test-IsNonImplementationReviseAction {
+    param([string]$Action)
+
+    if ($Action -ne "make_revise_prompt") {
+        return $false
+    }
+
+    $queueRelativePath = ".ai-dev/queue.json"
+    $stateRelativePath = ".ai-dev/state.json"
+    $queue = Read-JsonFile (Join-Path (Get-Location).Path $queueRelativePath) $queueRelativePath
+    $state = Read-JsonFile (Join-Path (Get-Location).Path $stateRelativePath) $stateRelativePath
+    $currentTask = Get-CurrentTask $queue $state
+
+    if ($null -eq $currentTask) {
+        return $false
+    }
+
+    return [string]$currentTask.type -ne "implementation"
+}
+
+function Get-ReviewRequiredChangesGate {
+    param(
+        [switch]$OnlyWhenCurrentTaskIsImplementation
+    )
+
+    $queueRelativePath = ".ai-dev/queue.json"
+    $stateRelativePath = ".ai-dev/state.json"
+    $reviewResponseRelativePath = ".ai-dev/review-response.json"
+
+    if ($OnlyWhenCurrentTaskIsImplementation) {
+        $queue = Read-JsonFile (Join-Path (Get-Location).Path $queueRelativePath) $queueRelativePath
+        $state = Read-JsonFile (Join-Path (Get-Location).Path $stateRelativePath) $stateRelativePath
+        $currentTask = Get-CurrentTask $queue $state
+
+        if ($null -eq $currentTask -or [string]$currentTask.type -ne "implementation") {
+            return [PSCustomObject][ordered]@{
+                passed = $true
+                reason = "ok"
+                message = ""
+            }
+        }
+    }
+
+    $reviewResponsePath = Join-Path (Get-Location).Path $reviewResponseRelativePath
+
+    if (-not (Test-Path -LiteralPath $reviewResponsePath -PathType Leaf)) {
+        return [PSCustomObject][ordered]@{
+            passed = $true
+            reason = "ok"
+            message = ""
+        }
+    }
+
+    $reviewResponse = Read-JsonFile $reviewResponsePath $reviewResponseRelativePath
+    $requiredFiles = @(Get-RequiredReviewChangeFiles $reviewResponse)
+
+    if ($requiredFiles.Count -eq 0) {
+        return [PSCustomObject][ordered]@{
+            passed = $true
+            reason = "ok"
+            message = ""
+        }
+    }
+
+    $changedFiles = @(Get-ChangedNonAiDevFiles)
+    $missingRequiredFiles = @(
+        $requiredFiles |
+            Where-Object { -not (Test-ReviewRequiredFileIsChanged $_ $changedFiles) }
+    )
+
+    if ($requiredFiles.Count -gt 0 -and $changedFiles.Count -eq 0) {
+        return [PSCustomObject][ordered]@{
+            passed = $false
+            reason = "missing_implementation"
+            message = "review-response.json이 구현 파일 변경을 요구했지만 현재 non-.ai-dev diff에 구현 변경 파일이 없습니다. missingRequiredFiles=$($requiredFiles -join ', ')"
+            missingRequiredFiles = @($requiredFiles)
+        }
+    }
+
+    if ($missingRequiredFiles.Count -gt 0) {
+        return [PSCustomObject][ordered]@{
+            passed = $false
+            reason = "stale_review_required_file_missing"
+            message = "review-response.json이 요구한 구현 파일 변경이 현재 non-.ai-dev diff에 없습니다. missingRequiredFiles=$($missingRequiredFiles -join ', '), changedFiles=$($changedFiles -join ', ')"
+            missingRequiredFiles = @($missingRequiredFiles)
+        }
+    }
+
+    return [PSCustomObject][ordered]@{
+        passed = $true
+        reason = "ok"
+        message = ""
+    }
+}
+
+function Test-IsAlreadyCompletedGoalState {
+    $stateRelativePath = ".ai-dev/state.json"
+    $statePath = Join-Path (Get-Location).Path $stateRelativePath
+
+    if (-not (Test-Path -LiteralPath $statePath -PathType Leaf)) {
+        return $false
+    }
+
+    $state = Read-JsonFile $statePath $stateRelativePath
+
+    return (
+        [string]$state.goalStatus -eq "completed" -and
+        -not (Test-HasValue $state.currentTaskId) -and
+        [string]$state.lastCommand -eq "complete-task" -and
+        [string]$state.lastCommandStatus -eq "passed" -and
+        (Test-HasValue $state.lastCommitHash)
+    )
+}
+
 if ($MaxSteps -lt 1) {
     $result = New-CycleResult @() "max_steps_must_be_at_least_1" $false 1
     Write-CycleResult $result
@@ -168,7 +509,92 @@ for ($index = 1; $index -le $MaxSteps; $index++) {
     }
     $steps += [PSCustomObject]$stepResult
 
+    try {
+        if (Test-IsNonImplementationReviseAction $action) {
+            Save-CycleFailureState "non_implementation_revise" "non_implementation_revise" ([string]$autoStep.message)
+            $result = New-CycleResult $steps "non_implementation_revise" $false 1
+            Write-CycleResult $result
+            exit 1
+        }
+
+        $reviewRequiredChangesGate = $null
+
+        if ($action -eq "make_revise_prompt") {
+            $reviewRequiredChangesGate = Get-ReviewRequiredChangesGate -OnlyWhenCurrentTaskIsImplementation
+        } elseif (@("commit", "complete_task", "complete-task") -contains $action) {
+            $reviewRequiredChangesGate = Get-ReviewRequiredChangesGate
+        }
+
+        if ($null -ne $reviewRequiredChangesGate -and -not $reviewRequiredChangesGate.passed) {
+            $step = [ordered]@{
+                step = $index
+                action = "review_required_changes_gate"
+                executed = $false
+                exitCode = 1
+                message = $reviewRequiredChangesGate.message
+                recommendedCommands = @()
+            }
+            $steps += [PSCustomObject]$step
+            Save-CycleFailureState "review_required_changes_gate" ([string]$reviewRequiredChangesGate.reason) ([string]$reviewRequiredChangesGate.message) @($reviewRequiredChangesGate.missingRequiredFiles)
+            $result = New-CycleResult $steps $reviewRequiredChangesGate.reason $false 1
+            Write-CycleResult $result
+            exit 1
+        }
+    } catch {
+        $step = [ordered]@{
+            step = $index
+            action = "revise_gate_failed"
+            executed = $false
+            exitCode = 1
+            message = $_.Exception.Message
+        }
+        $steps += [PSCustomObject]$step
+        Save-CycleFailureState "review_required_changes_gate" "revise_gate_failed" $_.Exception.Message
+        $result = New-CycleResult $steps "revise_gate_failed" $false 1
+        Write-CycleResult $result
+        exit 1
+    }
+
     if ($terminalActions -contains $action) {
+        try {
+            $shouldRunTerminalReviewRequiredChangesGate = -not (
+                $action -eq "goal_completed" -and (Test-IsAlreadyCompletedGoalState)
+            )
+
+            if ($shouldRunTerminalReviewRequiredChangesGate) {
+                $terminalReviewRequiredChangesGate = Get-ReviewRequiredChangesGate
+
+                if (-not $terminalReviewRequiredChangesGate.passed) {
+                    $step = [ordered]@{
+                        step = $index
+                        action = "terminal_review_required_changes_gate"
+                        executed = $false
+                        exitCode = 1
+                        message = $terminalReviewRequiredChangesGate.message
+                        recommendedCommands = @()
+                    }
+                    $steps += [PSCustomObject]$step
+                    Save-CycleFailureState "terminal_review_required_changes_gate" ([string]$terminalReviewRequiredChangesGate.reason) ([string]$terminalReviewRequiredChangesGate.message) @($terminalReviewRequiredChangesGate.missingRequiredFiles)
+                    $result = New-CycleResult $steps $terminalReviewRequiredChangesGate.reason $false 1
+                    Write-CycleResult $result
+                    exit 1
+                }
+            }
+        } catch {
+            $step = [ordered]@{
+                step = $index
+                action = "terminal_review_required_changes_gate_failed"
+                executed = $false
+                exitCode = 1
+                message = $_.Exception.Message
+            }
+            $steps += [PSCustomObject]$step
+            Save-CycleFailureState "terminal_review_required_changes_gate" "terminal_review_required_changes_gate_failed" $_.Exception.Message
+            $result = New-CycleResult $steps "terminal_review_required_changes_gate_failed" $false 1
+            Write-CycleResult $result
+            exit 1
+        }
+
         $completed = $action -eq "goal_completed"
         $result = New-CycleResult $steps $action $completed 0
         Write-CycleResult $result
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```