# AI Dev Diff

## Generated At

2026-07-31 17:47:26

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-test.ps1
```

## App Change Files

- scripts/ai-dev-test.ps1

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-test.ps1 | 282 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 266 insertions(+), 16 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-test.ps1 b/scripts/ai-dev-test.ps1
index 018cddc..5933e25 100644
--- a/scripts/ai-dev-test.ps1
+++ b/scripts/ai-dev-test.ps1
@@ -139,24 +139,226 @@ function Remove-IsolatedScenarioRoot {
     }
 }
 
-function Test-MaxStepsForwarding {
+function Test-MaxStepsForwardingBehavior {
     param(
         [Parameter(Mandatory = $true)]
-        [string]$Content
+        [string]$Name,
+
+        [Parameter(Mandatory = $true)]
+        [int]$ExpectedMaxSteps
     )
 
-    $forwardingPatterns = @(
-        '-MaxSteps\s+(?:\(\s*)?(?:\[string\]\s*)?\$MaxSteps',
-        '["'']-MaxSteps["'']\s*,\s*(?:\(\s*)?(?:\[string\]\s*)?\$MaxSteps'
+    $expectedMaxTasks = 3
+
+    $tmpRoot = Join-Path $env:TEMP (
+        "planpilot-test-" +
+        $Name +
+        "-" +
+        (Get-Date -Format "yyyyMMddHHmmssfff")
     )
 
-    foreach ($pattern in $forwardingPatterns) {
-        if ([regex]::IsMatch($Content, $pattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)) {
-            return $true
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
+                Join-Path $repoRoot "scripts\ai-dev-auto-goal.ps1"
+            ) `
+            -Destination (
+                Join-Path $tmpRoot "scripts\ai-dev-auto-goal.ps1"
+            ) `
+            -Force
+
+        $fakeBinPath = Join-Path $env:TEMP (
+            "planpilot-fake-bin-" +
+            $Name +
+            "-" +
+            (Get-Date -Format "yyyyMMddHHmmssfff")
+        )
+        [System.IO.Directory]::CreateDirectory($fakeBinPath) | Out-Null
+
+        $fakeCodexPath = Join-Path $fakeBinPath "codex.cmd"
+        $fakeAutoCyclePath = Join-Path $tmpRoot "scripts\ai-dev-auto-cycle-full.ps1"
+        $forwardedArgsPath = Join-Path $env:TEMP (
+            "planpilot-maxsteps-forwarding-args-" +
+            $Name +
+            "-" +
+            (Get-Date -Format "yyyyMMddHHmmssfff") +
+            ".txt"
+        )
+        $childStatusPath = Join-Path $env:TEMP (
+            "planpilot-maxsteps-forwarding-child-status-" +
+            $Name +
+            "-" +
+            (Get-Date -Format "yyyyMMddHHmmssfff") +
+            ".txt"
+        )
+
+        $fakeCodexContent = @'
+@echo off
+echo {"goalMarkdown":"# Goal","queue":{"goalTitle":"Forwarding test","goalSource":".ai-dev/goal.md","createdAt":"2026-01-01T00:00:00Z","updatedAt":"2026-01-01T00:00:00Z","currentTaskId":"T001","tasks":[{"id":"T001","title":"Forwarding test","description":"Verify MaxSteps forwarding.","type":"implementation","status":"in_progress","priority":"P0","dependsOn":[],"filesLikelyToChange":["scripts/ai-dev-test.ps1"],"verification":["Verify MaxSteps forwarding."],"commitMessage":null}]},"state":{"goalStatus":"in_progress","currentTaskId":"T001","currentLoop":0,"maxLoopsPerTask":2,"repeatedFailureCount":0,"lastCommand":null,"lastCommandStatus":"not_started","lastErrorSummary":null,"lastReviewDecision":"not_started","lastReviewSeverity":null,"lastCommitHash":null,"startedAt":"2026-01-01T00:00:00Z","updatedAt":"2026-01-01T00:00:00Z","stopReason":null}}
+'@
+
+        [System.IO.File]::WriteAllText(
+            $fakeCodexPath,
+            $fakeCodexContent,
+            [System.Text.Encoding]::ASCII
+        )
+
+        $escapedForwardedArgsPath = $forwardedArgsPath.Replace("'", "''")
+        $escapedChildStatusPath = $childStatusPath.Replace("'", "''")
+        $fakeAutoCycleContent = @"
+param(
+    [Parameter(ValueFromRemainingArguments = `$true)]
+    [string[]]`$RemainingArguments
+)
+
+`$argsToRecord = @(`$RemainingArguments)
+
+if (`$argsToRecord.Count -eq 0) {
+    `$argsToRecord = @(`$args)
+}
+
+[System.IO.File]::WriteAllLines('$escapedForwardedArgsPath', [string[]]`$argsToRecord)
+[System.IO.File]::WriteAllText('$escapedChildStatusPath', 'exit 0', [System.Text.Encoding]::ASCII)
+
+`$statePath = Join-Path (Get-Location) '.ai-dev\state.json'
+`$state = Get-Content -LiteralPath `$statePath -Raw | ConvertFrom-Json
+`$state.goalStatus = 'completed'
+`$stateJson = `$state | ConvertTo-Json -Depth 30
+`$utf8WithBom = New-Object System.Text.UTF8Encoding(`$true)
+[System.IO.File]::WriteAllText(`$statePath, `$stateJson, `$utf8WithBom)
+
+exit 0
+"@
+
+        [System.IO.File]::WriteAllText(
+            $fakeAutoCyclePath,
+            $fakeAutoCycleContent,
+            (New-Object System.Text.UTF8Encoding($true))
+        )
+
+        $previousPath = $env:PATH
+        $env:PATH = $fakeBinPath + [System.IO.Path]::PathSeparator + $previousPath
+
+        Push-Location $tmpRoot
+
+        try {
+            $output = & powershell `
+                -ExecutionPolicy Bypass `
+                -File ".\scripts\ai-dev-auto-goal.ps1" `
+                -GoalTitle "MaxSteps forwarding test" `
+                -GoalDescription "Verify custom MaxSteps reaches the child full cycle script." `
+                -MaxTasks $expectedMaxTasks `
+                -MaxSteps $ExpectedMaxSteps `
+                -AllowCodex `
+                -AllowReviewCodex `
+                -AllowCommit `
+                -AllowRun `
+                -AllowDirty 2>&1
+            $scenarioExitCode = $LASTEXITCODE
+            $outputText = $output | Out-String
         }
+        finally {
+            Pop-Location
+            $env:PATH = $previousPath
+        }
+
+        $forwardedArgs = @()
+
+        if ([System.IO.File]::Exists($forwardedArgsPath)) {
+            $forwardedArgs = @(Get-Content -LiteralPath $forwardedArgsPath)
+        }
+
+        $maxStepsIndex = [array]::IndexOf([object[]]$forwardedArgs, "-MaxSteps")
+        $actualMaxSteps = ""
+
+        if ($maxStepsIndex -ge 0 -and ($maxStepsIndex + 1) -lt $forwardedArgs.Count) {
+            $actualMaxSteps = [string]$forwardedArgs[$maxStepsIndex + 1]
+        }
+
+        $maxStepsMatched = ($actualMaxSteps -eq ([string]$ExpectedMaxSteps))
+        $maxTasksIndex = [array]::IndexOf([object[]]$forwardedArgs, "-MaxTasks")
+        $actualMaxTasks = ""
+
+        if ($maxTasksIndex -ge 0 -and ($maxTasksIndex + 1) -lt $forwardedArgs.Count) {
+            $actualMaxTasks = [string]$forwardedArgs[$maxTasksIndex + 1]
+        }
+
+        $requiredSwitches = @(
+            "-AllowCodex",
+            "-AllowReviewCodex",
+            "-AllowCommit",
+            "-AllowDirty"
+        )
+        $missingSwitches = @(
+            $requiredSwitches |
+                Where-Object { $forwardedArgs -notcontains $_ }
+        )
+
+        Write-TestResult `
+            -Name "$Name forwards MaxSteps $ExpectedMaxSteps to child script" `
+            -Passed $maxStepsMatched `
+            -Detail (
+                "Expected=$ExpectedMaxSteps Actual=$actualMaxSteps ExitCode=$scenarioExitCode Args=" +
+                ($forwardedArgs -join " ")
+            )
+
+        Write-TestResult `
+            -Name "$Name forwards MaxTasks and allow switches" `
+            -Passed (
+                $actualMaxTasks -eq ([string]$expectedMaxTasks) -and
+                $missingSwitches.Count -eq 0
+            ) `
+            -Detail (
+                "ExpectedMaxTasks=$expectedMaxTasks ActualMaxTasks=$actualMaxTasks MissingSwitches=" +
+                ($missingSwitches -join ", ")
+            )
+
+        Write-TestResult `
+            -Name "$Name fake child exited successfully" `
+            -Passed (
+                [System.IO.File]::Exists($childStatusPath) -and
+                ((Get-Content -LiteralPath $childStatusPath -Raw).Trim() -eq "exit 0")
+            ) `
+            -Detail "AutoGoalExitCode=$scenarioExitCode"
+
+        Write-TestResult `
+            -Name "$Name child script was invoked" `
+            -Passed ([System.IO.File]::Exists($forwardedArgsPath)) `
+            -Detail (
+                "ExitCode=$scenarioExitCode OutputPreview=" +
+                (($outputText.Replace("`r", " ").Replace("`n", " ")).Trim())
+            )
+    }
+    catch {
+        Write-TestResult `
+            -Name "$Name execution" `
+            -Passed $false `
+            -Detail $_.Exception.Message
     }
+    finally {
+        Remove-IsolatedScenarioRoot -ScenarioRoot $scenarioRoot
+
+        if ([System.IO.Directory]::Exists($fakeBinPath)) {
+            [System.IO.Directory]::Delete($fakeBinPath, $true)
+        }
 
-    return $false
+        foreach ($tempFile in @($forwardedArgsPath, $childStatusPath)) {
+            if ([System.IO.File]::Exists($tempFile)) {
+                [System.IO.File]::Delete($tempFile)
+            }
+        }
+    }
 }
 
 function Invoke-IsolatedScenario {
@@ -170,6 +372,7 @@ function Invoke-IsolatedScenario {
         [Parameter(Mandatory = $true)]
         [ValidateSet(
             "none",
+            "all_goal_candidates_excluded",
             "dirty_worktree",
             "baseline_output_conflict"
         )]
@@ -234,6 +437,56 @@ function Invoke-IsolatedScenario {
                 -Value $marker
         }
 
+        if ($SetupType -eq "all_goal_candidates_excluded") {
+            $queuePath = Join-Path $tmpRoot ".ai-dev\queue.json"
+            $statePath = Join-Path $tmpRoot ".ai-dev\state.json"
+            $backlogPath = Join-Path $tmpRoot ".ai-dev\backlog.md"
+            $fixtureTitle = "Only backlog task"
+            $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
+
+            $queue = [PSCustomObject][ordered]@{
+                goalTitle = $fixtureTitle
+                goalSource = ".ai-dev/goal.md"
+                currentTaskId = $null
+                tasks = @(
+                    [PSCustomObject][ordered]@{
+                        id = "T001"
+                        title = $fixtureTitle
+                        status = "done"
+                    }
+                )
+            }
+
+            $state = [PSCustomObject][ordered]@{
+                goalStatus = "completed"
+                currentTaskId = $null
+            }
+
+            $backlog = @"
+# Test Backlog
+
+## P0
+
+- $fixtureTitle
+"@
+
+            [System.IO.File]::WriteAllText(
+                $queuePath,
+                ($queue | ConvertTo-Json -Depth 30),
+                $utf8WithBom
+            )
+            [System.IO.File]::WriteAllText(
+                $statePath,
+                ($state | ConvertTo-Json -Depth 30),
+                $utf8WithBom
+            )
+            [System.IO.File]::WriteAllText(
+                $backlogPath,
+                $backlog,
+                $utf8WithBom
+            )
+        }
+
         if ($SetupType -eq "baseline_output_conflict") {
             $markerPath = Join-Path $tmpRoot ".ai-dev\codex-result.md"
 
@@ -350,17 +603,14 @@ Write-TestResult `
     -Passed $defaultMaxStepsValid `
     -Detail "Detected=$defaultMaxStepsValue"
 
-$maxStepsForwarded = Test-MaxStepsForwarding -Content $autoGoalContent
-
-Write-TestResult `
-    -Name "auto-goal forwards user MaxSteps" `
-    -Passed $maxStepsForwarded `
-    -Detail "Accepted forms: direct argument, array argument, or splatted helper arguments"
+Test-MaxStepsForwardingBehavior `
+    -Name "maxsteps-forwarding" `
+    -ExpectedMaxSteps 57
 
 Invoke-IsolatedScenario `
     -Name "all-goal-candidates-excluded" `
     -ExpectedReason "all_goal_candidates_excluded" `
-    -SetupType "none" `
+    -SetupType "all_goal_candidates_excluded" `
     -CommandArguments @(
         "-ExecutionPolicy", "Bypass",
         "-File", ".\scripts\ai-dev-autopilot.ps1",
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