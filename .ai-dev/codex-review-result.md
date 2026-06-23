# Codex Review Result

## Run

- Started at: 2026-06-23 15:31:55
- Ended at: 2026-06-23 15:33:18
- Exit code: 0
- Review prompt: .ai-dev/review-prompt.md
- Review response: .ai-dev/review-response.json
- Command: codex exec <short wrapper pointing to .ai-dev/review-prompt.md>

## Output

```text
node.exe : OpenAI Codex v0.133.0
위치 C:\Users\SECUI\AppData\Roaming\npm\codex.ps1:24 문자:5
+     & "node$exe"  "$basedir/node_modules/@openai/codex/bin/codex.js"  ...
+     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (OpenAI Codex v0.133.0:String) [], RemoteExce 
   ption
    + FullyQualifiedErrorId : NativeCommandError
 
--------
workdir: D:\ai-apps\planpilot-local
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: medium
reasoning summaries: none
session id: 019ef32d-a916-7e73-a9a8-b7b9f7710219
--------
user
Read and follow the full review prompt at this absolute file path: D:\ai-apps\planpilot-lo
cal\.ai-dev\review-prompt.md
codex
리뷰 지시문을 먼저 읽고, 그 안의 범위와 금지사항을 기준으로만 진행하겠습니다. 지금은 지정된 파일 하나만 확인합니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\review-prompt.md'" in D:\ai-apps\planpil
ot-local
 succeeded in 1315ms:
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
AI Dev Loop에서 구현 없는 revise 반복을 실패로 중단하도록 자동화 검증을 보강한다.

## 배경
현재 자동 실행 중 현재 task가 implementation이 아니거나 실제 구현 대상 파일 변경이 없는데도 review decision=revise가 반복될 
수 있다. 또한 review-response.json이 특정 구현 파일 수정을 요구했지만 diff에 해당 파일 변경이 없으면 이전 리뷰 결과를 다시 소비하거나 구
현 누락을 놓칠 위험이 있다.

## 성공 기준
- auto-goal 또는 auto-cycle 흐름에서 implementation task가 아닌 상태의 revise 반복을 성공 처리하지 않는다.
- review-response.json이 요구한 구현 파일 변경이 현재 diff에 없으면 stale review 또는 missing implementation으
로 판정한다.
- 위 판정 시 후속 완료 처리와 목표 완료 처리를 막고 명확한 실패 사유를 남긴다.
- 자동화 스크립트 변경만으로 동작을 보강한다.
- 빌드와 린트가 통과하고 리뷰가 pass 상태가 된다.

## 제약사항
- 이 목표는 implementation task 1개로만 처리한다.
- 앱 src 파일은 변경하지 않는다.
- 필요한 자동화 스크립트만 최소 범위로 수정한다.
- 기존 상태 파일 형식과 자동화 흐름을 최대한 유지한다.

## 범위 제외
- 앱 기능, 화면, 저장소 구조 변경은 제외한다.
- 분석 전용 task나 문서 전용 task를 별도로 만들지 않는다.
- 자동화 흐름 전체 재작성은 제외한다.

## 수동 검증
- review-response.json이 구현 파일 변경을 요구하지만 diff에 해당 파일이 없는 상황을 확인한다.
- implementation이 아닌 task에서 revise가 반복되는 상황을 확인한다.
- 두 상황 모두 성공이나 완료로 진행되지 않고 실패 사유가 기록되는지 확인한다.

## Current Task

- Task ID: T001
- Title: 구현 없는 revise 반복 실패 처리 보강
- Description: auto-goal 또는 auto-cycle 실행 중 implementation task가 아니거나 리뷰가 요구한 구현 파일 변경이 di
ff에 없을 때 stale review 또는 missing implementation으로 판단하고 완료 흐름을 차단한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- implementation task가 아닌 상태에서 revise 반복 시 실패 처리되는지 확인한다.
- review-response.json이 요구한 구현 파일 변경이 diff에 없을 때 완료 흐름이 차단되는지 확인한다.
- 허용된 검증 범위에서 빌드와 린트 결과를 확인한다.

## Test Result

# AI Dev Test Result

## 2026-06-23 15:26:31

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
dist/assets/index-CVTFf3OT.js   317.03 kB │ gzip: 100.03 kB

[32m✓ built in 233ms[39m
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

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도
로 확인합니다.

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
+    if ($null -eq $ReviewResponse -or -not ($ReviewResponse.PSObject.Properties.Name -con
tains "required_changes")) {
+        return @()
+    }
+
+    return @(
+        @($ReviewResponse.required_changes) |
+            Where-Object { $null -ne $_ -and ($_.PSObject.Properties.Name -contains "file
") -and (Test-HasValue $_.file) } |
+            ForEach-Object { ConvertTo-NormalizedChangedPath ([string]$_.file) } |
+            Where-Object { (Test-HasValue $_) -and $_ -ne "unknown" -and -not (Test-IsAiD
evOperationalPath $_) -and -not (Test-IsProtectedBaselineDirtyPath $_) } |
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
+        if ($changedFile.Equals($RequiredFile, [System.StringComparison]::OrdinalIgnoreCa
se)) {
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
+    $taskType = if ($null -ne $CurrentTask -and (Test-HasValue $CurrentTask.type)) { [str
ing]$CurrentTask.type } else { "" }
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
+            message = "현재 task type이 implementation이 아닌데 review decision=revise입니다. 구현 없는
 revise 반복을 성공 처리하지 않도록 중단합니다. taskType='$taskType', requiredFiles=$($requiredFiles -join 
', '), changedFiles=$($changedFiles -join ', ')"
+        }
+    }
+
+    if ($requiredFiles.Count -gt 0 -and $changedFiles.Count -eq 0) {
+        return [PSCustomObject][ordered]@{
+            passed = $false
+            reason = "missing_implementation"
+            message = "review-response.json이 구현 파일 변경을 요구했지만 현재 diff에 구현 변경 파일이 없습니다. req
uiredFiles=$($requiredFiles -join ', ')"
+        }
+    }
+
+    if ($missingRequiredFiles.Count -gt 0) {
+        return [PSCustomObject][ordered]@{
+            passed = $false
+            reason = "stale_review_required_file_missing"
+            message = "review-response.json이 요구한 구현 파일 변경이 현재 diff에 없습니다. stale review 또는
 missing implementation으로 보고 완료 흐름을 차단합니다. missingRequiredFiles=$($missingRequiredFiles -j
oin ', '), changedFiles=$($changedFiles -join ', ')"
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
     $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhite
Space($_) })
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
+            $resumeImplementationGate = Get-ReviewImplementationGate $currentTask $resume
ReviewGate
+
+            if (-not $resumeImplementationGate.passed) {
+                Save-CycleFailureState "resume-review-gate" $resumeImplementationGate.mes
sage $resumeReviewGate
+                $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/r
eview-response required_changes 및 현재 diff 확인" $false $true 1 $resumeImplementationGate.mes
sage
+                Stop-Cycle $script:steps $resumeImplementationGate.reason $false 1
+            }
+
             $resumeFromSavedReview = $true
             $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/revie
w-response 재확인" $false $false 0 "이미 저장된 리뷰 pass와 허용 가능한 next_step 상태를 확인했습니다. 구현/리뷰 재실행 없이
 commit/complete/meta-commit으로 계속 진행합니다."
             $stepNumber++
         } elseif ($resumeReviewGate.lastCommand -eq "save-review" -and $resumeReviewGate.
lastCommandStatus -eq "passed") {
+            $resumeImplementationGate = Get-ReviewImplementationGate $currentTask $resume
ReviewGate
             $message = "save-review 이후 계속 진행할 수 없습니다. review.decision=$($resumeReviewGate
.decision), state.lastReviewDecision=$($resumeReviewGate.stateDecision), next_step=$($resu
meReviewGate.nextStep)"
+
+            if (-not $resumeImplementationGate.passed) {
+                $message = $resumeImplementationGate.message
+                Save-CycleFailureState "resume-review-gate" $message $resumeReviewGate
+                $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/r
eview-response required_changes 및 현재 diff 확인" $false $true 1 $message
+                Stop-Cycle $script:steps $resumeImplementationGate.reason $false 1
+            }
+
+            Save-CycleFailureState "resume-review-gate" $message $resumeReviewGate
             $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/revie
w-response 재확인" $false $true 1 $message
             Stop-Cycle $script:steps "saved_review_not_ready_to_complete" $false 1
         }
@@ -817,8 +942,18 @@ while ($completedTaskCount -lt $MaxTasks) {
         Stop-Cycle $script:steps "review_save_not_passed" $false 1
     }
 
+    $implementationGate = Get-ReviewImplementationGate $currentTask $reviewGate
+
+    if (-not $implementationGate.passed) {
+        Save-CycleFailureState "review-gate" $implementationGate.message $reviewGate
+        $script:steps += New-StepResult $stepNumber "review-gate" "task type, $reviewResp
onseRelativePath required_changes, 현재 diff 확인" $false $true 1 $implementationGate.message
+        Stop-Cycle $script:steps $implementationGate.reason $false 1
+    }
+
     if ($reviewGate.decision -ne "pass") {
-        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativ
ePath decision 확인" $false $true 1 "리뷰 response decision이 pass가 아니므로 자동 커밋과 complete-task를 
실행하지 않습니다: $($reviewGate.decision)"
+        $message = "리뷰 response decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($
reviewGate.decision)"
+        Save-CycleFailureState "review-gate" $message $reviewGate
+        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativ
ePath decision 확인" $false $true 1 $message
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
+        $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-
Object -First 1
+
+        if ($null -ne $inProgressTask) {
+            $currentTaskId = [string]$inProgressTask.id
+        } else {
+            $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Obj
ect -First 1
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
+    return $normalizedRelativePath.StartsWith(".ai-dev/", [System.StringComparison]::Ordi
nalIgnoreCase)
+}
+
+function Get-ChangedNonAiDevFiles {
+    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
+    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhite
Space($_) })
+
+    return @(
+        $changeLines |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+            Where-Object { (Test-HasValue $_) -and -not (Test-IsAiDevOperationalPath $_) 
} |
+            Select-Object -Unique
+    )
+}
+
+function Get-RequiredReviewChangeFiles {
+    param(
+        [object]$ReviewResponse
+    )
+
+    if ($null -eq $ReviewResponse -or -not ($ReviewResponse.PSObject.Properties.Name -con
tains "required_changes")) {
+        return @()
+    }
+
+    return @(
+        @($ReviewResponse.required_changes) |
+            Where-Object { $null -ne $_ -and ($_.PSObject.Properties.Name -contains "file
") -and (Test-HasValue $_.file) } |
+            ForEach-Object { ConvertTo-NormalizedChangedPath ([string]$_.file) } |
+            Where-Object { (Test-HasValue $_) -and $_ -ne "unknown" -and -not (Test-IsAiD
evOperationalPath $_) } |
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
+        if ($changedFile.Equals($RequiredFile, [System.StringComparison]::OrdinalIgnoreCa
se)) {
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
+    $queue = Read-JsonFile (Join-Path (Get-Location).Path $queueRelativePath) $queueRelat
ivePath
+    $state = Read-JsonFile (Join-Path (Get-Location).Path $stateRelativePath) $stateRelat
ivePath
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
+        $queue = Read-JsonFile (Join-Path (Get-Location).Path $queueRelativePath) $queueR
elativePath
+        $state = Read-JsonFile (Join-Path (Get-Location).Path $stateRelativePath) $stateR
elativePath
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
+            message = "review-response.json이 구현 파일 변경을 요구했지만 현재 non-.ai-dev diff에 구현 변경 파
일이 없습니다. missingRequiredFiles=$($requiredFiles -join ', ')"
+            missingRequiredFiles = @($requiredFiles)
+        }
+    }
+
+    if ($missingRequiredFiles.Count -gt 0) {
+        return [PSCustomObject][ordered]@{
+            passed = $false
+            reason = "stale_review_required_file_missing"
+            message = "review-response.json이 요구한 구현 파일 변경이 현재 non-.ai-dev diff에 없습니다. mis
singRequiredFiles=$($missingRequiredFiles -join ', '), changedFiles=$($changedFiles -join 
', ')"
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
+            Save-CycleFailureState "non_implementation_revise" "non_implementation_revise
" ([string]$autoStep.message)
+            $result = New-CycleResult $steps "non_implementation_revise" $false 1
+            Write-CycleResult $result
+            exit 1
+        }
+
+        $reviewRequiredChangesGate = $null
+
+        if ($action -eq "make_revise_prompt") {
+            $reviewRequiredChangesGate = Get-ReviewRequiredChangesGate -OnlyWhenCurrentTa
skIsImplementation
+        } elseif (@("commit", "complete_task", "complete-task") -contains $action) {
+            $reviewRequiredChangesGate = Get-ReviewRequiredChangesGate
+        }
+
+        if ($null -ne $reviewRequiredChangesGate -and -not $reviewRequiredChangesGate.pas
sed) {
+            $step = [ordered]@{
+                step = $index
+                action = "review_required_changes_gate"
+                executed = $false
+                exitCode = 1
+                message = $reviewRequiredChangesGate.message
+                recommendedCommands = @()
+            }
+            $steps += [PSCustomObject]$step
+            Save-CycleFailureState "review_required_changes_gate" ([string]$reviewRequire
dChangesGate.reason) ([string]$reviewRequiredChangesGate.message) @($reviewRequiredChanges
Gate.missingRequiredFiles)
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
+        Save-CycleFailureState "review_required_changes_gate" "revise_gate_failed" $_.Exc
eption.Message
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
+                    Save-CycleFailureState "terminal_review_required_changes_gate" ([stri
ng]$terminalReviewRequiredChangesGate.reason) ([string]$terminalReviewRequiredChangesGate.
message) @($terminalReviewRequiredChangesGate.missingRequiredFiles)
+                    $result = New-CycleResult $steps $terminalReviewRequiredChangesGate.r
eason $false 1
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
+            Save-CycleFailureState "terminal_review_required_changes_gate" "terminal_revi
ew_required_changes_gate_failed" $_.Exception.Message
+            $result = New-CycleResult $steps "terminal_review_required_changes_gate_faile
d" $false 1
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

codex
리뷰 프롬프트에 따라 코드 리뷰 관점으로 보겠습니다. 제공된 diff만으로 판단하기 어려운 흐름과 함수 위치를 확인하기 위해 변경된 두 스크립트만 읽겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-cycle.ps1'" in D:\ai-apps\pl
anpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-cycle-full.ps1'" in D:\ai-ap
ps\planpilot-local
 succeeded in 1516ms:
param(
    [int]$MaxSteps = 5,
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowCheck,
    [switch]$AllowSaveDiff,
    [switch]$AllowReviewPrompt
)

. "$PSScriptRoot\ai-dev-env.ps1"

function Write-CycleResult {
    param(
        [object]$Result
    )

    if ($Json) {
        $Result | ConvertTo-Json -Depth 20
        return
    }

    foreach ($step in $Result.steps) {
        Write-Host "Step $($step.step):"
        Write-Host "  Action: $($step.action)"
        Write-Host "  Executed: $($step.executed)"
        Write-Host "  Message: $($step.message)"
        Write-Host "  Recommended commands:"

        $stepCommands = @($step.recommendedCommands) | Where-Object {
            -not [string]::IsNullOrWhiteSpace([string]$_)
        }

        if ($stepCommands.Count -eq 0) {
            Write-Host "    - 없음"
        } else {
            foreach ($command in $stepCommands) {
                Write-Host "    - $command"
            }
        }
    }

    Write-Host "Stopped reason: $($Result.stoppedReason)"
    Write-Host "Completed: $($Result.completed)"
    Write-Host "Exit code: $($Result.exitCode)"

    if ($Result.stoppedReason -eq "goal_completed") {
        Write-Host "Summary: 목표 완료로 종료되었습니다. 더 실행할 task가 없습니다."
        Write-Host "Next: 다음 목표를 시작하려면 .ai-dev/goal.md, .ai-dev/queue.json, .ai-dev/state.
json을 새 목표로 초기화하세요."
    }
}

function New-CycleResult {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    return [ordered]@{
        steps = @($Steps)
        stoppedReason = $StoppedReason
        completed = $Completed
        exitCode = $ExitCode
    }
}

function Test-HasValue {
    param([object]$Value)

    if ($null -eq $Value) {
        return $false
    }

    if ($Value -is [string]) {
        return -not [string]::IsNullOrWhiteSpace($Value)
    }

    return $true
}

function Read-JsonFile {
    param(
        [string]$Path,
        [string]$RelativePath
    )

    try {
        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | ConvertFrom-Json
    } catch {
        throw "$RelativePath JSON 파싱에 실패했습니다: $($_.Exception.Message)"
    }
}

function Set-ObjectProperty {
    param(
        [object]$InputObject,
        [string]$Name,
        [object]$Value
    )

    if ($InputObject.PSObject.Properties.Name -contains $Name) {
        $InputObject.$Name = $Value
    } else {
        $InputObject | Add-Member -NotePropertyName $Name -NotePropertyValue $Value
    }
}

function Write-JsonFile {
    param(
        [string]$Path,
        [object]$Value
    )

    $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
    $json = $Value | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($Path, $json, $utf8WithBom)
}

function Save-CycleFailureState {
    param(
        [string]$Command,
        [string]$StoppedReason,
        [string]$Message,
        [string[]]$MissingRequiredFiles = @()
    )

    if ($DryRun) {
        return
    }

    try {
        $stateRelativePath = ".ai-dev/state.json"
        $statePath = Join-Path (Get-Location).Path $stateRelativePath
        $state = Read-JsonFile $statePath $stateRelativePath
        $errorParts = @("stoppedReason=$StoppedReason")

        if ($MissingRequiredFiles.Count -gt 0) {
            $errorParts += "missingRequiredFiles=$($MissingRequiredFiles -join ', ')"
        }

        if (Test-HasValue $Message) {
            $errorParts += $Message
        }

        Set-ObjectProperty $state "lastCommand" $Command
        Set-ObjectProperty $state "lastCommandStatus" "failed"
        Set-ObjectProperty $state "lastErrorSummary" ($errorParts -join "; ")
        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
        Write-JsonFile $statePath $state
    } catch {
        Write-Warning "상태 파일에 실패 사유를 기록하지 못했습니다: $($_.Exception.Message)"
    }
}

function Invoke-GitCapture {
    param(
        [string[]]$Arguments,
        [string]$DisplayName
    )

    $output = & git @Arguments 2>&1 | Out-String
    $exitCode = $LASTEXITCODE

    if ($exitCode -ne 0) {
        throw "$DisplayName 실행에 실패했습니다. exit code: $exitCode`n$output"
    }

    return $output.TrimEnd()
}

function Get-CurrentTask {
    param(
        [object]$Queue,
        [object]$State
    )

    $tasks = @($Queue.tasks)
    $currentTaskId = $null

    if (Test-HasValue $State.currentTaskId) {
        $currentTaskId = [string]$State.currentTaskId
    } elseif (Test-HasValue $Queue.currentTaskId) {
        $currentTaskId = [string]$Queue.currentTaskId
    } else {
        $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-O
bject -First 1

        if ($null -ne $inProgressTask) {
            $currentTaskId = [string]$inProgressTask.id
        } else {
            $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Obje
ct -First 1

            if ($null -ne $pendingTask) {
                $currentTaskId = [string]$pendingTask.id
            }
        }
    }

    if (-not (Test-HasValue $currentTaskId)) {
        return $null
    }

    return $tasks | Where-Object { $_.id -eq $currentTaskId } | Select-Object -First 1
}

function Convert-ToChangedPath {
    param(
        [string]$ChangeLine
    )

    if ([string]::IsNullOrWhiteSpace($ChangeLine)) {
        return @()
    }

    $pathText = $ChangeLine

    if ($ChangeLine.Length -ge 4 -and $ChangeLine.Substring(2, 1) -eq " ") {
        $pathText = $ChangeLine.Substring(3)
    }

    if ($pathText.Contains(" -> ")) {
        return @($pathText -split " -> " | Where-Object { Test-HasValue $_ })
    }

    return @($pathText)
}

function ConvertTo-NormalizedChangedPath {
    param(
        [string]$RelativePath
    )

    if (-not (Test-HasValue $RelativePath)) {
        return $null
    }

    return $RelativePath.Trim().Trim('"').Replace('\', '/')
}

function Test-IsAiDevOperationalPath {
    param(
        [string]$RelativePath
    )

    $normalizedRelativePath = ConvertTo-NormalizedChangedPath $RelativePath
    return $normalizedRelativePath.StartsWith(".ai-dev/", [System.StringComparison]::Ordin
alIgnoreCase)
}

function Get-ChangedNonAiDevFiles {
    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteS
pace($_) })

    return @(
        $changeLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Where-Object { (Test-HasValue $_) -and -not (Test-IsAiDevOperationalPath $_) }
 |
            Select-Object -Unique
    )
}

function Get-RequiredReviewChangeFiles {
    param(
        [object]$ReviewResponse
    )

    if ($null -eq $ReviewResponse -or -not ($ReviewResponse.PSObject.Properties.Name -cont
ains "required_changes")) {
        return @()
    }

    return @(
        @($ReviewResponse.required_changes) |
            Where-Object { $null -ne $_ -and ($_.PSObject.Properties.Name -contains "file"
) -and (Test-HasValue $_.file) } |
            ForEach-Object { ConvertTo-NormalizedChangedPath ([string]$_.file) } |
            Where-Object { (Test-HasValue $_) -and $_ -ne "unknown" -and -not (Test-IsAiDe
vOperationalPath $_) } |
            Select-Object -Unique
    )
}

function Test-ReviewRequiredFileIsChanged {
    param(
        [string]$RequiredFile,
        [string[]]$ChangedFiles
    )

    foreach ($changedFile in @($ChangedFiles)) {
        if ($changedFile.Equals($RequiredFile, [System.StringComparison]::OrdinalIgnoreCas
e)) {
            return $true
        }
    }

    return $false
}

function Test-IsNonImplementationReviseAction {
    param([string]$Action)

    if ($Action -ne "make_revise_prompt") {
        return $false
    }

    $queueRelativePath = ".ai-dev/queue.json"
    $stateRelativePath = ".ai-dev/state.json"
    $queue = Read-JsonFile (Join-Path (Get-Location).Path $queueRelativePath) $queueRelati
vePath
    $state = Read-JsonFile (Join-Path (Get-Location).Path $stateRelativePath) $stateRelati
vePath
    $currentTask = Get-CurrentTask $queue $state

    if ($null -eq $currentTask) {
        return $false
    }

    return [string]$currentTask.type -ne "implementation"
}

function Get-ReviewRequiredChangesGate {
    param(
        [switch]$OnlyWhenCurrentTaskIsImplementation
    )

    $queueRelativePath = ".ai-dev/queue.json"
    $stateRelativePath = ".ai-dev/state.json"
    $reviewResponseRelativePath = ".ai-dev/review-response.json"

    if ($OnlyWhenCurrentTaskIsImplementation) {
        $queue = Read-JsonFile (Join-Path (Get-Location).Path $queueRelativePath) $queueRe
lativePath
        $state = Read-JsonFile (Join-Path (Get-Location).Path $stateRelativePath) $stateRe
lativePath
        $currentTask = Get-CurrentTask $queue $state

        if ($null -eq $currentTask -or [string]$currentTask.type -ne "implementation") {
            return [PSCustomObject][ordered]@{
                passed = $true
                reason = "ok"
                message = ""
            }
        }
    }

    $reviewResponsePath = Join-Path (Get-Location).Path $reviewResponseRelativePath

    if (-not (Test-Path -LiteralPath $reviewResponsePath -PathType Leaf)) {
        return [PSCustomObject][ordered]@{
            passed = $true
            reason = "ok"
            message = ""
        }
    }

    $reviewResponse = Read-JsonFile $reviewResponsePath $reviewResponseRelativePath
    $requiredFiles = @(Get-RequiredReviewChangeFiles $reviewResponse)

    if ($requiredFiles.Count -eq 0) {
        return [PSCustomObject][ordered]@{
            passed = $true
            reason = "ok"
            message = ""
        }
    }

    $changedFiles = @(Get-ChangedNonAiDevFiles)
    $missingRequiredFiles = @(
        $requiredFiles |
            Where-Object { -not (Test-ReviewRequiredFileIsChanged $_ $changedFiles) }
    )

    if ($requiredFiles.Count -gt 0 -and $changedFiles.Count -eq 0) {
        return [PSCustomObject][ordered]@{
            passed = $false
            reason = "missing_implementation"
            message = "review-response.json이 구현 파일 변경을 요구했지만 현재 non-.ai-dev diff에 구현 변경 파일
이 없습니다. missingRequiredFiles=$($requiredFiles -join ', ')"
            missingRequiredFiles = @($requiredFiles)
        }
    }

    if ($missingRequiredFiles.Count -gt 0) {
        return [PSCustomObject][ordered]@{
            passed = $false
            reason = "stale_review_required_file_missing"
            message = "review-response.json이 요구한 구현 파일 변경이 현재 non-.ai-dev diff에 없습니다. miss
ingRequiredFiles=$($missingRequiredFiles -join ', '), changedFiles=$($changedFiles -join '
, ')"
            missingRequiredFiles = @($missingRequiredFiles)
        }
    }

    return [PSCustomObject][ordered]@{
        passed = $true
        reason = "ok"
        message = ""
    }
}

function Test-IsAlreadyCompletedGoalState {
    $stateRelativePath = ".ai-dev/state.json"
    $statePath = Join-Path (Get-Location).Path $stateRelativePath

    if (-not (Test-Path -LiteralPath $statePath -PathType Leaf)) {
        return $false
    }

    $state = Read-JsonFile $statePath $stateRelativePath

    return (
        [string]$state.goalStatus -eq "completed" -and
        -not (Test-HasValue $state.currentTaskId) -and
        [string]$state.lastCommand -eq "complete-task" -and
        [string]$state.lastCommandStatus -eq "passed" -and
        (Test-HasValue $state.lastCommitHash)
    )
}

if ($MaxSteps -lt 1) {
    $result = New-CycleResult @() "max_steps_must_be_at_least_1" $false 1
    Write-CycleResult $result
    exit 1
}

$userInterventionActions = @(
    "run_codex_or_cline",
    "ask_gpt_review",
    "make_revise_prompt",
    "commit",
    "complete_task",
    "stop_for_user",
    "blocked",
    "inspect_status"
)
$terminalActions = @(
    "goal_completed",
    "no_task"
)
$steps = @()
$previousAction = $null
$autoStepPath = Join-Path $PSScriptRoot "ai-dev-auto-step.ps1"

if (-not (Test-Path -LiteralPath $autoStepPath -PathType Leaf)) {
    $result = New-CycleResult @() "auto_step_script_not_found" $false 1
    Write-CycleResult $result
    exit 1
}

for ($index = 1; $index -le $MaxSteps; $index++) {
    $arguments = @("-Json")

    if ($DryRun) {
        $arguments += "-DryRun"
    }

    if ($AllowCheck) {
        $arguments += "-AllowCheck"
    }

    if ($AllowSaveDiff) {
        $arguments += "-AllowSaveDiff"
    }

    if ($AllowReviewPrompt) {
        $arguments += "-AllowReviewPrompt"
    }

    $autoStepOutput = & powershell -ExecutionPolicy Bypass -File $autoStepPath @arguments 
2>&1 | Out-String
    $autoStepExitCode = $LASTEXITCODE

    if ($autoStepExitCode -ne 0) {
        $step = [ordered]@{
            step = $index
            action = "auto_step_failed"
            executed = $false
            exitCode = $autoStepExitCode
            message = $autoStepOutput.Trim()
        }
        $steps += [PSCustomObject]$step
        $result = New-CycleResult $steps "auto_step_failed" $false 1
        Write-CycleResult $result
        exit 1
    }

    try {
        $autoStep = $autoStepOutput | ConvertFrom-Json
    } catch {
        $step = [ordered]@{
            step = $index
            action = "auto_step_json_parse_failed"
            executed = $false
            exitCode = 1
            message = $_.Exception.Message
        }
        $steps += [PSCustomObject]$step
        $result = New-CycleResult $steps "auto_step_json_parse_failed" $false 1
        Write-CycleResult $result
        exit 1
    }

    $action = [string]$autoStep.action
    $recommendedCommands = @()

    if ($null -ne $autoStep.recommendedCommands) {
        foreach ($command in @($autoStep.recommendedCommands)) {
            if (-not [string]::IsNullOrWhiteSpace([string]$command)) {
                $recommendedCommands += [string]$command
            }
        }
    }

    $stepResult = [ordered]@{
        step = $index
        action = $action
        executed = [bool]$autoStep.executed
        exitCode = [int]$autoStep.exitCode
        message = [string]$autoStep.message
        recommendedCommands = @($recommendedCommands)
    }
    $steps += [PSCustomObject]$stepResult

    try {
        if (Test-IsNonImplementationReviseAction $action) {
            Save-CycleFailureState "non_implementation_revise" "non_implementation_revise"
 ([string]$autoStep.message)
            $result = New-CycleResult $steps "non_implementation_revise" $false 1
            Write-CycleResult $result
            exit 1
        }

        $reviewRequiredChangesGate = $null

        if ($action -eq "make_revise_prompt") {
            $reviewRequiredChangesGate = Get-ReviewRequiredChangesGate -OnlyWhenCurrentTas
kIsImplementation
        } elseif (@("commit", "complete_task", "complete-task") -contains $action) {
            $reviewRequiredChangesGate = Get-ReviewRequiredChangesGate
        }

        if ($null -ne $reviewRequiredChangesGate -and -not $reviewRequiredChangesGate.pass
ed) {
            $step = [ordered]@{
                step = $index
                action = "review_required_changes_gate"
                executed = $false
                exitCode = 1
                message = $reviewRequiredChangesGate.message
                recommendedCommands = @()
            }
            $steps += [PSCustomObject]$step
            Save-CycleFailureState "review_required_changes_gate" ([string]$reviewRequired
ChangesGate.reason) ([string]$reviewRequiredChangesGate.message) @($reviewRequiredChangesG
ate.missingRequiredFiles)
            $result = New-CycleResult $steps $reviewRequiredChangesGate.reason $false 1
            Write-CycleResult $result
            exit 1
        }
    } catch {
        $step = [ordered]@{
            step = $index
            action = "revise_gate_failed"
            executed = $false
            exitCode = 1
            message = $_.Exception.Message
        }
        $steps += [PSCustomObject]$step
        Save-CycleFailureState "review_required_changes_gate" "revise_gate_failed" $_.Exce
ption.Message
        $result = New-CycleResult $steps "revise_gate_failed" $false 1
        Write-CycleResult $result
        exit 1
    }

    if ($terminalActions -contains $action) {
        try {
            $shouldRunTerminalReviewRequiredChangesGate = -not (
                $action -eq "goal_completed" -and (Test-IsAlreadyCompletedGoalState)
            )

            if ($shouldRunTerminalReviewRequiredChangesGate) {
                $terminalReviewRequiredChangesGate = Get-ReviewRequiredChangesGate

                if (-not $terminalReviewRequiredChangesGate.passed) {
                    $step = [ordered]@{
                        step = $index
                        action = "terminal_review_required_changes_gate"
                        executed = $false
                        exitCode = 1
                        message = $terminalReviewRequiredChangesGate.message
                        recommendedCommands = @()
                    }
                    $steps += [PSCustomObject]$step
                    Save-CycleFailureState "terminal_review_required_changes_gate" ([strin
g]$terminalReviewRequiredChangesGate.reason) ([string]$terminalReviewRequiredChangesGate.m
essage) @($terminalReviewRequiredChangesGate.missingRequiredFiles)
                    $result = New-CycleResult $steps $terminalReviewRequiredChangesGate.re
ason $false 1
                    Write-CycleResult $result
                    exit 1
                }
            }
        } catch {
            $step = [ordered]@{
                step = $index
                action = "terminal_review_required_changes_gate_failed"
                executed = $false
                exitCode = 1
                message = $_.Exception.Message
            }
            $steps += [PSCustomObject]$step
            Save-CycleFailureState "terminal_review_required_changes_gate" "terminal_revie
w_required_changes_gate_failed" $_.Exception.Message
            $result = New-CycleResult $steps "terminal_review_required_changes_gate_failed
" $false 1
            Write-CycleResult $result
            exit 1
        }

        $completed = $action -eq "goal_completed"
        $result = New-CycleResult $steps $action $completed 0
        Write-CycleResult $result
        exit 0
    }

    if ($userInterventionActions -contains $action) {
        $result = New-CycleResult $steps "user_intervention_required:$action" $false 0
        Write-CycleResult $result
        exit 0
    }

    if (-not [bool]$autoStep.executed) {
        $result = New-CycleResult $steps "no_automatic_work_remaining:$action" $false 0
        Write-CycleResult $result
        exit 0
    }

    if ($null -ne $previousAction -and $previousAction -eq $action) {
        $result = New-CycleResult $steps "repeated_action_without_progress:$action" $false
 0
        Write-CycleResult $result
        exit 0
    }

    $previousAction = $action
}

$finalResult = New-CycleResult $steps "max_steps_reached" $false 0
Write-CycleResult $finalResult
exit 0

 succeeded in 1576ms:
param(
    [int]$MaxTasks = 1,
    [int]$MaxSteps = 20,
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowCodex,
    [switch]$AllowReviewCodex,
    [switch]$AllowCommit,
    [switch]$AllowDirty,
    [string[]]$ProtectedBaselineDirtyPaths,
    [string[]]$CommitFiles
)

. $PSScriptRoot\ai-dev-env.ps1

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$reviewResponseRelativePath = ".ai-dev/review-response.json"
$aiDevOperationalRoot = ".ai-dev/"
$queuePath = Join-Path $repoRoot $queueRelativePath
$statePath = Join-Path $repoRoot $stateRelativePath
$reviewResponsePath = Join-Path $repoRoot $reviewResponseRelativePath
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)

function Test-HasValue {
    param(
        [object]$Value
    )

    if ($null -eq $Value) {
        return $false
    }

    if ($Value -is [string]) {
        return -not [string]::IsNullOrWhiteSpace($Value)
    }

    return $true
}

function Read-JsonFile {
    param(
        [string]$Path,
        [string]$RelativePath
    )

    try {
        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | ConvertFrom-Json
    } catch {
        throw "$RelativePath JSON 파싱에 실패했습니다: $($_.Exception.Message)"
    }
}

function Set-ObjectProperty {
    param(
        [object]$InputObject,
        [string]$Name,
        [object]$Value
    )

    if ($InputObject.PSObject.Properties.Name -contains $Name) {
        $InputObject.$Name = $Value
    } else {
        $InputObject | Add-Member -NotePropertyName $Name -NotePropertyValue $Value
    }
}

function Write-JsonFile {
    param(
        [string]$Path,
        [object]$Value
    )

    $json = $Value | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($Path, $json, $utf8WithBom)
}

function Save-CycleFailureState {
    param(
        [string]$Command,
        [string]$ErrorSummary,
        [object]$ReviewGate = $null
    )

    try {
        $state = Read-JsonFile $statePath $stateRelativePath

        if ($null -ne $ReviewGate -and (Test-HasValue $ReviewGate.decision)) {
            Set-ObjectProperty $state "lastReviewDecision" ([string]$ReviewGate.decision)
        }

        if ($null -ne $ReviewGate -and (Test-HasValue $ReviewGate.severity)) {
            Set-ObjectProperty $state "lastReviewSeverity" ([string]$ReviewGate.severity)
        }

        Set-ObjectProperty $state "lastCommand" $Command
        Set-ObjectProperty $state "lastCommandStatus" "failed"
        Set-ObjectProperty $state "lastErrorSummary" $ErrorSummary
        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
        Write-JsonFile $statePath $state
    } catch {
        Write-Warning "상태 파일에 실패 사유를 기록하지 못했습니다: $($_.Exception.Message)"
    }
}

function Get-CurrentTask {
    param(
        [object]$Queue,
        [object]$State
    )

    $tasks = @($Queue.tasks)
    $currentTaskId = $null

    if (Test-HasValue $State.currentTaskId) {
        $currentTaskId = [string]$State.currentTaskId
    } elseif (Test-HasValue $Queue.currentTaskId) {
        $currentTaskId = [string]$Queue.currentTaskId
    } else {
        $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-O
bject -First 1

        if ($null -ne $inProgressTask) {
            $currentTaskId = [string]$inProgressTask.id
        } else {
            $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Obje
ct -First 1

            if ($null -ne $pendingTask) {
                $currentTaskId = [string]$pendingTask.id
            }
        }
    }

    if (-not (Test-HasValue $currentTaskId)) {
        return $null
    }

    return $tasks | Where-Object { $_.id -eq $currentTaskId } | Select-Object -First 1
}

function New-StepResult {
    param(
        [int]$Step,
        [string]$Name,
        [string]$Command,
        [bool]$Executed,
        [bool]$Skipped,
        [int]$ExitCode,
        [string]$Message
    )

    return [PSCustomObject][ordered]@{
        step = $Step
        name = $Name
        command = $Command
        executed = $Executed
        skipped = $Skipped
        exitCode = $ExitCode
        message = $Message
    }
}

function New-CycleResult {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    return [PSCustomObject][ordered]@{
        steps = @($Steps)
        stoppedReason = $StoppedReason
        completed = $Completed
        exitCode = $ExitCode
    }
}

function Write-CycleResult {
    param(
        [object]$Result
    )

    if ($Json) {
        $Result | ConvertTo-Json -Depth 20
        return
    }

    foreach ($step in @($Result.steps)) {
        Write-Host "Step $($step.step): $($step.name)"
        Write-Host "  Command: $($step.command)"
        Write-Host "  Executed: $($step.executed)"
        Write-Host "  Skipped: $($step.skipped)"
        Write-Host "  Exit code: $($step.exitCode)"
        Write-Host "  Message: $($step.message)"
    }

    Write-Host "Stopped reason: $($Result.stoppedReason)"
    Write-Host "Completed: $($Result.completed)"
    Write-Host "Exit code: $($Result.exitCode)"

}

function Stop-Cycle {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    $result = New-CycleResult $Steps $StoppedReason $Completed $ExitCode
    Write-CycleResult $result
    exit $ExitCode
}

function Complete-Cycle {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [int]$StepNumber
    )

    try {
        $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -DisplayNam
e "git status --short"

        if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
            $changeLines = @($remainingStatus -split "`r?`n" | Where-Object { -not [string
]::IsNullOrWhiteSpace($_) })
            $changedPaths = @(
                $changeLines |
                    ForEach-Object { Convert-ToChangedPath $_ } |
                    ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
                    Where-Object { Test-HasValue $_ } |
                    Select-Object -Unique
            )
            $protectedPaths = @($changedPaths | Where-Object { Test-IsProtectedBaselineDir
tyPath $_ })
            $nonAiDevPaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationa
lPath $_) })
            $eligibleAiDevPaths = @($changedPaths | Where-Object { (Test-IsAiDevOperationa
lPath $_) -and -not (Test-IsProtectedBaselineDirtyPath $_) })

            if ($nonAiDevPaths.Count -gt 0) {
                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --
short" $true $false 1 "Completed clean verification failed: non-.ai-dev changes remain aft
er all full-cycle result/state files were written.`n$remainingStatus"
                Stop-Cycle $Steps "completed_non_ai_dev_changes" $false 1
            }

            if ($protectedPaths.Count -gt 0) {
                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --
short" $true $false 1 "Completed clean verification failed: protected baseline dirty .ai-d
ev paths remain and must not be absorbed into the final meta commit.`n$($protectedPaths -j
oin "`n")`n$remainingStatus"
                Stop-Cycle $Steps "completed_protected_baseline_dirty" $false 1
            }

            if ($eligibleAiDevPaths.Count -eq 0) {
                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --
short" $true $false 1 "Completed clean verification failed: worktree still has changes, bu
t none are eligible new .ai-dev operational changes.`n$remainingStatus"
                Stop-Cycle $Steps "completed_no_eligible_meta_changes" $false 1
            }

            if (-not $AllowCommit) {
                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --
short" $true $false 1 "Completed clean verification failed: only new .ai-dev operational c
hanges remain, but -AllowCommit is required for the final auto-cycle meta commit.`n$remain
ingStatus"
                Stop-Cycle $Steps "completed_ai_dev_changes_require_commit" $false 1
            }

            if ($DryRun) {
                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --
short; git add/commit final .ai-dev operational changes; git status --short" $false $true 
0 "DryRun: only new .ai-dev operational changes remain, but the final auto-cycle meta comm
it was not created.`n$remainingStatus"
                Stop-Cycle $Steps "dry_run" $false 0
            }

            $addOutput = & git add -- $eligibleAiDevPaths 2>&1 | Out-String
            $addExitCode = $LASTEXITCODE

            if ($addExitCode -ne 0) {
                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git add -- <f
inal .ai-dev files>" $true $false 1 "Final auto-cycle .ai-dev meta add failed. exit code: 
$addExitCode`n$addOutput"
                Stop-Cycle $Steps "completed_meta_add_failed" $false 1
            }

            $metaCommitMessage = "chore(ai-dev): record final auto-cycle state"
            $commitOutput = & git commit -m $metaCommitMessage -- $eligibleAiDevPaths 2>&1
 | Out-String
            $commitExitCode = $LASTEXITCODE

            if ($commitExitCode -ne 0) {
                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git commit -m
 '$metaCommitMessage' -- <final .ai-dev files>" $true $false 1 "Final auto-cycle .ai-dev m
eta commit failed. exit code: $commitExitCode`n$commitOutput"
                Stop-Cycle $Steps "completed_meta_commit_failed" $false 1
            }

            $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -Displa
yName "git status --short"

            if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --
short" $true $false 1 "Completed clean verification failed: changes remain after the final
 auto-cycle .ai-dev meta commit.`n$remainingStatus"
                Stop-Cycle $Steps "completed_worktree_dirty" $false 1
            }

            $message = ($commitOutput.Trim(), "Final auto-cycle .ai-dev meta commit create
d: yes", "Completed clean verification passed: git status --short returned no changes.") -
join "`n"
            $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --shor
t; git add/commit final .ai-dev operational changes; git status --short" $true $false 0 $m
essage
            Stop-Cycle $Steps $StoppedReason $true 0
        }

        $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $
true $false 0 "Completed clean verification passed: git status --short returned no changes
."
        Stop-Cycle $Steps $StoppedReason $true 0
    } catch {
        $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short" $
false $false 1 $_.Exception.Message
        Stop-Cycle $Steps "completed_clean_gate_failed" $false 1
    }
}

function Invoke-CycleCommand {
    param(
        [int]$StepNumber,
        [string]$Name,
        [string]$Command,
        [string]$ScriptPath,
        [string[]]$Arguments
    )

    if ($DryRun) {
        $script:steps += New-StepResult $StepNumber $Name $Command $false $true 0 "DryRun:
 하위 스크립트를 실행하지 않았습니다."
        return
    }

    $output = & powershell -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1 | Out
-String
    $exitCode = $LASTEXITCODE
    $message = $output.Trim()

    if ([string]::IsNullOrWhiteSpace($message)) {
        $message = "완료"
    }

    $script:steps += New-StepResult $StepNumber $Name $Command $true $false $exitCode $mes
sage

    if ($exitCode -ne 0) {
        Stop-Cycle $script:steps "$Name`_failed" $false 1
    }
}

function Get-ScriptPath {
    param(
        [string]$Name
    )

    $scriptPath = Join-Path $PSScriptRoot $Name

    if (-not (Test-Path -LiteralPath $scriptPath -PathType Leaf)) {
        throw "필수 스크립트를 찾을 수 없습니다: scripts/$Name"
    }

    return $scriptPath
}

function Invoke-GitCapture {
    param(
        [string[]]$Arguments,
        [string]$DisplayName
    )

    $output = & git @Arguments 2>&1 | Out-String
    $exitCode = $LASTEXITCODE

    if ($exitCode -ne 0) {
        throw "$DisplayName 실행에 실패했습니다. exit code: $exitCode`n$output"
    }

    return $output.TrimEnd()
}

function Test-PackageFileChanged {
    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-
lock.json") "git status --porcelain -- package.json package-lock.json"
    return -not [string]::IsNullOrWhiteSpace($status)
}

function Convert-ToChangedPath {
    param(
        [string]$ChangeLine
    )

    if ([string]::IsNullOrWhiteSpace($ChangeLine)) {
        return @()
    }

    $pathText = $ChangeLine

    if ($ChangeLine.Length -ge 4 -and $ChangeLine.Substring(2, 1) -eq " ") {
        $pathText = $ChangeLine.Substring(3)
    }

    if ($pathText.Contains(" -> ")) {
        return @($pathText -split " -> " | Where-Object { Test-HasValue $_ })
    }

    return @($pathText)
}

function ConvertTo-NormalizedChangedPath {
    param(
        [string]$RelativePath
    )

    if (-not (Test-HasValue $RelativePath)) {
        return $null
    }

    return $RelativePath.Trim().Trim('"').Replace('\', '/')
}

function Test-IsAiDevOperationalPath {
    param(
        [string]$RelativePath
    )

    $normalizedRelativePath = ConvertTo-NormalizedChangedPath $RelativePath
    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringCompari
son]::OrdinalIgnoreCase)
}

function Get-ProtectedBaselineDirtyPaths {
    if ($null -eq $ProtectedBaselineDirtyPaths -or $ProtectedBaselineDirtyPaths.Count -eq 
0) {
        return @()
    }

    return @(
        $ProtectedBaselineDirtyPaths |
            ForEach-Object { $_ -split "," } |
            Where-Object { Test-HasValue $_ } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Select-Object -Unique
    )
}

function Test-IsProtectedBaselineDirtyPath {
    param(
        [string]$RelativePath
    )

    $normalizedRelativePath = ConvertTo-NormalizedChangedPath $RelativePath
    return @($script:protectedBaselineDirtyPaths) -contains $normalizedRelativePath
}

function Get-ChangedNonAiDevFiles {
    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteS
pace($_) })

    return @(
        $changeLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Where-Object { (Test-HasValue $_) -and -not (Test-IsAiDevOperationalPath $_) -
and -not (Test-IsProtectedBaselineDirtyPath $_) } |
            Select-Object -Unique
    )
}

function Get-RequiredReviewChangeFiles {
    param(
        [object]$ReviewResponse
    )

    if ($null -eq $ReviewResponse -or -not ($ReviewResponse.PSObject.Properties.Name -cont
ains "required_changes")) {
        return @()
    }

    return @(
        @($ReviewResponse.required_changes) |
            Where-Object { $null -ne $_ -and ($_.PSObject.Properties.Name -contains "file"
) -and (Test-HasValue $_.file) } |
            ForEach-Object { ConvertTo-NormalizedChangedPath ([string]$_.file) } |
            Where-Object { (Test-HasValue $_) -and $_ -ne "unknown" -and -not (Test-IsAiDe
vOperationalPath $_) -and -not (Test-IsProtectedBaselineDirtyPath $_) } |
            Select-Object -Unique
    )
}

function Test-ReviewRequiredFileIsChanged {
    param(
        [string]$RequiredFile,
        [string[]]$ChangedFiles
    )

    foreach ($changedFile in @($ChangedFiles)) {
        if ($changedFile.Equals($RequiredFile, [System.StringComparison]::OrdinalIgnoreCas
e)) {
            return $true
        }
    }

    return $false
}

function Get-ReviewImplementationGate {
    param(
        [object]$CurrentTask,
        [object]$ReviewGate
    )

    $taskType = if ($null -ne $CurrentTask -and (Test-HasValue $CurrentTask.type)) { [stri
ng]$CurrentTask.type } else { "" }
    $requiredFiles = @($ReviewGate.requiredChangeFiles)
    $changedFiles = @(Get-ChangedNonAiDevFiles)
    $missingRequiredFiles = @(
        $requiredFiles |
            Where-Object { -not (Test-ReviewRequiredFileIsChanged $_ $changedFiles) }
    )

    if ($ReviewGate.decision -eq "revise" -and $taskType -ne "implementation") {
        return [PSCustomObject][ordered]@{
            passed = $false
            reason = "non_implementation_revise"
            message = "현재 task type이 implementation이 아닌데 review decision=revise입니다. 구현 없는 
revise 반복을 성공 처리하지 않도록 중단합니다. taskType='$taskType', requiredFiles=$($requiredFiles -join '
, '), changedFiles=$($changedFiles -join ', ')"
        }
    }

    if ($requiredFiles.Count -gt 0 -and $changedFiles.Count -eq 0) {
        return [PSCustomObject][ordered]@{
            passed = $false
            reason = "missing_implementation"
            message = "review-response.json이 구현 파일 변경을 요구했지만 현재 diff에 구현 변경 파일이 없습니다. requ
iredFiles=$($requiredFiles -join ', ')"
        }
    }

    if ($missingRequiredFiles.Count -gt 0) {
        return [PSCustomObject][ordered]@{
            passed = $false
            reason = "stale_review_required_file_missing"
            message = "review-response.json이 요구한 구현 파일 변경이 현재 diff에 없습니다. stale review 또는 
missing implementation으로 보고 완료 흐름을 차단합니다. missingRequiredFiles=$($missingRequiredFiles -jo
in ', '), changedFiles=$($changedFiles -join ', ')"
        }
    }

    return [PSCustomObject][ordered]@{
        passed = $true
        reason = "ok"
        message = "review-response.json required_changes와 현재 diff 파일 목록이 일치합니다."
    }
}

function Get-ChangedAiDevOperationalFiles {
    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteS
pace($_) })

    return @(
        $changeLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Where-Object { (Test-HasValue $_) -and (Test-IsAiDevOperationalPath $_) -and -
not (Test-IsProtectedBaselineDirtyPath $_) } |
            Select-Object -Unique
    )
}

function Get-ReviewGate {
    $state = Read-JsonFile $statePath $stateRelativePath
    $reviewResponse = $null
    $decision = $null
    $severity = $null
    $nextStep = $null
    $normalizedNextStep = $null
    $hasNextStep = $false

    if (Test-Path -LiteralPath $reviewResponsePath -PathType Leaf) {
        $reviewResponse = Read-JsonFile $reviewResponsePath $reviewResponseRelativePath

        if (Test-HasValue $reviewResponse.decision) {
            $decision = [string]$reviewResponse.decision
        }

        if (Test-HasValue $reviewResponse.severity) {
            $severity = [string]$reviewResponse.severity
        }

        if ($reviewResponse.PSObject.Properties.Name -contains "next_step") {
            $hasNextStep = $true
            $nextStep = [string]$reviewResponse.next_step
            $normalizedNextStep = $nextStep.Trim().ToLowerInvariant().Replace("-", "_")
        }
    }

    return [PSCustomObject][ordered]@{
        lastCommand = [string]$state.lastCommand
        lastCommandStatus = [string]$state.lastCommandStatus
        stateDecision = [string]$state.lastReviewDecision
        decision = $decision
        severity = $severity
        hasNextStep = $hasNextStep
        nextStep = $nextStep
        normalizedNextStep = $normalizedNextStep
        requiredChangeFiles = @(Get-RequiredReviewChangeFiles $reviewResponse)
    }
}

function Test-IsAcceptableReviewNextStep {
    param(
        [object]$ReviewGate
    )

    return (-not $ReviewGate.hasNextStep) -or $ReviewGate.normalizedNextStep -eq "complete
_task"
}

function Test-IsSavedReviewPassReady {
    param(
        [object]$ReviewGate
    )

    return $ReviewGate.lastCommand -eq "save-review" `
        -and $ReviewGate.lastCommandStatus -eq "passed" `
        -and $ReviewGate.decision -eq "pass" `
        -and $ReviewGate.stateDecision -eq "pass" `
        -and (Test-IsAcceptableReviewNextStep $ReviewGate)
}

function Get-CommitArguments {
    $arguments = @()

    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
        $normalizedFiles = @(
            $CommitFiles |
                ForEach-Object { $_ -split "," } |
                Where-Object { Test-HasValue $_ } |
                ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
                Where-Object { -not (Test-IsProtectedBaselineDirtyPath $_) }
        )

        if ($normalizedFiles.Count -gt 0) {
            $arguments += "-Files"
            $arguments += ($normalizedFiles -join ",")
        }

        return $arguments
    }

    $implementationFiles = Get-ChangedNonAiDevFiles

    if ($implementationFiles.Count -gt 0) {
        $arguments += "-Files"
        $arguments += ($implementationFiles -join ",")
    }

    return $arguments
}

function Invoke-DirectMetaCommit {
    param(
        [int]$StepNumber
    )

    $command = "direct meta commit: git add scoped .ai-dev files, git commit -m 'chore(ai-
dev): record task completion', git status --short"

    try {
        $changedAiDevFiles = Get-ChangedAiDevOperationalFiles

        if ($changedAiDevFiles.Count -eq 0) {
            $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -Displa
yName "git status --short"

            if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
                throw ".ai-dev 메타 변경사항은 없지만 worktree에 변경 파일이 남아 있습니다.`n$remainingStatus"
            }

            $script:steps += New-StepResult $StepNumber "meta-commit" $command $false $tru
e 0 ".ai-dev 메타 상태 변경사항이 없어 meta commit을 건너뜁니다. worktree clean."
            return
        }

        $addOutput = & git add -- $changedAiDevFiles 2>&1 | Out-String
        $addExitCode = $LASTEXITCODE

        if ($addExitCode -ne 0) {
            throw "git add 실행에 실패했습니다. exit code: $addExitCode`n$addOutput"
        }

        $commitOutput = & git commit -m "chore(ai-dev): record task completion" -- $change
dAiDevFiles 2>&1 | Out-String
        $commitExitCode = $LASTEXITCODE

        if ($commitExitCode -ne 0) {
            throw "git commit 실행에 실패했습니다. exit code: $commitExitCode`n$commitOutput"
        }

        $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -DisplayNam
e "git status --short"

        if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
            throw "meta commit 이후 worktree에 변경 파일이 남아 있습니다.`n$remainingStatus"
        }

        $message = ($commitOutput.Trim(), "worktree clean") -join "`n"
        $script:steps += New-StepResult $StepNumber "meta-commit" $command $true $false 0 
$message
    } catch {
        $script:steps += New-StepResult $StepNumber "meta-commit" $command $true $false 1 
$_.Exception.Message
        Stop-Cycle $script:steps "meta_commit_failed" $false 1
    }
}

function Get-CommitGate {
    param(
        [string]$PreviousHeadCommitHash
    )

    $state = Read-JsonFile $statePath $stateRelativePath
    $lastCommitHash = if (Test-HasValue $state.lastCommitHash) { [string]$state.lastCommit
Hash } else { $null }
    $headCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "gi
t rev-parse HEAD"
    $commitHashChanged = (Test-HasValue $headCommitHash) -and $headCommitHash -ne $Previou
sHeadCommitHash
    $commitHashMatchesHead = (Test-HasValue $lastCommitHash) -and $lastCommitHash -eq $hea
dCommitHash

    if ($state.lastCommand -eq "commit" -and $state.lastCommandStatus -eq "passed" -and $c
ommitHashChanged -and -not $commitHashMatchesHead) {
        Set-ObjectProperty $state "lastCommitHash" $headCommitHash
        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
        Write-JsonFile $statePath $state

        $lastCommitHash = $headCommitHash
        $commitHashMatchesHead = $true
    }

    return [PSCustomObject][ordered]@{
        lastCommand = [string]$state.lastCommand
        lastCommandStatus = [string]$state.lastCommandStatus
        lastCommitHash = [string]$lastCommitHash
        commitHashChanged = $commitHashChanged
        commitHashMatchesHead = $commitHashMatchesHead
    }
}

Set-Location $repoRoot

$script:steps = @()
$script:protectedBaselineDirtyPaths = @(Get-ProtectedBaselineDirtyPaths)

if ($script:protectedBaselineDirtyPaths.Count -gt 0) {
    $script:steps += New-StepResult 0 "baseline-dirty-protection" "ProtectedBaselineDirtyP
aths" $false $false 0 "Auto-goal baseline dirty paths are protected from implementation an
d .ai-dev meta commit eligibility: $($script:protectedBaselineDirtyPaths -join ', ')"
}

if ($MaxTasks -lt 1) {
    Stop-Cycle $script:steps "max_tasks_must_be_at_least_1" $false 1
}

if ($MaxSteps -lt 1) {
    Stop-Cycle $script:steps "max_steps_must_be_at_least_1" $false 1
}

try {
    foreach ($requiredPath in @($queuePath, $statePath)) {
        if (-not (Test-Path -LiteralPath $requiredPath -PathType Leaf)) {
            throw "필수 상태 파일이 없습니다: $requiredPath"
        }
    }

    $queue = Read-JsonFile $queuePath $queueRelativePath
    $state = Read-JsonFile $statePath $stateRelativePath

    if ($state.goalStatus -eq "completed") {
        Complete-Cycle $script:steps "goal_completed" 0
    }

    if (-not ($queue.PSObject.Properties.Name -contains "tasks") -or $null -eq $queue.task
s) {
        Stop-Cycle $script:steps "no_task" $false 0
    }

    $currentTask = Get-CurrentTask $queue $state

    if ($null -eq $currentTask) {
        Stop-Cycle $script:steps "no_task" $false 0
    }

    if ($currentTask.status -eq "done") {
        Complete-Cycle $script:steps "current_task_done" 0
    }

    $scriptPaths = @{
        makePrompt = Get-ScriptPath "ai-dev-make-prompt.ps1"
        runCodex = Get-ScriptPath "ai-dev-run-codex.ps1"
        check = Get-ScriptPath "ai-dev-check.ps1"
        saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
        makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
        runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
        commit = Get-ScriptPath "ai-dev-commit.ps1"
        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
        status = Get-ScriptPath "ai-dev-status.ps1"
    }
} catch {
    $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Except
ion.Message
    Stop-Cycle $script:steps "prepare_failed" $false 1
}

$plannedSteps = @(
    "task-start",
    "make-prompt",
    "run-codex",
    "check",
    "save-diff",
    "make-review-prompt",
    "run-review-codex",
    "review-gate",
    "package-change-gate",
    "commit",
    "commit-result-gate",
    "complete-task",
    "meta-commit",
    "final-status"
)

if ($plannedSteps.Count -gt $MaxSteps) {
    Stop-Cycle $script:steps "max_steps_too_small_for_full_cycle" $false 1
}

$stepNumber = 1
$completedTaskCount = 0

while ($completedTaskCount -lt $MaxTasks) {
    try {
        $queue = Read-JsonFile $queuePath $queueRelativePath
        $state = Read-JsonFile $statePath $stateRelativePath
        $currentTask = Get-CurrentTask $queue $state
    } catch {
        $script:steps += New-StepResult $stepNumber "load-task" "state/queue 확인" $false $f
alse 1 $_.Exception.Message
        Stop-Cycle $script:steps "load_task_failed" $false 1
    }

    if ($state.goalStatus -eq "completed") {
        Complete-Cycle $script:steps "goal_completed" $stepNumber
    }

    if ($null -eq $currentTask) {
        Stop-Cycle $script:steps "no_task" $false 0
    }

    if ($currentTask.status -eq "done") {
        Complete-Cycle $script:steps "current_task_done" $stepNumber
    }

    $taskLabel = "$($currentTask.id) $($currentTask.title)"
    $script:steps += New-StepResult $stepNumber "task-start" "MaxTasks=$MaxTasks" $false $
false 0 "현재 task 실행 시작: $taskLabel"
    $stepNumber++

    $resumeFromSavedReview = $false

    if (-not $DryRun) {
        try {
            $resumeReviewGate = Get-ReviewGate
        } catch {
            $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review
-response 확인" $false $false 1 $_.Exception.Message
            Stop-Cycle $script:steps "resume_review_gate_failed" $false 1
        }

        if (Test-IsSavedReviewPassReady $resumeReviewGate) {
            $resumeImplementationGate = Get-ReviewImplementationGate $currentTask $resumeR
eviewGate

            if (-not $resumeImplementationGate.passed) {
                Save-CycleFailureState "resume-review-gate" $resumeImplementationGate.mess
age $resumeReviewGate
                $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/re
view-response required_changes 및 현재 diff 확인" $false $true 1 $resumeImplementationGate.mess
age
                Stop-Cycle $script:steps $resumeImplementationGate.reason $false 1
            }

            $resumeFromSavedReview = $true
            $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review
-response 재확인" $false $false 0 "이미 저장된 리뷰 pass와 허용 가능한 next_step 상태를 확인했습니다. 구현/리뷰 재실행 없이 
commit/complete/meta-commit으로 계속 진행합니다."
            $stepNumber++
        } elseif ($resumeReviewGate.lastCommand -eq "save-review" -and $resumeReviewGate.l
astCommandStatus -eq "passed") {
            $resumeImplementationGate = Get-ReviewImplementationGate $currentTask $resumeR
eviewGate
            $message = "save-review 이후 계속 진행할 수 없습니다. review.decision=$($resumeReviewGate.
decision), state.lastReviewDecision=$($resumeReviewGate.stateDecision), next_step=$($resum
eReviewGate.nextStep)"

            if (-not $resumeImplementationGate.passed) {
                $message = $resumeImplementationGate.message
                Save-CycleFailureState "resume-review-gate" $message $resumeReviewGate
                $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/re
view-response required_changes 및 현재 diff 확인" $false $true 1 $message
                Stop-Cycle $script:steps $resumeImplementationGate.reason $false 1
            }

            Save-CycleFailureState "resume-review-gate" $message $resumeReviewGate
            $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review
-response 재확인" $false $true 1 $message
            Stop-Cycle $script:steps "saved_review_not_ready_to_complete" $false 1
        }
    }

    if (-not $resumeFromSavedReview) {
        Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass 
-File scripts/ai-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
        $stepNumber++

        if (-not $AllowCodex -and -not $DryRun) {
            $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle
-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
            if ($AllowDirty) {
                $command = "$command -AllowDirty"
            }

            if ($AllowCommit) {
                $command = "$command -AllowCommit"
            }

            if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
                $command = "$command -CommitFiles $($CommitFiles -join ',')"
            }

            $script:steps += New-StepResult $stepNumber "run-codex" "powershell -Execution
Policy Bypass -File scripts/ai-dev-run-codex.ps1" $false $true 1 "Codex 구현 실행에는 -AllowCode
x가 필요합니다. 추천 명령: $command"
            Stop-Cycle $script:steps "allow_codex_required" $false 1
        }

        $runCodexArguments = @()
        if ($AllowDirty) {
            $runCodexArguments += "-AllowDirty"
        }

        Invoke-CycleCommand $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass -F
ile scripts/ai-dev-run-codex.ps1" $scriptPaths.runCodex $runCodexArguments
        $stepNumber++

        Invoke-CycleCommand $stepNumber "check" "powershell -ExecutionPolicy Bypass -File 
scripts/ai-dev-check.ps1 -BuildOnly" $scriptPaths.check @("-BuildOnly")
        $stepNumber++

        Invoke-CycleCommand $stepNumber "save-diff" "powershell -ExecutionPolicy Bypass -F
ile scripts/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
        $stepNumber++

        Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy 
Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt 
@("-Strict")
        $stepNumber++

        if (-not $AllowReviewCodex -and -not $DryRun) {
            $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle
-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
            if ($AllowDirty) {
                $command = "$command -AllowDirty"
            }

            if ($AllowCommit) {
                $command = "$command -AllowCommit"
            }

            if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
                $command = "$command -CommitFiles $($CommitFiles -join ',')"
            }

            $script:steps += New-StepResult $stepNumber "run-review-codex" "powershell -Ex
ecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $f
alse $true 1 "Codex 리뷰 실행에는 -AllowReviewCodex가 필요합니다. 추천 명령: $command"
            Stop-Cycle $script:steps "allow_review_codex_required" $false 1
        }

        Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy By
pass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runRe
viewCodex @("-AllowDirty", "-SaveReview")
        $stepNumber++
    }

    if ($DryRun) {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecisio
n 확인" $false $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --po
rcelain -- package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 
않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy 
Bypass -File scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다
."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastComman
d/lastCommitHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "complete-task" "powershell -Execution
Policy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"자동 완료: Codex 구현, bui
ld/check, Codex 리뷰 pass, 자동 커밋 완료`" -CommitHash <commit-hash>" $false $true 0 "DryRun: tas
k 완료 처리를 실행하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "meta-commit" "direct meta commit: git
 add scoped .ai-dev files, git commit -m 'chore(ai-dev): record task completion', git stat
us --short" $false $true 0 "DryRun: .ai-dev 메타 상태 직접 커밋을 실행하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "final-status" "powershell -ExecutionP
olicy Bypass -File scripts/ai-dev-status.ps1" $false $true 0 "DryRun: 최종 작업 상태 확인을 실행하지 않았
습니다."
        Stop-Cycle $script:steps "dry_run" $false 0
    }

    try {
        $reviewGate = Get-ReviewGate
    } catch {
        $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확
인" $false $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "review_gate_failed" $false 1
    }

    if ($reviewGate.lastCommand -ne "save-review" -or $reviewGate.lastCommandStatus -ne "p
assed") {
        $message = "최신 state가 save-review passed가 아니므로 자동 커밋하지 않습니다: lastCommand=$($review
Gate.lastCommand), lastCommandStatus=$($reviewGate.lastCommandStatus)"
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommand/state
.lastCommandStatus 확인" $false $true 1 $message
        Stop-Cycle $script:steps "review_save_not_passed" $false 1
    }

    $implementationGate = Get-ReviewImplementationGate $currentTask $reviewGate

    if (-not $implementationGate.passed) {
        Save-CycleFailureState "review-gate" $implementationGate.message $reviewGate
        $script:steps += New-StepResult $stepNumber "review-gate" "task type, $reviewRespo
nseRelativePath required_changes, 현재 diff 확인" $false $true 1 $implementationGate.message
        Stop-Cycle $script:steps $implementationGate.reason $false 1
    }

    if ($reviewGate.decision -ne "pass") {
        $message = "리뷰 response decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($r
eviewGate.decision)"
        Save-CycleFailureState "review-gate" $message $reviewGate
        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelative
Path decision 확인" $false $true 1 $message
        Stop-Cycle $script:steps "review_not_pass" $false 1
    }

    if ($reviewGate.stateDecision -ne "pass") {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecisio
n 확인" $false $true 1 "state.lastReviewDecision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다
: $($reviewGate.stateDecision)"
        Stop-Cycle $script:steps "state_review_not_pass" $false 1
    }

    if (-not (Test-IsAcceptableReviewNextStep $reviewGate)) {
        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelative
Path next_step 확인" $false $true 1 "리뷰 next_step이 존재하지만 complete_task가 아니므로 자동 커밋과 complete
-task를 실행하지 않습니다: 원본='$($reviewGate.nextStep)', 정규화='$($reviewGate.normalizedNextStep)'"
        Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 1
    }

    $script:steps += New-StepResult $stepNumber "review-gate" "최신 state 및 $reviewResponseR
elativePath 재확인" $false $false 0 "리뷰 pass 및 허용 가능한 next_step 상태 수락: 존재=$($reviewGate.hasNe
xtStep), 원본='$($reviewGate.nextStep)', 정규화='$($reviewGate.normalizedNextStep)'. commit/com
mit-result-gate/complete-task/meta-commit으로 계속 진행합니다."
    $stepNumber++

    try {
        if (Test-PackageFileChanged) {
            $script:steps += New-StepResult $stepNumber "package-change-gate" "git status 
--porcelain -- package.json package-lock.json" $false $true 1 "package.json 또는 package-loc
k.json 변경이 감지되어 자동 커밋하지 않습니다."
            Stop-Cycle $script:steps "package_files_changed" $false 1
        }
    } catch {
        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --po
rcelain -- package.json package-lock.json" $false $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "package_change_gate_failed" $false 1
    }

    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcel
ain -- package.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다.
"
    $stepNumber++

    if (-not $AllowCommit) {
        $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cyc
le-full.ps1 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
        if ($AllowDirty) {
            $commitCommand = "$commitCommand -AllowDirty"
        }

        if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
            $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
        }

        $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy 
Bypass -File scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령
: $commitCommand"
        Stop-Cycle $script:steps "allow_commit_required" $false 1
    }

    $commitArguments = Get-CommitArguments

    if ($commitArguments.Count -eq 0) {
        $script:steps += New-StepResult $stepNumber "commit" "git status --porcelain" $fal
se $true 1 "커밋할 구현 변경사항이 없어 complete-task를 실행하지 않습니다."
        Stop-Cycle $script:steps "no_implementation_changes" $false 1
    }

    $commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.p
s1"
    if ($commitArguments.Count -gt 0) {
        $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
    }

    try {
        $preCommitHeadCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -Di
splayName "git rev-parse HEAD"
    } catch {
        $script:steps += New-StepResult $stepNumber "commit" "git rev-parse HEAD" $false $
false 1 $_.Exception.Message
        Stop-Cycle $script:steps "pre_commit_head_failed" $false 1
    }

    Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commi
tArguments
    $stepNumber++

    try {
        $commitGate = Get-CommitGate $preCommitHeadCommitHash
    } catch {
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastComman
d/lastCommitHash 확인" $false $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
    }

    if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed
" -or -not $commitGate.commitHashChanged -or -not $commitGate.commitHashMatchesHead) {
        $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.
lastCommand), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commit
Gate.lastCommitHash)"
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastComman
d/lastCommitHash 확인" $false $true 1 $message
        Stop-Cycle $script:steps "commit_not_confirmed" $false 1
    }

    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/la
stCommitHash 확인" $false $false 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
    $stepNumber++

    $resultSummary = "자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료"
    Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -F
ile scripts/ai-dev-complete-task.ps1 -ResultSummary `"$resultSummary`" -CommitHash $($comm
itGate.lastCommitHash)" $scriptPaths.completeTask @("-ResultSummary", $resultSummary, "-Co
mmitHash", $commitGate.lastCommitHash)
    $stepNumber++

    Invoke-DirectMetaCommit $stepNumber
    $stepNumber++

    Invoke-CycleCommand $stepNumber "final-status" "powershell -ExecutionPolicy Bypass -Fi
le scripts/ai-dev-status.ps1" $scriptPaths.status @()
    $stepNumber++

    $completedTaskCount++

    $stateAfterComplete = Read-JsonFile $statePath $stateRelativePath

    if ($stateAfterComplete.goalStatus -eq "completed") {
        Complete-Cycle $script:steps "goal_completed" $stepNumber
    }
}

Complete-Cycle $script:steps "max_tasks_reached" $stepNumber

codex
변경된 두 파일의 실제 흐름을 확인했습니다. 이제 자동 루프의 분기 조건이 성공 기준을 막지 못하는 지점이 있는지 중심으로 판단하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -
LiteralPath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-cycle.ps1' -Pattern 'Test-
IsNonImplementationReviseAction|Get-ReviewRequiredChangesGate|terminalReviewRequiredChange
sGate|Test-IsAlreadyCompletedGoalState|userInterventionActions|make_revise_prompt|Save-Cyc
leFailureState'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -
LiteralPath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-cycle-full.ps1' -Pattern '
Get-ReviewImplementationGate|Test-IsSavedReviewPassReady|resumeImplementationGate|implemen
tationGate|reviewGate.decision|Save-CycleFailureState'" in D:\ai-apps\planpilot-local
 succeeded in 1680ms:

scripts\ai-dev-auto-cycle.ps1:120:function Save-CycleFailureState {
scripts\ai-dev-auto-cycle.ps1:295:function Test-IsNonImplementationReviseAction {
scripts\ai-dev-auto-cycle.ps1:298:    if ($Action -ne "make_revise_prompt") {
scripts\ai-dev-auto-cycle.ps1:315:function Get-ReviewRequiredChangesGate {
scripts\ai-dev-auto-cycle.ps1:390:function Test-IsAlreadyCompletedGoalState {
scripts\ai-dev-auto-cycle.ps1:415:$userInterventionActions = @(
scripts\ai-dev-auto-cycle.ps1:418:    "make_revise_prompt",
scripts\ai-dev-auto-cycle.ps1:513:        if (Test-IsNonImplementationReviseAction $action
) {
scripts\ai-dev-auto-cycle.ps1:514:            Save-CycleFailureState "non_implementation_r
evise" "non_implementation_re
vise" ([string]$autoStep.message)
scripts\ai-dev-auto-cycle.ps1:522:        if ($action -eq "make_revise_prompt") {
scripts\ai-dev-auto-cycle.ps1:523:            $reviewRequiredChangesGate = Get-ReviewRequi
redChangesGate -OnlyWhenCurre
ntTaskIsImplementation
scripts\ai-dev-auto-cycle.ps1:525:            $reviewRequiredChangesGate = Get-ReviewRequi
redChangesGate
scripts\ai-dev-auto-cycle.ps1:538:            Save-CycleFailureState "review_required_chan
ges_gate" ([string]$reviewReq
uiredChangesGate.reason) ([string]$reviewRequiredChangesGate.message) @($reviewRequiredCha
ngesGate.missingRequiredFiles
)
scripts\ai-dev-auto-cycle.ps1:552:        Save-CycleFailureState "review_required_changes_
gate" "revise_gate_failed" $_
.Exception.Message
scripts\ai-dev-auto-cycle.ps1:560:            $shouldRunTerminalReviewRequiredChangesGate 
= -not (
scripts\ai-dev-auto-cycle.ps1:561:                $action -eq "goal_completed" -and (Test-
IsAlreadyCompletedGoalState)
scripts\ai-dev-auto-cycle.ps1:564:            if ($shouldRunTerminalReviewRequiredChangesG
ate) {
scripts\ai-dev-auto-cycle.ps1:565:                $terminalReviewRequiredChangesGate = Get
-ReviewRequiredChangesGate
scripts\ai-dev-auto-cycle.ps1:567:                if (-not $terminalReviewRequiredChangesG
ate.passed) {
scripts\ai-dev-auto-cycle.ps1:573:                        message = $terminalReviewRequire
dChangesGate.message
scripts\ai-dev-auto-cycle.ps1:577:                    Save-CycleFailureState "terminal_rev
iew_required_changes_gate" ([
string]$terminalReviewRequiredChangesGate.reason) ([string]$terminalReviewRequiredChangesG
ate.message) @($terminalRevie
wRequiredChangesGate.missingRequiredFiles)
scripts\ai-dev-auto-cycle.ps1:578:                    $result = New-CycleResult $steps $te
rminalReviewRequiredChangesGa
te.reason $false 1
scripts\ai-dev-auto-cycle.ps1:592:            Save-CycleFailureState "terminal_review_requ
ired_changes_gate" "terminal_
review_required_changes_gate_failed" $_.Exception.Message
scripts\ai-dev-auto-cycle.ps1:604:    if ($userInterventionActions -contains $action) {



 succeeded in 1708ms:

scripts\ai-dev-auto-cycle-full.ps1:79:function Save-CycleFailureState {
scripts\ai-dev-auto-cycle-full.ps1:89:        if ($null -ne $ReviewGate -and (Test-HasValu
e $ReviewGate.decision)) {
scripts\ai-dev-auto-cycle-full.ps1:90:            Set-ObjectProperty $state "lastReviewDec
ision" ([string]$ReviewGate.d
ecision)
scripts\ai-dev-auto-cycle-full.ps1:478:function Get-ReviewImplementationGate {
scripts\ai-dev-auto-cycle-full.ps1:492:    if ($ReviewGate.decision -eq "revise" -and $tas
kType -ne "implementation") {
scripts\ai-dev-auto-cycle-full.ps1:584:function Test-IsSavedReviewPassReady {
scripts\ai-dev-auto-cycle-full.ps1:591:        -and $ReviewGate.decision -eq "pass" `
scripts\ai-dev-auto-cycle-full.ps1:825:        if (Test-IsSavedReviewPassReady $resumeRevi
ewGate) {
scripts\ai-dev-auto-cycle-full.ps1:826:            $resumeImplementationGate = Get-ReviewI
mplementationGate $currentTas
k $resumeReviewGate
scripts\ai-dev-auto-cycle-full.ps1:828:            if (-not $resumeImplementationGate.pass
ed) {
scripts\ai-dev-auto-cycle-full.ps1:829:                Save-CycleFailureState "resume-revi
ew-gate" $resumeImplementatio
nGate.message $resumeReviewGate
scripts\ai-dev-auto-cycle-full.ps1:830:                $script:steps += New-StepResult $st
epNumber "resume-review-gate"
 "state/review-response required_changes 및 현재 diff 확인" $false $true 1 $resumeImplementatio
nGate.message
scripts\ai-dev-auto-cycle-full.ps1:831:                Stop-Cycle $script:steps $resumeImp
lementationGate.reason $false
 1
scripts\ai-dev-auto-cycle-full.ps1:838:            $resumeImplementationGate = Get-ReviewI
mplementationGate $currentTas
k $resumeReviewGate
scripts\ai-dev-auto-cycle-full.ps1:839:            $message = "save-review 이후 계속 진행할 수 없습니
다. review.decision=$($resumeR
eviewGate.decision), state.lastReviewDecision=$($resumeReviewGate.stateDecision), next_ste
p=$($resumeReviewGate.nextSte
p)"
scripts\ai-dev-auto-cycle-full.ps1:841:            if (-not $resumeImplementationGate.pass
ed) {
scripts\ai-dev-auto-cycle-full.ps1:842:                $message = $resumeImplementationGat
e.message
scripts\ai-dev-auto-cycle-full.ps1:843:                Save-CycleFailureState "resume-revi
ew-gate" $message $resumeRevi
ewGate
scripts\ai-dev-auto-cycle-full.ps1:845:                Stop-Cycle $script:steps $resumeImp
lementationGate.reason $false
 1
scripts\ai-dev-auto-cycle-full.ps1:848:            Save-CycleFailureState "resume-review-g
ate" $message $resumeReviewGa
te
scripts\ai-dev-auto-cycle-full.ps1:945:    $implementationGate = Get-ReviewImplementationG
ate $currentTask $reviewGate
scripts\ai-dev-auto-cycle-full.ps1:947:    if (-not $implementationGate.passed) {
scripts\ai-dev-auto-cycle-full.ps1:948:        Save-CycleFailureState "review-gate" $imple
mentationGate.message $review
Gate
scripts\ai-dev-auto-cycle-full.ps1:949:        $script:steps += New-StepResult $stepNumber
 "review-gate" "task type, $r
eviewResponseRelativePath required_changes, 현재 diff 확인" $false $true 1 $implementationGate
.message
scripts\ai-dev-auto-cycle-full.ps1:950:        Stop-Cycle $script:steps $implementationGat
e.reason $false 1
scripts\ai-dev-auto-cycle-full.ps1:953:    if ($reviewGate.decision -ne "pass") {
scripts\ai-dev-auto-cycle-full.ps1:954:        $message = "리뷰 response decision이 pass가 아니므
로 자동 커밋과 complete-task를 실행하지 
않습니다: $($reviewGate.decision)"
scripts\ai-dev-auto-cycle-full.ps1:955:        Save-CycleFailureState "review-gate" $messa
ge $reviewGate



codex
{
  "decision": "pass",
  "severity": "none",
  "summary": "현재 task 요구사항에 맞게 auto-cycle/full 흐름에서 non-implementation revise와 required_ch
anges 누락을 차단하고 실패 사유를 기록한다.",
  "required_changes": [],
  "optional_suggestions": [],
  "scope_check": {
    "within_current_task": true,
    "scope_issues": []
  },
  "test_check": {
    "build_passed": true,
    "test_passed": true,
    "lint_passed": true,
    "issues": [
      "npm run test는 package.json에 test script가 없어 skipped였으나, 현재 저장소 조건상 실행 가능한 테스트가 없습니다
."
    ]
  },
  "next_step": "complete_task"
}
{
  "decision": "pass",
  "severity": "none",
  "summary": "현재 task 요구사항에 맞게 auto-cycle/full 흐름에서 non-implementation revise와 required_changes 누락을 차단하고 실패 사유를 기록한다.",
  "required_changes": [],
  "optional_suggestions": [],
  "scope_check": {
    "within_current_task": true,
    "scope_issues": []
  },
  "test_check": {
    "build_passed": true,
    "test_passed": true,
    "lint_passed": true,
    "issues": [
      "npm run test는 package.json에 test script가 없어 skipped였으나, 현재 저장소 조건상 실행 가능한 테스트가 없습니다."
    ]
  },
  "next_step": "complete_task"
}
tokens used
29,638

```