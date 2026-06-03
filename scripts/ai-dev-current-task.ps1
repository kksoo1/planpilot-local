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

function Format-List {
    param(
        [object]$Value
    )

    if ($null -eq $Value -or @($Value).Count -eq 0) {
        return "없음"
    }

    return (@($Value) -join ", ")
}

foreach ($requiredPath in @($queueRelativePath, $stateRelativePath)) {
    $fullPath = Join-Path $projectRoot $requiredPath

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        Stop-WithError "필수 파일이 없습니다: $requiredPath"
    }
}

$queue = Read-JsonFile $queuePath $queueRelativePath
$state = Read-JsonFile $statePath $stateRelativePath

$queueRequiredFields = @(
    "goalTitle",
    "goalSource",
    "createdAt",
    "updatedAt",
    "currentTaskId",
    "tasks"
)
$stateRequiredFields = @(
    "goalStatus",
    "currentTaskId",
    "currentLoop",
    "maxLoopsPerTask",
    "repeatedFailureCount",
    "lastCommand",
    "lastCommandStatus",
    "lastErrorSummary",
    "lastReviewDecision",
    "lastReviewSeverity",
    "lastCommitHash",
    "startedAt",
    "updatedAt",
    "stopReason"
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
    Write-Host "수행할 task가 없습니다."
    exit 0
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
    "verification",
    "commitMessage"
)

Stop-ForMissingFields "task $currentTaskId" (Get-MissingFields $currentTask $taskRequiredFields)

$taskOutput = [ordered]@{
    goalTitle = $queue.goalTitle
    goalStatus = $state.goalStatus
    currentTaskId = $currentTask.id
    currentTaskTitle = $currentTask.title
    type = $currentTask.type
    status = $currentTask.status
    priority = $currentTask.priority
    dependsOn = @($currentTask.dependsOn)
    description = $currentTask.description
    filesLikelyToChange = @($currentTask.filesLikelyToChange)
    verification = @($currentTask.verification)
    commitMessage = $currentTask.commitMessage
}

if ($Json) {
    $taskOutput | ConvertTo-Json -Depth 10
    exit 0
}

Write-Host "Goal title: $($taskOutput.goalTitle)"
Write-Host "Goal status: $($taskOutput.goalStatus)"
Write-Host "Current task id: $($taskOutput.currentTaskId)"
Write-Host "Current task title: $($taskOutput.currentTaskTitle)"
Write-Host "Task type: $($taskOutput.type)"
Write-Host "Task status: $($taskOutput.status)"
Write-Host "Priority: $($taskOutput.priority)"
Write-Host "Depends on: $(Format-List $taskOutput.dependsOn)"
Write-Host "Description: $($taskOutput.description)"
Write-Host "Files likely to change: $(Format-List $taskOutput.filesLikelyToChange)"
Write-Host "Verification: $(Format-List $taskOutput.verification)"
Write-Host "Commit message: $(if (Test-HasValue $taskOutput.commitMessage) { $taskOutput.commitMessage } else { '없음' })"
