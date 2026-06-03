param(
    [switch]$AllowOptionalSuggestions
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$reviewRelativePath = ".ai-dev/review.md"
$goalRelativePath = ".ai-dev/goal.md"
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$diffRelativePath = ".ai-dev/diff.md"
$testResultRelativePath = ".ai-dev/test-result.md"
$revisePromptRelativePath = ".ai-dev/revise-prompt.md"

$reviewPath = Join-Path $projectRoot $reviewRelativePath
$goalPath = Join-Path $projectRoot $goalRelativePath
$queuePath = Join-Path $projectRoot $queueRelativePath
$statePath = Join-Path $projectRoot $stateRelativePath
$diffPath = Join-Path $projectRoot $diffRelativePath
$testResultPath = Join-Path $projectRoot $testResultRelativePath
$revisePromptPath = Join-Path $projectRoot $revisePromptRelativePath
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

function Get-ReviewJson {
    param(
        [string]$ReviewContent
    )

    $candidates = @()
    $codeBlockMatch = [regex]::Match(
        $ReviewContent,
        '```(?:json)?\s*(\{[\s\S]*?\})\s*```',
        [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
    )

    if ($codeBlockMatch.Success) {
        $candidates += $codeBlockMatch.Groups[1].Value.Trim()
    }

    $firstBrace = $ReviewContent.IndexOf("{")
    $lastBrace = $ReviewContent.LastIndexOf("}")

    if ($firstBrace -ge 0 -and $lastBrace -gt $firstBrace) {
        $candidates += $ReviewContent.Substring($firstBrace, $lastBrace - $firstBrace + 1).Trim()
    }

    foreach ($candidate in @($candidates | Select-Object -Unique)) {
        try {
            $parsed = $candidate | ConvertFrom-Json

            if ($null -ne $parsed -and $parsed -isnot [System.Array]) {
                return $parsed
            }
        } catch {
        }
    }

    return $null
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
        "- File: $file`r`n  - Reason: $reason`r`n  - Suggestion: $suggestion"
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
        "- File: $file`r`n  - Suggestion: $suggestion"
    }) -join "`r`n"
}

foreach ($requiredPath in @(
    $reviewRelativePath,
    $goalRelativePath,
    $queueRelativePath,
    $stateRelativePath,
    $diffRelativePath,
    $testResultRelativePath
)) {
    $fullPath = Join-Path $projectRoot $requiredPath

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        Stop-WithError "필수 파일이 없습니다: $requiredPath"
    }
}

$reviewContent = Get-Content -Raw -Encoding UTF8 -LiteralPath $reviewPath
$goalContent = Get-Content -Raw -Encoding UTF8 -LiteralPath $goalPath
$queue = Read-JsonFile $queuePath $queueRelativePath
$state = Read-JsonFile $statePath $stateRelativePath
$diffContent = Get-Content -Raw -Encoding UTF8 -LiteralPath $diffPath
$testResultContent = Get-Content -Raw -Encoding UTF8 -LiteralPath $testResultPath

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
    Stop-WithError "재수정할 task가 없습니다."
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
    "verification"
)

Stop-ForMissingFields "task $currentTaskId" (Get-MissingFields $currentTask $taskRequiredFields)

$review = Get-ReviewJson $reviewContent
$reviewParsed = $null -ne $review

if ($reviewParsed -and $review.decision -eq "blocked") {
    Write-Host "리뷰 decision이 blocked입니다. 사용자 판단이 필요합니다."
    exit 1
}

if ($reviewParsed -and $review.decision -eq "pass") {
    Write-Host "리뷰 decision이 pass입니다. scripts/ai-dev-complete-task.ps1 실행을 검토하세요."
    exit 0
}

if (-not $reviewParsed) {
    Write-Warning "review.md의 JSON을 파싱하지 못했습니다. review.md 전체 내용을 포함해 재수정 프롬프트를 생성합니다."
}

$verificationText = Convert-ToMarkdownList $currentTask.verification
$reviewDecision = if ($reviewParsed -and (Test-HasValue $review.decision)) { $review.decision } else { "parse_failed" }
$reviewSeverity = if ($reviewParsed -and (Test-HasValue $review.severity)) { $review.severity } else { "unknown" }
$reviewNextStep = if ($reviewParsed -and (Test-HasValue $review.next_step)) { $review.next_step } else { "unknown" }
$reviewSummary = if ($reviewParsed -and (Test-HasValue $review.summary)) { $review.summary } else { "review.md JSON 파싱 실패" }
$requiredChangesText = if ($reviewParsed) {
    Format-RequiredChanges $review.required_changes
} else {
    "- review.md 전체 내용을 확인하고, 리뷰에서 요구한 필수 수정사항만 반영한다."
}
$optionalSuggestionsText = if ($reviewParsed) {
    Format-OptionalSuggestions $review.optional_suggestions
} else {
    "- review.md JSON 파싱 실패로 구조화된 optional suggestions를 확인할 수 없다."
}
$optionalPolicyText = if ($AllowOptionalSuggestions) {
    "- optional_suggestions도 현재 task 범위 안에서 필요한 경우 반영할 수 있다."
} else {
    "- optional_suggestions는 참고만 하며 구현하지 않는다."
}
$reviewResultText = if ($reviewParsed) {
@"
- Decision: $reviewDecision
- Severity: $reviewSeverity
- Next step: $reviewNextStep
- Summary: $reviewSummary
"@
} else {
@"
- Decision: parse_failed
- Severity: unknown
- Next step: unknown
- Summary: review.md JSON 파싱 실패

### Review.md Full Content

$reviewContent
"@
}

$revisePromptContent = @"
# AI Dev Revise Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.
이전 리뷰에서 지적된 사항만 수정한다.

## Goal

$goalContent

## Current Task

- Task ID: $($currentTask.id)
- Title: $($currentTask.title)
- Description: $($currentTask.description)
- Type: $($currentTask.type)
- Status: $($currentTask.status)
- Priority: $($currentTask.priority)
- Verification:
$verificationText

## Review Result

$reviewResultText

## Required Changes

$requiredChangesText

## Optional Suggestions

$optionalPolicyText
$optionalSuggestionsText

## Diff Context

$diffContent

## Test Result

$testResultContent

## Allowed Scope

- required_changes에 필요한 최소 수정만 허용한다.
- 현재 task 범위를 벗어나지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 새 기능 추가보다 리뷰 지적사항 해결을 우선한다.

## Hard Rules

- ``package.json``과 ``package-lock.json``은 수정하지 않는다. 꼭 필요하면 중단하고 이유만 기록한다.
- 실제 DB 삭제 또는 초기화를 하지 않는다.
- 사용자 데이터 복원 또는 덮어쓰기를 하지 않는다.
- 대규모 리팩터링을 하지 않는다.
- git commit을 실행하지 않는다.
- git reset, git checkout, git clean을 실행하지 않는다.
- npm install을 실행하지 않는다.
- optional_suggestions는 기본적으로 구현하지 않는다.

## Required Output

- 반영한 required_changes 목록
- 수정한 파일 목록
- 검증 방법
- 반영하지 못한 항목과 이유
- 남은 위험
- ``.ai-dev/loop-log.md``에 기록할 재수정 요약
"@

[System.IO.File]::WriteAllText($revisePromptPath, $revisePromptContent, $utf8WithBom)

Write-Host "생성된 재수정 프롬프트 파일: $revisePromptRelativePath"
Write-Host "Current task id: $($currentTask.id)"
Write-Host "Current task title: $($currentTask.title)"
Write-Host "Review decision: $reviewDecision"
Write-Host "Review severity: $reviewSeverity"
Write-Host "Optional suggestions 허용 여부: $($AllowOptionalSuggestions.IsPresent)"
