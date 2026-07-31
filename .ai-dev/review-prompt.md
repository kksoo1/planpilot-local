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

auto-cycle 전체 테스트 실행과 MaxSteps 전달 검증을 보강한다.

## 배경

현재 `scripts/ai-dev-auto-cycle-full.ps1`은 implementation 및 verification task의 check와 check-revise 단계에서 `ai-dev-check.ps1`을 항상 `-BuildOnly`로 실행해 `npm test` 결과가 skipped로 덮어써질 수 있다. 또한 `scripts/ai-dev-test.ps1`의 MaxSteps 사용자 지정 검증은 정규식 확인에 머물러 실제 하위 호출 인수 전달을 충분히 검증하지 못한다.

## 성공 기준

- implementation 및 verification task의 check/check-revise 단계에서 package.json에 test script가 있으면 build, test, lint 전체 검증을 실행한다.
- documentation 또는 analysis task에서 필요한 경우에만 BuildOnly 흐름을 사용한다.
- MaxSteps 사용자 지정 검증은 격리된 임시 작업 공간에서 fake `ai-dev-auto-cycle-full.ps1`을 사용해 `ai-dev-auto-goal.ps1`이 지정된 MaxSteps 값을 실제 하위 호출 인수로 전달했는지 동작 기반으로 확인한다.
- 예시로 MaxSteps 57 지정 시 하위 스크립트가 받은 인수에 57이 기록되는지 검증한다.
- 기존 17개 expected_non_work 테스트와 baseline 보존 테스트를 유지한다.
- 전체 `npm test`가 Failed=0으로 종료되어야 한다.

## 제약사항

- 변경 범위는 관련 PowerShell 스크립트와 테스트에 한정한다.
- 기존 테스트 의도를 유지하고 필요한 검증만 보강한다.
- 로컬 저장소 구조와 기존 AI Dev Loop 상태 파일 형식을 존중한다.
- 큰 구조 변경은 피하고 작은 수정으로 해결한다.

## 범위 제외

- 신규 기능 추가는 제외한다.
- UI 변경은 제외한다.
- 데이터 저장 구조 변경은 제외한다.
- 배포 관련 변경은 제외한다.

## 수동 검증

- 허용된 경우 `npm test`를 실행해 Failed=0인지 확인한다.
- MaxSteps 57 전달 검증 로그 또는 결과가 실제 하위 호출 인수 기반인지 확인한다.

## Current Task

- Task ID: T002
- Title: MaxSteps 전달 동작 검증 보강
- Description: `scripts/ai-dev-test.ps1`에서 격리된 임시 작업 공간과 fake `ai-dev-auto-cycle-full.ps1`을 사용해 사용자 지정 MaxSteps 값이 실제 하위 호출 인수로 전달되는지 검증한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- T001
- Verification:
- MaxSteps 57 지정 시 fake 하위 스크립트가 받은 인수에 57이 기록되는지 확인한다.
- 기존 17개 expected_non_work 테스트와 baseline 보존 테스트가 계속 실행되는지 확인한다.
- 허용된 경우 전체 npm test가 Failed=0으로 종료되는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-31 17:47:13

- Overall result: passed
- Current task: T002
- Mode: standard
- Commands:
  - npm run build: passed
  - npm run test: passed
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

[32m✓ built in 296ms[39m
```
### npm run test

- Status: passed
- Exit code: 0

```text

> planpilot-local@0.0.0 test
> powershell -ExecutionPolicy Bypass -File scripts/ai-dev-test.ps1

AI Dev automation tests
Repository: D:\ai-apps\planpilot-local

[PASS] auto-goal MaxSteps default is at least 40
       Detected=40
[PASS] maxsteps-forwarding forwards MaxSteps 57 to child script
       Expected=57 Actual=57 ExitCode=1 Args=-MaxTasks 3 -MaxSteps 57 -AllowCodex -AllowReviewCodex -AllowCommit -AllowDirty -ProtectedBaselineDirtyPaths scripts/ai-dev-auto-cycle-full.ps1,scripts/ai-dev-auto-goal.ps1
[PASS] maxsteps-forwarding forwards MaxTasks and allow switches
       ExpectedMaxTasks=3 ActualMaxTasks=3 MissingSwitches=
[PASS] maxsteps-forwarding fake child exited successfully
       AutoGoalExitCode=1
[PASS] maxsteps-forwarding child script was invoked
       ExitCode=1 OutputPreview=Step 1: validate-input    Command: check GoalTitle/GoalDescription    Executed: False    Skipped: False    Exit code: 0    Message: Input validation completed: MaxSteps forwarding test  Step 2: dirty-worktree-gate    Command: git status --porcelain    Executed: True    Skipped: False    Exit code: 0    Message: AllowDirty is set. Baseline dirty count: 2  Step 3: plan-goal    Command: codex exec <auto-goal planning prompt>    Executed: True    Skipped: False    Exit code: 0    Message: Codex goal planning completed. Result: .ai-dev/codex-result.md  Step 4: validate-generated-json    Command: goal/queue/state JSON validation    Executed: False    Skipped: False    Exit code: 0    Message: goalMarkdown, queue, and state JSON validation completed. currentTaskId: T001  Step 5: write-state-files    Command: .ai-dev/goal.md, .ai-dev/queue.json, .ai-dev/state.json    Executed: True    Skipped: False    Exit code: 0    Message: New goal, queue, and state files were written.  Step 6: make-prompt    Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1    Executed: True    Skipped: False    Exit code: 0    Message: 생성된 프롬프트 파일: .ai-dev/current-task-prompt.md  Current task id: T001  Current task title: Forwarding test  Step 7: auto-cycle-full    Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -MaxTasks 3 -MaxSteps 57 -AllowCodex -AllowReviewCodex -AllowCommit -AllowDirty -ProtectedBaselineDirtyPaths scripts/ai-dev-auto-cycle-full.ps1,scripts/ai-dev-auto-goal.ps1    Executed: True    Skipped: False    Exit code: 0    Message: completed  Step 8: verify-goal-status    Command: .ai-dev/state.json goalStatus 확인    Executed: False    Skipped: False    Exit code: 0    Message: auto-cycle-full 성공 후 goalStatus completed 확인.  Step 9: final-change-gate    Command: cleanup auto-goal temp artifacts, git status --short    Executed: True    Skipped: False    Exit code: 1    Message: Final clean verification failed: baseline dirty files remain, so auto-goal will not report completed.  Baseline dirty count: 2  Final dirty count: 7  Final .ai-dev meta commit created: skipped (baseline dirty remains).  Remaining baseline dirty paths:  scripts/ai-dev-auto-cycle-full.ps1  scripts/ai-dev-auto-goal.ps1   M .ai-dev/codex-result.md   M .ai-dev/current-task-prompt.md   M .ai-dev/goal.md   M .ai-dev/queue.json   M .ai-dev/state.json   M scripts/ai-dev-auto-cycle-full.ps1   M scripts/ai-dev-auto-goal.ps1  Plan preview:    Goal title: Forwarding test    Current task id: T001    Task T001: Forwarding test      Type: implementation      Status: in_progress      Priority: P0      Likely files: scripts/ai-dev-test.ps1      Verification: Verify MaxSteps forwarding.  Stopped reason: final_baseline_dirty_remains  Outcome category: actual_failure  Completed: False  Exit code: 1
[PASS] all-goal-candidates-excluded stopped reason
       Expected=all_goal_candidates_excluded ExitCode=1
[PASS] all-goal-candidates-excluded expected_non_work classification
[PASS] all-goal-candidates-excluded baseline marker preservation
[PASS] all-goal-candidates-excluded no new dirty paths
       NewDirtyPaths=
[PASS] all-goal-candidates-excluded no staged paths
       StagedPaths=
[PASS] dirty-worktree stopped reason
       Expected=dirty_worktree ExitCode=1
[PASS] dirty-worktree expected_non_work classification
[PASS] dirty-worktree baseline marker preservation
[PASS] dirty-worktree no new dirty paths
       NewDirtyPaths=
[PASS] dirty-worktree no staged paths
       StagedPaths=
[PASS] baseline-output-conflict stopped reason
       Expected=baseline_output_conflict ExitCode=1
[PASS] baseline-output-conflict expected_non_work classification
[PASS] baseline-output-conflict baseline marker preservation
[PASS] baseline-output-conflict no new dirty paths
       NewDirtyPaths=
[PASS] baseline-output-conflict no staged paths
       StagedPaths=

Test summary: Passed=20, Failed=0
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