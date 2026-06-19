# Codex Implementation Result

## Run

- Started at: 2026-06-14 23:32:37
- Ended at: 2026-06-14 23:34:49
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
session id: 019ec68c-8387-7043-b323-c06322649eef
--------
user
Read and follow the full task prompt at this absolute file path: D:\ai-apps\planpilot-local\.ai-dev\
current-task-prompt.md
codex
요청하신 작업 지시 파일을 먼저 읽고, 그 안의 범위와 제약을 확인한 뒤 필요한 파일만 추가로 살펴보겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\.ai-dev\\current-task-prompt.md'" in D:\ai-apps\planpilot-local
 succeeded in 973ms:
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표

AI Dev Loop auto-goal 완료 직전의 최종 상태 검증을 보강하여, completed 상태로 종료된 뒤에도 .ai-dev 운영 파일 변경이 남지 않도록 한다.

## 배경

현재 ai-dev-auto-goal 실행이 goal completed로 끝난 뒤 .ai-dev/auto-goal-planning-prompt.md 삭제 같은 후처리 변경이 남아 작
업 트리가 변경된 상태가 될 수 있다. 완료 상태의 의미와 실제 저장소 상태가 어긋나므로, auto-cycle-full의 메타 커밋 이후 또는 auto-goal 종료 직전에 최종 
변경 상태를 확인하는 보호 장치가 필요하다.

## 성공 기준

- auto-goal이 completed 상태로 종료되기 직전에 최종 변경 상태를 확인한다.
- 남은 변경이 .ai-dev 운영 파일의 후처리 변경이면 메타 커밋 흐름에 포함되도록 처리한다.
- 메타 커밋에 포함할 수 없는 남은 변경이 있으면 completed로 종료하지 않고 실패로 처리한다.
- completed 상태에서는 후속 실행자가 즉시 확인해도 남은 변경이 없는 상태다.
- 기존 사용자 변경 사항을 되돌리거나 무시하지 않는다.

## 제약사항

- 한 번에 하나의 작은 구현 변경으로 처리한다.
- 기존 AI Dev Loop 흐름과 파일 구조를 우선 따른다.
- 사용자 변경 사항을 되돌리지 않는다.
- 서버 API, 로그인, 클라우드 동기화, DB 구조 변경은 다루지 않는다.
- 광범위한 재작성 없이 종료 검증과 메타 커밋 흐름 주변만 수정한다.

## 범위 제외

- AI Dev Loop 전체 구조 재설계
- 새로운 저장소 관리 정책 도입
- UI 변경
- 앱 런타임 기능 변경
- 데이터베이스 마이그레이션

## 수동 검증

- auto-goal 완료 직전 후처리 변경이 생기는 상황을 재현하거나 시뮬레이션한다.
- completed 종료 후 남은 변경 상태가 없는지 확인한다.
- 남은 변경을 메타 커밋에 포함할 수 없는 경우 completed가 아닌 실패 상태로 종료되는지 확인한다.

## Current Task

- Task ID: T001
- Title: auto-goal 종료 전 최종 변경 상태 검증 보강
- Description: auto-cycle-full의 메타 커밋 이후 또는 auto-goal 종료 직전에 남은 .ai-dev 운영 변경을 확인하고, 처리 가능한 변경은 메타 커
밋 흐름에 포함하며 처리할 수 없는 변경은 완료가 아닌 실패로 종료하도록 보강한다.
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

- .ai-dev/auto-goal 관련 PowerShell 스크립트
- .ai-dev/auto-cycle-full 관련 PowerShell 스크립트

## Verification

- 완료 직전 남은 .ai-dev 운영 변경이 메타 커밋 흐름에 포함되는지 확인한다.
- 처리할 수 없는 남은 변경이 있을 때 completed로 종료하지 않는지 확인한다.
- 기존 사용자 변경 사항을 되돌리지 않는지 확인한다.

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
작업 범위가 `.ai-dev`의 자동 루프 스크립트에 한정되어 있습니다. `src` 밖 수정이 필요하지만, 프롬프트가 지정한 운영 스크립트 보강이므로 해당 범위 안에서만 구조를 확
인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'rg --files .ai-dev' in D:
\ai-apps\planpilot-local
 succeeded in 1159ms:
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
`.ai-dev` 최상위에는 스크립트 파일이 바로 보이지 않아 숨김/하위 폴더 구조까지 확인하겠습니다. 이 단계는 수정 대상 후보를 좁히기 위한 읽기 작업입니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-ChildItem -LiteralPat
h '.ai-dev' -Force" in D:\ai-apps\planpilot-local
 succeeded in 992ms:


    디렉터리: D:\ai-apps\planpilot-local\.ai-dev


Mode                 LastWriteTime         Length Name                                              
                   
----                 -------------         ------ ----                                              
                   
-a----        2026-06-14  오후 11:31           2667 auto-goal-planning-prompt.md                      
                   
-a----        2026-06-07   오후 8:00           1682 backlog.md                                        
                   
-a----        2026-06-14  오후 11:32          11543 codex-result.md                                   
                   
-a----        2026-06-14  오후 11:28          11138 codex-review-result.md                            
                   
-a----        2026-06-14  오후 11:32           4494 current-task-prompt.md                            
                   
-a----        2026-06-14  오후 11:27           2665 diff.md                                           
                   
-a----        2026-06-04  오전 12:01            307 extra-instructions.example.md                     
                   
-a----        2026-06-14  오후 11:32           2037 goal.md                                           
                   
-a----        2026-06-14  오후 11:28          12192 loop-log.md                                       
                   
-a----        2026-06-07  오후 10:10           6979 plan.md                                           
                   
-a----        2026-06-03   오후 4:30           4068 queue.example.json                                
                   
-a----        2026-06-14  오후 11:32           1869 queue.json                                        
                   
-a----        2026-06-09  오후 10:15          45601 README.md                                         
                   
-a----        2026-06-14  오후 11:27           8269 review-prompt.md                                  
                   
-a----        2026-06-14  오후 11:28            954 review-response.json                              
                   
-a----        2026-06-14  오후 11:28           1305 review.md                                         
                   
-a----        2026-06-03   오후 4:30            395 state.example.json                                
                   
-a----        2026-06-14  오후 11:32            487 state.json                                        
                   
-a----        2026-06-14  오후 11:27            971 test-result.md                                    
                   



codex
운영 파일만 있는 디렉터리라서 자동 실행 스크립트가 다른 위치에 있을 가능성이 큽니다. 저장소 전체에서 `auto-goal`과 `auto-cycle-full` 참조를 검색해 실제 
진입점을 찾겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "rg \"auto-goal|auto-cycle
-full\" -n --glob '"'!node_modules/**'"' --glob '"'!dist/**'"' --glob '"'!.git/**'"'" in D:\ai-apps\
planpilot-local
 exited 1 in 1112ms:
2026-06-14T14:33:02.910998Z ERROR codex_core::tools::router: error=Exit code: 1
Wall time: 1.1 seconds
Output:

codex
검색 결과가 없어 루프 구현이 저장소 파일이 아니라 상위/인접 자동화 파일에 있을 수 있습니다. 현재 작업 경로의 최상위 파일과 폴더만 확인해 위치를 좁히겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-ChildItem -LiteralPat
h '.' -Force" in D:\ai-apps\planpilot-local
 succeeded in 990ms:


    디렉터리: D:\ai-apps\planpilot-local


Mode                 LastWriteTime         Length Name                                              
                   
----                 -------------         ------ ----                                              
                   
d-----        2026-06-14  오후 11:31                .ai-dev                                           
                   
d-----        2026-05-24  오후 12:59                .antigravitycli                                   
                   
d-----        2026-05-10   오후 8:10                .clinerules                                       
                   
d--h--        2026-06-14  오후 11:32                .git                                              
                   
d-----        2026-05-24   오후 1:54                automation-logs                                   
                   
d-----        2026-06-14  오후 11:27                dist                                              
                   
d-----        2026-06-03   오후 4:26                docs                                              
                   
d-----        2026-05-10   오후 7:48                memory-bank                                       
                   
d-----        2026-05-05  오후 10:58                node_modules                                      
                   
d-----        2026-05-05  오후 10:47                public                                            
                   
d-----        2026-06-14  오후 11:08                scripts                                           
                   
d-----        2026-06-10  오후 10:42                src                                               
                   
-a----        2026-05-17   오후 5:57            162 .clineignore                                      
                   
-a----        2026-05-10   오후 7:43           2287 .clinerules.backup.md                             
                   
-a----        2026-05-24   오후 1:09            332 .gitignore                                        
                   
-a----        2026-05-21  오후 10:51           6728 AGENTS.md                                         
                   
-a----        2026-05-24   오후 1:54           2336 automation-state.json                             
                   
-a----        2026-05-05  오후 10:41            591 eslint.config.js                                  
                   
-a----        2026-05-05  오후 10:47            367 index.html                                        
                   
-a----        2026-05-05  오후 10:58          96874 package-lock.json                                 
                   
-a----        2026-05-05  오후 10:58            766 package.json                                      
                   
-a----        2026-05-29   오후 2:49          10910 README.md                                         
                   
-a----        2026-05-29   오후 4:59         132878 ROADMAP.md                                        
                   
-a----        2026-05-05  오후 10:41            617 tsconfig.app.json                                 
                   
-a----        2026-05-05  오후 10:41            119 tsconfig.json                                     
                   
-a----        2026-05-05  오후 10:41            591 tsconfig.node.json                                
                   
-a----        2026-05-05  오후 10:41            161 vite.config.ts                                    
                   



codex
`scripts` 폴더가 자동화 진입점일 가능성이 높습니다. 먼저 파일명만 확인하고, 관련 PowerShell 스크립트만 읽겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'rg --files scripts' in D:
\ai-apps\planpilot-local
 succeeded in 1144ms:
scripts\ai-dev-init.ps1
scripts\monitor-and-dev-loop.ps1
scripts\ai-dev-env.ps1
scripts\ai-dev-current-task.ps1
scripts\ai-dev-copy-review-prompt.ps1
scripts\ai-dev-complete-task.ps1
scripts\ai-dev-commit.ps1
scripts\ai-dev-check.ps1
scripts\ai-dev-auto-step.ps1
scripts\ai-dev-auto-goal.ps1
scripts\ai-dev-auto-cycle.ps1
scripts\ai-dev-run-codex.ps1
scripts\ai-dev-auto-cycle-full.ps1
scripts\ai-dev-next.ps1
scripts\ai-dev-manual-cycle.ps1
scripts\ai-dev-make-revise-prompt.ps1
scripts\ai-dev-make-prompt.ps1
scripts\ai-dev-make-review-prompt.ps1
scripts\ai-dev-save-diff.ps1
scripts\ai-dev-run-review-codex.ps1
scripts\ai-dev-save-review.ps1
scripts\ai-dev-status.ps1

codex
관련 후보는 `ai-dev-auto-goal.ps1`, `ai-dev-auto-cycle-full.ps1`, 메타 커밋을 담당할 수 있는 `ai-dev-commit.ps1`입니다.
 이 세 파일을 먼저 비교해 종료 흐름과 커밋 흐름의 경계를 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'scripts\\ai-dev-auto-goal.ps1'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'scripts\\ai-dev-auto-cycle-full.ps1'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'scripts\\ai-dev-commit.ps1'" in D:\ai-apps\planpilot-local
 succeeded in 1592ms:
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

function Get-CurrentGoalStatus {
    $statePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $stateRelativePath))

    try {
        $state = Get-Content -Raw -Encoding UTF8 -LiteralPath $statePath | ConvertFrom-Json
    } catch {
        throw "$stateRelativePath JSON 파싱에 실패했습니다: $($_.Exception.Message)"
    }

    if ($null -eq $state -or -not ($state.PSObject.Properties.Name -contains "goalStatus")) {
        throw "$stateRelativePath 파일에서 goalStatus를 찾을 수 없습니다."
    }

    return [string]$state.goalStatus
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

try {
    $goalStatusAfterFullCycle = Get-CurrentGoalStatus
} catch {
    $script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false
 $false 1 $_.Exception.Message
    Stop-AutoGoal $script:steps "goal_status_verify_failed" $false 1
}

if ($goalStatusAfterFullCycle -ne "completed") {
    $script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false
 $true 1 "auto-cycle-full은 성공 종료했지만 goalStatus가 completed가 아닙니다: $goalStatusAfterFullCycle"
    Stop-AutoGoal $script:steps "auto_cycle_incomplete" $false 1
}

$script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $fa
lse 0 "auto-cycle-full 성공 후 goalStatus completed 확인."

Stop-AutoGoal $script:steps "completed" $true 0


 succeeded in 1616ms:
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

 succeeded in 1667ms:
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
    }
}

function Test-IsAcceptableReviewNextStep {
    param(
        [object]$ReviewGate
    )

    return (-not $ReviewGate.hasNextStep) -or $ReviewGate.normalizedNextStep -eq "complete_task"
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
        status = Get-ScriptPath "ai-dev-status.ps1"
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

    $resumeFromSavedReview = $false

    if (-not $DryRun) {
        try {
            $resumeReviewGate = Get-ReviewGate
        } catch {
            $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 
확인" $false $false 1 $_.Exception.Message
            Stop-Cycle $script:steps "resume_review_gate_failed" $false 1
        }

        if (Test-IsSavedReviewPassReady $resumeReviewGate) {
            $resumeFromSavedReview = $true
            $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 
재확인" $false $false 0 "이미 저장된 리뷰 pass와 허용 가능한 next_step 상태를 확인했습니다. 구현/리뷰 재실행 없이 commit/complete/meta
-commit으로 계속 진행합니다."
            $stepNumber++
        } elseif ($resumeReviewGate.lastCommand -eq "save-review" -and $resumeReviewGate.lastCommand
Status -eq "passed") {
            $message = "save-review 이후 계속 진행할 수 없습니다. review.decision=$($resumeReviewGate.decision),
 state.lastReviewDecision=$($resumeReviewGate.stateDecision), next_step=$($resumeReviewGate.nextStep
)"
            $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 
재확인" $false $true 1 $message
            Stop-Cycle $script:steps "saved_review_not_ready_to_complete" $false 1
        }
    }

    if (-not $resumeFromSavedReview) {
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
ass -File scripts/ai-dev-run-codex.ps1" $false $true 1 "Codex 구현 실행에는 -AllowCodex가 필요합니다. 추천 명령: $co
mmand"
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
icy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 1 "Codex 
리뷰 실행에는 -AllowReviewCodex가 필요합니다. 추천 명령: $command"
            Stop-Cycle $script:steps "allow_review_codex_required" $false 1
        }

        Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File
 scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowD
irty", "-SaveReview")
        $stepNumber++
    }

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
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "final-status" "powershell -ExecutionPolicy Bypa
ss -File scripts/ai-dev-status.ps1" $false $true 0 "DryRun: 최종 작업 상태 확인을 실행하지 않았습니다."
        Stop-Cycle $script:steps "dry_run" $false 0
    }

    try {
        $reviewGate = Get-ReviewGate
    } catch {
        $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false 
$false 1 $_.Exception.Message
        Stop-Cycle $script:steps "review_gate_failed" $false 1
    }

    if ($reviewGate.lastCommand -ne "save-review" -or $reviewGate.lastCommandStatus -ne "passed") {
        $message = "최신 state가 save-review passed가 아니므로 자동 커밋하지 않습니다: lastCommand=$($reviewGate.lastC
ommand), lastCommandStatus=$($reviewGate.lastCommandStatus)"
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommand/state.lastComma
ndStatus 확인" $false $true 1 $message
        Stop-Cycle $script:steps "review_save_not_passed" $false 1
    }

    if ($reviewGate.decision -ne "pass") {
        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath decis
ion 확인" $false $true 1 "리뷰 response decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewG
ate.decision)"
        Stop-Cycle $script:steps "review_not_pass" $false 1
    }

    if ($reviewGate.stateDecision -ne "pass") {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fal
se $true 1 "state.lastReviewDecision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.stat
eDecision)"
        Stop-Cycle $script:steps "state_review_not_pass" $false 1
    }

    if (-not (Test-IsAcceptableReviewNextStep $reviewGate)) {
        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_
step 확인" $false $true 1 "리뷰 next_step이 존재하지만 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: 원본
='$($reviewGate.nextStep)', 정규화='$($reviewGate.normalizedNextStep)'"
        Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 1
    }

    $script:steps += New-StepResult $stepNumber "review-gate" "최신 state 및 $reviewResponseRelativePat
h 재확인" $false $false 0 "리뷰 pass 및 허용 가능한 next_step 상태 수락: 존재=$($reviewGate.hasNextStep), 원본='$($revi
ewGate.nextStep)', 정규화='$($reviewGate.normalizedNextStep)'. commit/commit-result-gate/complete-task/
meta-commit으로 계속 진행합니다."
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

    Invoke-CycleCommand $stepNumber "final-status" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-status.ps1" $scriptPaths.status @()
    $stepNumber++

    $completedTaskCount++

    $stateAfterComplete = Read-JsonFile $statePath $stateRelativePath

    if ($stateAfterComplete.goalStatus -eq "completed") {
        Stop-Cycle $script:steps "goal_completed" $true 0
    }
}

Stop-Cycle $script:steps "max_tasks_reached" $true 0

codex
핵심 원인은 `ai-dev-auto-goal.ps1`이 `auto-cycle-full`의 메타 커밋이 끝난 뒤 `Stop-AutoGoal`에서 임시 산출물을 삭제한다는 점입니다. 
그래서 completed 직전에 삭제 변경이 새로 생길 수 있으므로, 완료 경로에서만 삭제를 먼저 수행한 뒤 남은 변경을 검사하고 필요 시 `.ai-dev` 메타 커밋으로 닫는 방
식으로 작게 보강하겠습니다.
codex
수정은 `scripts/ai-dev-auto-goal.ps1` 한 파일에만 적용하겠습니다. 완료 경로에서 `Clear-AutoGoalTempArtifacts`를 선행 실행하고, g
it 상태가 `.ai-dev` 운영 변경만 남은 경우 `-AllowCommit`일 때 별도 메타 커밋으로 포함시키며, 그 외 변경은 실패로 종료하도록 하겠습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\scripts\ai-dev-auto-goal.ps1
diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 85e9175fc4b61e6e37e5cfa283569fd39fc801ba..de9a02743bf0a4eb9d93d244b07e74620cdee06a
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -24,9 +24,10 @@
 $goalRelativePath = ".ai-dev/goal.md"
 $queueRelativePath = ".ai-dev/queue.json"
 $stateRelativePath = ".ai-dev/state.json"
-$promptRelativePath = ".ai-dev/current-task-prompt.md"
-$planningPromptRelativePath = ".ai-dev/auto-goal-planning-prompt.md"
-$legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"
+$promptRelativePath = ".ai-dev/current-task-prompt.md"
+$planningPromptRelativePath = ".ai-dev/auto-goal-planning-prompt.md"
+$legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"
+$aiDevOperationalRoot = ".ai-dev/"
 
 function Resolve-RepoPath {
     param([string]$Path)
@@ -203,16 +204,109 @@
     return $normalized.Substring(0, 500)
 }
 
-function Get-GitStatusLines {
-    $statusOutput = & git status --short 2>&1
-
-    if ($LASTEXITCODE -ne 0) {
-        $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 
1 "git status failed: $($statusOutput -join "`n")"
+function Get-GitStatusLines {
+    $statusOutput = & git status --short 2>&1
+
+    if ($LASTEXITCODE -ne 0) {
+        $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 
1 "git status failed: $($statusOutput -join "`n")"
         Stop-AutoGoal $script:steps "git_status_failed" $false 1
     }
-
-    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
-}
+
+    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
+}
+
+function Convert-ToChangedPath {
+    param([string]$ChangeLine)
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
+    param([string]$RelativePath)
+
+    $normalizedRelativePath = $RelativePath.Replace('\', '/')
+    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::Ord
inalIgnoreCase)
+}
+
+function Invoke-FinalAutoGoalChangeGate {
+    param(
+        [int]$StepNumber
+    )
+
+    Clear-AutoGoalTempArtifacts
+
+    $statusLines = @(Get-GitStatusLines)
+    $command = "cleanup auto-goal temp artifacts, git status --short"
+
+    if ($statusLines.Count -eq 0) {
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $false $false 0 "a
uto-goal 최종 정리 후 worktree clean."
+        return
+    }
+
+    $changedPaths = @(
+        $statusLines |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            Where-Object { Test-HasValue $_ } |
+            Select-Object -Unique
+    )
+    $nonAiDevPaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
+    $aiDevPaths = @($changedPaths | Where-Object { Test-IsAiDevOperationalPath $_ })
+
+    if ($nonAiDevPaths.Count -gt 0) {
+        $message = "auto-goal 완료 직전 .ai-dev 밖 변경이 남아 completed로 종료하지 않습니다.`n$($statusLines -join "`
n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $false $true 1 $me
ssage
+        Stop-AutoGoal $script:steps "final_non_ai_dev_changes" $false 1
+    }
+
+    if (-not $AllowCommit) {
+        $message = "auto-goal 완료 직전 .ai-dev 운영 변경이 남았지만 -AllowCommit이 없어 메타 커밋에 포함할 수 없습니다.`n$($sta
tusLines -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $false $true 1 $me
ssage
+        Stop-AutoGoal $script:steps "final_ai_dev_changes_require_commit" $false 1
+    }
+
+    $addOutput = & git add -- $aiDevPaths 2>&1 | Out-String
+    $addExitCode = $LASTEXITCODE
+
+    if ($addExitCode -ne 0) {
+        $message = "auto-goal 최종 .ai-dev 메타 변경 git add 실패. exit code: $addExitCode`n$addOutput"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-dev 
files>" $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_meta_add_failed" $false 1
+    }
+
+    $commitOutput = & git commit -m "chore(ai-dev): finalize auto-goal state" -- $aiDevPaths 2>&1 |
 Out-String
+    $commitExitCode = $LASTEXITCODE
+
+    if ($commitExitCode -ne 0) {
+        $message = "auto-goal 최종 .ai-dev 메타 커밋 실패. exit code: $commitExitCode`n$commitOutput"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m 'chore(ai-de
v): finalize auto-goal state' -- <final .ai-dev files>" $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_meta_commit_failed" $false 1
+    }
+
+    $remainingStatus = @(Get-GitStatusLines)
+
+    if ($remainingStatus.Count -gt 0) {
+        $message = "auto-goal 최종 메타 커밋 이후에도 변경 파일이 남아 completed로 종료하지 않습니다.`n$($remainingStatus -jo
in "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git status --short" $true 
$false 1 $message
+        Stop-AutoGoal $script:steps "final_worktree_dirty" $false 1
+    }
+
+    $message = ($commitOutput.Trim(), "worktree clean") -join "`n"
+    $script:steps += New-StepResult $StepNumber "final-change-gate" "git add/commit final .ai-dev o
perational changes, git status --short" $true $false 0 $message
+}
 
 function Get-JsonObjectCandidates {
     param([string]$RawInput)
@@ -913,7 +1007,9 @@
     Stop-AutoGoal $script:steps "auto_cycle_incomplete" $false 1
 }
 
-$script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $f
alse 0 "auto-cycle-full 성공 후 goalStatus completed 확인."
-
-Stop-AutoGoal $script:steps "completed" $true 0
+$script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $f
alse 0 "auto-cycle-full 성공 후 goalStatus completed 확인."
+
+Invoke-FinalAutoGoalChangeGate 9
+
+Stop-AutoGoal $script:steps "completed" $true 0
 

diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 85e9175fc4b61e6e37e5cfa283569fd39fc801ba..de9a02743bf0a4eb9d93d244b07e74620cdee06a
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -24,9 +24,10 @@
 $goalRelativePath = ".ai-dev/goal.md"
 $queueRelativePath = ".ai-dev/queue.json"
 $stateRelativePath = ".ai-dev/state.json"
-$promptRelativePath = ".ai-dev/current-task-prompt.md"
-$planningPromptRelativePath = ".ai-dev/auto-goal-planning-prompt.md"
-$legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"
+$promptRelativePath = ".ai-dev/current-task-prompt.md"
+$planningPromptRelativePath = ".ai-dev/auto-goal-planning-prompt.md"
+$legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"
+$aiDevOperationalRoot = ".ai-dev/"
 
 function Resolve-RepoPath {
     param([string]$Path)
@@ -203,16 +204,109 @@
     return $normalized.Substring(0, 500)
 }
 
-function Get-GitStatusLines {
-    $statusOutput = & git status --short 2>&1
-
-    if ($LASTEXITCODE -ne 0) {
-        $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 
1 "git status failed: $($statusOutput -join "`n")"
+function Get-GitStatusLines {
+    $statusOutput = & git status --short 2>&1
+
+    if ($LASTEXITCODE -ne 0) {
+        $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 
1 "git status failed: $($statusOutput -join "`n")"
         Stop-AutoGoal $script:steps "git_status_failed" $false 1
     }
-
-    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
-}
+
+    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
+}
+
+function Convert-ToChangedPath {
+    param([string]$ChangeLine)
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
+    param([string]$RelativePath)
+
+    $normalizedRelativePath = $RelativePath.Replace('\', '/')
+    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::Ord
inalIgnoreCase)
+}
+
+function Invoke-FinalAutoGoalChangeGate {
+    param(
+        [int]$StepNumber
+    )
+
+    Clear-AutoGoalTempArtifacts
+
+    $statusLines = @(Get-GitStatusLines)
+    $command = "cleanup auto-goal temp artifacts, git status --short"
+
+    if ($statusLines.Count -eq 0) {
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $false $false 0 "a
uto-goal 최종 정리 후 worktree clean."
+        return
+    }
+
+    $changedPaths = @(
+        $statusLines |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            Where-Object { Test-HasValue $_ } |
+            Select-Object -Unique
+    )
+    $nonAiDevPaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
+    $aiDevPaths = @($changedPaths | Where-Object { Test-IsAiDevOperationalPath $_ })
+
+    if ($nonAiDevPaths.Count -gt 0) {
+        $message = "auto-goal 완료 직전 .ai-dev 밖 변경이 남아 completed로 종료하지 않습니다.`n$($statusLines -join "`
n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $false $true 1 $me
ssage
+        Stop-AutoGoal $script:steps "final_non_ai_dev_changes" $false 1
+    }
+
+    if (-not $AllowCommit) {
+        $message = "auto-goal 완료 직전 .ai-dev 운영 변경이 남았지만 -AllowCommit이 없어 메타 커밋에 포함할 수 없습니다.`n$($sta
tusLines -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $false $true 1 $me
ssage
+        Stop-AutoGoal $script:steps "final_ai_dev_changes_require_commit" $false 1
+    }
+
+    $addOutput = & git add -- $aiDevPaths 2>&1 | Out-String
+    $addExitCode = $LASTEXITCODE
+
+    if ($addExitCode -ne 0) {
+        $message = "auto-goal 최종 .ai-dev 메타 변경 git add 실패. exit code: $addExitCode`n$addOutput"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-dev 
files>" $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_meta_add_failed" $false 1
+    }
+
+    $commitOutput = & git commit -m "chore(ai-dev): finalize auto-goal state" -- $aiDevPaths 2>&1 |
 Out-String
+    $commitExitCode = $LASTEXITCODE
+
+    if ($commitExitCode -ne 0) {
+        $message = "auto-goal 최종 .ai-dev 메타 커밋 실패. exit code: $commitExitCode`n$commitOutput"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m 'chore(ai-de
v): finalize auto-goal state' -- <final .ai-dev files>" $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_meta_commit_failed" $false 1
+    }
+
+    $remainingStatus = @(Get-GitStatusLines)
+
+    if ($remainingStatus.Count -gt 0) {
+        $message = "auto-goal 최종 메타 커밋 이후에도 변경 파일이 남아 completed로 종료하지 않습니다.`n$($remainingStatus -jo
in "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git status --short" $true 
$false 1 $message
+        Stop-AutoGoal $script:steps "final_worktree_dirty" $false 1
+    }
+
+    $message = ($commitOutput.Trim(), "worktree clean") -join "`n"
+    $script:steps += New-StepResult $StepNumber "final-change-gate" "git add/commit final .ai-dev o
perational changes, git status --short" $true $false 0 $message
+}
 
 function Get-JsonObjectCandidates {
     param([string]$RawInput)
@@ -913,7 +1007,9 @@
     Stop-AutoGoal $script:steps "auto_cycle_incomplete" $false 1
 }
 
-$script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $f
alse 0 "auto-cycle-full 성공 후 goalStatus completed 확인."
-
-Stop-AutoGoal $script:steps "completed" $true 0
+$script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $f
alse 0 "auto-cycle-full 성공 후 goalStatus completed 확인."
+
+Invoke-FinalAutoGoalChangeGate 9
+
+Stop-AutoGoal $script:steps "completed" $true 0
 

codex
수정은 완료 경로 뒤쪽에만 들어갔습니다. 이제 실제 git 상태를 건드리지 않는 PowerShell 구문 파싱으로 스크립트 문법을 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '$errors = $null; [System.
Management.Automation.PSParser]::Tokenize((Get-Content -Raw -LiteralPath '"'scripts\\ai-dev-auto-goa
l.ps1'), [ref]"'$errors) | Out-Null; if ($errors.Count -gt 0) { $errors | Format-List *; exit 1 } el
se { '"'PowerShell parse OK' }" in D:\ai-apps\planpilot-local
 succeeded in 991ms:
PowerShell parse OK

diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 85e9175fc4b61e6e37e5cfa283569fd39fc801ba..de9a02743bf0a4eb9d93d244b07e74620cdee06a
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -24,9 +24,10 @@
 $goalRelativePath = ".ai-dev/goal.md"
 $queueRelativePath = ".ai-dev/queue.json"
 $stateRelativePath = ".ai-dev/state.json"
-$promptRelativePath = ".ai-dev/current-task-prompt.md"
-$planningPromptRelativePath = ".ai-dev/auto-goal-planning-prompt.md"
-$legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"
+$promptRelativePath = ".ai-dev/current-task-prompt.md"
+$planningPromptRelativePath = ".ai-dev/auto-goal-planning-prompt.md"
+$legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"
+$aiDevOperationalRoot = ".ai-dev/"
 
 function Resolve-RepoPath {
     param([string]$Path)
@@ -203,16 +204,109 @@
     return $normalized.Substring(0, 500)
 }
 
-function Get-GitStatusLines {
-    $statusOutput = & git status --short 2>&1
-
-    if ($LASTEXITCODE -ne 0) {
-        $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 
1 "git status failed: $($statusOutput -join "`n")"
+function Get-GitStatusLines {
+    $statusOutput = & git status --short 2>&1
+
+    if ($LASTEXITCODE -ne 0) {
+        $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 
1 "git status failed: $($statusOutput -join "`n")"
         Stop-AutoGoal $script:steps "git_status_failed" $false 1
     }
-
-    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
-}
+
+    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
+}
+
+function Convert-ToChangedPath {
+    param([string]$ChangeLine)
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
+    param([string]$RelativePath)
+
+    $normalizedRelativePath = $RelativePath.Replace('\', '/')
+    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::Ord
inalIgnoreCase)
+}
+
+function Invoke-FinalAutoGoalChangeGate {
+    param(
+        [int]$StepNumber
+    )
+
+    Clear-AutoGoalTempArtifacts
+
+    $statusLines = @(Get-GitStatusLines)
+    $command = "cleanup auto-goal temp artifacts, git status --short"
+
+    if ($statusLines.Count -eq 0) {
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $false $false 0 "a
uto-goal 최종 정리 후 worktree clean."
+        return
+    }
+
+    $changedPaths = @(
+        $statusLines |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            Where-Object { Test-HasValue $_ } |
+            Select-Object -Unique
+    )
+    $nonAiDevPaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
+    $aiDevPaths = @($changedPaths | Where-Object { Test-IsAiDevOperationalPath $_ })
+
+    if ($nonAiDevPaths.Count -gt 0) {
+        $message = "auto-goal 완료 직전 .ai-dev 밖 변경이 남아 completed로 종료하지 않습니다.`n$($statusLines -join "`
n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $false $true 1 $me
ssage
+        Stop-AutoGoal $script:steps "final_non_ai_dev_changes" $false 1
+    }
+
+    if (-not $AllowCommit) {
+        $message = "auto-goal 완료 직전 .ai-dev 운영 변경이 남았지만 -AllowCommit이 없어 메타 커밋에 포함할 수 없습니다.`n$($sta
tusLines -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $false $true 1 $me
ssage
+        Stop-AutoGoal $script:steps "final_ai_dev_changes_require_commit" $false 1
+    }
+
+    $addOutput = & git add -- $aiDevPaths 2>&1 | Out-String
+    $addExitCode = $LASTEXITCODE
+
+    if ($addExitCode -ne 0) {
+        $message = "auto-goal 최종 .ai-dev 메타 변경 git add 실패. exit code: $addExitCode`n$addOutput"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-dev 
files>" $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_meta_add_failed" $false 1
+    }
+
+    $commitOutput = & git commit -m "chore(ai-dev): finalize auto-goal state" -- $aiDevPaths 2>&1 |
 Out-String
+    $commitExitCode = $LASTEXITCODE
+
+    if ($commitExitCode -ne 0) {
+        $message = "auto-goal 최종 .ai-dev 메타 커밋 실패. exit code: $commitExitCode`n$commitOutput"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m 'chore(ai-de
v): finalize auto-goal state' -- <final .ai-dev files>" $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_meta_commit_failed" $false 1
+    }
+
+    $remainingStatus = @(Get-GitStatusLines)
+
+    if ($remainingStatus.Count -gt 0) {
+        $message = "auto-goal 최종 메타 커밋 이후에도 변경 파일이 남아 completed로 종료하지 않습니다.`n$($remainingStatus -jo
in "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git status --short" $true 
$false 1 $message
+        Stop-AutoGoal $script:steps "final_worktree_dirty" $false 1
+    }
+
+    $message = ($commitOutput.Trim(), "worktree clean") -join "`n"
+    $script:steps += New-StepResult $StepNumber "final-change-gate" "git add/commit final .ai-dev o
perational changes, git status --short" $true $false 0 $message
+}
 
 function Get-JsonObjectCandidates {
     param([string]$RawInput)
@@ -913,7 +1007,9 @@
     Stop-AutoGoal $script:steps "auto_cycle_incomplete" $false 1
 }
 
-$script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $f
alse 0 "auto-cycle-full 성공 후 goalStatus completed 확인."
-
-Stop-AutoGoal $script:steps "completed" $true 0
+$script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $f
alse 0 "auto-cycle-full 성공 후 goalStatus completed 확인."
+
+Invoke-FinalAutoGoalChangeGate 9
+
+Stop-AutoGoal $script:steps "completed" $true 0
 

codex
문법 검증은 통과했습니다. 최종 답변에서 정확한 위치를 짚을 수 있도록 변경된 함수와 완료 호출부의 줄 번호만 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -LiteralPat
h 'scripts\\ai-dev-auto-goal.ps1' -Pattern 'aiDevOperationalRoot|function Convert-ToChangedPath|func
tion Test-IsAiDevOperationalPath'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -LiteralPat
h 'scripts\\ai-dev-auto-goal.ps1' -Pattern 'function Invoke-FinalAutoGoalChangeGate|final-change-gat
e|Stop-AutoGoal \\"'$script:steps "completed"'"'" in D:\ai-apps\planpilot-local
 succeeded in 1336ms:

scripts\ai-dev-auto-goal.ps1:30:$aiDevOperationalRoot = ".ai-dev/"
scripts\ai-dev-auto-goal.ps1:218:function Convert-ToChangedPath {
scripts\ai-dev-auto-goal.ps1:238:function Test-IsAiDevOperationalPath {
scripts\ai-dev-auto-goal.ps1:242:    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot
, [System.StringCom
parison]::OrdinalIgnoreCase)



 succeeded in 1336ms:

scripts\ai-dev-auto-goal.ps1:245:function Invoke-FinalAutoGoalChangeGate {
scripts\ai-dev-auto-goal.ps1:256:        $script:steps += New-StepResult $StepNumber "final-change-g
ate" $command $fals
e $false 0 "auto-goal 최종 정리 후 worktree clean."
scripts\ai-dev-auto-goal.ps1:271:        $script:steps += New-StepResult $StepNumber "final-change-g
ate" $command $fals
e $true 1 $message
scripts\ai-dev-auto-goal.ps1:277:        $script:steps += New-StepResult $StepNumber "final-change-g
ate" $command $fals
e $true 1 $message
scripts\ai-dev-auto-goal.ps1:286:        $script:steps += New-StepResult $StepNumber "final-change-g
ate" "git add -- <f
inal .ai-dev files>" $true $false 1 $message
scripts\ai-dev-auto-goal.ps1:295:        $script:steps += New-StepResult $StepNumber "final-change-g
ate" "git commit -m
 'chore(ai-dev): finalize auto-goal state' -- <final .ai-dev files>" $true $false 1 $message
scripts\ai-dev-auto-goal.ps1:303:        $script:steps += New-StepResult $StepNumber "final-change-g
ate" "git status --
short" $true $false 1 $message
scripts\ai-dev-auto-goal.ps1:308:    $script:steps += New-StepResult $StepNumber "final-change-gate"
 "git add/commit fi
nal .ai-dev operational changes, git status --short" $true $false 0 $message
scripts\ai-dev-auto-goal.ps1:1014:Stop-AutoGoal $script:steps "completed" $true 0



diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 85e9175fc4b61e6e37e5cfa283569fd39fc801ba..de9a02743bf0a4eb9d93d244b07e74620cdee06a
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -24,9 +24,10 @@
 $goalRelativePath = ".ai-dev/goal.md"
 $queueRelativePath = ".ai-dev/queue.json"
 $stateRelativePath = ".ai-dev/state.json"
-$promptRelativePath = ".ai-dev/current-task-prompt.md"
-$planningPromptRelativePath = ".ai-dev/auto-goal-planning-prompt.md"
-$legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"
+$promptRelativePath = ".ai-dev/current-task-prompt.md"
+$planningPromptRelativePath = ".ai-dev/auto-goal-planning-prompt.md"
+$legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"
+$aiDevOperationalRoot = ".ai-dev/"
 
 function Resolve-RepoPath {
     param([string]$Path)
@@ -203,16 +204,109 @@
     return $normalized.Substring(0, 500)
 }
 
-function Get-GitStatusLines {
-    $statusOutput = & git status --short 2>&1
-
-    if ($LASTEXITCODE -ne 0) {
-        $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 
1 "git status failed: $($statusOutput -join "`n")"
+function Get-GitStatusLines {
+    $statusOutput = & git status --short 2>&1
+
+    if ($LASTEXITCODE -ne 0) {
+        $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 
1 "git status failed: $($statusOutput -join "`n")"
         Stop-AutoGoal $script:steps "git_status_failed" $false 1
     }
-
-    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
-}
+
+    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
+}
+
+function Convert-ToChangedPath {
+    param([string]$ChangeLine)
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
+    param([string]$RelativePath)
+
+    $normalizedRelativePath = $RelativePath.Replace('\', '/')
+    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::Ord
inalIgnoreCase)
+}
+
+function Invoke-FinalAutoGoalChangeGate {
+    param(
+        [int]$StepNumber
+    )
+
+    Clear-AutoGoalTempArtifacts
+
+    $statusLines = @(Get-GitStatusLines)
+    $command = "cleanup auto-goal temp artifacts, git status --short"
+
+    if ($statusLines.Count -eq 0) {
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $false $false 0 "a
uto-goal 최종 정리 후 worktree clean."
+        return
+    }
+
+    $changedPaths = @(
+        $statusLines |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            Where-Object { Test-HasValue $_ } |
+            Select-Object -Unique
+    )
+    $nonAiDevPaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
+    $aiDevPaths = @($changedPaths | Where-Object { Test-IsAiDevOperationalPath $_ })
+
+    if ($nonAiDevPaths.Count -gt 0) {
+        $message = "auto-goal 완료 직전 .ai-dev 밖 변경이 남아 completed로 종료하지 않습니다.`n$($statusLines -join "`
n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $false $true 1 $me
ssage
+        Stop-AutoGoal $script:steps "final_non_ai_dev_changes" $false 1
+    }
+
+    if (-not $AllowCommit) {
+        $message = "auto-goal 완료 직전 .ai-dev 운영 변경이 남았지만 -AllowCommit이 없어 메타 커밋에 포함할 수 없습니다.`n$($sta
tusLines -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $false $true 1 $me
ssage
+        Stop-AutoGoal $script:steps "final_ai_dev_changes_require_commit" $false 1
+    }
+
+    $addOutput = & git add -- $aiDevPaths 2>&1 | Out-String
+    $addExitCode = $LASTEXITCODE
+
+    if ($addExitCode -ne 0) {
+        $message = "auto-goal 최종 .ai-dev 메타 변경 git add 실패. exit code: $addExitCode`n$addOutput"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-dev 
files>" $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_meta_add_failed" $false 1
+    }
+
+    $commitOutput = & git commit -m "chore(ai-dev): finalize auto-goal state" -- $aiDevPaths 2>&1 |
 Out-String
+    $commitExitCode = $LASTEXITCODE
+
+    if ($commitExitCode -ne 0) {
+        $message = "auto-goal 최종 .ai-dev 메타 커밋 실패. exit code: $commitExitCode`n$commitOutput"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m 'chore(ai-de
v): finalize auto-goal state' -- <final .ai-dev files>" $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_meta_commit_failed" $false 1
+    }
+
+    $remainingStatus = @(Get-GitStatusLines)
+
+    if ($remainingStatus.Count -gt 0) {
+        $message = "auto-goal 최종 메타 커밋 이후에도 변경 파일이 남아 completed로 종료하지 않습니다.`n$($remainingStatus -jo
in "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git status --short" $true 
$false 1 $message
+        Stop-AutoGoal $script:steps "final_worktree_dirty" $false 1
+    }
+
+    $message = ($commitOutput.Trim(), "worktree clean") -join "`n"
+    $script:steps += New-StepResult $StepNumber "final-change-gate" "git add/commit final .ai-dev o
perational changes, git status --short" $true $false 0 $message
+}
 
 function Get-JsonObjectCandidates {
     param([string]$RawInput)
@@ -913,7 +1007,9 @@
     Stop-AutoGoal $script:steps "auto_cycle_incomplete" $false 1
 }
 
-$script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $f
alse 0 "auto-cycle-full 성공 후 goalStatus completed 확인."
-
-Stop-AutoGoal $script:steps "completed" $true 0
+$script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $f
alse 0 "auto-cycle-full 성공 후 goalStatus completed 확인."
+
+Invoke-FinalAutoGoalChangeGate 9
+
+Stop-AutoGoal $script:steps "completed" $true 0
 

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -LiteralPat
h 'scripts\\ai-dev-auto-goal.ps1' -Pattern 'Invoke-FinalAutoGoalChangeGate'" in D:\ai-apps\planpilot
-local
 succeeded in 965ms:

scripts\ai-dev-auto-goal.ps1:245:function Invoke-FinalAutoGoalChangeGate {
scripts\ai-dev-auto-goal.ps1:1012:Invoke-FinalAutoGoalChangeGate 9



diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 85e9175fc4b61e6e37e5cfa283569fd39fc801ba..de9a02743bf0a4eb9d93d244b07e74620cdee06a
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -24,9 +24,10 @@
 $goalRelativePath = ".ai-dev/goal.md"
 $queueRelativePath = ".ai-dev/queue.json"
 $stateRelativePath = ".ai-dev/state.json"
-$promptRelativePath = ".ai-dev/current-task-prompt.md"
-$planningPromptRelativePath = ".ai-dev/auto-goal-planning-prompt.md"
-$legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"
+$promptRelativePath = ".ai-dev/current-task-prompt.md"
+$planningPromptRelativePath = ".ai-dev/auto-goal-planning-prompt.md"
+$legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"
+$aiDevOperationalRoot = ".ai-dev/"
 
 function Resolve-RepoPath {
     param([string]$Path)
@@ -203,16 +204,109 @@
     return $normalized.Substring(0, 500)
 }
 
-function Get-GitStatusLines {
-    $statusOutput = & git status --short 2>&1
-
-    if ($LASTEXITCODE -ne 0) {
-        $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 
1 "git status failed: $($statusOutput -join "`n")"
+function Get-GitStatusLines {
+    $statusOutput = & git status --short 2>&1
+
+    if ($LASTEXITCODE -ne 0) {
+        $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 
1 "git status failed: $($statusOutput -join "`n")"
         Stop-AutoGoal $script:steps "git_status_failed" $false 1
     }
-
-    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
-}
+
+    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
+}
+
+function Convert-ToChangedPath {
+    param([string]$ChangeLine)
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
+    param([string]$RelativePath)
+
+    $normalizedRelativePath = $RelativePath.Replace('\', '/')
+    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::Ord
inalIgnoreCase)
+}
+
+function Invoke-FinalAutoGoalChangeGate {
+    param(
+        [int]$StepNumber
+    )
+
+    Clear-AutoGoalTempArtifacts
+
+    $statusLines = @(Get-GitStatusLines)
+    $command = "cleanup auto-goal temp artifacts, git status --short"
+
+    if ($statusLines.Count -eq 0) {
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $false $false 0 "a
uto-goal 최종 정리 후 worktree clean."
+        return
+    }
+
+    $changedPaths = @(
+        $statusLines |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            Where-Object { Test-HasValue $_ } |
+            Select-Object -Unique
+    )
+    $nonAiDevPaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
+    $aiDevPaths = @($changedPaths | Where-Object { Test-IsAiDevOperationalPath $_ })
+
+    if ($nonAiDevPaths.Count -gt 0) {
+        $message = "auto-goal 완료 직전 .ai-dev 밖 변경이 남아 completed로 종료하지 않습니다.`n$($statusLines -join "`
n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $false $true 1 $me
ssage
+        Stop-AutoGoal $script:steps "final_non_ai_dev_changes" $false 1
+    }
+
+    if (-not $AllowCommit) {
+        $message = "auto-goal 완료 직전 .ai-dev 운영 변경이 남았지만 -AllowCommit이 없어 메타 커밋에 포함할 수 없습니다.`n$($sta
tusLines -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $false $true 1 $me
ssage
+        Stop-AutoGoal $script:steps "final_ai_dev_changes_require_commit" $false 1
+    }
+
+    $addOutput = & git add -- $aiDevPaths 2>&1 | Out-String
+    $addExitCode = $LASTEXITCODE
+
+    if ($addExitCode -ne 0) {
+        $message = "auto-goal 최종 .ai-dev 메타 변경 git add 실패. exit code: $addExitCode`n$addOutput"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-dev 
files>" $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_meta_add_failed" $false 1
+    }
+
+    $commitOutput = & git commit -m "chore(ai-dev): finalize auto-goal state" -- $aiDevPaths 2>&1 |
 Out-String
+    $commitExitCode = $LASTEXITCODE
+
+    if ($commitExitCode -ne 0) {
+        $message = "auto-goal 최종 .ai-dev 메타 커밋 실패. exit code: $commitExitCode`n$commitOutput"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m 'chore(ai-de
v): finalize auto-goal state' -- <final .ai-dev files>" $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_meta_commit_failed" $false 1
+    }
+
+    $remainingStatus = @(Get-GitStatusLines)
+
+    if ($remainingStatus.Count -gt 0) {
+        $message = "auto-goal 최종 메타 커밋 이후에도 변경 파일이 남아 completed로 종료하지 않습니다.`n$($remainingStatus -jo
in "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git status --short" $true 
$false 1 $message
+        Stop-AutoGoal $script:steps "final_worktree_dirty" $false 1
+    }
+
+    $message = ($commitOutput.Trim(), "worktree clean") -join "`n"
+    $script:steps += New-StepResult $StepNumber "final-change-gate" "git add/commit final .ai-dev o
perational changes, git status --short" $true $false 0 $message
+}
 
 function Get-JsonObjectCandidates {
     param([string]$RawInput)
@@ -913,7 +1007,9 @@
     Stop-AutoGoal $script:steps "auto_cycle_incomplete" $false 1
 }
 
-$script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $f
alse 0 "auto-cycle-full 성공 후 goalStatus completed 확인."
-
-Stop-AutoGoal $script:steps "completed" $true 0
+$script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $f
alse 0 "auto-cycle-full 성공 후 goalStatus completed 확인."
+
+Invoke-FinalAutoGoalChangeGate 9
+
+Stop-AutoGoal $script:steps "completed" $true 0
 

codex
`scripts/ai-dev-auto-goal.ps1`만 수정했습니다.

구현 내용:
- completed 종료 직전 `Clear-AutoGoalTempArtifacts`를 먼저 실행하도록 보강했습니다.
- 최종 정리 뒤 worktree 상태를 확인하는 `final-change-gate`를 추가했습니다.
- 남은 변경이 `.ai-dev/` 운영 파일뿐이고 `-AllowCommit`이 있으면 별도 메타 커밋(`chore(ai-dev): finalize auto-goal state`)
으로 포함합니다.
- `.ai-dev` 밖 변경이 남거나, `.ai-dev` 변경을 커밋할 수 없는 상태면 completed로 종료하지 않고 실패 처리합니다.

검증:
- PowerShell 파서로 `scripts/ai-dev-auto-goal.ps1` 구문 검증 완료: `PowerShell parse OK`
- 규칙상 `git`, `npm run build`, `npm run test`, `npm run lint`는 실행하지 않았습니다.
- 실제 auto-goal 완료 시나리오 재현은 실행하지 못했습니다.

남은 위험:
- 실제 git 상태 기반 시나리오는 미실행이라, 다음 수동 검증에서 `auto-goal-planning-prompt.md` 삭제 변경이 최종 메타 커밋에 포함되는지 확인이 필요합
니다.

다음 task로 넘어가도 되는지:
- 코드 변경과 정적 구문 검증 기준으로는 넘어갈 수 있습니다.
- 다만 운영 루프에서는 수동 시나리오 검증 후 넘어가는 것이 안전합니다.

`.ai-dev/loop-log.md` 기록용 요약:
```md
- auto-goal completed 종료 직전 최종 변경 상태 검증을 추가했다.
- auto-goal 임시 산출물 정리 후 남은 `.ai-dev` 운영 변경은 `-AllowCommit`이 있을 때 최종 메타 커밋으로 포함한다.
- `.ai-dev` 밖 변경 또는 커밋 불가 변경이 남으면 completed로 종료하지 않고 실패 처리한다.
- PowerShell 구문 검증을 통과했으며, 실제 git 기반 완료 시나리오는 수동 검증 대상으로 남았다.
```
diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 85e9175fc4b61e6e37e5cfa283569fd39fc801ba..de9a02743bf0a4eb9d93d244b07e74620cdee06a
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -24,9 +24,10 @@
 $goalRelativePath = ".ai-dev/goal.md"
 $queueRelativePath = ".ai-dev/queue.json"
 $stateRelativePath = ".ai-dev/state.json"
-$promptRelativePath = ".ai-dev/current-task-prompt.md"
-$planningPromptRelativePath = ".ai-dev/auto-goal-planning-prompt.md"
-$legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"
+$promptRelativePath = ".ai-dev/current-task-prompt.md"
+$planningPromptRelativePath = ".ai-dev/auto-goal-planning-prompt.md"
+$legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"
+$aiDevOperationalRoot = ".ai-dev/"
 
 function Resolve-RepoPath {
     param([string]$Path)
@@ -203,16 +204,109 @@
     return $normalized.Substring(0, 500)
 }
 
-function Get-GitStatusLines {
-    $statusOutput = & git status --short 2>&1
-
-    if ($LASTEXITCODE -ne 0) {
-        $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 
1 "git status failed: $($statusOutput -join "`n")"
+function Get-GitStatusLines {
+    $statusOutput = & git status --short 2>&1
+
+    if ($LASTEXITCODE -ne 0) {
+        $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 
1 "git status failed: $($statusOutput -join "`n")"
         Stop-AutoGoal $script:steps "git_status_failed" $false 1
     }
-
-    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
-}
+
+    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
+}
+
+function Convert-ToChangedPath {
+    param([string]$ChangeLine)
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
+    param([string]$RelativePath)
+
+    $normalizedRelativePath = $RelativePath.Replace('\', '/')
+    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::Ord
inalIgnoreCase)
+}
+
+function Invoke-FinalAutoGoalChangeGate {
+    param(
+        [int]$StepNumber
+    )
+
+    Clear-AutoGoalTempArtifacts
+
+    $statusLines = @(Get-GitStatusLines)
+    $command = "cleanup auto-goal temp artifacts, git status --short"
+
+    if ($statusLines.Count -eq 0) {
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $false $false 0 "a
uto-goal 최종 정리 후 worktree clean."
+        return
+    }
+
+    $changedPaths = @(
+        $statusLines |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            Where-Object { Test-HasValue $_ } |
+            Select-Object -Unique
+    )
+    $nonAiDevPaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
+    $aiDevPaths = @($changedPaths | Where-Object { Test-IsAiDevOperationalPath $_ })
+
+    if ($nonAiDevPaths.Count -gt 0) {
+        $message = "auto-goal 완료 직전 .ai-dev 밖 변경이 남아 completed로 종료하지 않습니다.`n$($statusLines -join "`
n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $false $true 1 $me
ssage
+        Stop-AutoGoal $script:steps "final_non_ai_dev_changes" $false 1
+    }
+
+    if (-not $AllowCommit) {
+        $message = "auto-goal 완료 직전 .ai-dev 운영 변경이 남았지만 -AllowCommit이 없어 메타 커밋에 포함할 수 없습니다.`n$($sta
tusLines -join "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" $command $false $true 1 $me
ssage
+        Stop-AutoGoal $script:steps "final_ai_dev_changes_require_commit" $false 1
+    }
+
+    $addOutput = & git add -- $aiDevPaths 2>&1 | Out-String
+    $addExitCode = $LASTEXITCODE
+
+    if ($addExitCode -ne 0) {
+        $message = "auto-goal 최종 .ai-dev 메타 변경 git add 실패. exit code: $addExitCode`n$addOutput"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git add -- <final .ai-dev 
files>" $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_meta_add_failed" $false 1
+    }
+
+    $commitOutput = & git commit -m "chore(ai-dev): finalize auto-goal state" -- $aiDevPaths 2>&1 |
 Out-String
+    $commitExitCode = $LASTEXITCODE
+
+    if ($commitExitCode -ne 0) {
+        $message = "auto-goal 최종 .ai-dev 메타 커밋 실패. exit code: $commitExitCode`n$commitOutput"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git commit -m 'chore(ai-de
v): finalize auto-goal state' -- <final .ai-dev files>" $true $false 1 $message
+        Stop-AutoGoal $script:steps "final_meta_commit_failed" $false 1
+    }
+
+    $remainingStatus = @(Get-GitStatusLines)
+
+    if ($remainingStatus.Count -gt 0) {
+        $message = "auto-goal 최종 메타 커밋 이후에도 변경 파일이 남아 completed로 종료하지 않습니다.`n$($remainingStatus -jo
in "`n")"
+        $script:steps += New-StepResult $StepNumber "final-change-gate" "git status --short" $true 
$false 1 $message
+        Stop-AutoGoal $script:steps "final_worktree_dirty" $false 1
+    }
+
+    $message = ($commitOutput.Trim(), "worktree clean") -join "`n"
+    $script:steps += New-StepResult $StepNumber "final-change-gate" "git add/commit final .ai-dev o
perational changes, git status --short" $true $false 0 $message
+}
 
 function Get-JsonObjectCandidates {
     param([string]$RawInput)
@@ -913,7 +1007,9 @@
     Stop-AutoGoal $script:steps "auto_cycle_incomplete" $false 1
 }
 
-$script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $f
alse 0 "auto-cycle-full 성공 후 goalStatus completed 확인."
-
-Stop-AutoGoal $script:steps "completed" $true 0
+$script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath goalStatus 확인" $false $f
alse 0 "auto-cycle-full 성공 후 goalStatus completed 확인."
+
+Invoke-FinalAutoGoalChangeGate 9
+
+Stop-AutoGoal $script:steps "completed" $true 0
 

`scripts/ai-dev-auto-goal.ps1`만 수정했습니다.

구현 내용:
- completed 종료 직전 `Clear-AutoGoalTempArtifacts`를 먼저 실행하도록 보강했습니다.
- 최종 정리 뒤 worktree 상태를 확인하는 `final-change-gate`를 추가했습니다.
- 남은 변경이 `.ai-dev/` 운영 파일뿐이고 `-AllowCommit`이 있으면 별도 메타 커밋(`chore(ai-dev): finalize auto-goal state`)으로 포함합니다.
- `.ai-dev` 밖 변경이 남거나, `.ai-dev` 변경을 커밋할 수 없는 상태면 completed로 종료하지 않고 실패 처리합니다.

검증:
- PowerShell 파서로 `scripts/ai-dev-auto-goal.ps1` 구문 검증 완료: `PowerShell parse OK`
- 규칙상 `git`, `npm run build`, `npm run test`, `npm run lint`는 실행하지 않았습니다.
- 실제 auto-goal 완료 시나리오 재현은 실행하지 못했습니다.

남은 위험:
- 실제 git 상태 기반 시나리오는 미실행이라, 다음 수동 검증에서 `auto-goal-planning-prompt.md` 삭제 변경이 최종 메타 커밋에 포함되는지 확인이 필요합니다.

다음 task로 넘어가도 되는지:
- 코드 변경과 정적 구문 검증 기준으로는 넘어갈 수 있습니다.
- 다만 운영 루프에서는 수동 시나리오 검증 후 넘어가는 것이 안전합니다.

`.ai-dev/loop-log.md` 기록용 요약:
```md
- auto-goal completed 종료 직전 최종 변경 상태 검증을 추가했다.
- auto-goal 임시 산출물 정리 후 남은 `.ai-dev` 운영 변경은 `-AllowCommit`이 있을 때 최종 메타 커밋으로 포함한다.
- `.ai-dev` 밖 변경 또는 커밋 불가 변경이 남으면 completed로 종료하지 않고 실패 처리한다.
- PowerShell 구문 검증을 통과했으며, 실제 git 기반 완료 시나리오는 수동 검증 대상으로 남았다.
```
tokens used
52,932

```