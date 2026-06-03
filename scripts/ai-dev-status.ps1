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
        $decisionLine = $lines | Where-Object { $_ -match '^- Decision:\s*(.+)$' } | Select-Object -First 1
        $severityLine = $lines | Where-Object { $_ -match '^- Severity:\s*(.+)$' } | Select-Object -First 1
        $nextStepLine = $lines | Where-Object { $_ -match '^- Next step:\s*(.+)$' } | Select-Object -First 1
        $summaryLine = $lines | Where-Object { $_ -match '^- Summary:\s*(.+)$' } | Select-Object -First 1

        $decision = if ($decisionLine -match '^- Decision:\s*(.+)$') { $Matches[1].Trim() } else { $null }
        $severity = if ($severityLine -match '^- Severity:\s*(.+)$') { $Matches[1].Trim() } else { $null }
        $nextStep = if ($nextStepLine -match '^- Next step:\s*(.+)$') { $Matches[1].Trim() } else { $null }
        $summary = if ($summaryLine -match '^- Summary:\s*(.+)$') { $Matches[1].Trim() } else { $null }
        $hasStandardFields = (Test-HasValue $decision) -or (Test-HasValue $severity) -or (Test-HasValue $nextStep) -or (Test-HasValue $summary)

        return [PSCustomObject]@{
            available = $true
            decision = $decision
            severity = $severity
            nextStep = $nextStep
            summary = if (Test-HasValue $summary) { $summary } else { "요약 필드 없음" }
            fallback = if ($hasStandardFields) { $null } else { (($lines | Select-Object -Last 30) -join "`r`n") }
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
            $gitStatusLines = @($gitOutput -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
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
        id = if ($null -ne $currentTask) { $currentTask.id } elseif (Test-HasValue $currentTaskId) { $currentTaskId } else { $null }
        title = if ($null -ne $currentTask) { $currentTask.title } else { "없음" }
        status = if ($null -ne $currentTask) { $currentTask.status } else { "없음" }
        type = if ($null -ne $currentTask) { $currentTask.type } else { "없음" }
        priority = if ($null -ne $currentTask) { $currentTask.priority } else { "없음" }
    }
    taskProgress = "$($taskCounts.done)/$($taskCounts.total)"
    taskCounts = $taskCounts
    lastCommand = if (Test-HasValue $state.lastCommand) { $state.lastCommand } else { "없음" }
    lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { $state.lastCommandStatus } else { "없음" }
    lastErrorSummary = if (Test-HasValue $state.lastErrorSummary) { $state.lastErrorSummary } else { "없음" }
    lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { $state.lastReviewDecision } else { "없음" }
    lastReviewSeverity = if (Test-HasValue $state.lastReviewSeverity) { $state.lastReviewSeverity } else { "없음" }
    lastCommitHash = if (Test-HasValue $state.lastCommitHash) { $state.lastCommitHash } else { "없음" }
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
Write-Host "Task counts: pending=$($taskCounts.pending), in_progress=$($taskCounts.in_progress), review_required=$($taskCounts.review_required), done=$($taskCounts.done), failed=$($taskCounts.failed), blocked=$($taskCounts.blocked), skipped=$($taskCounts.skipped), total=$($taskCounts.total)"
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
