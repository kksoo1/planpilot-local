# AI Dev Review Prompt

## Role

너는 이 저장소의 엄격한 코드 리뷰어다.

## Review Goal

- 현재 task의 변경사항이 목표와 일치하는지 검토한다.
- 빌드/테스트 결과와 git diff를 함께 검토한다.
- 다음 task 범위까지 미리 구현했는지 확인한다.

## Project Goal

# Goal

AI Dev Loop Codex CLI 완전 자동화 도입

## Background

Codex CLI를 사용해 AI Dev Loop의 구현, 검증, 리뷰, 커밋, task 완료 처리를 가능한 한 end-to-end로 자동화한다.

`current-task-prompt.md`를 Codex CLI에 전달해 코드 수정을 수행하고, `review-prompt.md`를 Codex CLI에 전달해 JSON 리뷰를 생성한 뒤, `pass`, `revise`, `blocked` 결과에 따라 자동 분기한다.

초기 버전은 안전을 위해 `MaxTasks 1`, 명시적 Allow 옵션, git status clean 확인, package 변경 감지 중단, build 실패 시 commit 금지 정책을 적용한다.

## Success Criteria

- Codex CLI 실행 정책이 문서화된다.
- `current-task-prompt.md`를 Codex CLI에 전달하는 `ai-dev-run-codex.ps1`이 추가된다.
- `review-prompt.md`를 Codex CLI에 전달하고 JSON 리뷰를 저장하는 `ai-dev-run-review-codex.ps1`이 추가된다.
- Codex 구현, build/check, diff, Codex 리뷰, save-review 흐름이 연결된다.
- pass 리뷰에서만 자동 커밋과 complete-task를 수행하는 full cycle 초안이 추가된다.
- git status가 dirty이면 Codex 실행을 중단한다.
- package.json 또는 package-lock.json 변경이 감지되면 자동 커밋하지 않는다.
- build 실패 시 자동 커밋하지 않는다.
- git reset, git clean, npm install은 자동 실행하지 않는다.
- PowerShell 문법 검증이 통과한다.
- 작은 앱 기능 task로 MaxTasks 1 end-to-end 검증이 가능하다.

## Constraints

- Codex CLI는 구현자와 리뷰어로 사용한다.
- GPT API 키 없이 진행한다.
- Cline은 삭제되어 사용하지 않는다.
- Copilot CLI와 gh는 현재 사용하지 않는다.
- 자동화는 명시적 Allow 옵션 없이는 위험한 단계를 실행하지 않는다.
- git status가 dirty이면 Codex 구현 실행을 기본 중단한다.
- package.json/package-lock.json 변경이 감지되면 자동 커밋하지 않는다.
- build/check 실패 시 자동 커밋하지 않는다.
- git reset, git clean, npm install은 자동 실행하지 않는다.
- src 코드는 각 구현 task에서만 수정한다.

## Out of Scope

- GPT API 직접 호출
- Cline 사용
- Copilot CLI 사용
- gh 또는 GitHub PR 자동 연동
- git push 자동화
- git reset/git clean 같은 destructive git 명령
- npm install 자동 실행
- package 대량 교체
- DB 삭제, 초기화, 복원, 마이그레이션 자동화

## Manual Verification

- Codex CLI 실행 정책이 문서화되어 있다.
- Codex 구현 실행 스크립트가 DryRun과 dirty worktree 중단을 지원한다.
- Codex 리뷰 실행 스크립트가 JSON 리뷰를 저장하고 save-review 흐름과 연결된다.
- full auto-cycle DryRun이 전체 단계를 보여준다.
- full auto-cycle은 MaxTasks 1 제한과 Allow 옵션을 가진다.
- pass 리뷰가 아니면 자동 커밋하지 않는다.
- build 실패 시 자동 커밋하지 않는다.
- package 파일 변경 감지 시 자동 커밋하지 않는다.
- PowerShell 문법 검증이 통과한다.
- 작은 task로 MaxTasks 1 end-to-end 검증이 가능하다.


## Current Task

- Task ID: T005
- Title: 자동 커밋과 task 완료 연결
- Description: 리뷰 결과가 pass일 때만 선택 파일 커밋과 complete-task를 수행하도록 full auto-cycle에 연결한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- T004
- Verification:
- pass가 아니면 commit하지 않는지 확인
- build 실패 시 commit하지 않는지 확인
- package 파일 변경 감지 시 중단하는지 확인
- complete-task가 pass 이후에만 실행되는지 확인
- PowerShell 문법 검증

## Test Result

# AI Dev Test Result

## 2026-06-07 23:04:20

- Overall result: passed
- Current task: T005
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
dist/assets/index-C8DmBEYa.js   315.70 kB │ gzip: 99.56 kB

[32m✓ built in 583ms[39m
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

2026-06-07 23:04:31

## Git Status

```text
 M .ai-dev/README.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-auto-cycle-full.ps1
?? .ai-dev/codex-result.md
```

## Unstaged Diff Stat

```text
 .ai-dev/README.md                  |  19 +++-
 .ai-dev/state.json                 |   4 +-
 scripts/ai-dev-auto-cycle-full.ps1 | 190 ++++++++++++++++++++++++++++++++++---
 3 files changed, 194 insertions(+), 19 deletions(-)
```

## Unstaged Diff

```text
diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 5bf9253..53d98da 100644
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -668,9 +668,9 @@ powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -Dr
 
 ### full auto-cycle 초안
 
-`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict review prompt 생성, Codex JSON 리뷰와 save-review 흐름을 순서대로 연결하는 초안이다.
+`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict review prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 선택 파일 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.
 
-T004 버전의 실행 단계:
+T005 버전의 실행 단계:
 
 1. `ai-dev-make-prompt.ps1`
 2. `ai-dev-run-codex.ps1`
@@ -678,6 +678,11 @@ T004 버전의 실행 단계:
 4. `ai-dev-save-diff.ps1`
 5. `ai-dev-make-review-prompt.ps1 -Strict`
 6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`
+7. 리뷰 게이트 확인: `state.lastCommandStatus`가 `passed`이고 `state.lastReviewDecision`이 `pass`여야 한다.
+8. package 파일 변경 게이트 확인: `package.json` 또는 `package-lock.json` 변경이 있으면 자동 커밋하지 않는다.
+9. `-AllowCommit`과 `-CommitFiles`가 있을 때만 `ai-dev-commit.ps1 -Files`를 실행한다.
+10. 커밋 결과 게이트 확인: `state.lastCommand`가 `commit`이고 `lastCommitHash`가 있어야 한다.
+11. 커밋 성공 후에만 `ai-dev-complete-task.ps1`을 실행한다.
 
 먼저 DryRun으로 전체 단계를 확인한다. DryRun은 하위 스크립트를 실제 실행하지 않는다.
 
@@ -691,7 +696,7 @@ powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Dry
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -Json
 ```
 
-기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, T004 초안은 task 완료 처리를 하지 않으므로 실제로는 현재 task 한 개만 다룬다.
+기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, 초기 full cycle은 안전을 위해 현재 task 한 개만 다룬다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -MaxSteps 20
@@ -709,13 +714,19 @@ Codex 구현과 Codex 리뷰까지 이어가려면 `-AllowCodex`와 `-AllowRevie
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks 1
 ```
 
+리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`과 `-CommitFiles`를 함께 지정한다. full cycle은 안전을 위해 선택 파일 목록이 없으면 자동 커밋하지 않는다.
+
+```powershell
+powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTasks 1
+```
+
 dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-codex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -AllowDirty -MaxTasks 1
 ```
 
-`-AllowCommit` 옵션은 T004에서 파라미터와 출력만 제공한다. 실제 `ai-dev-commit.ps1` 실행과 `ai-dev-complete-task.ps1` 연결은 T005에서 구현한다. 따라서 T004 full auto-cycle은 리뷰 저장 후에도 git add, git commit, complete-task를 수행하지 않는다.
+리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 complete-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `package-lock.json` 변경이 감지되면 `package_files_changed`로 중단한다. 커밋 스크립트가 변경사항 없음 등으로 실제 commit hash를 기록하지 못하면 `commit_not_confirmed`로 중단하고 complete-task를 실행하지 않는다.
 
 ### 목표 입력 기반 자동 실행
 
diff --git a/.ai-dev/state.json b/.ai-dev/state.json
index af12da6..d5b47d5 100644
--- a/.ai-dev/state.json
+++ b/.ai-dev/state.json
@@ -4,13 +4,13 @@
     "currentLoop":  0,
     "maxLoopsPerTask":  2,
     "repeatedFailureCount":  0,
-    "lastCommand":  "complete-task",
+    "lastCommand":  "npm run build",
     "lastCommandStatus":  "passed",
     "lastErrorSummary":  "",
     "lastReviewDecision":  "not_started",
     "lastReviewSeverity":  "",
     "lastCommitHash":  null,
     "startedAt":  "2026-06-07T19:59:48.1282711+09:00",
-    "updatedAt":  "2026-06-07T13:57:13.9217915+00:00",
+    "updatedAt":  "2026-06-07T14:04:20.8981275+00:00",
     "stopReason":  null
 }
\ No newline at end of file
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49ea..effe1a6 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -6,7 +6,8 @@
     [switch]$AllowCodex,
     [switch]$AllowReviewCodex,
     [switch]$AllowCommit,
-    [switch]$AllowDirty
+    [switch]$AllowDirty,
+    [string[]]$CommitFiles
 )
 
 . $PSScriptRoot\ai-dev-env.ps1
@@ -14,8 +15,10 @@
 $repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
 $queueRelativePath = ".ai-dev/queue.json"
 $stateRelativePath = ".ai-dev/state.json"
+$reviewResponseRelativePath = ".ai-dev/review-response.json"
 $queuePath = Join-Path $repoRoot $queueRelativePath
 $statePath = Join-Path $repoRoot $stateRelativePath
+$reviewResponsePath = Join-Path $repoRoot $reviewResponseRelativePath
 
 function Test-HasValue {
     param(
@@ -141,9 +144,6 @@ function Write-CycleResult {
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,71 @@ function Get-ScriptPath {
     return $scriptPath
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
+function Test-PackageFileChanged {
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.json") "git status --porcelain -- package.json package-lock.json"
+    return -not [string]::IsNullOrWhiteSpace($status)
+}
+
+function Get-ReviewGate {
+    $state = Read-JsonFile $statePath $stateRelativePath
+    $nextStep = $null
+
+    if (Test-Path -LiteralPath $reviewResponsePath -PathType Leaf) {
+        $reviewResponse = Read-JsonFile $reviewResponsePath $reviewResponseRelativePath
+
+        if (Test-HasValue $reviewResponse.next_step) {
+            $nextStep = [string]$reviewResponse.next_step
+        }
+    }
+
+    return [PSCustomObject][ordered]@{
+        lastCommandStatus = [string]$state.lastCommandStatus
+        decision = [string]$state.lastReviewDecision
+        nextStep = $nextStep
+    }
+}
+
+function Get-CommitArguments {
+    $arguments = @()
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
+
+        if ($normalizedFiles.Count -gt 0) {
+            $arguments += "-Files"
+            $arguments += ($normalizedFiles -join ",")
+        }
+    }
+
+    return $arguments
+}
+
+function Get-CommitGate {
+    $state = Read-JsonFile $statePath $stateRelativePath
+
+    return [PSCustomObject][ordered]@{
+        lastCommand = [string]$state.lastCommand
+        lastCommandStatus = [string]$state.lastCommandStatus
+        lastCommitHash = [string]$state.lastCommitHash
+    }
+}
+
 Set-Location $repoRoot
 
 $script:steps = @()
@@ -249,6 +314,8 @@ try {
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Message
@@ -261,7 +328,12 @@ $plannedSteps = @(
     "check",
     "save-diff",
     "make-review-prompt",
-    "run-review-codex"
+    "run-review-codex",
+    "review-gate",
+    "package-change-gate",
+    "commit",
+    "commit-result-gate",
+    "complete-task"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -269,14 +341,14 @@ if ($plannedSteps.Count -gt $MaxSteps) {
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 task 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cycle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +375,7 @@ $stepNumber++
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +386,103 @@ if (-not $AllowReviewCodex) {
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirty", "-SaveReview")
+$stepNumber++
+
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "DryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
+}
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
+
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_step 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $false 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-commit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -AllowCommit -CommitFiles <files> -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+
+if ($commitArguments.Count -eq 0) {
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -Files <files>" $false $true 1 "자동 커밋에는 선택 파일 목록이 필요합니다. -CommitFiles scripts/example.ps1,.ai-dev/README.md 형식으로 지정하세요."
+    Stop-Cycle $script:steps "commit_files_required" $false 1
+}
+
+$commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
+if ($commitArguments.Count -gt 0) {
+    $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
+}
+
+Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
+$stepNumber++
+
+try {
+    $commitGate = Get-CommitGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHash 확인" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
+}
+
+if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -not (Test-HasValue $commitGate.lastCommitHash)) {
+    $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastCommand), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCommitHash)"
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHash 확인" $false $true 1 $message
+    Stop-Cycle $script:steps "commit_not_confirmed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHash 확인" $false $false 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-ResultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```

## Skipped Generated AI Dev Artifact Diffs

- .ai-dev/current-task-prompt.md
- .ai-dev/test-result.md

## Review Criteria

- 현재 task 요구사항을 충족했는가
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