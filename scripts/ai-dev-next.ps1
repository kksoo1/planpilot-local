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

    $commandText = [string]$Command

    return $commandText -eq "check" `
        -or $commandText -eq "build" `
        -or $commandText -eq "lint" `
        -or $commandText -eq "check-revise" `
        -or $commandText -eq "build-revise" `
        -or $commandText -eq "lint-revise" `
        -or $commandText -like "check-*" `
        -or $commandText -like "*-check" `
        -or $commandText -like "npm run build*" `
        -or $commandText -like "npm run test*" `
        -or $commandText -like "npm run lint*"
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
    return $normalizedPath -eq ".ai-dev" -or $normalizedPath -like ".ai-dev/*" -or $aiDevOperationalRelativePaths -contains $normalizedPath
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
            $gitChangedFiles = @($gitOutput -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
            $gitImplementationChangedFiles = @(
                $gitChangedFiles | Where-Object {
                    $changedPaths = @(Get-GitStatusPaths $_)
                    @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) }).Count -gt 0
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

$currentTaskPromptExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/current-task-prompt.md") -PathType Leaf
$testResultExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/test-result.md") -PathType Leaf
$diffExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/diff.md") -PathType Leaf
$reviewResultExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/review.md") -PathType Leaf
$reviewResponsePath = Join-Path $projectRoot ".ai-dev/review-response.json"
$reviewResponseExists = Test-Path -LiteralPath $reviewResponsePath -PathType Leaf
$reviewPromptExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/review-prompt.md") -PathType Leaf
$revisePromptExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/revise-prompt.md") -PathType Leaf

$goalStatus = if (Test-HasValue $state.goalStatus) { [string]$state.goalStatus } else { "" }
$lastCommand = if (Test-HasValue $state.lastCommand) { [string]$state.lastCommand } else { "" }
$lastCommandStatus = if (Test-HasValue $state.lastCommandStatus) { [string]$state.lastCommandStatus } else { "" }
$lastReviewDecision = if (Test-HasValue $state.lastReviewDecision) { [string]$state.lastReviewDecision } else { "" }
$lastReviewSeverity = if (Test-HasValue $state.lastReviewSeverity) { [string]$state.lastReviewSeverity } else { "" }
$lastCommitHash = if (Test-HasValue $state.lastCommitHash) { [string]$state.lastCommitHash } else { "" }

$reviewResponseDecision = ""
$reviewResponseNextStep = ""

if ($reviewResponseExists) {
    try {
        $reviewResponse = Get-Content -Raw -Encoding UTF8 -LiteralPath $reviewResponsePath | ConvertFrom-Json
        $reviewResponseDecision = if (Test-HasValue $reviewResponse.decision) { [string]$reviewResponse.decision } else { "" }
        $reviewResponseNextStep = if (Test-HasValue $reviewResponse.next_step) { [string]$reviewResponse.next_step } else { "" }
    } catch {
        $reviewResponseDecision = ""
        $reviewResponseNextStep = ""
    }
}

$hasGitChanges = $gitStatus -eq "available" -and $gitChangedFilesCount -gt 0
$hasNoGitChanges = $gitStatus -eq "available" -and $gitChangedFilesCount -eq 0
$hasImplementationGitChanges = $gitStatus -eq "available" -and $gitImplementationChangedFilesCount -gt 0
$hasNoImplementationGitChanges = $gitStatus -eq "available" -and $gitImplementationChangedFilesCount -eq 0
$reviewNotStarted = Test-IsReviewNotStarted $lastReviewDecision
$isCheckCommand = Test-IsCheckCommand $lastCommand
$hasCheckFailure = $isCheckCommand -and $lastCommandStatus -eq "failed"
$hasStateReviseReview = $lastReviewDecision -eq "revise"
$hasReviewResponseReviseSignal = $reviewResponseExists -and $reviewResponseDecision -eq "revise" -and $reviewResponseNextStep -eq "revise_with_codex"
$hasReviewResponseMismatch = $reviewResponseExists -and -not $hasReviewResponseReviseSignal
$canMakeRevisePrompt = $hasStateReviseReview

$checkFailureRecommendedCommands = @()
$checkFailureRecommendedCommands += "Get-Content -LiteralPath .ai-dev/test-result.md"
$checkFailureRecommendedCommands += "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1"
$checkFailureRecommendedCommands += "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict"

$revisePromptNotes = @()
$revisePromptNotes += $(if ($revisePromptExists) { "기존 revise-prompt.md는 현재 리뷰 기준으로 덮어씁니다." } else { "required changes만 반영하세요." })

if (-not $testResultExists) {
    $revisePromptNotes += ".ai-dev/test-result.md가 없으면 수정 전 실패/검증 결과를 먼저 확보하세요."
}

if (-not $diffExists) {
    $revisePromptNotes += ".ai-dev/diff.md가 없으면 save-diff로 현재 변경사항을 먼저 저장하세요."
}

if (-not $reviewResultExists) {
    $revisePromptNotes += ".ai-dev/review.md가 없으면 저장된 리뷰 내용을 먼저 확보하세요."
}

if (-not $reviewResponseExists) {
    $revisePromptNotes += "review-response.json이 없어도 state.json의 lastReviewDecision=revise를 기준으로 revise 안내를 유지합니다."
} elseif ($hasReviewResponseMismatch) {
    $revisePromptNotes += "review-response.json이 현재 revise 신호와 다르므로 review.md와 state.json의 최신성을 확인하세요."
}

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
} elseif ($hasCheckFailure) {
    $nextAction = New-NextAction "prepare_review_after_check_failure" "build/check가 실패했습니다. 실패 원인을 반영한 리뷰를 먼저 생성해야 합니다." $checkFailureRecommendedCommands @(
        $(if ($testResultExists) { ".ai-dev/test-result.md에서 실패 원인을 먼저 확인하세요." } else { ".ai-dev/test-result.md가 없으므로 실패 로그를 먼저 확보하세요." }),
        $(if ($hasImplementationGitChanges) { "구현 변경사항이 있으므로 실패 원인과 함께 현재 diff를 리뷰에 포함하세요." } elseif ($hasNoImplementationGitChanges) { "현재 감지된 구현 변경사항은 없지만 state.json 기준 build/check 실패 상태이므로 실패 로그 확인을 우선하세요." } else { "git 상태를 확인할 수 없지만 state.json 기준 build/check 실패 상태이므로 실패 로그 확인을 우선하세요." }),
        "save-diff로 현재 변경사항을 저장하고, make-review-prompt -Strict로 실패 결과 기준 리뷰 프롬프트를 생성하세요.",
        "review-prompt.md를 만든 뒤 Codex 리뷰를 실행하거나 리뷰 결과를 저장해야 합니다.",
        "리뷰 결과를 받은 뒤 decision이 revise이면 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1 를 실행합니다.",
        "revise-prompt가 생성된 뒤 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md 로 재수정할 수 있습니다.",
        "이 revise 단계는 리뷰 결과가 revise인 경우에만 해당하며, build/check 실패 직후에는 먼저 실패 로그 확인, diff 저장, review prompt 생성을 진행하세요."
    )
} elseif ($canMakeRevisePrompt) {
    $nextAction = New-NextAction "make_revise_prompt" "리뷰에서 수정이 필요하다고 판정했습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1"
    ) $revisePromptNotes
} elseif ($lastReviewDecision -eq "pass" -and $lastCommandStatus -eq "passed" -and $hasImplementationGitChanges) {
    $nextAction = New-NextAction "commit" "검증과 리뷰가 통과했고 커밋할 변경사항이 있습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
    ) @("먼저 ai-dev-commit.ps1 -DryRun으로 커밋 대상을 확인하는 것을 권장합니다.")
} elseif ($lastReviewDecision -eq "pass" -and (Test-HasValue $lastCommitHash) -and $hasNoImplementationGitChanges -and $lastCommand -eq "commit" -and $lastCommandStatus -eq "passed") {
    $nextAction = New-NextAction "complete_task" "리뷰와 커밋이 완료되었고 남은 구현 변경사항이 없습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 및 커밋 완료`" -CommitHash $lastCommitHash"
    ) @("완료 처리 시 구현 커밋 해시를 함께 전달하세요.")
} elseif ($hasNoImplementationGitChanges -and ($lastCommand -eq "" -or $lastCommand -eq "init" -or $lastCommand -eq "current-task")) {
    $nextAction = New-NextAction "run_codex_or_cline" "현재 task 프롬프트는 준비되었고 아직 변경사항이 없습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1"
    ) @("current-task-prompt.md를 Codex 또는 Cline에 전달해 현재 task를 수행하세요.")
} elseif ($hasImplementationGitChanges -and $lastCommand -eq "save-diff" -and $reviewNotStarted -and -not $reviewPromptExists) {
    $nextAction = New-NextAction "make_review_prompt" "diff가 저장되었고 리뷰 프롬프트가 없습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict"
    ) @("현재 diff와 검증 결과를 기준으로 리뷰 프롬프트를 생성하세요.")
} elseif ($hasImplementationGitChanges -and $reviewPromptExists -and $reviewNotStarted) {
    $nextAction = New-NextAction "ask_gpt_review" "리뷰 프롬프트가 준비되었고 아직 리뷰 결과가 없습니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard"
    ) @("review-prompt.md 내용을 GPT Chat에 붙여넣고 JSON 리뷰 결과를 받은 뒤 save-review를 실행하세요.")
} elseif ($hasImplementationGitChanges -and $isCheckCommand -and $lastCommandStatus -eq "passed" -and (-not $diffExists -or $isCheckCommand)) {
    $nextAction = New-NextAction "save_diff" "검증이 통과했으며 현재 변경사항의 diff 저장이 필요합니다." @(
        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1"
    ) @("diff 저장 후 리뷰 프롬프트를 생성하세요.")
} elseif ($hasImplementationGitChanges -and ($lastCommandStatus -ne "passed" -or -not $isCheckCommand)) {
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
    currentTaskId = if ($null -ne $currentTask) { $currentTask.id } elseif (Test-HasValue $currentTaskId) { $currentTaskId } else { $null }
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
        reviewResultExists = $reviewResultExists
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
Write-Host "Git implementation changed files count: $($output.gitImplementationChangedFilesCount)"
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
