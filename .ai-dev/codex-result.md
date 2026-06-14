# Codex Implementation Result

## Run

- Started at: 2026-06-14 22:14:44
- Ended at: 2026-06-14 22:16:39
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
session id: 019ec645-34a6-7a91-9f1e-2b62ed5262a2
--------
user
Read and follow the full task prompt at this absolute file path: D:\ai-apps\planpilot-local\.ai-dev\
current-task-prompt.md
codex
지정된 작업 프롬프트 파일만 먼저 읽어서 요구사항과 수정 범위를 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\.ai-dev\\current-task-prompt.md'" in D:\ai-apps\planpilot-local
 succeeded in 985ms:
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표

AI Dev Loop의 auto-goal 실행 경로에서 Codex 리뷰가 pass 된 뒤 후속 완료 흐름이 자동으로 이어지도록 개선한다.

## 배경

이미 별도 자동 사이클 스크립트에는 리뷰 pass 이후 구현 변경 커밋, complete-task 호출, 메타 정보 반영 흐름이 포함되어 있다. 현재 목표는 그 흐름을 실제 aut
o-goal 실행 경로에도 연결해 수동 개입을 줄이는 것이다.

## 성공 기준

- auto-goal 실행 중 Codex 리뷰 결과가 pass이면 구현 변경 커밋 단계가 자동으로 진행된다.
- 생성된 커밋 해시가 complete-task 호출에 전달된다.
- complete-task 이후 .ai-dev 메타 변경 반영 단계가 자동으로 이어진다.
- 모든 단계가 끝난 뒤 작업 상태 확인이 수행되고 결과가 로그로 남는다.
- 기존 실패 처리와 중단 조건은 유지된다.

## 제약사항

- 기존 ai-dev-auto-cycle-full.ps1에 있는 검증된 흐름을 우선 재사용한다.
- 변경 범위는 auto-goal 실행 경로 연결에 한정한다.
- PowerShell 5.1 호환성을 유지한다.
- 사용자 데이터 저장 구조는 변경하지 않는다.
- 불필요한 대규모 구조 변경은 하지 않는다.

## 범위 제외

- 새로운 UI 추가는 제외한다.
- 데이터베이스 스키마 변경은 제외한다.
- 알림 기능 추가는 제외한다.
- 외부 연동 기능 추가는 제외한다.

## 수동 검증

- pass 결과를 반환하는 리뷰 흐름에서 auto-goal을 실행해 후속 단계가 순서대로 진행되는지 확인한다.
- complete-task에 커밋 해시가 전달되는지 로그로 확인한다.
- 마지막 상태 확인 로그가 남는지 확인한다.

## Current Task

- Task ID: T001
- Title: auto-goal pass 이후 완료 흐름 연결
- Description: Codex 리뷰 pass 이후 실제 auto-goal 실행 경로에서 구현 변경 커밋, complete-task 커밋 해시 전달, .ai-dev 메타 반영
, 최종 상태 확인이 순서대로 이어지도록 기존 자동 사이클 흐름을 연결한다.
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

- .ai-dev/scripts/ai-dev-auto-goal.ps1
- .ai-dev/scripts/ai-dev-auto-cycle-full.ps1

## Verification

- pass 리뷰 결과를 기준으로 후속 단계가 자동 실행되는지 확인한다.
- complete-task 호출에 커밋 해시가 포함되는지 확인한다.
- 완료 후 상태 확인 로그가 출력되는지 확인한다.

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
요구사항은 `.ai-dev` 자동화 스크립트 연결 작업입니다. `src` 밖 파일 수정이 필요하지만 프롬프트의 Likely Files에 명시된 자동화 스크립트 범위라서 해당 파일 
구조를 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\.ai-dev\\scripts\\ai-dev-auto-goal.ps1'" in D:\ai-apps\planpilot-loca
l
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\.ai-dev\\scripts\\ai-dev-auto-cycle-full.ps1'" in D:\ai-apps\planpilo
t-local
 exited 1 in 1358ms:
Get-Content : 'D:\ai-apps\planpilot-local\.ai-dev\scripts\ai-dev-auto-goal.ps1' 경로는 존재하지 않으므로 찾을 수 없
습니다.
위치 줄:2 문자:1
+ Get-Content -LiteralPath 'D:\ai-apps\planpilot-local\.ai-dev\scripts\ ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (D:\ai-apps\plan...v-auto-goal.ps1:String) [Get-Conten
t], ItemNotFoundEx 
   ception
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetContentCommand
 

2026-06-14T13:15:00.805491Z ERROR codex_core::tools::router: error=Exit code: 1
Wall time: 1.4 seconds
Output:
Get-Content : 'D:\ai-apps\planpilot-local\.ai-dev\scripts\ai-dev-auto-goal.ps1' 경로는 존재하지 않으므로 찾을 수 없
습니다.
위치 줄:2 문자:1
+ Get-Content -LiteralPath 'D:\ai-apps\planpilot-local\.ai-dev\scripts\ ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (D:\ai-apps\plan...v-auto-goal.ps1:String) [Get-Conten
t], ItemNotFoundEx 
   ception
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetContentCommand
 

 exited 1 in 1361ms:
Get-Content : 'D:\ai-apps\planpilot-local\.ai-dev\scripts\ai-dev-auto-cycle-full.ps1' 경로는 존재하지 않으므로 
찾을 수 없습니다.
위치 줄:2 문자:1
+ Get-Content -LiteralPath 'D:\ai-apps\planpilot-local\.ai-dev\scripts\ ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (D:\ai-apps\plan...-cycle-full.ps1:String) [Get-Conten
t], ItemNotFoundEx 
   ception
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetContentCommand
 

2026-06-14T13:15:00.887797Z ERROR codex_core::tools::router: error=Exit code: 1
Wall time: 1.4 seconds
Output:
Get-Content : 'D:\ai-apps\planpilot-local\.ai-dev\scripts\ai-dev-auto-cycle-full.ps1' 경로는 존재하지 않으므로 
찾을 수 없습니다.
위치 줄:2 문자:1
+ Get-Content -LiteralPath 'D:\ai-apps\planpilot-local\.ai-dev\scripts\ ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (D:\ai-apps\plan...-cycle-full.ps1:String) [Get-Conten
t], ItemNotFoundEx 
   ception
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetContentCommand
 

codex
프롬프트의 예상 경로에는 파일이 없습니다. `.ai-dev` 안에서 실제 스크립트 위치와 이름을 좁혀 보겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "rg --files '.ai-dev'" in 
D:\ai-apps\planpilot-local
 succeeded in 1167ms:
.ai-dev\test-result.md
.ai-dev\state.json
.ai-dev\state.example.json
.ai-dev\review.md
.ai-dev\review-response.json
.ai-dev\review-prompt.md
.ai-dev\README.md
.ai-dev\queue.json
.ai-dev\queue.example.json
.ai-dev\plan.md
.ai-dev\loop-log.md
.ai-dev\goal.md
.ai-dev\extra-instructions.example.md
.ai-dev\diff.md
.ai-dev\current-task-prompt.md
.ai-dev\codex-review-result.md
.ai-dev\codex-result.md
.ai-dev\backlog.md
.ai-dev\auto-goal-planning-prompt.md

codex
`.ai-dev/scripts` 폴더가 없어서 저장소 전체에서 관련 PowerShell 스크립트 이름을 찾겠습니다. `node_modules`, `dist`, `.git`은 제외합
니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "rg --files -g '*.ps1' -g 
'"'!node_modules/**'"' -g '"'!dist/**'"' -g '"'!.git/**'"'" in D:\ai-apps\planpilot-local
 succeeded in 1185ms:
scripts\ai-dev-auto-goal.ps1
scripts\ai-dev-auto-cycle-full.ps1
scripts\ai-dev-auto-cycle.ps1
scripts\ai-dev-copy-review-prompt.ps1
scripts\ai-dev-env.ps1
scripts\ai-dev-current-task.ps1
scripts\ai-dev-complete-task.ps1
scripts\ai-dev-make-prompt.ps1
scripts\ai-dev-commit.ps1
scripts\ai-dev-init.ps1
scripts\ai-dev-check.ps1
scripts\ai-dev-make-review-prompt.ps1
scripts\ai-dev-auto-step.ps1
scripts\monitor-and-dev-loop.ps1
scripts\ai-dev-status.ps1
scripts\ai-dev-save-review.ps1
scripts\ai-dev-save-diff.ps1
scripts\ai-dev-run-review-codex.ps1
scripts\ai-dev-run-codex.ps1
scripts\ai-dev-next.ps1
scripts\ai-dev-manual-cycle.ps1
scripts\ai-dev-make-revise-prompt.ps1

codex
실제 위치는 루트의 `scripts` 폴더입니다. 작업 범위상 예상 파일과 대응되는 두 스크립트를 읽고, 이미 검증된 완료 흐름을 어디서 재사용할지 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-goal.ps1'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-cycle-full.ps1'" in D:\ai-apps\planpilot-local
 succeeded in 1096ms:
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

        if (-not $fullPath.StartsWith($repoRoot.TrimEnd("\") + "\", [System.StringComparison]::Ordin
alIgnoreCase)) {
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
        $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 1
 "git status failed: $($statusOutput -join "`n")"
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
                            HasPlanShape = ($candidateText -match '"goalMarkdown"\s*:' -and $candida
teText -match '"queue"\s*:' -and $candidateText -match '"state"\s*:')
                        }
                    }

                    break
                }
            }
        }
    }

    return @($candidates | Sort-Object -Property @{ Expression = "HasPlanShape"; Descending = $true 
}, @{ Expression = "Start"; Descending = $true } | ForEach-Object { $_.Text })
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
    $requiredFields = @("goalTitle", "goalSource", "createdAt", "updatedAt", "currentTaskId", "tasks
")

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
        $taskRequiredFields = @("id", "title", "description", "type", "status", "priority", "depends
On", "filesLikelyToChange", "verification", "commitMessage")
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

        if (@("analysis", "implementation", "documentation", "verification") -notcontains $task.type
) {
            $errors += "invalid task.type: $($task.type)"
        }

        if (@("pending", "in_progress", "done", "blocked") -notcontains $task.status) {
            $errors += "invalid task.status: $($task.status)"
        }

        if (@("P0", "P1", "P2") -notcontains $task.priority) {
            $errors += "invalid task.priority: $($task.priority)"
        }

        if ($task.dependsOn -isnot [System.Collections.IEnumerable] -or $task.dependsOn -is [string]
) {
            $errors += "task.dependsOn must be an array: $($task.id)"
        }

        if ($task.filesLikelyToChange -isnot [System.Collections.IEnumerable] -or $task.filesLikelyT
oChange -is [string]) {
            $errors += "task.filesLikelyToChange must be an array: $($task.id)"
        }

        if ($task.verification -isnot [System.Collections.IEnumerable] -or $task.verification -is [s
tring]) {
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
    $requiredFields = @("goalStatus", "currentTaskId", "currentLoop", "maxLoopsPerTask", "repeatedFa
ilureCount", "lastCommand", "lastCommandStatus", "lastErrorSummary", "lastReviewDecision", "lastRevi
ewSeverity", "lastCommitHash", "startedAt", "updatedAt", "stopReason")

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
                $validationFailures += "Candidate validation failed: $($validationErrors -join '; ')
"
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
        throw "No valid auto-goal JSON object was found in Codex output. Validation errors: $($valid
ationFailures -join ' | ')"
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
- goalMarkdown: .ai-dev/goal.md에 작성할 마크다운 문자열입니다. "# 목표", "배경", "성공 기준", "제약사항", "범위 제외", "수동 검증" 섹션
을 한국어로 포함해야 합니다.
- queue: an object for .ai-dev/queue.json.
- state: an object for .ai-dev/state.json.

queue rules:
- goalTitle must equal the supplied title.
- goalSource must be ".ai-dev/goal.md".
- createdAt and updatedAt are required and must be ISO 8601 strings.
- currentTaskId must be "T001".
- tasks must contain one to three tasks.
- T001 must be status "in_progress"; later tasks, if any, must be "pending".
- each task must include id, title, description, type, status, priority, dependsOn, filesLikelyToCha
nge, verification, commitMessage.
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
- Do not mention server APIs, login, cloud sync, npm install, git reset, git clean, git push, DB del
etion, or broad rewrites as implementation steps.
- Prefer one small implementation task when the goal is small.
- Use Korean for user-facing task titles, descriptions, verification, and goalMarkdown.
"@
}

function New-CodexAutoGoalWrapperPrompt {
    param(
        [string]$PromptFilePath
    )

    return "Read and follow the full auto-goal planning prompt at this absolute file path: $PromptFi
lePath"
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
        $script:steps += New-StepResult $StepNumber $Name $Command $false $true 0 "DryRun: child scr
ipt was not executed."
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
        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -not [
string]::IsNullOrWhiteSpace($_) })

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
$resolvedPlanningPromptPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $planningPromptRelativ
ePath))
$resolvedResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ResultPath))

if (-not (Test-HasValue $GoalTitle)) {
    $script:steps += New-StepResult 0 "validate-input" "check GoalTitle" $false $false 1 "GoalTitle 
must not be empty."
    Stop-AutoGoal $script:steps "invalid_goal_title" $false 1
}

if (-not (Test-HasValue $GoalDescription)) {
    $script:steps += New-StepResult 0 "validate-input" "check GoalDescription" $false $false 1 "Goal
Description must not be empty."
    Stop-AutoGoal $script:steps "invalid_goal_description" $false 1
}

if ($MaxTasks -lt 1) {
    $script:steps += New-StepResult 0 "validate-input" "check MaxTasks" $false $false 1 "MaxTasks mu
st be at least 1."
    Stop-AutoGoal $script:steps "max_tasks_must_be_at_least_1" $false 1
}

if ($MaxSteps -lt 1) {
    $script:steps += New-StepResult 0 "validate-input" "check MaxSteps" $false $false 1 "MaxSteps mu
st be at least 1."
    Stop-AutoGoal $script:steps "max_steps_must_be_at_least_1" $false 1
}

$makePromptPath = Join-Path $PSScriptRoot "ai-dev-make-prompt.ps1"
$autoCycleFullPath = Join-Path $PSScriptRoot "ai-dev-auto-cycle-full.ps1"

foreach ($requiredScript in @($makePromptPath, $autoCycleFullPath)) {
    if (-not (Test-Path -LiteralPath $requiredScript -PathType Leaf)) {
        $script:steps += New-StepResult 0 "prepare" "check required scripts" $false $false 1 "Missin
g required script: $requiredScript"
        Stop-AutoGoal $script:steps "prepare_failed" $false 1
    }
}

$shouldRunFullCycle = [bool]($AllowRun -or $AllowCodex -or $AllowReviewCodex -or $AllowCommit)
$fullCycleArguments = @(Get-FullCycleArguments)
$fullCycleCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1
 $($fullCycleArguments -join ' ')".Trim()

$script:steps += New-StepResult 1 "validate-input" "check GoalTitle/GoalDescription" $false $false 0
 "Input validation completed: $GoalTitle"

if ($DryRun) {
    $script:autoGoalPlanPreview = New-DryRunAutoGoalPlan $GoalTitle.Trim() $GoalDescription.Trim()
    $previewValidationErrors = @(Get-AutoGoalValidationErrors $script:autoGoalPlanPreview)

    if ($previewValidationErrors.Count -gt 0) {
        $script:steps += New-StepResult 2 "preview-plan" "local dry-run plan preview" $false $false 
1 "DryRun preview plan validation failed: $($previewValidationErrors -join '; ')"
        Stop-AutoGoal $script:steps "dry_run_preview_invalid" $false 1
    }

    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $true 0 "Dry
Run: dirty worktree gate was not executed."
    $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $false $t
rue 0 "DryRun: Codex goal planning was not executed. Preview currentTaskId: T001, task: $GoalTitle"
    $script:steps += New-StepResult 4 "validate-generated-json" "goal/queue/state JSON validation" $
false $true 0 "DryRun: preview goal/queue/state plan passed local schema validation."
    $script:steps += New-StepResult 5 "write-state-files" "$goalRelativePath, $queueRelativePath, $s
tateRelativePath" $false $true 0 "DryRun: state files were not written."
    $script:steps += New-StepResult 6 "make-prompt" "powershell -ExecutionPolicy Bypass -File script
s/ai-dev-make-prompt.ps1" $false $true 0 "DryRun: current-task-prompt.md was not generated."

    if ($shouldRunFullCycle) {
        $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleCommandText $false $true 0 "Dr
yRun: explicit run option is present, but full cycle was not executed. -AllowRun only invokes the fu
ll-cycle wrapper; implementation and review still require -AllowCodex and -AllowReviewCodex."
    } else {
        $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleCommandText $false $true 0 "Dr
yRun: full cycle requires -AllowRun or explicit execution options. -AllowRun only invokes the full-c
ycle wrapper; implementation and review still require -AllowCodex and -AllowReviewCodex."
    }

    Stop-AutoGoal $script:steps "dry_run" $false 0
}

$statusLines = @(Get-GitStatusLines)

if ($statusLines.Count -gt 0 -and -not $AllowDirty) {
    $dirtyText = ($statusLines -join "`n")
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $true 1 "Wor
ktree is dirty. Use -AllowDirty only when this is intentional.`n$dirtyText"
    Stop-AutoGoal $script:steps "dirty_worktree" $false 1
}

if ($statusLines.Count -gt 0) {
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 0 "Al
lowDirty is set. DirtyCount: $($statusLines.Count)"
} else {
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 0 "Wo
rktree is clean."
}

$codexCommand = Get-Command codex -ErrorAction SilentlyContinue

if ($null -eq $codexCommand) {
    $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $false $f
alse 1 "Codex CLI was not found."
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
    $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $true $fa
lse 1 "Codex goal planning failed. Result: $(ConvertTo-RepoRelativePath $ResultPath)"
    Stop-AutoGoal $script:steps "codex_plan_failed" $false 1
}

$script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $true $false 
0 "Codex goal planning completed. Result: $(ConvertTo-RepoRelativePath $ResultPath)"

try {
    $autoGoalPlan = ConvertFrom-CodexAutoGoalOutput $codexOutput
} catch {
    $preview = Get-InputPreview $codexOutput
    $script:steps += New-StepResult 4 "validate-generated-json" "goal/queue/state JSON validation" $
false $false 1 "Codex plan JSON extraction failed: $($_.Exception.Message) Output preview: $preview"
    Stop-AutoGoal $script:steps "generated_json_invalid" $false 1
}

$script:steps += New-StepResult 4 "validate-generated-json" "goal/queue/state JSON validation" $fals
e $false 0 "goalMarkdown, queue, and state JSON validation completed. currentTaskId: $($autoGoalPlan
.Parsed.queue.currentTaskId)"
$script:autoGoalPlanPreview = $autoGoalPlan.Parsed

$goalMarkdown = [string]$autoGoalPlan.Parsed.goalMarkdown
$queueJson = $autoGoalPlan.Parsed.queue | ConvertTo-Json -Depth 30
$stateJson = $autoGoalPlan.Parsed.state | ConvertTo-Json -Depth 30

[System.IO.File]::WriteAllText($resolvedGoalPath, $goalMarkdown, $utf8WithBom)
[System.IO.File]::WriteAllText($resolvedQueuePath, $queueJson, $utf8WithBom)
[System.IO.File]::WriteAllText($resolvedStatePath, $stateJson, $utf8WithBom)

$script:steps += New-StepResult 5 "write-state-files" "$goalRelativePath, $queueRelativePath, $state
RelativePath" $true $false 0 "New goal, queue, and state files were written."

Invoke-CycleCommand 6 "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-pr
ompt.ps1" $makePromptPath @()

if (-not $shouldRunFullCycle) {
    $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleCommandText $false $true 0 "Full c
ycle requires -AllowRun or explicit execution options. -AllowRun only invokes the full-cycle wrapper
; implementation and review still require -AllowCodex and -AllowReviewCodex."
    Stop-AutoGoal $script:steps "prepared_without_full_cycle" $true 0
}

Invoke-CycleCommand 7 "auto-cycle-full" $fullCycleCommandText $autoCycleFullPath $fullCycleArguments

Stop-AutoGoal $script:steps "completed" $true 0


 succeeded in 1119ms:
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
        $script:steps += New-StepResult $StepNumber $Name $Command $false $true 0 "DryRun: 하위 스크립트를 
실행하지 않았습니다."
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
    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.json"
) "git status --porcelain -- package.json package-lock.json"
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
    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::Ordi
nalIgnoreCase)
}

function Get-ChangedNonAiDevFiles {
    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
)

    return @(
        $changeLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            Where-Object { (Test-HasValue $_) -and -not (Test-IsAiDevOperationalPath $_) } |
            Select-Object -Unique
    )
}

function Get-ChangedAiDevOperationalFiles {
    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
)

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
        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -not [
string]::IsNullOrWhiteSpace($_) })

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

    $command = "direct meta commit: git add scoped .ai-dev files, git commit -m 'chore(ai-dev): reco
rd task completion', git status --short"

    try {
        $changedAiDevFiles = Get-ChangedAiDevOperationalFiles

        if ($changedAiDevFiles.Count -eq 0) {
            $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "git
 status --short"

            if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
                throw ".ai-dev 메타 변경사항은 없지만 worktree에 변경 파일이 남아 있습니다.`n$remainingStatus"
            }

            $script:steps += New-StepResult $StepNumber "meta-commit" $command $false $true 0 ".ai-d
ev 메타 상태 변경사항이 없어 meta commit을 건너뜁니다. worktree clean."
            return
        }

        $addOutput = & git add -- $changedAiDevFiles 2>&1 | Out-String
        $addExitCode = $LASTEXITCODE

        if ($addExitCode -ne 0) {
            throw "git add 실행에 실패했습니다. exit code: $addExitCode`n$addOutput"
        }

        $commitOutput = & git commit -m "chore(ai-dev): record task completion" -- $changedAiDevFile
s 2>&1 | Out-String
        $commitExitCode = $LASTEXITCODE

        if ($commitExitCode -ne 0) {
            throw "git commit 실행에 실패했습니다. exit code: $commitExitCode`n$commitOutput"
        }

        $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "git sta
tus --short"

        if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
            throw "meta commit 이후 worktree에 변경 파일이 남아 있습니다.`n$remainingStatus"
        }

        $message = ($commitOutput.Trim(), "worktree clean") -join "`n"
        $script:steps += New-StepResult $StepNumber "meta-commit" $command $true $false 0 $message
    } catch {
        $script:steps += New-StepResult $StepNumber "meta-commit" $command $true $false 1 $_.Excepti
on.Message
        Stop-Cycle $script:steps "meta_commit_failed" $false 1
    }
}

function Get-CommitGate {
    param(
        [string]$PreviousHeadCommitHash
    )

    $state = Read-JsonFile $statePath $stateRelativePath
    $lastCommitHash = if (Test-HasValue $state.lastCommitHash) { [string]$state.lastCommitHash } els
e { $null }
    $headCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-pars
e HEAD"
    $commitHashChanged = (Test-HasValue $headCommitHash) -and $headCommitHash -ne $PreviousHeadCommi
tHash
    $commitHashMatchesHead = (Test-HasValue $lastCommitHash) -and $lastCommitHash -eq $headCommitHas
h

    if ($state.lastCommand -eq "commit" -and $state.lastCommandStatus -eq "passed" -and $commitHashC
hanged -and -not $commitHashMatchesHead) {
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
    $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Messag
e
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
        $script:steps += New-StepResult $stepNumber "load-task" "state/queue 확인" $false $false 1 $_.
Exception.Message
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
    $script:steps += New-StepResult $stepNumber "task-start" "MaxTasks=$MaxTasks" $false $false 0 "현
재 task 실행 시작: $taskLabel"
    $stepNumber++

    Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/
ai-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
    $stepNumber++

    if (-not $AllowCodex -and -not $DryRun) {
        $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -All
owCodex -AllowReviewCodex -MaxTasks $MaxTasks"
        if ($AllowDirty) {
            $command = "$command -AllowDirty"
        }

        if ($AllowCommit) {
            $command = "$command -AllowCommit"
        }

        if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
            $command = "$command -CommitFiles $($CommitFiles -join ',')"
        }

        $script:steps += New-StepResult $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass 
-File scripts/ai-dev-run-codex.ps1" $false $true 1 "Codex 구현 실행에는 -AllowCodex가 필요합니다. 추천 명령: $comman
d"
        Stop-Cycle $script:steps "allow_codex_required" $false 1
    }

    $runCodexArguments = @()
    if ($AllowDirty) {
        $runCodexArguments += "-AllowDirty"
    }

    Invoke-CycleCommand $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai
-dev-run-codex.ps1" $scriptPaths.runCodex $runCodexArguments
    $stepNumber++

    Invoke-CycleCommand $stepNumber "check" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev
-check.ps1 -BuildOnly" $scriptPaths.check @("-BuildOnly")
    $stepNumber++

    Invoke-CycleCommand $stepNumber "save-diff" "powershell -ExecutionPolicy Bypass -File scripts/ai
-dev-save-diff.ps1" $scriptPaths.saveDiff @()
    $stepNumber++

    Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File s
cripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
    $stepNumber++

    if (-not $AllowReviewCodex -and -not $DryRun) {
        $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -All
owCodex -AllowReviewCodex -MaxTasks $MaxTasks"
        if ($AllowDirty) {
            $command = "$command -AllowDirty"
        }

        if ($AllowCommit) {
            $command = "$command -AllowCommit"
        }

        if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
            $command = "$command -CommitFiles $($CommitFiles -join ',')"
        }

        $script:steps += New-StepResult $stepNumber "run-review-codex" "powershell -ExecutionPolicy 
Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 1 "Codex 리뷰 실
행에는 -AllowReviewCodex가 필요합니다. 추천 명령: $command"
        Stop-Cycle $script:steps "allow_review_codex_required" $false 1
    }

    Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scr
ipts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirty
", "-SaveReview")
    $stepNumber++

    if ($DryRun) {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fal
se $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain --
 package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fi
le scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastComm
itHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Byp
ass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"자동 완료: Codex 구현, build/check, Codex 리뷰 p
ass, 자동 커밋 완료`" -CommitHash <commit-hash>" $false $true 0 "DryRun: task 완료 처리를 실행하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "meta-commit" "direct meta commit: git add scope
d .ai-dev files, git commit -m 'chore(ai-dev): record task completion', git status --short" $false $
true 0 "DryRun: .ai-dev 메타 상태 직접 커밋을 실행하지 않았습니다."
        Stop-Cycle $script:steps "dry_run" $false 0
    }

    try {
        $reviewGate = Get-ReviewGate
    } catch {
        $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false 
$false 1 $_.Exception.Message
        Stop-Cycle $script:steps "review_gate_failed" $false 1
    }

    if ($reviewGate.lastCommandStatus -ne "passed") {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $fals
e $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
        Stop-Cycle $script:steps "review_save_not_passed" $false 1
    }

    if ($reviewGate.decision -ne "pass") {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fal
se $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
        Stop-Cycle $script:steps "review_not_pass" $false 0
    }

    if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_
step 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revie
wGate.nextStep)"
        Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
    }

    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $
false 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
    $stepNumber++

    try {
        if (Test-PackageFileChanged) {
            $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelai
n -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 커
밋하지 않습니다."
            Stop-Cycle $script:steps "package_files_changed" $false 1
        }
    } catch {
        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain --
 package.json package-lock.json" $false $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "package_change_gate_failed" $false 1
    }

    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pac
kage.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
    $stepNumber++

    if (-not $AllowCommit) {
        $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps
1 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
        if ($AllowDirty) {
            $commitCommand = "$commitCommand -AllowDirty"
        }

        if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
            $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
        }

        $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fi
le scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
        Stop-Cycle $script:steps "allow_commit_required" $false 1
    }

    $commitArguments = Get-CommitArguments

    if ($commitArguments.Count -eq 0) {
        $script:steps += New-StepResult $stepNumber "commit" "git status --porcelain" $false $true 1
 "커밋할 구현 변경사항이 없어 complete-task를 실행하지 않습니다."
        Stop-Cycle $script:steps "no_implementation_changes" $false 1
    }

    $commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
    if ($commitArguments.Count -gt 0) {
        $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
    }

    try {
        $preCommitHeadCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName 
"git rev-parse HEAD"
    } catch {
        $script:steps += New-StepResult $stepNumber "commit" "git rev-parse HEAD" $false $false 1 $_
.Exception.Message
        Stop-Cycle $script:steps "pre_commit_head_failed" $false 1
    }

    Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
    $stepNumber++

    try {
        $commitGate = Get-CommitGate $preCommitHeadCommitHash
    } catch {
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastComm
itHash 확인" $false $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
    }

    if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -not
 $commitGate.commitHashChanged -or -not $commitGate.commitHashMatchesHead) {
        $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastComman
d), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCommitHash)
"
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastComm
itHash 확인" $false $true 1 $message
        Stop-Cycle $script:steps "commit_not_confirmed" $false 1
    }

    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHa
sh 확인" $false $false 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
    $stepNumber++

    $resultSummary = "자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료"
    Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File script
s/ai-dev-complete-task.ps1 -ResultSummary `"$resultSummary`" -CommitHash $($commitGate.lastCommitHas
h)" $scriptPaths.completeTask @("-ResultSummary", $resultSummary, "-CommitHash", $commitGate.lastCom
mitHash)
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
`ai-dev-auto-cycle-full.ps1`에는 pass 이후 커밋, `complete-task -CommitHash`, 메타 커밋 흐름이 이미 들어 있습니다. 다만 마지막
 “작업 상태 확인 로그” 단계가 full cycle에 없고, auto-goal 결과에도 별도 완료 확인 단계가 없어 보이므로 관련 상태/완료 스크립트 인터페이스를 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-complete-task.ps1'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-status.ps1'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-commit.ps1'" in D:\ai-apps\planpilot-local
 succeeded in 1612ms:
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
        $resolvedCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "--verify", $commitRevisio
n) -DisplayName "git rev-parse --verify $commitRevision"
    } catch {
        Stop-WithError "CommitHash가 실제 commit으로 확인되지 않았습니다: $Hash`n$($_.Exception.Message)"
    }

    try {
        $headCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-
parse HEAD"
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
        Stop-WithError "CommitHash가 현재 git HEAD와 일치하지 않습니다. resolved=$resolvedCommitHash, HEAD=$head
CommitHash"
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

 succeeded in 1642ms:
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
    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::Ordi
nalIgnoreCase)
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
        return @($pathText -split " -> " | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
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

    if (-not $fullPath.StartsWith($projectRootPrefix, [System.StringComparison]::OrdinalIgnoreCase))
 {
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
    $null = Invoke-GitCapture -Arguments @("rev-parse", "--show-toplevel") -DisplayName "git rev-par
se --show-toplevel"
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
    Stop-WithError "state.lastCommandStatus가 passed가 아닙니다. 검증 결과를 확인하거나 -AllowWithoutPassedCheck를 사용
하세요."
}

if (-not $AllowWithoutPassedReview -and $state.lastReviewDecision -ne "pass") {
    Stop-WithError "state.lastReviewDecision이 pass가 아닙니다. 리뷰 결과를 확인하거나 -AllowWithoutPassedReview를 사용
하세요."
}

try {
    $statusPorcelain = Invoke-GitCapture -Arguments @("status", "--porcelain") -DisplayName "git sta
tus --porcelain"
} catch {
    Stop-WithError $_.Exception.Message
}

$changeLines = @($statusPorcelain -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace(
$_) })

if ($changeLines.Count -eq 0) {
    Write-Host "커밋할 변경사항 없음"
    exit 0
}

$selectedFiles = @()
$targetChangeLines = $changeLines

if ($null -ne $Files -and $Files.Count -gt 0) {
    $requestedFiles = @($Files | ForEach-Object { $_ -split "," } | Where-Object { -not [string]::Is
NullOrWhiteSpace($_) })

    if ($requestedFiles.Count -eq 0) {
        Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
    }

    foreach ($file in $requestedFiles) {
        if ([string]::IsNullOrWhiteSpace($file)) {
            Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
        }

        $normalizedFile = Convert-ToRepoPathspec $file

        try {
            $fileStatus = Invoke-GitCapture -Arguments @("status", "--porcelain", "--", $normalizedF
ile) -DisplayName "git status --porcelain -- $normalizedFile"
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
        $stagedFiles = Invoke-GitCapture -Arguments @("diff", "--cached", "--name-only") -DisplayNam
e "git diff --cached --name-only"
    } catch {
        Stop-WithError $_.Exception.Message
    }

    $stagedFileList = @($stagedFiles -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpa
ce($_) })
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

if ($selectedFiles.Count -gt 0) {
    $targetChangedPaths = @($selectedFiles | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } 
| Select-Object -Unique)
} else {
    $targetChangedPaths = @($targetChangeLines | ForEach-Object { Convert-ToChangedPath $_ } | Where
-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique)
}
$targetAppChangePaths = @($targetChangedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_)
 })
$targetAiDevOperationalPaths = @($targetChangedPaths | Where-Object { Test-IsAiDevOperationalPath $_
 })

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
        $stagedFilesAfterAdd = Invoke-GitCapture -Arguments @("diff", "--cached", "--name-only") -Di
splayName "git diff --cached --name-only"
        $stagedFileListAfterAdd = @($stagedFilesAfterAdd -split "`r?`n" | Where-Object { -not [strin
g]::IsNullOrWhiteSpace($_) })
        $unexpectedStagedFilesAfterAdd = @($stagedFileListAfterAdd | Where-Object { $selectedFiles -
notcontains $_ })

        if ($unexpectedStagedFilesAfterAdd.Count -gt 0) {
            throw "선택 파일 외의 staged 파일이 감지되었습니다: $($unexpectedStagedFilesAfterAdd -join ', ')"
        }
    }

    $commitOutput = & git commit -m $commitMessage 2>&1 | Out-String

    if ($LASTEXITCODE -ne 0) {
        throw "git commit 실행에 실패했습니다. exit code: $LASTEXITCODE`n$commitOutput"
    }

    $commitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-parse HE
AD"
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

 succeeded in 1689ms:
param(
    [switch]$Json
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$testResultRelativePath = ".ai-dev/test-result.md"
$reviewRelativePath = ".ai-dev/review.md"

$queuePath = Join-Path $projectRoot $queueRelativePath
$statePath = Join-Path $projectRoot $stateRelativePath
$testResultPath = Join-Path $projectRoot $testResultRelativePath
$reviewPath = Join-Path $projectRoot $reviewRelativePath

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

function Get-LastLines {
    param(
        [string]$Path,
        [int]$Count = 30
    )

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        return "없음"
    }

    try {
        $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)

        if ($lines.Count -eq 0) {
            return "없음"
        }

        return ($lines | Select-Object -Last $Count) -join "`r`n"
    } catch {
        return "읽기 실패: $($_.Exception.Message)"
    }
}

function Get-ReviewSummary {
    param(
        [string]$Path
    )

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        return [PSCustomObject]@{
            available = $false
            decision = $null
            severity = $null
            nextStep = $null
            summary = "없음"
            fallback = $null
        }
    }

    try {
        $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)
        $decisionLine = $lines | Where-Object { $_ -match '^- Decision:\s*(.+)$' } | Select-Object -
First 1
        $severityLine = $lines | Where-Object { $_ -match '^- Severity:\s*(.+)$' } | Select-Object -
First 1
        $nextStepLine = $lines | Where-Object { $_ -match '^- Next step:\s*(.+)$' } | Select-Object 
-First 1
        $summaryLine = $lines | Where-Object { $_ -match '^- Summary:\s*(.+)$' } | Select-Object -Fi
rst 1

        $decision = if ($decisionLine -match '^- Decision:\s*(.+)$') { $Matches[1].Trim() } else { $
null }
        $severity = if ($severityLine -match '^- Severity:\s*(.+)$') { $Matches[1].Trim() } else { $
null }
        $nextStep = if ($nextStepLine -match '^- Next step:\s*(.+)$') { $Matches[1].Trim() } else { 
$null }
        $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } else { $nul
l }
        $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or (Test-HasVa
lue $nextStep) -or (Test-HasValue $summary)

        return [PSCustomObject]@{
            available = $true
            decision = $decision
            severity = $severity
            nextStep = $nextStep
            summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
            fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object -Last 30) -
join "`r`n") }
        }
    } catch {
        return [PSCustomObject]@{
            available = $true
            decision = $null
            severity = $null
            nextStep = $null
            summary = "읽기 실패: $($_.Exception.Message)"
            fallback = $null
        }
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

$taskCounts = [ordered]@{
    total = $tasks.Count
    pending = @($tasks | Where-Object { $_.status -eq "pending" }).Count
    in_progress = @($tasks | Where-Object { $_.status -eq "in_progress" }).Count
    review_required = @($tasks | Where-Object { $_.status -eq "review_required" }).Count
    done = @($tasks | Where-Object { $_.status -eq "done" }).Count
    failed = @($tasks | Where-Object { $_.status -eq "failed" }).Count
    blocked = @($tasks | Where-Object { $_.status -eq "blocked" }).Count
    skipped = @($tasks | Where-Object { $_.status -eq "skipped" }).Count
}

$gitStatus = "unavailable"
$gitChangedFilesCount = $null
$gitStatusLines = @()

try {
    $null = & git rev-parse --show-toplevel 2>&1

    if ($LASTEXITCODE -eq 0) {
        $gitOutput = & git status --short 2>&1 | Out-String

        if ($LASTEXITCODE -eq 0) {
            $gitStatusLines = @($gitOutput -split "`r?`n" | Where-Object { -not [string]::IsNullOrWh
iteSpace($_) })
            $gitChangedFilesCount = $gitStatusLines.Count
            $gitStatus = "available"
        }
    }
} catch {
    $gitStatus = "unavailable"
}

$testResultSummary = Get-LastLines $testResultPath 30
$reviewSummary = Get-ReviewSummary $reviewPath

$statusObject = [ordered]@{
    goalTitle = if (Test-HasValue $queue.goalTitle) { $queue.goalTitle } else { "없음" }
    goalStatus = if (Test-HasValue $state.goalStatus) { $state.goalStatus } else { "없음" }
    currentTask = [ordered]@{
        id = if ($null -ne $currentTask) { $currentTask.id } elseif (Test-HasValue $currentTaskId) {
 $currentTaskId } else { $null }
        title = if ($null -ne $currentTask) { $currentTask.title } else { "없음" }
        status = if ($null -ne $currentTask) { $currentTask.status } else { "없음" }
        type = if ($null -ne $currentTask) { $currentTask.type } else { "없음" }
        priority = if ($null -ne $currentTask) { $currentTask.priority } else { "없음" }
    }
    taskProgress = "$($taskCounts.done)/$($taskCounts.total)"
    taskCounts = $taskCounts
    lastCommand = if (Test-HasValue $state.lastCommand) { $state.lastCommand } else { "없음" }
    lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { $state.lastCommandStatus } els
e { "없음" }
    lastErrorSummary = if (Test-HasValue $state.lastErrorSummary) { $state.lastErrorSummary } else {
 "없음" }
    lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { $state.lastReviewDecision } 
else { "없음" }
    lastReviewSeverity = if (Test-HasValue $state.lastReviewSeverity) { $state.lastReviewSeverity } 
else { "없음" }
    lastCommitHash = if (Test-HasValue $state.lastCommitHash) { $state.lastCommitHash } else { "없음" 
}
    git = [ordered]@{
        status = $gitStatus
        changedFilesCount = $gitChangedFilesCount
        statusLines = $gitStatusLines
    }
    testResultSummary = $testResultSummary
    reviewSummary = $reviewSummary
}

if ($Json) {
    $statusObject | ConvertTo-Json -Depth 20
    exit 0
}

Write-Host "Goal title: $($statusObject.goalTitle)"
Write-Host "Goal status: $($statusObject.goalStatus)"
Write-Host "Current task id: $($statusObject.currentTask.id)"
Write-Host "Current task title: $($statusObject.currentTask.title)"
Write-Host "Current task status: $($statusObject.currentTask.status)"
Write-Host "Current task type: $($statusObject.currentTask.type)"
Write-Host "Current task priority: $($statusObject.currentTask.priority)"
Write-Host "Task progress: $($statusObject.taskProgress)"
Write-Host "Task counts: pending=$($taskCounts.pending), in_progress=$($taskCounts.in_progress), rev
iew_required=$($taskCounts.review_required), done=$($taskCounts.done), failed=$($taskCounts.failed),
 blocked=$($taskCounts.blocked), skipped=$($taskCounts.skipped), total=$($taskCounts.total)"
Write-Host "Last command: $($statusObject.lastCommand)"
Write-Host "Last command status: $($statusObject.lastCommandStatus)"
Write-Host "Last error: $($statusObject.lastErrorSummary)"
Write-Host "Last review decision: $($statusObject.lastReviewDecision)"
Write-Host "Last review severity: $($statusObject.lastReviewSeverity)"
Write-Host "Last commit hash: $($statusObject.lastCommitHash)"
Write-Host "Git status: $($statusObject.git.status)"
Write-Host "Git changed files count: $($statusObject.git.changedFilesCount)"
Write-Host ""
Write-Host "Test result summary:"
Write-Host $statusObject.testResultSummary
Write-Host ""
Write-Host "Review summary:"
Write-Host "  Decision: $($reviewSummary.decision)"
Write-Host "  Severity: $($reviewSummary.severity)"
Write-Host "  Next step: $($reviewSummary.nextStep)"
Write-Host "  Summary: $($reviewSummary.summary)"

if (Test-HasValue $reviewSummary.fallback) {
    Write-Host $reviewSummary.fallback
}

codex
수정은 `scripts/ai-dev-auto-cycle-full.ps1`에 한정하겠습니다. pass 이후 기존 완료 흐름의 끝에 `ai-dev-status.ps1` 실행 단계를 추
가해 최종 상태가 step 로그에 남도록 하고, DryRun/MaxSteps 계획도 같은 단계 수로 맞추겠습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\scripts\ai-dev-auto-cycle-full.ps1
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 7e86eff0601395640242369fea5e605131ccb25b..0336e3e5028191b7433cd19f91544f19c07be5ba
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -474,6 +474,7 @@
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
         commit = Get-ScriptPath "ai-dev-commit.ps1"
         completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
+        status = Get-ScriptPath "ai-dev-status.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Messa
ge
@@ -493,7 +494,8 @@
     "commit",
     "commit-result-gate",
     "complete-task",
-    "meta-commit"
+    "meta-commit",
+    "final-status"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -600,6 +602,8 @@
         $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy By
pass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"자동 완료: Codex 구현, build/check, Codex 리뷰 
pass, 자동 커밋 완료`" -CommitHash <commit-hash>" $false $true 0 "DryRun: task 완료 처리를 실행하지 않았습니다."
         $stepNumber++
         $script:steps += New-StepResult $stepNumber "meta-commit" "direct meta commit: git add scop
ed .ai-dev files, git commit -m 'chore(ai-dev): record task completion', git status --short" $false 
$true 0 "DryRun: .ai-dev 메타 상태 직접 커밋을 실행하지 않았습니다."
+        $stepNumber++
+        $script:steps += New-StepResult $stepNumber "final-status" "powershell -ExecutionPolicy Byp
ass -File scripts/ai-dev-status.ps1" $false $true 0 "DryRun: 최종 작업 상태 확인을 실행하지 않았습니다."
         Stop-Cycle $script:steps "dry_run" $false 0
     }
 
@@ -700,6 +704,9 @@
     Invoke-DirectMetaCommit $stepNumber
     $stepNumber++
 
+    Invoke-CycleCommand $stepNumber "final-status" "powershell -ExecutionPolicy Bypass -File script
s/ai-dev-status.ps1" $scriptPaths.status @()
+    $stepNumber++
+
     $completedTaskCount++
 
     $stateAfterComplete = Read-JsonFile $statePath $stateRelativePath

diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 7e86eff0601395640242369fea5e605131ccb25b..0336e3e5028191b7433cd19f91544f19c07be5ba
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -474,6 +474,7 @@
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
         commit = Get-ScriptPath "ai-dev-commit.ps1"
         completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
+        status = Get-ScriptPath "ai-dev-status.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Messa
ge
@@ -493,7 +494,8 @@
     "commit",
     "commit-result-gate",
     "complete-task",
-    "meta-commit"
+    "meta-commit",
+    "final-status"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -600,6 +602,8 @@
         $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy By
pass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"자동 완료: Codex 구현, build/check, Codex 리뷰 
pass, 자동 커밋 완료`" -CommitHash <commit-hash>" $false $true 0 "DryRun: task 완료 처리를 실행하지 않았습니다."
         $stepNumber++
         $script:steps += New-StepResult $stepNumber "meta-commit" "direct meta commit: git add scop
ed .ai-dev files, git commit -m 'chore(ai-dev): record task completion', git status --short" $false 
$true 0 "DryRun: .ai-dev 메타 상태 직접 커밋을 실행하지 않았습니다."
+        $stepNumber++
+        $script:steps += New-StepResult $stepNumber "final-status" "powershell -ExecutionPolicy Byp
ass -File scripts/ai-dev-status.ps1" $false $true 0 "DryRun: 최종 작업 상태 확인을 실행하지 않았습니다."
         Stop-Cycle $script:steps "dry_run" $false 0
     }
 
@@ -700,6 +704,9 @@
     Invoke-DirectMetaCommit $stepNumber
     $stepNumber++
 
+    Invoke-CycleCommand $stepNumber "final-status" "powershell -ExecutionPolicy Bypass -File script
s/ai-dev-status.ps1" $scriptPaths.status @()
+    $stepNumber++
+
     $completedTaskCount++
 
     $stateAfterComplete = Read-JsonFile $statePath $stateRelativePath

codex
이제 문법과 삽입 위치를 확인하겠습니다. 실제 build/test/git은 요청되지 않았고 금지되어 있으므로 실행하지 않고, PowerShell 파서로 스크립트 구문만 검증합니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -LiteralPat
h 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-cycle-full.ps1' -Pattern 'final-status|status 
= Get-ScriptPath' -Context 2,2" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '$tokens = $null; $errors 
= $null; [System.Management.Automation.Language.Parser]::ParseFile('"'D:\\ai-apps\\planpilot-local\\
scripts\\ai-dev-auto-cycle-full.ps1', [ref]"'$tokens, [ref]$errors) > $null; if ($errors.Count -gt 0
) { $errors | ForEach-Object { $_.Message } } else { '"'Parse OK' }" in D:\ai-apps\planpilot-local
 succeeded in 1269ms:
Parse OK

 succeeded in 1371ms:

  scripts\ai-dev-auto-cycle-full.ps1:475:        commit = Get-ScriptPath "ai-dev-commit.ps1"
  scripts\ai-dev-auto-cycle-full.ps1:476:        completeTask = Get-ScriptPath "ai-dev-complete-task
.ps1"
> scripts\ai-dev-auto-cycle-full.ps1:477:        status = Get-ScriptPath "ai-dev-status.ps1"
  scripts\ai-dev-auto-cycle-full.ps1:478:    }
  scripts\ai-dev-auto-cycle-full.ps1:479:} catch {
  scripts\ai-dev-auto-cycle-full.ps1:496:    "complete-task",
  scripts\ai-dev-auto-cycle-full.ps1:497:    "meta-commit",
> scripts\ai-dev-auto-cycle-full.ps1:498:    "final-status"
  scripts\ai-dev-auto-cycle-full.ps1:499:)
  scripts\ai-dev-auto-cycle-full.ps1:500:
  scripts\ai-dev-auto-cycle-full.ps1:604:        $script:steps += New-StepResult $stepNumber "meta-c
ommit" "direct meta
 commit: git add scoped .ai-dev files, git commit -m 'chore(ai-dev): record task completion', git st
atus --short" $fals
e $true 0 "DryRun: .ai-dev 메타 상태 직접 커밋을 실행하지 않았습니다."
  scripts\ai-dev-auto-cycle-full.ps1:605:        $stepNumber++
> scripts\ai-dev-auto-cycle-full.ps1:606:        $script:steps += New-StepResult $stepNumber "final-
status" "powershell
 -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1" $false $true 0 "DryRun: 최종 작업 상태 확인을 실행하지 
않았습니다."
  scripts\ai-dev-auto-cycle-full.ps1:607:        Stop-Cycle $script:steps "dry_run" $false 0
  scripts\ai-dev-auto-cycle-full.ps1:608:    }
  scripts\ai-dev-auto-cycle-full.ps1:705:    $stepNumber++
  scripts\ai-dev-auto-cycle-full.ps1:706:
> scripts\ai-dev-auto-cycle-full.ps1:707:    Invoke-CycleCommand $stepNumber "final-status" "powersh
ell -ExecutionPolic
y Bypass -File scripts/ai-dev-status.ps1" $scriptPaths.status @()
  scripts\ai-dev-auto-cycle-full.ps1:708:    $stepNumber++
  scripts\ai-dev-auto-cycle-full.ps1:709:



diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 7e86eff0601395640242369fea5e605131ccb25b..0336e3e5028191b7433cd19f91544f19c07be5ba
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -474,6 +474,7 @@
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
         commit = Get-ScriptPath "ai-dev-commit.ps1"
         completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
+        status = Get-ScriptPath "ai-dev-status.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Messa
ge
@@ -493,7 +494,8 @@
     "commit",
     "commit-result-gate",
     "complete-task",
-    "meta-commit"
+    "meta-commit",
+    "final-status"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -600,6 +602,8 @@
         $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy By
pass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"자동 완료: Codex 구현, build/check, Codex 리뷰 
pass, 자동 커밋 완료`" -CommitHash <commit-hash>" $false $true 0 "DryRun: task 완료 처리를 실행하지 않았습니다."
         $stepNumber++
         $script:steps += New-StepResult $stepNumber "meta-commit" "direct meta commit: git add scop
ed .ai-dev files, git commit -m 'chore(ai-dev): record task completion', git status --short" $false 
$true 0 "DryRun: .ai-dev 메타 상태 직접 커밋을 실행하지 않았습니다."
+        $stepNumber++
+        $script:steps += New-StepResult $stepNumber "final-status" "powershell -ExecutionPolicy Byp
ass -File scripts/ai-dev-status.ps1" $false $true 0 "DryRun: 최종 작업 상태 확인을 실행하지 않았습니다."
         Stop-Cycle $script:steps "dry_run" $false 0
     }
 
@@ -700,6 +704,9 @@
     Invoke-DirectMetaCommit $stepNumber
     $stepNumber++
 
+    Invoke-CycleCommand $stepNumber "final-status" "powershell -ExecutionPolicy Bypass -File script
s/ai-dev-status.ps1" $scriptPaths.status @()
+    $stepNumber++
+
     $completedTaskCount++
 
     $stateAfterComplete = Read-JsonFile $statePath $stateRelativePath

codex
구문 검증은 통과했습니다. 한 번 더 DryRun으로 단계 목록에 `final-status`가 포함되는지 확인하되, 실제 커밋/완료/상태 변경은 실행하지 않습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "powershell -ExecutionPoli
cy Bypass -File 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-cycle-full.ps1' -DryRun -MaxStep
s 14" in D:\ai-apps\planpilot-local
 succeeded in 1797ms:
Step 1: task-start
  Command: MaxTasks=1
  Executed: False
  Skipped: False
  Exit code: 0
  Message: 현재 task 실행 시작: T001 auto-goal pass 이후 완료 흐름 연결
Step 2: make-prompt
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: 하위 스크립트를 실행하지 않았습니다.
Step 3: run-codex
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: 하위 스크립트를 실행하지 않았습니다.
Step 4: check
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: 하위 스크립트를 실행하지 않았습니다.
Step 5: save-diff
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: 하위 스크립트를 실행하지 않았습니다.
Step 6: make-review-prompt
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: 하위 스크립트를 실행하지 않았습니다.
Step 7: run-review-codex
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty 
-SaveReview
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: 하위 스크립트를 실행하지 않았습니다.
Step 8: review-gate
  Command: state.lastReviewDecision 확인
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다.
Step 9: package-change-gate
  Command: git status --porcelain -- package.json package-lock.json
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: package 파일 변경 여부를 확인하지 않았습니다.
Step 10: commit
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: git add/commit을 실행하지 않았습니다.
Step 11: commit-result-gate
  Command: state.lastCommand/lastCommitHash 확인
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다.
Step 12: complete-task
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary 
"자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료" -CommitHash <commit-hash>
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: task 완료 처리를 실행하지 않았습니다.
Step 13: meta-commit
  Command: direct meta commit: git add scoped .ai-dev files, git commit -m 'chore(ai-dev): record ta
sk completion', git status --short
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: .ai-dev 메타 상태 직접 커밋을 실행하지 않았습니다.
Step 14: final-status
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: 최종 작업 상태 확인을 실행하지 않았습니다.
Stopped reason: dry_run
Completed: False
Exit code: 0

diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 7e86eff0601395640242369fea5e605131ccb25b..0336e3e5028191b7433cd19f91544f19c07be5ba
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -474,6 +474,7 @@
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
         commit = Get-ScriptPath "ai-dev-commit.ps1"
         completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
+        status = Get-ScriptPath "ai-dev-status.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Messa
ge
@@ -493,7 +494,8 @@
     "commit",
     "commit-result-gate",
     "complete-task",
-    "meta-commit"
+    "meta-commit",
+    "final-status"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -600,6 +602,8 @@
         $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy By
pass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"자동 완료: Codex 구현, build/check, Codex 리뷰 
pass, 자동 커밋 완료`" -CommitHash <commit-hash>" $false $true 0 "DryRun: task 완료 처리를 실행하지 않았습니다."
         $stepNumber++
         $script:steps += New-StepResult $stepNumber "meta-commit" "direct meta commit: git add scop
ed .ai-dev files, git commit -m 'chore(ai-dev): record task completion', git status --short" $false 
$true 0 "DryRun: .ai-dev 메타 상태 직접 커밋을 실행하지 않았습니다."
+        $stepNumber++
+        $script:steps += New-StepResult $stepNumber "final-status" "powershell -ExecutionPolicy Byp
ass -File scripts/ai-dev-status.ps1" $false $true 0 "DryRun: 최종 작업 상태 확인을 실행하지 않았습니다."
         Stop-Cycle $script:steps "dry_run" $false 0
     }
 
@@ -700,6 +704,9 @@
     Invoke-DirectMetaCommit $stepNumber
     $stepNumber++
 
+    Invoke-CycleCommand $stepNumber "final-status" "powershell -ExecutionPolicy Bypass -File script
s/ai-dev-status.ps1" $scriptPaths.status @()
+    $stepNumber++
+
     $completedTaskCount++
 
     $stateAfterComplete = Read-JsonFile $statePath $stateRelativePath

codex
수정 완료했습니다.

변경 파일:
- [scripts/ai-dev-auto-cycle-full.ps1](D:/ai-apps/planpilot-local/scripts/ai-dev-auto-cycle-full.ps1
:477)

구현 요약:
- `ai-dev-status.ps1`를 full auto-cycle의 필수 스크립트 목록에 추가했습니다.
- 기존 pass 이후 흐름인 `commit -> commit-result-gate -> complete-task -CommitHash -> meta-commit` 뒤에 `fina
l-status` 단계를 추가했습니다.
- DryRun 단계 목록과 `MaxSteps` 계획에도 `final-status`를 반영했습니다.
- 따라서 auto-goal이 `ai-dev-auto-cycle-full.ps1` 경로를 실행하면 완료 흐름 끝에서 최종 작업 상태 확인 결과가 step 로그에 남습니다.

검증:
- PowerShell AST 파서로 스크립트 구문 확인: `Parse OK`
- DryRun 실행 확인: `Step 14: final-status`가 출력되고 exit code `0`
- 실제 `npm run build`, lint, test, git commit은 요청되지 않았고 금지 규칙이 있어 실행하지 않았습니다.

남은 위험:
- 실제 Codex 리뷰 pass 이후 커밋/complete-task/meta-commit/status까지 이어지는 end-to-end 검증은 커밋이 발생하는 실행 경로라 수행하지
 않았습니다.
- 실제 검증은 사용자가 허용한 환경에서 `-AllowCodex -AllowReviewCodex -AllowCommit` 조합으로 확인해야 합니다.

다음 task로 넘어가도 되는지:
- 코드 수준 변경과 DryRun 검증 기준으로는 넘어가도 됩니다. 다만 성공 기준의 “pass 리뷰 결과 기반 실제 자동 실행”은 별도 수동 검증이 남아 있습니다.

`.ai-dev/loop-log.md` 기록용 요약:
```md
- auto-cycle full 경로에서 리뷰 pass 이후 commit, complete-task, meta-commit 뒤에 final-status 단계를 추가했다.
- complete-task에는 기존 commitGate.lastCommitHash 전달 흐름을 유지했다.
- DryRun과 MaxSteps 계획에도 final-status를 반영했고 PowerShell 구문 및 DryRun 단계 출력을 확인했다.
```
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 7e86eff0601395640242369fea5e605131ccb25b..0336e3e5028191b7433cd19f91544f19c07be5ba
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -474,6 +474,7 @@
         runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
         commit = Get-ScriptPath "ai-dev-commit.ps1"
         completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
+        status = Get-ScriptPath "ai-dev-status.ps1"
     }
 } catch {
     $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Messa
ge
@@ -493,7 +494,8 @@
     "commit",
     "commit-result-gate",
     "complete-task",
-    "meta-commit"
+    "meta-commit",
+    "final-status"
 )
 
 if ($plannedSteps.Count -gt $MaxSteps) {
@@ -600,6 +602,8 @@
         $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy By
pass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"자동 완료: Codex 구현, build/check, Codex 리뷰 
pass, 자동 커밋 완료`" -CommitHash <commit-hash>" $false $true 0 "DryRun: task 완료 처리를 실행하지 않았습니다."
         $stepNumber++
         $script:steps += New-StepResult $stepNumber "meta-commit" "direct meta commit: git add scop
ed .ai-dev files, git commit -m 'chore(ai-dev): record task completion', git status --short" $false 
$true 0 "DryRun: .ai-dev 메타 상태 직접 커밋을 실행하지 않았습니다."
+        $stepNumber++
+        $script:steps += New-StepResult $stepNumber "final-status" "powershell -ExecutionPolicy Byp
ass -File scripts/ai-dev-status.ps1" $false $true 0 "DryRun: 최종 작업 상태 확인을 실행하지 않았습니다."
         Stop-Cycle $script:steps "dry_run" $false 0
     }
 
@@ -700,6 +704,9 @@
     Invoke-DirectMetaCommit $stepNumber
     $stepNumber++
 
+    Invoke-CycleCommand $stepNumber "final-status" "powershell -ExecutionPolicy Bypass -File script
s/ai-dev-status.ps1" $scriptPaths.status @()
+    $stepNumber++
+
     $completedTaskCount++
 
     $stateAfterComplete = Read-JsonFile $statePath $stateRelativePath

tokens used
수정 완료했습니다.

변경 파일:
- [scripts/ai-dev-auto-cycle-full.ps1](D:/ai-apps/planpilot-local/scripts/ai-dev-auto-cycle-full.ps1:477)

구현 요약:
- `ai-dev-status.ps1`를 full auto-cycle의 필수 스크립트 목록에 추가했습니다.
- 기존 pass 이후 흐름인 `commit -> commit-result-gate -> complete-task -CommitHash -> meta-commit` 뒤에 `final-status` 단계를 추가했습니다.
- DryRun 단계 목록과 `MaxSteps` 계획에도 `final-status`를 반영했습니다.
- 따라서 auto-goal이 `ai-dev-auto-cycle-full.ps1` 경로를 실행하면 완료 흐름 끝에서 최종 작업 상태 확인 결과가 step 로그에 남습니다.

검증:
- PowerShell AST 파서로 스크립트 구문 확인: `Parse OK`
- DryRun 실행 확인: `Step 14: final-status`가 출력되고 exit code `0`
- 실제 `npm run build`, lint, test, git commit은 요청되지 않았고 금지 규칙이 있어 실행하지 않았습니다.

남은 위험:
- 실제 Codex 리뷰 pass 이후 커밋/complete-task/meta-commit/status까지 이어지는 end-to-end 검증은 커밋이 발생하는 실행 경로라 수행하지 않았습니다.
- 실제 검증은 사용자가 허용한 환경에서 `-AllowCodex -AllowReviewCodex -AllowCommit` 조합으로 확인해야 합니다.

다음 task로 넘어가도 되는지:
- 코드 수준 변경과 DryRun 검증 기준으로는 넘어가도 됩니다. 다만 성공 기준의 “pass 리뷰 결과 기반 실제 자동 실행”은 별도 수동 검증이 남아 있습니다.

`.ai-dev/loop-log.md` 기록용 요약:
```md
- auto-cycle full 경로에서 리뷰 pass 이후 commit, complete-task, meta-commit 뒤에 final-status 단계를 추가했다.
- complete-task에는 기존 commitGate.lastCommitHash 전달 흐름을 유지했다.
- DryRun과 MaxSteps 계획에도 final-status를 반영했고 PowerShell 구문 및 DryRun 단계 출력을 확인했다.
```
71,364

```