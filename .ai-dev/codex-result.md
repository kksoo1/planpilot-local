# Codex Implementation Result

## Run

- Started at: 2026-06-07 22:58:54
- Ended at: 2026-06-07 23:04:11
- Exit code: 0
- Prompt: .ai-dev/current-task-prompt.md
- Command: codex exec <content from .ai-dev/current-task-prompt.md plus safety rules>

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
session id: 019ea261-2436-7163-86a0-ea5663975656
--------
user
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# Goal

AI Dev Loop Codex CLI 완전 자동화 도입

## Background

Codex CLI를 사용해 AI Dev Loop의 구현, 검증, 리뷰, 커밋, task 완료 처리를 가능한 한 end-to-end로 자동화한다.

`current-task-prompt.md`를 Codex CLI에 전달해 코드 수정을 수행하고, `review-prompt.md`를 Codex CLI에 전달해 JSON 리뷰를 
생성한 뒤, `pass`, `revise`, `blocked` 결과에 따라 자동 분기한다.

초기 버전은 안전을 위해 `MaxTasks 1`, 명시적 Allow 옵션, git status clean 확인, package 변경 감지 중단, build 실패 시 commit
 금지 정책을 적용한다.

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

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

- scripts/ai-dev-auto-cycle-full.ps1
- .ai-dev/README.md

## Verification

- pass가 아니면 commit하지 않는지 확인
- build 실패 시 commit하지 않는지 확인
- package 파일 변경 감지 시 중단하는지 확인
- complete-task가 pass 이후에만 실행되는지 확인
- PowerShell 문법 검증

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

## Codex CLI Additional Safety Rules

- git commit을 실행하지 않는다.
- git reset, git checkout, git clean을 실행하지 않는다.
- npm install을 실행하지 않는다.
- package.json 또는 package-lock.json을 수정하지 않는다. 꼭 필요하면 작업을 중단하고 이유만 기록한다.
- 현재 task 범위 밖 작업을 하지 않는다.
- build, test, lint는 이 프롬프트가 명시적으로 요청하지 않는 한 실행하지 않는다.
codex
작업 범위가 `scripts/ai-dev-auto-cycle-full.ps1`와 `.ai-dev/README.md`로 보입니다. 먼저 현재 스크립트와 문서의 구조를 읽고, T0
05 완료 조건에 이미 맞춰진 부분과 빠진 연결 지점만 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content -Path scrip
ts/ai-dev-auto-cycle-full.ps1' in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content -Path .ai-d
ev/README.md' in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-ChildItem -Path scr
ipts -Filter *.ps1' in D:\ai-apps\planpilot-local
 succeeded in 3593ms:
param(
    [int]$MaxTasks = 1,
    [int]$MaxSteps = 20,
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowCodex,
    [switch]$AllowReviewCodex,
    [switch]$AllowCommit,
    [switch]$AllowDirty
)

. $PSScriptRoot\ai-dev-env.ps1

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$queuePath = Join-Path $repoRoot $queueRelativePath
$statePath = Join-Path $repoRoot $stateRelativePath

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
        $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-Object -F
irst 1

        if ($null -ne $inProgressTask) {
            $currentTaskId = [string]$inProgressTask.id
        } else {
            $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Object -Firs
t 1

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

    if ($AllowCommit) {
        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
    }
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
        $script:steps += New-StepResult $StepNumber $Name $Command $false $true 0 "DryRun: 하위 스크립트
를 실행하지 않았습니다."
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
    }
} catch {
    $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mess
age
    Stop-Cycle $script:steps "prepare_failed" $false 1
}

$plannedSteps = @(
    "make-prompt",
    "run-codex",
    "check",
    "save-diff",
    "make-review-prompt",
    "run-review-codex"
)

if ($plannedSteps.Count -gt $MaxSteps) {
    Stop-Cycle $script:steps "max_steps_too_small_for_full_cycle" $false 1
}

if ($MaxTasks -gt 1) {
    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 ta
sk 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
}

$stepNumber = 1
Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai
-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
$stepNumber++

if (-not $AllowCodex) {
    $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allow
Codex -AllowReviewCodex -MaxTasks $MaxTasks"
    if ($AllowDirty) {
        $command = "$command -AllowDirty"
    }

    $script:steps += New-StepResult $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass -F
ile scripts/ai-dev-run-codex.ps1" $false $true 1 "Codex 구현 실행에는 -AllowCodex가 필요합니다. 추천 명령: $comman
d"
    Stop-Cycle $script:steps "allow_codex_required" $false 1
}

$runCodexArguments = @()
if ($AllowDirty) {
    $runCodexArguments += "-AllowDirty"
}

Invoke-CycleCommand $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-d
ev-run-codex.ps1" $scriptPaths.runCodex $runCodexArguments
$stepNumber++

Invoke-CycleCommand $stepNumber "check" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-c
heck.ps1 -BuildOnly" $scriptPaths.check @("-BuildOnly")
$stepNumber++

Invoke-CycleCommand $stepNumber "save-diff" "powershell -ExecutionPolicy Bypass -File scripts/ai-d
ev-save-diff.ps1" $scriptPaths.saveDiff @()
$stepNumber++

Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File scr
ipts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
$stepNumber++

if (-not $AllowReviewCodex) {
    $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allow
Codex -AllowReviewCodex -MaxTasks $MaxTasks"
    if ($AllowDirty) {
        $command = "$command -AllowDirty"
    }

    $script:steps += New-StepResult $stepNumber "run-review-codex" "powershell -ExecutionPolicy By
pass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 1 "Codex 리뷰 실
행에는 -AllowReviewCodex가 필요합니다. 추천 명령: $command"
    Stop-Cycle $script:steps "allow_review_codex_required" $false 1
}

Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scrip
ts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirty
", "-SaveReview")

$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
if ($AllowCommit) {
    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
}

$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-com
mit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0

 succeeded in 3595ms:


    디렉터리: D:\ai-apps\planpilot-local\scripts


Mode                 LastWriteTime         Length Name                                            
                     
----                 -------------         ------ ----                                            
                     
-a----        2026-06-07  오후 10:30           9919 ai-dev-auto-cycle-full.ps1                      
                     
-a----        2026-06-07   오후 3:14           5451 ai-dev-auto-cycle.ps1                           
                     
-a----        2026-06-07   오후 3:03           8471 ai-dev-auto-step.ps1                            
                     
-a----        2026-06-07   오후 4:07           7762 ai-dev-check.ps1                                
                     
-a----        2026-06-03  오후 11:54          10635 ai-dev-commit.ps1                               
                     
-a----        2026-06-03  오후 10:14           5440 ai-dev-complete-task.ps1                        
                     
-a----        2026-06-04   오후 4:24           3805 ai-dev-copy-review-prompt.ps1                   
                     
-a----        2026-06-03  오후 10:14           5446 ai-dev-current-task.ps1                         
                     
-a----        2026-06-03  오후 10:14            309 ai-dev-env.ps1                                  
                     
-a----        2026-06-03  오후 10:14           3085 ai-dev-init.ps1                                 
                     
-a----        2026-06-04  오전 12:01           7243 ai-dev-make-prompt.ps1                          
                     
-a----        2026-06-03  오후 10:14           8050 ai-dev-make-review-prompt.ps1                   
                     
-a----        2026-06-03  오후 10:14          11227 ai-dev-make-revise-prompt.ps1                   
                     
-a----        2026-06-03  오후 10:14           2692 ai-dev-manual-cycle.ps1                         
                     
-a----        2026-06-03  오후 10:14          12771 ai-dev-next.ps1                                 
                     
-a----        2026-06-07   오후 9:55           6510 ai-dev-run-codex.ps1                            
                     
-a----        2026-06-07  오후 10:19          12076 ai-dev-run-review-codex.ps1                     
                     
-a----        2026-06-03  오후 11:44          10302 ai-dev-save-diff.ps1                            
                     
-a----        2026-06-07   오후 3:57          13077 ai-dev-save-review.ps1                          
                     
-a----        2026-06-03  오후 10:14          10013 ai-dev-status.ps1                               
                     
-a----        2026-05-24   오후 1:50           9682 monitor-and-dev-loop.ps1                        
                     



 succeeded in 3698ms:
# PlanPilot Local AI 개발 입력 폴더

이 폴더는 PlanPilot Local의 Level 5 AI 자동 개발 루프에서 목표와 후속 작업 후보를 관리하기 위한 기본 공간이다.

현재 단계에서는 사용자 입력 템플릿과 수동 AI Dev 루프 보조 스크립트를 제공한다. Codex CLI 완전 자동화 실행기는 다음 목표에서 단계적으로 도입하며, 각 task 
전환 전에는 `goal.md`, `queue.json`, `state.json`을 확인한다.

## 사람이 직접 관리하는 파일

### `goal.md`

현재 자동 개발 루프가 수행할 하나의 목표를 작성한다.

- 목표는 결과 중심으로 작성한다.
- 완료 기준, 제약 조건, 범위 밖 항목, 수동 검증 방법을 함께 적는다.
- 한 번에 하나의 명확한 목표만 유지한다.
- 저장소의 `AGENTS.md`와 `docs/ai-dev-loop-policy.md`를 위반하는 목표는 실행하지 않는다.

### `backlog.md`

추후 검토할 목표 후보와 아이디어를 우선순위별로 기록한다.

- backlog 항목은 자동 실행이 확정된 task가 아니다.
- 현재 단계에서는 AI가 backlog에서 다음 목표를 자동 선택하지 않는다.
- 실행할 항목은 사용자가 검토한 뒤 `goal.md`로 옮긴다.

## AI가 추후 생성하거나 수정할 파일

실제 자동 개발 루프를 구현하는 단계에서는 AI가 다음 파일을 생성하거나 갱신할 수 있다.

- `plan.md`
- `queue.json`
- `state.json`
- `test-result.md`
- `review.md`
- `loop-log.md`

이 파일들은 목표 분석, task queue, 실행 상태, 검증 결과, 리뷰 결과, 실행 이력을 기록하기 위한 파일이다.

현재 단계에서는 위 파일을 만들지 않는다.

## 구조 예시 파일

- `queue.example.json`: `goal.md`를 task 단위로 분해한 `queue.json` 구조 예시다.
- `state.example.json`: 자동 개발 루프의 현재 진행 상태를 기록할 `state.json` 구조 예시다.

예시 파일은 실제 실행 상태가 아니며, 초기화 스크립트가 `queue.json`과 `state.json`을 만들 때 복사 원본으로 사용한다.

## UTF-8 콘솔 설정

AI Dev PowerShell 스크립트의 UTF-8 콘솔 설정은 `scripts/ai-dev-env.ps1`에서 자동 처리한다. 사용자가 매번 `chcp 65001`을 직접 
실행할 필요는 없다.

기존에 한글이 깨진 `.ai-dev/*.md` 상태 파일은 필요한 경우 다음 명령으로 재초기화할 수 있다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-init.ps1 -Force
```

## 실행 파일 초기화

프로젝트 루트에서 다음 명령을 실행하면 실제 실행용 상태 파일과 기본 Markdown 템플릿을 생성한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-init.ps1
```

이미 생성된 파일을 덮어쓰려면 `-Force` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-init.ps1 -Force
```

초기화 스크립트는 Codex 실행, GPT 리뷰, build/test 실행, git commit을 수행하지 않는다.

## 현재 task 확인

`queue.json`과 `state.json`에서 현재 수행할 task를 사람이 읽기 쉬운 형태로 확인한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-current-task.ps1
```

현재 task 정보를 JSON으로 출력하려면 `-Json` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-current-task.ps1 -Json
```

현재 task 확인 스크립트는 상태 파일을 수정하지 않으며, Codex 실행, GPT 리뷰, build/test 실행, git commit을 수행하지 않는다.

## 현재 task 프롬프트 생성

`goal.md`, `queue.json`, `state.json`을 읽어 현재 task만 수행하도록 지시하는 `.ai-dev/current-task-prompt.md` 파일을
 생성한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1
```

프롬프트 생성 스크립트는 기존 `current-task-prompt.md`를 현재 task 기준으로 덮어쓴다. Codex 실행, GPT 리뷰, build/test 실행, git
 commit은 수행하지 않는다.

기본 추가 지시 파일인 `.ai-dev/extra-instructions.md`가 있으면 해당 내용을 프롬프트 끝의 `Extra Instructions` 섹션에 포함한다. 이 
파일이 없으면 기존과 동일하게 goal, queue, state만 사용해 프롬프트를 생성한다.

다른 추가 지시 파일을 사용하려면 `-ExtraInstructionsPath`를 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1 -ExtraInstructionsPath .ai
-dev/extra-instructions.example.md
```

추가 지시는 goal, queue, state 내용을 덮어쓰지 않는다. `current-task-prompt.md`를 직접 수정하지 말고, 반복해서 필요한 보조 지시는 `.ai
-dev/extra-instructions.md` 또는 별도 파일에 작성한다.

## task 완료 처리

현재 task를 완료 처리하고 다음 pending task로 이동하려면 다음 명령을 실행한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary "T001 분석 
완료"
```

특정 task를 완료 처리하려면 `-TaskId`를 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -TaskId T001 -ResultSumm
ary "분석 완료"
```

다음 task로 자동 이동하지 않으려면 `-NoNext` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -NoNext
```

task 완료 처리 스크립트는 `queue.json`, `state.json`, `loop-log.md`만 갱신한다. Codex 실행, GPT 리뷰, build/test 실행,
 git commit은 수행하지 않는다.

## 프로젝트 검증 실행

`package.json`에 정의된 build, test, lint script를 확인하고 실행 결과를 `test-result.md`와 `state.json`에 기록한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1
```

build만 실행하려면 `-BuildOnly` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly
```

필요한 검증을 개별적으로 건너뛰려면 `-SkipBuild`, `-SkipTest`, `-SkipLint` 옵션을 사용한다.

검증 실행 스크립트는 Codex 실행, GPT 리뷰, git commit을 수행하지 않는다.

T006 같은 최종 검증 task에서 PowerShell 문법 검증, `auto-step`/`auto-cycle` DryRun, `save-review` 성공/실패 흐름 확인 
결과를 사람이 직접 수행했다면 수동 요약만 `test-result.md`에 기록할 수 있다. 이 모드는 npm build/test/lint를 실행하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -ManualSummaryOnly -ManualSummar
y "PowerShell 문법 검증 통과. auto-step DryRun 통과. auto-cycle DryRun 통과. save-review 실패/성공 흐름 확인."
```

수동 요약 모드는 실제 명령 실행 결과를 조작하는 용도가 아니다. 실행하지 않은 검증은 통과로 적지 말고, 수행한 명령과 결과만 요약한다.

이 모드에서 `state.json`의 `lastCommandStatus`는 수동 요약 기록 작업의 성공 여부를 뜻한다. 실제 검증 통과/실패/미수행 판단은 `test-resul
t.md`의 요약 본문에 명확히 적는다.

## git diff 저장

현재 git 변경사항을 `diff.md`에 저장해 GPT 리뷰 또는 사람 검토에 사용할 수 있게 한다. 기본 동작은 untracked 파일명을 git status에 표시하지만 
파일 내용은 포함하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1
```

추적되지 않은 작은 텍스트 파일의 내용도 포함하려면 `-IncludeUntrackedContent` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1 -IncludeUntrackedContent
```

git diff 저장 스크립트는 `diff.md`와 `state.json`만 갱신한다. Codex 실행, GPT 리뷰, build/test 실행, git commit은 수행하지
 않는다.

다음 생성 산출물은 자기 중첩과 과도한 크기 증가를 줄이기 위해 Unstaged/Staged Diff와 Diff Stat 대상에서 기본 제외한다. tracked 변경 파일은 `
Skipped Generated AI Dev Artifact Diffs` 섹션에 파일명만 기록한다. `-IncludeUntrackedContent`를 사용한 경우 untrack
ed 생성 산출물도 내용 포함에서 제외하고 `Skipped Generated AI Dev Artifacts` 섹션에 파일명만 기록한다.

- `.ai-dev/diff.md`
- `.ai-dev/review-prompt.md`
- `.ai-dev/current-task-prompt.md`
- `.ai-dev/revise-prompt.md`
- `.ai-dev/test-result.md`
- `.ai-dev/review.md`
- `.ai-dev/review-response.json`

git diff/stat 명령의 stderr 경고는 diff 본문과 분리한다. git 명령이 실패하면 기존처럼 `state.json`에 실패 결과를 기록하고 종료한다.

`Git Status` 섹션에는 생성 산출물을 포함한 전체 변경 파일을 그대로 표시한다. `.ai-dev/README.md`, `scripts/ai-dev-save-diff.p
s1`처럼 실제 작업 대상 파일은 위 제외 목록에 없으므로 diff 본문에 포함된다.

## GPT 리뷰 프롬프트 생성

현재 goal, task, 검증 결과, git diff를 포함한 GPT 코드 리뷰용 `review-prompt.md`를 생성한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1
```

더 엄격한 판정 기준을 포함하려면 `-Strict` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict
```

리뷰 프롬프트 생성 스크립트는 GPT API 호출, Codex 실행, build/test 실행, git commit을 수행하지 않는다.

## 수동 GPT 리뷰 브리지

GPT API 키가 없는 환경에서는 ChatGPT 웹 화면을 사용해 리뷰를 수동으로 진행한다. AI Dev Loop는 prompt 생성과 저장 흐름만 돕고, ChatGPT 웹 
화면에 자동 접속하거나 GPT API를 직접 호출하지 않는다.

기본 흐름:

1. `ai-dev-make-review-prompt.ps1 -Strict`로 `.ai-dev/review-prompt.md`를 생성한다.
2. `review-prompt.md` 내용을 클립보드에 복사한다.
3. 사용자가 ChatGPT 웹 화면에 직접 붙여넣는다.
4. ChatGPT가 JSON 리뷰만 출력하도록 한다.
5. 사용자가 JSON 리뷰를 클립보드에 복사한다.
6. `ai-dev-save-review.ps1 -FromClipboard`로 리뷰를 저장한다.
7. 저장된 decision에 따라 `pass`, `revise`, `blocked` 흐름을 계속 진행한다.

현재 task의 다음 단계에서는 `review-prompt.md` 클립보드 복사를 돕는 helper를 추가할 예정이다. 그 전까지는 파일 내용을 직접 복사하거나 운영 환경에 맞
는 안전한 방법으로 클립보드에 옮긴다.

`review-prompt.md`가 이미 있으면 다음 명령으로 내용을 클립보드에 복사한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1
```

`review-prompt.md`가 없을 때 생성 후 복사하려면 `-GenerateIfMissing`을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1 -GenerateIfMissing
```

엄격한 리뷰 프롬프트를 생성한 뒤 복사하려면 `-Strict`를 함께 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1 -GenerateIfMissing 
-Strict
```

자동화에서 결과만 읽고 싶으면 `-Json` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1 -Json
```

복사 후에는 ChatGPT 웹 화면에 붙여넣고, JSON 리뷰만 출력하도록 요청한다. 리뷰 JSON을 받은 뒤에는 아래 명령으로 저장한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard
```

주의:

- `review-prompt.md`에는 diff와 테스트 결과가 포함될 수 있다.
- API Key, 개인정보, 백업 데이터, 민감한 로컬 경로가 포함되어 있으면 ChatGPT에 붙여넣지 않는다.
- prompt가 너무 길거나 민감 정보가 의심되면 diff 범위를 줄인 뒤 다시 생성한다.
- `ai-dev-auto-step.ps1`는 `ask_gpt_review` 상태에서 GPT API를 호출하지 않고 수동 브리지 안내만 해야 한다.

## GPT 리뷰 결과 저장

GPT Chat 또는 외부 리뷰어가 반환한 리뷰 JSON을 `review.md`에 저장하고, decision과 severity를 `state.json`에 반영한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -ReviewFile .ai-dev/review
-response.json
```

JSON 문자열이나 클립보드 내용을 직접 사용할 수도 있다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -ReviewJson '{"decision":"
pass","severity":"none","summary":"OK","required_changes":[],"optional_suggestions":[],"next_step"
:"complete_task"}'
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard
```

ChatGPT 웹 화면에서 받은 리뷰를 저장할 때는 JSON 리뷰 전체를 클립보드에 복사한 뒤 `-FromClipboard`를 실행한다. 순수 JSON 객체, `json` 코드
블록, 일반 텍스트 안에 포함된 첫 번째 JSON 객체를 최대한 파싱한다.

저장 실패 시 확인할 항목:

- 클립보드가 비어 있지 않은지 확인한다.
- ChatGPT 응답에서 JSON 객체 전체를 다시 복사한다.
- Markdown 코드블록을 포함해도 되지만, 가능하면 JSON만 복사한다.
- 오류 메시지의 입력 preview 앞부분을 보고 다른 설명 문장이나 잘린 JSON이 섞였는지 확인한다.

파싱 실패, 빈 입력, 필수 필드 누락 같은 입력 오류는 기본적으로 `review.md`와 `state.json`을 수정하지 않는다. review-prompt나 명령어를 실수로
 클립보드에 둔 상태에서 `-FromClipboard`를 실행해도 기존 리뷰 상태를 blocked/critical로 덮어쓰지 않기 위한 안전 동작이다.

실패 자체를 리뷰 결과로 기록해야 하는 특별한 경우에만 `-WriteFailureReview`를 함께 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard -WriteFailu
reReview
```

잘못 실행했다면 ChatGPT가 출력한 JSON 리뷰만 다시 클립보드에 복사한 뒤 `-FromClipboard`를 재실행한다.

리뷰 결과 저장 스크립트는 `pass + complete_task`, `revise + revise_with_codex`, `blocked` 또는 `stop_for_user` 
결과에 맞는 다음 행동을 안내만 한다. GPT API 호출, Codex 실행, build/test 실행, git commit은 수행하지 않는다.

## 리뷰 반영 재수정 프롬프트 생성

`review.md`의 required changes를 반영하도록 Codex 또는 Cline에 전달할 `revise-prompt.md`를 생성한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1
```

optional suggestions도 현재 task 범위 안에서 반영할 수 있게 하려면 `-AllowOptionalSuggestions` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1 -AllowOptionalSugge
stions
```

재수정 프롬프트 생성 스크립트는 Codex 실행, GPT API 호출, build/test 실행, git commit을 수행하지 않는다.

## task 단위 자동 커밋

검증과 리뷰를 통과한 현재 변경사항을 task 단위로 커밋한다. 먼저 `-DryRun`으로 커밋 대상과 메시지를 확인하는 것을 권장한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -DryRun
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1
```

지정한 파일만 커밋 대상으로 확인하거나 실제로 커밋하려면 `-Files` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -Files scripts/ai-dev-commit.ps
1,.ai-dev/README.md -DryRun
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -Files scripts/ai-dev-commit.ps
1,.ai-dev/README.md
```

커밋 메시지를 직접 지정하거나 검증·리뷰 게이트를 명시적으로 우회할 수도 있다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -Message "chore(ai-dev): add au
tomation helpers"
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -AllowWithoutPassedCheck -Allow
WithoutPassedReview
```

`-Files`를 지정하지 않으면 자동 커밋 스크립트는 기존처럼 `git add -A`로 현재 작업 트리의 모든 변경사항을 stage한다. `-Files`를 지정하면 각 파일이
 존재하고 변경사항이 있는지 확인한 뒤 `git add -- <files>`로 지정 파일만 stage한다. 선택 파일 외에 이미 staged 된 파일이 있으면 안전을 위해 중단
한다.

실행 전 예상하지 못한 사용자 변경이 없는지 반드시 확인한다. Codex 실행, GPT API 호출, build/test 실행은 수행하지 않는다.

## 실행 산출물 커밋 기준

AI Dev Loop의 실제 기능 변경과 `.ai-dev` 실행 상태는 가능한 한 별도 커밋으로 관리한다.

- 기능 커밋에는 현재 task의 코드와 직접 관련 문서만 포함한다.
- 루프 상태 커밋에는 필요할 때 `queue.json`, `state.json`, `loop-log.md`, `test-result.md`, `review.md` 등을 포함할
 수 있다.
- `diff.md`와 `review-prompt.md`는 커질 수 있으므로 항상 커밋하지 않는다.
- `review-response.json`은 민감 정보나 장문 내용이 포함될 수 있으므로 내용을 확인한 뒤 커밋 여부를 결정한다.
- untracked 텍스트 파일 내용은 리뷰에 필요할 수 있지만, 리뷰 포함 여부와 커밋 대상 여부는 별도로 판단한다.
- 대형 또는 민감 산출물은 정리하거나 별도 정책에 따라 제외한다.

커밋 전에는 `git status --short`와 `ai-dev-commit.ps1 -DryRun`으로 대상을 먼저 확인한다. 선택 파일 커밋 기능이 준비되면 전체 stage
보다 선택 파일 방식을 우선한다.

세부 기준은 `docs/ai-dev-loop-policy.md`의 `.ai-dev` 실행 산출물 커밋/무시 정책을 따른다. 실제 `.gitignore` 변경은 별도 task에서
 검토한다.

## 자동 개발 루프 상태 요약

현재 queue, state, git 변경사항, 테스트 결과, 리뷰 결과를 한 번에 확인한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1
```

상태 요약을 JSON으로 출력하려면 `-Json` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1 -Json
```

상태 요약 스크립트는 파일을 수정하지 않으며, Codex 실행, GPT API 호출, build/test 실행, git add, git commit을 수행하지 않는다.

## 다음 행동 안내

현재 queue, state, review, test, git 상태를 확인해 다음에 실행할 추천 명령을 출력한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-next.ps1
```

다음 행동 안내를 JSON으로 출력하려면 `-Json` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-next.ps1 -Json
```

다음 행동 안내 스크립트는 추천 명령만 출력하며, Codex 실행, GPT API 호출, build/test 실행, git add, git commit을 수행하지 않는다.

## 수동 사이클 안내

상태 요약과 다음 행동 안내를 한 번에 확인하고, 관련 프롬프트·결과 파일의 존재 여부를 표시한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-manual-cycle.ps1
```

상태와 다음 행동을 하나의 JSON 객체로 출력하려면 `-Json` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-manual-cycle.ps1 -Json
```

수동 사이클 안내 스크립트는 추천 명령과 파일 경로만 보여주며, Codex 실행, GPT API 호출, build/test 실행, git add, git commit을 수행하지
 않는다.

`manual-cycle`에서 다음 action이 `ask_gpt_review`로 표시되면 수동 리뷰 브리지를 사용한다. GPT API 키가 없어도 아래 흐름으로 리뷰를 진행할
 수 있다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-manual-cycle.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1
```

1. `manual-cycle`에서 현재 task와 다음 action이 `ask_gpt_review`인지 확인한다.
2. `ai-dev-copy-review-prompt.ps1`로 `review-prompt.md`를 클립보드에 복사한다.
3. ChatGPT 웹 화면에 붙여넣고 JSON 리뷰만 출력하도록 요청한다.
4. ChatGPT가 반환한 JSON 리뷰를 클립보드에 복사한다.
5. 아래 명령으로 리뷰 결과를 저장한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard
```

리뷰 저장 후 decision별 다음 단계:

- `pass`: `ai-dev-complete-task.ps1` 실행 또는 커밋 조건을 검토한다.
- `revise`: `ai-dev-make-revise-prompt.ps1`로 재수정 프롬프트를 만든 뒤 Codex/Cline에 수동 전달한다.
- `blocked`: 사용자 판단이 필요하므로 루프를 중단하고 요구사항이나 범위를 조정한다.

`review-prompt.md`에는 diff, 테스트 결과, 로컬 경로, 민감 정보가 포함될 수 있다. ChatGPT에 붙여넣기 전에 사용자가 공유 범위를 확인해야 한다.

## 자동 실행 단계 정책

`ai-dev-auto-step.ps1`는 현재 상태를 보고 안전한 다음 한 단계만 실행하는 보조 스크립트로 도입할 예정이다. `ai-dev-next.ps1`처럼 안내만 하는 
명령과 달리, 허용된 로컬 스크립트는 직접 실행할 수 있다.

명령 선택 기준:

| 상황 | 사용할 명령 | 이유 |
| --- | --- | --- |
| 현재 상태와 다음 행동을 한 화면에서 보고 싶을 때 | `scripts/ai-dev-manual-cycle.ps1` | 상태 요약, 다음 action, 관련 파일 존재 여부
를 함께 보여주는 수동 운영 대시보드다. |
| 다음 action과 추천 명령만 확인하고 싶을 때 | `scripts/ai-dev-next.ps1` | 읽기/안내용 스크립트이며 하위 명령을 자동 실행하지 않는다. |
| 안전한 다음 한 단계만 자동으로 진행하고 싶을 때 | `scripts/ai-dev-auto-step.ps1` | `next` 판단 결과를 기반으로 허용된 로컬 스크립트만 한
 번 실행한다. |
| 여러 안전 단계를 제한 횟수 안에서 이어가고 싶을 때 | `scripts/ai-dev-auto-cycle.ps1` | auto-step 반복용이며 사용자 개입 필요 상태에서
 중단한다. |

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -DryRun
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -Json
```

검증, diff 저장, 리뷰 프롬프트 생성처럼 기본 자동 실행보다 한 단계 위험한 로컬 작업은 명시적 허용 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -AllowCheck
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -AllowSaveDiff
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -AllowReviewPrompt
```

초기 auto-step 자동 실행 허용 후보:

- `current-task-prompt.md`가 없을 때 `scripts/ai-dev-make-prompt.ps1`
- 명시적으로 안전한 옵션이 선택된 경우 `scripts/ai-dev-check.ps1`
- diff 저장이 필요한 경우 `scripts/ai-dev-save-diff.ps1`
- review prompt 생성이 필요한 경우 `scripts/ai-dev-make-review-prompt.ps1`

auto-step이 직접 실행하지 않고 중단 또는 안내해야 하는 단계:

- Codex 또는 Cline 작업
- GPT 리뷰
- blocked 상태
- revise 반영
- git commit
- 사용자 데이터 삭제, 복원, 마이그레이션 위험이 있는 작업

`ask_gpt_review` 상태에서 auto-step은 GPT API를 호출하지 않고 수동 리뷰 브리지 명령을 안내한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -Json
```

안내에 포함되는 수동 리뷰 브리지 명령:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard
```

첫 번째 명령으로 `review-prompt.md`를 클립보드에 복사한 뒤 ChatGPT 웹 화면에 붙여넣는다. ChatGPT가 JSON 리뷰만 출력하면 그 JSON을 다시 클
립보드에 복사하고 두 번째 명령으로 저장한다.

`ai-dev-auto-cycle.ps1`는 제한 횟수 안에서 auto-step을 반복하는 초기 자동화 스크립트다. 사용자 개입이 필요한 action, 실패, 반복 위험, co
mmit 필요 상태에서는 중단한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -DryRun
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -MaxSteps 3
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -Json
```

auto-cycle에서 check, diff 저장, review prompt 생성을 허용하려면 auto-step과 같은 허용 옵션을 전달한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -AllowCheck
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -AllowSaveDiff
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -AllowReviewPrompt
```

auto-cycle은 Codex/Cline 작업, GPT 리뷰, revise, commit, blocked, 사용자 개입 필요 action에서 멈춘다. 무한 루프를 피하기 위해
 `-MaxSteps` 제한과 같은 action 반복 감지를 사용한다.

auto-cycle이 `ask_gpt_review`에서 멈추면 `stoppedReason`은 `user_intervention_required:ask_gpt_review`로 표
시된다. 이때 텍스트 출력과 JSON 출력의 step 항목에는 수동 리뷰 브리지 명령이 함께 표시된다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard
```

첫 번째 명령으로 `review-prompt.md`를 ChatGPT 웹 화면에 붙여넣을 수 있도록 복사하고, JSON 리뷰를 받은 뒤 두 번째 명령으로 클립보드의 리뷰 JSON
을 저장한다. auto-cycle은 이 단계에서 GPT API를 호출하지 않고 중단한다.

명령 역할 구분:

- `ai-dev-next.ps1`: 현재 상태를 읽고 다음 추천 action과 명령만 출력한다. 자동 실행하지 않는다.
- `ai-dev-manual-cycle.ps1`: `status`와 `next`를 함께 보여주는 수동 운영 대시보드다. 자동 실행하지 않는다.
- `ai-dev-auto-step.ps1`: `next` 판단 결과를 기반으로 안전한 action 한 단계만 자동 실행한다. 위험 action은 실행하지 않고 안내 후 중단한
다.
- `ai-dev-auto-cycle.ps1`: 제한 횟수 안에서 auto-step을 반복한다. 사용자 개입 필요 action에서 중단한다.

auto-step과 auto-cycle은 Codex/GPT API 호출, git commit, git push를 자동 실행하지 않는다.

## 수동 자동화 UX 판단 순서

GPT API 없이 수동 자동화 흐름을 운영할 때는 먼저 상태를 읽고, 그 다음 안전한 DryRun으로 다음 행동을 확인한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-next.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-manual-cycle.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -DryRun
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -DryRun -MaxSteps 3
```

확인 기준:

- `goal_completed`: 더 이상 실행할 task가 없으므로 새 goal 초기화가 필요하다.
- `ask_gpt_review`: `ai-dev-copy-review-prompt.ps1`와 `ai-dev-save-review.ps1 -FromClipboard`를 사용해 
수동 리뷰 브리지로 진행한다.
- `revise`: `ai-dev-make-revise-prompt.ps1`로 재수정 프롬프트를 만든다.
- `blocked`: 사용자 판단이 필요하므로 자동 진행을 멈춘다.
- `commit`: 자동 실행하지 않고 커밋 조건과 대상 파일을 사람이 확인한다.

`goal_completed` 상태에서 `auto-step`은 추가 작업을 실행하지 않고 현재 goal이 완료되었으며 더 실행할 task가 없다고 안내한다. 추천 명령에는 상태
 확인용 `ai-dev-status.ps1`만 포함한다.

`auto-cycle`이 `goal_completed`로 멈추면 텍스트 출력에서는 “목표 완료로 종료” 의미를 표시하고, JSON 출력에서는 `completed: true`, 
`stoppedReason: "goal_completed"`를 유지한다. 다음 목표를 시작하려면 `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.a
i-dev/state.json`을 새 목표 기준으로 초기화한다.

`save-review` 실패는 잘못된 클립보드 입력 때문에 발생할 수 있다. 실패 시에는 오류 preview를 확인하고 JSON 리뷰만 다시 복사한다. 완료된 goal이나 기
존 정상 상태를 불필요하게 오염시키지 않도록 실패 기록 방식은 별도 정책에 따라 개선한다.

최종 검증 task에서는 PowerShell 문법 검증, `auto-step`/`auto-cycle` DryRun, `save-review` 성공/실패 흐름 확인 결과를 `te
st-result.md`에 남기는 것을 원칙으로 한다. 실행하지 않은 검증은 통과로 기록하지 않는다.

## Codex CLI 완전 자동화 준비

다음 자동화 단계에서는 Codex CLI를 구현자와 리뷰어로 사용한다. GPT API Key, Cline, Copilot CLI, `gh` 없이 Codex CLI만 사용한다.

현재 전제:

- `codex-cli 0.133.0` 사용 가능
- `codex exec` 동작 확인 완료
- approval: `never`
- sandbox: `workspace-write`
- workdir: `D:\ai-apps\planpilot-local`
- Cline은 삭제되어 사용하지 않음
- Copilot CLI와 `gh`는 현재 사용하지 않음

도입 예정 스크립트:

- `scripts/ai-dev-run-codex.ps1`: `.ai-dev/current-task-prompt.md`를 Codex CLI에 전달해 현재 task 구현을 수행한
다.
- `scripts/ai-dev-run-review-codex.ps1`: `.ai-dev/review-prompt.md`를 Codex CLI에 전달해 JSON 리뷰를 생성하고 
저장 흐름에 연결한다.
- `scripts/ai-dev-auto-cycle-full.ps1`: prompt 생성, Codex 구현, check, diff 저장, Codex 리뷰, save-review
, pass 시 commit/complete-task를 연결한다.
- `scripts/ai-dev-auto-goal.ps1`: 사용자가 `GoalTitle`과 `GoalDescription`만 입력하면 goal/queue/state 생성, c
urrent-task-prompt 생성, full auto-cycle 실행까지 이어지게 한다.

초기 안전 기준:

- full cycle은 처음에 `MaxTasks 1` 중심으로 제한한다.
- Codex 구현 실행은 `AllowCodex`가 있을 때만 수행한다.
- Codex 리뷰 실행은 `AllowReviewCodex`가 있을 때만 수행한다.
- git commit은 `AllowCommit`이 있을 때만 수행한다.
- auto-goal에서 실제 full cycle 실행은 `AllowRun` 또는 명시적 실행 옵션이 있을 때만 수행한다.
- git status가 dirty이면 Codex 구현 실행을 기본 중단한다.
- build/check 실패, package 파일 변경, 리뷰 decision이 `pass`가 아닌 경우 자동 커밋하지 않는다.
- `git reset`, `git clean`, `npm install`, `git push`는 자동 실행하지 않는다.

자동화 로그와 결과 파일:

- `.ai-dev/codex-result.md`: Codex 구현 실행 결과
- `.ai-dev/review-response.json`: Codex 리뷰 JSON 원문
- `.ai-dev/review.md`: 저장된 리뷰 요약
- `.ai-dev/test-result.md`: check/build 또는 수동 검증 요약
- `.ai-dev/loop-log.md`: 루프 진행 기록
- `.ai-dev/state.json`: 현재 상태와 마지막 실패 요약

### Codex 구현 실행

`.ai-dev/current-task-prompt.md`를 Codex CLI에 전달해 현재 task 구현을 실행한다. 실행 전 `git status --short`를 확인하고
, 작업 트리가 dirty이면 기본 중단한다. 단, dirty 파일이 `.ai-dev/current-task-prompt.md`뿐이면 프롬프트 생성 산출물로 보고 진행할 수 있
다.

실행 예정 정보만 확인하려면 `-DryRun`을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -DryRun
```

기본 실행은 `codex exec`를 호출하고 stdout/stderr를 `.ai-dev/codex-result.md`에 저장한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1
```

`current-task-prompt.md`가 없을 때 자동 생성까지 허용하려면 `-GeneratePromptIfMissing`을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -GeneratePromptIfMissing
```

자동화에서 결과만 읽고 싶으면 `-Json`을 함께 사용할 수 있다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -DryRun -Json
```

dirty worktree에서도 실행해야 하는 특별한 경우에만 `-AllowDirty`를 명시한다. 이 옵션은 사용자 변경과 Codex 변경이 섞일 수 있으므로 full cyc
le에서는 초기 기본값으로 사용하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty
```

이 스크립트는 Codex에 전달하는 프롬프트 끝에 추가 안전 규칙을 붙인다. git commit, git reset, git clean, npm install, package 
파일 수정, 현재 task 범위 밖 작업을 금지한다. 스크립트 자체도 build/test/lint, git add, git commit을 실행하지 않는다.

### Codex 리뷰 실행

`.ai-dev/review-prompt.md`를 Codex CLI에 전달해 JSON 리뷰를 생성하고 `.ai-dev/review-response.json`에 저장한다. 실행 
전 `git status --short`를 확인하고, 작업 트리가 dirty이면 기본 중단한다. 리뷰 대상 변경사항이 남아 있는 상태에서 실행해야 하는 경우에만 `-AllowD
irty`를 명시한다.

실행 예정 정보만 확인하려면 `-DryRun`을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -DryRun
```

기본 실행은 `codex exec`를 호출하고 stdout/stderr를 `.ai-dev/codex-review-result.md`에 저장한다. Codex 출력에서 첫 번째 유
효 JSON 리뷰 객체를 추출해 `.ai-dev/review-response.json`에 저장한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1
```

`review-prompt.md`가 없을 때 자동 생성까지 허용하려면 `-GenerateReviewPromptIfMissing`를 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -GenerateReviewPrompt
IfMissing
```

리뷰 JSON 저장 후 `ai-dev-save-review.ps1 -ReviewFile .ai-dev/review-response.json` 흐름까지 이어가려면 `-SaveRe
view`를 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveRevi
ew
```

자동화에서 결과만 읽고 싶으면 `-Json`을 함께 사용할 수 있다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -DryRun -Json
```

주의:

- Codex 리뷰 실행 프롬프트에는 파일 수정 금지, git 명령 금지, build/test/lint 실행 금지, JSON 객체만 출력하라는 안전 규칙을 추가한다.
- JSON 리뷰에는 `decision`, `severity`, `summary`, `required_changes`, `optional_suggestions`, `next_s
tep` 필드가 필요하다.
- JSON 추출에 실패하면 출력 preview를 보여주고 종료 코드 1로 종료한다.
- `-AllowDirty`는 구현 변경사항을 리뷰해야 할 때만 사용한다. 사용자 변경과 자동화 산출물이 섞여 있으면 리뷰 결과와 후속 저장 상태가 혼동될 수 있다.
- 이 스크립트는 git add, git commit, build/test/lint, GPT API 호출을 수행하지 않는다.

### full auto-cycle 초안

`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revie
w prompt 생성, Codex JSON 리뷰와 save-review 흐름을 순서대로 연결하는 초안이다.

T004 버전의 실행 단계:

1. `ai-dev-make-prompt.ps1`
2. `ai-dev-run-codex.ps1`
3. `ai-dev-check.ps1 -BuildOnly`
4. `ai-dev-save-diff.ps1`
5. `ai-dev-make-review-prompt.ps1 -Strict`
6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`

먼저 DryRun으로 전체 단계를 확인한다. DryRun은 하위 스크립트를 실제 실행하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun
```

자동화 도구에서 결과만 파싱해야 하면 `-Json`을 함께 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -Json
```

기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, T004 초안은 task 완료 처리
를 하지 않으므로 실제로는 현재 task 한 개만 다룬다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -M
axSteps 20
```

`-AllowCodex` 없이 실제 실행하면 prompt 생성 이후 Codex 구현 실행 직전에서 중단하고 추천 명령을 출력한다. Codex 구현까지 허용하려면 명시적으로 `-
AllowCodex`를 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex
```

Codex 구현과 Codex 리뷰까지 이어가려면 `-AllowCodex`와 `-AllowReviewCodex`를 함께 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRevi
ewCodex -MaxTasks 1
```

dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-co
dex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRevi
ewCodex -AllowDirty -MaxTasks 1
```

`-AllowCommit` 옵션은 T004에서 파라미터와 출력만 제공한다. 실제 `ai-dev-commit.ps1` 실행과 `ai-dev-complete-task.ps1` 연결
은 T005에서 구현한다. 따라서 T004 full auto-cycle은 리뷰 저장 후에도 git add, git commit, complete-task를 수행하지 않는다.

### 목표 입력 기반 자동 실행

최종 목표는 사용자가 goal 파일과 queue 파일을 직접 편집하지 않고도 한 줄 명령으로 작은 앱 기능 task를 시작할 수 있게 하는 것이다.

예상 최종 명령:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalTitle "업무 검색 결과 하이라이트
 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -AllowCodex -AllowReviewCodex -All
owCommit -MaxTasks 1
```

예정 동작:

1. `GoalTitle`과 `GoalDescription`을 검증한다.
2. Codex CLI를 이용해 goal/queue/state 초안을 생성한다.
3. 생성된 JSON을 파싱해 필수 필드를 확인한다.
4. `.ai-dev/current-task-prompt.md`를 생성한다.
5. 명시적 실행 옵션이 있을 때만 `ai-dev-auto-cycle-full.ps1`로 이어간다.

안전 기준:

- `GoalTitle` 또는 `GoalDescription`이 비어 있으면 종료한다.
- DryRun에서는 생성될 goal/task 계획과 실행 단계만 표시한다.
- Json 출력은 사람이 읽는 텍스트와 섞지 않는다.
- 생성된 goal/queue/state JSON 파싱에 실패하면 실제 실행으로 넘어가지 않는다.
- full cycle 호출은 `-AllowRun` 또는 그에 준하는 명시적 실행 옵션이 있을 때만 수행한다.
- package 파일 변경, build/check 실패, 리뷰 `pass` 아님, dirty worktree 위험이 있으면 자동 커밋하지 않는다.

## 운영 원칙

- 저장소의 `AGENTS.md`, 사용자 지시, 보안 정책이 자동 개발 루프보다 우선한다.
- 한 번에 하나의 task만 수행한다.
- task 단위로 구현, 검증, 리뷰, 커밋한다.
- 현재 task 범위 밖 파일을 임의로 수정하지 않는다.
- 검증하지 않은 결과를 통과로 기록하지 않는다.
- 실제 DB 삭제, 초기화, 복원, 대규모 리팩터링은 초기 실험 범위에서 제외한다.

## 다음 단계

실제 자동 개발 루프 실행기와 상태 갱신 로직은 별도 정책 검토 후 추가한다.

세부 기준은 `docs/ai-dev-loop-policy.md`를 따른다.

codex
현재 full cycle은 T004 자리표시자에서 멈추고, `-AllowCommit`도 실제 사용하지 않는 상태입니다. 커밋 스크립트와 task 완료 스크립트의 파라미터/게이트
를 확인한 뒤 full cycle에 최소 연결만 추가하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Select-String -Path scr
ipts/ai-dev-complete-task.ps1 -Pattern "param|ResultSummary|TaskId|loop-log|queue|state" -Context 
0,3' in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Select-String -Path scr
ipts/ai-dev-save-review.ps1 -Pattern "lastReview|decision|next_step|state" -Context 0,3' in D:\ai-
apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Select-String -Path scr
ipts/ai-dev-commit.ps1 -Pattern "param|Files|DryRun|package|lastCommandStatus|lastReview|AllowWith
out" -Context 0,3' in D:\ai-apps\planpilot-local
 succeeded in 2602ms:

> scripts\ai-dev-complete-task.ps1:1:param(
> scripts\ai-dev-complete-task.ps1:2:    [string]$TaskId,
> scripts\ai-dev-complete-task.ps1:3:    [string]$ResultSummary,
  scripts\ai-dev-complete-task.ps1:4:    [switch]$NoNext
  scripts\ai-dev-complete-task.ps1:5:)
  scripts\ai-dev-complete-task.ps1:6:
> scripts\ai-dev-complete-task.ps1:10:$queueRelativePath = ".ai-dev/queue.json"
> scripts\ai-dev-complete-task.ps1:11:$stateRelativePath = ".ai-dev/state.json"
> scripts\ai-dev-complete-task.ps1:12:$loopLogRelativePath = ".ai-dev/loop-log.md"
  scripts\ai-dev-complete-task.ps1:13:
> scripts\ai-dev-complete-task.ps1:14:$queuePath = Join-Path $projectRoot $queueRelativePath
> scripts\ai-dev-complete-task.ps1:15:$statePath = Join-Path $projectRoot $stateRelativePath
  scripts\ai-dev-complete-task.ps1:16:$loopLogPath = Join-Path $projectRoot $loopLogRelativePath
  scripts\ai-dev-complete-task.ps1:17:$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
  scripts\ai-dev-complete-task.ps1:18:
> scripts\ai-dev-complete-task.ps1:20:    param(
  scripts\ai-dev-complete-task.ps1:21:        [string]$Message
  scripts\ai-dev-complete-task.ps1:22:    )
  scripts\ai-dev-complete-task.ps1:23:
> scripts\ai-dev-complete-task.ps1:29:    param(
  scripts\ai-dev-complete-task.ps1:30:        [string]$Path,
  scripts\ai-dev-complete-task.ps1:31:        [string]$RelativePath
  scripts\ai-dev-complete-task.ps1:32:    )
> scripts\ai-dev-complete-task.ps1:42:    param(
  scripts\ai-dev-complete-task.ps1:43:        [object]$Value
  scripts\ai-dev-complete-task.ps1:44:    )
  scripts\ai-dev-complete-task.ps1:45:
> scripts\ai-dev-complete-task.ps1:58:    param(
  scripts\ai-dev-complete-task.ps1:59:        [object]$InputObject,
  scripts\ai-dev-complete-task.ps1:60:        [string]$Name,
  scripts\ai-dev-complete-task.ps1:61:        [object]$Value
> scripts\ai-dev-complete-task.ps1:72:    param(
  scripts\ai-dev-complete-task.ps1:73:        [string]$Path,
  scripts\ai-dev-complete-task.ps1:74:        [object]$Value
  scripts\ai-dev-complete-task.ps1:75:    )
> scripts\ai-dev-complete-task.ps1:81:foreach ($requiredPath in @($queueRelativePath, $stateRelati
vePath, $loopLogRelat
ivePath)) {
  scripts\ai-dev-complete-task.ps1:82:    $fullPath = Join-Path $projectRoot $requiredPath
  scripts\ai-dev-complete-task.ps1:83:
  scripts\ai-dev-complete-task.ps1:84:    if (-not (Test-Path -LiteralPath $fullPath -PathType Lea
f)) {
> scripts\ai-dev-complete-task.ps1:89:$queue = Read-JsonFile $queuePath $queueRelativePath
> scripts\ai-dev-complete-task.ps1:90:$state = Read-JsonFile $statePath $stateRelativePath
  scripts\ai-dev-complete-task.ps1:91:
> scripts\ai-dev-complete-task.ps1:92:if (-not ($queue.PSObject.Properties.Name -contains "tasks")
) {
> scripts\ai-dev-complete-task.ps1:93:    Stop-WithError "$queueRelativePath 필수 필드가 누락되었습니다: tasks
"
  scripts\ai-dev-complete-task.ps1:94:}
  scripts\ai-dev-complete-task.ps1:95:
> scripts\ai-dev-complete-task.ps1:96:if ($null -eq $queue.tasks -or -not ($queue.tasks -is [Syste
m.Collections.IEnumer
able])) {
> scripts\ai-dev-complete-task.ps1:97:    Stop-WithError "$queueRelativePath tasks 필드는 배열이어야 합니다."
  scripts\ai-dev-complete-task.ps1:98:}
  scripts\ai-dev-complete-task.ps1:99:
> scripts\ai-dev-complete-task.ps1:100:$tasks = @($queue.tasks)
> scripts\ai-dev-complete-task.ps1:101:$targetTaskId = $null
  scripts\ai-dev-complete-task.ps1:102:
> scripts\ai-dev-complete-task.ps1:103:if (Test-HasValue $TaskId) {
> scripts\ai-dev-complete-task.ps1:104:    $targetTaskId = $TaskId
> scripts\ai-dev-complete-task.ps1:105:} elseif (Test-HasValue $state.currentTaskId) {
> scripts\ai-dev-complete-task.ps1:106:    $targetTaskId = [string]$state.currentTaskId
> scripts\ai-dev-complete-task.ps1:107:} elseif (Test-HasValue $queue.currentTaskId) {
> scripts\ai-dev-complete-task.ps1:108:    $targetTaskId = [string]$queue.currentTaskId
  scripts\ai-dev-complete-task.ps1:109:} else {
  scripts\ai-dev-complete-task.ps1:110:    $fallbackTask = $tasks |
  scripts\ai-dev-complete-task.ps1:111:        Where-Object { $_.status -eq "in_progress" -or $_.s
tatus -eq "pending" }
 |
> scripts\ai-dev-complete-task.ps1:115:        $targetTaskId = [string]$fallbackTask.id
  scripts\ai-dev-complete-task.ps1:116:    }
  scripts\ai-dev-complete-task.ps1:117:}
  scripts\ai-dev-complete-task.ps1:118:
> scripts\ai-dev-complete-task.ps1:119:if (-not (Test-HasValue $targetTaskId)) {
  scripts\ai-dev-complete-task.ps1:120:    Stop-WithError "완료 처리할 task가 없습니다."
  scripts\ai-dev-complete-task.ps1:121:}
  scripts\ai-dev-complete-task.ps1:122:
> scripts\ai-dev-complete-task.ps1:123:$completedTask = $tasks | Where-Object { $_.id -eq $targetT
askId } | Select-Obje
ct -First 1
  scripts\ai-dev-complete-task.ps1:124:
  scripts\ai-dev-complete-task.ps1:125:if ($null -eq $completedTask) {
> scripts\ai-dev-complete-task.ps1:126:    Stop-WithError "완료 처리할 task를 찾을 수 없습니다: $targetTaskId"
  scripts\ai-dev-complete-task.ps1:127:}
  scripts\ai-dev-complete-task.ps1:128:
  scripts\ai-dev-complete-task.ps1:129:$now = [DateTimeOffset]::UtcNow.ToString("o")
> scripts\ai-dev-complete-task.ps1:130:$summary = if (Test-HasValue $ResultSummary) { $ResultSumma
ry } else { "완료 처리됨" 
}
  scripts\ai-dev-complete-task.ps1:131:
  scripts\ai-dev-complete-task.ps1:132:Set-ObjectProperty $completedTask "status" "done"
  scripts\ai-dev-complete-task.ps1:133:Set-ObjectProperty $completedTask "completedAt" $now
> scripts\ai-dev-complete-task.ps1:135:if (Test-HasValue $ResultSummary) {
> scripts\ai-dev-complete-task.ps1:136:    Set-ObjectProperty $completedTask "resultSummary" $Resu
ltSummary
  scripts\ai-dev-complete-task.ps1:137:}
  scripts\ai-dev-complete-task.ps1:138:
  scripts\ai-dev-complete-task.ps1:139:$nextTask = $null
> scripts\ai-dev-complete-task.ps1:146:    Set-ObjectProperty $queue "currentTaskId" $null
> scripts\ai-dev-complete-task.ps1:147:    Set-ObjectProperty $state "currentTaskId" $null
> scripts\ai-dev-complete-task.ps1:148:    Set-ObjectProperty $state "goalStatus" "in_progress"
> scripts\ai-dev-complete-task.ps1:149:    Set-ObjectProperty $state "stopReason" "manual_next_sel
ection_required"
  scripts\ai-dev-complete-task.ps1:150:} elseif ($null -ne $nextTask) {
  scripts\ai-dev-complete-task.ps1:151:    Set-ObjectProperty $nextTask "status" "in_progress"
> scripts\ai-dev-complete-task.ps1:152:    Set-ObjectProperty $queue "currentTaskId" $nextTask.id
> scripts\ai-dev-complete-task.ps1:153:    Set-ObjectProperty $state "currentTaskId" $nextTask.id
> scripts\ai-dev-complete-task.ps1:154:    Set-ObjectProperty $state "goalStatus" "in_progress"
> scripts\ai-dev-complete-task.ps1:155:    Set-ObjectProperty $state "stopReason" $null
  scripts\ai-dev-complete-task.ps1:156:} else {
> scripts\ai-dev-complete-task.ps1:157:    Set-ObjectProperty $queue "currentTaskId" $null
> scripts\ai-dev-complete-task.ps1:158:    Set-ObjectProperty $state "currentTaskId" $null
> scripts\ai-dev-complete-task.ps1:159:    Set-ObjectProperty $state "goalStatus" "completed"
> scripts\ai-dev-complete-task.ps1:160:    Set-ObjectProperty $state "stopReason" "all_tasks_compl
eted"
  scripts\ai-dev-complete-task.ps1:161:}
  scripts\ai-dev-complete-task.ps1:162:
> scripts\ai-dev-complete-task.ps1:163:Set-ObjectProperty $queue "updatedAt" $now
> scripts\ai-dev-complete-task.ps1:164:Set-ObjectProperty $state "updatedAt" $now
> scripts\ai-dev-complete-task.ps1:165:Set-ObjectProperty $state "lastCommand" "complete-task"
> scripts\ai-dev-complete-task.ps1:166:Set-ObjectProperty $state "lastCommandStatus" "passed"
> scripts\ai-dev-complete-task.ps1:167:Set-ObjectProperty $state "lastErrorSummary" ""
  scripts\ai-dev-complete-task.ps1:168:
> scripts\ai-dev-complete-task.ps1:169:Write-JsonFile $queuePath $queue
> scripts\ai-dev-complete-task.ps1:170:Write-JsonFile $statePath $state
  scripts\ai-dev-complete-task.ps1:171:
  scripts\ai-dev-complete-task.ps1:172:$nextTaskText = if ($null -ne $nextTask) {
  scripts\ai-dev-complete-task.ps1:173:    "$($nextTask.id) $($nextTask.title)"
> scripts\ai-dev-complete-task.ps1:192:Write-Host "queue/state 저장 완료"



 succeeded in 2771ms:

> scripts\ai-dev-commit.ps1:1:param(
  scripts\ai-dev-commit.ps1:2:    [string]$Message,
> scripts\ai-dev-commit.ps1:3:    [string[]]$Files,
> scripts\ai-dev-commit.ps1:4:    [switch]$AllowWithoutPassedCheck,
> scripts\ai-dev-commit.ps1:5:    [switch]$AllowWithoutPassedReview,
> scripts\ai-dev-commit.ps1:6:    [switch]$DryRun
  scripts\ai-dev-commit.ps1:7:)
  scripts\ai-dev-commit.ps1:8:
  scripts\ai-dev-commit.ps1:9:. "$PSScriptRoot\ai-dev-env.ps1"
> scripts\ai-dev-commit.ps1:22:    param(
  scripts\ai-dev-commit.ps1:23:        [string]$Message
  scripts\ai-dev-commit.ps1:24:    )
  scripts\ai-dev-commit.ps1:25:
> scripts\ai-dev-commit.ps1:31:    param(
  scripts\ai-dev-commit.ps1:32:        [string]$Path,
  scripts\ai-dev-commit.ps1:33:        [string]$RelativePath
  scripts\ai-dev-commit.ps1:34:    )
> scripts\ai-dev-commit.ps1:44:    param(
  scripts\ai-dev-commit.ps1:45:        [object]$Value
  scripts\ai-dev-commit.ps1:46:    )
  scripts\ai-dev-commit.ps1:47:
> scripts\ai-dev-commit.ps1:60:    param(
  scripts\ai-dev-commit.ps1:61:        [object]$InputObject,
  scripts\ai-dev-commit.ps1:62:        [string]$Name,
  scripts\ai-dev-commit.ps1:63:        [object]$Value
> scripts\ai-dev-commit.ps1:74:    param(
  scripts\ai-dev-commit.ps1:75:        [object]$State,
  scripts\ai-dev-commit.ps1:76:        [string]$Status,
  scripts\ai-dev-commit.ps1:77:        [string]$ErrorSummary,
> scripts\ai-dev-commit.ps1:82:    Set-ObjectProperty $State "lastCommandStatus" $Status
  scripts\ai-dev-commit.ps1:83:    Set-ObjectProperty $State "lastErrorSummary" $ErrorSummary
  scripts\ai-dev-commit.ps1:84:    Set-ObjectProperty $State "updatedAt" ([DateTimeOffset]::UtcNow
.ToString("o"))
  scripts\ai-dev-commit.ps1:85:
> scripts\ai-dev-commit.ps1:95:    param(
  scripts\ai-dev-commit.ps1:96:        [string[]]$Arguments,
  scripts\ai-dev-commit.ps1:97:        [string]$DisplayName
  scripts\ai-dev-commit.ps1:98:    )
> scripts\ai-dev-commit.ps1:166:if (-not $AllowWithoutPassedCheck -and $state.lastCommandStatus -n
e "passed") {
> scripts\ai-dev-commit.ps1:167:    Stop-WithError "state.lastCommandStatus가 passed가 아닙니다. 검증 결과를 
확인하거나 -AllowWithoutPa
ssedCheck를 사용하세요."
  scripts\ai-dev-commit.ps1:168:}
  scripts\ai-dev-commit.ps1:169:
> scripts\ai-dev-commit.ps1:170:if (-not $AllowWithoutPassedReview -and $state.lastReviewDecision 
-ne "pass") {
> scripts\ai-dev-commit.ps1:171:    Stop-WithError "state.lastReviewDecision이 pass가 아닙니다. 리뷰 결과를 확
인하거나 -AllowWithoutPas
sedReview를 사용하세요."
  scripts\ai-dev-commit.ps1:172:}
  scripts\ai-dev-commit.ps1:173:
  scripts\ai-dev-commit.ps1:174:try {
> scripts\ai-dev-commit.ps1:187:$selectedFiles = @()
  scripts\ai-dev-commit.ps1:188:$targetChangeLines = $changeLines
  scripts\ai-dev-commit.ps1:189:
> scripts\ai-dev-commit.ps1:190:if ($null -ne $Files -and $Files.Count -gt 0) {
> scripts\ai-dev-commit.ps1:191:    $requestedFiles = @($Files | ForEach-Object { $_ -split "," } 
| Where-Object { -not
 [string]::IsNullOrWhiteSpace($_) })
  scripts\ai-dev-commit.ps1:192:
> scripts\ai-dev-commit.ps1:193:    if ($requestedFiles.Count -eq 0) {
> scripts\ai-dev-commit.ps1:194:        Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
  scripts\ai-dev-commit.ps1:195:    }
  scripts\ai-dev-commit.ps1:196:
> scripts\ai-dev-commit.ps1:197:    foreach ($file in $requestedFiles) {
  scripts\ai-dev-commit.ps1:198:        if ([string]::IsNullOrWhiteSpace($file)) {
> scripts\ai-dev-commit.ps1:199:            Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
  scripts\ai-dev-commit.ps1:200:        }
  scripts\ai-dev-commit.ps1:201:
  scripts\ai-dev-commit.ps1:202:        $normalizedFile = $file.Replace('\', '/')
> scripts\ai-dev-commit.ps1:215:            $fileStatus = Invoke-GitCapture -Arguments @("status",
 "--porcelain", "--",
 $normalizedFile) -DisplayName "git status --porcelain -- $normalizedFile"
  scripts\ai-dev-commit.ps1:216:        } catch {
  scripts\ai-dev-commit.ps1:217:            Stop-WithError $_.Exception.Message
  scripts\ai-dev-commit.ps1:218:        }
> scripts\ai-dev-commit.ps1:220:        if ([string]::IsNullOrWhiteSpace($fileStatus)) {
  scripts\ai-dev-commit.ps1:221:            Stop-WithError "선택한 파일에 커밋할 변경사항이 없습니다: $file"
  scripts\ai-dev-commit.ps1:222:        }
  scripts\ai-dev-commit.ps1:223:
> scripts\ai-dev-commit.ps1:224:        $selectedFiles += $normalizedFile
  scripts\ai-dev-commit.ps1:225:    }
  scripts\ai-dev-commit.ps1:226:
> scripts\ai-dev-commit.ps1:227:    $selectedFiles = @($selectedFiles | Select-Object -Unique)
> scripts\ai-dev-commit.ps1:228:    $targetChangeLines = @($selectedFiles)
  scripts\ai-dev-commit.ps1:229:
  scripts\ai-dev-commit.ps1:230:    try {
> scripts\ai-dev-commit.ps1:231:        $stagedFiles = Invoke-GitCapture -Arguments @("diff", "--c
ached", "--name-only"
) -DisplayName "git diff --cached --name-only"
  scripts\ai-dev-commit.ps1:232:    } catch {
  scripts\ai-dev-commit.ps1:233:        Stop-WithError $_.Exception.Message
  scripts\ai-dev-commit.ps1:234:    }
> scripts\ai-dev-commit.ps1:236:    $stagedFileList = @($stagedFiles -split "`r?`n" | Where-Object
 { -not [string]::IsN
ullOrWhiteSpace($_) })
> scripts\ai-dev-commit.ps1:237:    $unexpectedStagedFiles = @($stagedFileList | Where-Object { $s
electedFiles -notcont
ains $_ })
  scripts\ai-dev-commit.ps1:238:
> scripts\ai-dev-commit.ps1:239:    if ($unexpectedStagedFiles.Count -gt 0) {
> scripts\ai-dev-commit.ps1:240:        Stop-WithError "선택 파일 외에 이미 staged 된 파일이 있습니다: $($unexpect
edStagedFiles -join '
, ')"
  scripts\ai-dev-commit.ps1:241:    }
  scripts\ai-dev-commit.ps1:242:}
  scripts\ai-dev-commit.ps1:243:
> scripts\ai-dev-commit.ps1:262:if ($DryRun) {
  scripts\ai-dev-commit.ps1:263:    Write-Host "Dry run: git add/commit을 실행하지 않습니다."
  scripts\ai-dev-commit.ps1:264:    Write-Host "커밋 메시지: $commitMessage"
  scripts\ai-dev-commit.ps1:265:    Write-Host "현재 task: $taskText"
> scripts\ai-dev-commit.ps1:275:    if ($selectedFiles.Count -gt 0) {
> scripts\ai-dev-commit.ps1:276:        $addOutput = & git add -- @selectedFiles 2>&1 | Out-String
> scripts\ai-dev-commit.ps1:277:        $addDisplayName = "git add -- <selected files>"
  scripts\ai-dev-commit.ps1:278:    } else {
  scripts\ai-dev-commit.ps1:279:        $addOutput = & git add -A 2>&1 | Out-String
  scripts\ai-dev-commit.ps1:280:        $addDisplayName = "git add -A"
> scripts\ai-dev-commit.ps1:287:    if ($selectedFiles.Count -gt 0) {
> scripts\ai-dev-commit.ps1:288:        $stagedFilesAfterAdd = Invoke-GitCapture -Arguments @("dif
f", "--cached", "--na
me-only") -DisplayName "git diff --cached --name-only"
> scripts\ai-dev-commit.ps1:289:        $stagedFileListAfterAdd = @($stagedFilesAfterAdd -split "`
r?`n" | Where-Object 
{ -not [string]::IsNullOrWhiteSpace($_) })
> scripts\ai-dev-commit.ps1:290:        $unexpectedStagedFilesAfterAdd = @($stagedFileListAfterAdd
 | Where-Object { $se
lectedFiles -notcontains $_ })
  scripts\ai-dev-commit.ps1:291:
> scripts\ai-dev-commit.ps1:292:        if ($unexpectedStagedFilesAfterAdd.Count -gt 0) {
> scripts\ai-dev-commit.ps1:293:            throw "선택 파일 외의 staged 파일이 감지되었습니다: $($unexpectedStage
dFilesAfterAdd -join 
', ')"
  scripts\ai-dev-commit.ps1:294:        }
  scripts\ai-dev-commit.ps1:295:    }
  scripts\ai-dev-commit.ps1:296:



 succeeded in 2836ms:

> scripts\ai-dev-save-review.ps1:11:$stateRelativePath = ".ai-dev/state.json"
  scripts\ai-dev-save-review.ps1:12:$reviewRelativePath = ".ai-dev/review.md"
> scripts\ai-dev-save-review.ps1:13:$statePath = Join-Path $projectRoot $stateRelativePath
  scripts\ai-dev-save-review.ps1:14:$reviewPath = Join-Path $projectRoot $reviewRelativePath
  scripts\ai-dev-save-review.ps1:15:$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
  scripts\ai-dev-save-review.ps1:16:$codeFence = '```'
> scripts\ai-dev-save-review.ps1:70:function Save-StateReviewResult {
  scripts\ai-dev-save-review.ps1:71:    param(
> scripts\ai-dev-save-review.ps1:72:        [object]$State,
> scripts\ai-dev-save-review.ps1:73:        [string]$Decision,
  scripts\ai-dev-save-review.ps1:74:        [string]$Severity,
  scripts\ai-dev-save-review.ps1:75:        [string]$CommandStatus,
  scripts\ai-dev-save-review.ps1:76:        [string]$ErrorSummary
> scripts\ai-dev-save-review.ps1:79:    Set-ObjectProperty $State "lastReviewDecision" $Decision
> scripts\ai-dev-save-review.ps1:80:    Set-ObjectProperty $State "lastReviewSeverity" $Severity
> scripts\ai-dev-save-review.ps1:81:    Set-ObjectProperty $State "lastCommand" "save-review"
> scripts\ai-dev-save-review.ps1:82:    Set-ObjectProperty $State "lastCommandStatus" $CommandStat
us
> scripts\ai-dev-save-review.ps1:83:    Set-ObjectProperty $State "lastErrorSummary" $ErrorSummary
> scripts\ai-dev-save-review.ps1:84:    Set-ObjectProperty $State "updatedAt" ([DateTimeOffset]::U
tcNow.ToString("o"))
  scripts\ai-dev-save-review.ps1:85:
> scripts\ai-dev-save-review.ps1:86:    $stateJson = $State | ConvertTo-Json -Depth 20
> scripts\ai-dev-save-review.ps1:87:    [System.IO.File]::WriteAllText($statePath, $stateJson, $ut
f8WithBom)
  scripts\ai-dev-save-review.ps1:88:}
  scripts\ai-dev-save-review.ps1:89:
  scripts\ai-dev-save-review.ps1:90:function Get-ReviewInput {
> scripts\ai-dev-save-review.ps1:108:        Write-Host '  powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-save
-review.ps1 -ReviewJson ''{"decision":"pass","severity":"none","summary":"OK","required_changes":[
],"optional_suggestio
ns":[],"next_step":"complete_task"}'''
  scripts\ai-dev-save-review.ps1:109:        Write-Host "  powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-save
-review.ps1 -FromClipboard"
  scripts\ai-dev-save-review.ps1:110:        Stop-WithError "리뷰 입력을 지정해야 합니다."
  scripts\ai-dev-save-review.ps1:111:    }
> scripts\ai-dev-save-review.ps1:282:        "decision",
  scripts\ai-dev-save-review.ps1:283:        "severity",
  scripts\ai-dev-save-review.ps1:284:        "summary",
  scripts\ai-dev-save-review.ps1:285:        "required_changes",
> scripts\ai-dev-save-review.ps1:287:        "next_step"
  scripts\ai-dev-save-review.ps1:288:    )
  scripts\ai-dev-save-review.ps1:289:
  scripts\ai-dev-save-review.ps1:290:    foreach ($field in $requiredFields) {
> scripts\ai-dev-save-review.ps1:300:    if (@("pass", "revise", "blocked") -notcontains $Review.d
ecision) {
> scripts\ai-dev-save-review.ps1:301:        $errors += "허용되지 않은 decision: $($Review.decision)"
  scripts\ai-dev-save-review.ps1:302:    }
  scripts\ai-dev-save-review.ps1:303:
  scripts\ai-dev-save-review.ps1:304:    if (@("none", "low", "medium", "high", "critical") -notco
ntains $Review.severi
ty) {
> scripts\ai-dev-save-review.ps1:308:    if (@("complete_task", "revise_with_codex", "stop_for_use
r") -notcontains $Rev
iew.next_step) {
> scripts\ai-dev-save-review.ps1:309:        $errors += "허용되지 않은 next_step: $($Review.next_step)"
  scripts\ai-dev-save-review.ps1:310:    }
  scripts\ai-dev-save-review.ps1:311:
  scripts\ai-dev-save-review.ps1:312:    if ($Review.required_changes -isnot [System.Collections.I
Enumerable] -or $Revi
ew.required_changes -is [string]) {
> scripts\ai-dev-save-review.ps1:362:        [object]$State,
  scripts\ai-dev-save-review.ps1:363:        [string]$RawInput,
  scripts\ai-dev-save-review.ps1:364:        [string]$ErrorSummary
  scripts\ai-dev-save-review.ps1:365:    )
> scripts\ai-dev-save-review.ps1:373:- Decision: blocked
  scripts\ai-dev-save-review.ps1:374:- Severity: critical
  scripts\ai-dev-save-review.ps1:375:- Next step: stop_for_user
  scripts\ai-dev-save-review.ps1:376:- Summary: 리뷰 JSON을 파싱하거나 검증하지 못했습니다.
> scripts\ai-dev-save-review.ps1:390:    Save-StateReviewResult $State "blocked" "critical" "faile
d" $ErrorSummary
  scripts\ai-dev-save-review.ps1:391:}
  scripts\ai-dev-save-review.ps1:392:
  scripts\ai-dev-save-review.ps1:393:function Stop-WithInvalidReviewInput {
> scripts\ai-dev-save-review.ps1:395:        [object]$State,
  scripts\ai-dev-save-review.ps1:396:        [string]$RawInput,
  scripts\ai-dev-save-review.ps1:397:        [string]$ErrorSummary
  scripts\ai-dev-save-review.ps1:398:    )
> scripts\ai-dev-save-review.ps1:401:        Save-InvalidReview $State $RawInput $ErrorSummary
  scripts\ai-dev-save-review.ps1:402:        Stop-WithError "리뷰 JSON 저장에 실패했습니다: $ErrorSummary"
  scripts\ai-dev-save-review.ps1:403:    }
  scripts\ai-dev-save-review.ps1:404:
> scripts\ai-dev-save-review.ps1:405:    Write-Host "리뷰 입력 오류로 review.md와 state.json을 수정하지 않았습니다."
  scripts\ai-dev-save-review.ps1:406:    Write-Host "실패 리뷰를 명시적으로 기록하려면 -WriteFailureReview 옵션을 사용
하세요."
  scripts\ai-dev-save-review.ps1:407:    Stop-WithError "리뷰 JSON 저장에 실패했습니다: $ErrorSummary"
  scripts\ai-dev-save-review.ps1:408:}
> scripts\ai-dev-save-review.ps1:410:if (-not (Test-Path -LiteralPath $statePath -PathType Leaf)) 
{
> scripts\ai-dev-save-review.ps1:411:    Stop-WithError "필수 파일이 없습니다: $stateRelativePath"
  scripts\ai-dev-save-review.ps1:412:}
  scripts\ai-dev-save-review.ps1:413:
> scripts\ai-dev-save-review.ps1:414:$state = Read-JsonFile $statePath $stateRelativePath
  scripts\ai-dev-save-review.ps1:415:$rawReview = Get-ReviewInput
  scripts\ai-dev-save-review.ps1:416:$inputPreview = Get-InputPreview $rawReview
  scripts\ai-dev-save-review.ps1:417:
> scripts\ai-dev-save-review.ps1:420:    Stop-WithInvalidReviewInput $state $rawReview $errorSumma
ry
  scripts\ai-dev-save-review.ps1:421:}
  scripts\ai-dev-save-review.ps1:422:
  scripts\ai-dev-save-review.ps1:423:try {
> scripts\ai-dev-save-review.ps1:433:    Stop-WithInvalidReviewInput $state $rawReview $errorSumma
ry
  scripts\ai-dev-save-review.ps1:434:}
  scripts\ai-dev-save-review.ps1:435:
  scripts\ai-dev-save-review.ps1:436:$prettyJson = $review | ConvertTo-Json -Depth 20
> scripts\ai-dev-save-review.ps1:446:- Decision: $($review.decision)
  scripts\ai-dev-save-review.ps1:447:- Severity: $($review.severity)
> scripts\ai-dev-save-review.ps1:448:- Next step: $($review.next_step)
  scripts\ai-dev-save-review.ps1:449:- Summary: $($review.summary)
  scripts\ai-dev-save-review.ps1:450:
  scripts\ai-dev-save-review.ps1:451:### Required Changes
> scripts\ai-dev-save-review.ps1:467:Save-StateReviewResult $state $review.decision $review.severi
ty "passed" ""
  scripts\ai-dev-save-review.ps1:468:
> scripts\ai-dev-save-review.ps1:469:$nextAction = if ($review.decision -eq "pass" -and $review.ne
xt_step -eq "complete
_task") {
  scripts\ai-dev-save-review.ps1:470:    "pass + complete_task: 다음 명령을 실행해 현재 task 완료 처리를 검토하세요. p
owershell -ExecutionP
olicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 통과`""
> scripts\ai-dev-save-review.ps1:471:} elseif ($review.decision -eq "revise" -and $review.next_ste
p -eq "revise_with_co
dex") {
  scripts\ai-dev-save-review.ps1:472:    "revise + make_revise_prompt: 다음 명령으로 재수정 프롬프트를 생성한 뒤 Cod
ex/Cline에 전달하세요. powe
rshell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1"
> scripts\ai-dev-save-review.ps1:473:} elseif ($review.decision -eq "blocked" -or $review.next_ste
p -eq "stop_for_user"
) {
  scripts\ai-dev-save-review.ps1:474:    "blocked/stop_for_user: 사용자 판단이 필요합니다. 자동 진행을 중단하고 review
.md의 Required Changes
와 Summary를 확인하세요."
  scripts\ai-dev-save-review.ps1:475:} else {
> scripts\ai-dev-save-review.ps1:476:    "decision과 next_step 조합을 확인한 뒤 다음 행동을 결정하세요."
  scripts\ai-dev-save-review.ps1:477:}
  scripts\ai-dev-save-review.ps1:478:
  scripts\ai-dev-save-review.ps1:479:Write-Host "리뷰 저장 완료: $reviewRelativePath"
> scripts\ai-dev-save-review.ps1:480:Write-Host "Decision: $($review.decision)"
  scripts\ai-dev-save-review.ps1:481:Write-Host "Severity: $($review.severity)"
> scripts\ai-dev-save-review.ps1:482:Write-Host "Next step: $($review.next_step)"
  scripts\ai-dev-save-review.ps1:483:Write-Host "안내: $nextAction"



exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content -Path .ai-d
ev/queue.json' in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content -Path scrip
ts/ai-dev-commit.ps1 | Select-Object -First 340' in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content -Path .ai-d
ev/state.json' in D:\ai-apps\planpilot-local
 succeeded in 4378ms:
{
    "goalTitle":  "AI Dev Loop Codex CLI 완전 자동화 도입",
    "goalSource":  ".ai-dev/goal.md",
    "createdAt":  "2026-06-07T19:59:48.1282711+09:00",
    "updatedAt":  "2026-06-07T13:57:13.9217915+00:00",
    "currentTaskId":  "T005",
    "tasks":  [
                  {
                      "id":  "T001",
                      "title":  "Codex CLI 완전 자동화 정책 문서화",
                      "description":  "Codex CLI를 구현자와 리뷰어로 사용하는 완전 자동화 정책, 허용/금지 명령, 안전 중단 조건을 문서
화한다.",
                      "type":  "documentation",
                      "status":  "done",
                      "priority":  "P0",
                      "dependsOn":  [

                                    ],
                      "filesLikelyToChange":  [
                                                  "docs/ai-dev-loop-policy.md",
                                                  ".ai-dev/README.md",
                                                  ".ai-dev/plan.md"
                                              ],
                      "verification":  [
                                           "Codex CLI 사용 방식과 안전 기준이 문서화되었는지 확인",
                                           "Cline/Copilot/GPT API 없이 진행하는 구조가 명확한지 확인"
                                       ],
                      "commitMessage":  "Document Codex CLI automation policy",
                      "completedAt":  "2026-06-07T12:46:13.9691878+00:00",
                      "resultSummary":  "T001 완료: Codex CLI를 구현자/리뷰어로 사용하는 완전 자동화 정책, 허용/금지 명령, 안전
 중단 조건 문서화"
                  },
                  {
                      "id":  "T002",
                      "title":  "Codex 구현 실행 스크립트 추가",
                      "description":  "current-task-prompt.md를 Codex CLI에 전달해 현재 task 구현을 수행하는 ai-
dev-run-codex.ps1을 추가한다.",
                      "type":  "implementation",
                      "status":  "done",
                      "priority":  "P0",
                      "dependsOn":  [
                                        "T001"
                                    ],
                      "filesLikelyToChange":  [
                                                  "scripts/ai-dev-run-codex.ps1",
                                                  ".ai-dev/README.md"
                                              ],
                      "verification":  [
                                           "DryRun에서 실행 예정 명령만 출력되는지 확인",
                                           "current-task-prompt.md가 없으면 명확히 안내하는지 확인",
                                           "git status dirty 상태에서 기본 중단하는지 확인",
                                           "PowerShell 문법 검증"
                                       ],
                      "commitMessage":  "Add Codex task runner",
                      "completedAt":  "2026-06-07T12:48:36.8786703+00:00",
                      "resultSummary":  "T001 완료: Codex CLI를 구현자/리뷰어로 사용하는 완전 자동화 정책, 허용/금지 명령, 안전
 중단 조건 문서화"
                  },
                  {
                      "id":  "T003",
                      "title":  "Codex 리뷰 실행 스크립트 추가",
                      "description":  "review-prompt.md를 Codex CLI에 전달해 JSON 리뷰를 생성하고 review-respo
nse.json 및 save-review 흐름에 연결하는 ai-dev-run-review-codex.ps1을 추가한다.",
                      "type":  "implementation",
                      "status":  "done",
                      "priority":  "P0",
                      "dependsOn":  [
                                        "T002"
                                    ],
                      "filesLikelyToChange":  [
                                                  "scripts/ai-dev-run-review-codex.ps1",
                                                  ".ai-dev/README.md"
                                              ],
                      "verification":  [
                                           "DryRun에서 실행 예정 명령만 출력되는지 확인",
                                           "Codex 출력에서 JSON 객체를 추출해 저장하는지 확인",
                                           "save-review와 연결되는지 확인",
                                           "PowerShell 문법 검증"
                                       ],
                      "commitMessage":  "Add Codex review runner",
                      "completedAt":  "2026-06-07T13:23:42.7240601+00:00",
                      "resultSummary":  "T003 완료: review-prompt.md를 codex exec에 전달해 JSON 리뷰를 생성하는 
ai-dev-run-review-codex.ps1 추가, 문법 검증과 DryRun/Json 확인"
                  },
                  {
                      "id":  "T004",
                      "title":  "full auto-cycle 초안 추가",
                      "description":  "make-prompt, run-codex, check, save-diff, make-review-promp
t, run-review-codex를 연결하는 ai-dev-auto-cycle-full.ps1 초안을 추가한다.",
                      "type":  "implementation",
                      "status":  "done",
                      "priority":  "P0",
                      "dependsOn":  [
                                        "T003"
                                    ],
                      "filesLikelyToChange":  [
                                                  "scripts/ai-dev-auto-cycle-full.ps1",
                                                  ".ai-dev/README.md"
                                              ],
                      "verification":  [
                                           "DryRun에서 전체 단계가 표시되는지 확인",
                                           "MaxTasks 제한이 있는지 확인",
                                           "AllowCodex, AllowReviewCodex, AllowCommit 같은 명시적 옵션이 있
는지 확인",
                                           "PowerShell 문법 검증"
                                       ],
                      "commitMessage":  "Add full AI dev auto cycle draft",
                      "completedAt":  "2026-06-07T13:57:13.9217915+00:00",
                      "resultSummary":  "T004 완료: make-prompt/run-codex/check/save-diff/make-revie
w-prompt/run-review-codex를 연결하는 ai-dev-auto-cycle-full.ps1 초안 추가, DryRun/Json/AllowCodex 중단 확인"
                  },
                  {
                      "id":  "T005",
                      "title":  "자동 커밋과 task 완료 연결",
                      "description":  "리뷰 결과가 pass일 때만 선택 파일 커밋과 complete-task를 수행하도록 full auto-cy
cle에 연결한다.",
                      "type":  "implementation",
                      "status":  "in_progress",
                      "priority":  "P0",
                      "dependsOn":  [
                                        "T004"
                                    ],
                      "filesLikelyToChange":  [
                                                  "scripts/ai-dev-auto-cycle-full.ps1",
                                                  ".ai-dev/README.md"
                                              ],
                      "verification":  [
                                           "pass가 아니면 commit하지 않는지 확인",
                                           "build 실패 시 commit하지 않는지 확인",
                                           "package 파일 변경 감지 시 중단하는지 확인",
                                           "complete-task가 pass 이후에만 실행되는지 확인",
                                           "PowerShell 문법 검증"
                                       ],
                      "commitMessage":  "Connect pass review to auto commit and task completion"
                  },
                  {
                      "id":  "T006",
                      "title":  "작은 앱 task로 end-to-end 검증",
                      "description":  "작은 문서 또는 UI 변경 task를 MaxTasks 1로 실행해 Codex 구현부터 리뷰, 커밋, 완료 
처리까지 검증한다.",
                      "type":  "verification",
                      "status":  "pending",
                      "priority":  "P0",
                      "dependsOn":  [
                                        "T005"
                                    ],
                      "filesLikelyToChange":  [
                                                  ".ai-dev/plan.md",
                                                  ".ai-dev/loop-log.md",
                                                  ".ai-dev/test-result.md"
                                              ],
                      "verification":  [
                                           "full auto-cycle DryRun 확인",
                                           "MaxTasks 1 실제 실행 확인",
                                           "Codex 구현 로그 확인",
                                           "Codex 리뷰 JSON 저장 확인",
                                           "pass 시 커밋/complete-task 확인",
                                           "git status clean 확인"
                                       ],
                      "commitMessage":  null
                  },
                  {
                      "id":  "T007",
                      "title":  "목표 입력 기반 자동 goal 실행 스크립트 추가",
                      "description":  "사용자가 GoalTitle과 GoalDescription만 입력하면 Codex CLI를 이용해 goal/q
ueue/state를 생성하고, current-task-prompt 생성 후 auto-cycle-full을 실행할 수 있게 하는 ai-dev-auto-goal.ps1을 추가한다
.",
                      "type":  "implementation",
                      "status":  "pending",
                      "priority":  "P0",
                      "dependsOn":  [
                                        "T005"
                                    ],
                      "filesLikelyToChange":  [
                                                  "scripts/ai-dev-auto-goal.ps1",
                                                  ".ai-dev/README.md"
                                              ],
                      "verification":  [
                                           "DryRun에서 생성될 goal/task 계획과 실행 단계가 표시되는지 확인",
                                           "Json 출력이 가능한지 확인",
                                           "goal/queue/state JSON 파싱 검증을 수행하는지 확인",
                                           "auto-cycle-full 호출은 -AllowRun 또는 명시적 실행 옵션에서만 수행되는지 확인
",
                                           "GoalTitle/GoalDescription이 비어 있으면 오류로 종료하는지 확인",
                                           "PowerShell 문법 검증"
                                       ],
                      "commitMessage":  "Add automatic goal runner"
                  }
              ]
}

 succeeded in 4404ms:
{
    "goalStatus":  "in_progress",
    "currentTaskId":  "T005",
    "currentLoop":  0,
    "maxLoopsPerTask":  2,
    "repeatedFailureCount":  0,
    "lastCommand":  "complete-task",
    "lastCommandStatus":  "passed",
    "lastErrorSummary":  "",
    "lastReviewDecision":  "not_started",
    "lastReviewSeverity":  "",
    "lastCommitHash":  null,
    "startedAt":  "2026-06-07T19:59:48.1282711+09:00",
    "updatedAt":  "2026-06-07T13:57:13.9217915+00:00",
    "stopReason":  null
}

 succeeded in 4567ms:
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

foreach ($requiredPath in @($stateRelativePath, $queueRelativePath, $loopLogRelativePath)) {
    $fullPath = Join-Path $projectRoot $requiredPath

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        Stop-WithError "필수 파일이 없습니다: $requiredPath"
    }
}

try {
    $null = Invoke-GitCapture -Arguments @("rev-parse", "--show-toplevel") -DisplayName "git rev-p
arse --show-toplevel"
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
    $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-Object -First
 1

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
    Stop-WithError "state.lastCommandStatus가 passed가 아닙니다. 검증 결과를 확인하거나 -AllowWithoutPassedCheck를 
사용하세요."
}

if (-not $AllowWithoutPassedReview -and $state.lastReviewDecision -ne "pass") {
    Stop-WithError "state.lastReviewDecision이 pass가 아닙니다. 리뷰 결과를 확인하거나 -AllowWithoutPassedReview를 
사용하세요."
}

try {
    $statusPorcelain = Invoke-GitCapture -Arguments @("status", "--porcelain") -DisplayName "git s
tatus --porcelain"
} catch {
    Stop-WithError $_.Exception.Message
}

$changeLines = @($statusPorcelain -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpac
e($_) })

if ($changeLines.Count -eq 0) {
    Write-Host "커밋할 변경사항 없음"
    exit 0
}

$selectedFiles = @()
$targetChangeLines = $changeLines

if ($null -ne $Files -and $Files.Count -gt 0) {
    $requestedFiles = @($Files | ForEach-Object { $_ -split "," } | Where-Object { -not [string]::
IsNullOrWhiteSpace($_) })

    if ($requestedFiles.Count -eq 0) {
        Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
    }

    foreach ($file in $requestedFiles) {
        if ([string]::IsNullOrWhiteSpace($file)) {
            Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
        }

        $normalizedFile = $file.Replace('\', '/')
        $fullPath = [System.IO.Path]::GetFullPath((Join-Path $projectRoot $normalizedFile))
        $projectRootPrefix = [System.IO.Path]::GetFullPath($projectRoot).TrimEnd('\', '/') + [Syst
em.IO.Path]::DirectorySeparatorChar

        if (-not $fullPath.StartsWith($projectRootPrefix, [System.StringComparison]::OrdinalIgnore
Case)) {
            Stop-WithError "저장소 밖 파일은 선택할 수 없습니다: $file"
        }

        if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
            Stop-WithError "선택한 파일이 존재하지 않습니다: $file"
        }

        try {
            $fileStatus = Invoke-GitCapture -Arguments @("status", "--porcelain", "--", $normalize
dFile) -DisplayName "git status --porcelain -- $normalizedFile"
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
        $stagedFiles = Invoke-GitCapture -Arguments @("diff", "--cached", "--name-only") -DisplayN
ame "git diff --cached --name-only"
    } catch {
        Stop-WithError $_.Exception.Message
    }

    $stagedFileList = @($stagedFiles -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteS
pace($_) })
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

if ($DryRun) {
    Write-Host "Dry run: git add/commit을 실행하지 않습니다."
    Write-Host "커밋 메시지: $commitMessage"
    Write-Host "현재 task: $taskText"
    Write-Host "커밋 대상 변경 파일:"
    foreach ($line in $targetChangeLines) {
        Write-Host "  - $line"
    }
    Write-Host "변경 파일 수: $($targetChangeLines.Count)"
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
        $stagedFilesAfterAdd = Invoke-GitCapture -Arguments @("diff", "--cached", "--name-only") -
DisplayName "git diff --cached --name-only"
        $stagedFileListAfterAdd = @($stagedFilesAfterAdd -split "`r?`n" | Where-Object { -not [str
ing]::IsNullOrWhiteSpace($_) })
        $unexpectedStagedFilesAfterAdd = @($stagedFileListAfterAdd | Where-Object { $selectedFiles
 -notcontains $_ })

        if ($unexpectedStagedFilesAfterAdd.Count -gt 0) {
            throw "선택 파일 외의 staged 파일이 감지되었습니다: $($unexpectedStagedFilesAfterAdd -join ', ')"
        }
    }

    $commitOutput = & git commit -m $commitMessage 2>&1 | Out-String

    if ($LASTEXITCODE -ne 0) {
        throw "git commit 실행에 실패했습니다. exit code: $LASTEXITCODE`n$commitOutput"
    }

    $commitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-parse 
HEAD"
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
Write-Host "변경 파일 수: $($targetChangeLines.Count)"
Write-Host "현재 task: $taskText"

codex
커밋 연결은 `ai-dev-commit.ps1`의 기존 검증 게이트를 재사용하되, full cycle 쪽에서 한 번 더 `review pass`, `next_step compl
ete_task`, package 파일 변경 여부를 확인하도록 넣겠습니다. `complete-task`는 커밋 단계 성공 뒤에만 호출되게 순서를 고정합니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\scripts\ai-dev-auto-cycle-full.ps1
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..7240437c74a8273e33925eeb7e651c6e85eac995
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,61 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
 Set-Location $repoRoot
 
 $script:steps = @()
@@ -249,6 +304,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +318,9 @@
     "check",
     "save-diff",
     "make-review-prompt",
-    "run-review-codex"
+    "run-review-codex",
+    "commit",
+    "complete-task"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -269,7 +328,7 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
@@ -314,11 +373,68 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
+
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
+
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+$commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
+if ($commitArguments.Count -gt 0) {
+    $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
+}
+
+Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..7240437c74a8273e33925eeb7e651c6e85eac995
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,61 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
 Set-Location $repoRoot
 
 $script:steps = @()
@@ -249,6 +304,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +318,9 @@
     "check",
     "save-diff",
     "make-review-prompt",
-    "run-review-codex"
+    "run-review-codex",
+    "commit",
+    "complete-task"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -269,7 +328,7 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
@@ -314,11 +373,68 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
+
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
+
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+$commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
+if ($commitArguments.Count -gt 0) {
+    $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
+}
+
+Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

codex
패치 후 한 가지 중요한 점은 DryRun과 실제 실행의 의미가 갈리지 않게 하는 것입니다. 이제 문법을 먼저 확인하고, 필요하면 DryRun에서 게이트 표시가 어색한 부분만 
좁게 조정하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '$null = [System.Managem
ent.Automation.Language.Parser]::ParseFile('"'scripts/ai-dev-auto-cycle-full.ps1', [ref]"'$null, [
ref]$parseErrors); if ($parseErrors.Count -gt 0) { $parseErrors | ForEach-Object { $_.Message }; e
xit 1 } else { '"'syntax ok' }" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Select-String -Path scr
ipts/ai-dev-auto-cycle-full.ps1 -Pattern "review-gate|package-change-gate|AllowCommit|complete-tas
k|CommitFiles|plannedSteps" -Context 2,2' in D:\ai-apps\planpilot-local
 succeeded in 2171ms:
syntax ok
존재하지 않는 변수에 [ref]을(를) 적용할 수 없습니다.
위치 줄:2 문자:1
+ $null = [System.Management.Automation.Language.Parser]::ParseFile('sc ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (parseErrors:VariablePath) [], RuntimeException
    + FullyQualifiedErrorId : NonExistingVariableReference
 

 succeeded in 2288ms:

  scripts\ai-dev-auto-cycle-full.ps1:6:    [switch]$AllowCodex,
  scripts\ai-dev-auto-cycle-full.ps1:7:    [switch]$AllowReviewCodex,
> scripts\ai-dev-auto-cycle-full.ps1:8:    [switch]$AllowCommit,
  scripts\ai-dev-auto-cycle-full.ps1:9:    [switch]$AllowDirty,
> scripts\ai-dev-auto-cycle-full.ps1:10:    [string[]]$CommitFiles
  scripts\ai-dev-auto-cycle-full.ps1:11:)
  scripts\ai-dev-auto-cycle-full.ps1:12:
  scripts\ai-dev-auto-cycle-full.ps1:246:    $arguments = @()
  scripts\ai-dev-auto-cycle-full.ps1:247:
> scripts\ai-dev-auto-cycle-full.ps1:248:    if ($null -ne $CommitFiles -and $CommitFiles.Count -g
t 0) {
> scripts\ai-dev-auto-cycle-full.ps1:249:        $normalizedFiles = @($CommitFiles | ForEach-Objec
t { $_ -split "," } |
 Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
  scripts\ai-dev-auto-cycle-full.ps1:250:
  scripts\ai-dev-auto-cycle-full.ps1:251:        if ($normalizedFiles.Count -gt 0) {
  scripts\ai-dev-auto-cycle-full.ps1:306:        runReviewCodex = Get-ScriptPath "ai-dev-run-revie
w-codex.ps1"
  scripts\ai-dev-auto-cycle-full.ps1:307:        commit = Get-ScriptPath "ai-dev-commit.ps1"
> scripts\ai-dev-auto-cycle-full.ps1:308:        completeTask = Get-ScriptPath "ai-dev-complete-ta
sk.ps1"
  scripts\ai-dev-auto-cycle-full.ps1:309:    }
  scripts\ai-dev-auto-cycle-full.ps1:310:} catch {
  scripts\ai-dev-auto-cycle-full.ps1:313:}
  scripts\ai-dev-auto-cycle-full.ps1:314:
> scripts\ai-dev-auto-cycle-full.ps1:315:$plannedSteps = @(
  scripts\ai-dev-auto-cycle-full.ps1:316:    "make-prompt",
  scripts\ai-dev-auto-cycle-full.ps1:317:    "run-codex",
  scripts\ai-dev-auto-cycle-full.ps1:321:    "run-review-codex",
  scripts\ai-dev-auto-cycle-full.ps1:322:    "commit",
> scripts\ai-dev-auto-cycle-full.ps1:323:    "complete-task"
  scripts\ai-dev-auto-cycle-full.ps1:324:)
  scripts\ai-dev-auto-cycle-full.ps1:325:
> scripts\ai-dev-auto-cycle-full.ps1:326:if ($plannedSteps.Count -gt $MaxSteps) {
  scripts\ai-dev-auto-cycle-full.ps1:327:    Stop-Cycle $script:steps "max_steps_too_small_for_ful
l_cycle" $false 1
  scripts\ai-dev-auto-cycle-full.ps1:328:}
  scripts\ai-dev-auto-cycle-full.ps1:379:    $reviewGate = Get-ReviewGate
  scripts\ai-dev-auto-cycle-full.ps1:380:} catch {
> scripts\ai-dev-auto-cycle-full.ps1:381:    $script:steps += New-StepResult $stepNumber "review-g
ate" "state/review-re
sponse 확인" $false $false 1 $_.Exception.Message
  scripts\ai-dev-auto-cycle-full.ps1:382:    Stop-Cycle $script:steps "review_gate_failed" $false 
1
  scripts\ai-dev-auto-cycle-full.ps1:383:}
  scripts\ai-dev-auto-cycle-full.ps1:384:
  scripts\ai-dev-auto-cycle-full.ps1:385:if ($reviewGate.lastCommandStatus -ne "passed") {
> scripts\ai-dev-auto-cycle-full.ps1:386:    $script:steps += New-StepResult $stepNumber "review-g
ate" "state.lastComma
ndStatus 확인" $false $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandS
tatus)"
  scripts\ai-dev-auto-cycle-full.ps1:387:    Stop-Cycle $script:steps "review_save_not_passed" $fa
lse 1
  scripts\ai-dev-auto-cycle-full.ps1:388:}
  scripts\ai-dev-auto-cycle-full.ps1:389:
  scripts\ai-dev-auto-cycle-full.ps1:390:if ($reviewGate.decision -ne "pass") {
> scripts\ai-dev-auto-cycle-full.ps1:391:    $script:steps += New-StepResult $stepNumber "review-g
ate" "state.lastRevie
wDecision 확인" $false $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGa
te.decision)"
  scripts\ai-dev-auto-cycle-full.ps1:392:    Stop-Cycle $script:steps "review_not_pass" $false 0
  scripts\ai-dev-auto-cycle-full.ps1:393:}
  scripts\ai-dev-auto-cycle-full.ps1:394:
  scripts\ai-dev-auto-cycle-full.ps1:395:if (Test-HasValue $reviewGate.nextStep -and $reviewGate.n
extStep -ne "complete
_task") {
> scripts\ai-dev-auto-cycle-full.ps1:396:    $script:steps += New-StepResult $stepNumber "review-g
ate" "$reviewResponse
RelativePath next_step 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를
 실행하지 않습니다: $($review
Gate.nextStep)"
  scripts\ai-dev-auto-cycle-full.ps1:397:    Stop-Cycle $script:steps "review_next_step_not_comple
te_task" $false 0
  scripts\ai-dev-auto-cycle-full.ps1:398:}
  scripts\ai-dev-auto-cycle-full.ps1:399:
> scripts\ai-dev-auto-cycle-full.ps1:400:$script:steps += New-StepResult $stepNumber "review-gate"
 "state.lastReviewDec
ision 확인" $false $false 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
  scripts\ai-dev-auto-cycle-full.ps1:401:$stepNumber++
  scripts\ai-dev-auto-cycle-full.ps1:402:
  scripts\ai-dev-auto-cycle-full.ps1:403:try {
  scripts\ai-dev-auto-cycle-full.ps1:404:    if (Test-PackageFileChanged) {
> scripts\ai-dev-auto-cycle-full.ps1:405:        $script:steps += New-StepResult $stepNumber "pack
age-change-gate" "git
 status --porcelain -- package.json package-lock.json" $false $true 1 "package.json 또는 package-loc
k.json 변경이 감지되어 자동 커밋
하지 않습니다."
  scripts\ai-dev-auto-cycle-full.ps1:406:        Stop-Cycle $script:steps "package_files_changed" 
$false 1
  scripts\ai-dev-auto-cycle-full.ps1:407:    }
  scripts\ai-dev-auto-cycle-full.ps1:408:} catch {
> scripts\ai-dev-auto-cycle-full.ps1:409:    $script:steps += New-StepResult $stepNumber "package-
change-gate" "git sta
tus --porcelain -- package.json package-lock.json" $false $false 1 $_.Exception.Message
  scripts\ai-dev-auto-cycle-full.ps1:410:    Stop-Cycle $script:steps "package_change_gate_failed"
 $false 1
  scripts\ai-dev-auto-cycle-full.ps1:411:}
  scripts\ai-dev-auto-cycle-full.ps1:412:
> scripts\ai-dev-auto-cycle-full.ps1:413:$script:steps += New-StepResult $stepNumber "package-chan
ge-gate" "git status 
--porcelain -- package.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다.
"
  scripts\ai-dev-auto-cycle-full.ps1:414:$stepNumber++
  scripts\ai-dev-auto-cycle-full.ps1:415:
> scripts\ai-dev-auto-cycle-full.ps1:416:if (-not $AllowCommit) {
> scripts\ai-dev-auto-cycle-full.ps1:417:    $commitCommand = "powershell -ExecutionPolicy Bypass 
-File scripts/ai-dev-
auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
  scripts\ai-dev-auto-cycle-full.ps1:418:    if ($AllowDirty) {
  scripts\ai-dev-auto-cycle-full.ps1:419:        $commitCommand = "$commitCommand -AllowDirty"
  scripts\ai-dev-auto-cycle-full.ps1:420:    }
  scripts\ai-dev-auto-cycle-full.ps1:421:
> scripts\ai-dev-auto-cycle-full.ps1:422:    if ($null -ne $CommitFiles -and $CommitFiles.Count -g
t 0) {
> scripts\ai-dev-auto-cycle-full.ps1:423:        $commitCommand = "$commitCommand -CommitFiles $($
CommitFiles -join ','
)"
  scripts\ai-dev-auto-cycle-full.ps1:424:    }
  scripts\ai-dev-auto-cycle-full.ps1:425:
> scripts\ai-dev-auto-cycle-full.ps1:426:    $script:steps += New-StepResult $stepNumber "commit" 
"powershell -Executio
nPolicy Bypass -File scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령
: $commitCommand"
  scripts\ai-dev-auto-cycle-full.ps1:427:    Stop-Cycle $script:steps "allow_commit_required" $fal
se 1
  scripts\ai-dev-auto-cycle-full.ps1:428:}
  scripts\ai-dev-auto-cycle-full.ps1:437:$stepNumber++
  scripts\ai-dev-auto-cycle-full.ps1:438:
> scripts\ai-dev-auto-cycle-full.ps1:439:Invoke-CycleCommand $stepNumber "complete-task" "powershe
ll -ExecutionPolicy B
ypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.c
ompleteTask @("-Resul
tSummary", "리뷰 pass 후 자동 커밋 완료")
  scripts\ai-dev-auto-cycle-full.ps1:440:Stop-Cycle $script:steps "completed" $true 0



diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..7240437c74a8273e33925eeb7e651c6e85eac995
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,61 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
 Set-Location $repoRoot
 
 $script:steps = @()
@@ -249,6 +304,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +318,9 @@
     "check",
     "save-diff",
     "make-review-prompt",
-    "run-review-codex"
+    "run-review-codex",
+    "commit",
+    "complete-task"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -269,7 +328,7 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
@@ -314,11 +373,68 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
+
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
+
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+$commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
+if ($commitArguments.Count -gt 0) {
+    $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
+}
+
+Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

codex
문법 검증 명령에서 `[ref]` 대상 변수를 초기화하지 않아 PowerShell 경고가 섞였습니다. 스크립트 자체 문법은 통과했지만, 검증 명령을 바로잡아 다시 돌리기 전에 
DryRun이 실제 상태를 읽지 않고 전체 단계를 보여주도록 보완하겠습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\scripts\ai-dev-auto-cycle-full.ps1
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..ca7c819495ff1601486ebf2585a46b9cc1245292
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,61 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
 Set-Location $repoRoot
 
 $script:steps = @()
@@ -249,6 +304,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +318,11 @@
     "check",
     "save-diff",
     "make-review-prompt",
-    "run-review-codex"
+    "run-review-codex",
+    "review-gate",
+    "package-change-gate",
+    "commit",
+    "complete-task"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -269,14 +330,14 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +364,7 @@
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +375,79 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "D
ryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
+
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+$commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
+if ($commitArguments.Count -gt 0) {
+    $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
+}
+
+Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..ca7c819495ff1601486ebf2585a46b9cc1245292
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,61 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
 Set-Location $repoRoot
 
 $script:steps = @()
@@ -249,6 +304,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +318,11 @@
     "check",
     "save-diff",
     "make-review-prompt",
-    "run-review-codex"
+    "run-review-codex",
+    "review-gate",
+    "package-change-gate",
+    "commit",
+    "complete-task"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -269,14 +330,14 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +364,7 @@
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +375,79 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "D
ryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
+
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+$commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
+if ($commitArguments.Count -gt 0) {
+    $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
+}
+
+Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

codex
스크립트는 T005 흐름으로 바뀌었습니다. 이제 `.ai-dev/README.md`의 T004 자리표시자 설명을 T005 기준으로 갱신해 사용자가 Allow 옵션, pass 게
이트, package 중단 조건을 확인할 수 있게 하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Select-String -Path .ai
-dev/README.md -Pattern "full auto-cycle 초안|T004|AllowCommit|package|complete-task" -Context 2,4' 
in D:\ai-apps\planpilot-local
 succeeded in 3078ms:

  .ai-dev\README.md:113:
  .ai-dev\README.md:114:```powershell
> .ai-dev\README.md:115:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 
-ResultSummary "T001 
분석 완료"
  .ai-dev\README.md:116:```
  .ai-dev\README.md:117:
  .ai-dev\README.md:118:특정 task를 완료 처리하려면 `-TaskId`를 지정한다.
  .ai-dev\README.md:119:
  .ai-dev\README.md:120:```powershell
> .ai-dev\README.md:121:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 
-TaskId T001 -ResultS
ummary "분석 완료"
  .ai-dev\README.md:122:```
  .ai-dev\README.md:123:
  .ai-dev\README.md:124:다음 task로 자동 이동하지 않으려면 `-NoNext` 옵션을 사용한다.
  .ai-dev\README.md:125:
  .ai-dev\README.md:126:```powershell
> .ai-dev\README.md:127:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 
-NoNext
  .ai-dev\README.md:128:```
  .ai-dev\README.md:129:
  .ai-dev\README.md:130:task 완료 처리 스크립트는 `queue.json`, `state.json`, `loop-log.md`만 갱신한다. Codex 실행
, GPT 리뷰, build/test 
실행, git commit은 수행하지 않는다.
  .ai-dev\README.md:131:
  .ai-dev\README.md:132:## 프로젝트 검증 실행
  .ai-dev\README.md:133:
> .ai-dev\README.md:134:`package.json`에 정의된 build, test, lint script를 확인하고 실행 결과를 `test-result.md`
와 `state.json`에 기록한다.
  .ai-dev\README.md:135:
  .ai-dev\README.md:136:```powershell
  .ai-dev\README.md:137:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1
  .ai-dev\README.md:138:```
  .ai-dev\README.md:418:리뷰 저장 후 decision별 다음 단계:
  .ai-dev\README.md:419:
> .ai-dev\README.md:420:- `pass`: `ai-dev-complete-task.ps1` 실행 또는 커밋 조건을 검토한다.
  .ai-dev\README.md:421:- `revise`: `ai-dev-make-revise-prompt.ps1`로 재수정 프롬프트를 만든 뒤 Codex/Cline에 수
동 전달한다.
  .ai-dev\README.md:422:- `blocked`: 사용자 판단이 필요하므로 루프를 중단하고 요구사항이나 범위를 조정한다.
  .ai-dev\README.md:423:
  .ai-dev\README.md:424:`review-prompt.md`에는 diff, 테스트 결과, 로컬 경로, 민감 정보가 포함될 수 있다. ChatGPT에 붙여넣기 전
에 사용자가 공유 범위를 확인해야 한다
.
  .ai-dev\README.md:566:- `scripts/ai-dev-run-codex.ps1`: `.ai-dev/current-task-prompt.md`를 Codex 
CLI에 전달해 현재 task 구현을 
수행한다.
  .ai-dev\README.md:567:- `scripts/ai-dev-run-review-codex.ps1`: `.ai-dev/review-prompt.md`를 Codex
 CLI에 전달해 JSON 리뷰를 생성
하고 저장 흐름에 연결한다.
> .ai-dev\README.md:568:- `scripts/ai-dev-auto-cycle-full.ps1`: prompt 생성, Codex 구현, check, diff 저
장, Codex 리뷰, save-rev
iew, pass 시 commit/complete-task를 연결한다.
  .ai-dev\README.md:569:- `scripts/ai-dev-auto-goal.ps1`: 사용자가 `GoalTitle`과 `GoalDescription`만 입력하
면 goal/queue/state 생성
, current-task-prompt 생성, full auto-cycle 실행까지 이어지게 한다.
  .ai-dev\README.md:570:
  .ai-dev\README.md:571:초기 안전 기준:
  .ai-dev\README.md:572:
  .ai-dev\README.md:574:- Codex 구현 실행은 `AllowCodex`가 있을 때만 수행한다.
  .ai-dev\README.md:575:- Codex 리뷰 실행은 `AllowReviewCodex`가 있을 때만 수행한다.
> .ai-dev\README.md:576:- git commit은 `AllowCommit`이 있을 때만 수행한다.
  .ai-dev\README.md:577:- auto-goal에서 실제 full cycle 실행은 `AllowRun` 또는 명시적 실행 옵션이 있을 때만 수행한다.
  .ai-dev\README.md:578:- git status가 dirty이면 Codex 구현 실행을 기본 중단한다.
> .ai-dev\README.md:579:- build/check 실패, package 파일 변경, 리뷰 decision이 `pass`가 아닌 경우 자동 커밋하지 않는다.
  .ai-dev\README.md:580:- `git reset`, `git clean`, `npm install`, `git push`는 자동 실행하지 않는다.
  .ai-dev\README.md:581:
  .ai-dev\README.md:582:자동화 로그와 결과 파일:
  .ai-dev\README.md:583:
  .ai-dev\README.md:623:```
  .ai-dev\README.md:624:
> .ai-dev\README.md:625:이 스크립트는 Codex에 전달하는 프롬프트 끝에 추가 안전 규칙을 붙인다. git commit, git reset, git clea
n, npm install, packa
ge 파일 수정, 현재 task 범위 밖 작업을 금지한다. 스크립트 자체도 build/test/lint, git add, git commit을 실행하지 않는다.
  .ai-dev\README.md:626:
  .ai-dev\README.md:627:### Codex 리뷰 실행
  .ai-dev\README.md:628:
  .ai-dev\README.md:629:`.ai-dev/review-prompt.md`를 Codex CLI에 전달해 JSON 리뷰를 생성하고 `.ai-dev/review-r
esponse.json`에 저장한다. 
실행 전 `git status --short`를 확인하고, 작업 트리가 dirty이면 기본 중단한다. 리뷰 대상 변경사항이 남아 있는 상태에서 실행해야 하는 경우에만 `-All
owDirty`를 명시한다.
  .ai-dev\README.md:667:- 이 스크립트는 git add, git commit, build/test/lint, GPT API 호출을 수행하지 않는다.
  .ai-dev\README.md:668:
> .ai-dev\README.md:669:### full auto-cycle 초안
  .ai-dev\README.md:670:
  .ai-dev\README.md:671:`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build chec
k, diff 저장, strict re
view prompt 생성, Codex JSON 리뷰와 save-review 흐름을 순서대로 연결하는 초안이다.
  .ai-dev\README.md:672:
> .ai-dev\README.md:673:T004 버전의 실행 단계:
  .ai-dev\README.md:674:
  .ai-dev\README.md:675:1. `ai-dev-make-prompt.ps1`
  .ai-dev\README.md:676:2. `ai-dev-run-codex.ps1`
  .ai-dev\README.md:677:3. `ai-dev-check.ps1 -BuildOnly`
  .ai-dev\README.md:692:```
  .ai-dev\README.md:693:
> .ai-dev\README.md:694:기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제
한이며, T004 초안은 task 완료
 처리를 하지 않으므로 실제로는 현재 task 한 개만 다룬다.
  .ai-dev\README.md:695:
  .ai-dev\README.md:696:```powershell
  .ai-dev\README.md:697:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps
1 -DryRun -MaxTasks 1
 -MaxSteps 20
  .ai-dev\README.md:698:```
  .ai-dev\README.md:716:```
  .ai-dev\README.md:717:
> .ai-dev\README.md:718:`-AllowCommit` 옵션은 T004에서 파라미터와 출력만 제공한다. 실제 `ai-dev-commit.ps1` 실행과 `ai-d
ev-complete-task.ps1`
 연결은 T005에서 구현한다. 따라서 T004 full auto-cycle은 리뷰 저장 후에도 git add, git commit, complete-task를 수행하지 않는다
.
  .ai-dev\README.md:719:
  .ai-dev\README.md:720:### 목표 입력 기반 자동 실행
  .ai-dev\README.md:721:
  .ai-dev\README.md:722:최종 목표는 사용자가 goal 파일과 queue 파일을 직접 편집하지 않고도 한 줄 명령으로 작은 앱 기능 task를 시작할 수 있게
 하는 것이다.
  .ai-dev\README.md:725:
  .ai-dev\README.md:726:```powershell
> .ai-dev\README.md:727:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -G
oalTitle "업무 검색 결과 하이
라이트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -AllowCodex -AllowReviewCodex -
AllowCommit -MaxTasks
 1
  .ai-dev\README.md:728:```
  .ai-dev\README.md:729:
  .ai-dev\README.md:730:예정 동작:
  .ai-dev\README.md:731:
  .ai-dev\README.md:743:- 생성된 goal/queue/state JSON 파싱에 실패하면 실제 실행으로 넘어가지 않는다.
  .ai-dev\README.md:744:- full cycle 호출은 `-AllowRun` 또는 그에 준하는 명시적 실행 옵션이 있을 때만 수행한다.
> .ai-dev\README.md:745:- package 파일 변경, build/check 실패, 리뷰 `pass` 아님, dirty worktree 위험이 있으면 자동 커
밋하지 않는다.
  .ai-dev\README.md:746:
  .ai-dev\README.md:747:## 운영 원칙
  .ai-dev\README.md:748:
  .ai-dev\README.md:749:- 저장소의 `AGENTS.md`, 사용자 지시, 보안 정책이 자동 개발 루프보다 우선한다.



diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..ca7c819495ff1601486ebf2585a46b9cc1245292
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,61 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
 Set-Location $repoRoot
 
 $script:steps = @()
@@ -249,6 +304,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +318,11 @@
     "check",
     "save-diff",
     "make-review-prompt",
-    "run-review-codex"
+    "run-review-codex",
+    "review-gate",
+    "package-change-gate",
+    "commit",
+    "complete-task"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -269,14 +330,14 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +364,7 @@
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +375,79 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "D
ryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
+
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+$commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
+if ($commitArguments.Count -gt 0) {
+    $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
+}
+
+Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'Get-Content -Path .ai-d
ev/README.md | Select-Object -Skip 668 -First 55' in D:\ai-apps\planpilot-local
 succeeded in 1406ms:
### full auto-cycle 초안

`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revie
w prompt 생성, Codex JSON 리뷰와 save-review 흐름을 순서대로 연결하는 초안이다.

T004 버전의 실행 단계:

1. `ai-dev-make-prompt.ps1`
2. `ai-dev-run-codex.ps1`
3. `ai-dev-check.ps1 -BuildOnly`
4. `ai-dev-save-diff.ps1`
5. `ai-dev-make-review-prompt.ps1 -Strict`
6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`

먼저 DryRun으로 전체 단계를 확인한다. DryRun은 하위 스크립트를 실제 실행하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun
```

자동화 도구에서 결과만 파싱해야 하면 `-Json`을 함께 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -Json
```

기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, T004 초안은 task 완료 처리
를 하지 않으므로 실제로는 현재 task 한 개만 다룬다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -M
axSteps 20
```

`-AllowCodex` 없이 실제 실행하면 prompt 생성 이후 Codex 구현 실행 직전에서 중단하고 추천 명령을 출력한다. Codex 구현까지 허용하려면 명시적으로 `-
AllowCodex`를 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex
```

Codex 구현과 Codex 리뷰까지 이어가려면 `-AllowCodex`와 `-AllowReviewCodex`를 함께 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRevi
ewCodex -MaxTasks 1
```

dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-co
dex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRevi
ewCodex -AllowDirty -MaxTasks 1
```

`-AllowCommit` 옵션은 T004에서 파라미터와 출력만 제공한다. 실제 `ai-dev-commit.ps1` 실행과 `ai-dev-complete-task.ps1` 연결
은 T005에서 구현한다. 따라서 T004 full auto-cycle은 리뷰 저장 후에도 git add, git commit, complete-task를 수행하지 않는다.

### 목표 입력 기반 자동 실행

최종 목표는 사용자가 goal 파일과 queue 파일을 직접 편집하지 않고도 한 줄 명령으로 작은 앱 기능 task를 시작할 수 있게 하는 것이다.


diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..ca7c819495ff1601486ebf2585a46b9cc1245292
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,61 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
 Set-Location $repoRoot
 
 $script:steps = @()
@@ -249,6 +304,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +318,11 @@
     "check",
     "save-diff",
     "make-review-prompt",
-    "run-review-codex"
+    "run-review-codex",
+    "review-gate",
+    "package-change-gate",
+    "commit",
+    "complete-task"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -269,14 +330,14 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +364,7 @@
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +375,79 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "D
ryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
+
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+$commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
+if ($commitArguments.Count -gt 0) {
+    $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
+}
+
+Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

codex
README의 full cycle 설명은 아직 T004 기준이라 실제 동작과 어긋납니다. 해당 섹션만 갱신하고, 다른 정책/운영 문구는 그대로 두겠습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\.ai-dev\README.md
diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 5bf9253347c33a852d2bba22cd59a4f1a4918d9c..b50e832b1d99857130daa9949b9f52658b299bb3
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -668,9 +668,9 @@
 
 ### full auto-cycle 초안
 
-`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review 흐름을 순서대로 연결하는 초안이다.
+`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 선택 파일 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.
 
-T004 버전의 실행 단계:
+T005 버전의 실행 단계:
 
 1. `ai-dev-make-prompt.ps1`
 2. `ai-dev-run-codex.ps1`
@@ -678,6 +678,10 @@
 4. `ai-dev-save-diff.ps1`
 5. `ai-dev-make-review-prompt.ps1 -Strict`
 6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`
+7. 리뷰 게이트 확인: `state.lastCommandStatus`가 `passed`이고 `state.lastReviewDecision`이 `pass`여야 한다.
+8. package 파일 변경 게이트 확인: `package.json` 또는 `package-lock.json` 변경이 있으면 자동 커밋하지 않는다.
+9. `-AllowCommit`이 있을 때만 `ai-dev-commit.ps1`을 실행한다.
+10. 커밋 성공 후에만 `ai-dev-complete-task.ps1`을 실행한다.
 
 먼저 DryRun으로 전체 단계를 확인한다. DryRun은 하위 스크립트를 실제 실행하지 않는다.
 
@@ -691,7 +695,7 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -Json
 ```
 
-기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, T004 초안은 task 완료 처
리를 하지 않으므로 실제로는 현재 task 한 개만 다룬다.
+기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, 초기 full cycle은 안전을
 위해 현재 task 한 개만 다룬다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -
MaxSteps 20
@@ -709,13 +713,19 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -MaxTasks 1
 ```
 
+리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`을 추가한다. `-CommitFiles`를 지정하
면 선택한 파일만 커밋 대상으로 전달한다.
+
+```powershell
+powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTasks 
1
+```
+
 dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-c
odex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowDirty -MaxTasks 1
 ```
 
-`-AllowCommit` 옵션은 T004에서 파라미터와 출력만 제공한다. 실제 `ai-dev-commit.ps1` 실행과 `ai-dev-complete-task.ps1` 연
결은 T005에서 구현한다. 따라서 T004 full auto-cycle은 리뷰 저장 후에도 git add, git commit, complete-task를 수행하지 않는다.
+리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 comple
te-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `package
-lock.json` 변경이 감지되면 `package_files_changed`로 중단한다.
 
 ### 목표 입력 기반 자동 실행
 
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..ca7c819495ff1601486ebf2585a46b9cc1245292
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,61 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
 Set-Location $repoRoot
 
 $script:steps = @()
@@ -249,6 +304,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +318,11 @@
     "check",
     "save-diff",
     "make-review-prompt",
-    "run-review-codex"
+    "run-review-codex",
+    "review-gate",
+    "package-change-gate",
+    "commit",
+    "complete-task"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -269,14 +330,14 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +364,7 @@
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +375,79 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "D
ryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
+
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+$commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
+if ($commitArguments.Count -gt 0) {
+    $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
+}
+
+Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 5bf9253347c33a852d2bba22cd59a4f1a4918d9c..b50e832b1d99857130daa9949b9f52658b299bb3
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -668,9 +668,9 @@
 
 ### full auto-cycle 초안
 
-`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review 흐름을 순서대로 연결하는 초안이다.
+`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 선택 파일 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.
 
-T004 버전의 실행 단계:
+T005 버전의 실행 단계:
 
 1. `ai-dev-make-prompt.ps1`
 2. `ai-dev-run-codex.ps1`
@@ -678,6 +678,10 @@
 4. `ai-dev-save-diff.ps1`
 5. `ai-dev-make-review-prompt.ps1 -Strict`
 6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`
+7. 리뷰 게이트 확인: `state.lastCommandStatus`가 `passed`이고 `state.lastReviewDecision`이 `pass`여야 한다.
+8. package 파일 변경 게이트 확인: `package.json` 또는 `package-lock.json` 변경이 있으면 자동 커밋하지 않는다.
+9. `-AllowCommit`이 있을 때만 `ai-dev-commit.ps1`을 실행한다.
+10. 커밋 성공 후에만 `ai-dev-complete-task.ps1`을 실행한다.
 
 먼저 DryRun으로 전체 단계를 확인한다. DryRun은 하위 스크립트를 실제 실행하지 않는다.
 
@@ -691,7 +695,7 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -Json
 ```
 
-기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, T004 초안은 task 완료 처
리를 하지 않으므로 실제로는 현재 task 한 개만 다룬다.
+기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, 초기 full cycle은 안전을
 위해 현재 task 한 개만 다룬다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -
MaxSteps 20
@@ -709,13 +713,19 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -MaxTasks 1
 ```
 
+리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`을 추가한다. `-CommitFiles`를 지정하
면 선택한 파일만 커밋 대상으로 전달한다.
+
+```powershell
+powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTasks 
1
+```
+
 dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-c
odex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowDirty -MaxTasks 1
 ```
 
-`-AllowCommit` 옵션은 T004에서 파라미터와 출력만 제공한다. 실제 `ai-dev-commit.ps1` 실행과 `ai-dev-complete-task.ps1` 연
결은 T005에서 구현한다. 따라서 T004 full auto-cycle은 리뷰 저장 후에도 git add, git commit, complete-task를 수행하지 않는다.
+리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 comple
te-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `package
-lock.json` 변경이 감지되면 `package_files_changed`로 중단한다.
 
 ### 목표 입력 기반 자동 실행
 
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..ca7c819495ff1601486ebf2585a46b9cc1245292
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,61 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
 Set-Location $repoRoot
 
 $script:steps = @()
@@ -249,6 +304,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +318,11 @@
     "check",
     "save-diff",
     "make-review-prompt",
-    "run-review-codex"
+    "run-review-codex",
+    "review-gate",
+    "package-change-gate",
+    "commit",
+    "complete-task"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -269,14 +330,14 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +364,7 @@
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +375,79 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "D
ryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
+
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+$commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
+if ($commitArguments.Count -gt 0) {
+    $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
+}
+
+Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

codex
문서까지 맞췄습니다. 이제 수정한 PowerShell 파일의 파서 문법 검증과 full cycle DryRun을 실행해 실제 하위 스크립트, build, git commit이 
호출되지 않는 범위에서 흐름을 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '$tokens = $null; $parse
Errors = $null; $null = [System.Management.Automation.Language.Parser]::ParseFile('"'scripts/ai-de
v-auto-cycle-full.ps1', [ref]"'$tokens, [ref]$parseErrors); if ($parseErrors.Count -gt 0) { $parse
Errors | ForEach-Object { $_.Message }; exit 1 } else { '"'syntax ok' }" in D:\ai-apps\planpilot-l
ocal
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'powershell -ExecutionPo
licy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -MaxSteps 20 -Json' in D:
\ai-apps\planpilot-local
 succeeded in 1811ms:
syntax ok

 succeeded in 3087ms:
{
    "steps":  [
                  {
                      "step":  1,
                      "name":  "make-prompt",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-pr
ompt.ps1",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 하위 스크립트를 실행하지 않았습니다."
                  },
                  {
                      "step":  2,
                      "name":  "run-codex",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-cod
ex.ps1",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 하위 스크립트를 실행하지 않았습니다."
                  },
                  {
                      "step":  3,
                      "name":  "check",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.p
s1 -BuildOnly",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 하위 스크립트를 실행하지 않았습니다."
                  },
                  {
                      "step":  4,
                      "name":  "save-diff",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-di
ff.ps1",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 하위 스크립트를 실행하지 않았습니다."
                  },
                  {
                      "step":  5,
                      "name":  "make-review-prompt",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-re
view-prompt.ps1 -Strict",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 하위 스크립트를 실행하지 않았습니다."
                  },
                  {
                      "step":  6,
                      "name":  "run-review-codex",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-rev
iew-codex.ps1 -AllowDirty -SaveReview",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 하위 스크립트를 실행하지 않았습니다."
                  },
                  {
                      "step":  7,
                      "name":  "review-gate",
                      "command":  "state.lastReviewDecision 확인",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
                  },
                  {
                      "step":  8,
                      "name":  "package-change-gate",
                      "command":  "git status --porcelain -- package.json package-lock.json",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
                  },
                  {
                      "step":  9,
                      "name":  "commit",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.
ps1",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: git add/commit을 실행하지 않았습니다."
                  },
                  {
                      "step":  10,
                      "name":  "complete-task",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complet
e-task.ps1 -ResultSummary \"리뷰 pass 후 자동 커밋 완료\"",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: task 완료 처리를 실행하지 않았습니다."
                  }
              ],
    "stoppedReason":  "dry_run",
    "completed":  false,
    "exitCode":  0
}

diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 5bf9253347c33a852d2bba22cd59a4f1a4918d9c..b50e832b1d99857130daa9949b9f52658b299bb3
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -668,9 +668,9 @@
 
 ### full auto-cycle 초안
 
-`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review 흐름을 순서대로 연결하는 초안이다.
+`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 선택 파일 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.
 
-T004 버전의 실행 단계:
+T005 버전의 실행 단계:
 
 1. `ai-dev-make-prompt.ps1`
 2. `ai-dev-run-codex.ps1`
@@ -678,6 +678,10 @@
 4. `ai-dev-save-diff.ps1`
 5. `ai-dev-make-review-prompt.ps1 -Strict`
 6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`
+7. 리뷰 게이트 확인: `state.lastCommandStatus`가 `passed`이고 `state.lastReviewDecision`이 `pass`여야 한다.
+8. package 파일 변경 게이트 확인: `package.json` 또는 `package-lock.json` 변경이 있으면 자동 커밋하지 않는다.
+9. `-AllowCommit`이 있을 때만 `ai-dev-commit.ps1`을 실행한다.
+10. 커밋 성공 후에만 `ai-dev-complete-task.ps1`을 실행한다.
 
 먼저 DryRun으로 전체 단계를 확인한다. DryRun은 하위 스크립트를 실제 실행하지 않는다.
 
@@ -691,7 +695,7 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -Json
 ```
 
-기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, T004 초안은 task 완료 처
리를 하지 않으므로 실제로는 현재 task 한 개만 다룬다.
+기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, 초기 full cycle은 안전을
 위해 현재 task 한 개만 다룬다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -
MaxSteps 20
@@ -709,13 +713,19 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -MaxTasks 1
 ```
 
+리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`을 추가한다. `-CommitFiles`를 지정하
면 선택한 파일만 커밋 대상으로 전달한다.
+
+```powershell
+powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTasks 
1
+```
+
 dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-c
odex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowDirty -MaxTasks 1
 ```
 
-`-AllowCommit` 옵션은 T004에서 파라미터와 출력만 제공한다. 실제 `ai-dev-commit.ps1` 실행과 `ai-dev-complete-task.ps1` 연
결은 T005에서 구현한다. 따라서 T004 full auto-cycle은 리뷰 저장 후에도 git add, git commit, complete-task를 수행하지 않는다.
+리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 comple
te-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `package
-lock.json` 변경이 감지되면 `package_files_changed`로 중단한다.
 
 ### 목표 입력 기반 자동 실행
 
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..ca7c819495ff1601486ebf2585a46b9cc1245292
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,61 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
 Set-Location $repoRoot
 
 $script:steps = @()
@@ -249,6 +304,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +318,11 @@
     "check",
     "save-diff",
     "make-review-prompt",
-    "run-review-codex"
+    "run-review-codex",
+    "review-gate",
+    "package-change-gate",
+    "commit",
+    "complete-task"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -269,14 +330,14 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +364,7 @@
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +375,79 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "D
ryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
+
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+$commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
+if ($commitArguments.Count -gt 0) {
+    $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
+}
+
+Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

codex
DryRun은 10단계 전체를 보여주며 하위 실행이 없음을 확인했습니다. 추가로, `ai-dev-commit.ps1`은 변경사항이 없으면 exit 0으로 끝날 수 있어 full
 cycle이 실제 커밋 없이 complete-task로 넘어갈 수 있습니다. 이 경우를 막기 위해 커밋 후 state에 `lastCommand=commit`, `passed`
, `lastCommitHash`가 기록됐는지 확인하는 게이트를 하나 더 넣겠습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\scripts\ai-dev-auto-cycle-full.ps1
diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 5bf9253347c33a852d2bba22cd59a4f1a4918d9c..b50e832b1d99857130daa9949b9f52658b299bb3
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -668,9 +668,9 @@
 
 ### full auto-cycle 초안
 
-`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review 흐름을 순서대로 연결하는 초안이다.
+`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 선택 파일 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.
 
-T004 버전의 실행 단계:
+T005 버전의 실행 단계:
 
 1. `ai-dev-make-prompt.ps1`
 2. `ai-dev-run-codex.ps1`
@@ -678,6 +678,10 @@
 4. `ai-dev-save-diff.ps1`
 5. `ai-dev-make-review-prompt.ps1 -Strict`
 6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`
+7. 리뷰 게이트 확인: `state.lastCommandStatus`가 `passed`이고 `state.lastReviewDecision`이 `pass`여야 한다.
+8. package 파일 변경 게이트 확인: `package.json` 또는 `package-lock.json` 변경이 있으면 자동 커밋하지 않는다.
+9. `-AllowCommit`이 있을 때만 `ai-dev-commit.ps1`을 실행한다.
+10. 커밋 성공 후에만 `ai-dev-complete-task.ps1`을 실행한다.
 
 먼저 DryRun으로 전체 단계를 확인한다. DryRun은 하위 스크립트를 실제 실행하지 않는다.
 
@@ -691,7 +695,7 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -Json
 ```
 
-기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, T004 초안은 task 완료 처
리를 하지 않으므로 실제로는 현재 task 한 개만 다룬다.
+기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, 초기 full cycle은 안전을
 위해 현재 task 한 개만 다룬다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -
MaxSteps 20
@@ -709,13 +713,19 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -MaxTasks 1
 ```
 
+리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`을 추가한다. `-CommitFiles`를 지정하
면 선택한 파일만 커밋 대상으로 전달한다.
+
+```powershell
+powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTasks 
1
+```
+
 dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-c
odex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowDirty -MaxTasks 1
 ```
 
-`-AllowCommit` 옵션은 T004에서 파라미터와 출력만 제공한다. 실제 `ai-dev-commit.ps1` 실행과 `ai-dev-complete-task.ps1` 연
결은 T005에서 구현한다. 따라서 T004 full auto-cycle은 리뷰 저장 후에도 git add, git commit, complete-task를 수행하지 않는다.
+리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 comple
te-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `package
-lock.json` 변경이 감지되면 `package_files_changed`로 중단한다.
 
 ### 목표 입력 기반 자동 실행
 
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..84c3a6c8713a84a4304f6cc025a4949946302bb5
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,71 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
@@ -249,6 +314,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +328,12 @@
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
@@ -269,14 +341,14 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +375,7 @@
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +386,97 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
+
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "D
ryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
+}
+
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
+
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+$commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
+if ($commitArguments.Count -gt 0) {
+    $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
+}
+
+Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
+$stepNumber++
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+try {
+    $commitGate = Get-CommitGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -not 
(Test-HasValue $commitGate.lastCommitHash)) {
+    $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastCommand
), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCommitHash
)"
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 1 $message
+    Stop-Cycle $script:steps "commit_not_confirmed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHas
h 확인" $false $false 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 5bf9253347c33a852d2bba22cd59a4f1a4918d9c..b50e832b1d99857130daa9949b9f52658b299bb3
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -668,9 +668,9 @@
 
 ### full auto-cycle 초안
 
-`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review 흐름을 순서대로 연결하는 초안이다.
+`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 선택 파일 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.
 
-T004 버전의 실행 단계:
+T005 버전의 실행 단계:
 
 1. `ai-dev-make-prompt.ps1`
 2. `ai-dev-run-codex.ps1`
@@ -678,6 +678,10 @@
 4. `ai-dev-save-diff.ps1`
 5. `ai-dev-make-review-prompt.ps1 -Strict`
 6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`
+7. 리뷰 게이트 확인: `state.lastCommandStatus`가 `passed`이고 `state.lastReviewDecision`이 `pass`여야 한다.
+8. package 파일 변경 게이트 확인: `package.json` 또는 `package-lock.json` 변경이 있으면 자동 커밋하지 않는다.
+9. `-AllowCommit`이 있을 때만 `ai-dev-commit.ps1`을 실행한다.
+10. 커밋 성공 후에만 `ai-dev-complete-task.ps1`을 실행한다.
 
 먼저 DryRun으로 전체 단계를 확인한다. DryRun은 하위 스크립트를 실제 실행하지 않는다.
 
@@ -691,7 +695,7 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -Json
 ```
 
-기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, T004 초안은 task 완료 처
리를 하지 않으므로 실제로는 현재 task 한 개만 다룬다.
+기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, 초기 full cycle은 안전을
 위해 현재 task 한 개만 다룬다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -
MaxSteps 20
@@ -709,13 +713,19 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -MaxTasks 1
 ```
 
+리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`을 추가한다. `-CommitFiles`를 지정하
면 선택한 파일만 커밋 대상으로 전달한다.
+
+```powershell
+powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTasks 
1
+```
+
 dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-c
odex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowDirty -MaxTasks 1
 ```
 
-`-AllowCommit` 옵션은 T004에서 파라미터와 출력만 제공한다. 실제 `ai-dev-commit.ps1` 실행과 `ai-dev-complete-task.ps1` 연
결은 T005에서 구현한다. 따라서 T004 full auto-cycle은 리뷰 저장 후에도 git add, git commit, complete-task를 수행하지 않는다.
+리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 comple
te-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `package
-lock.json` 변경이 감지되면 `package_files_changed`로 중단한다.
 
 ### 목표 입력 기반 자동 실행
 
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..84c3a6c8713a84a4304f6cc025a4949946302bb5
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,71 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
@@ -249,6 +314,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +328,12 @@
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
@@ -269,14 +341,14 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +375,7 @@
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +386,97 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
+
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "D
ryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
+}
+
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
+
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+$commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
+if ($commitArguments.Count -gt 0) {
+    $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
+}
+
+Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
+$stepNumber++
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+try {
+    $commitGate = Get-CommitGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -not 
(Test-HasValue $commitGate.lastCommitHash)) {
+    $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastCommand
), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCommitHash
)"
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 1 $message
+    Stop-Cycle $script:steps "commit_not_confirmed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHas
h 확인" $false $false 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

codex
커밋 결과 확인 게이트를 추가했으므로 README 단계 번호도 맞춰 갱신하겠습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\.ai-dev\README.md
diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 5bf9253347c33a852d2bba22cd59a4f1a4918d9c..1bdb85799839984c1deb03a6eba84a23cfc01093
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -668,9 +668,9 @@
 
 ### full auto-cycle 초안
 
-`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review 흐름을 순서대로 연결하는 초안이다.
+`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 선택 파일 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.
 
-T004 버전의 실행 단계:
+T005 버전의 실행 단계:
 
 1. `ai-dev-make-prompt.ps1`
 2. `ai-dev-run-codex.ps1`
@@ -678,6 +678,11 @@
 4. `ai-dev-save-diff.ps1`
 5. `ai-dev-make-review-prompt.ps1 -Strict`
 6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`
+7. 리뷰 게이트 확인: `state.lastCommandStatus`가 `passed`이고 `state.lastReviewDecision`이 `pass`여야 한다.
+8. package 파일 변경 게이트 확인: `package.json` 또는 `package-lock.json` 변경이 있으면 자동 커밋하지 않는다.
+9. `-AllowCommit`이 있을 때만 `ai-dev-commit.ps1`을 실행한다.
+10. 커밋 결과 게이트 확인: `state.lastCommand`가 `commit`이고 `lastCommitHash`가 있어야 한다.
+11. 커밋 성공 후에만 `ai-dev-complete-task.ps1`을 실행한다.
 
 먼저 DryRun으로 전체 단계를 확인한다. DryRun은 하위 스크립트를 실제 실행하지 않는다.
 
@@ -691,7 +696,7 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -Json
 ```
 
-기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, T004 초안은 task 완료 처
리를 하지 않으므로 실제로는 현재 task 한 개만 다룬다.
+기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, 초기 full cycle은 안전을
 위해 현재 task 한 개만 다룬다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -
MaxSteps 20
@@ -709,13 +714,19 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -MaxTasks 1
 ```
 
+리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`을 추가한다. `-CommitFiles`를 지정하
면 선택한 파일만 커밋 대상으로 전달한다.
+
+```powershell
+powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTasks 
1
+```
+
 dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-c
odex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowDirty -MaxTasks 1
 ```
 
-`-AllowCommit` 옵션은 T004에서 파라미터와 출력만 제공한다. 실제 `ai-dev-commit.ps1` 실행과 `ai-dev-complete-task.ps1` 연
결은 T005에서 구현한다. 따라서 T004 full auto-cycle은 리뷰 저장 후에도 git add, git commit, complete-task를 수행하지 않는다.
+리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 comple
te-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `package
-lock.json` 변경이 감지되면 `package_files_changed`로 중단한다. 커밋 스크립트가 변경사항 없음 등으로 실제 commit hash를 기록하지 못하면 
`commit_not_confirmed`로 중단하고 complete-task를 실행하지 않는다.
 
 ### 목표 입력 기반 자동 실행
 
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..84c3a6c8713a84a4304f6cc025a4949946302bb5
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,71 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
@@ -249,6 +314,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +328,12 @@
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
@@ -269,14 +341,14 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +375,7 @@
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +386,97 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
+
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "D
ryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
+}
+
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
+
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+$commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
+if ($commitArguments.Count -gt 0) {
+    $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
+}
+
+Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
+$stepNumber++
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+try {
+    $commitGate = Get-CommitGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -not 
(Test-HasValue $commitGate.lastCommitHash)) {
+    $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastCommand
), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCommitHash
)"
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 1 $message
+    Stop-Cycle $script:steps "commit_not_confirmed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHas
h 확인" $false $false 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 5bf9253347c33a852d2bba22cd59a4f1a4918d9c..1bdb85799839984c1deb03a6eba84a23cfc01093
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -668,9 +668,9 @@
 
 ### full auto-cycle 초안
 
-`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review 흐름을 순서대로 연결하는 초안이다.
+`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 선택 파일 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.
 
-T004 버전의 실행 단계:
+T005 버전의 실행 단계:
 
 1. `ai-dev-make-prompt.ps1`
 2. `ai-dev-run-codex.ps1`
@@ -678,6 +678,11 @@
 4. `ai-dev-save-diff.ps1`
 5. `ai-dev-make-review-prompt.ps1 -Strict`
 6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`
+7. 리뷰 게이트 확인: `state.lastCommandStatus`가 `passed`이고 `state.lastReviewDecision`이 `pass`여야 한다.
+8. package 파일 변경 게이트 확인: `package.json` 또는 `package-lock.json` 변경이 있으면 자동 커밋하지 않는다.
+9. `-AllowCommit`이 있을 때만 `ai-dev-commit.ps1`을 실행한다.
+10. 커밋 결과 게이트 확인: `state.lastCommand`가 `commit`이고 `lastCommitHash`가 있어야 한다.
+11. 커밋 성공 후에만 `ai-dev-complete-task.ps1`을 실행한다.
 
 먼저 DryRun으로 전체 단계를 확인한다. DryRun은 하위 스크립트를 실제 실행하지 않는다.
 
@@ -691,7 +696,7 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -Json
 ```
 
-기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, T004 초안은 task 완료 처
리를 하지 않으므로 실제로는 현재 task 한 개만 다룬다.
+기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, 초기 full cycle은 안전을
 위해 현재 task 한 개만 다룬다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -
MaxSteps 20
@@ -709,13 +714,19 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -MaxTasks 1
 ```
 
+리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`을 추가한다. `-CommitFiles`를 지정하
면 선택한 파일만 커밋 대상으로 전달한다.
+
+```powershell
+powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTasks 
1
+```
+
 dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-c
odex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowDirty -MaxTasks 1
 ```
 
-`-AllowCommit` 옵션은 T004에서 파라미터와 출력만 제공한다. 실제 `ai-dev-commit.ps1` 실행과 `ai-dev-complete-task.ps1` 연
결은 T005에서 구현한다. 따라서 T004 full auto-cycle은 리뷰 저장 후에도 git add, git commit, complete-task를 수행하지 않는다.
+리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 comple
te-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `package
-lock.json` 변경이 감지되면 `package_files_changed`로 중단한다. 커밋 스크립트가 변경사항 없음 등으로 실제 commit hash를 기록하지 못하면 
`commit_not_confirmed`로 중단하고 complete-task를 실행하지 않는다.
 
 ### 목표 입력 기반 자동 실행
 
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..84c3a6c8713a84a4304f6cc025a4949946302bb5
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,71 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
@@ -249,6 +314,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +328,12 @@
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
@@ -269,14 +341,14 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +375,7 @@
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +386,97 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
+
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "D
ryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
+}
+
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
+
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+$commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
+if ($commitArguments.Count -gt 0) {
+    $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
+}
+
+Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
+$stepNumber++
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+try {
+    $commitGate = Get-CommitGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -not 
(Test-HasValue $commitGate.lastCommitHash)) {
+    $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastCommand
), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCommitHash
)"
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 1 $message
+    Stop-Cycle $script:steps "commit_not_confirmed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHas
h 확인" $false $false 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

codex
이제 최종 형태로 문법과 DryRun을 다시 확인하겠습니다. 이 검증은 build/test/lint, git commit, 브라우저 실행을 하지 않습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '$tokens = $null; $parse
Errors = $null; $null = [System.Management.Automation.Language.Parser]::ParseFile('"'scripts/ai-de
v-auto-cycle-full.ps1', [ref]"'$tokens, [ref]$parseErrors); if ($parseErrors.Count -gt 0) { $parse
Errors | ForEach-Object { $_.Message }; exit 1 } else { '"'syntax ok' }" in D:\ai-apps\planpilot-l
ocal
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'powershell -ExecutionPo
licy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -MaxSteps 20 -Json' in D:
\ai-apps\planpilot-local
 succeeded in 1813ms:
syntax ok

 succeeded in 3056ms:
{
    "steps":  [
                  {
                      "step":  1,
                      "name":  "make-prompt",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-pr
ompt.ps1",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 하위 스크립트를 실행하지 않았습니다."
                  },
                  {
                      "step":  2,
                      "name":  "run-codex",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-cod
ex.ps1",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 하위 스크립트를 실행하지 않았습니다."
                  },
                  {
                      "step":  3,
                      "name":  "check",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.p
s1 -BuildOnly",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 하위 스크립트를 실행하지 않았습니다."
                  },
                  {
                      "step":  4,
                      "name":  "save-diff",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-di
ff.ps1",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 하위 스크립트를 실행하지 않았습니다."
                  },
                  {
                      "step":  5,
                      "name":  "make-review-prompt",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-re
view-prompt.ps1 -Strict",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 하위 스크립트를 실행하지 않았습니다."
                  },
                  {
                      "step":  6,
                      "name":  "run-review-codex",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-rev
iew-codex.ps1 -AllowDirty -SaveReview",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 하위 스크립트를 실행하지 않았습니다."
                  },
                  {
                      "step":  7,
                      "name":  "review-gate",
                      "command":  "state.lastReviewDecision 확인",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
                  },
                  {
                      "step":  8,
                      "name":  "package-change-gate",
                      "command":  "git status --porcelain -- package.json package-lock.json",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
                  },
                  {
                      "step":  9,
                      "name":  "commit",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.
ps1",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: git add/commit을 실행하지 않았습니다."
                  },
                  {
                      "step":  10,
                      "name":  "commit-result-gate",
                      "command":  "state.lastCommand/lastCommitHash 확인",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
                  },
                  {
                      "step":  11,
                      "name":  "complete-task",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complet
e-task.ps1 -ResultSummary \"리뷰 pass 후 자동 커밋 완료\"",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: task 완료 처리를 실행하지 않았습니다."
                  }
              ],
    "stoppedReason":  "dry_run",
    "completed":  false,
    "exitCode":  0
}

diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 5bf9253347c33a852d2bba22cd59a4f1a4918d9c..1bdb85799839984c1deb03a6eba84a23cfc01093
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -668,9 +668,9 @@
 
 ### full auto-cycle 초안
 
-`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review 흐름을 순서대로 연결하는 초안이다.
+`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 선택 파일 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.
 
-T004 버전의 실행 단계:
+T005 버전의 실행 단계:
 
 1. `ai-dev-make-prompt.ps1`
 2. `ai-dev-run-codex.ps1`
@@ -678,6 +678,11 @@
 4. `ai-dev-save-diff.ps1`
 5. `ai-dev-make-review-prompt.ps1 -Strict`
 6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`
+7. 리뷰 게이트 확인: `state.lastCommandStatus`가 `passed`이고 `state.lastReviewDecision`이 `pass`여야 한다.
+8. package 파일 변경 게이트 확인: `package.json` 또는 `package-lock.json` 변경이 있으면 자동 커밋하지 않는다.
+9. `-AllowCommit`이 있을 때만 `ai-dev-commit.ps1`을 실행한다.
+10. 커밋 결과 게이트 확인: `state.lastCommand`가 `commit`이고 `lastCommitHash`가 있어야 한다.
+11. 커밋 성공 후에만 `ai-dev-complete-task.ps1`을 실행한다.
 
 먼저 DryRun으로 전체 단계를 확인한다. DryRun은 하위 스크립트를 실제 실행하지 않는다.
 
@@ -691,7 +696,7 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -Json
 ```
 
-기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, T004 초안은 task 완료 처
리를 하지 않으므로 실제로는 현재 task 한 개만 다룬다.
+기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, 초기 full cycle은 안전을
 위해 현재 task 한 개만 다룬다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -
MaxSteps 20
@@ -709,13 +714,19 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -MaxTasks 1
 ```
 
+리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`을 추가한다. `-CommitFiles`를 지정하
면 선택한 파일만 커밋 대상으로 전달한다.
+
+```powershell
+powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTasks 
1
+```
+
 dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-c
odex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowDirty -MaxTasks 1
 ```
 
-`-AllowCommit` 옵션은 T004에서 파라미터와 출력만 제공한다. 실제 `ai-dev-commit.ps1` 실행과 `ai-dev-complete-task.ps1` 연
결은 T005에서 구현한다. 따라서 T004 full auto-cycle은 리뷰 저장 후에도 git add, git commit, complete-task를 수행하지 않는다.
+리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 comple
te-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `package
-lock.json` 변경이 감지되면 `package_files_changed`로 중단한다. 커밋 스크립트가 변경사항 없음 등으로 실제 commit hash를 기록하지 못하면 
`commit_not_confirmed`로 중단하고 complete-task를 실행하지 않는다.
 
 ### 목표 입력 기반 자동 실행
 
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..84c3a6c8713a84a4304f6cc025a4949946302bb5
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,71 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
@@ -249,6 +314,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +328,12 @@
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
@@ -269,14 +341,14 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +375,7 @@
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +386,97 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
+
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "D
ryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
+}
+
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
+
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+$commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
+if ($commitArguments.Count -gt 0) {
+    $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
+}
+
+Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
+$stepNumber++
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+try {
+    $commitGate = Get-CommitGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -not 
(Test-HasValue $commitGate.lastCommitHash)) {
+    $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastCommand
), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCommitHash
)"
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 1 $message
+    Stop-Cycle $script:steps "commit_not_confirmed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHas
h 확인" $false $false 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

codex
요구사항의 “선택 파일 커밋”을 더 엄격히 해석하는 편이 안전합니다. full cycle에서 `-AllowCommit`만으로 전체 변경을 커밋하지 않고, `-CommitFile
s`가 지정된 경우에만 커밋 스크립트로 넘기도록 좁히겠습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\scripts\ai-dev-auto-cycle-full.ps1
diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 5bf9253347c33a852d2bba22cd59a4f1a4918d9c..1bdb85799839984c1deb03a6eba84a23cfc01093
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -668,9 +668,9 @@
 
 ### full auto-cycle 초안
 
-`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review 흐름을 순서대로 연결하는 초안이다.
+`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 선택 파일 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.
 
-T004 버전의 실행 단계:
+T005 버전의 실행 단계:
 
 1. `ai-dev-make-prompt.ps1`
 2. `ai-dev-run-codex.ps1`
@@ -678,6 +678,11 @@
 4. `ai-dev-save-diff.ps1`
 5. `ai-dev-make-review-prompt.ps1 -Strict`
 6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`
+7. 리뷰 게이트 확인: `state.lastCommandStatus`가 `passed`이고 `state.lastReviewDecision`이 `pass`여야 한다.
+8. package 파일 변경 게이트 확인: `package.json` 또는 `package-lock.json` 변경이 있으면 자동 커밋하지 않는다.
+9. `-AllowCommit`이 있을 때만 `ai-dev-commit.ps1`을 실행한다.
+10. 커밋 결과 게이트 확인: `state.lastCommand`가 `commit`이고 `lastCommitHash`가 있어야 한다.
+11. 커밋 성공 후에만 `ai-dev-complete-task.ps1`을 실행한다.
 
 먼저 DryRun으로 전체 단계를 확인한다. DryRun은 하위 스크립트를 실제 실행하지 않는다.
 
@@ -691,7 +696,7 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -Json
 ```
 
-기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, T004 초안은 task 완료 처
리를 하지 않으므로 실제로는 현재 task 한 개만 다룬다.
+기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, 초기 full cycle은 안전을
 위해 현재 task 한 개만 다룬다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -
MaxSteps 20
@@ -709,13 +714,19 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -MaxTasks 1
 ```
 
+리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`을 추가한다. `-CommitFiles`를 지정하
면 선택한 파일만 커밋 대상으로 전달한다.
+
+```powershell
+powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTasks 
1
+```
+
 dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-c
odex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowDirty -MaxTasks 1
 ```
 
-`-AllowCommit` 옵션은 T004에서 파라미터와 출력만 제공한다. 실제 `ai-dev-commit.ps1` 실행과 `ai-dev-complete-task.ps1` 연
결은 T005에서 구현한다. 따라서 T004 full auto-cycle은 리뷰 저장 후에도 git add, git commit, complete-task를 수행하지 않는다.
+리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 comple
te-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `package
-lock.json` 변경이 감지되면 `package_files_changed`로 중단한다. 커밋 스크립트가 변경사항 없음 등으로 실제 commit hash를 기록하지 못하면 
`commit_not_confirmed`로 중단하고 complete-task를 실행하지 않는다.
 
 ### 목표 입력 기반 자동 실행
 
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..effe1a6dc47f7fb626e50e31b78fca6d3085ab76
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,71 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
@@ -249,6 +314,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +328,12 @@
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
@@ -269,14 +341,14 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +375,7 @@
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +386,103 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
+
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "D
ryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
+}
+
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -CommitFiles <files> -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+
+if ($commitArguments.Count -eq 0) {
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1 -Files <files>" $false $true 1 "자동 커밋에는 선택 파일 목록이 필요합니다. -CommitFiles 
scripts/example.ps1,.ai-dev/README.md 형식으로 지정하세요."
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
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
+}
+
+if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -not 
(Test-HasValue $commitGate.lastCommitHash)) {
+    $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastCommand
), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCommitHash
)"
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 1 $message
+    Stop-Cycle $script:steps "commit_not_confirmed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHas
h 확인" $false $false 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 5bf9253347c33a852d2bba22cd59a4f1a4918d9c..1bdb85799839984c1deb03a6eba84a23cfc01093
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -668,9 +668,9 @@
 
 ### full auto-cycle 초안
 
-`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review 흐름을 순서대로 연결하는 초안이다.
+`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 선택 파일 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.
 
-T004 버전의 실행 단계:
+T005 버전의 실행 단계:
 
 1. `ai-dev-make-prompt.ps1`
 2. `ai-dev-run-codex.ps1`
@@ -678,6 +678,11 @@
 4. `ai-dev-save-diff.ps1`
 5. `ai-dev-make-review-prompt.ps1 -Strict`
 6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`
+7. 리뷰 게이트 확인: `state.lastCommandStatus`가 `passed`이고 `state.lastReviewDecision`이 `pass`여야 한다.
+8. package 파일 변경 게이트 확인: `package.json` 또는 `package-lock.json` 변경이 있으면 자동 커밋하지 않는다.
+9. `-AllowCommit`이 있을 때만 `ai-dev-commit.ps1`을 실행한다.
+10. 커밋 결과 게이트 확인: `state.lastCommand`가 `commit`이고 `lastCommitHash`가 있어야 한다.
+11. 커밋 성공 후에만 `ai-dev-complete-task.ps1`을 실행한다.
 
 먼저 DryRun으로 전체 단계를 확인한다. DryRun은 하위 스크립트를 실제 실행하지 않는다.
 
@@ -691,7 +696,7 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -Json
 ```
 
-기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, T004 초안은 task 완료 처
리를 하지 않으므로 실제로는 현재 task 한 개만 다룬다.
+기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, 초기 full cycle은 안전을
 위해 현재 task 한 개만 다룬다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -
MaxSteps 20
@@ -709,13 +714,19 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -MaxTasks 1
 ```
 
+리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`을 추가한다. `-CommitFiles`를 지정하
면 선택한 파일만 커밋 대상으로 전달한다.
+
+```powershell
+powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTasks 
1
+```
+
 dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-c
odex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowDirty -MaxTasks 1
 ```
 
-`-AllowCommit` 옵션은 T004에서 파라미터와 출력만 제공한다. 실제 `ai-dev-commit.ps1` 실행과 `ai-dev-complete-task.ps1` 연
결은 T005에서 구현한다. 따라서 T004 full auto-cycle은 리뷰 저장 후에도 git add, git commit, complete-task를 수행하지 않는다.
+리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 comple
te-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `package
-lock.json` 변경이 감지되면 `package_files_changed`로 중단한다. 커밋 스크립트가 변경사항 없음 등으로 실제 commit hash를 기록하지 못하면 
`commit_not_confirmed`로 중단하고 complete-task를 실행하지 않는다.
 
 ### 목표 입력 기반 자동 실행
 
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..effe1a6dc47f7fb626e50e31b78fca6d3085ab76
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,71 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
@@ -249,6 +314,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +328,12 @@
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
@@ -269,14 +341,14 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +375,7 @@
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +386,103 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
+
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "D
ryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
+}
+
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -CommitFiles <files> -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+
+if ($commitArguments.Count -eq 0) {
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1 -Files <files>" $false $true 1 "자동 커밋에는 선택 파일 목록이 필요합니다. -CommitFiles 
scripts/example.ps1,.ai-dev/README.md 형식으로 지정하세요."
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
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
+}
+
+if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -not 
(Test-HasValue $commitGate.lastCommitHash)) {
+    $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastCommand
), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCommitHash
)"
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 1 $message
+    Stop-Cycle $script:steps "commit_not_confirmed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHas
h 확인" $false $false 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

codex
문서도 같은 정책으로 맞춰 `-AllowCommit`에는 반드시 `-CommitFiles`가 필요하다고 명시하겠습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\.ai-dev\README.md
diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 5bf9253347c33a852d2bba22cd59a4f1a4918d9c..53d98da00e94782e631bca47c1b7ebdf54159c39
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -668,9 +668,9 @@
 
 ### full auto-cycle 초안
 
-`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review 흐름을 순서대로 연결하는 초안이다.
+`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 선택 파일 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.
 
-T004 버전의 실행 단계:
+T005 버전의 실행 단계:
 
 1. `ai-dev-make-prompt.ps1`
 2. `ai-dev-run-codex.ps1`
@@ -678,6 +678,11 @@
 4. `ai-dev-save-diff.ps1`
 5. `ai-dev-make-review-prompt.ps1 -Strict`
 6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`
+7. 리뷰 게이트 확인: `state.lastCommandStatus`가 `passed`이고 `state.lastReviewDecision`이 `pass`여야 한다.
+8. package 파일 변경 게이트 확인: `package.json` 또는 `package-lock.json` 변경이 있으면 자동 커밋하지 않는다.
+9. `-AllowCommit`과 `-CommitFiles`가 있을 때만 `ai-dev-commit.ps1 -Files`를 실행한다.
+10. 커밋 결과 게이트 확인: `state.lastCommand`가 `commit`이고 `lastCommitHash`가 있어야 한다.
+11. 커밋 성공 후에만 `ai-dev-complete-task.ps1`을 실행한다.
 
 먼저 DryRun으로 전체 단계를 확인한다. DryRun은 하위 스크립트를 실제 실행하지 않는다.
 
@@ -691,7 +696,7 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -Json
 ```
 
-기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, T004 초안은 task 완료 처
리를 하지 않으므로 실제로는 현재 task 한 개만 다룬다.
+기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, 초기 full cycle은 안전을
 위해 현재 task 한 개만 다룬다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -
MaxSteps 20
@@ -709,13 +714,19 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -MaxTasks 1
 ```
 
+리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`과 `-CommitFiles`를 함께 지정한다. 
full cycle은 안전을 위해 선택 파일 목록이 없으면 자동 커밋하지 않는다.
+
+```powershell
+powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTasks 
1
+```
+
 dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-c
odex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowDirty -MaxTasks 1
 ```
 
-`-AllowCommit` 옵션은 T004에서 파라미터와 출력만 제공한다. 실제 `ai-dev-commit.ps1` 실행과 `ai-dev-complete-task.ps1` 연
결은 T005에서 구현한다. 따라서 T004 full auto-cycle은 리뷰 저장 후에도 git add, git commit, complete-task를 수행하지 않는다.
+리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 comple
te-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `package
-lock.json` 변경이 감지되면 `package_files_changed`로 중단한다. 커밋 스크립트가 변경사항 없음 등으로 실제 commit hash를 기록하지 못하면 
`commit_not_confirmed`로 중단하고 complete-task를 실행하지 않는다.
 
 ### 목표 입력 기반 자동 실행
 
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..effe1a6dc47f7fb626e50e31b78fca6d3085ab76
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,71 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
@@ -249,6 +314,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +328,12 @@
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
@@ -269,14 +341,14 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +375,7 @@
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +386,103 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
+
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "D
ryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
+}
+
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -CommitFiles <files> -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+
+if ($commitArguments.Count -eq 0) {
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1 -Files <files>" $false $true 1 "자동 커밋에는 선택 파일 목록이 필요합니다. -CommitFiles 
scripts/example.ps1,.ai-dev/README.md 형식으로 지정하세요."
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
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
+}
+
+if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -not 
(Test-HasValue $commitGate.lastCommitHash)) {
+    $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastCommand
), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCommitHash
)"
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 1 $message
+    Stop-Cycle $script:steps "commit_not_confirmed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHas
h 확인" $false $false 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 5bf9253347c33a852d2bba22cd59a4f1a4918d9c..53d98da00e94782e631bca47c1b7ebdf54159c39
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -668,9 +668,9 @@
 
 ### full auto-cycle 초안
 
-`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review 흐름을 순서대로 연결하는 초안이다.
+`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 선택 파일 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.
 
-T004 버전의 실행 단계:
+T005 버전의 실행 단계:
 
 1. `ai-dev-make-prompt.ps1`
 2. `ai-dev-run-codex.ps1`
@@ -678,6 +678,11 @@
 4. `ai-dev-save-diff.ps1`
 5. `ai-dev-make-review-prompt.ps1 -Strict`
 6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`
+7. 리뷰 게이트 확인: `state.lastCommandStatus`가 `passed`이고 `state.lastReviewDecision`이 `pass`여야 한다.
+8. package 파일 변경 게이트 확인: `package.json` 또는 `package-lock.json` 변경이 있으면 자동 커밋하지 않는다.
+9. `-AllowCommit`과 `-CommitFiles`가 있을 때만 `ai-dev-commit.ps1 -Files`를 실행한다.
+10. 커밋 결과 게이트 확인: `state.lastCommand`가 `commit`이고 `lastCommitHash`가 있어야 한다.
+11. 커밋 성공 후에만 `ai-dev-complete-task.ps1`을 실행한다.
 
 먼저 DryRun으로 전체 단계를 확인한다. DryRun은 하위 스크립트를 실제 실행하지 않는다.
 
@@ -691,7 +696,7 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -Json
 ```
 
-기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, T004 초안은 task 완료 처
리를 하지 않으므로 실제로는 현재 task 한 개만 다룬다.
+기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, 초기 full cycle은 안전을
 위해 현재 task 한 개만 다룬다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -
MaxSteps 20
@@ -709,13 +714,19 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -MaxTasks 1
 ```
 
+리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`과 `-CommitFiles`를 함께 지정한다. 
full cycle은 안전을 위해 선택 파일 목록이 없으면 자동 커밋하지 않는다.
+
+```powershell
+powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTasks 
1
+```
+
 dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-c
odex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowDirty -MaxTasks 1
 ```
 
-`-AllowCommit` 옵션은 T004에서 파라미터와 출력만 제공한다. 실제 `ai-dev-commit.ps1` 실행과 `ai-dev-complete-task.ps1` 연
결은 T005에서 구현한다. 따라서 T004 full auto-cycle은 리뷰 저장 후에도 git add, git commit, complete-task를 수행하지 않는다.
+리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 comple
te-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `package
-lock.json` 변경이 감지되면 `package_files_changed`로 중단한다. 커밋 스크립트가 변경사항 없음 등으로 실제 commit hash를 기록하지 못하면 
`commit_not_confirmed`로 중단하고 complete-task를 실행하지 않는다.
 
 ### 목표 입력 기반 자동 실행
 
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..effe1a6dc47f7fb626e50e31b78fca6d3085ab76
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,71 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
@@ -249,6 +314,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +328,12 @@
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
@@ -269,14 +341,14 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +375,7 @@
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +386,103 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
+
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "D
ryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
+}
+
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -CommitFiles <files> -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+
+if ($commitArguments.Count -eq 0) {
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1 -Files <files>" $false $true 1 "자동 커밋에는 선택 파일 목록이 필요합니다. -CommitFiles 
scripts/example.ps1,.ai-dev/README.md 형식으로 지정하세요."
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
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
+}
+
+if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -not 
(Test-HasValue $commitGate.lastCommitHash)) {
+    $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastCommand
), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCommitHash
)"
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 1 $message
+    Stop-Cycle $script:steps "commit_not_confirmed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHas
h 확인" $false $false 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

codex
선택 파일 필수 정책까지 반영했습니다. 마지막으로 문법 검증과 DryRun을 한 번 더 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '$tokens = $null; $parse
Errors = $null; $null = [System.Management.Automation.Language.Parser]::ParseFile('"'scripts/ai-de
v-auto-cycle-full.ps1', [ref]"'$tokens, [ref]$parseErrors); if ($parseErrors.Count -gt 0) { $parse
Errors | ForEach-Object { $_.Message }; exit 1 } else { '"'syntax ok' }" in D:\ai-apps\planpilot-l
ocal
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'powershell -ExecutionPo
licy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -MaxSteps 20 -Json' in D:
\ai-apps\planpilot-local
 succeeded in 1694ms:
syntax ok

 succeeded in 2932ms:
{
    "steps":  [
                  {
                      "step":  1,
                      "name":  "make-prompt",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-pr
ompt.ps1",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 하위 스크립트를 실행하지 않았습니다."
                  },
                  {
                      "step":  2,
                      "name":  "run-codex",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-cod
ex.ps1",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 하위 스크립트를 실행하지 않았습니다."
                  },
                  {
                      "step":  3,
                      "name":  "check",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.p
s1 -BuildOnly",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 하위 스크립트를 실행하지 않았습니다."
                  },
                  {
                      "step":  4,
                      "name":  "save-diff",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-di
ff.ps1",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 하위 스크립트를 실행하지 않았습니다."
                  },
                  {
                      "step":  5,
                      "name":  "make-review-prompt",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-re
view-prompt.ps1 -Strict",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 하위 스크립트를 실행하지 않았습니다."
                  },
                  {
                      "step":  6,
                      "name":  "run-review-codex",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-rev
iew-codex.ps1 -AllowDirty -SaveReview",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 하위 스크립트를 실행하지 않았습니다."
                  },
                  {
                      "step":  7,
                      "name":  "review-gate",
                      "command":  "state.lastReviewDecision 확인",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
                  },
                  {
                      "step":  8,
                      "name":  "package-change-gate",
                      "command":  "git status --porcelain -- package.json package-lock.json",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
                  },
                  {
                      "step":  9,
                      "name":  "commit",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.
ps1",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: git add/commit을 실행하지 않았습니다."
                  },
                  {
                      "step":  10,
                      "name":  "commit-result-gate",
                      "command":  "state.lastCommand/lastCommitHash 확인",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
                  },
                  {
                      "step":  11,
                      "name":  "complete-task",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complet
e-task.ps1 -ResultSummary \"리뷰 pass 후 자동 커밋 완료\"",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: task 완료 처리를 실행하지 않았습니다."
                  }
              ],
    "stoppedReason":  "dry_run",
    "completed":  false,
    "exitCode":  0
}

diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 5bf9253347c33a852d2bba22cd59a4f1a4918d9c..53d98da00e94782e631bca47c1b7ebdf54159c39
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -668,9 +668,9 @@
 
 ### full auto-cycle 초안
 
-`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review 흐름을 순서대로 연결하는 초안이다.
+`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 선택 파일 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.
 
-T004 버전의 실행 단계:
+T005 버전의 실행 단계:
 
 1. `ai-dev-make-prompt.ps1`
 2. `ai-dev-run-codex.ps1`
@@ -678,6 +678,11 @@
 4. `ai-dev-save-diff.ps1`
 5. `ai-dev-make-review-prompt.ps1 -Strict`
 6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`
+7. 리뷰 게이트 확인: `state.lastCommandStatus`가 `passed`이고 `state.lastReviewDecision`이 `pass`여야 한다.
+8. package 파일 변경 게이트 확인: `package.json` 또는 `package-lock.json` 변경이 있으면 자동 커밋하지 않는다.
+9. `-AllowCommit`과 `-CommitFiles`가 있을 때만 `ai-dev-commit.ps1 -Files`를 실행한다.
+10. 커밋 결과 게이트 확인: `state.lastCommand`가 `commit`이고 `lastCommitHash`가 있어야 한다.
+11. 커밋 성공 후에만 `ai-dev-complete-task.ps1`을 실행한다.
 
 먼저 DryRun으로 전체 단계를 확인한다. DryRun은 하위 스크립트를 실제 실행하지 않는다.
 
@@ -691,7 +696,7 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -Json
 ```
 
-기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, T004 초안은 task 완료 처
리를 하지 않으므로 실제로는 현재 task 한 개만 다룬다.
+기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, 초기 full cycle은 안전을
 위해 현재 task 한 개만 다룬다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -
MaxSteps 20
@@ -709,13 +714,19 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -MaxTasks 1
 ```
 
+리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`과 `-CommitFiles`를 함께 지정한다. 
full cycle은 안전을 위해 선택 파일 목록이 없으면 자동 커밋하지 않는다.
+
+```powershell
+powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTasks 
1
+```
+
 dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-c
odex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowDirty -MaxTasks 1
 ```
 
-`-AllowCommit` 옵션은 T004에서 파라미터와 출력만 제공한다. 실제 `ai-dev-commit.ps1` 실행과 `ai-dev-complete-task.ps1` 연
결은 T005에서 구현한다. 따라서 T004 full auto-cycle은 리뷰 저장 후에도 git add, git commit, complete-task를 수행하지 않는다.
+리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 comple
te-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `package
-lock.json` 변경이 감지되면 `package_files_changed`로 중단한다. 커밋 스크립트가 변경사항 없음 등으로 실제 commit hash를 기록하지 못하면 
`commit_not_confirmed`로 중단하고 complete-task를 실행하지 않는다.
 
 ### 목표 입력 기반 자동 실행
 
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..effe1a6dc47f7fb626e50e31b78fca6d3085ab76
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,71 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
@@ -249,6 +314,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +328,12 @@
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
@@ -269,14 +341,14 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +375,7 @@
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +386,103 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
+
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "D
ryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
+}
+
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -CommitFiles <files> -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+
+if ($commitArguments.Count -eq 0) {
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1 -Files <files>" $false $true 1 "자동 커밋에는 선택 파일 목록이 필요합니다. -CommitFiles 
scripts/example.ps1,.ai-dev/README.md 형식으로 지정하세요."
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
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
+}
+
+if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -not 
(Test-HasValue $commitGate.lastCommitHash)) {
+    $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastCommand
), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCommitHash
)"
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 1 $message
+    Stop-Cycle $script:steps "commit_not_confirmed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHas
h 확인" $false $false 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

codex
T005 구현 완료했습니다.

변경한 파일:
- [scripts/ai-dev-auto-cycle-full.ps1](D:/ai-apps/planpilot-local/scripts/ai-dev-auto-cycle-full.p
s1)
- [.ai-dev/README.md](D:/ai-apps/planpilot-local/.ai-dev/README.md)

구현 요약:
- full auto-cycle에 `review-gate`, `package-change-gate`, `commit-result-gate`를 추가했습니다.
- 리뷰 저장 결과가 `passed`이고 `lastReviewDecision`이 `pass`일 때만 커밋 단계로 진행합니다.
- `review-response.json`의 `next_step`이 있으면 `complete_task`일 때만 진행합니다.
- `package.json` 또는 `package-lock.json` 변경 감지 시 `package_files_changed`로 중단합니다.
- `-AllowCommit`만으로는 커밋하지 않고, `-CommitFiles`가 지정된 경우에만 `ai-dev-commit.ps1 -Files`로 선택 파일 커밋을 수행합니다
.
- 커밋 후 `state.lastCommand=commit`, `lastCommandStatus=passed`, `lastCommitHash`가 확인될 때만 `complete-
task`를 실행합니다.
- README의 full auto-cycle 설명을 T005 기준으로 갱신했습니다.

검증:
- PowerShell 문법 검증 통과:
  - `Parser.ParseFile('scripts/ai-dev-auto-cycle-full.ps1', ...)`
- DryRun 확인 통과:
  - `powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks
 1 -MaxSteps 20 -Json`
  - 11단계가 표시되고, 하위 스크립트/build/git commit/complete-task는 실행되지 않았습니다.
- `npm run build`, `npm run test`, `npm run lint`, 실제 git commit은 실행하지 않았습니다.

남은 위험:
- 실제 pass 리뷰 이후의 end-to-end 커밋/complete-task 실행은 T006의 작은 task 검증에서 확인해야 합니다.
- package 변경, build 실패, non-pass 리뷰 중단은 현재 코드 게이트와 흐름 기준으로 확인했으며 실제 시나리오 실행은 하지 않았습니다.

다음 task로 넘어가도 됩니다.

`.ai-dev/loop-log.md` 기록용 요약:
```markdown
## T005 - 자동 커밋과 task 완료 연결

- `ai-dev-auto-cycle-full.ps1`에 리뷰 pass 게이트, package 파일 변경 게이트, 커밋 결과 확인 게이트를 추가했다.
- `-AllowCommit`과 `-CommitFiles`가 있을 때만 선택 파일 커밋을 실행하도록 제한했다.
- 실제 commit hash가 state에 기록된 경우에만 `ai-dev-complete-task.ps1`을 실행하도록 연결했다.
- `.ai-dev/README.md`의 full auto-cycle 설명을 T005 기준으로 갱신했다.
- PowerShell 문법 검증과 full cycle DryRun을 확인했다.
```
diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 5bf9253347c33a852d2bba22cd59a4f1a4918d9c..53d98da00e94782e631bca47c1b7ebdf54159c39
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -668,9 +668,9 @@
 
 ### full auto-cycle 초안
 
-`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review 흐름을 순서대로 연결하는 초안이다.
+`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 선택 파일 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.
 
-T004 버전의 실행 단계:
+T005 버전의 실행 단계:
 
 1. `ai-dev-make-prompt.ps1`
 2. `ai-dev-run-codex.ps1`
@@ -678,6 +678,11 @@
 4. `ai-dev-save-diff.ps1`
 5. `ai-dev-make-review-prompt.ps1 -Strict`
 6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`
+7. 리뷰 게이트 확인: `state.lastCommandStatus`가 `passed`이고 `state.lastReviewDecision`이 `pass`여야 한다.
+8. package 파일 변경 게이트 확인: `package.json` 또는 `package-lock.json` 변경이 있으면 자동 커밋하지 않는다.
+9. `-AllowCommit`과 `-CommitFiles`가 있을 때만 `ai-dev-commit.ps1 -Files`를 실행한다.
+10. 커밋 결과 게이트 확인: `state.lastCommand`가 `commit`이고 `lastCommitHash`가 있어야 한다.
+11. 커밋 성공 후에만 `ai-dev-complete-task.ps1`을 실행한다.
 
 먼저 DryRun으로 전체 단계를 확인한다. DryRun은 하위 스크립트를 실제 실행하지 않는다.
 
@@ -691,7 +696,7 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -Json
 ```
 
-기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, T004 초안은 task 완료 처
리를 하지 않으므로 실제로는 현재 task 한 개만 다룬다.
+기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이며, 초기 full cycle은 안전을
 위해 현재 task 한 개만 다룬다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -
MaxSteps 20
@@ -709,13 +714,19 @@
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -MaxTasks 1
 ```
 
+리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`과 `-CommitFiles`를 함께 지정한다. 
full cycle은 안전을 위해 선택 파일 목록이 없으면 자동 커밋하지 않는다.
+
+```powershell
+powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTasks 
1
+```
+
 dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-c
odex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.
 
 ```powershell
 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRev
iewCodex -AllowDirty -MaxTasks 1
 ```
 
-`-AllowCommit` 옵션은 T004에서 파라미터와 출력만 제공한다. 실제 `ai-dev-commit.ps1` 실행과 `ai-dev-complete-task.ps1` 연
결은 T005에서 구현한다. 따라서 T004 full auto-cycle은 리뷰 저장 후에도 git add, git commit, complete-task를 수행하지 않는다.
+리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 comple
te-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `package
-lock.json` 변경이 감지되면 `package_files_changed`로 중단한다. 커밋 스크립트가 변경사항 없음 등으로 실제 commit hash를 기록하지 못하면 
`commit_not_confirmed`로 중단하고 complete-task를 실행하지 않는다.
 
 ### 목표 입력 기반 자동 실행
 
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 27f49eae70ad3c78fd202fe45ab5ff9afccd569a..effe1a6dc47f7fb626e50e31b78fca6d3085ab76
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
@@ -141,9 +144,6 @@
     Write-Host "Completed: $($Result.completed)"
     Write-Host "Exit code: $($Result.exitCode)"
 
-    if ($AllowCommit) {
-        Write-Host "AllowCommit: specified, but T004 does not run commit or complete-task."
-    }
 }
 
 function Stop-Cycle {
@@ -202,6 +202,71 @@
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
+    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.js
on") "git status --porcelain -- package.json package-lock.json"
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
+        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -no
t [string]::IsNullOrWhiteSpace($_) })
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
@@ -249,6 +314,8 @@
         saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
         makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
+        commit = Get-ScriptPath "ai-dev-commit.ps1"
+        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Mes
sage
@@ -261,7 +328,12 @@
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
@@ -269,14 +341,14 @@
 }
 
 if ($MaxTasks -gt 1) {
-    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "T004 초안은 t
ask 완료 처리를 하지 않으므로 한 번에 현재 task만 실행합니다."
+    $script:steps += New-StepResult 0 "max-tasks" "MaxTasks=$MaxTasks" $false $true 0 "초기 full cy
cle은 안전을 위해 현재 task 하나만 실행합니다."
 }
 
 $stepNumber = 1
 Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
 $stepNumber++
 
-if (-not $AllowCodex) {
+if (-not $AllowCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -303,7 +375,7 @@
 Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
 $stepNumber++
 
-if (-not $AllowReviewCodex) {
+if (-not $AllowReviewCodex -and -not $DryRun) {
     $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Allo
wCodex -AllowReviewCodex -MaxTasks $MaxTasks"
     if ($AllowDirty) {
         $command = "$command -AllowDirty"
@@ -314,11 +386,103 @@
 }
 
 Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scri
pts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirt
y", "-SaveReview")
+$stepNumber++
+
+if ($DryRun) {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
+    $stepNumber++
+    $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $false $true 0 "D
ryRun: task 완료 처리를 실행하지 않았습니다."
+    Stop-Cycle $script:steps "dry_run" $false 0
+}
+
+try {
+    $reviewGate = Get-ReviewGate
+} catch {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false $
false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "review_gate_failed" $false 1
+}
+
+if ($reviewGate.lastCommandStatus -ne "passed") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $false
 $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
+    Stop-Cycle $script:steps "review_save_not_passed" $false 1
+}
+
+if ($reviewGate.decision -ne "pass") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fals
e $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
+    Stop-Cycle $script:steps "review_not_pass" $false 0
+}
 
-$finalMessage = "T004 초안은 여기서 중단합니다. 자동 커밋과 complete-task는 T005에서 연결합니다."
-if ($AllowCommit) {
-    $finalMessage = "$finalMessage -AllowCommit은 지정되었지만 이번 버전에서는 출력만 하고 사용하지 않습니다."
+if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
+    $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_s
tep 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revi
ewGate.nextStep)"
+    Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
+}
+
+$script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $f
alse 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
+$stepNumber++
+
+try {
+    if (Test-PackageFileChanged) {
+        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain
 -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 
커밋하지 않습니다."
+        Stop-Cycle $script:steps "package_files_changed" $false 1
+    }
+} catch {
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- 
package.json package-lock.json" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "package_change_gate_failed" $false 1
 }
 
-$script:steps += New-StepResult ($stepNumber + 1) "commit-complete-placeholder" "T005에서 ai-dev-co
mmit.ps1 및 ai-dev-complete-task.ps1 연결 예정" $false $true 0 $finalMessage
-Stop-Cycle $script:steps "t004_commit_complete_not_implemented" $false 0
+$script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pack
age.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+$stepNumber++
+
+if (-not $AllowCommit) {
+    $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 -AllowCodex -AllowReviewCodex -AllowCommit -CommitFiles <files> -MaxTasks $MaxTasks"
+    if ($AllowDirty) {
+        $commitCommand = "$commitCommand -AllowDirty"
+    }
+
+    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+        $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
+    }
+
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
+    Stop-Cycle $script:steps "allow_commit_required" $false 1
+}
+
+$commitArguments = Get-CommitArguments
+
+if ($commitArguments.Count -eq 0) {
+    $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fil
e scripts/ai-dev-commit.ps1 -Files <files>" $false $true 1 "자동 커밋에는 선택 파일 목록이 필요합니다. -CommitFiles 
scripts/example.ps1,.ai-dev/README.md 형식으로 지정하세요."
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
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $false 1 $_.Exception.Message
+    Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
+}
+
+if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -not 
(Test-HasValue $commitGate.lastCommitHash)) {
+    $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastCommand
), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCommitHash
)"
+    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommi
tHash 확인" $false $true 1 $message
+    Stop-Cycle $script:steps "commit_not_confirmed" $false 1
+}
+
+$script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHas
h 확인" $false $false 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
+$stepNumber++
+
+Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 pass 후 자동 커밋 완료`"" $scriptPaths.completeTask @("-Res
ultSummary", "리뷰 pass 후 자동 커밋 완료")
+Stop-Cycle $script:steps "completed" $true 0

tokens used
63,636
T005 구현 완료했습니다.

변경한 파일:
- [scripts/ai-dev-auto-cycle-full.ps1](D:/ai-apps/planpilot-local/scripts/ai-dev-auto-cycle-full.ps1)
- [.ai-dev/README.md](D:/ai-apps/planpilot-local/.ai-dev/README.md)

구현 요약:
- full auto-cycle에 `review-gate`, `package-change-gate`, `commit-result-gate`를 추가했습니다.
- 리뷰 저장 결과가 `passed`이고 `lastReviewDecision`이 `pass`일 때만 커밋 단계로 진행합니다.
- `review-response.json`의 `next_step`이 있으면 `complete_task`일 때만 진행합니다.
- `package.json` 또는 `package-lock.json` 변경 감지 시 `package_files_changed`로 중단합니다.
- `-AllowCommit`만으로는 커밋하지 않고, `-CommitFiles`가 지정된 경우에만 `ai-dev-commit.ps1 -Files`로 선택 파일 커밋을 수행합니다.
- 커밋 후 `state.lastCommand=commit`, `lastCommandStatus=passed`, `lastCommitHash`가 확인될 때만 `complete-task`를 실행합니다.
- README의 full auto-cycle 설명을 T005 기준으로 갱신했습니다.

검증:
- PowerShell 문법 검증 통과:
  - `Parser.ParseFile('scripts/ai-dev-auto-cycle-full.ps1', ...)`
- DryRun 확인 통과:
  - `powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -MaxSteps 20 -Json`
  - 11단계가 표시되고, 하위 스크립트/build/git commit/complete-task는 실행되지 않았습니다.
- `npm run build`, `npm run test`, `npm run lint`, 실제 git commit은 실행하지 않았습니다.

남은 위험:
- 실제 pass 리뷰 이후의 end-to-end 커밋/complete-task 실행은 T006의 작은 task 검증에서 확인해야 합니다.
- package 변경, build 실패, non-pass 리뷰 중단은 현재 코드 게이트와 흐름 기준으로 확인했으며 실제 시나리오 실행은 하지 않았습니다.

다음 task로 넘어가도 됩니다.

`.ai-dev/loop-log.md` 기록용 요약:
```markdown
## T005 - 자동 커밋과 task 완료 연결

- `ai-dev-auto-cycle-full.ps1`에 리뷰 pass 게이트, package 파일 변경 게이트, 커밋 결과 확인 게이트를 추가했다.
- `-AllowCommit`과 `-CommitFiles`가 있을 때만 선택 파일 커밋을 실행하도록 제한했다.
- 실제 commit hash가 state에 기록된 경우에만 `ai-dev-complete-task.ps1`을 실행하도록 연결했다.
- `.ai-dev/README.md`의 full auto-cycle 설명을 T005 기준으로 갱신했다.
- PowerShell 문법 검증과 full cycle DryRun을 확인했다.
```

```