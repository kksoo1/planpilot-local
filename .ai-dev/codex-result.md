# Codex Implementation Result

## Run

- Started at: 2026-06-25 16:29:06
- Ended at: 2026-06-25 16:32:11
- Exit code: 0
- Prompt: .ai-dev/current-task-prompt.md
- Command: codex exec <short wrapper pointing to .ai-dev/current-task-prompt.md>

## Output

```text
node.exe : OpenAI Codex v0.133.0
At C:\Users\SECUI\AppData\Roaming\npm\codex.ps1:24 char:5
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
session id: 019efdae-bd17-74b1-81a2-e80ec5e53c1a
--------
user
Read and follow the full task prompt at this absolute file path: D:\ai-apps\planpilot-loca
l\.ai-dev\current-task-prompt.md
codex
작업 지시 파일을 먼저 읽어서 범위와 제약을 확인하겠습니다. PowerShell에서 해당 파일만 대상으로 읽습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\current-task-prompt.md'" in D:\ai-apps\p
lanpilot-local
 succeeded in 1368ms:
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
AI Dev Loop 상태 출력에서 새 goal 또는 새 task가 `not_started` 상태일 때 이전 작업의 테스트 결과나 리뷰 응답 요약이 섞여 보이지 
않도록 개선한다.

## 배경
현재 자동 개발 루프 상태 표시에서 오래된 test-result 또는 review-response 요약이 현재 task의 `lastCommand`, `lastRe
viewDecision`, `currentTaskId`, goal 상태와 맞지 않게 노출될 수 있다. 이로 인해 새 작업이 시작되지 않았거나 초기 상태인데도 이전
 작업 결과가 현재 상태처럼 보이는 혼선이 생긴다.

## 성공 기준
- 현재 task가 `not_started` 또는 초기 상태일 때 이전 task의 리뷰/테스트 요약이 현재 결과처럼 표시되지 않는다.
- `currentTaskId`, goal 상태, `lastCommand`, `lastReviewDecision`과 맞지 않는 오래된 요약은 숨기거나 stale 
상태로 구분된다.
- 상태 출력 로직의 변경 범위가 작고 기존 자동 개발 루프 파일 구조를 유지한다.
- 관련 상태 표시 동작을 검증할 수 있는 최소 확인 절차가 정리된다.

## 제약사항
- 앱 기능 변경이 아니라 자동 개발 루프 운영 상태 표시 개선에만 집중한다.
- 기존 상태 파일 구조와 명명 규칙을 우선 사용한다.
- 불필요한 대규모 재작성이나 추상화는 피한다.
- 사용자 변경 사항은 되돌리지 않는다.

## 범위 제외
- React 앱의 사용자 기능 변경은 포함하지 않는다.
- IndexedDB 스키마 변경은 포함하지 않는다.
- 알림, 동기화, 계정 관련 기능은 포함하지 않는다.

## 수동 검증
- 새 goal 또는 새 task를 `not_started` 상태로 두고 상태 출력에서 이전 리뷰/테스트 요약이 현재 결과처럼 보이지 않는지 확인한다.
- 현재 task와 일치하는 최신 리뷰/테스트 요약은 정상적으로 표시되는지 확인한다.
- 오래된 요약을 stale로 표시하는 경우 현재 상태와 구분 가능한지 확인한다.

## Current Task

- Task ID: T001
- Title: 상태 출력의 오래된 요약 차단
- Description: ai-dev-status 출력 로직에서 현재 task와 goal 상태에 맞지 않는 이전 리뷰 또는 테스트 요약이 표시되지 않도록 작은 
범위로 개선한다.
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

- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json

## Verification

- 새 task 초기 상태에서 이전 리뷰/테스트 요약이 현재 결과처럼 표시되지 않는지 확인한다.
- 현재 task와 일치하는 최신 요약은 정상 표시되는지 확인한다.

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
프롬프트 기준으로 앱 `src`가 아니라 `.ai-dev` 운영 상태 표시 로직이 대상입니다. 먼저 관련 파일과 `ai-dev-status` 문자열 위치만 좁게 
찾겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "rg --files -g '
"'!node_modules'"' -g '"'!dist'"' -g '"'!*package-lock.json'"'" in D:\ai-apps\planpilot-lo
cal
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "rg -n \"ai-dev-
status|lastCommand|lastReviewDecision|test-result|review-response|currentTaskId\" -g '"'!n
ode_modules'"' -g '"'!dist'"' -g '"'!package-lock.json'"'" in D:\ai-apps\planpilot-local
 succeeded in 2102ms:
vite.config.ts
tsconfig.node.json
tsconfig.json
tsconfig.app.json
package.json
AGENTS.md
README.md
ROADMAP.md
eslint.config.js
index.html
docs\ai-dev-loop-operation.md
docs\data-backup-export-policy.md
docs\ai-dev-loop-policy.md
docs\data-import-restore-policy.md
docs\error-loading-state-policy.md
src\db.ts
src\App.css
src\App.tsx
src\main.tsx
docs\manual-regression-test-result.md
docs\manual-test-checklist.md
src\index.css
src\types.ts
src\store.ts
public\icons.svg
memory-bank\technicalContext.md
public\favicon.svg
memory-bank\progress.md
memory-bank\productContext.md
memory-bank\activeContext.md
scripts\ai-dev-copy-review-prompt.ps1
scripts\ai-dev-complete-task.ps1
scripts\ai-dev-commit.ps1
scripts\ai-dev-check.ps1
scripts\ai-dev-auto-step.ps1
scripts\ai-dev-auto-goal.ps1
scripts\ai-dev-auto-cycle.ps1
scripts\ai-dev-auto-cycle-full.ps1
scripts\ai-dev-env.ps1
scripts\ai-dev-current-task.ps1
scripts\ai-dev-init.ps1
scripts\ai-dev-manual-cycle.ps1
scripts\ai-dev-make-revise-prompt.ps1
scripts\ai-dev-make-review-prompt.ps1
scripts\ai-dev-next.ps1
scripts\ai-dev-run-codex.ps1
scripts\ai-dev-make-prompt.ps1
scripts\ai-dev-save-review.ps1
scripts\ai-dev-save-diff.ps1
scripts\ai-dev-run-review-codex.ps1
scripts\ai-dev-status.ps1
scripts\monitor-and-dev-loop.ps1
src\utils\importValidation.ts
src\views\SettingsView.tsx
src\utils\exportData.ts
src\views\ProjectsView.tsx
src\utils\dateUtils.ts
src\utils\projectLookup.ts
src\utils\projectDeletion.ts
src\views\TasksView.tsx
src\utils\projectStats.ts
src\ai\AIProvider.ts
src\utils\taskSummary.ts
src\ai\recommendationScore.ts
src\utils\taskDates.ts
src\views\TodayView.tsx
src\utils\taskLabels.ts
src\utils\taskFilters.ts
src\ai\RuleBasedAIProvider.ts
src\assets\vite.svg
src\assets\react.svg
src\assets\hero.png
src\hooks\useProjectActions.ts
src\hooks\useTaskFormState.ts
src\hooks\useTaskActions.ts
src\hooks\useProjectFormState.ts
src\components\ProjectForm.tsx
src\components\ProjectCard.tsx
src\components\TaskCard.tsx
src\components\TaskForm.tsx

 exited 1 in 2123ms:
2026-06-25T07:29:27.676176Z ERROR codex_core::tools::router: error=Exit code: 1
Wall time: 2.1 seconds
Output:

codex
일반 검색에는 숨김 디렉터리 `.ai-dev` 내용이 잡히지 않았습니다. 상태 출력 스크립트와 `.ai-dev` 상태 파일만 직접 확인해 현재 데이터 형태를 보겠
습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\state.json'" in D:\ai-apps\planpilot-loc
al
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-status.ps1'" in D:\ai-apps\planpi
lot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\queue.json'" in D:\ai-apps\planpilot-loc
al
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\goal.md'" in D:\ai-apps\planpilot-local
 succeeded in 2368ms:
{
    "goalStatus":  "in_progress",
    "currentTaskId":  "T001",
    "currentLoop":  0,
    "maxLoopsPerTask":  2,
    "repeatedFailureCount":  0,
    "lastCommand":  null,
    "lastCommandStatus":  "not_started",
    "lastErrorSummary":  null,
    "lastReviewDecision":  "not_started",
    "lastReviewSeverity":  null,
    "lastCommitHash":  null,
    "startedAt":  "2026-06-25T00:00:00+09:00",
    "updatedAt":  "2026-06-25T00:00:00+09:00",
    "stopReason":  null
}

 succeeded in 2449ms:
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
        $decisionLine = $lines | Where-Object { $_ -match '^- Decision:\s*(.+)$' } | Selec
t-Object -First 1
        $severityLine = $lines | Where-Object { $_ -match '^- Severity:\s*(.+)$' } | Selec
t-Object -First 1
        $nextStepLine = $lines | Where-Object { $_ -match '^- Next step:\s*(.+)$' } | Sele
ct-Object -First 1
        $summaryLine = $lines | Where-Object { $_ -match '^- Summary:\s*(.+)$' } | Select-
Object -First 1

        $decision = if ($decisionLine -match '^- Decision:\s*(.+)$') { $Matches[1].Trim() 
} else { $null }
        $severity = if ($severityLine -match '^- Severity:\s*(.+)$') { $Matches[1].Trim() 
} else { $null }
        $nextStep = if ($nextStepLine -match '^- Next step:\s*(.+)$') { $Matches[1].Trim()
 } else { $null }
        $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } e
lse { $null }
        $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or (
Test-HasValue $nextStep) -or (Test-HasValue $summary)

        return [PSCustomObject]@{
            available = $true
            decision = $decision
            severity = $severity
            nextStep = $nextStep
            summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
            fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object -
Last 30) -join "`r`n") }
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
    $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-Objec
t -First 1

    if ($null -ne $inProgressTask) {
        $currentTaskId = [string]$inProgressTask.id
    } else {
        $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Object -
First 1

        if ($null -ne $pendingTask) {
            $currentTaskId = [string]$pendingTask.id
        }
    }
}

$currentTask = $null

if (Test-HasValue $currentTaskId) {
    $currentTask = $tasks | Where-Object { $_.id -eq $currentTaskId } | Select-Object -Fir
st 1
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
            $gitStatusLines = @($gitOutput -split "`r?`n" | Where-Object { -not [string]::
IsNullOrWhiteSpace($_) })
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
        id = if ($null -ne $currentTask) { $currentTask.id } elseif (Test-HasValue $curren
tTaskId) { $currentTaskId } else { $null }
        title = if ($null -ne $currentTask) { $currentTask.title } else { "없음" }
        status = if ($null -ne $currentTask) { $currentTask.status } else { "없음" }
        type = if ($null -ne $currentTask) { $currentTask.type } else { "없음" }
        priority = if ($null -ne $currentTask) { $currentTask.priority } else { "없음" }
    }
    taskProgress = "$($taskCounts.done)/$($taskCounts.total)"
    taskCounts = $taskCounts
    lastCommand = if (Test-HasValue $state.lastCommand) { $state.lastCommand } else { "없음"
 }
    lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { $state.lastCommandSt
atus } else { "없음" }
    lastErrorSummary = if (Test-HasValue $state.lastErrorSummary) { $state.lastErrorSummar
y } else { "없음" }
    lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { $state.lastReviewD
ecision } else { "없음" }
    lastReviewSeverity = if (Test-HasValue $state.lastReviewSeverity) { $state.lastReviewS
everity } else { "없음" }
    lastCommitHash = if (Test-HasValue $state.lastCommitHash) { $state.lastCommitHash } el
se { "없음" }
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
Write-Host "Task counts: pending=$($taskCounts.pending), in_progress=$($taskCounts.in_prog
ress), review_required=$($taskCounts.review_required), done=$($taskCounts.done), failed=$(
$taskCounts.failed), blocked=$($taskCounts.blocked), skipped=$($taskCounts.skipped), total
=$($taskCounts.total)"
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

 succeeded in 2489ms:
{
    "goalTitle":  "AI Dev Loop status stale summary 차단",
    "goalSource":  ".ai-dev/goal.md",
    "createdAt":  "2026-06-25T00:00:00+09:00",
    "updatedAt":  "2026-06-25T00:00:00+09:00",
    "currentTaskId":  "T001",
    "tasks":  [
                  {
                      "id":  "T001",
                      "title":  "상태 출력의 오래된 요약 차단",
                      "description":  "ai-dev-status 출력 로직에서 현재 task와 goal 상태에 맞지 않는 이전 리뷰
 또는 테스트 요약이 표시되지 않도록 작은 범위로 개선한다.",
                      "type":  "implementation",
                      "status":  "in_progress",
                      "priority":  "P0",
                      "dependsOn":  [

                                    ],
                      "filesLikelyToChange":  [
                                                  ".ai-dev/goal.md",
                                                  ".ai-dev/queue.json",
                                                  ".ai-dev/state.json"
                                              ],
                      "verification":  [
                                           "새 task 초기 상태에서 이전 리뷰/테스트 요약이 현재 결과처럼 표시되지 않는지 
확인한다.",
                                           "현재 task와 일치하는 최신 요약은 정상 표시되는지 확인한다."
                                       ],
                      "commitMessage":  "Hide stale AI dev status summaries"
                  }
              ]
}

 succeeded in 2577ms:
# 목표
AI Dev Loop 상태 출력에서 새 goal 또는 새 task가 `not_started` 상태일 때 이전 작업의 테스트 결과나 리뷰 응답 요약이 섞여 보이지 
않도록 개선한다.

## 배경
현재 자동 개발 루프 상태 표시에서 오래된 test-result 또는 review-response 요약이 현재 task의 `lastCommand`, `lastRe
viewDecision`, `currentTaskId`, goal 상태와 맞지 않게 노출될 수 있다. 이로 인해 새 작업이 시작되지 않았거나 초기 상태인데도 이전
 작업 결과가 현재 상태처럼 보이는 혼선이 생긴다.

## 성공 기준
- 현재 task가 `not_started` 또는 초기 상태일 때 이전 task의 리뷰/테스트 요약이 현재 결과처럼 표시되지 않는다.
- `currentTaskId`, goal 상태, `lastCommand`, `lastReviewDecision`과 맞지 않는 오래된 요약은 숨기거나 stale 
상태로 구분된다.
- 상태 출력 로직의 변경 범위가 작고 기존 자동 개발 루프 파일 구조를 유지한다.
- 관련 상태 표시 동작을 검증할 수 있는 최소 확인 절차가 정리된다.

## 제약사항
- 앱 기능 변경이 아니라 자동 개발 루프 운영 상태 표시 개선에만 집중한다.
- 기존 상태 파일 구조와 명명 규칙을 우선 사용한다.
- 불필요한 대규모 재작성이나 추상화는 피한다.
- 사용자 변경 사항은 되돌리지 않는다.

## 범위 제외
- React 앱의 사용자 기능 변경은 포함하지 않는다.
- IndexedDB 스키마 변경은 포함하지 않는다.
- 알림, 동기화, 계정 관련 기능은 포함하지 않는다.

## 수동 검증
- 새 goal 또는 새 task를 `not_started` 상태로 두고 상태 출력에서 이전 리뷰/테스트 요약이 현재 결과처럼 보이지 않는지 확인한다.
- 현재 task와 일치하는 최신 리뷰/테스트 요약은 정상적으로 표시되는지 확인한다.
- 오래된 요약을 stale로 표시하는 경우 현재 상태와 구분 가능한지 확인한다.

codex
현재 문제는 `scripts/ai-dev-status.ps1`이 `.ai-dev/test-result.md`와 `.ai-dev/review.md`를 무조건 읽어 
출력하는 구조입니다. 수정 전, 두 요약 파일에 현재 task를 식별할 메타데이터가 있는지 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\test-result.md'" in D:\ai-apps\planpilot
-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-save-review.ps1'" in D:\ai-apps\p
lanpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-check.ps1'" in D:\ai-apps\planpil
ot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\review.md'" in D:\ai-apps\planpilot-loca
l
 succeeded in 2395ms:
param(
    [switch]$BuildOnly,
    [switch]$SkipBuild,
    [switch]$SkipTest,
    [switch]$SkipLint,
    [switch]$ManualSummaryOnly,
    [string]$ManualSummary
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$packageRelativePath = "package.json"
$stateRelativePath = ".ai-dev/state.json"
$testResultRelativePath = ".ai-dev/test-result.md"

$packagePath = Join-Path $projectRoot $packageRelativePath
$statePath = Join-Path $projectRoot $stateRelativePath
$testResultPath = Join-Path $projectRoot $testResultRelativePath
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

function Test-HasScript {
    param(
        [object]$Package,
        [string]$Name
    )

    return $null -ne $Package.scripts -and ($Package.scripts.PSObject.Properties.Name -con
tains $Name)
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

function Invoke-NpmCheck {
    param(
        [string]$Name,
        [bool]$ShouldRun,
        [string]$SkipReason
    )

    $command = "npm run $Name"

    if (-not $ShouldRun) {
        return [PSCustomObject]@{
            Name = $Name
            Command = $command
            Status = "skipped"
            ExitCode = $null
            Log = $SkipReason
        }
    }

    Write-Host "실행 중: $command"
    $output = & npm run $Name 2>&1 | Out-String
    $exitCode = $LASTEXITCODE
    $status = if ($exitCode -eq 0) { "passed" } else { "failed" }

    return [PSCustomObject]@{
        Name = $Name
        Command = $command
        Status = $status
        ExitCode = $exitCode
        Log = $output.TrimEnd()
    }
}

$requiredPaths = if ($ManualSummaryOnly) {
    @($stateRelativePath, $testResultRelativePath)
} else {
    @($packageRelativePath, $stateRelativePath, $testResultRelativePath)
}

foreach ($requiredPath in $requiredPaths) {
    $fullPath = Join-Path $projectRoot $requiredPath

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        Stop-WithError "필수 파일이 없습니다: $requiredPath"
    }
}

$state = Read-JsonFile $statePath $stateRelativePath

if ($ManualSummaryOnly) {
    if ([string]::IsNullOrWhiteSpace($ManualSummary)) {
        Stop-WithError "-ManualSummaryOnly를 사용할 때는 -ManualSummary 내용을 입력해야 합니다."
    }

    $currentTaskId = if ($null -ne $state.currentTaskId -and -not [string]::IsNullOrWhiteS
pace([string]$state.currentTaskId)) {
        [string]$state.currentTaskId
    } else {
        "없음"
    }

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $codeFence = '```'
    $testResultContent = @"
# AI Dev Test Result

## $timestamp

- Overall result: recorded
- Current task: $currentTaskId
- Mode: manual-summary
- Commands:
  - npm run build: skipped
  - npm run test: skipped
  - npm run lint: skipped

### Manual Verification Summary

${codeFence}text
$ManualSummary
$codeFence
"@

    [System.IO.File]::WriteAllText($testResultPath, $testResultContent, $utf8WithBom)

    $now = [DateTimeOffset]::UtcNow.ToString("o")
    Set-ObjectProperty $state "lastCommand" "manual-summary"
    Set-ObjectProperty $state "lastCommandStatus" "passed"
    Set-ObjectProperty $state "lastErrorSummary" ""
    Set-ObjectProperty $state "updatedAt" $now

    $stateJson = $state | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)

    Write-Host "수동 검증 요약 기록 완료: $testResultRelativePath"
    Write-Host "상태 저장 완료: $stateRelativePath"
    exit 0
}

$package = Read-JsonFile $packagePath $packageRelativePath

$hasBuild = Test-HasScript $package "build"
$hasTest = Test-HasScript $package "test"
$hasLint = Test-HasScript $package "lint"

$runBuild = $hasBuild -and -not $SkipBuild
$runTest = $hasTest -and -not $SkipTest -and -not $BuildOnly
$runLint = $hasLint -and -not $SkipLint

$buildSkipReason = if (-not $hasBuild) {
    "package.json에 build script가 없습니다."
} elseif ($SkipBuild) {
    "-SkipBuild 옵션으로 건너뛰었습니다."
} else {
    ""
}

$testSkipReason = if (-not $hasTest) {
    "package.json에 test script가 없습니다."
} elseif ($SkipTest) {
    "-SkipTest 옵션으로 건너뛰었습니다."
} elseif ($BuildOnly) {
    "-BuildOnly 옵션으로 건너뛰었습니다."
} else {
    ""
}

$lintSkipReason = if (-not $hasLint) {
    "package.json에 lint script가 없습니다."
} elseif ($SkipLint) {
    "-SkipLint 옵션으로 건너뛰었습니다."
} else {
    ""
}

$results = @(
    Invoke-NpmCheck "build" $runBuild $buildSkipReason
    Invoke-NpmCheck "test" $runTest $testSkipReason
    Invoke-NpmCheck "lint" $runLint $lintSkipReason
)

$failedResults = @($results | Where-Object { $_.Status -eq "failed" })
$executedResults = @($results | Where-Object { $_.Status -ne "skipped" })
$overallResult = if ($failedResults.Count -gt 0) { "failed" } else { "passed" }
$currentTaskId = if ($null -ne $state.currentTaskId -and -not [string]::IsNullOrWhiteSpace
([string]$state.currentTaskId)) {
    [string]$state.currentTaskId
} else {
    "없음"
}

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$modeText = if ($BuildOnly) { "BuildOnly (build + lint when available)" } else { "standard
" }
$commandSummary = ($results | ForEach-Object { "  - $($_.Command): $($_.Status)" }) -join 
"`r`n"
$detailSections = @()
$codeFence = '```'

foreach ($result in $results) {
    $logText = if ([string]::IsNullOrWhiteSpace($result.Log)) { "출력 없음" } else { $result.L
og }
    $exitCodeText = if ($null -eq $result.ExitCode) { "없음" } else { [string]$result.ExitCo
de }

    $detailSections += @"
### $($result.Command)

- Status: $($result.Status)
- Exit code: $exitCodeText

${codeFence}text
$logText
$codeFence
"@
}

$testResultContent = @"
# AI Dev Test Result

## $timestamp

- Overall result: $overallResult
- Current task: $currentTaskId
- Mode: $modeText
- Commands:
$commandSummary

$($detailSections -join "`r`n")
"@

[System.IO.File]::WriteAllText($testResultPath, $testResultContent, $utf8WithBom)

$now = [DateTimeOffset]::UtcNow.ToString("o")
$lastCommand = if ($executedResults.Count -gt 0) {
    $executedResults[-1].Command
} else {
    "ai-dev-check"
}
$lastCommandStatus = if ($executedResults.Count -eq 0) {
    "skipped"
} else {
    $overallResult
}
$lastErrorSummary = if ($failedResults.Count -gt 0) {
    ($failedResults | ForEach-Object { "$($_.Command) exit code $($_.ExitCode)" }) -join "
; "
} else {
    ""
}

Set-ObjectProperty $state "lastCommand" $lastCommand
Set-ObjectProperty $state "lastCommandStatus" $lastCommandStatus
Set-ObjectProperty $state "lastErrorSummary" $lastErrorSummary
Set-ObjectProperty $state "updatedAt" $now

$stateJson = $state | ConvertTo-Json -Depth 20
[System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)

Write-Host "검증 결과: $overallResult"
foreach ($result in $results) {
    Write-Host "  - $($result.Command): $($result.Status)"
}
Write-Host "기록 완료: $testResultRelativePath"
Write-Host "상태 저장 완료: $stateRelativePath"

if ($overallResult -eq "failed") {
    exit 1
}

exit 0

 succeeded in 2458ms:
param(
    [string]$ReviewFile,
    [string]$ReviewJson,
    [switch]$FromClipboard,
    [switch]$WriteFailureReview
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$stateRelativePath = ".ai-dev/state.json"
$reviewRelativePath = ".ai-dev/review.md"
$statePath = Join-Path $projectRoot $stateRelativePath
$reviewPath = Join-Path $projectRoot $reviewRelativePath
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
$codeFence = '```'

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

function Save-StateReviewResult {
    param(
        [object]$State,
        [string]$Decision,
        [string]$Severity,
        [string]$CommandStatus,
        [string]$ErrorSummary
    )

    Set-ObjectProperty $State "lastReviewDecision" $Decision
    Set-ObjectProperty $State "lastReviewSeverity" $Severity
    Set-ObjectProperty $State "lastCommand" "save-review"
    Set-ObjectProperty $State "lastCommandStatus" $CommandStatus
    Set-ObjectProperty $State "lastErrorSummary" $ErrorSummary
    Set-ObjectProperty $State "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))

    $stateJson = $State | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)
}

function Get-ReviewInput {
    $inputCount = 0

    if (Test-HasValue $ReviewJson) {
        $inputCount++
    }

    if (Test-HasValue $ReviewFile) {
        $inputCount++
    }

    if ($FromClipboard) {
        $inputCount++
    }

    if ($inputCount -eq 0) {
        Write-Host "사용 예시:"
        Write-Host "  powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.
ps1 -ReviewFile .ai-dev/review-response.json"
        Write-Host '  powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.
ps1 -ReviewJson ''{"decision":"pass","severity":"none","summary":"OK","required_changes":[
],"optional_suggestions":[],"next_step":"complete_task"}'''
        Write-Host "  powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.
ps1 -FromClipboard"
        Stop-WithError "리뷰 입력을 지정해야 합니다."
    }

    if ($inputCount -gt 1) {
        Stop-WithError "-ReviewJson, -ReviewFile, -FromClipboard 중 하나만 지정해야 합니다."
    }

    if (Test-HasValue $ReviewJson) {
        return $ReviewJson
    }

    if (Test-HasValue $ReviewFile) {
        $reviewFilePath = if ([System.IO.Path]::IsPathRooted($ReviewFile)) {
            $ReviewFile
        } else {
            Join-Path $projectRoot $ReviewFile
        }

        if (-not (Test-Path -LiteralPath $reviewFilePath -PathType Leaf)) {
            Stop-WithError "리뷰 파일이 없습니다: $ReviewFile"
        }

        try {
            return Get-Content -Raw -Encoding UTF8 -LiteralPath $reviewFilePath
        } catch {
            Stop-WithError "리뷰 파일을 읽지 못했습니다: $ReviewFile"
        }
    }

    try {
        return Get-Clipboard -Raw
    } catch {
        Stop-WithError "클립보드 내용을 읽지 못했습니다: $($_.Exception.Message)"
    }
}

function Get-JsonCandidates {
    param(
        [string]$RawInput
    )

    $candidates = @()
    $trimmed = $RawInput.Trim()

    if (-not [string]::IsNullOrWhiteSpace($trimmed)) {
        $candidates += $trimmed
    }

    $codeBlockMatch = [regex]::Match(
        $RawInput,
        '```(?:json)?\s*(\{[\s\S]*?\})\s*```',
        [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
    )

    if ($codeBlockMatch.Success) {
        $candidates += $codeBlockMatch.Groups[1].Value.Trim()
    }

    $firstJsonObject = Get-FirstJsonObject $RawInput

    if (-not [string]::IsNullOrWhiteSpace($firstJsonObject)) {
        $candidates += $firstJsonObject
    }

    return @($candidates | Select-Object -Unique)
}

function Get-FirstJsonObject {
    param(
        [string]$RawInput
    )

    $start = $RawInput.IndexOf("{")

    if ($start -lt 0) {
        return $null
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
                return $RawInput.Substring($start, $index - $start + 1).Trim()
            }
        }
    }

    return $null
}

function Get-InputPreview {
    param(
        [string]$RawInput
    )

    if ($null -eq $RawInput) {
        return "<null>"
    }

    $normalized = $RawInput.Replace("`r", " ").Replace("`n", " ").Trim()

    if ($normalized.Length -eq 0) {
        return "<empty>"
    }

    if ($normalized.Length -le 300) {
        return $normalized
    }

    return $normalized.Substring(0, 300)
}

function ConvertFrom-ReviewJson {
    param(
        [string]$RawInput
    )

    foreach ($candidate in Get-JsonCandidates $RawInput) {
        try {
            $parsed = $candidate | ConvertFrom-Json

            if ($null -ne $parsed -and $parsed -isnot [System.Array]) {
                return [PSCustomObject]@{
                    Parsed = $parsed
                    JsonText = $candidate
                }
            }
        } catch {
        }
    }

    throw "리뷰 입력에서 유효한 JSON 객체를 찾지 못했습니다."
}

function Get-ValidationErrors {
    param(
        [object]$Review
    )

    $errors = @()
    $requiredFields = @(
        "decision",
        "severity",
        "summary",
        "required_changes",
        "optional_suggestions",
        "next_step"
    )

    foreach ($field in $requiredFields) {
        if (-not ($Review.PSObject.Properties.Name -contains $field)) {
            $errors += "필수 필드 누락: $field"
        }
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (@("pass", "revise", "blocked") -notcontains $Review.decision) {
        $errors += "허용되지 않은 decision: $($Review.decision)"
    }

    if (@("none", "low", "medium", "high", "critical") -notcontains $Review.severity) {
        $errors += "허용되지 않은 severity: $($Review.severity)"
    }

    if (@("complete_task", "revise_with_codex", "stop_for_user") -notcontains $Review.next
_step) {
        $errors += "허용되지 않은 next_step: $($Review.next_step)"
    }

    if ($Review.required_changes -isnot [System.Collections.IEnumerable] -or $Review.requi
red_changes -is [string]) {
        $errors += "required_changes는 배열이어야 합니다."
    }

    if ($Review.optional_suggestions -isnot [System.Collections.IEnumerable] -or $Review.o
ptional_suggestions -is [string]) {
        $errors += "optional_suggestions는 배열이어야 합니다."
    }

    return $errors
}

function Format-RequiredChanges {
    param(
        [object]$Changes
    )

    $items = @($Changes)

    if ($items.Count -eq 0) {
        return "- 없음"
    }

    return ($items | ForEach-Object {
        $file = if (Test-HasValue $_.file) { $_.file } else { "unknown" }
        $reason = if (Test-HasValue $_.reason) { $_.reason } else { "이유 없음" }
        $suggestion = if (Test-HasValue $_.suggestion) { $_.suggestion } else { "제안 없음" }
        "- $file`: $reason / $suggestion"
    }) -join "`r`n"
}

function Format-OptionalSuggestions {
    param(
        [object]$Suggestions
    )

    $items = @($Suggestions)

    if ($items.Count -eq 0) {
        return "- 없음"
    }

    return ($items | ForEach-Object {
        $file = if (Test-HasValue $_.file) { $_.file } else { "unknown" }
        $suggestion = if (Test-HasValue $_.suggestion) { $_.suggestion } else { "제안 없음" }
        "- $file`: $suggestion"
    }) -join "`r`n"
}

function Save-InvalidReview {
    param(
        [object]$State,
        [string]$RawInput,
        [string]$ErrorSummary
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $content = @"
# AI Dev Review

## $timestamp

- Decision: blocked
- Severity: critical
- Next step: stop_for_user
- Summary: 리뷰 JSON을 파싱하거나 검증하지 못했습니다.

### Validation Error

- $ErrorSummary

### Raw Input

${codeFence}text
$RawInput
$codeFence
"@

    [System.IO.File]::WriteAllText($reviewPath, $content, $utf8WithBom)
    Save-StateReviewResult $State "blocked" "critical" "failed" $ErrorSummary
}

function Stop-WithInvalidReviewInput {
    param(
        [object]$State,
        [string]$RawInput,
        [string]$ErrorSummary
    )

    if ($WriteFailureReview) {
        Save-InvalidReview $State $RawInput $ErrorSummary
        Stop-WithError "리뷰 JSON 저장에 실패했습니다: $ErrorSummary"
    }

    Write-Host "리뷰 입력 오류로 review.md와 state.json을 수정하지 않았습니다."
    Write-Host "실패 리뷰를 명시적으로 기록하려면 -WriteFailureReview 옵션을 사용하세요."
    Stop-WithError "리뷰 JSON 저장에 실패했습니다: $ErrorSummary"
}

if (-not (Test-Path -LiteralPath $statePath -PathType Leaf)) {
    Stop-WithError "필수 파일이 없습니다: $stateRelativePath"
}

$state = Read-JsonFile $statePath $stateRelativePath
$rawReview = Get-ReviewInput
$inputPreview = Get-InputPreview $rawReview

if ([string]::IsNullOrWhiteSpace($rawReview)) {
    $errorSummary = "리뷰 입력이 비어 있습니다. ChatGPT가 출력한 JSON 리뷰를 클립보드에 복사한 뒤 다시 실행하세요. 입력 previe
w: $inputPreview"
    Stop-WithInvalidReviewInput $state $rawReview $errorSummary
}

try {
    $reviewResult = ConvertFrom-ReviewJson $rawReview
    $review = $reviewResult.Parsed
    $validationErrors = @(Get-ValidationErrors $review)

    if ($validationErrors.Count -gt 0) {
        throw ($validationErrors -join "; ")
    }
} catch {
    $errorSummary = "$($_.Exception.Message) 입력 preview: $inputPreview"
    Stop-WithInvalidReviewInput $state $rawReview $errorSummary
}

$prettyJson = $review | ConvertTo-Json -Depth 20
$requiredChangesText = Format-RequiredChanges $review.required_changes
$optionalSuggestionsText = Format-OptionalSuggestions $review.optional_suggestions
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$reviewContent = @"
# AI Dev Review

## $timestamp

- Decision: $($review.decision)
- Severity: $($review.severity)
- Next step: $($review.next_step)
- Summary: $($review.summary)

### Required Changes

$requiredChangesText

### Optional Suggestions

$optionalSuggestionsText

### Raw JSON

${codeFence}json
$prettyJson
$codeFence
"@

[System.IO.File]::WriteAllText($reviewPath, $reviewContent, $utf8WithBom)
Save-StateReviewResult $state $review.decision $review.severity "passed" ""

$nextAction = if ($review.decision -eq "pass" -and $review.next_step -eq "complete_task") 
{
    "pass + complete_task: 다음 명령을 실행해 현재 task 완료 처리를 검토하세요. powershell -ExecutionPolicy By
pass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 통과`""
} elseif ($review.decision -eq "revise" -and $review.next_step -eq "revise_with_codex") {
    "revise + make_revise_prompt: 다음 명령으로 재수정 프롬프트를 생성한 뒤 Codex/Cline에 전달하세요. powershell -
ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1"
} elseif ($review.decision -eq "blocked" -or $review.next_step -eq "stop_for_user") {
    "blocked/stop_for_user: 사용자 판단이 필요합니다. 자동 진행을 중단하고 review.md의 Required Changes와 Summar
y를 확인하세요."
} else {
    "decision과 next_step 조합을 확인한 뒤 다음 행동을 결정하세요."
}

Write-Host "리뷰 저장 완료: $reviewRelativePath"
Write-Host "Decision: $($review.decision)"
Write-Host "Severity: $($review.severity)"
Write-Host "Next step: $($review.next_step)"
Write-Host "안내: $nextAction"

 succeeded in 2487ms:
# AI Dev Review

## 2026-06-25 15:58:57

- Decision: pass
- Severity: none
- Next step: complete_task
- Summary: 로컬 저장 안내 문구가 작은 범위에서 보강되었고 현재 task 요구사항과 p
rivacy-first 방향에 부합합니다.

### Required Changes

- 없음

### Optional Suggestions

- 없음

### Raw JSON

```json
{
    "decision":  "pass",
    "severity":  "none",
    "summary":  "로컬 저장 안내 문구가 작은 범위에서 보강되었고 현재 task 요구사항과 p\r\nrivacy-first 방향에 부합합니다.",
    "required_changes":  [

                         ],
    "optional_suggestions":  [

                             ],
    "scope_check":  {
                        "w\r\nithin_current_task":  true,
                        "scope_issues":  [

                                         ]
                    },
    "test_check":  {
                       "build_passed":  true,
                       "test_passed\r\n":  false,
                       "lint_passed":  true,
                       "issues":  [
                                      "package.json에 test script가 없어 npm run test는 skipped
 \r\n처리되었습니다."
                                  ]
                   },
    "next_step":  "complete_task"
}
```

 succeeded in 2509ms:
# AI Dev Test Result

## 2026-06-25 15:57:53

- Overall result: passed
- Current task: T003
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
dist/assets/index-DtLVvPCG.js   317.50 kB │ gzip: 100.16 kB

[32m✓ built in 213ms[39m
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

codex
수정 방향은 작게 잡겠습니다. `ai-dev-status`에서 현재 상태가 초기값이거나 요약 파일의 task 표시가 현재 task와 다르면 본문을 그대로 출력하지
 않고 `stale`/숨김 이유를 출력하도록 바꾸겠습니다.
codex
이제 `scripts/ai-dev-status.ps1` 한 파일만 수정합니다. `src` 외 파일 수정 이유는 자동 개발 루프 운영 상태 출력 스크립트가 이번 t
ask의 직접 대상이기 때문입니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\scripts\ai-dev-status.ps1
diff --git a/scripts/ai-dev-status.ps1 b/scripts/ai-dev-status.ps1
index 83046c60ec29bcad826a0d0baa1eee36c553b87e..9aa3d95c2f430bd6616da269af3c57396d258bd4
--- a/scripts/ai-dev-status.ps1
+++ b/scripts/ai-dev-status.ps1
@@ -76,13 +76,77 @@
     }
 }
 
+function Get-TestResultCurrentTaskId {
+    param(
+        [string[]]$Lines
+    )
+
+    $currentTaskLine = $Lines | Where-Object { $_ -match '^- Current task:\s*(.+)$' } | S
elect-Object -First 1
+
+    if ($currentTaskLine -match '^- Current task:\s*(.+)$') {
+        return $Matches[1].Trim()
+    }
+
+    return $null
+}
+
+function New-SummaryStatus {
+    param(
+        [string]$Status,
+        [string]$Reason,
+        [object]$Content
+    )
+
+    return [PSCustomObject]@{
+        status = $Status
+        reason = $Reason
+        content = $Content
+    }
+}
+
+function Get-TestResultSummary {
+    param(
+        [string]$Path,
+        [string]$CurrentTaskId,
+        [bool]$IsInitialState
+    )
+
+    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
+        return New-SummaryStatus "missing" "test-result 파일이 없습니다." "없음"
+    }
+
+    try {
+        $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)
+
+        if ($lines.Count -eq 0) {
+            return New-SummaryStatus "missing" "test-result 파일이 비어 있습니다." "없음"
+        }
+
+        $resultTaskId = Get-TestResultCurrentTaskId $lines
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 test-result 요약을 숨겼습니다." 
"숨김"
+        }
+
+        if ((Test-HasValue $CurrentTaskId) -and (Test-HasValue $resultTaskId) -and $resul
tTaskId -ne $CurrentTaskId) {
+            return New-SummaryStatus "stale" "test-result의 task($resultTaskId)가 현재 task($
CurrentTaskId)와 다릅니다." "숨김"
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." (($lines | Select-Object -Last
 30) -join "`r`n")
+    } catch {
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" "읽기 실패: $($_.Ex
ception.Message)"
+    }
+}
+
 function Get-ReviewSummary {
     param(
-        [string]$Path
+        [string]$Path,
+        [string]$LastReviewDecision,
+        [bool]$IsInitialState
     )
 
     if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
-        return [PSCustomObject]@{
+        $missingSummary = [PSCustomObject]@{
             available = $false
             decision = $null
             severity = $null
@@ -90,6 +154,8 @@
             summary = "없음"
             fallback = $null
         }
+
+        return New-SummaryStatus "missing" "review 파일이 없습니다." $missingSummary
     }
 
     try {
@@ -105,7 +171,7 @@
         $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } 
else { $null }
         $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or 
(Test-HasValue $nextStep) -or (Test-HasValue $summary)
 
-        return [PSCustomObject]@{
+        $review = [PSCustomObject]@{
             available = $true
             decision = $decision
             severity = $severity
@@ -113,8 +179,22 @@
             summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
             fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object 
-Last 30) -join "`r`n") }
         }
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." $revi
ew
+        }
+
+        if ((Test-HasValue $LastReviewDecision) -and $LastReviewDecision -ne "not_started
" -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
+            return New-SummaryStatus "stale" "review decision($decision)이 state lastRevie
wDecision($LastReviewDecision)와 다릅니다." $review
+        }
+
+        if (-not (Test-HasValue $LastReviewDecision) -or $LastReviewDecision -eq "not_sta
rted") {
+            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 
요약을 숨겼습니다." $review
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." $review
     } catch {
-        return [PSCustomObject]@{
+        $errorSummary = [PSCustomObject]@{
             available = $true
             decision = $null
             severity = $null
@@ -122,6 +202,8 @@
             summary = "읽기 실패: $($_.Exception.Message)"
             fallback = $null
         }
+
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" $errorSummary
     }
 }
 
@@ -182,6 +264,16 @@
     skipped = @($tasks | Where-Object { $_.status -eq "skipped" }).Count
 }
 
+$currentTaskStatus = if ($null -ne $currentTask) { [string]$currentTask.status } else { $
null }
+$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastCom
mandStatus } else { $null }
+$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastR
eviewDecision } else { $null }
+$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { $
null }
+$initialTaskStatuses = @("not_started", "pending")
+$isInitialState = ($initialTaskStatuses -contains $currentTaskStatus) -or `
+    ($goalStatus -eq "not_started") -or `
+    (-not (Test-HasValue $state.lastCommand) -and ($lastCommandStatus -eq "not_started" -
or -not (Test-HasValue $lastCommandStatus))) -or `
+    ($lastReviewDecision -eq "not_started")
+
 $gitStatus = "unavailable"
 $gitChangedFilesCount = $null
 $gitStatusLines = @()
@@ -202,8 +294,8 @@
     $gitStatus = "unavailable"
 }
 
-$testResultSummary = Get-LastLines $testResultPath 30
-$reviewSummary = Get-ReviewSummary $reviewPath
+$testResultSummary = Get-TestResultSummary $testResultPath $currentTaskId $isInitialState
+$reviewSummary = Get-ReviewSummary $reviewPath $lastReviewDecision $isInitialState
 
 $statusObject = [ordered]@{
     goalTitle = if (Test-HasValue $queue.goalTitle) { $queue.goalTitle } else { "없음" }
@@ -256,14 +348,18 @@
 Write-Host "Git changed files count: $($statusObject.git.changedFilesCount)"
 Write-Host ""
 Write-Host "Test result summary:"
-Write-Host $statusObject.testResultSummary
+Write-Host "  Status: $($testResultSummary.status)"
+Write-Host "  Reason: $($testResultSummary.reason)"
+Write-Host $testResultSummary.content
 Write-Host ""
 Write-Host "Review summary:"
-Write-Host "  Decision: $($reviewSummary.decision)"
-Write-Host "  Severity: $($reviewSummary.severity)"
-Write-Host "  Next step: $($reviewSummary.nextStep)"
-Write-Host "  Summary: $($reviewSummary.summary)"
+Write-Host "  Status: $($reviewSummary.status)"
+Write-Host "  Reason: $($reviewSummary.reason)"
+Write-Host "  Decision: $($reviewSummary.content.decision)"
+Write-Host "  Severity: $($reviewSummary.content.severity)"
+Write-Host "  Next step: $($reviewSummary.content.nextStep)"
+Write-Host "  Summary: $($reviewSummary.content.summary)"
 
-if (Test-HasValue $reviewSummary.fallback) {
-    Write-Host $reviewSummary.fallback
+if ($reviewSummary.status -eq "current" -and (Test-HasValue $reviewSummary.content.fallba
ck)) {
+    Write-Host $reviewSummary.content.fallback
 }

diff --git a/scripts/ai-dev-status.ps1 b/scripts/ai-dev-status.ps1
index 83046c60ec29bcad826a0d0baa1eee36c553b87e..9aa3d95c2f430bd6616da269af3c57396d258bd4
--- a/scripts/ai-dev-status.ps1
+++ b/scripts/ai-dev-status.ps1
@@ -76,13 +76,77 @@
     }
 }
 
+function Get-TestResultCurrentTaskId {
+    param(
+        [string[]]$Lines
+    )
+
+    $currentTaskLine = $Lines | Where-Object { $_ -match '^- Current task:\s*(.+)$' } | S
elect-Object -First 1
+
+    if ($currentTaskLine -match '^- Current task:\s*(.+)$') {
+        return $Matches[1].Trim()
+    }
+
+    return $null
+}
+
+function New-SummaryStatus {
+    param(
+        [string]$Status,
+        [string]$Reason,
+        [object]$Content
+    )
+
+    return [PSCustomObject]@{
+        status = $Status
+        reason = $Reason
+        content = $Content
+    }
+}
+
+function Get-TestResultSummary {
+    param(
+        [string]$Path,
+        [string]$CurrentTaskId,
+        [bool]$IsInitialState
+    )
+
+    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
+        return New-SummaryStatus "missing" "test-result 파일이 없습니다." "없음"
+    }
+
+    try {
+        $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)
+
+        if ($lines.Count -eq 0) {
+            return New-SummaryStatus "missing" "test-result 파일이 비어 있습니다." "없음"
+        }
+
+        $resultTaskId = Get-TestResultCurrentTaskId $lines
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 test-result 요약을 숨겼습니다." 
"숨김"
+        }
+
+        if ((Test-HasValue $CurrentTaskId) -and (Test-HasValue $resultTaskId) -and $resul
tTaskId -ne $CurrentTaskId) {
+            return New-SummaryStatus "stale" "test-result의 task($resultTaskId)가 현재 task($
CurrentTaskId)와 다릅니다." "숨김"
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." (($lines | Select-Object -Last
 30) -join "`r`n")
+    } catch {
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" "읽기 실패: $($_.Ex
ception.Message)"
+    }
+}
+
 function Get-ReviewSummary {
     param(
-        [string]$Path
+        [string]$Path,
+        [string]$LastReviewDecision,
+        [bool]$IsInitialState
     )
 
     if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
-        return [PSCustomObject]@{
+        $missingSummary = [PSCustomObject]@{
             available = $false
             decision = $null
             severity = $null
@@ -90,6 +154,8 @@
             summary = "없음"
             fallback = $null
         }
+
+        return New-SummaryStatus "missing" "review 파일이 없습니다." $missingSummary
     }
 
     try {
@@ -105,7 +171,7 @@
         $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } 
else { $null }
         $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or 
(Test-HasValue $nextStep) -or (Test-HasValue $summary)
 
-        return [PSCustomObject]@{
+        $review = [PSCustomObject]@{
             available = $true
             decision = $decision
             severity = $severity
@@ -113,8 +179,22 @@
             summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
             fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object 
-Last 30) -join "`r`n") }
         }
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." $revi
ew
+        }
+
+        if ((Test-HasValue $LastReviewDecision) -and $LastReviewDecision -ne "not_started
" -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
+            return New-SummaryStatus "stale" "review decision($decision)이 state lastRevie
wDecision($LastReviewDecision)와 다릅니다." $review
+        }
+
+        if (-not (Test-HasValue $LastReviewDecision) -or $LastReviewDecision -eq "not_sta
rted") {
+            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 
요약을 숨겼습니다." $review
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." $review
     } catch {
-        return [PSCustomObject]@{
+        $errorSummary = [PSCustomObject]@{
             available = $true
             decision = $null
             severity = $null
@@ -122,6 +202,8 @@
             summary = "읽기 실패: $($_.Exception.Message)"
             fallback = $null
         }
+
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" $errorSummary
     }
 }
 
@@ -182,6 +264,16 @@
     skipped = @($tasks | Where-Object { $_.status -eq "skipped" }).Count
 }
 
+$currentTaskStatus = if ($null -ne $currentTask) { [string]$currentTask.status } else { $
null }
+$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastCom
mandStatus } else { $null }
+$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastR
eviewDecision } else { $null }
+$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { $
null }
+$initialTaskStatuses = @("not_started", "pending")
+$isInitialState = ($initialTaskStatuses -contains $currentTaskStatus) -or `
+    ($goalStatus -eq "not_started") -or `
+    (-not (Test-HasValue $state.lastCommand) -and ($lastCommandStatus -eq "not_started" -
or -not (Test-HasValue $lastCommandStatus))) -or `
+    ($lastReviewDecision -eq "not_started")
+
 $gitStatus = "unavailable"
 $gitChangedFilesCount = $null
 $gitStatusLines = @()
@@ -202,8 +294,8 @@
     $gitStatus = "unavailable"
 }
 
-$testResultSummary = Get-LastLines $testResultPath 30
-$reviewSummary = Get-ReviewSummary $reviewPath
+$testResultSummary = Get-TestResultSummary $testResultPath $currentTaskId $isInitialState
+$reviewSummary = Get-ReviewSummary $reviewPath $lastReviewDecision $isInitialState
 
 $statusObject = [ordered]@{
     goalTitle = if (Test-HasValue $queue.goalTitle) { $queue.goalTitle } else { "없음" }
@@ -256,14 +348,18 @@
 Write-Host "Git changed files count: $($statusObject.git.changedFilesCount)"
 Write-Host ""
 Write-Host "Test result summary:"
-Write-Host $statusObject.testResultSummary
+Write-Host "  Status: $($testResultSummary.status)"
+Write-Host "  Reason: $($testResultSummary.reason)"
+Write-Host $testResultSummary.content
 Write-Host ""
 Write-Host "Review summary:"
-Write-Host "  Decision: $($reviewSummary.decision)"
-Write-Host "  Severity: $($reviewSummary.severity)"
-Write-Host "  Next step: $($reviewSummary.nextStep)"
-Write-Host "  Summary: $($reviewSummary.summary)"
+Write-Host "  Status: $($reviewSummary.status)"
+Write-Host "  Reason: $($reviewSummary.reason)"
+Write-Host "  Decision: $($reviewSummary.content.decision)"
+Write-Host "  Severity: $($reviewSummary.content.severity)"
+Write-Host "  Next step: $($reviewSummary.content.nextStep)"
+Write-Host "  Summary: $($reviewSummary.content.summary)"
 
-if (Test-HasValue $reviewSummary.fallback) {
-    Write-Host $reviewSummary.fallback
+if ($reviewSummary.status -eq "current" -and (Test-HasValue $reviewSummary.content.fallba
ck)) {
+    Write-Host $reviewSummary.content.fallback
 }

codex
패치를 적용했습니다. 이제 변경된 함수와 출력부를 읽어 PowerShell 문법과 출력 구조가 의도대로 이어지는지 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-status.ps1' | Select-Object -Firs
t 260" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -Li
teralPath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-status.ps1' | Select-Object -Last
 120" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -
LiteralPath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-status.ps1' -Pattern 'function 
Get-TestResultSummary','function Get-ReviewSummary','isInitialState','Test result summary'
,'Review summary' -Context 3,8" in D:\ai-apps\planpilot-local
 succeeded in 2284ms:
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

function Get-TestResultCurrentTaskId {
    param(
        [string[]]$Lines
    )

    $currentTaskLine = $Lines | Where-Object { $_ -match '^- Current task:\s*(.+)$' } | Se
lect-Object -First 1

    if ($currentTaskLine -match '^- Current task:\s*(.+)$') {
        return $Matches[1].Trim()
    }

    return $null
}

function New-SummaryStatus {
    param(
        [string]$Status,
        [string]$Reason,
        [object]$Content
    )

    return [PSCustomObject]@{
        status = $Status
        reason = $Reason
        content = $Content
    }
}

function Get-TestResultSummary {
    param(
        [string]$Path,
        [string]$CurrentTaskId,
        [bool]$IsInitialState
    )

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        return New-SummaryStatus "missing" "test-result 파일이 없습니다." "없음"
    }

    try {
        $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)

        if ($lines.Count -eq 0) {
            return New-SummaryStatus "missing" "test-result 파일이 비어 있습니다." "없음"
        }

        $resultTaskId = Get-TestResultCurrentTaskId $lines

        if ($IsInitialState) {
            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 test-result 요약을 숨겼습니다." "
숨김"
        }

        if ((Test-HasValue $CurrentTaskId) -and (Test-HasValue $resultTaskId) -and $result
TaskId -ne $CurrentTaskId) {
            return New-SummaryStatus "stale" "test-result의 task($resultTaskId)가 현재 task($C
urrentTaskId)와 다릅니다." "숨김"
        }

        return New-SummaryStatus "current" "현재 상태와 일치합니다." (($lines | Select-Object -Last 
30) -join "`r`n")
    } catch {
        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" "읽기 실패: $($_.Exc
eption.Message)"
    }
}

function Get-ReviewSummary {
    param(
        [string]$Path,
        [string]$LastReviewDecision,
        [bool]$IsInitialState
    )

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        $missingSummary = [PSCustomObject]@{
            available = $false
            decision = $null
            severity = $null
            nextStep = $null
            summary = "없음"
            fallback = $null
        }

        return New-SummaryStatus "missing" "review 파일이 없습니다." $missingSummary
    }

    try {
        $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)
        $decisionLine = $lines | Where-Object { $_ -match '^- Decision:\s*(.+)$' } | Selec
t-Object -First 1
        $severityLine = $lines | Where-Object { $_ -match '^- Severity:\s*(.+)$' } | Selec
t-Object -First 1
        $nextStepLine = $lines | Where-Object { $_ -match '^- Next step:\s*(.+)$' } | Sele
ct-Object -First 1
        $summaryLine = $lines | Where-Object { $_ -match '^- Summary:\s*(.+)$' } | Select-
Object -First 1

        $decision = if ($decisionLine -match '^- Decision:\s*(.+)$') { $Matches[1].Trim() 
} else { $null }
        $severity = if ($severityLine -match '^- Severity:\s*(.+)$') { $Matches[1].Trim() 
} else { $null }
        $nextStep = if ($nextStepLine -match '^- Next step:\s*(.+)$') { $Matches[1].Trim()
 } else { $null }
        $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } e
lse { $null }
        $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or (
Test-HasValue $nextStep) -or (Test-HasValue $summary)

        $review = [PSCustomObject]@{
            available = $true
            decision = $decision
            severity = $severity
            nextStep = $nextStep
            summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
            fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object -
Last 30) -join "`r`n") }
        }

        if ($IsInitialState) {
            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." $revie
w
        }

        if ((Test-HasValue $LastReviewDecision) -and $LastReviewDecision -ne "not_started"
 -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
            return New-SummaryStatus "stale" "review decision($decision)이 state lastReview
Decision($LastReviewDecision)와 다릅니다." $review
        }

        if (-not (Test-HasValue $LastReviewDecision) -or $LastReviewDecision -eq "not_star
ted") {
            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 요
약을 숨겼습니다." $review
        }

        return New-SummaryStatus "current" "현재 상태와 일치합니다." $review
    } catch {
        $errorSummary = [PSCustomObject]@{
            available = $true
            decision = $null
            severity = $null
            nextStep = $null
            summary = "읽기 실패: $($_.Exception.Message)"
            fallback = $null
        }

        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" $errorSummary
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
    $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-Objec
t -First 1

    if ($null -ne $inProgressTask) {
        $currentTaskId = [string]$inProgressTask.id
    } else {
        $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Object -
First 1

        if ($null -ne $pendingTask) {
            $currentTaskId = [string]$pendingTask.id
        }
    }
}

$currentTask = $null

if (Test-HasValue $currentTaskId) {
    $currentTask = $tasks | Where-Object { $_.id -eq $currentTaskId } | Select-Object -Fir
st 1
}

$taskCounts = [ordered]@{
    total = $tasks.Count
    pending = @($tasks | Where-Object { $_.status -eq "pending" }).Count
    in_progress = @($tasks | Where-Object { $_.status -eq "in_progress" }).Count
    review_required = @($tasks | Where-Object { $_.status -eq "review_required" }).Count

 succeeded in 2325ms:
        }
    }
}

$currentTask = $null

if (Test-HasValue $currentTaskId) {
    $currentTask = $tasks | Where-Object { $_.id -eq $currentTaskId } | Select-Object -Fir
st 1
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

$currentTaskStatus = if ($null -ne $currentTask) { [string]$currentTask.status } else { $n
ull }
$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastComm
andStatus } else { $null }
$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastRe
viewDecision } else { $null }
$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { $n
ull }
$initialTaskStatuses = @("not_started", "pending")
$isInitialState = ($initialTaskStatuses -contains $currentTaskStatus) -or `
    ($goalStatus -eq "not_started") -or `
    (-not (Test-HasValue $state.lastCommand) -and ($lastCommandStatus -eq "not_started" -o
r -not (Test-HasValue $lastCommandStatus))) -or `
    ($lastReviewDecision -eq "not_started")

$gitStatus = "unavailable"
$gitChangedFilesCount = $null
$gitStatusLines = @()

try {
    $null = & git rev-parse --show-toplevel 2>&1

    if ($LASTEXITCODE -eq 0) {
        $gitOutput = & git status --short 2>&1 | Out-String

        if ($LASTEXITCODE -eq 0) {
            $gitStatusLines = @($gitOutput -split "`r?`n" | Where-Object { -not [string]::
IsNullOrWhiteSpace($_) })
            $gitChangedFilesCount = $gitStatusLines.Count
            $gitStatus = "available"
        }
    }
} catch {
    $gitStatus = "unavailable"
}

$testResultSummary = Get-TestResultSummary $testResultPath $currentTaskId $isInitialState
$reviewSummary = Get-ReviewSummary $reviewPath $lastReviewDecision $isInitialState

$statusObject = [ordered]@{
    goalTitle = if (Test-HasValue $queue.goalTitle) { $queue.goalTitle } else { "없음" }
    goalStatus = if (Test-HasValue $state.goalStatus) { $state.goalStatus } else { "없음" }
    currentTask = [ordered]@{
        id = if ($null -ne $currentTask) { $currentTask.id } elseif (Test-HasValue $curren
tTaskId) { $currentTaskId } else { $null }
        title = if ($null -ne $currentTask) { $currentTask.title } else { "없음" }
        status = if ($null -ne $currentTask) { $currentTask.status } else { "없음" }
        type = if ($null -ne $currentTask) { $currentTask.type } else { "없음" }
        priority = if ($null -ne $currentTask) { $currentTask.priority } else { "없음" }
    }
    taskProgress = "$($taskCounts.done)/$($taskCounts.total)"
    taskCounts = $taskCounts
    lastCommand = if (Test-HasValue $state.lastCommand) { $state.lastCommand } else { "없음"
 }
    lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { $state.lastCommandSt
atus } else { "없음" }
    lastErrorSummary = if (Test-HasValue $state.lastErrorSummary) { $state.lastErrorSummar
y } else { "없음" }
    lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { $state.lastReviewD
ecision } else { "없음" }
    lastReviewSeverity = if (Test-HasValue $state.lastReviewSeverity) { $state.lastReviewS
everity } else { "없음" }
    lastCommitHash = if (Test-HasValue $state.lastCommitHash) { $state.lastCommitHash } el
se { "없음" }
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
Write-Host "Task counts: pending=$($taskCounts.pending), in_progress=$($taskCounts.in_prog
ress), review_required=$($taskCounts.review_required), done=$($taskCounts.done), failed=$(
$taskCounts.failed), blocked=$($taskCounts.blocked), skipped=$($taskCounts.skipped), total
=$($taskCounts.total)"
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
Write-Host "  Status: $($testResultSummary.status)"
Write-Host "  Reason: $($testResultSummary.reason)"
Write-Host $testResultSummary.content
Write-Host ""
Write-Host "Review summary:"
Write-Host "  Status: $($reviewSummary.status)"
Write-Host "  Reason: $($reviewSummary.reason)"
Write-Host "  Decision: $($reviewSummary.content.decision)"
Write-Host "  Severity: $($reviewSummary.content.severity)"
Write-Host "  Next step: $($reviewSummary.content.nextStep)"
Write-Host "  Summary: $($reviewSummary.content.summary)"

if ($reviewSummary.status -eq "current" -and (Test-HasValue $reviewSummary.content.fallbac
k)) {
    Write-Host $reviewSummary.content.fallback
}

 succeeded in 2360ms:

  scripts\ai-dev-status.ps1:104:    }
  scripts\ai-dev-status.ps1:105:}
  scripts\ai-dev-status.ps1:106:
> scripts\ai-dev-status.ps1:107:function Get-TestResultSummary {
  scripts\ai-dev-status.ps1:108:    param(
  scripts\ai-dev-status.ps1:109:        [string]$Path,
  scripts\ai-dev-status.ps1:110:        [string]$CurrentTaskId,
> scripts\ai-dev-status.ps1:111:        [bool]$IsInitialState
  scripts\ai-dev-status.ps1:112:    )
  scripts\ai-dev-status.ps1:113:
  scripts\ai-dev-status.ps1:114:    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)
) {
  scripts\ai-dev-status.ps1:115:        return New-SummaryStatus "missing" "test-result 파일
이 없습니다." "없음"
  scripts\ai-dev-status.ps1:116:    }
  scripts\ai-dev-status.ps1:117:
  scripts\ai-dev-status.ps1:118:    try {
  scripts\ai-dev-status.ps1:119:        $lines = @(Get-Content -Encoding UTF8 -LiteralPath
 $Path)
  scripts\ai-dev-status.ps1:124:
  scripts\ai-dev-status.ps1:125:        $resultTaskId = Get-TestResultCurrentTaskId $lines
  scripts\ai-dev-status.ps1:126:
> scripts\ai-dev-status.ps1:127:        if ($IsInitialState) {
  scripts\ai-dev-status.ps1:128:            return New-SummaryStatus "stale" "현재 task가 초기 
상태라 이전 test-result 요약을 숨겼습니다.
" "숨김"
  scripts\ai-dev-status.ps1:129:        }
  scripts\ai-dev-status.ps1:130:
  scripts\ai-dev-status.ps1:131:        if ((Test-HasValue $CurrentTaskId) -and (Test-HasV
alue $resultTaskId) -and $res
ultTaskId -ne $CurrentTaskId) {
  scripts\ai-dev-status.ps1:132:            return New-SummaryStatus "stale" "test-result의
 task($resultTaskId)가 현재 task
($CurrentTaskId)와 다릅니다." "숨김"
  scripts\ai-dev-status.ps1:133:        }
  scripts\ai-dev-status.ps1:134:
  scripts\ai-dev-status.ps1:135:        return New-SummaryStatus "current" "현재 상태와 일치합니다."
 (($lines | Select-Object -La
st 30) -join "`r`n")
  scripts\ai-dev-status.ps1:138:    }
  scripts\ai-dev-status.ps1:139:}
  scripts\ai-dev-status.ps1:140:
> scripts\ai-dev-status.ps1:141:function Get-ReviewSummary {
  scripts\ai-dev-status.ps1:142:    param(
  scripts\ai-dev-status.ps1:143:        [string]$Path,
  scripts\ai-dev-status.ps1:144:        [string]$LastReviewDecision,
> scripts\ai-dev-status.ps1:145:        [bool]$IsInitialState
  scripts\ai-dev-status.ps1:146:    )
  scripts\ai-dev-status.ps1:147:
  scripts\ai-dev-status.ps1:148:    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)
) {
  scripts\ai-dev-status.ps1:149:        $missingSummary = [PSCustomObject]@{
  scripts\ai-dev-status.ps1:150:            available = $false
  scripts\ai-dev-status.ps1:151:            decision = $null
  scripts\ai-dev-status.ps1:152:            severity = $null
  scripts\ai-dev-status.ps1:153:            nextStep = $null
  scripts\ai-dev-status.ps1:180:            fallback = if ($hasStandardFields) { $null } e
lse { (($lines | Select-Objec
t -Last 30) -join "`r`n") }
  scripts\ai-dev-status.ps1:181:        }
  scripts\ai-dev-status.ps1:182:
> scripts\ai-dev-status.ps1:183:        if ($IsInitialState) {
  scripts\ai-dev-status.ps1:184:            return New-SummaryStatus "stale" "현재 task가 초기 
상태라 이전 review 요약을 숨겼습니다." $re
view
  scripts\ai-dev-status.ps1:185:        }
  scripts\ai-dev-status.ps1:186:
  scripts\ai-dev-status.ps1:187:        if ((Test-HasValue $LastReviewDecision) -and $Last
ReviewDecision -ne "not_start
ed" -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
  scripts\ai-dev-status.ps1:188:            return New-SummaryStatus "stale" "review decis
ion($decision)이 state lastRev
iewDecision($LastReviewDecision)와 다릅니다." $review
  scripts\ai-dev-status.ps1:189:        }
  scripts\ai-dev-status.ps1:190:
  scripts\ai-dev-status.ps1:191:        if (-not (Test-HasValue $LastReviewDecision) -or $
LastReviewDecision -eq "not_s
tarted") {
  scripts\ai-dev-status.ps1:269:$lastReviewDecision = if (Test-HasValue $state.lastReviewD
ecision) { [string]$state.las
tReviewDecision } else { $null }
  scripts\ai-dev-status.ps1:270:$goalStatus = if (Test-HasValue $state.goalStatus) { [stri
ng]$state.goalStatus } else {
 $null }
  scripts\ai-dev-status.ps1:271:$initialTaskStatuses = @("not_started", "pending")
> scripts\ai-dev-status.ps1:272:$isInitialState = ($initialTaskStatuses -contains $current
TaskStatus) -or `
  scripts\ai-dev-status.ps1:273:    ($goalStatus -eq "not_started") -or `
  scripts\ai-dev-status.ps1:274:    (-not (Test-HasValue $state.lastCommand) -and ($lastCo
mmandStatus -eq "not_started"
 -or -not (Test-HasValue $lastCommandStatus))) -or `
  scripts\ai-dev-status.ps1:275:    ($lastReviewDecision -eq "not_started")
  scripts\ai-dev-status.ps1:276:
  scripts\ai-dev-status.ps1:277:$gitStatus = "unavailable"
  scripts\ai-dev-status.ps1:278:$gitChangedFilesCount = $null
  scripts\ai-dev-status.ps1:279:$gitStatusLines = @()
  scripts\ai-dev-status.ps1:280:
  scripts\ai-dev-status.ps1:294:    $gitStatus = "unavailable"
  scripts\ai-dev-status.ps1:295:}
  scripts\ai-dev-status.ps1:296:
> scripts\ai-dev-status.ps1:297:$testResultSummary = Get-TestResultSummary $testResultPath
 $currentTaskId $isInitialSta
te
> scripts\ai-dev-status.ps1:298:$reviewSummary = Get-ReviewSummary $reviewPath $lastReview
Decision $isInitialState
  scripts\ai-dev-status.ps1:299:
  scripts\ai-dev-status.ps1:300:$statusObject = [ordered]@{
  scripts\ai-dev-status.ps1:301:    goalTitle = if (Test-HasValue $queue.goalTitle) { $que
ue.goalTitle } else { "없음" }
  scripts\ai-dev-status.ps1:302:    goalStatus = if (Test-HasValue $state.goalStatus) { $s
tate.goalStatus } else { "없음"
 }
  scripts\ai-dev-status.ps1:303:    currentTask = [ordered]@{
  scripts\ai-dev-status.ps1:304:        id = if ($null -ne $currentTask) { $currentTask.id
 } elseif (Test-HasValue $cur
rentTaskId) { $currentTaskId } else { $null }
  scripts\ai-dev-status.ps1:305:        title = if ($null -ne $currentTask) { $currentTask
.title } else { "없음" }
  scripts\ai-dev-status.ps1:306:        status = if ($null -ne $currentTask) { $currentTas
k.status } else { "없음" }
  scripts\ai-dev-status.ps1:347:Write-Host "Git status: $($statusObject.git.status)"
  scripts\ai-dev-status.ps1:348:Write-Host "Git changed files count: $($statusObject.git.c
hangedFilesCount)"
  scripts\ai-dev-status.ps1:349:Write-Host ""
> scripts\ai-dev-status.ps1:350:Write-Host "Test result summary:"
  scripts\ai-dev-status.ps1:351:Write-Host "  Status: $($testResultSummary.status)"
  scripts\ai-dev-status.ps1:352:Write-Host "  Reason: $($testResultSummary.reason)"
  scripts\ai-dev-status.ps1:353:Write-Host $testResultSummary.content
  scripts\ai-dev-status.ps1:354:Write-Host ""
> scripts\ai-dev-status.ps1:355:Write-Host "Review summary:"
  scripts\ai-dev-status.ps1:356:Write-Host "  Status: $($reviewSummary.status)"
  scripts\ai-dev-status.ps1:357:Write-Host "  Reason: $($reviewSummary.reason)"
  scripts\ai-dev-status.ps1:358:Write-Host "  Decision: $($reviewSummary.content.decision)
"
  scripts\ai-dev-status.ps1:359:Write-Host "  Severity: $($reviewSummary.content.severity)
"
  scripts\ai-dev-status.ps1:360:Write-Host "  Next step: $($reviewSummary.content.nextStep
)"
  scripts\ai-dev-status.ps1:361:Write-Host "  Summary: $($reviewSummary.content.summary)"
  scripts\ai-dev-status.ps1:362:
  scripts\ai-dev-status.ps1:363:if ($reviewSummary.status -eq "current" -and (Test-HasValu
e $reviewSummary.content.fall
back)) {



diff --git a/scripts/ai-dev-status.ps1 b/scripts/ai-dev-status.ps1
index 83046c60ec29bcad826a0d0baa1eee36c553b87e..9aa3d95c2f430bd6616da269af3c57396d258bd4
--- a/scripts/ai-dev-status.ps1
+++ b/scripts/ai-dev-status.ps1
@@ -76,13 +76,77 @@
     }
 }
 
+function Get-TestResultCurrentTaskId {
+    param(
+        [string[]]$Lines
+    )
+
+    $currentTaskLine = $Lines | Where-Object { $_ -match '^- Current task:\s*(.+)$' } | S
elect-Object -First 1
+
+    if ($currentTaskLine -match '^- Current task:\s*(.+)$') {
+        return $Matches[1].Trim()
+    }
+
+    return $null
+}
+
+function New-SummaryStatus {
+    param(
+        [string]$Status,
+        [string]$Reason,
+        [object]$Content
+    )
+
+    return [PSCustomObject]@{
+        status = $Status
+        reason = $Reason
+        content = $Content
+    }
+}
+
+function Get-TestResultSummary {
+    param(
+        [string]$Path,
+        [string]$CurrentTaskId,
+        [bool]$IsInitialState
+    )
+
+    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
+        return New-SummaryStatus "missing" "test-result 파일이 없습니다." "없음"
+    }
+
+    try {
+        $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)
+
+        if ($lines.Count -eq 0) {
+            return New-SummaryStatus "missing" "test-result 파일이 비어 있습니다." "없음"
+        }
+
+        $resultTaskId = Get-TestResultCurrentTaskId $lines
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 test-result 요약을 숨겼습니다." 
"숨김"
+        }
+
+        if ((Test-HasValue $CurrentTaskId) -and (Test-HasValue $resultTaskId) -and $resul
tTaskId -ne $CurrentTaskId) {
+            return New-SummaryStatus "stale" "test-result의 task($resultTaskId)가 현재 task($
CurrentTaskId)와 다릅니다." "숨김"
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." (($lines | Select-Object -Last
 30) -join "`r`n")
+    } catch {
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" "읽기 실패: $($_.Ex
ception.Message)"
+    }
+}
+
 function Get-ReviewSummary {
     param(
-        [string]$Path
+        [string]$Path,
+        [string]$LastReviewDecision,
+        [bool]$IsInitialState
     )
 
     if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
-        return [PSCustomObject]@{
+        $missingSummary = [PSCustomObject]@{
             available = $false
             decision = $null
             severity = $null
@@ -90,6 +154,8 @@
             summary = "없음"
             fallback = $null
         }
+
+        return New-SummaryStatus "missing" "review 파일이 없습니다." $missingSummary
     }
 
     try {
@@ -105,7 +171,7 @@
         $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } 
else { $null }
         $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or 
(Test-HasValue $nextStep) -or (Test-HasValue $summary)
 
-        return [PSCustomObject]@{
+        $review = [PSCustomObject]@{
             available = $true
             decision = $decision
             severity = $severity
@@ -113,8 +179,22 @@
             summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
             fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object 
-Last 30) -join "`r`n") }
         }
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." $revi
ew
+        }
+
+        if ((Test-HasValue $LastReviewDecision) -and $LastReviewDecision -ne "not_started
" -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
+            return New-SummaryStatus "stale" "review decision($decision)이 state lastRevie
wDecision($LastReviewDecision)와 다릅니다." $review
+        }
+
+        if (-not (Test-HasValue $LastReviewDecision) -or $LastReviewDecision -eq "not_sta
rted") {
+            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 
요약을 숨겼습니다." $review
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." $review
     } catch {
-        return [PSCustomObject]@{
+        $errorSummary = [PSCustomObject]@{
             available = $true
             decision = $null
             severity = $null
@@ -122,6 +202,8 @@
             summary = "읽기 실패: $($_.Exception.Message)"
             fallback = $null
         }
+
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" $errorSummary
     }
 }
 
@@ -182,6 +264,16 @@
     skipped = @($tasks | Where-Object { $_.status -eq "skipped" }).Count
 }
 
+$currentTaskStatus = if ($null -ne $currentTask) { [string]$currentTask.status } else { $
null }
+$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastCom
mandStatus } else { $null }
+$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastR
eviewDecision } else { $null }
+$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { $
null }
+$initialTaskStatuses = @("not_started", "pending")
+$isInitialState = ($initialTaskStatuses -contains $currentTaskStatus) -or `
+    ($goalStatus -eq "not_started") -or `
+    (-not (Test-HasValue $state.lastCommand) -and ($lastCommandStatus -eq "not_started" -
or -not (Test-HasValue $lastCommandStatus))) -or `
+    ($lastReviewDecision -eq "not_started")
+
 $gitStatus = "unavailable"
 $gitChangedFilesCount = $null
 $gitStatusLines = @()
@@ -202,8 +294,8 @@
     $gitStatus = "unavailable"
 }
 
-$testResultSummary = Get-LastLines $testResultPath 30
-$reviewSummary = Get-ReviewSummary $reviewPath
+$testResultSummary = Get-TestResultSummary $testResultPath $currentTaskId $isInitialState
+$reviewSummary = Get-ReviewSummary $reviewPath $lastReviewDecision $isInitialState
 
 $statusObject = [ordered]@{
     goalTitle = if (Test-HasValue $queue.goalTitle) { $queue.goalTitle } else { "없음" }
@@ -256,14 +348,18 @@
 Write-Host "Git changed files count: $($statusObject.git.changedFilesCount)"
 Write-Host ""
 Write-Host "Test result summary:"
-Write-Host $statusObject.testResultSummary
+Write-Host "  Status: $($testResultSummary.status)"
+Write-Host "  Reason: $($testResultSummary.reason)"
+Write-Host $testResultSummary.content
 Write-Host ""
 Write-Host "Review summary:"
-Write-Host "  Decision: $($reviewSummary.decision)"
-Write-Host "  Severity: $($reviewSummary.severity)"
-Write-Host "  Next step: $($reviewSummary.nextStep)"
-Write-Host "  Summary: $($reviewSummary.summary)"
+Write-Host "  Status: $($reviewSummary.status)"
+Write-Host "  Reason: $($reviewSummary.reason)"
+Write-Host "  Decision: $($reviewSummary.content.decision)"
+Write-Host "  Severity: $($reviewSummary.content.severity)"
+Write-Host "  Next step: $($reviewSummary.content.nextStep)"
+Write-Host "  Summary: $($reviewSummary.content.summary)"
 
-if (Test-HasValue $reviewSummary.fallback) {
-    Write-Host $reviewSummary.fallback
+if ($reviewSummary.status -eq "current" -and (Test-HasValue $reviewSummary.content.fallba
ck)) {
+    Write-Host $reviewSummary.content.fallback
 }

codex
검토 중 한 가지 과도한 조건을 발견했습니다. 리뷰가 아직 `not_started`인 정상 중간 상태에서도 현재 task의 테스트 결과까지 숨길 수 있어, 테스트
와 리뷰의 stale 판단을 분리해 조정합니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\scripts\ai-dev-status.ps1
diff --git a/scripts/ai-dev-status.ps1 b/scripts/ai-dev-status.ps1
index 83046c60ec29bcad826a0d0baa1eee36c553b87e..fc32599a0981496a62033a5fbdd569bcda2cc48b
--- a/scripts/ai-dev-status.ps1
+++ b/scripts/ai-dev-status.ps1
@@ -76,13 +76,77 @@
     }
 }
 
+function Get-TestResultCurrentTaskId {
+    param(
+        [string[]]$Lines
+    )
+
+    $currentTaskLine = $Lines | Where-Object { $_ -match '^- Current task:\s*(.+)$' } | S
elect-Object -First 1
+
+    if ($currentTaskLine -match '^- Current task:\s*(.+)$') {
+        return $Matches[1].Trim()
+    }
+
+    return $null
+}
+
+function New-SummaryStatus {
+    param(
+        [string]$Status,
+        [string]$Reason,
+        [object]$Content
+    )
+
+    return [PSCustomObject]@{
+        status = $Status
+        reason = $Reason
+        content = $Content
+    }
+}
+
+function Get-TestResultSummary {
+    param(
+        [string]$Path,
+        [string]$CurrentTaskId,
+        [bool]$IsInitialState
+    )
+
+    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
+        return New-SummaryStatus "missing" "test-result 파일이 없습니다." "없음"
+    }
+
+    try {
+        $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)
+
+        if ($lines.Count -eq 0) {
+            return New-SummaryStatus "missing" "test-result 파일이 비어 있습니다." "없음"
+        }
+
+        $resultTaskId = Get-TestResultCurrentTaskId $lines
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 test-result 요약을 숨겼습니다." 
"숨김"
+        }
+
+        if ((Test-HasValue $CurrentTaskId) -and (Test-HasValue $resultTaskId) -and $resul
tTaskId -ne $CurrentTaskId) {
+            return New-SummaryStatus "stale" "test-result의 task($resultTaskId)가 현재 task($
CurrentTaskId)와 다릅니다." "숨김"
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." (($lines | Select-Object -Last
 30) -join "`r`n")
+    } catch {
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" "읽기 실패: $($_.Ex
ception.Message)"
+    }
+}
+
 function Get-ReviewSummary {
     param(
-        [string]$Path
+        [string]$Path,
+        [string]$LastReviewDecision,
+        [bool]$IsInitialState
     )
 
     if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
-        return [PSCustomObject]@{
+        $missingSummary = [PSCustomObject]@{
             available = $false
             decision = $null
             severity = $null
@@ -90,6 +154,8 @@
             summary = "없음"
             fallback = $null
         }
+
+        return New-SummaryStatus "missing" "review 파일이 없습니다." $missingSummary
     }
 
     try {
@@ -105,7 +171,7 @@
         $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } 
else { $null }
         $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or 
(Test-HasValue $nextStep) -or (Test-HasValue $summary)
 
-        return [PSCustomObject]@{
+        $review = [PSCustomObject]@{
             available = $true
             decision = $decision
             severity = $severity
@@ -113,8 +179,22 @@
             summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
             fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object 
-Last 30) -join "`r`n") }
         }
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." $revi
ew
+        }
+
+        if ((Test-HasValue $LastReviewDecision) -and $LastReviewDecision -ne "not_started
" -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
+            return New-SummaryStatus "stale" "review decision($decision)이 state lastRevie
wDecision($LastReviewDecision)와 다릅니다." $review
+        }
+
+        if (-not (Test-HasValue $LastReviewDecision) -or $LastReviewDecision -eq "not_sta
rted") {
+            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 
요약을 숨겼습니다." $review
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." $review
     } catch {
-        return [PSCustomObject]@{
+        $errorSummary = [PSCustomObject]@{
             available = $true
             decision = $null
             severity = $null
@@ -122,6 +202,8 @@
             summary = "읽기 실패: $($_.Exception.Message)"
             fallback = $null
         }
+
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" $errorSummary
     }
 }
 
@@ -182,6 +264,17 @@
     skipped = @($tasks | Where-Object { $_.status -eq "skipped" }).Count
 }
 
+$currentTaskStatus = if ($null -ne $currentTask) { [string]$currentTask.status } else { $
null }
+$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastCom
mandStatus } else { $null }
+$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastR
eviewDecision } else { $null }
+$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { $
null }
+$initialTaskStatuses = @("not_started", "pending")
+$isTaskInitialState = ($initialTaskStatuses -contains $currentTaskStatus) -or ($goalStatu
s -eq "not_started")
+$isTestResultInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $state.lastCommand) -and ($lastCommandStatus -eq "not_started" -
or -not (Test-HasValue $lastCommandStatus)))
+$isReviewInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $lastReviewDecision) -or $lastReviewDecision -eq "not_started")
+
 $gitStatus = "unavailable"
 $gitChangedFilesCount = $null
 $gitStatusLines = @()
@@ -202,8 +295,8 @@
     $gitStatus = "unavailable"
 }
 
-$testResultSummary = Get-LastLines $testResultPath 30
-$reviewSummary = Get-ReviewSummary $reviewPath
+$testResultSummary = Get-TestResultSummary $testResultPath $currentTaskId $isTestResultIn
itialState
+$reviewSummary = Get-ReviewSummary $reviewPath $lastReviewDecision $isReviewInitialState
 
 $statusObject = [ordered]@{
     goalTitle = if (Test-HasValue $queue.goalTitle) { $queue.goalTitle } else { "없음" }
@@ -256,14 +349,18 @@
 Write-Host "Git changed files count: $($statusObject.git.changedFilesCount)"
 Write-Host ""
 Write-Host "Test result summary:"
-Write-Host $statusObject.testResultSummary
+Write-Host "  Status: $($testResultSummary.status)"
+Write-Host "  Reason: $($testResultSummary.reason)"
+Write-Host $testResultSummary.content
 Write-Host ""
 Write-Host "Review summary:"
-Write-Host "  Decision: $($reviewSummary.decision)"
-Write-Host "  Severity: $($reviewSummary.severity)"
-Write-Host "  Next step: $($reviewSummary.nextStep)"
-Write-Host "  Summary: $($reviewSummary.summary)"
+Write-Host "  Status: $($reviewSummary.status)"
+Write-Host "  Reason: $($reviewSummary.reason)"
+Write-Host "  Decision: $($reviewSummary.content.decision)"
+Write-Host "  Severity: $($reviewSummary.content.severity)"
+Write-Host "  Next step: $($reviewSummary.content.nextStep)"
+Write-Host "  Summary: $($reviewSummary.content.summary)"
 
-if (Test-HasValue $reviewSummary.fallback) {
-    Write-Host $reviewSummary.fallback
+if ($reviewSummary.status -eq "current" -and (Test-HasValue $reviewSummary.content.fallba
ck)) {
+    Write-Host $reviewSummary.content.fallback
 }

diff --git a/scripts/ai-dev-status.ps1 b/scripts/ai-dev-status.ps1
index 83046c60ec29bcad826a0d0baa1eee36c553b87e..fc32599a0981496a62033a5fbdd569bcda2cc48b
--- a/scripts/ai-dev-status.ps1
+++ b/scripts/ai-dev-status.ps1
@@ -76,13 +76,77 @@
     }
 }
 
+function Get-TestResultCurrentTaskId {
+    param(
+        [string[]]$Lines
+    )
+
+    $currentTaskLine = $Lines | Where-Object { $_ -match '^- Current task:\s*(.+)$' } | S
elect-Object -First 1
+
+    if ($currentTaskLine -match '^- Current task:\s*(.+)$') {
+        return $Matches[1].Trim()
+    }
+
+    return $null
+}
+
+function New-SummaryStatus {
+    param(
+        [string]$Status,
+        [string]$Reason,
+        [object]$Content
+    )
+
+    return [PSCustomObject]@{
+        status = $Status
+        reason = $Reason
+        content = $Content
+    }
+}
+
+function Get-TestResultSummary {
+    param(
+        [string]$Path,
+        [string]$CurrentTaskId,
+        [bool]$IsInitialState
+    )
+
+    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
+        return New-SummaryStatus "missing" "test-result 파일이 없습니다." "없음"
+    }
+
+    try {
+        $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)
+
+        if ($lines.Count -eq 0) {
+            return New-SummaryStatus "missing" "test-result 파일이 비어 있습니다." "없음"
+        }
+
+        $resultTaskId = Get-TestResultCurrentTaskId $lines
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 test-result 요약을 숨겼습니다." 
"숨김"
+        }
+
+        if ((Test-HasValue $CurrentTaskId) -and (Test-HasValue $resultTaskId) -and $resul
tTaskId -ne $CurrentTaskId) {
+            return New-SummaryStatus "stale" "test-result의 task($resultTaskId)가 현재 task($
CurrentTaskId)와 다릅니다." "숨김"
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." (($lines | Select-Object -Last
 30) -join "`r`n")
+    } catch {
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" "읽기 실패: $($_.Ex
ception.Message)"
+    }
+}
+
 function Get-ReviewSummary {
     param(
-        [string]$Path
+        [string]$Path,
+        [string]$LastReviewDecision,
+        [bool]$IsInitialState
     )
 
     if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
-        return [PSCustomObject]@{
+        $missingSummary = [PSCustomObject]@{
             available = $false
             decision = $null
             severity = $null
@@ -90,6 +154,8 @@
             summary = "없음"
             fallback = $null
         }
+
+        return New-SummaryStatus "missing" "review 파일이 없습니다." $missingSummary
     }
 
     try {
@@ -105,7 +171,7 @@
         $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } 
else { $null }
         $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or 
(Test-HasValue $nextStep) -or (Test-HasValue $summary)
 
-        return [PSCustomObject]@{
+        $review = [PSCustomObject]@{
             available = $true
             decision = $decision
             severity = $severity
@@ -113,8 +179,22 @@
             summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
             fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object 
-Last 30) -join "`r`n") }
         }
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." $revi
ew
+        }
+
+        if ((Test-HasValue $LastReviewDecision) -and $LastReviewDecision -ne "not_started
" -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
+            return New-SummaryStatus "stale" "review decision($decision)이 state lastRevie
wDecision($LastReviewDecision)와 다릅니다." $review
+        }
+
+        if (-not (Test-HasValue $LastReviewDecision) -or $LastReviewDecision -eq "not_sta
rted") {
+            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 
요약을 숨겼습니다." $review
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." $review
     } catch {
-        return [PSCustomObject]@{
+        $errorSummary = [PSCustomObject]@{
             available = $true
             decision = $null
             severity = $null
@@ -122,6 +202,8 @@
             summary = "읽기 실패: $($_.Exception.Message)"
             fallback = $null
         }
+
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" $errorSummary
     }
 }
 
@@ -182,6 +264,17 @@
     skipped = @($tasks | Where-Object { $_.status -eq "skipped" }).Count
 }
 
+$currentTaskStatus = if ($null -ne $currentTask) { [string]$currentTask.status } else { $
null }
+$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastCom
mandStatus } else { $null }
+$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastR
eviewDecision } else { $null }
+$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { $
null }
+$initialTaskStatuses = @("not_started", "pending")
+$isTaskInitialState = ($initialTaskStatuses -contains $currentTaskStatus) -or ($goalStatu
s -eq "not_started")
+$isTestResultInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $state.lastCommand) -and ($lastCommandStatus -eq "not_started" -
or -not (Test-HasValue $lastCommandStatus)))
+$isReviewInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $lastReviewDecision) -or $lastReviewDecision -eq "not_started")
+
 $gitStatus = "unavailable"
 $gitChangedFilesCount = $null
 $gitStatusLines = @()
@@ -202,8 +295,8 @@
     $gitStatus = "unavailable"
 }
 
-$testResultSummary = Get-LastLines $testResultPath 30
-$reviewSummary = Get-ReviewSummary $reviewPath
+$testResultSummary = Get-TestResultSummary $testResultPath $currentTaskId $isTestResultIn
itialState
+$reviewSummary = Get-ReviewSummary $reviewPath $lastReviewDecision $isReviewInitialState
 
 $statusObject = [ordered]@{
     goalTitle = if (Test-HasValue $queue.goalTitle) { $queue.goalTitle } else { "없음" }
@@ -256,14 +349,18 @@
 Write-Host "Git changed files count: $($statusObject.git.changedFilesCount)"
 Write-Host ""
 Write-Host "Test result summary:"
-Write-Host $statusObject.testResultSummary
+Write-Host "  Status: $($testResultSummary.status)"
+Write-Host "  Reason: $($testResultSummary.reason)"
+Write-Host $testResultSummary.content
 Write-Host ""
 Write-Host "Review summary:"
-Write-Host "  Decision: $($reviewSummary.decision)"
-Write-Host "  Severity: $($reviewSummary.severity)"
-Write-Host "  Next step: $($reviewSummary.nextStep)"
-Write-Host "  Summary: $($reviewSummary.summary)"
+Write-Host "  Status: $($reviewSummary.status)"
+Write-Host "  Reason: $($reviewSummary.reason)"
+Write-Host "  Decision: $($reviewSummary.content.decision)"
+Write-Host "  Severity: $($reviewSummary.content.severity)"
+Write-Host "  Next step: $($reviewSummary.content.nextStep)"
+Write-Host "  Summary: $($reviewSummary.content.summary)"
 
-if (Test-HasValue $reviewSummary.fallback) {
-    Write-Host $reviewSummary.fallback
+if ($reviewSummary.status -eq "current" -and (Test-HasValue $reviewSummary.content.fallba
ck)) {
+    Write-Host $reviewSummary.content.fallback
 }

codex
조건을 분리했습니다. 실행 검증은 스크립트 내부가 `git status`를 호출하므로 AGENTS의 git 제한 때문에 하지 않고, PowerShell 파서로 문
법 오류만 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '$tokens = $null
; $errors = $null; [System.Management.Automation.Language.Parser]::ParseFile('"'D:\\ai-app
s\\planpilot-local\\scripts\\ai-dev-status.ps1', [ref]"'$tokens, [ref]$errors) > $null; if
 ($errors.Count -eq 0) { '"'Parse OK' } else { "'$errors | ForEach-Object { $_.Message } }
' in D:\ai-apps\planpilot-local
 succeeded in 1296ms:
Parse OK

diff --git a/scripts/ai-dev-status.ps1 b/scripts/ai-dev-status.ps1
index 83046c60ec29bcad826a0d0baa1eee36c553b87e..fc32599a0981496a62033a5fbdd569bcda2cc48b
--- a/scripts/ai-dev-status.ps1
+++ b/scripts/ai-dev-status.ps1
@@ -76,13 +76,77 @@
     }
 }
 
+function Get-TestResultCurrentTaskId {
+    param(
+        [string[]]$Lines
+    )
+
+    $currentTaskLine = $Lines | Where-Object { $_ -match '^- Current task:\s*(.+)$' } | S
elect-Object -First 1
+
+    if ($currentTaskLine -match '^- Current task:\s*(.+)$') {
+        return $Matches[1].Trim()
+    }
+
+    return $null
+}
+
+function New-SummaryStatus {
+    param(
+        [string]$Status,
+        [string]$Reason,
+        [object]$Content
+    )
+
+    return [PSCustomObject]@{
+        status = $Status
+        reason = $Reason
+        content = $Content
+    }
+}
+
+function Get-TestResultSummary {
+    param(
+        [string]$Path,
+        [string]$CurrentTaskId,
+        [bool]$IsInitialState
+    )
+
+    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
+        return New-SummaryStatus "missing" "test-result 파일이 없습니다." "없음"
+    }
+
+    try {
+        $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)
+
+        if ($lines.Count -eq 0) {
+            return New-SummaryStatus "missing" "test-result 파일이 비어 있습니다." "없음"
+        }
+
+        $resultTaskId = Get-TestResultCurrentTaskId $lines
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 test-result 요약을 숨겼습니다." 
"숨김"
+        }
+
+        if ((Test-HasValue $CurrentTaskId) -and (Test-HasValue $resultTaskId) -and $resul
tTaskId -ne $CurrentTaskId) {
+            return New-SummaryStatus "stale" "test-result의 task($resultTaskId)가 현재 task($
CurrentTaskId)와 다릅니다." "숨김"
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." (($lines | Select-Object -Last
 30) -join "`r`n")
+    } catch {
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" "읽기 실패: $($_.Ex
ception.Message)"
+    }
+}
+
 function Get-ReviewSummary {
     param(
-        [string]$Path
+        [string]$Path,
+        [string]$LastReviewDecision,
+        [bool]$IsInitialState
     )
 
     if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
-        return [PSCustomObject]@{
+        $missingSummary = [PSCustomObject]@{
             available = $false
             decision = $null
             severity = $null
@@ -90,6 +154,8 @@
             summary = "없음"
             fallback = $null
         }
+
+        return New-SummaryStatus "missing" "review 파일이 없습니다." $missingSummary
     }
 
     try {
@@ -105,7 +171,7 @@
         $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } 
else { $null }
         $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or 
(Test-HasValue $nextStep) -or (Test-HasValue $summary)
 
-        return [PSCustomObject]@{
+        $review = [PSCustomObject]@{
             available = $true
             decision = $decision
             severity = $severity
@@ -113,8 +179,22 @@
             summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
             fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object 
-Last 30) -join "`r`n") }
         }
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." $revi
ew
+        }
+
+        if ((Test-HasValue $LastReviewDecision) -and $LastReviewDecision -ne "not_started
" -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
+            return New-SummaryStatus "stale" "review decision($decision)이 state lastRevie
wDecision($LastReviewDecision)와 다릅니다." $review
+        }
+
+        if (-not (Test-HasValue $LastReviewDecision) -or $LastReviewDecision -eq "not_sta
rted") {
+            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 
요약을 숨겼습니다." $review
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." $review
     } catch {
-        return [PSCustomObject]@{
+        $errorSummary = [PSCustomObject]@{
             available = $true
             decision = $null
             severity = $null
@@ -122,6 +202,8 @@
             summary = "읽기 실패: $($_.Exception.Message)"
             fallback = $null
         }
+
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" $errorSummary
     }
 }
 
@@ -182,6 +264,17 @@
     skipped = @($tasks | Where-Object { $_.status -eq "skipped" }).Count
 }
 
+$currentTaskStatus = if ($null -ne $currentTask) { [string]$currentTask.status } else { $
null }
+$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastCom
mandStatus } else { $null }
+$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastR
eviewDecision } else { $null }
+$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { $
null }
+$initialTaskStatuses = @("not_started", "pending")
+$isTaskInitialState = ($initialTaskStatuses -contains $currentTaskStatus) -or ($goalStatu
s -eq "not_started")
+$isTestResultInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $state.lastCommand) -and ($lastCommandStatus -eq "not_started" -
or -not (Test-HasValue $lastCommandStatus)))
+$isReviewInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $lastReviewDecision) -or $lastReviewDecision -eq "not_started")
+
 $gitStatus = "unavailable"
 $gitChangedFilesCount = $null
 $gitStatusLines = @()
@@ -202,8 +295,8 @@
     $gitStatus = "unavailable"
 }
 
-$testResultSummary = Get-LastLines $testResultPath 30
-$reviewSummary = Get-ReviewSummary $reviewPath
+$testResultSummary = Get-TestResultSummary $testResultPath $currentTaskId $isTestResultIn
itialState
+$reviewSummary = Get-ReviewSummary $reviewPath $lastReviewDecision $isReviewInitialState
 
 $statusObject = [ordered]@{
     goalTitle = if (Test-HasValue $queue.goalTitle) { $queue.goalTitle } else { "없음" }
@@ -256,14 +349,18 @@
 Write-Host "Git changed files count: $($statusObject.git.changedFilesCount)"
 Write-Host ""
 Write-Host "Test result summary:"
-Write-Host $statusObject.testResultSummary
+Write-Host "  Status: $($testResultSummary.status)"
+Write-Host "  Reason: $($testResultSummary.reason)"
+Write-Host $testResultSummary.content
 Write-Host ""
 Write-Host "Review summary:"
-Write-Host "  Decision: $($reviewSummary.decision)"
-Write-Host "  Severity: $($reviewSummary.severity)"
-Write-Host "  Next step: $($reviewSummary.nextStep)"
-Write-Host "  Summary: $($reviewSummary.summary)"
+Write-Host "  Status: $($reviewSummary.status)"
+Write-Host "  Reason: $($reviewSummary.reason)"
+Write-Host "  Decision: $($reviewSummary.content.decision)"
+Write-Host "  Severity: $($reviewSummary.content.severity)"
+Write-Host "  Next step: $($reviewSummary.content.nextStep)"
+Write-Host "  Summary: $($reviewSummary.content.summary)"
 
-if (Test-HasValue $reviewSummary.fallback) {
-    Write-Host $reviewSummary.fallback
+if ($reviewSummary.status -eq "current" -and (Test-HasValue $reviewSummary.content.fallba
ck)) {
+    Write-Host $reviewSummary.content.fallback
 }

codex
문법 검사는 통과했습니다. 현재 `.ai-dev` 상태값 기준으로 새 로직이 어떤 판정을 낼지만 별도 읽기 스니펫으로 확인하겠습니다. 이 검증은 상태 스크립트를 
실행하지 않아 git 호출이 없습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '$state = Get-Co
ntent -Raw -Encoding UTF8 -LiteralPath '"'D:\\ai-apps\\planpilot-local\\.ai-dev\\state.jso
n' | ConvertFrom-Json; "'$queue = Get-Content -Raw -Encoding UTF8 -LiteralPath '"'D:\\ai-a
pps\\planpilot-local\\.ai-dev\\queue.json' | ConvertFrom-Json; "'$task = @($queue.tasks | 
Where-Object { $_.id -eq $state.currentTaskId } | Select-Object -First 1)[0]; $testTask = 
(Get-Content -Encoding UTF8 -LiteralPath '"'D:\\ai-apps\\planpilot-local\\.ai-dev\\test-re
sult.md' | Where-Object { "'$_ -match '"'"'^- Current task:'"\\s*(.+)"'$'"' } | Select-Obj
ect -First 1); "'$testTaskId = if ($testTask -match '"'"'^- Current task:'"\\s*(.+)"'$'"')
 { "'$Matches[1].Trim() } else { '"'' }; "'$isTaskInitial = @('"'not_started','pending') -
contains [string]"'$task.status -or [string]$state.goalStatus -eq '"'not_started'; "'$isTe
stInitial = $isTaskInitial -or (-not [string]$state.lastCommand -and ([string]$state.lastC
ommandStatus -eq '"'not_started' -or -not [string]"'$state.lastCommandStatus)); $isReviewI
nitial = $isTaskInitial -or (-not [string]$state.lastReviewDecision -or [string]$state.las
tReviewDecision -eq '"'not_started'); \"currentTask="'$($state.currentTaskId); taskStatus=
$($task.status); testResultTask=$testTaskId; testInitial=$isTestInitial; reviewInitial=$is
ReviewInitial"' in D:\ai-apps\planpilot-local
 succeeded in 1422ms:
currentTask=T001; taskStatus=in_progress; testResultTask=T003; testInitial=True; reviewIni
tial=True

diff --git a/scripts/ai-dev-status.ps1 b/scripts/ai-dev-status.ps1
index 83046c60ec29bcad826a0d0baa1eee36c553b87e..fc32599a0981496a62033a5fbdd569bcda2cc48b
--- a/scripts/ai-dev-status.ps1
+++ b/scripts/ai-dev-status.ps1
@@ -76,13 +76,77 @@
     }
 }
 
+function Get-TestResultCurrentTaskId {
+    param(
+        [string[]]$Lines
+    )
+
+    $currentTaskLine = $Lines | Where-Object { $_ -match '^- Current task:\s*(.+)$' } | S
elect-Object -First 1
+
+    if ($currentTaskLine -match '^- Current task:\s*(.+)$') {
+        return $Matches[1].Trim()
+    }
+
+    return $null
+}
+
+function New-SummaryStatus {
+    param(
+        [string]$Status,
+        [string]$Reason,
+        [object]$Content
+    )
+
+    return [PSCustomObject]@{
+        status = $Status
+        reason = $Reason
+        content = $Content
+    }
+}
+
+function Get-TestResultSummary {
+    param(
+        [string]$Path,
+        [string]$CurrentTaskId,
+        [bool]$IsInitialState
+    )
+
+    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
+        return New-SummaryStatus "missing" "test-result 파일이 없습니다." "없음"
+    }
+
+    try {
+        $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)
+
+        if ($lines.Count -eq 0) {
+            return New-SummaryStatus "missing" "test-result 파일이 비어 있습니다." "없음"
+        }
+
+        $resultTaskId = Get-TestResultCurrentTaskId $lines
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 test-result 요약을 숨겼습니다." 
"숨김"
+        }
+
+        if ((Test-HasValue $CurrentTaskId) -and (Test-HasValue $resultTaskId) -and $resul
tTaskId -ne $CurrentTaskId) {
+            return New-SummaryStatus "stale" "test-result의 task($resultTaskId)가 현재 task($
CurrentTaskId)와 다릅니다." "숨김"
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." (($lines | Select-Object -Last
 30) -join "`r`n")
+    } catch {
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" "읽기 실패: $($_.Ex
ception.Message)"
+    }
+}
+
 function Get-ReviewSummary {
     param(
-        [string]$Path
+        [string]$Path,
+        [string]$LastReviewDecision,
+        [bool]$IsInitialState
     )
 
     if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
-        return [PSCustomObject]@{
+        $missingSummary = [PSCustomObject]@{
             available = $false
             decision = $null
             severity = $null
@@ -90,6 +154,8 @@
             summary = "없음"
             fallback = $null
         }
+
+        return New-SummaryStatus "missing" "review 파일이 없습니다." $missingSummary
     }
 
     try {
@@ -105,7 +171,7 @@
         $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } 
else { $null }
         $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or 
(Test-HasValue $nextStep) -or (Test-HasValue $summary)
 
-        return [PSCustomObject]@{
+        $review = [PSCustomObject]@{
             available = $true
             decision = $decision
             severity = $severity
@@ -113,8 +179,22 @@
             summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
             fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object 
-Last 30) -join "`r`n") }
         }
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." $revi
ew
+        }
+
+        if ((Test-HasValue $LastReviewDecision) -and $LastReviewDecision -ne "not_started
" -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
+            return New-SummaryStatus "stale" "review decision($decision)이 state lastRevie
wDecision($LastReviewDecision)와 다릅니다." $review
+        }
+
+        if (-not (Test-HasValue $LastReviewDecision) -or $LastReviewDecision -eq "not_sta
rted") {
+            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 
요약을 숨겼습니다." $review
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." $review
     } catch {
-        return [PSCustomObject]@{
+        $errorSummary = [PSCustomObject]@{
             available = $true
             decision = $null
             severity = $null
@@ -122,6 +202,8 @@
             summary = "읽기 실패: $($_.Exception.Message)"
             fallback = $null
         }
+
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" $errorSummary
     }
 }
 
@@ -182,6 +264,17 @@
     skipped = @($tasks | Where-Object { $_.status -eq "skipped" }).Count
 }
 
+$currentTaskStatus = if ($null -ne $currentTask) { [string]$currentTask.status } else { $
null }
+$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastCom
mandStatus } else { $null }
+$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastR
eviewDecision } else { $null }
+$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { $
null }
+$initialTaskStatuses = @("not_started", "pending")
+$isTaskInitialState = ($initialTaskStatuses -contains $currentTaskStatus) -or ($goalStatu
s -eq "not_started")
+$isTestResultInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $state.lastCommand) -and ($lastCommandStatus -eq "not_started" -
or -not (Test-HasValue $lastCommandStatus)))
+$isReviewInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $lastReviewDecision) -or $lastReviewDecision -eq "not_started")
+
 $gitStatus = "unavailable"
 $gitChangedFilesCount = $null
 $gitStatusLines = @()
@@ -202,8 +295,8 @@
     $gitStatus = "unavailable"
 }
 
-$testResultSummary = Get-LastLines $testResultPath 30
-$reviewSummary = Get-ReviewSummary $reviewPath
+$testResultSummary = Get-TestResultSummary $testResultPath $currentTaskId $isTestResultIn
itialState
+$reviewSummary = Get-ReviewSummary $reviewPath $lastReviewDecision $isReviewInitialState
 
 $statusObject = [ordered]@{
     goalTitle = if (Test-HasValue $queue.goalTitle) { $queue.goalTitle } else { "없음" }
@@ -256,14 +349,18 @@
 Write-Host "Git changed files count: $($statusObject.git.changedFilesCount)"
 Write-Host ""
 Write-Host "Test result summary:"
-Write-Host $statusObject.testResultSummary
+Write-Host "  Status: $($testResultSummary.status)"
+Write-Host "  Reason: $($testResultSummary.reason)"
+Write-Host $testResultSummary.content
 Write-Host ""
 Write-Host "Review summary:"
-Write-Host "  Decision: $($reviewSummary.decision)"
-Write-Host "  Severity: $($reviewSummary.severity)"
-Write-Host "  Next step: $($reviewSummary.nextStep)"
-Write-Host "  Summary: $($reviewSummary.summary)"
+Write-Host "  Status: $($reviewSummary.status)"
+Write-Host "  Reason: $($reviewSummary.reason)"
+Write-Host "  Decision: $($reviewSummary.content.decision)"
+Write-Host "  Severity: $($reviewSummary.content.severity)"
+Write-Host "  Next step: $($reviewSummary.content.nextStep)"
+Write-Host "  Summary: $($reviewSummary.content.summary)"
 
-if (Test-HasValue $reviewSummary.fallback) {
-    Write-Host $reviewSummary.fallback
+if ($reviewSummary.status -eq "current" -and (Test-HasValue $reviewSummary.content.fallba
ck)) {
+    Write-Host $reviewSummary.content.fallback
 }

codex
현재 상태에서는 `currentTask=T001`, 이전 test-result는 `T003`, 그리고 command/review가 초기값이라 두 요약 모두 sta
le로 숨겨지는 판정입니다. 최종 보고를 위해 변경 위치를 한 번 더 정리합니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -
LiteralPath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-status.ps1' -Pattern 'Get-LastL
ines'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -
LiteralPath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-status.ps1' -Pattern 'function 
Get-TestResultCurrentTaskId','function New-SummaryStatus','function Get-TestResultSummary'
,'function Get-ReviewSummary','isTestResultInitialState','testResultSummary =','Write-Host
 \"Test result summary'" in D:\ai-apps\planpilot-local
 succeeded in 1757ms:

scripts\ai-dev-status.ps1:79:function Get-TestResultCurrentTaskId {
scripts\ai-dev-status.ps1:93:function New-SummaryStatus {
scripts\ai-dev-status.ps1:107:function Get-TestResultSummary {
scripts\ai-dev-status.ps1:141:function Get-ReviewSummary {
scripts\ai-dev-status.ps1:273:$isTestResultInitialState = $isTaskInitialState -or `
scripts\ai-dev-status.ps1:298:$testResultSummary = Get-TestResultSummary $testResultPath $
currentTaskId $isTestResultIn
itialState
scripts\ai-dev-status.ps1:324:    testResultSummary = $testResultSummary
scripts\ai-dev-status.ps1:351:Write-Host "Test result summary:"



 succeeded in 1770ms:

scripts\ai-dev-status.ps1:56:function Get-LastLines {



diff --git a/scripts/ai-dev-status.ps1 b/scripts/ai-dev-status.ps1
index 83046c60ec29bcad826a0d0baa1eee36c553b87e..fc32599a0981496a62033a5fbdd569bcda2cc48b
--- a/scripts/ai-dev-status.ps1
+++ b/scripts/ai-dev-status.ps1
@@ -76,13 +76,77 @@
     }
 }
 
+function Get-TestResultCurrentTaskId {
+    param(
+        [string[]]$Lines
+    )
+
+    $currentTaskLine = $Lines | Where-Object { $_ -match '^- Current task:\s*(.+)$' } | S
elect-Object -First 1
+
+    if ($currentTaskLine -match '^- Current task:\s*(.+)$') {
+        return $Matches[1].Trim()
+    }
+
+    return $null
+}
+
+function New-SummaryStatus {
+    param(
+        [string]$Status,
+        [string]$Reason,
+        [object]$Content
+    )
+
+    return [PSCustomObject]@{
+        status = $Status
+        reason = $Reason
+        content = $Content
+    }
+}
+
+function Get-TestResultSummary {
+    param(
+        [string]$Path,
+        [string]$CurrentTaskId,
+        [bool]$IsInitialState
+    )
+
+    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
+        return New-SummaryStatus "missing" "test-result 파일이 없습니다." "없음"
+    }
+
+    try {
+        $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)
+
+        if ($lines.Count -eq 0) {
+            return New-SummaryStatus "missing" "test-result 파일이 비어 있습니다." "없음"
+        }
+
+        $resultTaskId = Get-TestResultCurrentTaskId $lines
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 test-result 요약을 숨겼습니다." 
"숨김"
+        }
+
+        if ((Test-HasValue $CurrentTaskId) -and (Test-HasValue $resultTaskId) -and $resul
tTaskId -ne $CurrentTaskId) {
+            return New-SummaryStatus "stale" "test-result의 task($resultTaskId)가 현재 task($
CurrentTaskId)와 다릅니다." "숨김"
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." (($lines | Select-Object -Last
 30) -join "`r`n")
+    } catch {
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" "읽기 실패: $($_.Ex
ception.Message)"
+    }
+}
+
 function Get-ReviewSummary {
     param(
-        [string]$Path
+        [string]$Path,
+        [string]$LastReviewDecision,
+        [bool]$IsInitialState
     )
 
     if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
-        return [PSCustomObject]@{
+        $missingSummary = [PSCustomObject]@{
             available = $false
             decision = $null
             severity = $null
@@ -90,6 +154,8 @@
             summary = "없음"
             fallback = $null
         }
+
+        return New-SummaryStatus "missing" "review 파일이 없습니다." $missingSummary
     }
 
     try {
@@ -105,7 +171,7 @@
         $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } 
else { $null }
         $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or 
(Test-HasValue $nextStep) -or (Test-HasValue $summary)
 
-        return [PSCustomObject]@{
+        $review = [PSCustomObject]@{
             available = $true
             decision = $decision
             severity = $severity
@@ -113,8 +179,22 @@
             summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
             fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object 
-Last 30) -join "`r`n") }
         }
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." $revi
ew
+        }
+
+        if ((Test-HasValue $LastReviewDecision) -and $LastReviewDecision -ne "not_started
" -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
+            return New-SummaryStatus "stale" "review decision($decision)이 state lastRevie
wDecision($LastReviewDecision)와 다릅니다." $review
+        }
+
+        if (-not (Test-HasValue $LastReviewDecision) -or $LastReviewDecision -eq "not_sta
rted") {
+            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 
요약을 숨겼습니다." $review
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." $review
     } catch {
-        return [PSCustomObject]@{
+        $errorSummary = [PSCustomObject]@{
             available = $true
             decision = $null
             severity = $null
@@ -122,6 +202,8 @@
             summary = "읽기 실패: $($_.Exception.Message)"
             fallback = $null
         }
+
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" $errorSummary
     }
 }
 
@@ -182,6 +264,17 @@
     skipped = @($tasks | Where-Object { $_.status -eq "skipped" }).Count
 }
 
+$currentTaskStatus = if ($null -ne $currentTask) { [string]$currentTask.status } else { $
null }
+$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastCom
mandStatus } else { $null }
+$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastR
eviewDecision } else { $null }
+$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { $
null }
+$initialTaskStatuses = @("not_started", "pending")
+$isTaskInitialState = ($initialTaskStatuses -contains $currentTaskStatus) -or ($goalStatu
s -eq "not_started")
+$isTestResultInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $state.lastCommand) -and ($lastCommandStatus -eq "not_started" -
or -not (Test-HasValue $lastCommandStatus)))
+$isReviewInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $lastReviewDecision) -or $lastReviewDecision -eq "not_started")
+
 $gitStatus = "unavailable"
 $gitChangedFilesCount = $null
 $gitStatusLines = @()
@@ -202,8 +295,8 @@
     $gitStatus = "unavailable"
 }
 
-$testResultSummary = Get-LastLines $testResultPath 30
-$reviewSummary = Get-ReviewSummary $reviewPath
+$testResultSummary = Get-TestResultSummary $testResultPath $currentTaskId $isTestResultIn
itialState
+$reviewSummary = Get-ReviewSummary $reviewPath $lastReviewDecision $isReviewInitialState
 
 $statusObject = [ordered]@{
     goalTitle = if (Test-HasValue $queue.goalTitle) { $queue.goalTitle } else { "없음" }
@@ -256,14 +349,18 @@
 Write-Host "Git changed files count: $($statusObject.git.changedFilesCount)"
 Write-Host ""
 Write-Host "Test result summary:"
-Write-Host $statusObject.testResultSummary
+Write-Host "  Status: $($testResultSummary.status)"
+Write-Host "  Reason: $($testResultSummary.reason)"
+Write-Host $testResultSummary.content
 Write-Host ""
 Write-Host "Review summary:"
-Write-Host "  Decision: $($reviewSummary.decision)"
-Write-Host "  Severity: $($reviewSummary.severity)"
-Write-Host "  Next step: $($reviewSummary.nextStep)"
-Write-Host "  Summary: $($reviewSummary.summary)"
+Write-Host "  Status: $($reviewSummary.status)"
+Write-Host "  Reason: $($reviewSummary.reason)"
+Write-Host "  Decision: $($reviewSummary.content.decision)"
+Write-Host "  Severity: $($reviewSummary.content.severity)"
+Write-Host "  Next step: $($reviewSummary.content.nextStep)"
+Write-Host "  Summary: $($reviewSummary.content.summary)"
 
-if (Test-HasValue $reviewSummary.fallback) {
-    Write-Host $reviewSummary.fallback
+if ($reviewSummary.status -eq "current" -and (Test-HasValue $reviewSummary.content.fallba
ck)) {
+    Write-Host $reviewSummary.content.fallback
 }

codex
기존 `Get-LastLines`는 새 요약 판정 함수로 대체되어 더 이상 쓰이지 않습니다. 같은 파일 안의 죽은 코드만 제거해 변경을 깔끔하게 유지하겠습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\scripts\ai-dev-status.ps1
diff --git a/scripts/ai-dev-status.ps1 b/scripts/ai-dev-status.ps1
index 83046c60ec29bcad826a0d0baa1eee36c553b87e..ec23aa95745017e513d88e597e1382e4704360c0
--- a/scripts/ai-dev-status.ps1
+++ b/scripts/ai-dev-status.ps1
@@ -53,36 +53,77 @@
     return $true
 }
 
-function Get-LastLines {
+function Get-TestResultCurrentTaskId {
+    param(
+        [string[]]$Lines
+    )
+
+    $currentTaskLine = $Lines | Where-Object { $_ -match '^- Current task:\s*(.+)$' } | S
elect-Object -First 1
+
+    if ($currentTaskLine -match '^- Current task:\s*(.+)$') {
+        return $Matches[1].Trim()
+    }
+
+    return $null
+}
+
+function New-SummaryStatus {
+    param(
+        [string]$Status,
+        [string]$Reason,
+        [object]$Content
+    )
+
+    return [PSCustomObject]@{
+        status = $Status
+        reason = $Reason
+        content = $Content
+    }
+}
+
+function Get-TestResultSummary {
     param(
         [string]$Path,
-        [int]$Count = 30
+        [string]$CurrentTaskId,
+        [bool]$IsInitialState
     )
 
     if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
-        return "없음"
+        return New-SummaryStatus "missing" "test-result 파일이 없습니다." "없음"
     }
 
     try {
         $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)
 
         if ($lines.Count -eq 0) {
-            return "없음"
+            return New-SummaryStatus "missing" "test-result 파일이 비어 있습니다." "없음"
+        }
+
+        $resultTaskId = Get-TestResultCurrentTaskId $lines
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 test-result 요약을 숨겼습니다." 
"숨김"
         }
 
-        return ($lines | Select-Object -Last $Count) -join "`r`n"
+        if ((Test-HasValue $CurrentTaskId) -and (Test-HasValue $resultTaskId) -and $resul
tTaskId -ne $CurrentTaskId) {
+            return New-SummaryStatus "stale" "test-result의 task($resultTaskId)가 현재 task($
CurrentTaskId)와 다릅니다." "숨김"
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." (($lines | Select-Object -Last
 30) -join "`r`n")
     } catch {
-        return "읽기 실패: $($_.Exception.Message)"
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" "읽기 실패: $($_.Ex
ception.Message)"
     }
 }
 
 function Get-ReviewSummary {
     param(
-        [string]$Path
+        [string]$Path,
+        [string]$LastReviewDecision,
+        [bool]$IsInitialState
     )
 
     if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
-        return [PSCustomObject]@{
+        $missingSummary = [PSCustomObject]@{
             available = $false
             decision = $null
             severity = $null
@@ -90,6 +131,8 @@
             summary = "없음"
             fallback = $null
         }
+
+        return New-SummaryStatus "missing" "review 파일이 없습니다." $missingSummary
     }
 
     try {
@@ -105,7 +148,7 @@
         $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } 
else { $null }
         $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or 
(Test-HasValue $nextStep) -or (Test-HasValue $summary)
 
-        return [PSCustomObject]@{
+        $review = [PSCustomObject]@{
             available = $true
             decision = $decision
             severity = $severity
@@ -113,8 +156,22 @@
             summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
             fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object 
-Last 30) -join "`r`n") }
         }
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." $revi
ew
+        }
+
+        if ((Test-HasValue $LastReviewDecision) -and $LastReviewDecision -ne "not_started
" -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
+            return New-SummaryStatus "stale" "review decision($decision)이 state lastRevie
wDecision($LastReviewDecision)와 다릅니다." $review
+        }
+
+        if (-not (Test-HasValue $LastReviewDecision) -or $LastReviewDecision -eq "not_sta
rted") {
+            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 
요약을 숨겼습니다." $review
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." $review
     } catch {
-        return [PSCustomObject]@{
+        $errorSummary = [PSCustomObject]@{
             available = $true
             decision = $null
             severity = $null
@@ -122,6 +179,8 @@
             summary = "읽기 실패: $($_.Exception.Message)"
             fallback = $null
         }
+
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" $errorSummary
     }
 }
 
@@ -182,6 +241,17 @@
     skipped = @($tasks | Where-Object { $_.status -eq "skipped" }).Count
 }
 
+$currentTaskStatus = if ($null -ne $currentTask) { [string]$currentTask.status } else { $
null }
+$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastCom
mandStatus } else { $null }
+$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastR
eviewDecision } else { $null }
+$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { $
null }
+$initialTaskStatuses = @("not_started", "pending")
+$isTaskInitialState = ($initialTaskStatuses -contains $currentTaskStatus) -or ($goalStatu
s -eq "not_started")
+$isTestResultInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $state.lastCommand) -and ($lastCommandStatus -eq "not_started" -
or -not (Test-HasValue $lastCommandStatus)))
+$isReviewInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $lastReviewDecision) -or $lastReviewDecision -eq "not_started")
+
 $gitStatus = "unavailable"
 $gitChangedFilesCount = $null
 $gitStatusLines = @()
@@ -202,8 +272,8 @@
     $gitStatus = "unavailable"
 }
 
-$testResultSummary = Get-LastLines $testResultPath 30
-$reviewSummary = Get-ReviewSummary $reviewPath
+$testResultSummary = Get-TestResultSummary $testResultPath $currentTaskId $isTestResultIn
itialState
+$reviewSummary = Get-ReviewSummary $reviewPath $lastReviewDecision $isReviewInitialState
 
 $statusObject = [ordered]@{
     goalTitle = if (Test-HasValue $queue.goalTitle) { $queue.goalTitle } else { "없음" }
@@ -256,14 +326,18 @@
 Write-Host "Git changed files count: $($statusObject.git.changedFilesCount)"
 Write-Host ""
 Write-Host "Test result summary:"
-Write-Host $statusObject.testResultSummary
+Write-Host "  Status: $($testResultSummary.status)"
+Write-Host "  Reason: $($testResultSummary.reason)"
+Write-Host $testResultSummary.content
 Write-Host ""
 Write-Host "Review summary:"
-Write-Host "  Decision: $($reviewSummary.decision)"
-Write-Host "  Severity: $($reviewSummary.severity)"
-Write-Host "  Next step: $($reviewSummary.nextStep)"
-Write-Host "  Summary: $($reviewSummary.summary)"
+Write-Host "  Status: $($reviewSummary.status)"
+Write-Host "  Reason: $($reviewSummary.reason)"
+Write-Host "  Decision: $($reviewSummary.content.decision)"
+Write-Host "  Severity: $($reviewSummary.content.severity)"
+Write-Host "  Next step: $($reviewSummary.content.nextStep)"
+Write-Host "  Summary: $($reviewSummary.content.summary)"
 
-if (Test-HasValue $reviewSummary.fallback) {
-    Write-Host $reviewSummary.fallback
+if ($reviewSummary.status -eq "current" -and (Test-HasValue $reviewSummary.content.fallba
ck)) {
+    Write-Host $reviewSummary.content.fallback
 }

diff --git a/scripts/ai-dev-status.ps1 b/scripts/ai-dev-status.ps1
index 83046c60ec29bcad826a0d0baa1eee36c553b87e..ec23aa95745017e513d88e597e1382e4704360c0
--- a/scripts/ai-dev-status.ps1
+++ b/scripts/ai-dev-status.ps1
@@ -53,36 +53,77 @@
     return $true
 }
 
-function Get-LastLines {
+function Get-TestResultCurrentTaskId {
+    param(
+        [string[]]$Lines
+    )
+
+    $currentTaskLine = $Lines | Where-Object { $_ -match '^- Current task:\s*(.+)$' } | S
elect-Object -First 1
+
+    if ($currentTaskLine -match '^- Current task:\s*(.+)$') {
+        return $Matches[1].Trim()
+    }
+
+    return $null
+}
+
+function New-SummaryStatus {
+    param(
+        [string]$Status,
+        [string]$Reason,
+        [object]$Content
+    )
+
+    return [PSCustomObject]@{
+        status = $Status
+        reason = $Reason
+        content = $Content
+    }
+}
+
+function Get-TestResultSummary {
     param(
         [string]$Path,
-        [int]$Count = 30
+        [string]$CurrentTaskId,
+        [bool]$IsInitialState
     )
 
     if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
-        return "없음"
+        return New-SummaryStatus "missing" "test-result 파일이 없습니다." "없음"
     }
 
     try {
         $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)
 
         if ($lines.Count -eq 0) {
-            return "없음"
+            return New-SummaryStatus "missing" "test-result 파일이 비어 있습니다." "없음"
+        }
+
+        $resultTaskId = Get-TestResultCurrentTaskId $lines
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 test-result 요약을 숨겼습니다." 
"숨김"
         }
 
-        return ($lines | Select-Object -Last $Count) -join "`r`n"
+        if ((Test-HasValue $CurrentTaskId) -and (Test-HasValue $resultTaskId) -and $resul
tTaskId -ne $CurrentTaskId) {
+            return New-SummaryStatus "stale" "test-result의 task($resultTaskId)가 현재 task($
CurrentTaskId)와 다릅니다." "숨김"
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." (($lines | Select-Object -Last
 30) -join "`r`n")
     } catch {
-        return "읽기 실패: $($_.Exception.Message)"
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" "읽기 실패: $($_.Ex
ception.Message)"
     }
 }
 
 function Get-ReviewSummary {
     param(
-        [string]$Path
+        [string]$Path,
+        [string]$LastReviewDecision,
+        [bool]$IsInitialState
     )
 
     if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
-        return [PSCustomObject]@{
+        $missingSummary = [PSCustomObject]@{
             available = $false
             decision = $null
             severity = $null
@@ -90,6 +131,8 @@
             summary = "없음"
             fallback = $null
         }
+
+        return New-SummaryStatus "missing" "review 파일이 없습니다." $missingSummary
     }
 
     try {
@@ -105,7 +148,7 @@
         $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } 
else { $null }
         $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or 
(Test-HasValue $nextStep) -or (Test-HasValue $summary)
 
-        return [PSCustomObject]@{
+        $review = [PSCustomObject]@{
             available = $true
             decision = $decision
             severity = $severity
@@ -113,8 +156,22 @@
             summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
             fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object 
-Last 30) -join "`r`n") }
         }
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." $revi
ew
+        }
+
+        if ((Test-HasValue $LastReviewDecision) -and $LastReviewDecision -ne "not_started
" -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
+            return New-SummaryStatus "stale" "review decision($decision)이 state lastRevie
wDecision($LastReviewDecision)와 다릅니다." $review
+        }
+
+        if (-not (Test-HasValue $LastReviewDecision) -or $LastReviewDecision -eq "not_sta
rted") {
+            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 
요약을 숨겼습니다." $review
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." $review
     } catch {
-        return [PSCustomObject]@{
+        $errorSummary = [PSCustomObject]@{
             available = $true
             decision = $null
             severity = $null
@@ -122,6 +179,8 @@
             summary = "읽기 실패: $($_.Exception.Message)"
             fallback = $null
         }
+
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" $errorSummary
     }
 }
 
@@ -182,6 +241,17 @@
     skipped = @($tasks | Where-Object { $_.status -eq "skipped" }).Count
 }
 
+$currentTaskStatus = if ($null -ne $currentTask) { [string]$currentTask.status } else { $
null }
+$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastCom
mandStatus } else { $null }
+$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastR
eviewDecision } else { $null }
+$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { $
null }
+$initialTaskStatuses = @("not_started", "pending")
+$isTaskInitialState = ($initialTaskStatuses -contains $currentTaskStatus) -or ($goalStatu
s -eq "not_started")
+$isTestResultInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $state.lastCommand) -and ($lastCommandStatus -eq "not_started" -
or -not (Test-HasValue $lastCommandStatus)))
+$isReviewInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $lastReviewDecision) -or $lastReviewDecision -eq "not_started")
+
 $gitStatus = "unavailable"
 $gitChangedFilesCount = $null
 $gitStatusLines = @()
@@ -202,8 +272,8 @@
     $gitStatus = "unavailable"
 }
 
-$testResultSummary = Get-LastLines $testResultPath 30
-$reviewSummary = Get-ReviewSummary $reviewPath
+$testResultSummary = Get-TestResultSummary $testResultPath $currentTaskId $isTestResultIn
itialState
+$reviewSummary = Get-ReviewSummary $reviewPath $lastReviewDecision $isReviewInitialState
 
 $statusObject = [ordered]@{
     goalTitle = if (Test-HasValue $queue.goalTitle) { $queue.goalTitle } else { "없음" }
@@ -256,14 +326,18 @@
 Write-Host "Git changed files count: $($statusObject.git.changedFilesCount)"
 Write-Host ""
 Write-Host "Test result summary:"
-Write-Host $statusObject.testResultSummary
+Write-Host "  Status: $($testResultSummary.status)"
+Write-Host "  Reason: $($testResultSummary.reason)"
+Write-Host $testResultSummary.content
 Write-Host ""
 Write-Host "Review summary:"
-Write-Host "  Decision: $($reviewSummary.decision)"
-Write-Host "  Severity: $($reviewSummary.severity)"
-Write-Host "  Next step: $($reviewSummary.nextStep)"
-Write-Host "  Summary: $($reviewSummary.summary)"
+Write-Host "  Status: $($reviewSummary.status)"
+Write-Host "  Reason: $($reviewSummary.reason)"
+Write-Host "  Decision: $($reviewSummary.content.decision)"
+Write-Host "  Severity: $($reviewSummary.content.severity)"
+Write-Host "  Next step: $($reviewSummary.content.nextStep)"
+Write-Host "  Summary: $($reviewSummary.content.summary)"
 
-if (Test-HasValue $reviewSummary.fallback) {
-    Write-Host $reviewSummary.fallback
+if ($reviewSummary.status -eq "current" -and (Test-HasValue $reviewSummary.content.fallba
ck)) {
+    Write-Host $reviewSummary.content.fallback
 }

codex
죽은 코드를 제거했습니다. 마지막으로 PowerShell 파서 검증을 다시 실행합니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '$tokens = $null
; $errors = $null; [System.Management.Automation.Language.Parser]::ParseFile('"'D:\\ai-app
s\\planpilot-local\\scripts\\ai-dev-status.ps1', [ref]"'$tokens, [ref]$errors) > $null; if
 ($errors.Count -eq 0) { '"'Parse OK' } else { "'$errors | ForEach-Object { $_.Message } }
' in D:\ai-apps\planpilot-local
 succeeded in 1324ms:
Parse OK

diff --git a/scripts/ai-dev-status.ps1 b/scripts/ai-dev-status.ps1
index 83046c60ec29bcad826a0d0baa1eee36c553b87e..ec23aa95745017e513d88e597e1382e4704360c0
--- a/scripts/ai-dev-status.ps1
+++ b/scripts/ai-dev-status.ps1
@@ -53,36 +53,77 @@
     return $true
 }
 
-function Get-LastLines {
+function Get-TestResultCurrentTaskId {
+    param(
+        [string[]]$Lines
+    )
+
+    $currentTaskLine = $Lines | Where-Object { $_ -match '^- Current task:\s*(.+)$' } | S
elect-Object -First 1
+
+    if ($currentTaskLine -match '^- Current task:\s*(.+)$') {
+        return $Matches[1].Trim()
+    }
+
+    return $null
+}
+
+function New-SummaryStatus {
+    param(
+        [string]$Status,
+        [string]$Reason,
+        [object]$Content
+    )
+
+    return [PSCustomObject]@{
+        status = $Status
+        reason = $Reason
+        content = $Content
+    }
+}
+
+function Get-TestResultSummary {
     param(
         [string]$Path,
-        [int]$Count = 30
+        [string]$CurrentTaskId,
+        [bool]$IsInitialState
     )
 
     if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
-        return "없음"
+        return New-SummaryStatus "missing" "test-result 파일이 없습니다." "없음"
     }
 
     try {
         $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)
 
         if ($lines.Count -eq 0) {
-            return "없음"
+            return New-SummaryStatus "missing" "test-result 파일이 비어 있습니다." "없음"
+        }
+
+        $resultTaskId = Get-TestResultCurrentTaskId $lines
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 test-result 요약을 숨겼습니다." 
"숨김"
         }
 
-        return ($lines | Select-Object -Last $Count) -join "`r`n"
+        if ((Test-HasValue $CurrentTaskId) -and (Test-HasValue $resultTaskId) -and $resul
tTaskId -ne $CurrentTaskId) {
+            return New-SummaryStatus "stale" "test-result의 task($resultTaskId)가 현재 task($
CurrentTaskId)와 다릅니다." "숨김"
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." (($lines | Select-Object -Last
 30) -join "`r`n")
     } catch {
-        return "읽기 실패: $($_.Exception.Message)"
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" "읽기 실패: $($_.Ex
ception.Message)"
     }
 }
 
 function Get-ReviewSummary {
     param(
-        [string]$Path
+        [string]$Path,
+        [string]$LastReviewDecision,
+        [bool]$IsInitialState
     )
 
     if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
-        return [PSCustomObject]@{
+        $missingSummary = [PSCustomObject]@{
             available = $false
             decision = $null
             severity = $null
@@ -90,6 +131,8 @@
             summary = "없음"
             fallback = $null
         }
+
+        return New-SummaryStatus "missing" "review 파일이 없습니다." $missingSummary
     }
 
     try {
@@ -105,7 +148,7 @@
         $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } 
else { $null }
         $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or 
(Test-HasValue $nextStep) -or (Test-HasValue $summary)
 
-        return [PSCustomObject]@{
+        $review = [PSCustomObject]@{
             available = $true
             decision = $decision
             severity = $severity
@@ -113,8 +156,22 @@
             summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
             fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object 
-Last 30) -join "`r`n") }
         }
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." $revi
ew
+        }
+
+        if ((Test-HasValue $LastReviewDecision) -and $LastReviewDecision -ne "not_started
" -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
+            return New-SummaryStatus "stale" "review decision($decision)이 state lastRevie
wDecision($LastReviewDecision)와 다릅니다." $review
+        }
+
+        if (-not (Test-HasValue $LastReviewDecision) -or $LastReviewDecision -eq "not_sta
rted") {
+            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 
요약을 숨겼습니다." $review
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." $review
     } catch {
-        return [PSCustomObject]@{
+        $errorSummary = [PSCustomObject]@{
             available = $true
             decision = $null
             severity = $null
@@ -122,6 +179,8 @@
             summary = "읽기 실패: $($_.Exception.Message)"
             fallback = $null
         }
+
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" $errorSummary
     }
 }
 
@@ -182,6 +241,17 @@
     skipped = @($tasks | Where-Object { $_.status -eq "skipped" }).Count
 }
 
+$currentTaskStatus = if ($null -ne $currentTask) { [string]$currentTask.status } else { $
null }
+$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastCom
mandStatus } else { $null }
+$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastR
eviewDecision } else { $null }
+$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { $
null }
+$initialTaskStatuses = @("not_started", "pending")
+$isTaskInitialState = ($initialTaskStatuses -contains $currentTaskStatus) -or ($goalStatu
s -eq "not_started")
+$isTestResultInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $state.lastCommand) -and ($lastCommandStatus -eq "not_started" -
or -not (Test-HasValue $lastCommandStatus)))
+$isReviewInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $lastReviewDecision) -or $lastReviewDecision -eq "not_started")
+
 $gitStatus = "unavailable"
 $gitChangedFilesCount = $null
 $gitStatusLines = @()
@@ -202,8 +272,8 @@
     $gitStatus = "unavailable"
 }
 
-$testResultSummary = Get-LastLines $testResultPath 30
-$reviewSummary = Get-ReviewSummary $reviewPath
+$testResultSummary = Get-TestResultSummary $testResultPath $currentTaskId $isTestResultIn
itialState
+$reviewSummary = Get-ReviewSummary $reviewPath $lastReviewDecision $isReviewInitialState
 
 $statusObject = [ordered]@{
     goalTitle = if (Test-HasValue $queue.goalTitle) { $queue.goalTitle } else { "없음" }
@@ -256,14 +326,18 @@
 Write-Host "Git changed files count: $($statusObject.git.changedFilesCount)"
 Write-Host ""
 Write-Host "Test result summary:"
-Write-Host $statusObject.testResultSummary
+Write-Host "  Status: $($testResultSummary.status)"
+Write-Host "  Reason: $($testResultSummary.reason)"
+Write-Host $testResultSummary.content
 Write-Host ""
 Write-Host "Review summary:"
-Write-Host "  Decision: $($reviewSummary.decision)"
-Write-Host "  Severity: $($reviewSummary.severity)"
-Write-Host "  Next step: $($reviewSummary.nextStep)"
-Write-Host "  Summary: $($reviewSummary.summary)"
+Write-Host "  Status: $($reviewSummary.status)"
+Write-Host "  Reason: $($reviewSummary.reason)"
+Write-Host "  Decision: $($reviewSummary.content.decision)"
+Write-Host "  Severity: $($reviewSummary.content.severity)"
+Write-Host "  Next step: $($reviewSummary.content.nextStep)"
+Write-Host "  Summary: $($reviewSummary.content.summary)"
 
-if (Test-HasValue $reviewSummary.fallback) {
-    Write-Host $reviewSummary.fallback
+if ($reviewSummary.status -eq "current" -and (Test-HasValue $reviewSummary.content.fallba
ck)) {
+    Write-Host $reviewSummary.content.fallback
 }

codex
수정 완료했습니다.

변경한 파일:
- [scripts/ai-dev-status.ps1](D:/ai-apps/planpilot-local/scripts/ai-dev-status.ps1)

구현 요약:
- `test-result.md`의 `- Current task:` 값을 읽어 현재 `currentTaskId`와 다르면 `stale`로 표시하고 본문을 숨기도록
 했습니다.
- 현재 task/goal/command/review 상태가 초기 상태이면 이전 테스트/리뷰 요약을 현재 결과처럼 출력하지 않도록 했습니다.
- 리뷰 요약은 `state.lastReviewDecision`과 맞지 않거나 `not_started`이면 `stale`로 구분합니다.
- JSON 출력에도 `status`, `reason`, `content` 구조로 stale 여부가 드러나도록 했습니다.

검증:
- PowerShell AST 파서로 문법 검증: `Parse OK`
- 현재 상태 기준 확인: `currentTask=T001`, 기존 test-result는 `T003`, command/review 초기 상태라 새 로직상 테스트
/리뷰 요약 모두 stale 판정됩니다.
- `scripts/ai-dev-status.ps1` 직접 실행은 하지 않았습니다. 해당 스크립트 내부가 `git status`를 호출하므로 AGENTS의 git
 실행 제한을 지켰습니다.
- `npm run build`, `npm run lint`, `npm run test`는 실행하지 않았습니다.

남은 위험:
- `review.md`에는 현재 task id 메타데이터가 없어서 task 불일치 직접 비교는 불가능합니다. 대신 `lastReviewDecision` 초기값/
불일치 기준으로 stale 처리합니다.

다음 task로 넘어가도 됩니다.

`.ai-dev/loop-log.md` 기록용 요약:
`T001: ai-dev-status 출력에서 현재 초기 상태 또는 currentTaskId/lastReviewDecision과 맞지 않는 이전 test-resu
lt/review 요약을 stale로 구분하고 본문 노출을 차단함. PowerShell 파서 검증 통과, 빌드/테스트/린트 및 status 직접 실행은 미수행.`
diff --git a/scripts/ai-dev-status.ps1 b/scripts/ai-dev-status.ps1
index 83046c60ec29bcad826a0d0baa1eee36c553b87e..ec23aa95745017e513d88e597e1382e4704360c0
--- a/scripts/ai-dev-status.ps1
+++ b/scripts/ai-dev-status.ps1
@@ -53,36 +53,77 @@
     return $true
 }
 
-function Get-LastLines {
+function Get-TestResultCurrentTaskId {
+    param(
+        [string[]]$Lines
+    )
+
+    $currentTaskLine = $Lines | Where-Object { $_ -match '^- Current task:\s*(.+)$' } | S
elect-Object -First 1
+
+    if ($currentTaskLine -match '^- Current task:\s*(.+)$') {
+        return $Matches[1].Trim()
+    }
+
+    return $null
+}
+
+function New-SummaryStatus {
+    param(
+        [string]$Status,
+        [string]$Reason,
+        [object]$Content
+    )
+
+    return [PSCustomObject]@{
+        status = $Status
+        reason = $Reason
+        content = $Content
+    }
+}
+
+function Get-TestResultSummary {
     param(
         [string]$Path,
-        [int]$Count = 30
+        [string]$CurrentTaskId,
+        [bool]$IsInitialState
     )
 
     if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
-        return "없음"
+        return New-SummaryStatus "missing" "test-result 파일이 없습니다." "없음"
     }
 
     try {
         $lines = @(Get-Content -Encoding UTF8 -LiteralPath $Path)
 
         if ($lines.Count -eq 0) {
-            return "없음"
+            return New-SummaryStatus "missing" "test-result 파일이 비어 있습니다." "없음"
+        }
+
+        $resultTaskId = Get-TestResultCurrentTaskId $lines
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 test-result 요약을 숨겼습니다." 
"숨김"
         }
 
-        return ($lines | Select-Object -Last $Count) -join "`r`n"
+        if ((Test-HasValue $CurrentTaskId) -and (Test-HasValue $resultTaskId) -and $resul
tTaskId -ne $CurrentTaskId) {
+            return New-SummaryStatus "stale" "test-result의 task($resultTaskId)가 현재 task($
CurrentTaskId)와 다릅니다." "숨김"
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." (($lines | Select-Object -Last
 30) -join "`r`n")
     } catch {
-        return "읽기 실패: $($_.Exception.Message)"
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" "읽기 실패: $($_.Ex
ception.Message)"
     }
 }
 
 function Get-ReviewSummary {
     param(
-        [string]$Path
+        [string]$Path,
+        [string]$LastReviewDecision,
+        [bool]$IsInitialState
     )
 
     if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
-        return [PSCustomObject]@{
+        $missingSummary = [PSCustomObject]@{
             available = $false
             decision = $null
             severity = $null
@@ -90,6 +131,8 @@
             summary = "없음"
             fallback = $null
         }
+
+        return New-SummaryStatus "missing" "review 파일이 없습니다." $missingSummary
     }
 
     try {
@@ -105,7 +148,7 @@
         $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } 
else { $null }
         $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or 
(Test-HasValue $nextStep) -or (Test-HasValue $summary)
 
-        return [PSCustomObject]@{
+        $review = [PSCustomObject]@{
             available = $true
             decision = $decision
             severity = $severity
@@ -113,8 +156,22 @@
             summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
             fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object 
-Last 30) -join "`r`n") }
         }
+
+        if ($IsInitialState) {
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." $revi
ew
+        }
+
+        if ((Test-HasValue $LastReviewDecision) -and $LastReviewDecision -ne "not_started
" -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
+            return New-SummaryStatus "stale" "review decision($decision)이 state lastRevie
wDecision($LastReviewDecision)와 다릅니다." $review
+        }
+
+        if (-not (Test-HasValue $LastReviewDecision) -or $LastReviewDecision -eq "not_sta
rted") {
+            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 
요약을 숨겼습니다." $review
+        }
+
+        return New-SummaryStatus "current" "현재 상태와 일치합니다." $review
     } catch {
-        return [PSCustomObject]@{
+        $errorSummary = [PSCustomObject]@{
             available = $true
             decision = $null
             severity = $null
@@ -122,6 +179,8 @@
             summary = "읽기 실패: $($_.Exception.Message)"
             fallback = $null
         }
+
+        return New-SummaryStatus "error" "읽기 실패: $($_.Exception.Message)" $errorSummary
     }
 }
 
@@ -182,6 +241,17 @@
     skipped = @($tasks | Where-Object { $_.status -eq "skipped" }).Count
 }
 
+$currentTaskStatus = if ($null -ne $currentTask) { [string]$currentTask.status } else { $
null }
+$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastCom
mandStatus } else { $null }
+$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastR
eviewDecision } else { $null }
+$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { $
null }
+$initialTaskStatuses = @("not_started", "pending")
+$isTaskInitialState = ($initialTaskStatuses -contains $currentTaskStatus) -or ($goalStatu
s -eq "not_started")
+$isTestResultInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $state.lastCommand) -and ($lastCommandStatus -eq "not_started" -
or -not (Test-HasValue $lastCommandStatus)))
+$isReviewInitialState = $isTaskInitialState -or `
+    (-not (Test-HasValue $lastReviewDecision) -or $lastReviewDecision -eq "not_started")
+
 $gitStatus = "unavailable"
 $gitChangedFilesCount = $null
 $gitStatusLines = @()
@@ -202,8 +272,8 @@
     $gitStatus = "unavailable"
 }
 
-$testResultSummary = Get-LastLines $testResultPath 30
-$reviewSummary = Get-ReviewSummary $reviewPath
+$testResultSummary = Get-TestResultSummary $testResultPath $currentTaskId $isTestResultIn
itialState
+$reviewSummary = Get-ReviewSummary $reviewPath $lastReviewDecision $isReviewInitialState
 
 $statusObject = [ordered]@{
     goalTitle = if (Test-HasValue $queue.goalTitle) { $queue.goalTitle } else { "없음" }
@@ -256,14 +326,18 @@
 Write-Host "Git changed files count: $($statusObject.git.changedFilesCount)"
 Write-Host ""
 Write-Host "Test result summary:"
-Write-Host $statusObject.testResultSummary
+Write-Host "  Status: $($testResultSummary.status)"
+Write-Host "  Reason: $($testResultSummary.reason)"
+Write-Host $testResultSummary.content
 Write-Host ""
 Write-Host "Review summary:"
-Write-Host "  Decision: $($reviewSummary.decision)"
-Write-Host "  Severity: $($reviewSummary.severity)"
-Write-Host "  Next step: $($reviewSummary.nextStep)"
-Write-Host "  Summary: $($reviewSummary.summary)"
+Write-Host "  Status: $($reviewSummary.status)"
+Write-Host "  Reason: $($reviewSummary.reason)"
+Write-Host "  Decision: $($reviewSummary.content.decision)"
+Write-Host "  Severity: $($reviewSummary.content.severity)"
+Write-Host "  Next step: $($reviewSummary.content.nextStep)"
+Write-Host "  Summary: $($reviewSummary.content.summary)"
 
-if (Test-HasValue $reviewSummary.fallback) {
-    Write-Host $reviewSummary.fallback
+if ($reviewSummary.status -eq "current" -and (Test-HasValue $reviewSummary.content.fallba
ck)) {
+    Write-Host $reviewSummary.content.fallback
 }

tokens used
69,244
수정 완료했습니다.

변경한 파일:
- [scripts/ai-dev-status.ps1](D:/ai-apps/planpilot-local/scripts/ai-dev-status.ps1)

구현 요약:
- `test-result.md`의 `- Current task:` 값을 읽어 현재 `currentTaskId`와 다르면 `stale`로 표시하고 본문을 숨기도록 했습니다.
- 현재 task/goal/command/review 상태가 초기 상태이면 이전 테스트/리뷰 요약을 현재 결과처럼 출력하지 않도록 했습니다.
- 리뷰 요약은 `state.lastReviewDecision`과 맞지 않거나 `not_started`이면 `stale`로 구분합니다.
- JSON 출력에도 `status`, `reason`, `content` 구조로 stale 여부가 드러나도록 했습니다.

검증:
- PowerShell AST 파서로 문법 검증: `Parse OK`
- 현재 상태 기준 확인: `currentTask=T001`, 기존 test-result는 `T003`, command/review 초기 상태라 새 로직상 테스트/리뷰 요약 모두 stale 판정됩니다.
- `scripts/ai-dev-status.ps1` 직접 실행은 하지 않았습니다. 해당 스크립트 내부가 `git status`를 호출하므로 AGENTS의 git 실행 제한을 지켰습니다.
- `npm run build`, `npm run lint`, `npm run test`는 실행하지 않았습니다.

남은 위험:
- `review.md`에는 현재 task id 메타데이터가 없어서 task 불일치 직접 비교는 불가능합니다. 대신 `lastReviewDecision` 초기값/불일치 기준으로 stale 처리합니다.

다음 task로 넘어가도 됩니다.

`.ai-dev/loop-log.md` 기록용 요약:
`T001: ai-dev-status 출력에서 현재 초기 상태 또는 currentTaskId/lastReviewDecision과 맞지 않는 이전 test-result/review 요약을 stale로 구분하고 본문 노출을 차단함. PowerShell 파서 검증 통과, 빌드/테스트/린트 및 status 직접 실행은 미수행.`

```