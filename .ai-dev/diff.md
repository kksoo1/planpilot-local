# AI Dev Diff

## Generated At

2026-07-31 17:24:52

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

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-auto-cycle-full.ps1 | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 350b1b2..844d2d6 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -690,6 +690,27 @@ function Get-ReviewImplementationGate {
     }
 }
 
+function Get-CheckCommandSpec {
+    param(
+        [object]$CurrentTask
+    )
+
+    $taskType = if ($null -ne $CurrentTask -and (Test-HasValue $CurrentTask.type)) { [string]$CurrentTask.type } else { "" }
+    $useBuildOnly = $taskType -in @("analysis", "documentation")
+    $arguments = @()
+    $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1"
+
+    if ($useBuildOnly) {
+        $arguments += "-BuildOnly"
+        $command = "$command -BuildOnly"
+    }
+
+    return [PSCustomObject][ordered]@{
+        command = $command
+        arguments = $arguments
+    }
+}
+
 function Get-ChangedAiDevOperationalFiles {
     $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
     $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
@@ -1087,7 +1108,8 @@ while ($script:completedTaskCount -lt $MaxTasks) {
         Invoke-CycleCommand $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty" $scriptPaths.runCodex $runCodexArguments
         $stepNumber++
 
-        Invoke-CycleCommand $stepNumber "check" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly" $scriptPaths.check @("-BuildOnly")
+        $checkSpec = Get-CheckCommandSpec $script:currentTask
+        Invoke-CycleCommand $stepNumber "check" $checkSpec.command $scriptPaths.check $checkSpec.arguments
         $stepNumber++
 
         Invoke-CycleCommand $stepNumber "save-diff" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
@@ -1125,7 +1147,8 @@ while ($script:completedTaskCount -lt $MaxTasks) {
         $stepNumber++
         $script:steps += New-StepResult $stepNumber "run-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $false $true 0 "DryRun: Codex 재수정 실행을 실행하지 않았습니다."
         $stepNumber++
-        $script:steps += New-StepResult $stepNumber "check-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly" $false $true 0 "DryRun: 재수정 검증을 실행하지 않았습니다."
+        $checkSpec = Get-CheckCommandSpec $script:currentTask
+        $script:steps += New-StepResult $stepNumber "check-revise" $checkSpec.command $false $true 0 "DryRun: 재수정 검증을 실행하지 않았습니다."
         $stepNumber++
         $script:steps += New-StepResult $stepNumber "save-diff-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $false $true 0 "DryRun: 재수정 diff 저장을 실행하지 않았습니다."
         $stepNumber++
@@ -1196,7 +1219,8 @@ while ($script:completedTaskCount -lt $MaxTasks) {
         Invoke-CycleCommand $stepNumber "run-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $scriptPaths.runCodex @("-AllowDirty", "-PromptPath", ".ai-dev/revise-prompt.md")
         $stepNumber++
 
-        Invoke-CycleCommand $stepNumber "check-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly" $scriptPaths.check @("-BuildOnly")
+        $checkSpec = Get-CheckCommandSpec $script:currentTask
+        Invoke-CycleCommand $stepNumber "check-revise" $checkSpec.command $scriptPaths.check $checkSpec.arguments
         $stepNumber++
 
         Invoke-CycleCommand $stepNumber "save-diff-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```

## Untracked File Content

내용을 포함할 추적되지 않은 텍스트 파일이 없습니다.