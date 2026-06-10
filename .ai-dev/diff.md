# AI Dev Diff

## Generated At

2026-06-10 23:31:39

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
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-auto-cycle-full.ps1
 M scripts/ai-dev-complete-task.ps1
```

## App Change Files

- scripts/ai-dev-auto-cycle-full.ps1
- scripts/ai-dev-complete-task.ps1

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
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-auto-cycle-full.ps1 | 61 ++++++++++++++++++++++++++++++++++----
 scripts/ai-dev-complete-task.ps1   | 57 +++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+), 5 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index ceb53aa..a1eb93a 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -19,6 +19,7 @@ $reviewResponseRelativePath = ".ai-dev/review-response.json"
 $queuePath = Join-Path $repoRoot $queueRelativePath
 $statePath = Join-Path $repoRoot $stateRelativePath
 $reviewResponsePath = Join-Path $repoRoot $reviewResponseRelativePath
+$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
 
 function Test-HasValue {
     param(
@@ -49,6 +50,30 @@ function Read-JsonFile {
     }
 }
 
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
+    $json = $Value | ConvertTo-Json -Depth 20
+    [System.IO.File]::WriteAllText($Path, $json, $utf8WithBom)
+}
+
 function Get-CurrentTask {
     param(
         [object]$Queue,
@@ -258,12 +283,31 @@ function Get-CommitArguments {
 }
 
 function Get-CommitGate {
+    param(
+        [string]$PreviousHeadCommitHash
+    )
+
     $state = Read-JsonFile $statePath $stateRelativePath
+    $lastCommitHash = if (Test-HasValue $state.lastCommitHash) { [string]$state.lastCommitHash } else { $null }
+    $headCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-parse HEAD"
+    $commitHashChanged = (Test-HasValue $headCommitHash) -and $headCommitHash -ne $PreviousHeadCommitHash
+    $commitHashMatchesHead = (Test-HasValue $lastCommitHash) -and $lastCommitHash -eq $headCommitHash
+
+    if ($state.lastCommand -eq "commit" -and $state.lastCommandStatus -eq "passed" -and $commitHashChanged -and -not $commitHashMatchesHead) {
+        Set-ObjectProperty $state "lastCommitHash" $headCommitHash
+        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
+        Write-JsonFile $statePath $state
+
+        $lastCommitHash = $headCommitHash
+        $commitHashMatchesHead = $true
+    }
 
     return [PSCustomObject][ordered]@{
         lastCommand = [string]$state.lastCommand
         lastCommandStatus = [string]$state.lastCommandStatus
-        lastCommitHash = [string]$state.lastCommitHash
+        lastCommitHash = [string]$lastCommitHash
+        commitHashChanged = $commitHashChanged
+        commitHashMatchesHead = $commitHashMatchesHead
     }
 }
 
@@ -437,7 +481,7 @@ while ($completedTaskCount -lt $MaxTasks) {
         $stepNumber++
         $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
         $stepNumber++
-        $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료`"" $false $true 0 "DryRun: task 완료 처리를 실행하지 않았습니다."
+        $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료`" -CommitHash <commit-hash>" $false $true 0 "DryRun: task 완료 처리를 실행하지 않았습니다."
         Stop-Cycle $script:steps "dry_run" $false 0
     }
 
@@ -499,17 +543,24 @@ while ($completedTaskCount -lt $MaxTasks) {
         $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
     }
 
+    try {
+        $preCommitHeadCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-parse HEAD"
+    } catch {
+        $script:steps += New-StepResult $stepNumber "commit" "git rev-parse HEAD" $false $false 1 $_.Exception.Message
+        Stop-Cycle $script:steps "pre_commit_head_failed" $false 1
+    }
+
     Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
     $stepNumber++
 
     try {
-        $commitGate = Get-CommitGate
+        $commitGate = Get-CommitGate $preCommitHeadCommitHash
     } catch {
         $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHash 확인" $false $false 1 $_.Exception.Message
         Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
     }
 
-    if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -not (Test-HasValue $commitGate.lastCommitHash)) {
+    if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -not $commitGate.commitHashChanged -or -not $commitGate.commitHashMatchesHead) {
         $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastCommand), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCommitHash)"
         $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHash 확인" $false $true 1 $message
         Stop-Cycle $script:steps "commit_not_confirmed" $false 1
@@ -519,7 +570,7 @@ while ($completedTaskCount -lt $MaxTasks) {
     $stepNumber++
 
     $resultSummary = "자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료"
-    Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"$resultSummary`"" $scriptPaths.completeTask @("-ResultSummary", $resultSummary)
+    Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"$resultSummary`" -CommitHash $($commitGate.lastCommitHash)" $scriptPaths.completeTask @("-ResultSummary", $resultSummary, "-CommitHash", $commitGate.lastCommitHash)
     $stepNumber++
     $completedTaskCount++
 }
diff --git a/scripts/ai-dev-complete-task.ps1 b/scripts/ai-dev-complete-task.ps1
index c5da716..50eb511 100644
--- a/scripts/ai-dev-complete-task.ps1
+++ b/scripts/ai-dev-complete-task.ps1
@@ -1,6 +1,7 @@
 ﻿param(
     [string]$TaskId,
     [string]$ResultSummary,
+    [string]$CommitHash,
     [switch]$NoNext
 )
 
@@ -78,6 +79,56 @@ function Write-JsonFile {
     [System.IO.File]::WriteAllText($Path, $json, $utf8WithBom)
 }
 
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
+function Resolve-ValidatedCommitHash {
+    param(
+        [string]$Hash
+    )
+
+    $commitRevision = "$Hash^{commit}"
+
+    try {
+        $resolvedCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "--verify", $commitRevision) -DisplayName "git rev-parse --verify $commitRevision"
+    } catch {
+        Stop-WithError "CommitHash가 실제 commit으로 확인되지 않았습니다: $Hash`n$($_.Exception.Message)"
+    }
+
+    try {
+        $headCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-parse HEAD"
+    } catch {
+        Stop-WithError "현재 git HEAD를 확인하지 못했습니다: $($_.Exception.Message)"
+    }
+
+    if (-not (Test-HasValue $resolvedCommitHash)) {
+        Stop-WithError "CommitHash가 빈 값으로 resolve되었습니다: $Hash"
+    }
+
+    if (-not (Test-HasValue $headCommitHash)) {
+        Stop-WithError "현재 git HEAD가 빈 값으로 확인되었습니다."
+    }
+
+    if ($resolvedCommitHash -ne $headCommitHash) {
+        Stop-WithError "CommitHash가 현재 git HEAD와 일치하지 않습니다. resolved=$resolvedCommitHash, HEAD=$headCommitHash"
+    }
+
+    return $resolvedCommitHash
+}
+
 foreach ($requiredPath in @($queueRelativePath, $stateRelativePath, $loopLogRelativePath)) {
     $fullPath = Join-Path $projectRoot $requiredPath
 
@@ -161,6 +212,12 @@ if ($NoNext) {
 }
 
 Set-ObjectProperty $queue "updatedAt" $now
+
+if (Test-HasValue $CommitHash) {
+    $validatedCommitHash = Resolve-ValidatedCommitHash $CommitHash
+    Set-ObjectProperty $state "lastCommitHash" $validatedCommitHash
+}
+
 Set-ObjectProperty $state "updatedAt" $now
 Set-ObjectProperty $state "lastCommand" "complete-task"
 Set-ObjectProperty $state "lastCommandStatus" "passed"
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```