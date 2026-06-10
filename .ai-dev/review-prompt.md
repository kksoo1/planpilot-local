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
AI Dev Loop에서 커밋 완료 후 `.ai-dev/state.json`의 `lastCommitHash`가 항상 최신 커밋 해시로 기록되도록 개선한다.

## 배경
현재 자동 또는 수동 커밋 흐름이 끝난 뒤 `lastCommitHash`가 비어 있을 수 있어, 후속 단계에서 커밋 결과를 일관되게 추적하기 어렵다. `ai-dev-commit`, `commit-result-gate`, `complete-task` 흐름에서 동일한 기준으로 최신 커밋 해시를 남기도록 정리한다.

## 성공 기준
- 커밋이 성공한 뒤 `.ai-dev/state.json`의 `lastCommitHash`가 null 또는 빈 값으로 남지 않는다.
- `ai-dev-commit`, `commit-result-gate`, `complete-task` 흐름에서 최신 커밋 해시 기록 방식이 일관된다.
- 커밋이 없는 상태나 실패 상태에서는 기존 상태 흐름을 깨뜨리지 않는다.
- 변경 범위가 AI Dev Loop 상태 갱신 로직에 한정된다.

## 제약사항
- 기존 작업 큐와 상태 파일 구조를 유지한다.
- 한 번에 하나의 작은 구현 변경으로 처리한다.
- 사용자가 만든 변경 사항은 되돌리지 않는다.
- 불필요한 대규모 구조 변경은 하지 않는다.

## 범위 제외
- 새로운 기능 화면 추가는 하지 않는다.
- 상태 파일 포맷의 전면 변경은 하지 않는다.
- AI Dev Loop와 직접 관련 없는 앱 기능은 수정하지 않는다.

## 수동 검증
- 커밋 완료 흐름 이후 `.ai-dev/state.json`의 `lastCommitHash`에 최신 커밋 해시가 기록되는지 확인한다.
- 커밋 실패 또는 커밋 없음 상황에서 상태 값이 부정확하게 갱신되지 않는지 확인한다.

## Current Task

- Task ID: T001
- Title: 커밋 해시 상태 기록 흐름 개선
- Description: AI Dev Loop의 커밋 완료 처리 흐름을 확인하고, 자동 또는 수동 커밋 성공 후 `.ai-dev/state.json`의 `lastCommitHash`가 최신 커밋 해시로 남도록 상태 갱신 로직을 보강한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- 커밋 성공 흐름 뒤 `.ai-dev/state.json`의 `lastCommitHash`가 최신 커밋 해시와 일치하는지 확인한다.
- 커밋이 생성되지 않은 흐름에서 `lastCommitHash`가 잘못된 값으로 갱신되지 않는지 확인한다.
- 관련 스크립트의 상태 갱신 경로가 동일한 기준을 사용하는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-06-10 23:31:32

- Overall result: passed
- Current task: T001
- Commands:
  - npm run build: passed
  - npm run test: skipped
  - npm run lint: skipped

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
dist/index.html                   0.46 kB │ gzip:  0.29 kB
dist/assets/index-DvjxWt30.css    5.69 kB │ gzip:  1.93 kB
dist/assets/index-BNHocAt1.js   315.73 kB │ gzip: 99.57 kB

[32m✓ built in 256ms[39m
```
### npm run test

- Status: skipped
- Exit code: 없음

```text
-BuildOnly 옵션으로 건너뛰었습니다.
```
### npm run lint

- Status: skipped
- Exit code: 없음

```text
-BuildOnly 옵션으로 건너뛰었습니다.
```

## Diff To Review

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