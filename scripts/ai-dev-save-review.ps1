param(
    [string]$ReviewFile,
    [string]$ReviewJson,
    [switch]$FromClipboard
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
        Write-Host "  powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -ReviewFile .ai-dev/review-response.json"
        Write-Host '  powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -ReviewJson ''{"decision":"pass","severity":"none","summary":"OK","required_changes":[],"optional_suggestions":[],"next_step":"complete_task"}'''
        Write-Host "  powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard"
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

    $firstBrace = $RawInput.IndexOf("{")
    $lastBrace = $RawInput.LastIndexOf("}")

    if ($firstBrace -ge 0 -and $lastBrace -gt $firstBrace) {
        $candidates += $RawInput.Substring($firstBrace, $lastBrace - $firstBrace + 1).Trim()
    }

    return @($candidates | Select-Object -Unique)
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

    if (@("complete_task", "revise_with_codex", "stop_for_user") -notcontains $Review.next_step) {
        $errors += "허용되지 않은 next_step: $($Review.next_step)"
    }

    if ($Review.required_changes -isnot [System.Collections.IEnumerable] -or $Review.required_changes -is [string]) {
        $errors += "required_changes는 배열이어야 합니다."
    }

    if ($Review.optional_suggestions -isnot [System.Collections.IEnumerable] -or $Review.optional_suggestions -is [string]) {
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

if (-not (Test-Path -LiteralPath $statePath -PathType Leaf)) {
    Stop-WithError "필수 파일이 없습니다: $stateRelativePath"
}

$state = Read-JsonFile $statePath $stateRelativePath
$rawReview = Get-ReviewInput

try {
    $reviewResult = ConvertFrom-ReviewJson $rawReview
    $review = $reviewResult.Parsed
    $validationErrors = @(Get-ValidationErrors $review)

    if ($validationErrors.Count -gt 0) {
        throw ($validationErrors -join "; ")
    }
} catch {
    $errorSummary = $_.Exception.Message
    Save-InvalidReview $state $rawReview $errorSummary
    Stop-WithError "리뷰 JSON 저장에 실패했습니다: $errorSummary"
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

$nextAction = if ($review.decision -eq "pass" -and $review.next_step -eq "complete_task") {
    "scripts/ai-dev-complete-task.ps1 실행을 검토하세요."
} elseif ($review.decision -eq "revise" -and $review.next_step -eq "revise_with_codex") {
    "review.md를 Codex 또는 Cline에 전달해 필수 수정사항을 반영하세요."
} elseif ($review.decision -eq "blocked" -or $review.next_step -eq "stop_for_user") {
    "사용자 판단이 필요하므로 자동 진행을 중단하세요."
} else {
    "decision과 next_step 조합을 확인한 뒤 다음 행동을 결정하세요."
}

Write-Host "리뷰 저장 완료: $reviewRelativePath"
Write-Host "Decision: $($review.decision)"
Write-Host "Severity: $($review.severity)"
Write-Host "Next step: $($review.next_step)"
Write-Host "안내: $nextAction"
