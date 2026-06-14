# Codex Review Result

## Run

- Started at: 2026-06-14 21:47:52
- Ended at: 2026-06-14 21:49:26
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
    + CategoryInfo          : NotSpecified: (OpenAI Codex v0.133.0:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 
--------
workdir: D:\ai-apps\planpilot-local
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: medium
reasoning summaries: none
session id: 019ec62c-9b62-7e03-bd81-de7c33b98a01
--------
user
Read and follow the full review prompt at this absolute file path: D:\ai-apps\planpilot-local\.a
i-dev\review-prompt.md
codex
`.ai-dev\review-prompt.md`의 지시를 먼저 읽고, 그 안의 범위와 출력 형식에 맞춰 진행하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\review-prompt.md'" in D:\ai-apps\planpilot-local
 succeeded in 989ms:
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
AI Dev Loop의 리뷰 결과가 pass인 경우 구현 변경사항 커밋, task 완료 처리, 메타 상태 커밋까지 자동으로 이어지도록 개선한다.

## 배경
현재 AI Dev Loop pass 이후에도 사용자가 후속 완료 명령과 정리 절차를 수동으로 진행해야 하는 흐름이 남아 있다. pass 결과를 신뢰할 수 있는 완료 신호로 
사용해, 구현 커밋 해시를 완료 처리에 전달하고 최종 메타 상태까지 기록되도록 한다.

## 성공 기준
- 리뷰 결과가 pass일 때 구현 변경사항이 자동 커밋된다.
- 생성된 구현 커밋 해시가 complete-task 흐름에 전달된다.
- task 완료 처리 후 변경된 .ai-dev 메타 상태가 별도 커밋으로 기록된다.
- 정상 종료 시 goal completed 상태가 확인 가능하다.
- pass가 아닌 리뷰 결과에서는 자동 완료 처리가 실행되지 않는다.

## 제약사항
- 기존 AI Dev Loop 흐름과 파일 구조를 우선 사용한다.
- 한 번에 하나의 작은 구현 변경으로 처리한다.
- 사용자 변경사항을 되돌리지 않는다.
- 앱의 로컬 우선 동작 원칙을 유지한다.

## 범위 제외
- 리뷰 판단 로직 자체의 기준 변경은 제외한다.
- 대규모 구조 재작성은 제외한다.
- 새로운 외부 연동 기능 추가는 제외한다.

## 수동 검증
- pass 결과를 반환하는 로컬 루프 시나리오에서 자동 커밋과 완료 처리가 순서대로 실행되는지 확인한다.
- pass가 아닌 결과에서 자동 완료 처리가 건너뛰어지는지 확인한다.
- 종료 후 .ai-dev 상태 파일이 완료 상태를 반영하는지 확인한다.

## Current Task

- Task ID: T001
- Title: pass 이후 자동 완료 흐름 구현
- Description: AI Dev Loop 리뷰 결과가 pass일 때 구현 변경사항 커밋, complete-task 호출, .ai-dev 메타 상태 커밋이 순서대로 실
행되도록 기존 루프 흐름에 최소 변경을 적용한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- pass 리뷰 결과 시 구현 커밋 해시가 complete-task에 전달되는지 확인한다.
- task 완료 후 .ai-dev 메타 상태 커밋이 생성되는지 확인한다.
- pass가 아닌 리뷰 결과에서는 자동 완료 처리가 실행되지 않는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-06-14 21:42:19

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
dist/assets/index-D00vtd0_.js   316.25 kB │ gzip: 99.81 kB

[32m✓ built in 482ms[39m
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
---

## Manual executable verification: pass 이후 자동 완료 처리

### 1. auto-cycle-full DryRun output

`	ext
Step 1: task-start
  Command: MaxTasks=1
  Executed: False
  Skipped: False
  Exit code: 0
  Message: ?꾩옱 task ?ㅽ뻾 ?쒖옉: T001 pass ?댄썑 ?먮룞 ?꾨즺 ?먮쫫 援ы쁽
Step 2: make-prompt
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: ?섏쐞 ?ㅽ겕由쏀듃瑜??ㅽ뻾?섏? ?딆븯?듬땲??
Step 3: run-codex
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: ?섏쐞 ?ㅽ겕由쏀듃瑜??ㅽ뻾?섏? ?딆븯?듬땲??
Step 4: check
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: ?섏쐞 ?ㅽ겕由쏀듃瑜??ㅽ뻾?섏? ?딆븯?듬땲??
Step 5: save-diff
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: ?섏쐞 ?ㅽ겕由쏀듃瑜??ㅽ뻾?섏? ?딆븯?듬땲??
Step 6: make-review-prompt
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Stric
t
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: ?섏쐞 ?ㅽ겕由쏀듃瑜??ㅽ뻾?섏? ?딆븯?듬땲??
Step 7: run-review-codex
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDi
rty -SaveReview
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: ?섏쐞 ?ㅽ겕由쏀듃瑜??ㅽ뻾?섏? ?딆븯?듬땲??
Step 8: review-gate
  Command: state.lastReviewDecision ?뺤씤
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: 由щ럭 pass ?щ?瑜??ㅼ젣 ?곹깭?먯꽌 ?쎌? ?딆븯?듬땲??
Step 9: package-change-gate
  Command: git status --porcelain -- package.json package-lock.json
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: package ?뚯씪 蹂寃??щ?瑜??뺤씤?섏? ?딆븯?듬땲??
Step 10: commit
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: git add/commit???ㅽ뻾?섏? ?딆븯?듬땲??
Step 11: commit-result-gate
  Command: state.lastCommand/lastCommitHash ?뺤씤
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: ?ㅼ젣 而ㅻ컠 ?앹꽦 ?щ?瑜??뺤씤?섏? ?딆븯?듬땲??
Step 12: complete-task
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSumm
ary "?먮룞 ?꾨즺: Codex 援ы쁽, build/check, Codex 由щ럭 pass, ?먮룞 而ㅻ컠 ?꾨즺" -CommitHash <commit-hash>
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: task ?꾨즺 泥섎━瑜??ㅽ뻾?섏? ?딆븯?듬땲??
Step 13: meta-commit
  Command: direct meta commit: git add scoped .ai-dev files, git commit -m 'chore(ai-dev): recor
d task completion', git status --short
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: .ai-dev 硫뷀? ?곹깭 吏곸젒 而ㅻ컠???ㅽ뻾?섏? ?딆븯?듬땲??
Stopped reason: dry_run
Completed: False
Exit code: 0

`"
"


`	ext
Current action: make_revise_prompt
Reason: 由щ럭?먯꽌 ?섏젙???꾩슂?섎떎怨??먯젙?덉뒿?덈떎.
Current task: T001 pass ?댄썑 ?먮룞 ?꾨즺 ?먮쫫 援ы쁽
Goal status: in_progress
Last command/status: save-review / passed
Last review decision/severity: revise / low
Git changed files count: 14
Git implementation changed files count: 3
Recommended command:
  - powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1
Additional note:
  - required changes留?諛섏쁺?섏꽭??

`"
"


`	ext
Syntax OK: .\scripts\ai-dev-auto-cycle-full.ps1
Syntax OK: .\scripts\ai-dev-commit.ps1
Syntax OK: .\scripts\ai-dev-next.ps1

`"
"


`	ext

> planpilot-local@0.0.0 lint
> eslint .


`"
"


- DryRun 출력에서 commit, commit-result-gate, complete-task -CommitHash, meta-commit 단계가 포함되는 것을 확인했
습니다.
- ai-dev-next 출력에서 Git changed files count와 Git implementation changed files count가 분리되어 표시되는 것을
 확인했습니다.
- PowerShell parser 기준 세 스크립트 모두 Syntax OK입니다.
- npm run lint는 오류 없이 종료되었습니다.
- 현재 non-pass 상태에서는 ai-dev-next가 make_revise_prompt를 추천하므로 자동 커밋/complete-task/meta-commit으로 진행하
지 않는 것을 확인했습니다.
- pass 경로는 review pass 이후 구현 커밋 해시를 complete-task -CommitHash로 전달하고, 이후 .ai-dev 운영 산출물을 meta-com
mit한 뒤 git status --short로 clean 여부를 검증하도록 구성되어 있습니다.


## Diff To Review

# AI Dev Diff

## Generated At

2026-06-14 21:47:47

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
 M scripts/ai-dev-commit.ps1
 M scripts/ai-dev-next.ps1
```

## App Change Files

- scripts/ai-dev-auto-cycle-full.ps1
- scripts/ai-dev-commit.ps1
- scripts/ai-dev-next.ps1

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

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니
다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-auto-cycle-full.ps1 | 136 ++++++++++++++++++++++++++++++++++++-
 scripts/ai-dev-commit.ps1          |  68 ++++++++++++++-----
 scripts/ai-dev-next.ps1            |  80 +++++++++++++++++++---
 3 files changed, 254 insertions(+), 30 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index a1eb93a..7e86eff 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -16,6 +16,7 @@ $repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
 $queueRelativePath = ".ai-dev/queue.json"
 $stateRelativePath = ".ai-dev/state.json"
 $reviewResponseRelativePath = ".ai-dev/review-response.json"
+$aiDevOperationalRoot = ".ai-dev/"
 $queuePath = Join-Path $repoRoot $queueRelativePath
 $statePath = Join-Path $repoRoot $stateRelativePath
 $reviewResponsePath = Join-Path $repoRoot $reviewResponseRelativePath
@@ -248,6 +249,61 @@ function Test-PackageFileChanged {
     return -not [string]::IsNullOrWhiteSpace($status)
 }
 
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
+function Test-IsAiDevOperationalPath {
+    param(
+        [string]$RelativePath
+    )
+
+    $normalizedRelativePath = $RelativePath.Replace('\', '/')
+    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]:
:OrdinalIgnoreCase)
+}
+
+function Get-ChangedNonAiDevFiles {
+    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
+    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace(
$_) })
+
+    return @(
+        $changeLines |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            Where-Object { (Test-HasValue $_) -and -not (Test-IsAiDevOperationalPath $_) } |
+            Select-Object -Unique
+    )
+}
+
+function Get-ChangedAiDevOperationalFiles {
+    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
+    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace(
$_) })
+
+    return @(
+        $changeLines |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            Where-Object { (Test-HasValue $_) -and (Test-IsAiDevOperationalPath $_) } |
+            Select-Object -Unique
+    )
+}
+
 function Get-ReviewGate {
     $state = Read-JsonFile $statePath $stateRelativePath
     $nextStep = $null
@@ -277,11 +333,69 @@ function Get-CommitArguments {
             $arguments += "-Files"
             $arguments += ($normalizedFiles -join ",")
         }
+
+        return $arguments
+    }
+
+    $implementationFiles = Get-ChangedNonAiDevFiles
+
+    if ($implementationFiles.Count -gt 0) {
+        $arguments += "-Files"
+        $arguments += ($implementationFiles -join ",")
     }
 
     return $arguments
 }
 
+function Invoke-DirectMetaCommit {
+    param(
+        [int]$StepNumber
+    )
+
+    $command = "direct meta commit: git add scoped .ai-dev files, git commit -m 'chore(ai-dev):
 record task completion', git status --short"
+
+    try {
+        $changedAiDevFiles = Get-ChangedAiDevOperationalFiles
+
+        if ($changedAiDevFiles.Count -eq 0) {
+            $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName
 "git status --short"
+
+            if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
+                throw ".ai-dev 메타 변경사항은 없지만 worktree에 변경 파일이 남아 있습니다.`n$remainingStatus"
+            }
+
+            $script:steps += New-StepResult $StepNumber "meta-commit" $command $false $true 0 "
.ai-dev 메타 상태 변경사항이 없어 meta commit을 건너뜁니다. worktree clean."
+            return
+        }
+
+        $addOutput = & git add -- $changedAiDevFiles 2>&1 | Out-String
+        $addExitCode = $LASTEXITCODE
+
+        if ($addExitCode -ne 0) {
+            throw "git add 실행에 실패했습니다. exit code: $addExitCode`n$addOutput"
+        }
+
+        $commitOutput = & git commit -m "chore(ai-dev): record task completion" -- $changedAiDe
vFiles 2>&1 | Out-String
+        $commitExitCode = $LASTEXITCODE
+
+        if ($commitExitCode -ne 0) {
+            throw "git commit 실행에 실패했습니다. exit code: $commitExitCode`n$commitOutput"
+        }
+
+        $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "gi
t status --short"
+
+        if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
+            throw "meta commit 이후 worktree에 변경 파일이 남아 있습니다.`n$remainingStatus"
+        }
+
+        $message = ($commitOutput.Trim(), "worktree clean") -join "`n"
+        $script:steps += New-StepResult $StepNumber "meta-commit" $command $true $false 0 $mess
age
+    } catch {
+        $script:steps += New-StepResult $StepNumber "meta-commit" $command $true $false 1 $_.Ex
ception.Message
+        Stop-Cycle $script:steps "meta_commit_failed" $false 1
+    }
+}
+
 function Get-CommitGate {
     param(
         [string]$PreviousHeadCommitHash
@@ -367,6 +481,7 @@ try {
 }
 
 $plannedSteps = @(
+    "task-start",
     "make-prompt",
     "run-codex",
     "check",
@@ -377,7 +492,8 @@ $plannedSteps = @(
     "package-change-gate",
     "commit",
     "commit-result-gate",
-    "complete-task"
+    "complete-task",
+    "meta-commit"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -482,6 +598,8 @@ while ($completedTaskCount -lt $MaxTasks) {
         $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/las
tCommitHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
         $stepNumber++
         $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolic
y Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"자동 완료: Codex 구현, build/check, C
odex 리뷰 pass, 자동 커밋 완료`" -CommitHash <commit-hash>" $false $true 0 "DryRun: task 완료 처리를 실행하지 않았습
니다."
+        $stepNumber++
+        $script:steps += New-StepResult $stepNumber "meta-commit" "direct meta commit: git add 
scoped .ai-dev files, git commit -m 'chore(ai-dev): record task completion', git status --short"
 $false $true 0 "DryRun: .ai-dev 메타 상태 직접 커밋을 실행하지 않았습니다."
         Stop-Cycle $script:steps "dry_run" $false 0
     }
 
@@ -538,6 +656,12 @@ while ($completedTaskCount -lt $MaxTasks) {
     }
 
     $commitArguments = Get-CommitArguments
+
+    if ($commitArguments.Count -eq 0) {
+        $script:steps += New-StepResult $stepNumber "commit" "git status --porcelain" $false $t
rue 1 "커밋할 구현 변경사항이 없어 complete-task를 실행하지 않습니다."
+        Stop-Cycle $script:steps "no_implementation_changes" $false 1
+    }
+
     $commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
     if ($commitArguments.Count -gt 0) {
         $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
@@ -572,7 +696,17 @@ while ($completedTaskCount -lt $MaxTasks) {
     $resultSummary = "자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료"
     Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File s
cripts/ai-dev-complete-task.ps1 -ResultSummary `"$resultSummary`" -CommitHash $($commitGate.last
CommitHash)" $scriptPaths.completeTask @("-ResultSummary", $resultSummary, "-CommitHash", $commi
tGate.lastCommitHash)
     $stepNumber++
+
+    Invoke-DirectMetaCommit $stepNumber
+    $stepNumber++
+
     $completedTaskCount++
+
+    $stateAfterComplete = Read-JsonFile $statePath $stateRelativePath
+
+    if ($stateAfterComplete.goalStatus -eq "completed") {
+        Stop-Cycle $script:steps "goal_completed" $true 0
+    }
 }
 
 Stop-Cycle $script:steps "max_tasks_reached" $true 0
diff --git a/scripts/ai-dev-commit.ps1 b/scripts/ai-dev-commit.ps1
index 11d1ba9..44338ef 100644
--- a/scripts/ai-dev-commit.ps1
+++ b/scripts/ai-dev-commit.ps1
@@ -123,18 +123,56 @@ function Convert-ToChangedPath {
     )
 
     if ([string]::IsNullOrWhiteSpace($ChangeLine)) {
-        return $null
+        return @()
     }
 
-    if ($ChangeLine.StartsWith("?? ")) {
-        return $ChangeLine.Substring(3)
-    }
+    $pathText = $ChangeLine
 
     if ($ChangeLine.Length -ge 4 -and $ChangeLine.Substring(2, 1) -eq " ") {
-        return $ChangeLine.Substring(3)
+        $pathText = $ChangeLine.Substring(3)
+    }
+
+    if ($pathText.Contains(" -> ")) {
+        return @($pathText -split " -> " | Where-Object { -not [string]::IsNullOrWhiteSpace($_)
 })
     }
 
-    return $ChangeLine
+    return @($pathText)
+}
+
+function Convert-ToRepoPathspec {
+    param(
+        [string]$Pathspec
+    )
+
+    if ([string]::IsNullOrWhiteSpace($Pathspec)) {
+        Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
+    }
+
+    $trimmedPathspec = $Pathspec.Trim()
+    $normalizedPathspec = $trimmedPathspec.Replace('\', '/')
+    $projectRootFullPath = [System.IO.Path]::GetFullPath($projectRoot).TrimEnd('\', '/')
+    $projectRootPrefix = $projectRootFullPath + [System.IO.Path]::DirectorySeparatorChar
+
+    if ([System.IO.Path]::IsPathRooted($trimmedPathspec)) {
+        $fullPath = [System.IO.Path]::GetFullPath($trimmedPathspec)
+    } else {
+        $fullPath = [System.IO.Path]::GetFullPath((Join-Path $projectRoot $normalizedPathspec))
+    }
+
+    if ($fullPath.Equals($projectRootFullPath, [System.StringComparison]::OrdinalIgnoreCase)) {
+        Stop-WithError "저장소 루트 전체는 선택할 수 없습니다: $Pathspec"
+    }
+
+    if (-not $fullPath.StartsWith($projectRootPrefix, [System.StringComparison]::OrdinalIgnoreC
ase)) {
+        Stop-WithError "저장소 밖 파일은 선택할 수 없습니다: $Pathspec"
+    }
+
+    if ([System.IO.Path]::IsPathRooted($trimmedPathspec)) {
+        $relativePath = $fullPath.Substring($projectRootPrefix.Length)
+        return $relativePath.Replace('\', '/')
+    }
+
+    return $normalizedPathspec.TrimStart('/')
 }
 
 function Convert-ToFileList {
@@ -241,17 +279,7 @@ if ($null -ne $Files -and $Files.Count -gt 0) {
             Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
         }
 
-        $normalizedFile = $file.Replace('\', '/')
-        $fullPath = [System.IO.Path]::GetFullPath((Join-Path $projectRoot $normalizedFile))
-        $projectRootPrefix = [System.IO.Path]::GetFullPath($projectRoot).TrimEnd('\', '/') + [S
ystem.IO.Path]::DirectorySeparatorChar
-
-        if (-not $fullPath.StartsWith($projectRootPrefix, [System.StringComparison]::OrdinalIgn
oreCase)) {
-            Stop-WithError "저장소 밖 파일은 선택할 수 없습니다: $file"
-        }
-
-        if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
-            Stop-WithError "선택한 파일이 존재하지 않습니다: $file"
-        }
+        $normalizedFile = Convert-ToRepoPathspec $file
 
         try {
             $fileStatus = Invoke-GitCapture -Arguments @("status", "--porcelain", "--", $normal
izedFile) -DisplayName "git status --porcelain -- $normalizedFile"
@@ -301,7 +329,11 @@ $taskText = if ($null -ne $currentTask) {
     "unknown"
 }
 
-$targetChangedPaths = @($targetChangeLines | ForEach-Object { Convert-ToChangedPath $_ } | Wher
e-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique)
+if ($selectedFiles.Count -gt 0) {
+    $targetChangedPaths = @($selectedFiles | Where-Object { -not [string]::IsNullOrWhiteSpace($
_) } | Select-Object -Unique)
+} else {
+    $targetChangedPaths = @($targetChangeLines | ForEach-Object { Convert-ToChangedPath $_ } | 
Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique)
+}
 $targetAppChangePaths = @($targetChangedPaths | Where-Object { -not (Test-IsAiDevOperationalPat
h $_) })
 $targetAiDevOperationalPaths = @($targetChangedPaths | Where-Object { Test-IsAiDevOperationalPa
th $_ })
 
diff --git a/scripts/ai-dev-next.ps1 b/scripts/ai-dev-next.ps1
index bbb3569..5c2d172 100644
--- a/scripts/ai-dev-next.ps1
+++ b/scripts/ai-dev-next.ps1
@@ -129,6 +129,51 @@ if (Test-HasValue $currentTaskId) {
 
 $gitStatus = "unavailable"
 $gitChangedFilesCount = $null
+$gitImplementationChangedFilesCount = $null
+
+$aiDevOperationalRelativePaths = @(
+    ".ai-dev/state.json",
+    ".ai-dev/queue.json",
+    ".ai-dev/loop-log.md",
+    ".ai-dev/review.md",
+    ".ai-dev/review-response.json",
+    ".ai-dev/diff.md",
+    ".ai-dev/codex-result.md",
+    ".ai-dev/codex-review-result.md",
+    ".ai-dev/current-task-prompt.md",
+    ".ai-dev/test-result.md"
+)
+
+function ConvertTo-GitRelativePath {
+    param(
+        [string]$Path
+    )
+
+    return ($Path -replace "\\", "/").Trim()
+}
+
+function Test-IsAiDevOperationalPath {
+    param(
+        [string]$Path
+    )
+
+    $normalizedPath = ConvertTo-GitRelativePath $Path
+    return $normalizedPath -eq ".ai-dev" -or $normalizedPath -like ".ai-dev/*" -or $aiDevOperat
ionalRelativePaths -contains $normalizedPath
+}
+
+function Get-GitStatusPaths {
+    param(
+        [string]$StatusLine
+    )
+
+    $pathText = $StatusLine.Substring(3).Trim()
+
+    if ($pathText -like "* -> *") {
+        return @($pathText -split " -> " | ForEach-Object { ConvertTo-GitRelativePath $_ })
+    }
+
+    return @(ConvertTo-GitRelativePath $pathText)
+}
 
 try {
     $null = & git rev-parse --show-toplevel 2>&1
@@ -137,7 +182,16 @@ try {
         $gitOutput = & git status --porcelain 2>&1 | Out-String
 
         if ($LASTEXITCODE -eq 0) {
-            $gitChangedFilesCount = @($gitOutput -split "`r?`n" | Where-Object { -not [string]:
:IsNullOrWhiteSpace($_) }).Count
+            $gitChangedFiles = @($gitOutput -split "`r?`n" | Where-Object { -not [string]::IsNu
llOrWhiteSpace($_) })
+            $gitImplementationChangedFiles = @(
+                $gitChangedFiles | Where-Object {
+                    $changedPaths = @(Get-GitStatusPaths $_)
+                    @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) }).C
ount -gt 0
+                }
+            )
+
+            $gitChangedFilesCount = $gitChangedFiles.Count
+            $gitImplementationChangedFilesCount = $gitImplementationChangedFiles.Count
             $gitStatus = "available"
         }
     }
@@ -159,6 +213,8 @@ $lastReviewSeverity = if (Test-HasValue $state.lastReviewSeverity) { [string
]$st
 $lastCommitHash = if (Test-HasValue $state.lastCommitHash) { [string]$state.lastCommitHash } el
se { "" }
 $hasGitChanges = $gitStatus -eq "available" -and $gitChangedFilesCount -gt 0
 $hasNoGitChanges = $gitStatus -eq "available" -and $gitChangedFilesCount -eq 0
+$hasImplementationGitChanges = $gitStatus -eq "available" -and $gitImplementationChangedFilesCo
unt -gt 0
+$hasNoImplementationGitChanges = $gitStatus -eq "available" -and $gitImplementationChangedFiles
Count -eq 0
 $reviewNotStarted = Test-IsReviewNotStarted $lastReviewDecision
 $isCheckCommand = Test-IsCheckCommand $lastCommand
 
@@ -180,31 +236,31 @@ if (-not (Test-HasValue $currentTaskId) -and $goalStatus -eq "completed") 
{
     ) @(
         $(if ($revisePromptExists) { "기존 revise-prompt.md는 현재 리뷰 기준으로 덮어씁니다." } else { "require
d changes만 반영하세요." })
     )
-} elseif ($lastReviewDecision -eq "pass" -and $lastCommandStatus -eq "passed" -and $hasGitChang
es) {
+} elseif ($lastReviewDecision -eq "pass" -and $lastCommandStatus -eq "passed" -and $hasImplemen
tationGitChanges) {
     $nextAction = New-NextAction "commit" "검증과 리뷰가 통과했고 커밋할 변경사항이 있습니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
     ) @("먼저 ai-dev-commit.ps1 -DryRun으로 커밋 대상을 확인하는 것을 권장합니다.")
-} elseif ($lastReviewDecision -eq "pass" -and (Test-HasValue $lastCommitHash) -and $hasNoGitCha
nges) {
-    $nextAction = New-NextAction "complete_task" "리뷰와 커밋이 완료되었고 작업 트리가 깨끗합니다." @(
-        'powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSumma
ry "리뷰 및 커밋 완료"'
-    ) @("다음 pending task로 이동하기 전에 현재 task 결과를 확인하세요.")
-} elseif ($hasNoGitChanges -and ($lastCommand -eq "" -or $lastCommand -eq "init" -or $lastComma
nd -eq "current-task")) {
+} elseif ($lastReviewDecision -eq "pass" -and (Test-HasValue $lastCommitHash) -and $hasNoImplem
entationGitChanges -and $lastCommand -eq "commit" -and $lastCommandStatus -eq "passed") {
+    $nextAction = New-NextAction "complete_task" "리뷰와 커밋이 완료되었고 남은 구현 변경사항이 없습니다." @(
+        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSumma
ry `"리뷰 및 커밋 완료`" -CommitHash $lastCommitHash"
+    ) @("완료 처리 시 구현 커밋 해시를 함께 전달하세요.")
+} elseif ($hasNoImplementationGitChanges -and ($lastCommand -eq "" -or $lastCommand -eq "init" 
-or $lastCommand -eq "current-task")) {
     $nextAction = New-NextAction "run_codex_or_cline" "현재 task 프롬프트는 준비되었고 아직 변경사항이 없습니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1"
     ) @("current-task-prompt.md를 Codex 또는 Cline에 전달해 현재 task를 수행하세요.")
-} elseif ($hasGitChanges -and $lastCommand -eq "save-diff" -and $reviewNotStarted -and -not $re
viewPromptExists) {
+} elseif ($hasImplementationGitChanges -and $lastCommand -eq "save-diff" -and $reviewNotStarted
 -and -not $reviewPromptExists) {
     $nextAction = New-NextAction "make_review_prompt" "diff가 저장되었고 리뷰 프롬프트가 없습니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict
"
     ) @("현재 diff와 검증 결과를 기준으로 리뷰 프롬프트를 생성하세요.")
-} elseif ($hasGitChanges -and $reviewPromptExists -and $reviewNotStarted) {
+} elseif ($hasImplementationGitChanges -and $reviewPromptExists -and $reviewNotStarted) {
     $nextAction = New-NextAction "ask_gpt_review" "리뷰 프롬프트가 준비되었고 아직 리뷰 결과가 없습니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard
"
     ) @("review-prompt.md 내용을 GPT Chat에 붙여넣고 JSON 리뷰 결과를 받은 뒤 save-review를 실행하세요.")
-} elseif ($hasGitChanges -and $isCheckCommand -and $lastCommandStatus -eq "passed" -and (-not $
diffExists -or $isCheckCommand)) {
+} elseif ($hasImplementationGitChanges -and $isCheckCommand -and $lastCommandStatus -eq "passed
" -and (-not $diffExists -or $isCheckCommand)) {
     $nextAction = New-NextAction "save_diff" "검증이 통과했으며 현재 변경사항의 diff 저장이 필요합니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1"
     ) @("diff 저장 후 리뷰 프롬프트를 생성하세요.")
-} elseif ($hasGitChanges -and ($lastCommandStatus -ne "passed" -or -not $isCheckCommand)) {
+} elseif ($hasImplementationGitChanges -and ($lastCommandStatus -ne "passed" -or -not $isCheckC
ommand)) {
     $nextAction = New-NextAction "run_check" "변경사항이 있으며 최신 검증 통과 상태를 확인해야 합니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly"
     ) @("검증 실패 시 현재 task 범위 안에서만 수정하세요.")
@@ -239,6 +295,7 @@ $output = [ordered]@{
     lastCommitHash = $lastCommitHash
     gitStatus = $gitStatus
     gitChangedFilesCount = $gitChangedFilesCount
+    gitImplementationChangedFilesCount = $gitImplementationChangedFilesCount
     files = [ordered]@{
         currentTaskPromptExists = $currentTaskPromptExists
         testResultExists = $testResultExists
@@ -262,6 +319,7 @@ Write-Host "Goal status: $($output.goalStatus)"
 Write-Host "Last command/status: $($output.lastCommand) / $($output.lastCommandStatus)"
 Write-Host "Last review decision/severity: $($output.lastReviewDecision) / $($output.lastReview
Severity)"
 Write-Host "Git changed files count: $($output.gitChangedFilesCount)"
+Write-Host "Git implementation changed files count: $($output.gitImplementationChangedFilesCoun
t)"
 Write-Host "Recommended command:"
 
 if ($output.recommendedCommands.Count -eq 0) {
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
리뷰 프롬프트의 diff만으로 보이는 흐름은 확인했습니다. 판정 전에 변경된 세 스크립트의 실제 주변 코드를 읽어, diff에서 빠진 호출부와 상태 갱신 방식까지 맞물리는지
 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-commit.ps1'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-cycle-full.ps1'" in D:\ai-apps\planpilot
-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-next.ps1'" in D:\ai-apps\planpilot-local
 succeeded in 1614ms:
param(
    [switch]$Json
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$queuePath = Join-Path $projectRoot $queueRelativePath
$statePath = Join-Path $projectRoot $stateRelativePath

function Stop-WithError {
    param(
        [string]$Message
    )

    Write-Error $Message
    exit 1
}

function Read-JsonFile {
    param(
        [string]$Path,
        [string]$RelativePath
    )

    try {
        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | ConvertFrom-Json
    } catch {
        Stop-WithError "$RelativePath JSON 파싱에 실패했습니다: $($_.Exception.Message)"
    }
}

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

function Test-IsReviewNotStarted {
    param(
        [object]$Decision
    )

    return (-not (Test-HasValue $Decision)) -or $Decision -eq "not_started"
}

function Test-IsCheckCommand {
    param(
        [object]$Command
    )

    if (-not (Test-HasValue $Command)) {
        return $false
    }

    return $Command -eq "check" -or $Command -like "npm run build*" -or $Command -like "npm run 
test*" -or $Command -like "npm run lint*"
}

function New-NextAction {
    param(
        [string]$Action,
        [string]$Reason,
        [string[]]$RecommendedCommands,
        [string[]]$Notes
    )

    return [PSCustomObject]@{
        action = $Action
        reason = $Reason
        recommendedCommands = @($RecommendedCommands)
        notes = @($Notes)
    }
}

foreach ($requiredPath in @($queueRelativePath, $stateRelativePath)) {
    $fullPath = Join-Path $projectRoot $requiredPath

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        Stop-WithError "필수 파일이 없습니다: $requiredPath"
    }
}

$queue = Read-JsonFile $queuePath $queueRelativePath
$state = Read-JsonFile $statePath $stateRelativePath

if (-not ($queue.PSObject.Properties.Name -contains "tasks")) {
    Stop-WithError "$queueRelativePath 필수 필드가 누락되었습니다: tasks"
}

if ($null -eq $queue.tasks -or -not ($queue.tasks -is [System.Collections.IEnumerable])) {
    Stop-WithError "$queueRelativePath tasks 필드는 배열이어야 합니다."
}

$tasks = @($queue.tasks)
$pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Object -First 1
$currentTaskId = $null

if (Test-HasValue $state.currentTaskId) {
    $currentTaskId = [string]$state.currentTaskId
} elseif (Test-HasValue $queue.currentTaskId) {
    $currentTaskId = [string]$queue.currentTaskId
} else {
    $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-Object -Fir
st 1

    if ($null -ne $inProgressTask) {
        $currentTaskId = [string]$inProgressTask.id
    } elseif ($null -ne $pendingTask) {
        $currentTaskId = [string]$pendingTask.id
    }
}

$currentTask = $null

if (Test-HasValue $currentTaskId) {
    $currentTask = $tasks | Where-Object { $_.id -eq $currentTaskId } | Select-Object -First 1
}

$gitStatus = "unavailable"
$gitChangedFilesCount = $null
$gitImplementationChangedFilesCount = $null

$aiDevOperationalRelativePaths = @(
    ".ai-dev/state.json",
    ".ai-dev/queue.json",
    ".ai-dev/loop-log.md",
    ".ai-dev/review.md",
    ".ai-dev/review-response.json",
    ".ai-dev/diff.md",
    ".ai-dev/codex-result.md",
    ".ai-dev/codex-review-result.md",
    ".ai-dev/current-task-prompt.md",
    ".ai-dev/test-result.md"
)

function ConvertTo-GitRelativePath {
    param(
        [string]$Path
    )

    return ($Path -replace "\\", "/").Trim()
}

function Test-IsAiDevOperationalPath {
    param(
        [string]$Path
    )

    $normalizedPath = ConvertTo-GitRelativePath $Path
    return $normalizedPath -eq ".ai-dev" -or $normalizedPath -like ".ai-dev/*" -or $aiDevOperati
onalRelativePaths -contains $normalizedPath
}

function Get-GitStatusPaths {
    param(
        [string]$StatusLine
    )

    $pathText = $StatusLine.Substring(3).Trim()

    if ($pathText -like "* -> *") {
        return @($pathText -split " -> " | ForEach-Object { ConvertTo-GitRelativePath $_ })
    }

    return @(ConvertTo-GitRelativePath $pathText)
}

try {
    $null = & git rev-parse --show-toplevel 2>&1

    if ($LASTEXITCODE -eq 0) {
        $gitOutput = & git status --porcelain 2>&1 | Out-String

        if ($LASTEXITCODE -eq 0) {
            $gitChangedFiles = @($gitOutput -split "`r?`n" | Where-Object { -not [string]::IsNul
lOrWhiteSpace($_) })
            $gitImplementationChangedFiles = @(
                $gitChangedFiles | Where-Object {
                    $changedPaths = @(Get-GitStatusPaths $_)
                    @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) }).Co
unt -gt 0
                }
            )

            $gitChangedFilesCount = $gitChangedFiles.Count
            $gitImplementationChangedFilesCount = $gitImplementationChangedFiles.Count
            $gitStatus = "available"
        }
    }
} catch {
    $gitStatus = "unavailable"
}

$currentTaskPromptExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/current-task-
prompt.md") -PathType Leaf
$testResultExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/test-result.md") -Pa
thType Leaf
$diffExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/diff.md") -PathType Leaf
$reviewPromptExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/review-prompt.md")
 -PathType Leaf
$revisePromptExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/revise-prompt.md")
 -PathType Leaf

$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { "" }
$lastCommand = if (Test-HasValue $state.lastCommand) { [string]$state.lastCommand } else { "" }
$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastCommandSta
tus } else { "" }
$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastReviewDe
cision } else { "" }
$lastReviewSeverity = if (Test-HasValue $state.lastReviewSeverity) { [string]$state.lastReviewSe
verity } else { "" }
$lastCommitHash = if (Test-HasValue $state.lastCommitHash) { [string]$state.lastCommitHash } els
e { "" }
$hasGitChanges = $gitStatus -eq "available" -and $gitChangedFilesCount -gt 0
$hasNoGitChanges = $gitStatus -eq "available" -and $gitChangedFilesCount -eq 0
$hasImplementationGitChanges = $gitStatus -eq "available" -and $gitImplementationChangedFilesCou
nt -gt 0
$hasNoImplementationGitChanges = $gitStatus -eq "available" -and $gitImplementationChangedFilesC
ount -eq 0
$reviewNotStarted = Test-IsReviewNotStarted $lastReviewDecision
$isCheckCommand = Test-IsCheckCommand $lastCommand

$nextAction = $null

if (-not (Test-HasValue $currentTaskId) -and $goalStatus -eq "completed") {
    $nextAction = New-NextAction "goal_completed" "모든 task가 완료되었습니다." @() @("새 goal을 시작하기 전 현재 결
과를 확인하세요.")
} elseif (-not (Test-HasValue $currentTaskId) -and $null -eq $pendingTask) {
    $nextAction = New-NextAction "no_task" "수행할 task가 없습니다." @() @("queue.json과 goal.md를 확인하세요."
)
} elseif (-not $currentTaskPromptExists) {
    $nextAction = New-NextAction "make_task_prompt" "현재 task 프롬프트 파일이 없습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1"
    ) @("프롬프트 생성 후 현재 task만 수행하세요.")
} elseif ($lastReviewDecision -eq "blocked") {
    $nextAction = New-NextAction "stop_for_user" "리뷰가 blocked 상태입니다." @() @("사용자 판단이 필요하므로 자동 진행
을 중단하세요.")
} elseif ($lastReviewDecision -eq "revise") {
    $nextAction = New-NextAction "make_revise_prompt" "리뷰에서 수정이 필요하다고 판정했습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1"
    ) @(
        $(if ($revisePromptExists) { "기존 revise-prompt.md는 현재 리뷰 기준으로 덮어씁니다." } else { "required
 changes만 반영하세요." })
    )
} elseif ($lastReviewDecision -eq "pass" -and $lastCommandStatus -eq "passed" -and $hasImplement
ationGitChanges) {
    $nextAction = New-NextAction "commit" "검증과 리뷰가 통과했고 커밋할 변경사항이 있습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
    ) @("먼저 ai-dev-commit.ps1 -DryRun으로 커밋 대상을 확인하는 것을 권장합니다.")
} elseif ($lastReviewDecision -eq "pass" -and (Test-HasValue $lastCommitHash) -and $hasNoImpleme
ntationGitChanges -and $lastCommand -eq "commit" -and $lastCommandStatus -eq "passed") {
    $nextAction = New-NextAction "complete_task" "리뷰와 커밋이 완료되었고 남은 구현 변경사항이 없습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummar
y `"리뷰 및 커밋 완료`" -CommitHash $lastCommitHash"
    ) @("완료 처리 시 구현 커밋 해시를 함께 전달하세요.")
} elseif ($hasNoImplementationGitChanges -and ($lastCommand -eq "" -or $lastCommand -eq "init" -
or $lastCommand -eq "current-task")) {
    $nextAction = New-NextAction "run_codex_or_cline" "현재 task 프롬프트는 준비되었고 아직 변경사항이 없습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1"
    ) @("current-task-prompt.md를 Codex 또는 Cline에 전달해 현재 task를 수행하세요.")
} elseif ($hasImplementationGitChanges -and $lastCommand -eq "save-diff" -and $reviewNotStarted 
-and -not $reviewPromptExists) {
    $nextAction = New-NextAction "make_review_prompt" "diff가 저장되었고 리뷰 프롬프트가 없습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict"
    ) @("현재 diff와 검증 결과를 기준으로 리뷰 프롬프트를 생성하세요.")
} elseif ($hasImplementationGitChanges -and $reviewPromptExists -and $reviewNotStarted) {
    $nextAction = New-NextAction "ask_gpt_review" "리뷰 프롬프트가 준비되었고 아직 리뷰 결과가 없습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard"
    ) @("review-prompt.md 내용을 GPT Chat에 붙여넣고 JSON 리뷰 결과를 받은 뒤 save-review를 실행하세요.")
} elseif ($hasImplementationGitChanges -and $isCheckCommand -and $lastCommandStatus -eq "passed"
 -and (-not $diffExists -or $isCheckCommand)) {
    $nextAction = New-NextAction "save_diff" "검증이 통과했으며 현재 변경사항의 diff 저장이 필요합니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1"
    ) @("diff 저장 후 리뷰 프롬프트를 생성하세요.")
} elseif ($hasImplementationGitChanges -and ($lastCommandStatus -ne "passed" -or -not $isCheckCo
mmand)) {
    $nextAction = New-NextAction "run_check" "변경사항이 있으며 최신 검증 통과 상태를 확인해야 합니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly"
    ) @("검증 실패 시 현재 task 범위 안에서만 수정하세요.")
} elseif ($diffExists -and $reviewNotStarted -and -not $reviewPromptExists) {
    $nextAction = New-NextAction "make_review_prompt" "저장된 diff가 있고 리뷰 프롬프트가 없습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict"
    ) @("리뷰 프롬프트 생성 후 GPT 리뷰를 요청하세요.")
} elseif ($reviewPromptExists -and $reviewNotStarted) {
    $nextAction = New-NextAction "ask_gpt_review" "리뷰 프롬프트가 준비되었고 아직 리뷰 결과가 없습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard"
    ) @("review-prompt.md 내용을 GPT Chat에 붙여넣고 JSON 리뷰 결과를 받은 뒤 save-review를 실행하세요.")
} else {
    $nextAction = New-NextAction "inspect_status" "다음 행동을 자동으로 확정할 수 없습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1"
    ) @(
        "queue, state, git 상태를 확인하세요.",
        $(if ($gitStatus -eq "unavailable") { "git 상태를 확인할 수 없습니다." } else { "상태 파일과 생성 파일의 최신성을
 확인하세요." }),
        $(if (-not $testResultExists) { "test-result.md가 없습니다." } else { "test-result.md가 있습니다."
 })
    )
}

$output = [ordered]@{
    action = $nextAction.action
    reason = $nextAction.reason
    currentTaskId = if ($null -ne $currentTask) { $currentTask.id } elseif (Test-HasValue $curre
ntTaskId) { $currentTaskId } else { $null }
    currentTaskTitle = if ($null -ne $currentTask) { $currentTask.title } else { "없음" }
    goalStatus = $goalStatus
    lastCommand = $lastCommand
    lastCommandStatus = $lastCommandStatus
    lastReviewDecision = $lastReviewDecision
    lastReviewSeverity = $lastReviewSeverity
    lastCommitHash = $lastCommitHash
    gitStatus = $gitStatus
    gitChangedFilesCount = $gitChangedFilesCount
    gitImplementationChangedFilesCount = $gitImplementationChangedFilesCount
    files = [ordered]@{
        currentTaskPromptExists = $currentTaskPromptExists
        testResultExists = $testResultExists
        diffExists = $diffExists
        reviewPromptExists = $reviewPromptExists
        revisePromptExists = $revisePromptExists
    }
    recommendedCommands = @($nextAction.recommendedCommands)
    notes = @($nextAction.notes)
}

if ($Json) {
    $output | ConvertTo-Json -Depth 20
    exit 0
}

Write-Host "Current action: $($output.action)"
Write-Host "Reason: $($output.reason)"
Write-Host "Current task: $($output.currentTaskId) $($output.currentTaskTitle)"
Write-Host "Goal status: $($output.goalStatus)"
Write-Host "Last command/status: $($output.lastCommand) / $($output.lastCommandStatus)"
Write-Host "Last review decision/severity: $($output.lastReviewDecision) / $($output.lastReviewS
everity)"
Write-Host "Git changed files count: $($output.gitChangedFilesCount)"
Write-Host "Git implementation changed files count: $($output.gitImplementationChangedFilesCount
)"
Write-Host "Recommended command:"

if ($output.recommendedCommands.Count -eq 0) {
    Write-Host "  - 없음"
} else {
    foreach ($command in $output.recommendedCommands) {
        Write-Host "  - $command"
    }
}

Write-Host "Additional note:"
if ($output.notes.Count -eq 0) {
    Write-Host "  - 없음"
} else {
    foreach ($note in $output.notes) {
        Write-Host "  - $note"
    }
}

 succeeded in 1617ms:
param(
    [string]$Message,
    [string[]]$Files,
    [switch]$AllowWithoutPassedCheck,
    [switch]$AllowWithoutPassedReview,
    [switch]$DryRun
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$stateRelativePath = ".ai-dev/state.json"
$queueRelativePath = ".ai-dev/queue.json"
$loopLogRelativePath = ".ai-dev/loop-log.md"
$aiDevOperationalRoot = ".ai-dev/"

$statePath = Join-Path $projectRoot $stateRelativePath
$queuePath = Join-Path $projectRoot $queueRelativePath
$loopLogPath = Join-Path $projectRoot $loopLogRelativePath
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)

function Stop-WithError {
    param(
        [string]$Message
    )

    Write-Error $Message
    exit 1
}

function Read-JsonFile {
    param(
        [string]$Path,
        [string]$RelativePath
    )

    try {
        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | ConvertFrom-Json
    } catch {
        Stop-WithError "$RelativePath JSON 파싱에 실패했습니다: $($_.Exception.Message)"
    }
}

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

function Save-StateResult {
    param(
        [object]$State,
        [string]$Status,
        [string]$ErrorSummary,
        [string]$CommitHash
    )

    Set-ObjectProperty $State "lastCommand" "commit"
    Set-ObjectProperty $State "lastCommandStatus" $Status
    Set-ObjectProperty $State "lastErrorSummary" $ErrorSummary
    Set-ObjectProperty $State "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))

    if (Test-HasValue $CommitHash) {
        Set-ObjectProperty $State "lastCommitHash" $CommitHash
    }

    $stateJson = $State | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)
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

function Test-IsAiDevOperationalPath {
    param(
        [string]$RelativePath
    )

    $normalizedRelativePath = $RelativePath.Replace('\', '/')
    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::
OrdinalIgnoreCase)
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
        return @($pathText -split " -> " | Where-Object { -not [string]::IsNullOrWhiteSpace($_) 
})
    }

    return @($pathText)
}

function Convert-ToRepoPathspec {
    param(
        [string]$Pathspec
    )

    if ([string]::IsNullOrWhiteSpace($Pathspec)) {
        Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
    }

    $trimmedPathspec = $Pathspec.Trim()
    $normalizedPathspec = $trimmedPathspec.Replace('\', '/')
    $projectRootFullPath = [System.IO.Path]::GetFullPath($projectRoot).TrimEnd('\', '/')
    $projectRootPrefix = $projectRootFullPath + [System.IO.Path]::DirectorySeparatorChar

    if ([System.IO.Path]::IsPathRooted($trimmedPathspec)) {
        $fullPath = [System.IO.Path]::GetFullPath($trimmedPathspec)
    } else {
        $fullPath = [System.IO.Path]::GetFullPath((Join-Path $projectRoot $normalizedPathspec))
    }

    if ($fullPath.Equals($projectRootFullPath, [System.StringComparison]::OrdinalIgnoreCase)) {
        Stop-WithError "저장소 루트 전체는 선택할 수 없습니다: $Pathspec"
    }

    if (-not $fullPath.StartsWith($projectRootPrefix, [System.StringComparison]::OrdinalIgnoreCa
se)) {
        Stop-WithError "저장소 밖 파일은 선택할 수 없습니다: $Pathspec"
    }

    if ([System.IO.Path]::IsPathRooted($trimmedPathspec)) {
        $relativePath = $fullPath.Substring($projectRootPrefix.Length)
        return $relativePath.Replace('\', '/')
    }

    return $normalizedPathspec.TrimStart('/')
}

function Convert-ToFileList {
    param(
        [string[]]$Paths
    )

    if ($null -eq $Paths -or $Paths.Count -eq 0) {
        return @("  - 없음")
    }

    return @($Paths | ForEach-Object { "  - $_" })
}

foreach ($requiredPath in @($stateRelativePath, $queueRelativePath, $loopLogRelativePath)) {
    $fullPath = Join-Path $projectRoot $requiredPath

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        Stop-WithError "필수 파일이 없습니다: $requiredPath"
    }
}

try {
    $null = Invoke-GitCapture -Arguments @("rev-parse", "--show-toplevel") -DisplayName "git rev
-parse --show-toplevel"
} catch {
    Stop-WithError "현재 위치가 git repository가 아닙니다."
}

$queue = Read-JsonFile $queuePath $queueRelativePath
$state = Read-JsonFile $statePath $stateRelativePath

if (-not ($queue.PSObject.Properties.Name -contains "tasks")) {
    Stop-WithError "$queueRelativePath 필수 필드가 누락되었습니다: tasks"
}

if ($null -eq $queue.tasks -or -not ($queue.tasks -is [System.Collections.IEnumerable])) {
    Stop-WithError "$queueRelativePath tasks 필드는 배열이어야 합니다."
}

$tasks = @($queue.tasks)
$currentTaskId = $null

if (Test-HasValue $state.currentTaskId) {
    $currentTaskId = [string]$state.currentTaskId
} elseif (Test-HasValue $queue.currentTaskId) {
    $currentTaskId = [string]$queue.currentTaskId
} else {
    $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-Object -Fir
st 1

    if ($null -ne $inProgressTask) {
        $currentTaskId = [string]$inProgressTask.id
    } else {
        $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Object -First 
1

        if ($null -ne $pendingTask) {
            $currentTaskId = [string]$pendingTask.id
        }
    }
}

$currentTask = $null

if (Test-HasValue $currentTaskId) {
    $currentTask = $tasks | Where-Object { $_.id -eq $currentTaskId } | Select-Object -First 1
}

if ($null -eq $currentTask) {
    Write-Warning "현재 task를 찾지 못했습니다. 기본 커밋 메시지를 사용할 수 있습니다."
}

if (-not $AllowWithoutPassedCheck -and $state.lastCommandStatus -ne "passed") {
    Stop-WithError "state.lastCommandStatus가 passed가 아닙니다. 검증 결과를 확인하거나 -AllowWithoutPassedCheck
를 사용하세요."
}

if (-not $AllowWithoutPassedReview -and $state.lastReviewDecision -ne "pass") {
    Stop-WithError "state.lastReviewDecision이 pass가 아닙니다. 리뷰 결과를 확인하거나 -AllowWithoutPassedReview
를 사용하세요."
}

try {
    $statusPorcelain = Invoke-GitCapture -Arguments @("status", "--porcelain") -DisplayName "git
 status --porcelain"
} catch {
    Stop-WithError $_.Exception.Message
}

$changeLines = @($statusPorcelain -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSp
ace($_) })

if ($changeLines.Count -eq 0) {
    Write-Host "커밋할 변경사항 없음"
    exit 0
}

$selectedFiles = @()
$targetChangeLines = $changeLines

if ($null -ne $Files -and $Files.Count -gt 0) {
    $requestedFiles = @($Files | ForEach-Object { $_ -split "," } | Where-Object { -not [string]
::IsNullOrWhiteSpace($_) })

    if ($requestedFiles.Count -eq 0) {
        Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
    }

    foreach ($file in $requestedFiles) {
        if ([string]::IsNullOrWhiteSpace($file)) {
            Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
        }

        $normalizedFile = Convert-ToRepoPathspec $file

        try {
            $fileStatus = Invoke-GitCapture -Arguments @("status", "--porcelain", "--", $normali
zedFile) -DisplayName "git status --porcelain -- $normalizedFile"
        } catch {
            Stop-WithError $_.Exception.Message
        }

        if ([string]::IsNullOrWhiteSpace($fileStatus)) {
            Stop-WithError "선택한 파일에 커밋할 변경사항이 없습니다: $file"
        }

        $selectedFiles += $normalizedFile
    }

    $selectedFiles = @($selectedFiles | Select-Object -Unique)
    $targetChangeLines = @($selectedFiles)

    try {
        $stagedFiles = Invoke-GitCapture -Arguments @("diff", "--cached", "--name-only") -Displa
yName "git diff --cached --name-only"
    } catch {
        Stop-WithError $_.Exception.Message
    }

    $stagedFileList = @($stagedFiles -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhit
eSpace($_) })
    $unexpectedStagedFiles = @($stagedFileList | Where-Object { $selectedFiles -notcontains $_ }
)

    if ($unexpectedStagedFiles.Count -gt 0) {
        Stop-WithError "선택 파일 외에 이미 staged 된 파일이 있습니다: $($unexpectedStagedFiles -join ', ')"
    }
}

$commitMessage = if (Test-HasValue $Message) {
    $Message
} elseif ($null -ne $currentTask -and (Test-HasValue $currentTask.commitMessage)) {
    [string]$currentTask.commitMessage
} elseif ($null -ne $currentTask) {
    "chore(ai-dev): complete $($currentTask.id) $($currentTask.title)"
} else {
    "chore(ai-dev): automated task commit"
}

$taskText = if ($null -ne $currentTask) {
    "$($currentTask.id) $($currentTask.title)"
} elseif (Test-HasValue $currentTaskId) {
    "$currentTaskId unknown"
} else {
    "unknown"
}

if ($selectedFiles.Count -gt 0) {
    $targetChangedPaths = @($selectedFiles | Where-Object { -not [string]::IsNullOrWhiteSpace($_
) } | Select-Object -Unique)
} else {
    $targetChangedPaths = @($targetChangeLines | ForEach-Object { Convert-ToChangedPath $_ } | W
here-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique)
}
$targetAppChangePaths = @($targetChangedPaths | Where-Object { -not (Test-IsAiDevOperationalPath
 $_) })
$targetAiDevOperationalPaths = @($targetChangedPaths | Where-Object { Test-IsAiDevOperationalPat
h $_ })

if ($DryRun) {
    Write-Host "Dry run: git add/commit을 실행하지 않습니다."
    Write-Host "커밋 메시지: $commitMessage"
    Write-Host "현재 task: $taskText"
    Write-Host "커밋 대상 앱 변경 파일:"
    foreach ($line in (Convert-ToFileList $targetAppChangePaths)) {
        Write-Host $line
    }
    Write-Host "커밋 대상 AI Dev 운영 산출물:"
    foreach ($line in (Convert-ToFileList $targetAiDevOperationalPaths)) {
        Write-Host $line
    }
    Write-Host "앱 변경 파일 수: $($targetAppChangePaths.Count)"
    Write-Host "AI Dev 운영 산출물 수: $($targetAiDevOperationalPaths.Count)"
    Write-Host "전체 변경 파일 수: $($targetChangedPaths.Count)"
    exit 0
}

try {
    if ($selectedFiles.Count -gt 0) {
        $addOutput = & git add -- @selectedFiles 2>&1 | Out-String
        $addDisplayName = "git add -- <selected files>"
    } else {
        $addOutput = & git add -A 2>&1 | Out-String
        $addDisplayName = "git add -A"
    }

    if ($LASTEXITCODE -ne 0) {
        throw "$addDisplayName 실행에 실패했습니다. exit code: $LASTEXITCODE`n$addOutput"
    }

    if ($selectedFiles.Count -gt 0) {
        $stagedFilesAfterAdd = Invoke-GitCapture -Arguments @("diff", "--cached", "--name-only")
 -DisplayName "git diff --cached --name-only"
        $stagedFileListAfterAdd = @($stagedFilesAfterAdd -split "`r?`n" | Where-Object { -not [s
tring]::IsNullOrWhiteSpace($_) })
        $unexpectedStagedFilesAfterAdd = @($stagedFileListAfterAdd | Where-Object { $selectedFil
es -notcontains $_ })

        if ($unexpectedStagedFilesAfterAdd.Count -gt 0) {
            throw "선택 파일 외의 staged 파일이 감지되었습니다: $($unexpectedStagedFilesAfterAdd -join ', ')"
        }
    }

    $commitOutput = & git commit -m $commitMessage 2>&1 | Out-String

    if ($LASTEXITCODE -ne 0) {
        throw "git commit 실행에 실패했습니다. exit code: $LASTEXITCODE`n$commitOutput"
    }

    $commitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-pars
e HEAD"
} catch {
    $errorSummary = $_.Exception.Message
    Save-StateResult $state "failed" $errorSummary $null
    Stop-WithError "자동 커밋에 실패했습니다: $errorSummary"
}

Save-StateResult $state "passed" "" $commitHash

$logTimestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$logEntry = @"

## $logTimestamp - Commit created

- Task: $taskText
- Commit: $commitHash
- Message: $commitMessage
"@

[System.IO.File]::AppendAllText($loopLogPath, $logEntry, $utf8WithBom)

Write-Host "커밋 메시지: $commitMessage"
Write-Host "커밋 해시: $commitHash"
Write-Host "앱 변경 파일 수: $($targetAppChangePaths.Count)"
Write-Host "AI Dev 운영 산출물 수: $($targetAiDevOperationalPaths.Count)"
Write-Host "전체 변경 파일 수: $($targetChangedPaths.Count)"
Write-Host "현재 task: $taskText"

 succeeded in 1747ms:
param(
    [int]$MaxTasks = 1,
    [int]$MaxSteps = 20,
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowCodex,
    [switch]$AllowReviewCodex,
    [switch]$AllowCommit,
    [switch]$AllowDirty,
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
        $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-Object 
-First 1

        if ($null -ne $inProgressTask) {
            $currentTaskId = [string]$inProgressTask.id
        } else {
            $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Object -Fi
rst 1

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

function Invoke-CycleCommand {
    param(
        [int]$StepNumber,
        [string]$Name,
        [string]$Command,
        [string]$ScriptPath,
        [string[]]$Arguments
    )

    if ($DryRun) {
        $script:steps += New-StepResult $StepNumber $Name $Command $false $true 0 "DryRun: 하위 스크
립트를 실행하지 않았습니다."
        return
    }

    $output = & powershell -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1 | Out-Strin
g
    $exitCode = $LASTEXITCODE
    $message = $output.Trim()

    if ([string]::IsNullOrWhiteSpace($message)) {
        $message = "완료"
    }

    $script:steps += New-StepResult $StepNumber $Name $Command $true $false $exitCode $message

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
    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.j
son") "git status --porcelain -- package.json package-lock.json"
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

function Test-IsAiDevOperationalPath {
    param(
        [string]$RelativePath
    )

    $normalizedRelativePath = $RelativePath.Replace('\', '/')
    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::
OrdinalIgnoreCase)
}

function Get-ChangedNonAiDevFiles {
    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($
_) })

    return @(
        $changeLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            Where-Object { (Test-HasValue $_) -and -not (Test-IsAiDevOperationalPath $_) } |
            Select-Object -Unique
    )
}

function Get-ChangedAiDevOperationalFiles {
    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($
_) })

    return @(
        $changeLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            Where-Object { (Test-HasValue $_) -and (Test-IsAiDevOperationalPath $_) } |
            Select-Object -Unique
    )
}

function Get-ReviewGate {
    $state = Read-JsonFile $statePath $stateRelativePath
    $nextStep = $null

    if (Test-Path -LiteralPath $reviewResponsePath -PathType Leaf) {
        $reviewResponse = Read-JsonFile $reviewResponsePath $reviewResponseRelativePath

        if (Test-HasValue $reviewResponse.next_step) {
            $nextStep = [string]$reviewResponse.next_step
        }
    }

    return [PSCustomObject][ordered]@{
        lastCommandStatus = [string]$state.lastCommandStatus
        decision = [string]$state.lastReviewDecision
        nextStep = $nextStep
    }
}

function Get-CommitArguments {
    $arguments = @()

    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -n
ot [string]::IsNullOrWhiteSpace($_) })

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

    $command = "direct meta commit: git add scoped .ai-dev files, git commit -m 'chore(ai-dev): 
record task completion', git status --short"

    try {
        $changedAiDevFiles = Get-ChangedAiDevOperationalFiles

        if ($changedAiDevFiles.Count -eq 0) {
            $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName 
"git status --short"

            if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
                throw ".ai-dev 메타 변경사항은 없지만 worktree에 변경 파일이 남아 있습니다.`n$remainingStatus"
            }

            $script:steps += New-StepResult $StepNumber "meta-commit" $command $false $true 0 ".
ai-dev 메타 상태 변경사항이 없어 meta commit을 건너뜁니다. worktree clean."
            return
        }

        $addOutput = & git add -- $changedAiDevFiles 2>&1 | Out-String
        $addExitCode = $LASTEXITCODE

        if ($addExitCode -ne 0) {
            throw "git add 실행에 실패했습니다. exit code: $addExitCode`n$addOutput"
        }

        $commitOutput = & git commit -m "chore(ai-dev): record task completion" -- $changedAiDev
Files 2>&1 | Out-String
        $commitExitCode = $LASTEXITCODE

        if ($commitExitCode -ne 0) {
            throw "git commit 실행에 실패했습니다. exit code: $commitExitCode`n$commitOutput"
        }

        $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "git
 status --short"

        if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
            throw "meta commit 이후 worktree에 변경 파일이 남아 있습니다.`n$remainingStatus"
        }

        $message = ($commitOutput.Trim(), "worktree clean") -join "`n"
        $script:steps += New-StepResult $StepNumber "meta-commit" $command $true $false 0 $messa
ge
    } catch {
        $script:steps += New-StepResult $StepNumber "meta-commit" $command $true $false 1 $_.Exc
eption.Message
        Stop-Cycle $script:steps "meta_commit_failed" $false 1
    }
}

function Get-CommitGate {
    param(
        [string]$PreviousHeadCommitHash
    )

    $state = Read-JsonFile $statePath $stateRelativePath
    $lastCommitHash = if (Test-HasValue $state.lastCommitHash) { [string]$state.lastCommitHash }
 else { $null }
    $headCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-
parse HEAD"
    $commitHashChanged = (Test-HasValue $headCommitHash) -and $headCommitHash -ne $PreviousHeadC
ommitHash
    $commitHashMatchesHead = (Test-HasValue $lastCommitHash) -and $lastCommitHash -eq $headCommi
tHash

    if ($state.lastCommand -eq "commit" -and $state.lastCommandStatus -eq "passed" -and $commitH
ashChanged -and -not $commitHashMatchesHead) {
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
        Stop-Cycle $script:steps "goal_completed" $true 0
    }

    if (-not ($queue.PSObject.Properties.Name -contains "tasks") -or $null -eq $queue.tasks) {
        Stop-Cycle $script:steps "no_task" $false 0
    }

    $currentTask = Get-CurrentTask $queue $state

    if ($null -eq $currentTask) {
        Stop-Cycle $script:steps "no_task" $false 0
    }

    if ($currentTask.status -eq "done") {
        Stop-Cycle $script:steps "current_task_done" $true 0
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
    }
} catch {
    $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Me
ssage
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
    "meta-commit"
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
        $script:steps += New-StepResult $stepNumber "load-task" "state/queue 확인" $false $false 1
 $_.Exception.Message
        Stop-Cycle $script:steps "load_task_failed" $false 1
    }

    if ($state.goalStatus -eq "completed") {
        Stop-Cycle $script:steps "goal_completed" $true 0
    }

    if ($null -eq $currentTask) {
        Stop-Cycle $script:steps "no_task" $false 0
    }

    if ($currentTask.status -eq "done") {
        Stop-Cycle $script:steps "current_task_done" $true 0
    }

    $taskLabel = "$($currentTask.id) $($currentTask.title)"
    $script:steps += New-StepResult $stepNumber "task-start" "MaxTasks=$MaxTasks" $false $false 
0 "현재 task 실행 시작: $taskLabel"
    $stepNumber++

    Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
    $stepNumber++

    if (-not $AllowCodex -and -not $DryRun) {
        $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 
-AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
        if ($AllowDirty) {
            $command = "$command -AllowDirty"
        }

        if ($AllowCommit) {
            $command = "$command -AllowCommit"
        }

        if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
            $command = "$command -CommitFiles $($CommitFiles -join ',')"
        }

        $script:steps += New-StepResult $stepNumber "run-codex" "powershell -ExecutionPolicy Byp
ass -File scripts/ai-dev-run-codex.ps1" $false $true 1 "Codex 구현 실행에는 -AllowCodex가 필요합니다. 추천 명령:
 $command"
        Stop-Cycle $script:steps "allow_codex_required" $false 1
    }

    $runCodexArguments = @()
    if ($AllowDirty) {
        $runCodexArguments += "-AllowDirty"
    }

    Invoke-CycleCommand $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass -File script
s/ai-dev-run-codex.ps1" $scriptPaths.runCodex $runCodexArguments
    $stepNumber++

    Invoke-CycleCommand $stepNumber "check" "powershell -ExecutionPolicy Bypass -File scripts/ai
-dev-check.ps1 -BuildOnly" $scriptPaths.check @("-BuildOnly")
    $stepNumber++

    Invoke-CycleCommand $stepNumber "save-diff" "powershell -ExecutionPolicy Bypass -File script
s/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
    $stepNumber++

    Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -Fi
le scripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
    $stepNumber++

    if (-not $AllowReviewCodex -and -not $DryRun) {
        $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 
-AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
        if ($AllowDirty) {
            $command = "$command -AllowDirty"
        }

        if ($AllowCommit) {
            $command = "$command -AllowCommit"
        }

        if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
            $command = "$command -CommitFiles $($CommitFiles -join ',')"
        }

        $script:steps += New-StepResult $stepNumber "run-review-codex" "powershell -ExecutionPol
icy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 1 "Co
dex 리뷰 실행에는 -AllowReviewCodex가 필요합니다. 추천 명령: $command"
        Stop-Cycle $script:steps "allow_review_codex_required" $false 1
    }

    Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File
 scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-Al
lowDirty", "-SaveReview")
    $stepNumber++

    if ($DryRun) {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" 
$false $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelai
n -- package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass
 -File scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/last
CommitHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy
 Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"자동 완료: Codex 구현, build/check, Co
dex 리뷰 pass, 자동 커밋 완료`" -CommitHash <commit-hash>" $false $true 0 "DryRun: task 완료 처리를 실행하지 않았습니
다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "meta-commit" "direct meta commit: git add s
coped .ai-dev files, git commit -m 'chore(ai-dev): record task completion', git status --short" 
$false $true 0 "DryRun: .ai-dev 메타 상태 직접 커밋을 실행하지 않았습니다."
        Stop-Cycle $script:steps "dry_run" $false 0
    }

    try {
        $reviewGate = Get-ReviewGate
    } catch {
        $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $fa
lse $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "review_gate_failed" $false 1
    }

    if ($reviewGate.lastCommandStatus -ne "passed") {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $
false $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
        Stop-Cycle $script:steps "review_save_not_passed" $false 1
    }

    if ($reviewGate.decision -ne "pass") {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" 
$false $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)
"
        Stop-Cycle $script:steps "review_not_pass" $false 0
    }

    if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath n
ext_step 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: 
$($reviewGate.nextStep)"
        Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
    }

    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fal
se $false 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
    $stepNumber++

    try {
        if (Test-PackageFileChanged) {
            $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porc
elain -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감
지되어 자동 커밋하지 않습니다."
            Stop-Cycle $script:steps "package_files_changed" $false 1
        }
    } catch {
        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelai
n -- package.json package-lock.json" $false $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "package_change_gate_failed" $false 1
    }

    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain --
 package.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
    $stepNumber++

    if (-not $AllowCommit) {
        $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-ful
l.ps1 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
        if ($AllowDirty) {
            $commitCommand = "$commitCommand -AllowDirty"
        }

        if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
            $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
        }

        $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass
 -File scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCom
mand"
        Stop-Cycle $script:steps "allow_commit_required" $false 1
    }

    $commitArguments = Get-CommitArguments

    if ($commitArguments.Count -eq 0) {
        $script:steps += New-StepResult $stepNumber "commit" "git status --porcelain" $false $tr
ue 1 "커밋할 구현 변경사항이 없어 complete-task를 실행하지 않습니다."
        Stop-Cycle $script:steps "no_implementation_changes" $false 1
    }

    $commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
    if ($commitArguments.Count -gt 0) {
        $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
    }

    try {
        $preCommitHeadCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayN
ame "git rev-parse HEAD"
    } catch {
        $script:steps += New-StepResult $stepNumber "commit" "git rev-parse HEAD" $false $false 
1 $_.Exception.Message
        Stop-Cycle $script:steps "pre_commit_head_failed" $false 1
    }

    Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArgum
ents
    $stepNumber++

    try {
        $commitGate = Get-CommitGate $preCommitHeadCommitHash
    } catch {
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/last
CommitHash 확인" $false $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
    }

    if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or 
-not $commitGate.commitHashChanged -or -not $commitGate.commitHashMatchesHead) {
        $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastCo
mmand), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCom
mitHash)"
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/last
CommitHash 확인" $false $true 1 $message
        Stop-Cycle $script:steps "commit_not_confirmed" $false 1
    }

    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastComm
itHash 확인" $false $false 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
    $stepNumber++

    $resultSummary = "자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료"
    Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-complete-task.ps1 -ResultSummary `"$resultSummary`" -CommitHash $($commitGate.lastC
ommitHash)" $scriptPaths.completeTask @("-ResultSummary", $resultSummary, "-CommitHash", $commit
Gate.lastCommitHash)
    $stepNumber++

    Invoke-DirectMetaCommit $stepNumber
    $stepNumber++

    $completedTaskCount++

    $stateAfterComplete = Read-JsonFile $statePath $stateRelativePath

    if ($stateAfterComplete.goalStatus -eq "completed") {
        Stop-Cycle $script:steps "goal_completed" $true 0
    }
}

Stop-Cycle $script:steps "max_tasks_reached" $true 0

codex
세 스크립트의 전체 흐름을 확인했습니다. 자동 완료 경로 자체는 추가되어 있지만, 커밋 범위와 `git status --porcelain` 파싱이 실제 Git 출력 형식과 
맞지 않는 지점이 있어 결함 여부를 더 좁혀 보고 있습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-complete-task.ps1'" in D:\ai-apps\planpilot-l
ocal
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -Litera
lPath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-save-diff.ps1' -Pattern 'App Change|Operati
onal|status|porcelain|diff'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -Litera
lPath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-make-review-prompt.ps1' -Pattern 'App Chang
e|Operational|status|porcelain|diff'" in D:\ai-apps\planpilot-local
 succeeded in 1530ms:
param(
    [string]$TaskId,
    [string]$ResultSummary,
    [string]$CommitHash,
    [switch]$NoNext
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$loopLogRelativePath = ".ai-dev/loop-log.md"

$queuePath = Join-Path $projectRoot $queueRelativePath
$statePath = Join-Path $projectRoot $stateRelativePath
$loopLogPath = Join-Path $projectRoot $loopLogRelativePath
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)

function Stop-WithError {
    param(
        [string]$Message
    )

    Write-Error $Message
    exit 1
}

function Read-JsonFile {
    param(
        [string]$Path,
        [string]$RelativePath
    )

    try {
        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | ConvertFrom-Json
    } catch {
        Stop-WithError "$RelativePath JSON 파싱에 실패했습니다: $($_.Exception.Message)"
    }
}

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

function Resolve-ValidatedCommitHash {
    param(
        [string]$Hash
    )

    $commitRevision = "$Hash^{commit}"

    try {
        $resolvedCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "--verify", $commitRev
ision) -DisplayName "git rev-parse --verify $commitRevision"
    } catch {
        Stop-WithError "CommitHash가 실제 commit으로 확인되지 않았습니다: $Hash`n$($_.Exception.Message)"
    }

    try {
        $headCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git 
rev-parse HEAD"
    } catch {
        Stop-WithError "현재 git HEAD를 확인하지 못했습니다: $($_.Exception.Message)"
    }

    if (-not (Test-HasValue $resolvedCommitHash)) {
        Stop-WithError "CommitHash가 빈 값으로 resolve되었습니다: $Hash"
    }

    if (-not (Test-HasValue $headCommitHash)) {
        Stop-WithError "현재 git HEAD가 빈 값으로 확인되었습니다."
    }

    if ($resolvedCommitHash -ne $headCommitHash) {
        Stop-WithError "CommitHash가 현재 git HEAD와 일치하지 않습니다. resolved=$resolvedCommitHash, HEAD=$
headCommitHash"
    }

    return $resolvedCommitHash
}

foreach ($requiredPath in @($queueRelativePath, $stateRelativePath, $loopLogRelativePath)) {
    $fullPath = Join-Path $projectRoot $requiredPath

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        Stop-WithError "필수 파일이 없습니다: $requiredPath"
    }
}

$queue = Read-JsonFile $queuePath $queueRelativePath
$state = Read-JsonFile $statePath $stateRelativePath

if (-not ($queue.PSObject.Properties.Name -contains "tasks")) {
    Stop-WithError "$queueRelativePath 필수 필드가 누락되었습니다: tasks"
}

if ($null -eq $queue.tasks -or -not ($queue.tasks -is [System.Collections.IEnumerable])) {
    Stop-WithError "$queueRelativePath tasks 필드는 배열이어야 합니다."
}

$tasks = @($queue.tasks)
$targetTaskId = $null

if (Test-HasValue $TaskId) {
    $targetTaskId = $TaskId
} elseif (Test-HasValue $state.currentTaskId) {
    $targetTaskId = [string]$state.currentTaskId
} elseif (Test-HasValue $queue.currentTaskId) {
    $targetTaskId = [string]$queue.currentTaskId
} else {
    $fallbackTask = $tasks |
        Where-Object { $_.status -eq "in_progress" -or $_.status -eq "pending" } |
        Select-Object -First 1

    if ($null -ne $fallbackTask) {
        $targetTaskId = [string]$fallbackTask.id
    }
}

if (-not (Test-HasValue $targetTaskId)) {
    Stop-WithError "완료 처리할 task가 없습니다."
}

$completedTask = $tasks | Where-Object { $_.id -eq $targetTaskId } | Select-Object -First 1

if ($null -eq $completedTask) {
    Stop-WithError "완료 처리할 task를 찾을 수 없습니다: $targetTaskId"
}

$now = [DateTimeOffset]::UtcNow.ToString("o")
$summary = if (Test-HasValue $ResultSummary) { $ResultSummary } else { "완료 처리됨" }

Set-ObjectProperty $completedTask "status" "done"
Set-ObjectProperty $completedTask "completedAt" $now

if (Test-HasValue $ResultSummary) {
    Set-ObjectProperty $completedTask "resultSummary" $ResultSummary
}

$nextTask = $null

if (-not $NoNext) {
    $nextTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Object -First 1
}

if ($NoNext) {
    Set-ObjectProperty $queue "currentTaskId" $null
    Set-ObjectProperty $state "currentTaskId" $null
    Set-ObjectProperty $state "goalStatus" "in_progress"
    Set-ObjectProperty $state "stopReason" "manual_next_selection_required"
} elseif ($null -ne $nextTask) {
    Set-ObjectProperty $nextTask "status" "in_progress"
    Set-ObjectProperty $queue "currentTaskId" $nextTask.id
    Set-ObjectProperty $state "currentTaskId" $nextTask.id
    Set-ObjectProperty $state "goalStatus" "in_progress"
    Set-ObjectProperty $state "stopReason" $null
} else {
    Set-ObjectProperty $queue "currentTaskId" $null
    Set-ObjectProperty $state "currentTaskId" $null
    Set-ObjectProperty $state "goalStatus" "completed"
    Set-ObjectProperty $state "stopReason" "all_tasks_completed"
}

Set-ObjectProperty $queue "updatedAt" $now

if (Test-HasValue $CommitHash) {
    $validatedCommitHash = Resolve-ValidatedCommitHash $CommitHash
    Set-ObjectProperty $state "lastCommitHash" $validatedCommitHash
}

Set-ObjectProperty $state "updatedAt" $now
Set-ObjectProperty $state "lastCommand" "complete-task"
Set-ObjectProperty $state "lastCommandStatus" "passed"
Set-ObjectProperty $state "lastErrorSummary" ""

Write-JsonFile $queuePath $queue
Write-JsonFile $statePath $state

$nextTaskText = if ($null -ne $nextTask) {
    "$($nextTask.id) $($nextTask.title)"
} else {
    "없음"
}

$logTimestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$logEntry = @"

## $logTimestamp - Task completed

- Task: $($completedTask.id) $($completedTask.title)
- Result: $summary
- Next task: $nextTaskText
"@

[System.IO.File]::AppendAllText($loopLogPath, $logEntry, $utf8WithBom)

Write-Host "완료 처리된 task: $($completedTask.id) $($completedTask.title)"
Write-Host "다음 task: $nextTaskText"
Write-Host "queue/state 저장 완료"

 succeeded in 1594ms:

scripts\ai-dev-make-review-prompt.ps1:12:$diffRelativePath = ".ai-dev/diff.md"
scripts\ai-dev-make-review-prompt.ps1:19:$diffPath = Join-Path $projectRoot $diffRelativePath
scripts\ai-dev-make-review-prompt.ps1:113:    $diffRelativePath
scripts\ai-dev-make-review-prompt.ps1:126:$diffContent = Get-Content -Raw -Encoding UTF8 -Litera
lPath $diffPath
scripts\ai-dev-make-review-prompt.ps1:134:    "goalStatus",
scripts\ai-dev-make-review-prompt.ps1:153:    $inProgressTask = $tasks | Where-Object { $_.statu
s -eq "in_progress" } |
 Select-Object -First 1
scripts\ai-dev-make-review-prompt.ps1:158:        $pendingTask = $tasks | Where-Object { $_.stat
us -eq "pending" } | Se
lect-Object -First 1
scripts\ai-dev-make-review-prompt.ps1:181:    "status",
scripts\ai-dev-make-review-prompt.ps1:244:- 빌드/테스트 결과와 git diff를 함께 검토한다.
scripts\ai-dev-make-review-prompt.ps1:245:- 리뷰 판단은 `App Change Files`와 diff 본문의 실제 앱 변경 파일을 중심으로
 수행한다.
scripts\ai-dev-make-review-prompt.ps1:259:- Status: $($currentTask.status)
scripts\ai-dev-make-review-prompt.ps1:270:## Diff To Review
scripts\ai-dev-make-review-prompt.ps1:272:$diffContent



 succeeded in 1722ms:

scripts\ai-dev-save-diff.ps1:9:$diffRelativePath = ".ai-dev/diff.md"
scripts\ai-dev-save-diff.ps1:11:$diffPath = Join-Path $projectRoot $diffRelativePath
scripts\ai-dev-save-diff.ps1:14:$aiDevOperationalRoot = ".ai-dev/"
scripts\ai-dev-save-diff.ps1:15:$reviewDiffPathspecExcludes = @(":(exclude).ai-dev/**")
scripts\ai-dev-save-diff.ps1:56:        [string]$Status,
scripts\ai-dev-save-diff.ps1:60:    Set-ObjectProperty $State "lastCommand" "save-diff"
scripts\ai-dev-save-diff.ps1:61:    Set-ObjectProperty $State "lastCommandStatus" $Status
scripts\ai-dev-save-diff.ps1:125:function Test-IsAiDevOperationalPath {
scripts\ai-dev-save-diff.ps1:131:    return $normalizedRelativePath.StartsWith($aiDevOperational
Root, [System.StringCom
parison]::OrdinalIgnoreCase)
scripts\ai-dev-save-diff.ps1:134:function Get-ChangedPathsFromPorcelain {
scripts\ai-dev-save-diff.ps1:136:        [string]$PorcelainStatus
scripts\ai-dev-save-diff.ps1:140:    $statusLines = @($PorcelainStatus -split "`r?`n" | Where-Ob
ject { -not [string]::I
sNullOrWhiteSpace($_) })
scripts\ai-dev-save-diff.ps1:142:    foreach ($line in $statusLines) {
scripts\ai-dev-save-diff.ps1:174:        [string]$PorcelainStatus
scripts\ai-dev-save-diff.ps1:180:    $untrackedLines = @($PorcelainStatus -split "`r?`n" | Where
-Object { $_.StartsWith
("?? ") })
scripts\ai-dev-save-diff.ps1:192:        if (Test-IsAiDevOperationalPath $normalizedRelativePath
) {
scripts\ai-dev-save-diff.ps1:260:    $statusShort = Invoke-GitCapture -Arguments @("status", "--
short") -DisplayName "g
it status --short"
scripts\ai-dev-save-diff.ps1:261:    $statusPorcelain = Invoke-GitCapture -Arguments @("status",
 "--porcelain") -Displa
yName "git status --porcelain"
scripts\ai-dev-save-diff.ps1:262:    $diffPathspecArguments = @("--", ".") + $reviewDiffPathspec
Excludes
scripts\ai-dev-save-diff.ps1:263:    $unstagedStat = Invoke-GitCapture -Arguments (@("diff", "--
stat") + $diffPathspecA
rguments) -DisplayName "git diff --stat"
scripts\ai-dev-save-diff.ps1:264:    $unstagedDiff = Invoke-GitCapture -Arguments (@("diff") + $
diffPathspecArguments) 
-DisplayName "git diff"
scripts\ai-dev-save-diff.ps1:265:    $stagedStat = Invoke-GitCapture -Arguments (@("diff", "--st
aged", "--stat") + $dif
fPathspecArguments) -DisplayName "git diff --staged --stat"
scripts\ai-dev-save-diff.ps1:266:    $stagedDiff = Invoke-GitCapture -Arguments (@("diff", "--st
aged") + $diffPathspecA
rguments) -DisplayName "git diff --staged"
scripts\ai-dev-save-diff.ps1:267:    $changedPaths = Get-ChangedPathsFromPorcelain $statusPorcel
ain
scripts\ai-dev-save-diff.ps1:268:    $appChangePaths = @($changedPaths | Where-Object { -not (Te
st-IsAiDevOperationalPa
th $_) })
scripts\ai-dev-save-diff.ps1:269:    $aiDevOperationalPaths = @($changedPaths | Where-Object { T
est-IsAiDevOperationalP
ath $_ })
scripts\ai-dev-save-diff.ps1:273:        "# AI Dev Diff",
scripts\ai-dev-save-diff.ps1:275:        "## Git Status`r`n`r`n$(Convert-ToCodeBlock $statusShor
t)",
scripts\ai-dev-save-diff.ps1:276:        "## App Change Files`r`n`r`n$(Convert-ToFileList $appCh
angePaths)",
scripts\ai-dev-save-diff.ps1:277:        "## AI Dev Operational Artifact Files`r`n`r`n$(Convert-
ToFileList $aiDevOperat
ionalPaths)",
scripts\ai-dev-save-diff.ps1:278:        "## Review Diff Scope`r`n`r`n아래 diff 본문은 실제 앱 변경 파일 중심으
로 검토하도록 `.ai-dev` 운영 산출
물 diff를 제외합니다. `.ai-dev` 변경은 위 운영 산출물 목록에서 별도로 확인합니다.",
scripts\ai-dev-save-diff.ps1:279:        "## Unstaged Diff Stat`r`n`r`n$(Convert-ToCodeBlock $un
stagedStat)",
scripts\ai-dev-save-diff.ps1:280:        "## Unstaged Diff`r`n`r`n$(Convert-ToCodeBlock $unstage
dDiff)",
scripts\ai-dev-save-diff.ps1:281:        "## Staged Diff Stat`r`n`r`n$(Convert-ToCodeBlock $stag
edStat)",
scripts\ai-dev-save-diff.ps1:282:        "## Staged Diff`r`n`r`n$(Convert-ToCodeBlock $stagedDif
f)"
scripts\ai-dev-save-diff.ps1:286:        $untrackedResult = Get-UntrackedFileSections $repositor
yRoot $statusPorcelain
scripts\ai-dev-save-diff.ps1:295:    $diffContent = $sections -join "`r`n`r`n"
scripts\ai-dev-save-diff.ps1:296:    [System.IO.File]::WriteAllText($diffPath, $diffContent, $ut
f8WithBom)
scripts\ai-dev-save-diff.ps1:300:    Stop-WithError "git diff 저장에 실패했습니다: $($_.Exception.Message
)"
scripts\ai-dev-save-diff.ps1:303:Write-Host "git diff 저장 완료: $diffRelativePath"



codex
`complete-task`는 `-CommitHash`를 받아 HEAD 검증까지 하고 있어 전달 경로는 요구사항과 맞습니다. 남은 판단 포인트는 자동 커밋 대상 수집 로직이
 정상 케이스뿐 아니라 경로/삭제/rename 같은 Git 상태에서 안전하게 동작하는지입니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-save-diff.ps1' | Select-Object -Skip 120 -Fir
st 90" in D:\ai-apps\planpilot-local
 succeeded in 1006ms:

    return "${codeFence}text`r`n$text`r`n$codeFence"
}

function Test-IsAiDevOperationalPath {
    param(
        [string]$RelativePath
    )

    $normalizedRelativePath = $RelativePath.Replace('\', '/')
    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::
OrdinalIgnoreCase)
}

function Get-ChangedPathsFromPorcelain {
    param(
        [string]$PorcelainStatus
    )

    $paths = @()
    $statusLines = @($PorcelainStatus -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhi
teSpace($_) })

    foreach ($line in $statusLines) {
        if ($line.StartsWith("?? ")) {
            $paths += $line.Substring(3)
            continue
        }

        if ($line.Length -lt 4) {
            continue
        }

        $relativePath = $line.Substring(3)
        $paths += $relativePath
    }

    return @($paths | Select-Object -Unique)
}

function Convert-ToFileList {
    param(
        [string[]]$Paths
    )

    if ($null -eq $Paths -or $Paths.Count -eq 0) {
        return "- 없음"
    }

    return ($Paths | ForEach-Object { "- $_" }) -join "`r`n"
}

function Get-UntrackedFileSections {
    param(
        [string]$RepositoryRoot,
        [string]$PorcelainStatus
    )

    $sections = @()
    $skippedGeneratedArtifacts = @()
    $repositoryRootFullPath = [System.IO.Path]::GetFullPath($RepositoryRoot).TrimEnd('\', '/') +
 [System.IO.Path]::DirectorySeparatorChar
    $untrackedLines = @($PorcelainStatus -split "`r?`n" | Where-Object { $_.StartsWith("?? ") })

    foreach ($line in $untrackedLines) {
        $relativePath = $line.Substring(3)
        $sectionTitle = "### $relativePath"
        $normalizedRelativePath = $relativePath.Replace('\', '/')

        if ($relativePath.StartsWith('"') -and $relativePath.EndsWith('"')) {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 따옴표로 인코딩된 경로는 자동 읽기 대상에서 제외합니다."
            continue
        }

        if (Test-IsAiDevOperationalPath $normalizedRelativePath) {
            $skippedGeneratedArtifacts += $relativePath
            continue
        }

        try {
            $fullPath = [System.IO.Path]::GetFullPath((Join-Path $RepositoryRoot $relativePath))
        } catch {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 경로를 해석할 수 없습니다."
            continue
        }

        if (-not $fullPath.StartsWith($repositoryRootFullPath, [System.StringComparison]::Ordina
lIgnoreCase)) {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 저장소 밖 경로입니다."
            continue
        }

        if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 파일이 아니거나 읽을 수 없습니다."

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -Litera
lPath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-run-codex.ps1' -Pattern 'AllowDirty|git sta
tus|porcelain|dirty' -Context 2,3" in D:\ai-apps\planpilot-local
 succeeded in 996ms:

  scripts\ai-dev-run-codex.ps1:2:    [switch]$DryRun,
  scripts\ai-dev-run-codex.ps1:3:    [switch]$Json,
> scripts\ai-dev-run-codex.ps1:4:    [switch]$AllowDirty,
  scripts\ai-dev-run-codex.ps1:5:    [switch]$GeneratePromptIfMissing,
  scripts\ai-dev-run-codex.ps1:6:    [string]$PromptPath = ".ai-dev/current-task-prompt.md",
  scripts\ai-dev-run-codex.ps1:7:    [string]$ResultPath = ".ai-dev/codex-result.md"
  scripts\ai-dev-run-codex.ps1:65:
  scripts\ai-dev-run-codex.ps1:66:function Get-GitStatusLines {
> scripts\ai-dev-run-codex.ps1:67:    $statusOutput = & git status --short 2>&1
  scripts\ai-dev-run-codex.ps1:68:
  scripts\ai-dev-run-codex.ps1:69:    if ($LASTEXITCODE -ne 0) {
> scripts\ai-dev-run-codex.ps1:70:        $message = "git status 확인에 실패했습니다: $($statusOutput -jo
in "`n")"
  scripts\ai-dev-run-codex.ps1:71:        Write-RunResult "run_codex" $false 1 $message
  scripts\ai-dev-run-codex.ps1:72:    }
  scripts\ai-dev-run-codex.ps1:73:
  scripts\ai-dev-run-codex.ps1:93:}
  scripts\ai-dev-run-codex.ps1:94:
> scripts\ai-dev-run-codex.ps1:95:function Test-OnlyAllowedPromptDirty {
  scripts\ai-dev-run-codex.ps1:96:    param(
  scripts\ai-dev-run-codex.ps1:97:        [string[]]$StatusLines,
  scripts\ai-dev-run-codex.ps1:98:        [string]$PromptRelativePath
  scripts\ai-dev-run-codex.ps1:130:$statusLines = @(Get-GitStatusLines)
  scripts\ai-dev-run-codex.ps1:131:
> scripts\ai-dev-run-codex.ps1:132:if ($statusLines.Count -gt 0 -and -not $AllowDirty) {
> scripts\ai-dev-run-codex.ps1:133:    if (-not (Test-OnlyAllowedPromptDirty $statusLines $promp
tRelativePath)) {
> scripts\ai-dev-run-codex.ps1:134:        $dirtyText = ($statusLines -join "`n")
> scripts\ai-dev-run-codex.ps1:135:        $message = "작업 트리가 dirty 상태라 Codex 실행을 중단합니다. 계속하려면 변
경사항을 정리하거나 -AllowDirty를
 명시하세요.`n$dirtyText"
  scripts\ai-dev-run-codex.ps1:136:        Write-RunResult "run_codex" $false 1 $message
  scripts\ai-dev-run-codex.ps1:137:    }
  scripts\ai-dev-run-codex.ps1:138:}
  scripts\ai-dev-run-codex.ps1:171:- Result: $resultRelativePath
  scripts\ai-dev-run-codex.ps1:172:- Command: $commandText
> scripts\ai-dev-run-codex.ps1:173:- AllowDirty: $([bool]$AllowDirty)
> scripts\ai-dev-run-codex.ps1:174:- DirtyCount: $($statusLines.Count)
  scripts\ai-dev-run-codex.ps1:175:"@
  scripts\ai-dev-run-codex.ps1:176:
  scripts\ai-dev-run-codex.ps1:177:    Write-RunResult "run_codex" $false 0 $message



codex
`run-codex`는 기본적으로 dirty worktree를 막고, `-AllowDirty`가 있을 때만 예외를 둡니다. 그래서 자동 커밋이 기존 사용자 변경을 섞을 위험
은 완전히 사라진 것은 아니지만, 이번 변경의 핵심 실패 조건으로 보기는 어렵습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\package.json'" in D:\ai-apps\planpilot-local
 succeeded in 938ms:
{
  "name": "planpilot-local",
  "private": true,
  "version": "0.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc -b && vite build",
    "lint": "eslint .",
    "preview": "vite preview"
  },
  "dependencies": {
    "dexie": "^4.4.2",
    "react": "^19.2.5",
    "react-dom": "^19.2.5",
    "zustand": "^5.0.13"
  },
  "devDependencies": {
    "@eslint/js": "^10.0.1",
    "@types/node": "^24.12.2",
    "@types/react": "^19.2.14",
    "@types/react-dom": "^19.2.3",
    "@vitejs/plugin-react": "^6.0.1",
    "eslint": "^10.2.1",
    "eslint-plugin-react-hooks": "^7.1.1",
    "eslint-plugin-react-refresh": "^0.5.2",
    "globals": "^17.5.0",
    "typescript": "~6.0.2",
    "typescript-eslint": "^8.58.2",
    "vite": "^8.0.10"
  }
}

codex
{
  "decision": "pass",
  "severity": "none",
  "summary": "pass 이후 구현 커밋, CommitHash 전달 complete-task, .ai-dev 메타 커밋 흐름이 기존 스크립트 구조 안에서 최소 변경
으로 구현되었습니다.",
  "required_changes": [],
  "optional_suggestions": [
    {
      "file": "scripts/ai-dev-auto-cycle-full.ps1",
      "suggestion": "DryRun의 commit 단계 표시에도 실제 실행 경로처럼 -Files 범위가 드러나면 수동 검증 로그의 신뢰도가 더 좋아집니다."
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
    "issues": [
      "npm run test는 package.json에 test 스크립트가 없어 BuildOnly 검증에서 skipped로 기록되었습니다."
    ]
  },
  "next_step": "complete_task"
}
tokens used
42,182
{
  "decision": "pass",
  "severity": "none",
  "summary": "pass 이후 구현 커밋, CommitHash 전달 complete-task, .ai-dev 메타 커밋 흐름이 기존 스크립트 구조 안에서 최소 변경으로 구현되었습니다.",
  "required_changes": [],
  "optional_suggestions": [
    {
      "file": "scripts/ai-dev-auto-cycle-full.ps1",
      "suggestion": "DryRun의 commit 단계 표시에도 실제 실행 경로처럼 -Files 범위가 드러나면 수동 검증 로그의 신뢰도가 더 좋아집니다."
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
    "issues": [
      "npm run test는 package.json에 test 스크립트가 없어 BuildOnly 검증에서 skipped로 기록되었습니다."
    ]
  },
  "next_step": "complete_task"
}

```