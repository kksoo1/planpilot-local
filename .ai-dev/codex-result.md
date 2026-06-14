# Codex Implementation Result

## Run

- Started at: 2026-06-14 20:51:16
- Ended at: 2026-06-14 20:53:06
- Exit code: 0
- Prompt: .ai-dev/current-task-prompt.md
- Command: codex exec <short wrapper pointing to .ai-dev/current-task-prompt.md>

## Output

```text
node.exe : OpenAI Codex v0.133.0
At C:\Users\SECUI\AppData\Roaming\npm\codex.ps1:24 char:5
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
session id: 019ec5f8-c916-7710-bf0e-13ae362a60ac
--------
user
Read and follow the full task prompt at this absolute file path: D:\ai-apps\planpilot-local\.ai-dev\current-task-prompt
.md
codex
작업 프롬프트를 먼저 읽어서 요청 범위와 수정 대상 파일을 확인하겠습니다. 지금은 지정된 `.ai-dev/current-task-prompt.md`만 읽습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath \"D:\\ai-apps\\plan
pilot-local\\.ai-dev\\current-task-prompt.md\"" in D:\ai-apps\planpilot-local
 succeeded in 1022ms:
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
AI Dev Loop의 리뷰 결과가 pass인 경우 구현 변경사항 커밋, task 완료 처리, 메타 상태 커밋까지 자동으로 이어지도록 개선한다.

## 배경
현재 AI Dev Loop pass 이후에도 사용자가 후속 완료 명령과 정리 절차를 수동으로 진행해야 하는 흐름이 남아 있다. pass 결과를 신뢰할 수 있는 완료 신호로 사용해, 구현 커밋 해시를 완료 처리에 전
달하고 최종 메타 상태까지 기록되도록 한다.

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
- Description: AI Dev Loop 리뷰 결과가 pass일 때 구현 변경사항 커밋, complete-task 호출, .ai-dev 메타 상태 커밋이 순서대로 실행되도록 기존 루프 흐름에 최소 변경을 적
용한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

- .ai-dev 관련 루프 실행 스크립트
- complete-task 호출부

## Verification

- pass 리뷰 결과 시 구현 커밋 해시가 complete-task에 전달되는지 확인한다.
- task 완료 후 .ai-dev 메타 상태 커밋이 생성되는지 확인한다.
- pass가 아닌 리뷰 결과에서는 자동 완료 처리가 실행되지 않는지 확인한다.

- 필요한 경우 `npm run build`는 사람이 별도로 실행한다.
- 이 프롬프트는 자동으로 build, test, lint를 실행하라고 지시하지 않는다.

## Required Output

- 변경한 파일 목록
- 구현 또는 분석 내용 요약
- 검증 방법
- 남은 위험
- 다음 task로 넘어가도 되는지 여부
- `.ai-dev/loop-log.md`에 기록할 작업 요약

## Hard Rules

- `src` 외 파일을 수정해야 하는 경우 이유를 기록한다.
- `package.json`과 `package-lock.json`은 수정하지 않는다. 꼭 필요하면 중단하고 이유만 기록한다.
- 실제 DB 삭제 또는 초기화를 하지 않는다.
- 사용자 데이터 복원 또는 덮어쓰기를 하지 않는다.
- 현재 task와 무관한 UI 전면 개편을 하지 않는다.
- 대규모 리팩터링을 하지 않는다.
- git commit을 실행하지 않는다.
- git reset, git checkout, git clean을 실행하지 않는다.
- npm install을 실행하지 않는다.

## Stop Conditions

- 요구사항이 충돌하는 경우
- 현재 task 범위 밖 수정이 필요한 경우
- 패키지 추가가 필요한 경우
- 데이터 삭제 또는 마이그레이션이 필요한 경우
- 같은 오류가 반복되는 경우

codex
프롬프트 기준으로 git 커밋 명령은 실행하지 않습니다. 대신 기존 AI Dev Loop 스크립트 구조를 확인해서 pass 분기 이후에 들어갈 최소 변경 지점을 찾겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'rg --files -g "!.git" -g "!node_modules" -g 
"!dist"' in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'rg -n "complete-task|review|pass|loop|goal c
ompleted|completed" -g "!.git" -g "!node_modules" -g "!dist"' in D:\ai-apps\planpilot-local
 succeeded in 1613ms:
vite.config.ts
tsconfig.node.json
tsconfig.json
tsconfig.app.json
index.html
eslint.config.js
ROADMAP.md
README.md
AGENTS.md
package-lock.json
package.json
public\icons.svg
scripts\ai-dev-copy-review-prompt.ps1
public\favicon.svg
scripts\ai-dev-make-prompt.ps1
memory-bank\productContext.md
scripts\ai-dev-complete-task.ps1
scripts\ai-dev-init.ps1
memory-bank\activeContext.md
memory-bank\progress.md
scripts\ai-dev-commit.ps1
scripts\ai-dev-env.ps1
memory-bank\technicalContext.md
scripts\ai-dev-check.ps1
scripts\ai-dev-current-task.ps1
scripts\ai-dev-auto-step.ps1
scripts\ai-dev-auto-cycle.ps1
scripts\ai-dev-make-revise-prompt.ps1
scripts\ai-dev-auto-goal.ps1
scripts\ai-dev-auto-cycle-full.ps1
scripts\ai-dev-run-codex.ps1
scripts\ai-dev-run-review-codex.ps1
scripts\ai-dev-save-diff.ps1
src\App.tsx
src\App.css
scripts\ai-dev-make-review-prompt.ps1
scripts\ai-dev-status.ps1
scripts\ai-dev-save-review.ps1
scripts\monitor-and-dev-loop.ps1
scripts\ai-dev-manual-cycle.ps1
scripts\ai-dev-next.ps1
src\db.ts
src\store.ts
src\main.tsx
src\index.css
src\types.ts
docs\data-backup-export-policy.md
docs\ai-dev-loop-policy.md
docs\error-loading-state-policy.md
docs\data-import-restore-policy.md
docs\manual-regression-test-result.md
docs\manual-test-checklist.md
src\views\TodayView.tsx
src\views\TasksView.tsx
src\views\SettingsView.tsx
src\views\ProjectsView.tsx
src\components\ProjectForm.tsx
src\components\ProjectCard.tsx
src\components\TaskCard.tsx
src\components\TaskForm.tsx
src\hooks\useProjectFormState.ts
src\hooks\useProjectActions.ts
src\hooks\useTaskFormState.ts
src\hooks\useTaskActions.ts
src\ai\AIProvider.ts
src\ai\RuleBasedAIProvider.ts
src\ai\recommendationScore.ts
src\assets\react.svg
src\assets\hero.png
src\assets\vite.svg
src\utils\importValidation.ts
src\utils\exportData.ts
src\utils\dateUtils.ts
src\utils\projectLookup.ts
src\utils\projectDeletion.ts
src\utils\projectStats.ts
src\utils\taskDates.ts
src\utils\taskSummary.ts
src\utils\taskLabels.ts
src\utils\taskFilters.ts

 exited 1 in 1648ms:
2026-06-14T11:51:34.490298Z ERROR codex_core::tools::router: error=Exit code: 1
Wall time: 1.6 seconds
Output:

codex
`src`가 아니라 AI Dev Loop 자동화 스크립트가 수정 대상입니다. 프롬프트의 Likely Files가 `.ai-dev` 관련 루프 스크립트와 `complete-task` 호출부라서, 해당 스크립트만 좁혀
 읽겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath \"D:\\ai-apps\\plan
pilot-local\\scripts\\ai-dev-auto-cycle-full.ps1\"" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath \"D:\\ai-apps\\plan
pilot-local\\scripts\\ai-dev-auto-cycle.ps1\"" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath \"D:\\ai-apps\\plan
pilot-local\\scripts\\ai-dev-auto-step.ps1\"" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath \"D:\\ai-apps\\plan
pilot-local\\scripts\\ai-dev-complete-task.ps1\"" in D:\ai-apps\planpilot-local
 succeeded in 2213ms:
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
        $resolvedCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "--verify", $commitRevision) -DisplayName "gi
t rev-parse --verify $commitRevision"
    } catch {
        Stop-WithError "CommitHash가 실제 commit으로 확인되지 않았습니다: $Hash`n$($_.Exception.Message)"
    }

    try {
        $headCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-parse HEAD"
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
        Stop-WithError "CommitHash가 현재 git HEAD와 일치하지 않습니다. resolved=$resolvedCommitHash, HEAD=$headCommitHash"
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

 succeeded in 2243ms:
param(
    [switch]$Json,
    [switch]$DryRun,
    [switch]$AllowCheck,
    [switch]$AllowReviewPrompt,
    [switch]$AllowSaveDiff
)

. "$PSScriptRoot\ai-dev-env.ps1"

function Stop-WithJsonError {
    param(
        [string]$Message
    )

    $result = [ordered]@{
        action = "error"
        executed = $false
        dryRun = [bool]$DryRun
        exitCode = 1
        message = $Message
        recommendedCommands = @()
    }

    if ($Json) {
        $result | ConvertTo-Json -Depth 10
    } else {
        Write-Error $Message
    }

    exit 1
}

function New-StepResult {
    param(
        [string]$Action,
        [bool]$Executed,
        [int]$ExitCode,
        [string]$Message,
        [string[]]$RecommendedCommands
    )

    return [ordered]@{
        action = $Action
        executed = $Executed
        dryRun = [bool]$DryRun
        exitCode = $ExitCode
        message = $Message
        recommendedCommands = @($RecommendedCommands)
    }
}

function Invoke-AiDevScript {
    param(
        [string]$ScriptName,
        [string[]]$Arguments
    )

    $scriptPath = Join-Path $PSScriptRoot $ScriptName

    if (-not (Test-Path -LiteralPath $scriptPath -PathType Leaf)) {
        throw "스크립트를 찾을 수 없습니다: $ScriptName"
    }

    $output = & powershell -ExecutionPolicy Bypass -File $scriptPath @Arguments 2>&1 | Out-String
    $exitCode = $LASTEXITCODE

    return [PSCustomObject]@{
        ExitCode = $exitCode
        Output = $output.TrimEnd()
    }
}

function Write-StepResult {
    param(
        [object]$Result
    )

    if ($Json) {
        $Result | ConvertTo-Json -Depth 10
        return
    }

    Write-Host "Action: $($Result.action)"
    Write-Host "Executed: $($Result.executed)"
    Write-Host "Dry run: $($Result.dryRun)"
    Write-Host "Exit code: $($Result.exitCode)"
    Write-Host "Message: $($Result.message)"
    Write-Host "Recommended commands:"

    if ($Result.recommendedCommands.Count -eq 0) {
        Write-Host "  - 없음"
    } else {
        foreach ($command in $Result.recommendedCommands) {
            Write-Host "  - $command"
        }
    }
}

try {
    $nextOutput = & powershell -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "ai-dev-next.ps1") -Json 2>&1 | O
ut-String

    if ($LASTEXITCODE -ne 0) {
        Stop-WithJsonError "ai-dev-next.ps1 실행에 실패했습니다: $nextOutput"
    }

    $next = $nextOutput | ConvertFrom-Json
} catch {
    Stop-WithJsonError "다음 action 판단에 실패했습니다: $($_.Exception.Message)"
}

$action = [string]$next.action
$recommendedCommands = @($next.recommendedCommands)
$commandDisplay = if ($recommendedCommands.Count -gt 0) { $recommendedCommands[0] } else { "" }
$scriptToRun = $null
$scriptArguments = @()
$shouldExecute = $false
$message = ""

switch ($action) {
    "make_task_prompt" {
        $scriptToRun = "ai-dev-make-prompt.ps1"
        $shouldExecute = $true
        $message = "현재 task 프롬프트를 생성합니다."
    }
    "run_check" {
        $scriptToRun = "ai-dev-check.ps1"
        $scriptArguments = @("-BuildOnly")
        $shouldExecute = [bool]$AllowCheck
        $message = if ($AllowCheck) {
            "검증을 실행합니다: ai-dev-check.ps1 -BuildOnly"
        } else {
            "검증 단계는 기본 자동 실행 대상이 아닙니다. 실행하려면 -AllowCheck를 사용하세요."
        }
    }
    "save_diff" {
        $scriptToRun = "ai-dev-save-diff.ps1"
        $scriptArguments = @("-IncludeUntrackedContent")
        $shouldExecute = [bool]$AllowSaveDiff
        $message = if ($AllowSaveDiff) {
            "diff를 저장합니다: ai-dev-save-diff.ps1 -IncludeUntrackedContent"
        } else {
            "diff 저장은 기본 자동 실행 대상이 아닙니다. 실행하려면 -AllowSaveDiff를 사용하세요."
        }
    }
    "make_review_prompt" {
        $scriptToRun = "ai-dev-make-review-prompt.ps1"
        $scriptArguments = @("-Strict")
        $shouldExecute = [bool]$AllowReviewPrompt
        $message = if ($AllowReviewPrompt) {
            "리뷰 프롬프트를 생성합니다: ai-dev-make-review-prompt.ps1 -Strict"
        } else {
            "리뷰 프롬프트 생성은 기본 자동 실행 대상이 아닙니다. 실행하려면 -AllowReviewPrompt를 사용하세요."
        }
    }
    default {
        if ($action -eq "ask_gpt_review") {
            $reviewBridgeCommands = @(
                "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1",
                "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard"
            )
            $result = New-StepResult `
                -Action $action `
                -Executed $false `
                -ExitCode 0 `
                -Message "GPT API는 호출하지 않습니다. review-prompt를 클립보드에 복사해 ChatGPT 웹 화면에 붙여넣고, JSON 리뷰만 받은 뒤 JSON 리뷰를 클립보드에
 복사해 save-review -FromClipboard를 실행하세요." `
                -RecommendedCommands $reviewBridgeCommands
            Write-StepResult $result
            exit 0
        }

        if ($action -eq "goal_completed") {
            $goalCompletedCommands = @(
                "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1"
            )
            $result = New-StepResult `
                -Action $action `
                -Executed $false `
                -ExitCode 0 `
                -Message "현재 goal은 completed 상태입니다. 더 실행할 task가 없습니다. 다음 목표를 시작하려면 .ai-dev/goal.md, .ai-dev/queue.json,
 .ai-dev/state.json을 새 목표로 초기화하세요. 상태 확인 명령: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1" `
                -RecommendedCommands $goalCompletedCommands
            Write-StepResult $result
            exit 0
        }

        $forbiddenActions = @(
            "run_codex_or_cline",
            "ask_gpt_review",
            "make_revise_prompt",
            "commit",
            "complete_task",
            "stop_for_user",
            "blocked",
            "goal_completed",
            "no_task",
            "inspect_status"
        )

        if ($forbiddenActions -contains $action) {
            $result = New-StepResult `
                -Action $action `
                -Executed $false `
                -ExitCode 0 `
                -Message "이 action은 auto-step에서 자동 실행하지 않습니다. 추천 명령 또는 사용자 판단이 필요합니다." `
                -RecommendedCommands $recommendedCommands
            Write-StepResult $result
            exit 0
        }

        $result = New-StepResult `
            -Action $action `
            -Executed $false `
            -ExitCode 0 `
            -Message "알 수 없는 action입니다. 상태를 수동으로 확인하세요." `
            -RecommendedCommands @("powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1")
        Write-StepResult $result
        exit 0
    }
}

if ($DryRun -or -not $shouldExecute) {
    $result = New-StepResult `
        -Action $action `
        -Executed $false `
        -ExitCode 0 `
        -Message $message `
        -RecommendedCommands $(if ([string]::IsNullOrWhiteSpace($commandDisplay)) { @() } else { @($commandDisplay) })
    Write-StepResult $result
    exit 0
}

try {
    $childResult = Invoke-AiDevScript -ScriptName $scriptToRun -Arguments $scriptArguments

    if ($childResult.ExitCode -ne 0) {
        $result = New-StepResult `
            -Action $action `
            -Executed $true `
            -ExitCode $childResult.ExitCode `
            -Message "하위 스크립트 실행에 실패했습니다: $($childResult.Output)" `
            -RecommendedCommands $recommendedCommands
        Write-StepResult $result
        exit 1
    }

    $result = New-StepResult `
        -Action $action `
        -Executed $true `
        -ExitCode 0 `
        -Message $message `
        -RecommendedCommands $recommendedCommands
    Write-StepResult $result
    exit 0
} catch {
    $result = New-StepResult `
        -Action $action `
        -Executed $true `
        -ExitCode 1 `
        -Message "auto-step 실행에 실패했습니다: $($_.Exception.Message)" `
        -RecommendedCommands $recommendedCommands
    Write-StepResult $result
    exit 1
}

 succeeded in 2349ms:
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
        $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-Object -First 1

        if ($null -ne $inProgressTask) {
            $currentTaskId = [string]$inProgressTask.id
        } else {
            $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Object -First 1

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
        $script:steps += New-StepResult $StepNumber $Name $Command $false $true 0 "DryRun: 하위 스크립트를 실행하지 않았습니다."
        return
    }

    $output = & powershell -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1 | Out-String
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
    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.json") "git status --por
celain -- package.json package-lock.json"
    return -not [string]::IsNullOrWhiteSpace($status)
}

function Convert-ToChangedPath {
    param(
        [string]$ChangeLine
    )

    if ([string]::IsNullOrWhiteSpace($ChangeLine)) {
        return $null
    }

    if ($ChangeLine.StartsWith("?? ")) {
        return $ChangeLine.Substring(3)
    }

    if ($ChangeLine.Length -ge 4 -and $ChangeLine.Substring(2, 1) -eq " ") {
        return $ChangeLine.Substring(3)
    }

    return $ChangeLine
}

function Test-IsAiDevOperationalPath {
    param(
        [string]$RelativePath
    )

    $normalizedRelativePath = $RelativePath.Replace('\', '/')
    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::OrdinalIgnoreCase)
}

function Get-ChangedNonAiDevFiles {
    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })

    return @(
        $changeLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            Where-Object { (Test-HasValue $_) -and -not (Test-IsAiDevOperationalPath $_) } |
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
        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -not [string]::IsNullOrWh
iteSpace($_) })

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

    $metaFiles = @(
        ".ai-dev/queue.json",
        ".ai-dev/state.json",
        ".ai-dev/loop-log.md",
        ".ai-dev/test-result.md"
    )
    $command = "direct meta commit: git add scoped .ai-dev files, git commit -m 'chore(ai-dev): record task completion'
, git status --short"
    $changedExistingFiles = @()

    try {
        foreach ($metaFile in $metaFiles) {
            $absolutePath = Join-Path $repoRoot $metaFile

            if (-not (Test-Path -LiteralPath $absolutePath -PathType Leaf)) {
                continue
            }

            $status = Invoke-GitCapture -Arguments @("status", "--porcelain", "--", $metaFile) -DisplayName "git status
 --porcelain -- $metaFile"

            if (-not [string]::IsNullOrWhiteSpace($status)) {
                $changedExistingFiles += $metaFile
            }
        }

        if ($changedExistingFiles.Count -eq 0) {
            $remainingImplementationFiles = Get-ChangedNonAiDevFiles

            if ($remainingImplementationFiles.Count -gt 0) {
                throw "meta commit 대상 변경사항은 없지만 구현 변경 파일이 남아 있습니다.`n$($remainingImplementationFiles -join "`n")"
            }

            $script:steps += New-StepResult $StepNumber "meta-commit" $command $false $true 0 ".ai-dev 메타 상태 변경사항이 없어 m
eta commit을 건너뜁니다."
            return
        }

        $addOutput = & git add -- $changedExistingFiles 2>&1 | Out-String
        $addExitCode = $LASTEXITCODE

        if ($addExitCode -ne 0) {
            throw "git add 실행에 실패했습니다. exit code: $addExitCode`n$addOutput"
        }

        $commitOutput = & git commit -m "chore(ai-dev): record task completion" -- $changedExistingFiles 2>&1 | Out-Str
ing
        $commitExitCode = $LASTEXITCODE

        if ($commitExitCode -ne 0) {
            throw "git commit 실행에 실패했습니다. exit code: $commitExitCode`n$commitOutput"
        }

        $remainingImplementationFiles = Get-ChangedNonAiDevFiles

        if ($remainingImplementationFiles.Count -gt 0) {
            throw "meta commit 이후 구현 변경 파일이 남아 있습니다.`n$($remainingImplementationFiles -join "`n")"
        }

        $message = ($commitOutput.Trim(), "non-.ai-dev implementation files clean") -join "`n"
        $script:steps += New-StepResult $StepNumber "meta-commit" $command $true $false 0 $message
    } catch {
        $script:steps += New-StepResult $StepNumber "meta-commit" $command $true $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "meta_commit_failed" $false 1
    }
}

function Get-CommitGate {
    param(
        [string]$PreviousHeadCommitHash
    )

    $state = Read-JsonFile $statePath $stateRelativePath
    $lastCommitHash = if (Test-HasValue $state.lastCommitHash) { [string]$state.lastCommitHash } else { $null }
    $headCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-parse HEAD"
    $commitHashChanged = (Test-HasValue $headCommitHash) -and $headCommitHash -ne $PreviousHeadCommitHash
    $commitHashMatchesHead = (Test-HasValue $lastCommitHash) -and $lastCommitHash -eq $headCommitHash

    if ($state.lastCommand -eq "commit" -and $state.lastCommandStatus -eq "passed" -and $commitHashChanged -and -not $c
ommitHashMatchesHead) {
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
    $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Message
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
        $script:steps += New-StepResult $stepNumber "load-task" "state/queue 확인" $false $false 1 $_.Exception.Message
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
    $script:steps += New-StepResult $stepNumber "task-start" "MaxTasks=$MaxTasks" $false $false 0 "현재 task 실행 시작: $task
Label"
    $stepNumber++

    Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.
ps1" $scriptPaths.makePrompt @()
    $stepNumber++

    if (-not $AllowCodex -and -not $DryRun) {
        $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRevie
wCodex -MaxTasks $MaxTasks"
        if ($AllowDirty) {
            $command = "$command -AllowDirty"
        }

        if ($AllowCommit) {
            $command = "$command -AllowCommit"
        }

        if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
            $command = "$command -CommitFiles $($CommitFiles -join ',')"
        }

        $script:steps += New-StepResult $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-de
v-run-codex.ps1" $false $true 1 "Codex 구현 실행에는 -AllowCodex가 필요합니다. 추천 명령: $command"
        Stop-Cycle $script:steps "allow_codex_required" $false 1
    }

    $runCodexArguments = @()
    if ($AllowDirty) {
        $runCodexArguments += "-AllowDirty"
    }

    Invoke-CycleCommand $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1"
 $scriptPaths.runCodex $runCodexArguments
    $stepNumber++

    Invoke-CycleCommand $stepNumber "check" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOn
ly" $scriptPaths.check @("-BuildOnly")
    $stepNumber++

    Invoke-CycleCommand $stepNumber "save-diff" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1"
 $scriptPaths.saveDiff @()
    $stepNumber++

    Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-
review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
    $stepNumber++

    if (-not $AllowReviewCodex -and -not $DryRun) {
        $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRevie
wCodex -MaxTasks $MaxTasks"
        if ($AllowDirty) {
            $command = "$command -AllowDirty"
        }

        if ($AllowCommit) {
            $command = "$command -AllowCommit"
        }

        if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
            $command = "$command -CommitFiles $($CommitFiles -join ',')"
        }

        $script:steps += New-StepResult $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File script
s/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 1 "Codex 리뷰 실행에는 -AllowReviewCodex가 필요합니다. 추천 명령: $
command"
        Stop-Cycle $script:steps "allow_review_codex_required" $false 1
    }

    Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-rev
iew-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirty", "-SaveReview")
    $stepNumber++

    if ($DryRun) {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $true 0 "DryRun:
 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json packa
ge-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-c
ommit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHash 확인" $false $
true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-complete-task.ps1 -ResultSummary `"자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료`" -CommitHash <commit-ha
sh>" $false $true 0 "DryRun: task 완료 처리를 실행하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "meta-commit" "direct meta commit: git add scoped .ai-dev files, gi
t commit -m 'chore(ai-dev): record task completion', git status --short" $false $true 0 "DryRun: .ai-dev 메타 상태 직접 커밋을 실
행하지 않았습니다."
        Stop-Cycle $script:steps "dry_run" $false 0
    }

    try {
        $reviewGate = Get-ReviewGate
    } catch {
        $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $false 1 $_.Excepti
on.Message
        Stop-Cycle $script:steps "review_gate_failed" $false 1
    }

    if ($reviewGate.lastCommandStatus -ne "passed") {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false $true 1 "리뷰 저장 또는
 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
        Stop-Cycle $script:steps "review_save_not_passed" $false 1
    }

    if ($reviewGate.decision -ne "pass") {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $true 0 "리뷰 deci
sion이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
        Stop-Cycle $script:steps "review_not_pass" $false 0
    }

    if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_step 확인" $false $tr
ue 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.nextStep)"
        Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
    }

    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $false 0 "리뷰 pass 확인
. 커밋 게이트로 진행합니다."
    $stepNumber++

    try {
        if (Test-PackageFileChanged) {
            $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json p
ackage-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 커밋하지 않습니다."
            Stop-Cycle $script:steps "package_files_changed" $false 1
        }
    } catch {
        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json packa
ge-lock.json" $false $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "package_change_gate_failed" $false 1
    }

    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json package-l
ock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
    $stepNumber++

    if (-not $AllowCommit) {
        $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -Allo
wReviewCodex -AllowCommit -MaxTasks $MaxTasks"
        if ($AllowDirty) {
            $commitCommand = "$commitCommand -AllowDirty"
        }

        if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
            $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
        }

        $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-c
ommit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
        Stop-Cycle $script:steps "allow_commit_required" $false 1
    }

    $commitArguments = Get-CommitArguments

    if ($commitArguments.Count -eq 0) {
        $script:steps += New-StepResult $stepNumber "commit" "git status --porcelain" $false $true 1 "커밋할 구현 변경사항이 없어 c
omplete-task를 실행하지 않습니다."
        Stop-Cycle $script:steps "no_implementation_changes" $false 1
    }

    $commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
    if ($commitArguments.Count -gt 0) {
        $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
    }

    try {
        $preCommitHeadCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-parse HEAD
"
    } catch {
        $script:steps += New-StepResult $stepNumber "commit" "git rev-parse HEAD" $false $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "pre_commit_head_failed" $false 1
    }

    Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
    $stepNumber++

    try {
        $commitGate = Get-CommitGate $preCommitHeadCommitHash
    } catch {
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHash 확인" $false $
false 1 $_.Exception.Message
        Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
    }

    if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -not $commitGate.commit
HashChanged -or -not $commitGate.commitHashMatchesHead) {
        $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastCommand), lastCommandStat
us=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCommitHash)"
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHash 확인" $false $
true 1 $message
        Stop-Cycle $script:steps "commit_not_confirmed" $false 1
    }

    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHash 확인" $false $fals
e 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
    $stepNumber++

    $resultSummary = "자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료"
    Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-t
ask.ps1 -ResultSummary `"$resultSummary`" -CommitHash $($commitGate.lastCommitHash)" $scriptPaths.completeTask @("-Resu
ltSummary", $resultSummary, "-CommitHash", $commitGate.lastCommitHash)
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

 succeeded in 2367ms:
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
        Write-Host "Next: 다음 목표를 시작하려면 .ai-dev/goal.md, .ai-dev/queue.json, .ai-dev/state.json을 새 목표로 초기화하세요."
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

    $autoStepOutput = & powershell -ExecutionPolicy Bypass -File $autoStepPath @arguments 2>&1 | Out-String
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

    if ($terminalActions -contains $action) {
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
        $result = New-CycleResult $steps "repeated_action_without_progress:$action" $false 0
        Write-CycleResult $result
        exit 0
    }

    $previousAction = $action
}

$finalResult = New-CycleResult $steps "max_steps_reached" $false 0
Write-CycleResult $finalResult
exit 0

codex
현재 `ai-dev-auto-cycle-full.ps1`에는 이미 pass 이후 commit, commit hash 확인, `complete-task`, 메타 커밋 단계가 들어가 있습니다. 실제 변경이 필요한지 판
단하려고 호출 경로와 문서화된 실행 스크립트를 조금 더 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'rg --hidden -n "auto-cycle-full|complete-tas
k|AllowCommit|lastCommitHash|lastReviewDecision|review_not_pass|meta-commit" -g "!.git" -g "!node_modules" -g "!dist"' 
in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath \"D:\\ai-apps\\plan
pilot-local\\scripts\\ai-dev-next.ps1\"" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath \"D:\\ai-apps\\plan
pilot-local\\scripts\\ai-dev-auto-goal.ps1\"" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath \"D:\\ai-apps\\plan
pilot-local\\scripts\\ai-dev-commit.ps1\"" in D:\ai-apps\planpilot-local
 succeeded in 1964ms:
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
    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::OrdinalIgnoreCase)
}

function Convert-ToChangedPath {
    param(
        [string]$ChangeLine
    )

    if ([string]::IsNullOrWhiteSpace($ChangeLine)) {
        return $null
    }

    if ($ChangeLine.StartsWith("?? ")) {
        return $ChangeLine.Substring(3)
    }

    if ($ChangeLine.Length -ge 4 -and $ChangeLine.Substring(2, 1) -eq " ") {
        return $ChangeLine.Substring(3)
    }

    return $ChangeLine
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
    $null = Invoke-GitCapture -Arguments @("rev-parse", "--show-toplevel") -DisplayName "git rev-parse --show-toplevel"
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
    $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-Object -First 1

    if ($null -ne $inProgressTask) {
        $currentTaskId = [string]$inProgressTask.id
    } else {
        $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Object -First 1

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
    Stop-WithError "state.lastCommandStatus가 passed가 아닙니다. 검증 결과를 확인하거나 -AllowWithoutPassedCheck를 사용하세요."
}

if (-not $AllowWithoutPassedReview -and $state.lastReviewDecision -ne "pass") {
    Stop-WithError "state.lastReviewDecision이 pass가 아닙니다. 리뷰 결과를 확인하거나 -AllowWithoutPassedReview를 사용하세요."
}

try {
    $statusPorcelain = Invoke-GitCapture -Arguments @("status", "--porcelain") -DisplayName "git status --porcelain"
} catch {
    Stop-WithError $_.Exception.Message
}

$changeLines = @($statusPorcelain -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })

if ($changeLines.Count -eq 0) {
    Write-Host "커밋할 변경사항 없음"
    exit 0
}

$selectedFiles = @()
$targetChangeLines = $changeLines

if ($null -ne $Files -and $Files.Count -gt 0) {
    $requestedFiles = @($Files | ForEach-Object { $_ -split "," } | Where-Object { -not [string]::IsNullOrWhiteSpace($_
) })

    if ($requestedFiles.Count -eq 0) {
        Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
    }

    foreach ($file in $requestedFiles) {
        if ([string]::IsNullOrWhiteSpace($file)) {
            Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
        }

        $normalizedFile = $file.Replace('\', '/')
        $fullPath = [System.IO.Path]::GetFullPath((Join-Path $projectRoot $normalizedFile))
        $projectRootPrefix = [System.IO.Path]::GetFullPath($projectRoot).TrimEnd('\', '/') + [System.IO.Path]::Director
ySeparatorChar

        if (-not $fullPath.StartsWith($projectRootPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
            Stop-WithError "저장소 밖 파일은 선택할 수 없습니다: $file"
        }

        if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
            Stop-WithError "선택한 파일이 존재하지 않습니다: $file"
        }

        try {
            $fileStatus = Invoke-GitCapture -Arguments @("status", "--porcelain", "--", $normalizedFile) -DisplayName "
git status --porcelain -- $normalizedFile"
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
        $stagedFiles = Invoke-GitCapture -Arguments @("diff", "--cached", "--name-only") -DisplayName "git diff --cache
d --name-only"
    } catch {
        Stop-WithError $_.Exception.Message
    }

    $stagedFileList = @($stagedFiles -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
    $unexpectedStagedFiles = @($stagedFileList | Where-Object { $selectedFiles -notcontains $_ })

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

$targetChangedPaths = @($targetChangeLines | ForEach-Object { Convert-ToChangedPath $_ } | Where-Object { -not [string]
::IsNullOrWhiteSpace($_) } | Select-Object -Unique)
$targetAppChangePaths = @($targetChangedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
$targetAiDevOperationalPaths = @($targetChangedPaths | Where-Object { Test-IsAiDevOperationalPath $_ })

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
        $stagedFilesAfterAdd = Invoke-GitCapture -Arguments @("diff", "--cached", "--name-only") -DisplayName "git diff
 --cached --name-only"
        $stagedFileListAfterAdd = @($stagedFilesAfterAdd -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSp
ace($_) })
        $unexpectedStagedFilesAfterAdd = @($stagedFileListAfterAdd | Where-Object { $selectedFiles -notcontains $_ })

        if ($unexpectedStagedFilesAfterAdd.Count -gt 0) {
            throw "선택 파일 외의 staged 파일이 감지되었습니다: $($unexpectedStagedFilesAfterAdd -join ', ')"
        }
    }

    $commitOutput = & git commit -m $commitMessage 2>&1 | Out-String

    if ($LASTEXITCODE -ne 0) {
        throw "git commit 실행에 실패했습니다. exit code: $LASTEXITCODE`n$commitOutput"
    }

    $commitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-parse HEAD"
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

 succeeded in 1968ms:
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

    return $Command -eq "check" -or $Command -like "npm run build*" -or $Command -like "npm run test*" -or $Command -li
ke "npm run lint*"
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
    $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-Object -First 1

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

try {
    $null = & git rev-parse --show-toplevel 2>&1

    if ($LASTEXITCODE -eq 0) {
        $gitOutput = & git status --porcelain 2>&1 | Out-String

        if ($LASTEXITCODE -eq 0) {
            $gitChangedFilesCount = @($gitOutput -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) 
}).Count
            $gitStatus = "available"
        }
    }
} catch {
    $gitStatus = "unavailable"
}

$currentTaskPromptExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/current-task-prompt.md") -PathType L
eaf
$testResultExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/test-result.md") -PathType Leaf
$diffExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/diff.md") -PathType Leaf
$reviewPromptExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/review-prompt.md") -PathType Leaf
$revisePromptExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/revise-prompt.md") -PathType Leaf

$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { "" }
$lastCommand = if (Test-HasValue $state.lastCommand) { [string]$state.lastCommand } else { "" }
$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastCommandStatus } else { "" }
$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastReviewDecision } else { "" }
$lastReviewSeverity = if (Test-HasValue $state.lastReviewSeverity) { [string]$state.lastReviewSeverity } else { "" }
$lastCommitHash = if (Test-HasValue $state.lastCommitHash) { [string]$state.lastCommitHash } else { "" }
$hasGitChanges = $gitStatus -eq "available" -and $gitChangedFilesCount -gt 0
$hasNoGitChanges = $gitStatus -eq "available" -and $gitChangedFilesCount -eq 0
$reviewNotStarted = Test-IsReviewNotStarted $lastReviewDecision
$isCheckCommand = Test-IsCheckCommand $lastCommand

$nextAction = $null

if (-not (Test-HasValue $currentTaskId) -and $goalStatus -eq "completed") {
    $nextAction = New-NextAction "goal_completed" "모든 task가 완료되었습니다." @() @("새 goal을 시작하기 전 현재 결과를 확인하세요.")
} elseif (-not (Test-HasValue $currentTaskId) -and $null -eq $pendingTask) {
    $nextAction = New-NextAction "no_task" "수행할 task가 없습니다." @() @("queue.json과 goal.md를 확인하세요.")
} elseif (-not $currentTaskPromptExists) {
    $nextAction = New-NextAction "make_task_prompt" "현재 task 프롬프트 파일이 없습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1"
    ) @("프롬프트 생성 후 현재 task만 수행하세요.")
} elseif ($lastReviewDecision -eq "blocked") {
    $nextAction = New-NextAction "stop_for_user" "리뷰가 blocked 상태입니다." @() @("사용자 판단이 필요하므로 자동 진행을 중단하세요.")
} elseif ($lastReviewDecision -eq "revise") {
    $nextAction = New-NextAction "make_revise_prompt" "리뷰에서 수정이 필요하다고 판정했습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1"
    ) @(
        $(if ($revisePromptExists) { "기존 revise-prompt.md는 현재 리뷰 기준으로 덮어씁니다." } else { "required changes만 반영하세요." })
    )
} elseif ($lastReviewDecision -eq "pass" -and $lastCommandStatus -eq "passed" -and $hasGitChanges) {
    $nextAction = New-NextAction "commit" "검증과 리뷰가 통과했고 커밋할 변경사항이 있습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
    ) @("먼저 ai-dev-commit.ps1 -DryRun으로 커밋 대상을 확인하는 것을 권장합니다.")
} elseif ($lastReviewDecision -eq "pass" -and (Test-HasValue $lastCommitHash) -and $hasNoGitChanges) {
    $nextAction = New-NextAction "complete_task" "리뷰와 커밋이 완료되었고 작업 트리가 깨끗합니다." @(
        'powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary "리뷰 및 커밋 완료"'
    ) @("다음 pending task로 이동하기 전에 현재 task 결과를 확인하세요.")
} elseif ($hasNoGitChanges -and ($lastCommand -eq "" -or $lastCommand -eq "init" -or $lastCommand -eq "current-task")) 
{
    $nextAction = New-NextAction "run_codex_or_cline" "현재 task 프롬프트는 준비되었고 아직 변경사항이 없습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1"
    ) @("current-task-prompt.md를 Codex 또는 Cline에 전달해 현재 task를 수행하세요.")
} elseif ($hasGitChanges -and $lastCommand -eq "save-diff" -and $reviewNotStarted -and -not $reviewPromptExists) {
    $nextAction = New-NextAction "make_review_prompt" "diff가 저장되었고 리뷰 프롬프트가 없습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict"
    ) @("현재 diff와 검증 결과를 기준으로 리뷰 프롬프트를 생성하세요.")
} elseif ($hasGitChanges -and $reviewPromptExists -and $reviewNotStarted) {
    $nextAction = New-NextAction "ask_gpt_review" "리뷰 프롬프트가 준비되었고 아직 리뷰 결과가 없습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard"
    ) @("review-prompt.md 내용을 GPT Chat에 붙여넣고 JSON 리뷰 결과를 받은 뒤 save-review를 실행하세요.")
} elseif ($hasGitChanges -and $isCheckCommand -and $lastCommandStatus -eq "passed" -and (-not $diffExists -or $isCheckC
ommand)) {
    $nextAction = New-NextAction "save_diff" "검증이 통과했으며 현재 변경사항의 diff 저장이 필요합니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1"
    ) @("diff 저장 후 리뷰 프롬프트를 생성하세요.")
} elseif ($hasGitChanges -and ($lastCommandStatus -ne "passed" -or -not $isCheckCommand)) {
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
        $(if ($gitStatus -eq "unavailable") { "git 상태를 확인할 수 없습니다." } else { "상태 파일과 생성 파일의 최신성을 확인하세요." }),
        $(if (-not $testResultExists) { "test-result.md가 없습니다." } else { "test-result.md가 있습니다." })
    )
}

$output = [ordered]@{
    action = $nextAction.action
    reason = $nextAction.reason
    currentTaskId = if ($null -ne $currentTask) { $currentTask.id } elseif (Test-HasValue $currentTaskId) { $currentTas
kId } else { $null }
    currentTaskTitle = if ($null -ne $currentTask) { $currentTask.title } else { "없음" }
    goalStatus = $goalStatus
    lastCommand = $lastCommand
    lastCommandStatus = $lastCommandStatus
    lastReviewDecision = $lastReviewDecision
    lastReviewSeverity = $lastReviewSeverity
    lastCommitHash = $lastCommitHash
    gitStatus = $gitStatus
    gitChangedFilesCount = $gitChangedFilesCount
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
Write-Host "Last review decision/severity: $($output.lastReviewDecision) / $($output.lastReviewSeverity)"
Write-Host "Git changed files count: $($output.gitChangedFilesCount)"
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

 succeeded in 2088ms:
param(
    [AllowEmptyString()]
    [string]$GoalTitle,
    [AllowEmptyString()]
    [string]$GoalDescription,
    [int]$MaxTasks = 1,
    [int]$MaxSteps = 20,
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowRun,
    [switch]$AllowCodex,
    [switch]$AllowReviewCodex,
    [switch]$AllowCommit,
    [switch]$AllowDirty,
    [string[]]$CommitFiles,
    [string]$ResultPath = ".ai-dev/codex-result.md"
)

. "$PSScriptRoot\ai-dev-env.ps1"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
$codeFence = '```'
$goalRelativePath = ".ai-dev/goal.md"
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$promptRelativePath = ".ai-dev/current-task-prompt.md"
$planningPromptRelativePath = ".ai-dev/auto-goal-planning-prompt.md"
$legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"

function Resolve-RepoPath {
    param([string]$Path)

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return $Path
    }

    return Join-Path $repoRoot $Path
}

function ConvertTo-RepoRelativePath {
    param([string]$Path)

    $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $Path))
    $rootWithSeparator = $repoRoot.TrimEnd("\") + "\"

    if ($fullPath.StartsWith($rootWithSeparator, [System.StringComparison]::OrdinalIgnoreCase)) {
        return $fullPath.Substring($rootWithSeparator.Length).Replace("\", "/")
    }

    return $fullPath.Replace("\", "/")
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

function New-AutoGoalResult {
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
        plan = $script:autoGoalPlanPreview
        goalPath = $goalRelativePath
        queuePath = $queueRelativePath
        statePath = $stateRelativePath
        promptPath = $promptRelativePath
        resultPath = (ConvertTo-RepoRelativePath $ResultPath)
    }
}

function Write-AutoGoalResult {
    param([object]$Result)

    if ($Json) {
        $Result | ConvertTo-Json -Depth 30
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

    if ($null -ne $Result.plan) {
        Write-Host "Plan preview:"
        Write-Host "  Goal title: $($Result.plan.queue.goalTitle)"
        Write-Host "  Current task id: $($Result.plan.queue.currentTaskId)"

        foreach ($task in @($Result.plan.queue.tasks)) {
            Write-Host "  Task $($task.id): $($task.title)"
            Write-Host "    Type: $($task.type)"
            Write-Host "    Status: $($task.status)"
            Write-Host "    Priority: $($task.priority)"
            Write-Host "    Likely files: $((@($task.filesLikelyToChange) -join ', '))"
            Write-Host "    Verification: $((@($task.verification) -join ' / '))"
        }
    }

    Write-Host "Stopped reason: $($Result.stoppedReason)"
    Write-Host "Completed: $($Result.completed)"
    Write-Host "Exit code: $($Result.exitCode)"
}

function Clear-AutoGoalTempArtifacts {
    $currentResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ResultPath))

    foreach ($relativePath in @($planningPromptRelativePath, $legacyAutoGoalResultRelativePath)) {
        $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $relativePath))

        if (-not $fullPath.StartsWith($repoRoot.TrimEnd("\") + "\", [System.StringComparison]::OrdinalIgnoreCase)) {
            continue
        }

        if ($fullPath.Equals($currentResultPath, [System.StringComparison]::OrdinalIgnoreCase)) {
            continue
        }

        try {
            if ([System.IO.File]::Exists($fullPath)) {
                [System.IO.File]::Delete($fullPath)
            }
        } catch {
            Write-Warning "Failed to clean auto-goal temp artifact: $relativePath"
        }
    }
}

function Stop-AutoGoal {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    Clear-AutoGoalTempArtifacts
    Write-AutoGoalResult (New-AutoGoalResult $Steps $StoppedReason $Completed $ExitCode)
    exit $ExitCode
}

function Get-InputPreview {
    param([string]$RawInput)

    if ($null -eq $RawInput) {
        return "<null>"
    }

    $normalized = $RawInput.Replace("`r", " ").Replace("`n", " ").Trim()

    if ($normalized.Length -eq 0) {
        return "<empty>"
    }

    if ($normalized.Length -le 500) {
        return $normalized
    }

    return $normalized.Substring(0, 500)
}

function Get-GitStatusLines {
    $statusOutput = & git status --short 2>&1

    if ($LASTEXITCODE -ne 0) {
        $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 1 "git status failed
: $($statusOutput -join "`n")"
        Stop-AutoGoal $script:steps "git_status_failed" $false 1
    }

    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
}

function Get-JsonObjectCandidates {
    param([string]$RawInput)

    $candidates = @()
    $seen = @{}

    for ($start = 0; $start -lt $RawInput.Length; $start++) {
        if ($RawInput[$start] -ne "{") {
            continue
        }

        $depth = 0
        $inString = $false
        $escaped = $false

        for ($index = $start; $index -lt $RawInput.Length; $index++) {
            $char = $RawInput[$index]

            if ($escaped) {
                $escaped = $false
                continue
            }

            if ($char -eq "\") {
                $escaped = $true
                continue
            }

            if ($char -eq '"') {
                $inString = -not $inString
                continue
            }

            if ($inString) {
                continue
            }

            if ($char -eq "{") {
                $depth++
                continue
            }

            if ($char -eq "}") {
                $depth--

                if ($depth -eq 0) {
                    $candidateText = $RawInput.Substring($start, $index - $start + 1).Trim()

                    if (-not $seen.ContainsKey($candidateText)) {
                        $seen[$candidateText] = $true
                        $candidates += [PSCustomObject]@{
                            Start = $start
                            Text = $candidateText
                            HasPlanShape = ($candidateText -match '"goalMarkdown"\s*:' -and $candidateText -match '"que
ue"\s*:' -and $candidateText -match '"state"\s*:')
                        }
                    }

                    break
                }
            }
        }
    }

    return @($candidates | Sort-Object -Property @{ Expression = "HasPlanShape"; Descending = $true }, @{ Expression = 
"Start"; Descending = $true } | ForEach-Object { $_.Text })
}

function Get-MissingFields {
    param(
        [object]$InputObject,
        [string[]]$RequiredFields
    )

    $missingFields = @()

    foreach ($field in $RequiredFields) {
        if (-not ($InputObject.PSObject.Properties.Name -contains $field)) {
            $missingFields += $field
        }
    }

    return $missingFields
}

function Get-QueueValidationErrors {
    param([object]$Queue)

    $errors = @()
    $requiredFields = @("goalTitle", "goalSource", "createdAt", "updatedAt", "currentTaskId", "tasks")

    foreach ($field in @(Get-MissingFields $Queue $requiredFields)) {
        $errors += "queue missing field: $field"
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (-not (Test-HasValue $Queue.goalTitle)) {
        $errors += "queue.goalTitle must not be empty."
    }

    if ($Queue.goalSource -ne $goalRelativePath) {
        $errors += "queue.goalSource must be $goalRelativePath."
    }

    if ($Queue.tasks -isnot [System.Collections.IEnumerable] -or $Queue.tasks -is [string]) {
        $errors += "queue.tasks must be an array."
        return $errors
    }

    $tasks = @($Queue.tasks)

    if ($tasks.Count -lt 1) {
        $errors += "queue.tasks must contain at least one task."
        return $errors
    }

    if ($tasks.Count -gt 3) {
        $errors += "queue.tasks must contain no more than three tasks."
    }

    if ($Queue.currentTaskId -ne "T001") {
        $errors += "queue.currentTaskId must be T001."
    }

    $taskIds = @()

    foreach ($task in $tasks) {
        $taskRequiredFields = @("id", "title", "description", "type", "status", "priority", "dependsOn", "filesLikelyTo
Change", "verification", "commitMessage")
        $taskMissingFields = @(Get-MissingFields $task $taskRequiredFields)

        foreach ($field in $taskMissingFields) {
            $errors += "task missing field: $field"
        }

        if ($taskMissingFields.Count -gt 0) {
            continue
        }

        if (-not (Test-HasValue $task.id)) {
            $errors += "task.id must not be empty."
        } else {
            $taskIds += [string]$task.id
        }

        if (-not (Test-HasValue $task.title)) {
            $errors += "task.title must not be empty."
        }

        if (-not (Test-HasValue $task.description)) {
            $errors += "task.description must not be empty."
        }

        if (@("analysis", "implementation", "documentation", "verification") -notcontains $task.type) {
            $errors += "invalid task.type: $($task.type)"
        }

        if (@("pending", "in_progress", "done", "blocked") -notcontains $task.status) {
            $errors += "invalid task.status: $($task.status)"
        }

        if (@("P0", "P1", "P2") -notcontains $task.priority) {
            $errors += "invalid task.priority: $($task.priority)"
        }

        if ($task.dependsOn -isnot [System.Collections.IEnumerable] -or $task.dependsOn -is [string]) {
            $errors += "task.dependsOn must be an array: $($task.id)"
        }

        if ($task.filesLikelyToChange -isnot [System.Collections.IEnumerable] -or $task.filesLikelyToChange -is [string
]) {
            $errors += "task.filesLikelyToChange must be an array: $($task.id)"
        }

        if ($task.verification -isnot [System.Collections.IEnumerable] -or $task.verification -is [string]) {
            $errors += "task.verification must be an array: $($task.id)"
        }
    }

    if ((@($tasks | Where-Object { $_.status -eq "in_progress" })).Count -ne 1) {
        $errors += "queue.tasks must contain exactly one in_progress task."
    }

    if (-not (Test-HasValue $Queue.currentTaskId)) {
        $errors += "queue.currentTaskId must not be empty."
    } elseif ($taskIds -notcontains [string]$Queue.currentTaskId) {
        $errors += "queue.currentTaskId does not match a task: $($Queue.currentTaskId)"
    }

    $firstTask = $tasks | Where-Object { $_.id -eq "T001" } | Select-Object -First 1
    if ($null -eq $firstTask) {
        $errors += "queue.tasks must include T001."
    } elseif ($firstTask.status -ne "in_progress") {
        $errors += "T001 must be in_progress."
    }

    foreach ($laterTask in @($tasks | Where-Object { $_.id -ne "T001" })) {
        if ($laterTask.status -ne "pending") {
            $errors += "later tasks must be pending: $($laterTask.id)"
        }
    }

    return $errors
}

function Get-StateValidationErrors {
    param(
        [object]$State,
        [object]$Queue
    )

    $errors = @()
    $requiredFields = @("goalStatus", "currentTaskId", "currentLoop", "maxLoopsPerTask", "repeatedFailureCount", "lastC
ommand", "lastCommandStatus", "lastErrorSummary", "lastReviewDecision", "lastReviewSeverity", "lastCommitHash", "starte
dAt", "updatedAt", "stopReason")

    foreach ($field in @(Get-MissingFields $State $requiredFields)) {
        $errors += "state missing field: $field"
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (@("idle", "in_progress", "completed", "blocked") -notcontains $State.goalStatus) {
        $errors += "invalid state.goalStatus: $($State.goalStatus)"
    }

    if ($State.currentTaskId -ne $Queue.currentTaskId) {
        $errors += "state.currentTaskId must match queue.currentTaskId."
    }

    if ($State.currentTaskId -ne "T001") {
        $errors += "state.currentTaskId must be T001."
    }

    if (@("not_started", "passed", "failed", "blocked") -notcontains $State.lastCommandStatus) {
        $errors += "invalid state.lastCommandStatus: $($State.lastCommandStatus)"
    }

    if (@("not_started", "pass", "revise", "blocked") -notcontains $State.lastReviewDecision) {
        $errors += "invalid state.lastReviewDecision: $($State.lastReviewDecision)"
    }

    return $errors
}

function Get-AutoGoalValidationErrors {
    param([object]$Plan)

    $errors = @()

    foreach ($field in @(Get-MissingFields $Plan @("goalMarkdown", "queue", "state"))) {
        $errors += "plan missing field: $field"
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (-not (Test-HasValue $Plan.goalMarkdown)) {
        $errors += "goalMarkdown must not be empty."
    }

    $errors += @(Get-QueueValidationErrors $Plan.queue)
    $errors += @(Get-StateValidationErrors $Plan.state $Plan.queue)

    return $errors
}

function New-DryRunAutoGoalPlan {
    param(
        [string]$Title,
        [string]$Description
    )

    $now = (Get-Date).ToUniversalTime().ToString("o")
    $safeTitle = $Title.Trim()
    $safeDescription = $Description.Trim()

    $plan = [PSCustomObject][ordered]@{
        goalMarkdown = @"
# 목표

$safeTitle

## 배경

$safeDescription

## 성공 기준

- 입력한 목표에서 현재 작업을 준비한다.
- full auto-cycle 실행 전에 현재 작업 프롬프트가 생성된다.
- full auto-cycle은 명시적인 허용 옵션이 있을 때만 실행된다.

## 제약사항

- 서버 API, 로그인, 클라우드 동기화, npm install, 위험한 git 명령은 사용하지 않는다.
- 저장소 정책과 현재 작업 범위를 따른다.

## 범위 제외

- 패키지 변경
- DB 삭제 또는 초기화
- 광범위한 리팩터링

## 수동 검증

- DryRun 계획과 JSON 출력을 검토한다.
- 현재 작업 프롬프트 생성 여부를 확인한다.
- 필요한 경우 빌드와 검증은 별도로 실행한다.
"@
        queue = [PSCustomObject][ordered]@{
            goalTitle = $safeTitle
            goalSource = $goalRelativePath
            createdAt = $now
            updatedAt = $now
            currentTaskId = "T001"
            tasks = @(
                [PSCustomObject][ordered]@{
                    id = "T001"
                    title = $safeTitle
                    description = $safeDescription
                    type = "implementation"
                    status = "in_progress"
                    priority = "P0"
                    dependsOn = @()
                    filesLikelyToChange = @()
                    verification = @(
                        "변경 범위가 현재 목표와 일치하는지 확인한다.",
                        "필요한 경우 npm run build를 별도로 실행한다."
                    )
                    commitMessage = $null
                }
            )
        }
        state = [PSCustomObject][ordered]@{
            goalStatus = "in_progress"
            currentTaskId = "T001"
            currentLoop = 0
            maxLoopsPerTask = 2
            repeatedFailureCount = 0
            lastCommand = $null
            lastCommandStatus = "not_started"
            lastErrorSummary = $null
            lastReviewDecision = "not_started"
            lastReviewSeverity = $null
            lastCommitHash = $null
            startedAt = $now
            updatedAt = $now
            stopReason = $null
        }
    }

    return $plan
}

function ConvertFrom-CodexAutoGoalOutput {
    param([string]$RawInput)

    $validationFailures = @()

    foreach ($candidate in Get-JsonObjectCandidates $RawInput) {
        try {
            $parsed = $candidate | ConvertFrom-Json

            if ($null -eq $parsed -or $parsed -is [System.Array]) {
                continue
            }

            $validationErrors = @(Get-AutoGoalValidationErrors $parsed)

            if ($validationErrors.Count -gt 0) {
                $validationFailures += "Candidate validation failed: $($validationErrors -join '; ')"
                continue
            }

            return [PSCustomObject]@{
                Parsed = $parsed
                JsonText = ($parsed | ConvertTo-Json -Depth 30)
            }
        } catch {
        }
    }

    if ($validationFailures.Count -gt 0) {
        throw "No valid auto-goal JSON object was found in Codex output. Validation errors: $($validationFailures -join
 ' | ')"
    }

    throw "No valid auto-goal JSON object was found in Codex output."
}

function New-CodexAutoGoalPrompt {
    param(
        [string]$Title,
        [string]$Description
    )

    return @"
You are preparing local AI Dev Loop state files for the repository at $repoRoot.

Return exactly one JSON object and no markdown fences or commentary.

The user supplied this new goal:
Title: $Title
Description: $Description

Create a small, safe goal plan for this repository. The response object must have these fields:
- goalMarkdown: .ai-dev/goal.md에 작성할 마크다운 문자열입니다. "# 목표", "배경", "성공 기준", "제약사항", "범위 제외", "수동 검증" 섹션을 한국어로 포함해야 합니다.
- queue: an object for .ai-dev/queue.json.
- state: an object for .ai-dev/state.json.

queue rules:
- goalTitle must equal the supplied title.
- goalSource must be ".ai-dev/goal.md".
- createdAt and updatedAt are required and must be ISO 8601 strings.
- currentTaskId must be "T001".
- tasks must contain one to three tasks.
- T001 must be status "in_progress"; later tasks, if any, must be "pending".
- each task must include id, title, description, type, status, priority, dependsOn, filesLikelyToChange, verification, 
commitMessage.
- type must be one of analysis, implementation, documentation, verification.
- priority must be P0, P1, or P2.
- dependsOn, filesLikelyToChange, and verification must be arrays.
- commitMessage must be null or a short English commit message.

state rules:
- goalStatus must be "in_progress".
- currentTaskId must be "T001".
- currentLoop must be 0.
- maxLoopsPerTask must be 2.
- repeatedFailureCount must be 0.
- lastCommand must be null.
- lastCommandStatus must be "not_started".
- lastErrorSummary must be null.
- lastReviewDecision must be "not_started".
- lastReviewSeverity must be null.
- lastCommitHash must be null.
- startedAt and updatedAt must be ISO 8601 strings.
- stopReason must be null.

Safety rules:
- Do not mention server APIs, login, cloud sync, npm install, git reset, git clean, git push, DB deletion, or broad rew
rites as implementation steps.
- Prefer one small implementation task when the goal is small.
- Use Korean for user-facing task titles, descriptions, verification, and goalMarkdown.
"@
}

function New-CodexAutoGoalWrapperPrompt {
    param(
        [string]$PromptFilePath
    )

    return "Read and follow the full auto-goal planning prompt at this absolute file path: $PromptFilePath"
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
        $script:steps += New-StepResult $StepNumber $Name $Command $false $true 0 "DryRun: child script was not execute
d."
        return
    }

    $output = & powershell -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1 | Out-String
    $exitCode = $LASTEXITCODE
    $message = $output.Trim()

    if ([string]::IsNullOrWhiteSpace($message)) {
        $message = "completed"
    }

    $script:steps += New-StepResult $StepNumber $Name $Command $true $false $exitCode $message

    if ($exitCode -ne 0) {
        Stop-AutoGoal $script:steps "$Name`_failed" $false 1
    }
}

function Get-FullCycleArguments {
    $arguments = @("-MaxTasks", ([string]$MaxTasks), "-MaxSteps", ([string]$MaxSteps))

    if ($AllowCodex) {
        $arguments += "-AllowCodex"
    }

    if ($AllowReviewCodex) {
        $arguments += "-AllowReviewCodex"
    }

    if ($AllowCommit) {
        $arguments += "-AllowCommit"
    }

    # auto-goal writes goal/queue/state/current prompt/result files after the initial dirty gate.
    # The downstream full cycle must tolerate those intended artifacts.
    $arguments += "-AllowDirty"

    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -not [string]::IsNullOrWh
iteSpace($_) })

        if ($normalizedFiles.Count -gt 0) {
            $arguments += "-CommitFiles"
            $arguments += ($normalizedFiles -join ",")
        }
    }

    return $arguments
}

Set-Location $repoRoot

$script:steps = @()
$script:autoGoalPlanPreview = $null
$resolvedGoalPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $goalRelativePath))
$resolvedQueuePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $queueRelativePath))
$resolvedStatePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $stateRelativePath))
$resolvedPlanningPromptPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $planningPromptRelativePath))
$resolvedResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ResultPath))

if (-not (Test-HasValue $GoalTitle)) {
    $script:steps += New-StepResult 0 "validate-input" "check GoalTitle" $false $false 1 "GoalTitle must not be empty."
    Stop-AutoGoal $script:steps "invalid_goal_title" $false 1
}

if (-not (Test-HasValue $GoalDescription)) {
    $script:steps += New-StepResult 0 "validate-input" "check GoalDescription" $false $false 1 "GoalDescription must no
t be empty."
    Stop-AutoGoal $script:steps "invalid_goal_description" $false 1
}

if ($MaxTasks -lt 1) {
    $script:steps += New-StepResult 0 "validate-input" "check MaxTasks" $false $false 1 "MaxTasks must be at least 1."
    Stop-AutoGoal $script:steps "max_tasks_must_be_at_least_1" $false 1
}

if ($MaxSteps -lt 1) {
    $script:steps += New-StepResult 0 "validate-input" "check MaxSteps" $false $false 1 "MaxSteps must be at least 1."
    Stop-AutoGoal $script:steps "max_steps_must_be_at_least_1" $false 1
}

$makePromptPath = Join-Path $PSScriptRoot "ai-dev-make-prompt.ps1"
$autoCycleFullPath = Join-Path $PSScriptRoot "ai-dev-auto-cycle-full.ps1"

foreach ($requiredScript in @($makePromptPath, $autoCycleFullPath)) {
    if (-not (Test-Path -LiteralPath $requiredScript -PathType Leaf)) {
        $script:steps += New-StepResult 0 "prepare" "check required scripts" $false $false 1 "Missing required script: 
$requiredScript"
        Stop-AutoGoal $script:steps "prepare_failed" $false 1
    }
}

$shouldRunFullCycle = [bool]($AllowRun -or $AllowCodex -or $AllowReviewCodex -or $AllowCommit)
$fullCycleArguments = @(Get-FullCycleArguments)
$fullCycleCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 $($fullCycleArgume
nts -join ' ')".Trim()

$script:steps += New-StepResult 1 "validate-input" "check GoalTitle/GoalDescription" $false $false 0 "Input validation 
completed: $GoalTitle"

if ($DryRun) {
    $script:autoGoalPlanPreview = New-DryRunAutoGoalPlan $GoalTitle.Trim() $GoalDescription.Trim()
    $previewValidationErrors = @(Get-AutoGoalValidationErrors $script:autoGoalPlanPreview)

    if ($previewValidationErrors.Count -gt 0) {
        $script:steps += New-StepResult 2 "preview-plan" "local dry-run plan preview" $false $false 1 "DryRun preview p
lan validation failed: $($previewValidationErrors -join '; ')"
        Stop-AutoGoal $script:steps "dry_run_preview_invalid" $false 1
    }

    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $true 0 "DryRun: dirty worktree
 gate was not executed."
    $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $false $true 0 "DryRun: Code
x goal planning was not executed. Preview currentTaskId: T001, task: $GoalTitle"
    $script:steps += New-StepResult 4 "validate-generated-json" "goal/queue/state JSON validation" $false $true 0 "DryR
un: preview goal/queue/state plan passed local schema validation."
    $script:steps += New-StepResult 5 "write-state-files" "$goalRelativePath, $queueRelativePath, $stateRelativePath" $
false $true 0 "DryRun: state files were not written."
    $script:steps += New-StepResult 6 "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-promp
t.ps1" $false $true 0 "DryRun: current-task-prompt.md was not generated."

    if ($shouldRunFullCycle) {
        $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleCommandText $false $true 0 "DryRun: explicit run 
option is present, but full cycle was not executed. -AllowRun only invokes the full-cycle wrapper; implementation and r
eview still require -AllowCodex and -AllowReviewCodex."
    } else {
        $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleCommandText $false $true 0 "DryRun: full cycle re
quires -AllowRun or explicit execution options. -AllowRun only invokes the full-cycle wrapper; implementation and revie
w still require -AllowCodex and -AllowReviewCodex."
    }

    Stop-AutoGoal $script:steps "dry_run" $false 0
}

$statusLines = @(Get-GitStatusLines)

if ($statusLines.Count -gt 0 -and -not $AllowDirty) {
    $dirtyText = ($statusLines -join "`n")
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $true 1 "Worktree is dirty. Use
 -AllowDirty only when this is intentional.`n$dirtyText"
    Stop-AutoGoal $script:steps "dirty_worktree" $false 1
}

if ($statusLines.Count -gt 0) {
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 0 "AllowDirty is set. Di
rtyCount: $($statusLines.Count)"
} else {
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 0 "Worktree is clean."
}

$codexCommand = Get-Command codex -ErrorAction SilentlyContinue

if ($null -eq $codexCommand) {
    $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $false $false 1 "Codex CLI w
as not found."
    Stop-AutoGoal $script:steps "codex_not_found" $false 1
}

$plannerPrompt = New-CodexAutoGoalPrompt $GoalTitle.Trim() $GoalDescription.Trim()
$codexPrompt = New-CodexAutoGoalWrapperPrompt $resolvedPlanningPromptPath
$commandText = "codex exec <short wrapper pointing to $planningPromptRelativePath>"
[System.IO.File]::WriteAllText($resolvedPlanningPromptPath, $plannerPrompt, $utf8WithBom)
$startedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$codexOutput = & codex exec $codexPrompt 2>&1 | Out-String
$codexExitCode = $LASTEXITCODE
$endedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$resultContent = @"
# Codex Auto Goal Result

## Run

- Started at: $startedAt
- Ended at: $endedAt
- Exit code: $codexExitCode
- Goal title: $($GoalTitle.Trim())
- Planning prompt: $planningPromptRelativePath
- Command: $commandText

## Output

${codeFence}text
$codexOutput
$codeFence
"@

[System.IO.File]::WriteAllText($resolvedResultPath, $resultContent, $utf8WithBom)

if ($codexExitCode -ne 0) {
    $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $true $false 1 "Codex goal p
lanning failed. Result: $(ConvertTo-RepoRelativePath $ResultPath)"
    Stop-AutoGoal $script:steps "codex_plan_failed" $false 1
}

$script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $true $false 0 "Codex goal plann
ing completed. Result: $(ConvertTo-RepoRelativePath $ResultPath)"

try {
    $autoGoalPlan = ConvertFrom-CodexAutoGoalOutput $codexOutput
} catch {
    $preview = Get-InputPreview $codexOutput
    $script:steps += New-StepResult 4 "validate-generated-json" "goal/queue/state JSON validation" $false $false 1 "Cod
ex plan JSON extraction failed: $($_.Exception.Message) Output preview: $preview"
    Stop-AutoGoal $script:steps "generated_json_invalid" $false 1
}

$script:steps += New-StepResult 4 "validate-generated-json" "goal/queue/state JSON validation" $false $false 0 "goalMar
kdown, queue, and state JSON validation completed. currentTaskId: $($autoGoalPlan.Parsed.queue.currentTaskId)"
$script:autoGoalPlanPreview = $autoGoalPlan.Parsed

$goalMarkdown = [string]$autoGoalPlan.Parsed.goalMarkdown
$queueJson = $autoGoalPlan.Parsed.queue | ConvertTo-Json -Depth 30
$stateJson = $autoGoalPlan.Parsed.state | ConvertTo-Json -Depth 30

[System.IO.File]::WriteAllText($resolvedGoalPath, $goalMarkdown, $utf8WithBom)
[System.IO.File]::WriteAllText($resolvedQueuePath, $queueJson, $utf8WithBom)
[System.IO.File]::WriteAllText($resolvedStatePath, $stateJson, $utf8WithBom)

$script:steps += New-StepResult 5 "write-state-files" "$goalRelativePath, $queueRelativePath, $stateRelativePath" $true
 $false 0 "New goal, queue, and state files were written."

Invoke-CycleCommand 6 "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1" $makeProm
ptPath @()

if (-not $shouldRunFullCycle) {
    $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleCommandText $false $true 0 "Full cycle requires -Allo
wRun or explicit execution options. -AllowRun only invokes the full-cycle wrapper; implementation and review still requ
ire -AllowCodex and -AllowReviewCodex."
    Stop-AutoGoal $script:steps "prepared_without_full_cycle" $true 0
}

Invoke-CycleCommand 7 "auto-cycle-full" $fullCycleCommandText $autoCycleFullPath $fullCycleArguments

Stop-AutoGoal $script:steps "completed" $true 0


 exited 1 in 2334ms:
2026-06-14T11:52:01.155899Z ERROR codex_core::tools::router: error=Exit code: 1
Wall time: 2.3 seconds
Output:

codex
호출 경로를 보면 `ai-dev-auto-goal.ps1`은 full cycle 래퍼를 호출하고, 그 full cycle에는 자동 완료 단계가 이미 연결되어 있습니다. 다만 일반 `ai-dev-next.ps1`의 
`complete_task` 추천 명령은 commit hash를 넘기지 않아 수동/반자동 경로가 요구사항과 어긋날 수 있어 그 지점을 최소 수정 대상으로 보겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath \"D:\\ai-apps\\plan
pilot-local\\.ai-dev\\queue.json\"" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath \"D:\\ai-apps\\plan
pilot-local\\.ai-dev\\state.json\"" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath \"D:\\ai-apps\\plan
pilot-local\\.ai-dev\\loop-log.md\"" in D:\ai-apps\planpilot-local
 succeeded in 1587ms:
# AI Dev Loop Log

## 2026-06-07 19:59:48 - New goal initialized

- Previous goal: PlanPilot Local 업무 검색/필터 UX 개선
- Previous status: 업무 검색/필터 UX 개선 목표는 진행 중이었으나 Codex CLI 기반 완전 자동화 도입을 위해 잠시 중단함
- New goal: AI Dev Loop Codex CLI 완전 자동화 도입
- Current task: T001 Codex CLI 완전 자동화 정책 문서화
- Scope: Codex CLI를 구현자와 리뷰어로 사용해 AI Dev Loop의 구현, 검증, 리뷰, 커밋, task 완료 처리 자동화 초안을 만든다.
- Known environment: `codex --version`은 `codex-cli 0.133.0`으로 확인되었고, `codex exec`는 현재 저장소에서 파일 수정 없이 응답하는 테스트를 통과했다.
- Excluded: scripts/src/package 파일 수정은 이번 목표 전환 단계에서 하지 않음, build/test 실행 안 함, git add/commit 안 함, Codex CLI 호출 안 함, Cl
ine/Copilot/gh/GPT API 사용 안 함
- Result: `goal.md`, `backlog.md`, `queue.json`, `state.json`, `plan.md`, `test-result.md`, `review.md`, `loop-log.md`를
 새 목표 기준으로 초기화함

## 2026-06-07 21:46:14 - Task completed

- Task: T001 Codex CLI 완전 자동화 정책 문서화
- Result: T001 완료: Codex CLI를 구현자/리뷰어로 사용하는 완전 자동화 정책, 허용/금지 명령, 안전 중단 조건 문서화
- Next task: T002 Codex 구현 실행 스크립트 추가
## 2026-06-07 21:48:36 - Task completed

- Task: T002 Codex 구현 실행 스크립트 추가
- Result: T001 완료: Codex CLI를 구현자/리뷰어로 사용하는 완전 자동화 정책, 허용/금지 명령, 안전 중단 조건 문서화
- Next task: T003 Codex 리뷰 실행 스크립트 추가
## 2026-06-07 21:58:28 - Task completed

- Task: T003 Codex 리뷰 실행 스크립트 추가
- Result: T002 완료: current-task-prompt.md를 codex exec에 전달하는 ai-dev-run-codex.ps1 추가, 문법 검증과 DryRun/Json/dirty 상태 중단 확인
- Next task: T004 full auto-cycle 초안 추가

## 2026-06-07 22:10:00 - Goal expanded

- Goal: AI Dev Loop Codex CLI 완전 자동화 도입
- Change: T001~T006 진행 상태는 유지하고 T007 목표 입력 기반 자동 goal 실행 스크립트 추가 task를 queue에 추가함
- Final target command: `powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalTitle "업무 검색 결과 하
이라이트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -AllowCodex -AllowReviewCodex -AllowCommit -MaxTask
s 1`
- Scope: scripts/src/package 파일은 수정하지 않고 queue, plan, README, 정책 문서에 auto-goal 목표와 안전 기준만 반영함

## 2026-06-07 22:20:00 - State repaired

- Reason: T003 `Codex 리뷰 실행 스크립트 추가`가 `done`으로 표시되어 있었지만 실제 `scripts/ai-dev-run-review-codex.ps1` 산출물이 누락됨
- Change: T003 상태를 `in_progress`로 되돌리고 T004 `full auto-cycle 초안 추가` 상태를 `pending`으로 되돌림
- Current task: T003 Codex 리뷰 실행 스크립트 추가
- Preserved: T001/T002는 `done` 유지, T005/T006/T007은 `pending` 유지, T007 추가 내용 유지
- Excluded: scripts/src/package 파일 수정 없음, git add/commit 없음, Codex CLI 호출 없음

## 2026-06-07 22:35:00 - Task progress

- Task: T003 Codex 리뷰 실행 스크립트 추가
- Result: `scripts/ai-dev-run-review-codex.ps1` 추가, `review-prompt.md`를 Codex CLI에 전달하고 JSON 리뷰를 `review-response.json`
에 저장하며 `-SaveReview`로 `ai-dev-save-review.ps1 -ReviewFile` 흐름에 연결하도록 구현
- Docs: `.ai-dev/README.md`에 DryRun, 기본 실행, `-GenerateReviewPromptIfMissing`, `-SaveReview`, `-AllowDirty` 주의사항을 추가
- Verification: PowerShell 문법 검증 예정. 실제 Codex 실행, build/test/lint, git add/commit은 수행하지 않음

## 2026-06-07 22:23:42 - Task completed

- Task: T003 Codex 리뷰 실행 스크립트 추가
- Result: T003 완료: review-prompt.md를 codex exec에 전달해 JSON 리뷰를 생성하는 ai-dev-run-review-codex.ps1 추가, 문법 검증과 DryRun/Json 확
인
- Next task: T004 full auto-cycle 초안 추가
## 2026-06-07 22:57:13 - Task completed

- Task: T004 full auto-cycle 초안 추가
- Result: T004 완료: make-prompt/run-codex/check/save-diff/make-review-prompt/run-review-codex를 연결하는 ai-dev-auto-cycle-fu
ll.ps1 초안 추가, DryRun/Json/AllowCodex 중단 확인
- Next task: T005 자동 커밋과 task 완료 연결
## 2026-06-08 23:11:23 - Task completed

- Task: T005 자동 커밋과 task 완료 연결
- Result: T004 완료: make-prompt/run-codex/check/save-diff/make-review-prompt/run-review-codex를 연결하는 ai-dev-auto-cycle-fu
ll.ps1 초안 추가, DryRun/Json/AllowCodex 중단 확인
- Next task: T006 작은 앱 task로 end-to-end 검증

## 2026-06-08 23:30:00 - Task progress

- Task: T005 자동 커밋과 task 완료 연결
- Result: `ai-dev-auto-cycle-full.ps1`에서 review pass 이후 package 변경 게이트, `-AllowCommit` 기반 자동 커밋, 커밋 확인 후 complete-task 
실행, `MaxTasks` 반복 구조를 정리함
- Docs: `.ai-dev/README.md`에 DryRun, MaxTasks 1/3, `AllowCodex + AllowReviewCodex + AllowCommit`, 선택 파일 커밋 예시를 추가함
- Verification: PowerShell AST 문법 검증 통과, full auto-cycle DryRun/Json 출력에서 commit 및 complete-task 단계 포함 확인
- Excluded: 실제 Codex 실행, build/test/lint, git add/commit은 수행하지 않음

## 2026-06-09 00:17:52 - Task completed

- Task: T006 작은 앱 task로 end-to-end 검증
- Result: T006 완료: full auto-cycle DryRun/Json 구조 검증 및 Codex runner 인자 길이 버그 수정 확인, 실제 end-to-end 검증은 T007 auto-goal 이후
 작은 앱 목표로 수행
- Next task: T007 목표 입력 기반 자동 goal 실행 스크립트 추가
## 2026-06-09 23:05:15 - Task completed

- Task: T007 목표 입력 기반 자동 goal 실행 스크립트 추가
- Result: T007 완료: 목표 제목/설명 입력 기반 auto-goal 실행 스크립트 추가, DryRun/Json 출력, 입력 검증, dirty 처리, full auto-cycle 연결 및 Codex 리뷰 
pass 확인
- Next task: 없음
## 2026-06-09 23:50:32 - Task completed

- Task: T001 업무 검색창 placeholder 문구 수정
- Result: T001 완료: 업무 검색창 placeholder를 업무명과 프로젝트명 검색 대상에 맞는 명확한 한국어 문구로 개선하고 build 및 Codex 리뷰 결과를 확인함
- Next task: 없음
## 2026-06-10 22:22:07 - Task completed

- Task: T001 리뷰 diff 범위 분리 로직 정리
- Result: T001 완료: 리뷰 diff 생성과 리뷰 프롬프트에서 실제 변경 파일과 .ai-dev 운영 산출물을 분리하고, 앱 변경 중심 리뷰가 가능하도록 개선함
- Next task: 없음

## 2026-06-10 23:09:10 - Task progress

- Task: T001 커밋 해시 상태 기록 흐름 개선
- Result: `ai-dev-auto-cycle-full.ps1`의 commit-result-gate가 커밋 전 HEAD와 커밋 후 HEAD를 비교하고, commit/passed 상태에서 최신 HEAD를 `la
stCommitHash`에 보강하도록 수정함. `ai-dev-complete-task.ps1`은 완료 처리 전 commit/passed 상태에서 기록된 해시가 있거나 HEAD 커밋 시각이 상태 갱신 이후인 경우에만
 `lastCommitHash`를 동기화하도록 수정함
- Verification: 관련 PowerShell 스크립트 2개 AST 문법 검증 통과
- Excluded: build/test/lint, 실제 커밋 생성, git 명령 직접 실행은 수행하지 않음

## 2026-06-10 23:34:13 - Task completed

- Task: T001 커밋 해시 상태 기록 흐름 개선
- Result: T001 완료: 커밋 성공 후 명시적으로 전달된 커밋 해시를 검증하여 state.lastCommitHash에 기록하도록 commit-result-gate와 complete-task 흐름을 개선함
- Next task: 없음
## 2026-06-13 00:33:57 - Task completed

- Task: T001 업무 카드 완료 버튼 문구 수정
- Result: T001 완료: 업무 카드의 미완료 상태 완료 버튼 문구를 더 명확한 한국어 표현으로 개선했으며, 동작 로직이나 구조 변경 없이 UI 문구만 최소 범위로 수정함
- Next task: 없음
## 2026-06-14 20:18:29 - Task completed

- Task: T001 마감 임박 배지 표시 구현
- Result: T001 완료: 미완료 업무 중 마감일이 오늘부터 7일 이내인 경우 업무 카드에 마감 임박 배지를 표시하도록 구현함
- Next task: 없음

 succeeded in 1618ms:
{
    "goalStatus":  "in_progress",
    "currentTaskId":  "T001",
    "currentLoop":  0,
    "maxLoopsPerTask":  2,
    "repeatedFailureCount":  0,
    "lastCommand":  "save-review",
    "lastCommandStatus":  "passed",
    "lastErrorSummary":  "",
    "lastReviewDecision":  "revise",
    "lastReviewSeverity":  "medium",
    "lastCommitHash":  null,
    "startedAt":  "2026-06-14T00:00:00+09:00",
    "updatedAt":  "2026-06-14T11:48:50.3602619+00:00",
    "stopReason":  null
}

 succeeded in 1671ms:
{
    "goalTitle":  "AI Dev Loop pass 이후 자동 완료 처리",
    "goalSource":  ".ai-dev/goal.md",
    "createdAt":  "2026-06-14T00:00:00+09:00",
    "updatedAt":  "2026-06-14T00:00:00+09:00",
    "currentTaskId":  "T001",
    "tasks":  [
                  {
                      "id":  "T001",
                      "title":  "pass 이후 자동 완료 흐름 구현",
                      "description":  "AI Dev Loop 리뷰 결과가 pass일 때 구현 변경사항 커밋, complete-task 호출, .ai-dev 메타 상태 커밋이 순서대로 
실행되도록 기존 루프 흐름에 최소 변경을 적용한다.",
                      "type":  "implementation",
                      "status":  "in_progress",
                      "priority":  "P0",
                      "dependsOn":  [

                                    ],
                      "filesLikelyToChange":  [
                                                  ".ai-dev 관련 루프 실행 스크립트",
                                                  "complete-task 호출부"
                                              ],
                      "verification":  [
                                           "pass 리뷰 결과 시 구현 커밋 해시가 complete-task에 전달되는지 확인한다.",
                                           "task 완료 후 .ai-dev 메타 상태 커밋이 생성되는지 확인한다.",
                                           "pass가 아닌 리뷰 결과에서는 자동 완료 처리가 실행되지 않는지 확인한다."
                                       ],
                      "commitMessage":  "Auto-complete passed dev loop tasks"
                  }
              ]
}

codex
수정은 `scripts/ai-dev-next.ps1` 한 파일로 제한하겠습니다. 이유는 full 자동 루프는 이미 구현 커밋 해시를 `complete-task`에 넘기지만, `pass + clean worktree
 + lastCommitHash` 상태에서 안내되는 완료 명령은 해시를 빠뜨리고 있어 같은 완료 흐름의 호출부가 일관되지 않기 때문입니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\scripts\ai-dev-next.ps1
diff --git a/scripts/ai-dev-next.ps1 b/scripts/ai-dev-next.ps1
index bbb35696034ff87c4a5a321843aba48a663ffcaf..359bb5b3418e18cd2a4b2e1a011acd5e8960c02e
--- a/scripts/ai-dev-next.ps1
+++ b/scripts/ai-dev-next.ps1
@@ -186,8 +186,8 @@
     ) @("먼저 ai-dev-commit.ps1 -DryRun으로 커밋 대상을 확인하는 것을 권장합니다.")
 } elseif ($lastReviewDecision -eq "pass" -and (Test-HasValue $lastCommitHash) -and $hasNoGitChanges) {
     $nextAction = New-NextAction "complete_task" "리뷰와 커밋이 완료되었고 작업 트리가 깨끗합니다." @(
-        'powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary "리뷰 및 커밋 완료"'
-    ) @("다음 pending task로 이동하기 전에 현재 task 결과를 확인하세요.")
+        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 및 커밋 완료`" -Comm
itHash $lastCommitHash"
+    ) @("완료 처리 시 구현 커밋 해시를 함께 전달하세요.")
 } elseif ($hasNoGitChanges -and ($lastCommand -eq "" -or $lastCommand -eq "init" -or $lastCommand -eq "current-task"))
 {
     $nextAction = New-NextAction "run_codex_or_cline" "현재 task 프롬프트는 준비되었고 아직 변경사항이 없습니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1"

diff --git a/scripts/ai-dev-next.ps1 b/scripts/ai-dev-next.ps1
index bbb35696034ff87c4a5a321843aba48a663ffcaf..359bb5b3418e18cd2a4b2e1a011acd5e8960c02e
--- a/scripts/ai-dev-next.ps1
+++ b/scripts/ai-dev-next.ps1
@@ -186,8 +186,8 @@
     ) @("먼저 ai-dev-commit.ps1 -DryRun으로 커밋 대상을 확인하는 것을 권장합니다.")
 } elseif ($lastReviewDecision -eq "pass" -and (Test-HasValue $lastCommitHash) -and $hasNoGitChanges) {
     $nextAction = New-NextAction "complete_task" "리뷰와 커밋이 완료되었고 작업 트리가 깨끗합니다." @(
-        'powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary "리뷰 및 커밋 완료"'
-    ) @("다음 pending task로 이동하기 전에 현재 task 결과를 확인하세요.")
+        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 및 커밋 완료`" -Comm
itHash $lastCommitHash"
+    ) @("완료 처리 시 구현 커밋 해시를 함께 전달하세요.")
 } elseif ($hasNoGitChanges -and ($lastCommand -eq "" -or $lastCommand -eq "init" -or $lastCommand -eq "current-task"))
 {
     $nextAction = New-NextAction "run_codex_or_cline" "현재 task 프롬프트는 준비되었고 아직 변경사항이 없습니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1"

codex
호출부 문구만 바꿨습니다. 이제 PowerShell 파서로 문법만 확인하겠습니다. git, build, lint, test는 프롬프트 제약 때문에 실행하지 않습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '$tokens = $null; $errors = $null; [System.Ma
nagement.Automation.Language.Parser]::ParseFile("D:'"\\ai-apps\\planpilot-local\\scripts\\ai-dev-next.ps1\", [ref]"'$to
kens, [ref]$errors) | Out-Null; if ($errors.Count -gt 0) { $errors | ForEach-Object { $_.Message }; exit 1 } else { "Po
werShell syntax OK" }' in D:\ai-apps\planpilot-local
 succeeded in 1204ms:
PowerShell syntax OK

diff --git a/scripts/ai-dev-next.ps1 b/scripts/ai-dev-next.ps1
index bbb35696034ff87c4a5a321843aba48a663ffcaf..359bb5b3418e18cd2a4b2e1a011acd5e8960c02e
--- a/scripts/ai-dev-next.ps1
+++ b/scripts/ai-dev-next.ps1
@@ -186,8 +186,8 @@
     ) @("먼저 ai-dev-commit.ps1 -DryRun으로 커밋 대상을 확인하는 것을 권장합니다.")
 } elseif ($lastReviewDecision -eq "pass" -and (Test-HasValue $lastCommitHash) -and $hasNoGitChanges) {
     $nextAction = New-NextAction "complete_task" "리뷰와 커밋이 완료되었고 작업 트리가 깨끗합니다." @(
-        'powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary "리뷰 및 커밋 완료"'
-    ) @("다음 pending task로 이동하기 전에 현재 task 결과를 확인하세요.")
+        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 및 커밋 완료`" -Comm
itHash $lastCommitHash"
+    ) @("완료 처리 시 구현 커밋 해시를 함께 전달하세요.")
 } elseif ($hasNoGitChanges -and ($lastCommand -eq "" -or $lastCommand -eq "init" -or $lastCommand -eq "current-task"))
 {
     $nextAction = New-NextAction "run_codex_or_cline" "현재 task 프롬프트는 준비되었고 아직 변경사항이 없습니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1"

codex
문법 검증은 통과했습니다. 최종 보고를 위해 변경된 분기 위치만 다시 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -LiteralPath \"D:\\ai-apps\\pl
anpilot-local\\scripts\\ai-dev-next.ps1\" -Pattern \"complete-task|CommitHash|완료 처리 시\" -Context 2,2" in D:\ai-apps\pla
npilot-local
 succeeded in 1063ms:

  scripts\ai-dev-next.ps1:157:$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastR
eviewDecision } else { "" }
  scripts\ai-dev-next.ps1:158:$lastReviewSeverity = if (Test-HasValue $state.lastReviewSeverity) { [string]$state.lastR
eviewSeverity } else { "" }
> scripts\ai-dev-next.ps1:159:$lastCommitHash = if (Test-HasValue $state.lastCommitHash) { [string]$state.lastCommitHas
h } else { "" }
  scripts\ai-dev-next.ps1:160:$hasGitChanges = $gitStatus -eq "available" -and $gitChangedFilesCount -gt 0
  scripts\ai-dev-next.ps1:161:$hasNoGitChanges = $gitStatus -eq "available" -and $gitChangedFilesCount -eq 0
  scripts\ai-dev-next.ps1:185:        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
  scripts\ai-dev-next.ps1:186:    ) @("먼저 ai-dev-commit.ps1 -DryRun으로 커밋 대상을 확인하는 것을 권장합니다.")
> scripts\ai-dev-next.ps1:187:} elseif ($lastReviewDecision -eq "pass" -and (Test-HasValue $lastCommitHash) -and $hasNo
GitChanges) {
  scripts\ai-dev-next.ps1:188:    $nextAction = New-NextAction "complete_task" "리뷰와 커밋이 완료되었고 작업 트리가 깨끗합니다." @(
> scripts\ai-dev-next.ps1:189:        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -Resul
tSummary `"리뷰 및 커밋 완료`" -CommitHash $lastCommitHash"
> scripts\ai-dev-next.ps1:190:    ) @("완료 처리 시 구현 커밋 해시를 함께 전달하세요.")
  scripts\ai-dev-next.ps1:191:} elseif ($hasNoGitChanges -and ($lastCommand -eq "" -or $lastCommand -eq "init" -or $las
tCommand -eq "current-task")) {
  scripts\ai-dev-next.ps1:192:    $nextAction = New-NextAction "run_codex_or_cline" "현재 task 프롬프트는 준비되었고 아직 변경사항이 없습니다.
" @(
  scripts\ai-dev-next.ps1:237:    lastReviewDecision = $lastReviewDecision
  scripts\ai-dev-next.ps1:238:    lastReviewSeverity = $lastReviewSeverity
> scripts\ai-dev-next.ps1:239:    lastCommitHash = $lastCommitHash
  scripts\ai-dev-next.ps1:240:    gitStatus = $gitStatus
  scripts\ai-dev-next.ps1:241:    gitChangedFilesCount = $gitChangedFilesCount



diff --git a/scripts/ai-dev-next.ps1 b/scripts/ai-dev-next.ps1
index bbb35696034ff87c4a5a321843aba48a663ffcaf..359bb5b3418e18cd2a4b2e1a011acd5e8960c02e
--- a/scripts/ai-dev-next.ps1
+++ b/scripts/ai-dev-next.ps1
@@ -186,8 +186,8 @@
     ) @("먼저 ai-dev-commit.ps1 -DryRun으로 커밋 대상을 확인하는 것을 권장합니다.")
 } elseif ($lastReviewDecision -eq "pass" -and (Test-HasValue $lastCommitHash) -and $hasNoGitChanges) {
     $nextAction = New-NextAction "complete_task" "리뷰와 커밋이 완료되었고 작업 트리가 깨끗합니다." @(
-        'powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary "리뷰 및 커밋 완료"'
-    ) @("다음 pending task로 이동하기 전에 현재 task 결과를 확인하세요.")
+        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 및 커밋 완료`" -Comm
itHash $lastCommitHash"
+    ) @("완료 처리 시 구현 커밋 해시를 함께 전달하세요.")
 } elseif ($hasNoGitChanges -and ($lastCommand -eq "" -or $lastCommand -eq "init" -or $lastCommand -eq "current-task"))
 {
     $nextAction = New-NextAction "run_codex_or_cline" "현재 task 프롬프트는 준비되었고 아직 변경사항이 없습니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1"

codex
변경 완료했습니다.

변경한 파일:
- [scripts/ai-dev-next.ps1](D:/ai-apps/planpilot-local/scripts/ai-dev-next.ps1:187)

구현 요약:
- 기존 `ai-dev-auto-cycle-full.ps1`에는 이미 리뷰 `pass` 이후 구현 커밋, 커밋 해시 확인, `complete-task -CommitHash`, `.ai-dev` 메타 커밋 흐름이 연
결되어 있었습니다.
- 누락되어 있던 일반 next-action 경로를 보완했습니다.
- `pass + lastCommitHash 존재 + clean worktree` 상태에서 추천되는 `complete-task` 명령이 이제 `-CommitHash $lastCommitHash`를 함께 전달합니다.

검증:
- PowerShell AST 문법 검증 통과:
  - `scripts/ai-dev-next.ps1`
- 프롬프트 제약에 따라 `npm run build`, `npm run lint`, `npm run test`, git 명령, 실제 커밋 생성은 실행하지 않았습니다.

남은 위험:
- 실제 pass 리뷰 결과에서 자동 커밋과 메타 커밋이 순서대로 생성되는 end-to-end 검증은 수행하지 않았습니다.
- 현재 상태 파일은 `lastReviewDecision: revise`라 pass 시나리오 실검증에는 별도 상태 준비가 필요합니다.

다음 task로 넘어가도 되는지:
- 코드 변경 기준으로는 넘어가도 됩니다.
- 다만 성공 기준의 실제 커밋 생성 검증은 사용자가 허용한 환경에서 별도로 확인해야 합니다.

`.ai-dev/loop-log.md`에 기록할 작업 요약:
```md
## 2026-06-14 - Task progress

- Task: T001 pass 이후 자동 완료 흐름 구현
- Result: `ai-dev-next.ps1`의 complete_task 추천 명령이 `state.lastCommitHash`를 `-CommitHash`로 전달하도록 수정해, pass 이후 완료 처리 경로에서도
 구현 커밋 해시가 누락되지 않도록 보완함
- Verification: PowerShell AST 문법 검증 통과
- Excluded: build/test/lint, 실제 git commit, end-to-end 자동 커밋 검증은 수행하지 않음
```
diff --git a/scripts/ai-dev-next.ps1 b/scripts/ai-dev-next.ps1
index bbb35696034ff87c4a5a321843aba48a663ffcaf..359bb5b3418e18cd2a4b2e1a011acd5e8960c02e
--- a/scripts/ai-dev-next.ps1
+++ b/scripts/ai-dev-next.ps1
@@ -186,8 +186,8 @@
     ) @("먼저 ai-dev-commit.ps1 -DryRun으로 커밋 대상을 확인하는 것을 권장합니다.")
 } elseif ($lastReviewDecision -eq "pass" -and (Test-HasValue $lastCommitHash) -and $hasNoGitChanges) {
     $nextAction = New-NextAction "complete_task" "리뷰와 커밋이 완료되었고 작업 트리가 깨끗합니다." @(
-        'powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary "리뷰 및 커밋 완료"'
-    ) @("다음 pending task로 이동하기 전에 현재 task 결과를 확인하세요.")
+        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 및 커밋 완료`" -Comm
itHash $lastCommitHash"
+    ) @("완료 처리 시 구현 커밋 해시를 함께 전달하세요.")
 } elseif ($hasNoGitChanges -and ($lastCommand -eq "" -or $lastCommand -eq "init" -or $lastCommand -eq "current-task"))
 {
     $nextAction = New-NextAction "run_codex_or_cline" "현재 task 프롬프트는 준비되었고 아직 변경사항이 없습니다." @(
         "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1"

tokens used
46,605
변경 완료했습니다.

변경한 파일:
- [scripts/ai-dev-next.ps1](D:/ai-apps/planpilot-local/scripts/ai-dev-next.ps1:187)

구현 요약:
- 기존 `ai-dev-auto-cycle-full.ps1`에는 이미 리뷰 `pass` 이후 구현 커밋, 커밋 해시 확인, `complete-task -CommitHash`, `.ai-dev` 메타 커밋 흐름이 연결되어 있었습니다.
- 누락되어 있던 일반 next-action 경로를 보완했습니다.
- `pass + lastCommitHash 존재 + clean worktree` 상태에서 추천되는 `complete-task` 명령이 이제 `-CommitHash $lastCommitHash`를 함께 전달합니다.

검증:
- PowerShell AST 문법 검증 통과:
  - `scripts/ai-dev-next.ps1`
- 프롬프트 제약에 따라 `npm run build`, `npm run lint`, `npm run test`, git 명령, 실제 커밋 생성은 실행하지 않았습니다.

남은 위험:
- 실제 pass 리뷰 결과에서 자동 커밋과 메타 커밋이 순서대로 생성되는 end-to-end 검증은 수행하지 않았습니다.
- 현재 상태 파일은 `lastReviewDecision: revise`라 pass 시나리오 실검증에는 별도 상태 준비가 필요합니다.

다음 task로 넘어가도 되는지:
- 코드 변경 기준으로는 넘어가도 됩니다.
- 다만 성공 기준의 실제 커밋 생성 검증은 사용자가 허용한 환경에서 별도로 확인해야 합니다.

`.ai-dev/loop-log.md`에 기록할 작업 요약:
```md
## 2026-06-14 - Task progress

- Task: T001 pass 이후 자동 완료 흐름 구현
- Result: `ai-dev-next.ps1`의 complete_task 추천 명령이 `state.lastCommitHash`를 `-CommitHash`로 전달하도록 수정해, pass 이후 완료 처리 경로에서도 구현 커밋 해시가 누락되지 않도록 보완함
- Verification: PowerShell AST 문법 검증 통과
- Excluded: build/test/lint, 실제 git commit, end-to-end 자동 커밋 검증은 수행하지 않음
```

```