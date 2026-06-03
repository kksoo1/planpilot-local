param()

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$goalRelativePath = ".ai-dev/goal.md"
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$promptRelativePath = ".ai-dev/current-task-prompt.md"

$goalPath = Join-Path $projectRoot $goalRelativePath
$queuePath = Join-Path $projectRoot $queueRelativePath
$statePath = Join-Path $projectRoot $stateRelativePath
$promptPath = Join-Path $projectRoot $promptRelativePath

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

function Stop-ForMissingFields {
    param(
        [string]$SourceName,
        [string[]]$MissingFields
    )

    if ($MissingFields.Count -eq 0) {
        return
    }

    Write-Host "$SourceName 누락 필드:"
    foreach ($field in $MissingFields) {
        Write-Host "  - $field"
    }

    Stop-WithError "$SourceName 필수 필드가 누락되었습니다."
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

function Convert-ToMarkdownList {
    param(
        [object]$Value
    )

    if ($null -eq $Value -or @($Value).Count -eq 0) {
        return "- 없음"
    }

    return (@($Value) | ForEach-Object { "- $_" }) -join "`r`n"
}

foreach ($requiredPath in @($goalRelativePath, $queueRelativePath, $stateRelativePath)) {
    $fullPath = Join-Path $projectRoot $requiredPath

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        Stop-WithError "필수 파일이 없습니다: $requiredPath"
    }
}

$goalContent = Get-Content -Raw -Encoding UTF8 -LiteralPath $goalPath
$queue = Read-JsonFile $queuePath $queueRelativePath
$state = Read-JsonFile $statePath $stateRelativePath

$queueRequiredFields = @(
    "goalTitle",
    "currentTaskId",
    "tasks"
)
$stateRequiredFields = @(
    "goalStatus",
    "currentTaskId"
)

Stop-ForMissingFields $queueRelativePath (Get-MissingFields $queue $queueRequiredFields)
Stop-ForMissingFields $stateRelativePath (Get-MissingFields $state $stateRequiredFields)

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
    $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Object -First 1

    if ($null -ne $pendingTask) {
        $currentTaskId = [string]$pendingTask.id
    }
}

if (-not (Test-HasValue $currentTaskId)) {
    Stop-WithError "수행할 task가 없습니다."
}

$currentTask = $tasks | Where-Object { $_.id -eq $currentTaskId } | Select-Object -First 1

if ($null -eq $currentTask) {
    Stop-WithError "currentTaskId에 해당하는 task를 찾을 수 없습니다: $currentTaskId"
}

$taskRequiredFields = @(
    "id",
    "title",
    "description",
    "type",
    "status",
    "priority",
    "dependsOn",
    "filesLikelyToChange",
    "verification"
)

Stop-ForMissingFields "task $currentTaskId" (Get-MissingFields $currentTask $taskRequiredFields)

$dependsOnText = Convert-ToMarkdownList $currentTask.dependsOn
$likelyFilesText = Convert-ToMarkdownList $currentTask.filesLikelyToChange
$verificationText = Convert-ToMarkdownList $currentTask.verification

$promptContent = @"
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

$goalContent

## Current Task

- Task ID: $($currentTask.id)
- Title: $($currentTask.title)
- Description: $($currentTask.description)
- Type: $($currentTask.type)
- Status: $($currentTask.status)
- Priority: $($currentTask.priority)
- Depends on:
$dependsOnText

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

$likelyFilesText

## Verification

$verificationText

- 필요한 경우 ``npm run build``는 사람이 별도로 실행한다.
- 이 프롬프트는 자동으로 build, test, lint를 실행하라고 지시하지 않는다.

## Required Output

- 변경한 파일 목록
- 구현 또는 분석 내용 요약
- 검증 방법
- 남은 위험
- 다음 task로 넘어가도 되는지 여부
- ``.ai-dev/loop-log.md``에 기록할 작업 요약

## Hard Rules

- ``src`` 외 파일을 수정해야 하는 경우 이유를 기록한다.
- ``package.json``과 ``package-lock.json``은 수정하지 않는다. 꼭 필요하면 중단하고 이유만 기록한다.
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
"@

$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllText($promptPath, $promptContent, $utf8WithBom)

Write-Host "생성된 프롬프트 파일: $promptRelativePath"
Write-Host "Current task id: $($currentTask.id)"
Write-Host "Current task title: $($currentTask.title)"
