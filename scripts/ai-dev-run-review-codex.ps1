param(
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowDirty,
    [switch]$GenerateReviewPromptIfMissing,
    [switch]$SaveReview,
    [string]$ReviewPromptPath = ".ai-dev/review-prompt.md",
    [string]$ReviewResponsePath = ".ai-dev/review-response.json",
    [string]$ResultPath = ".ai-dev/codex-review-result.md"
)

. "$PSScriptRoot\ai-dev-env.ps1"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
$codeFence = '```'
$stateRelativePath = ".ai-dev/state.json"
$statePath = Join-Path $repoRoot $stateRelativePath

function Resolve-RepoPath {
    param(
        [string]$Path
    )

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return $Path
    }

    return Join-Path $repoRoot $Path
}

function ConvertTo-RepoRelativePath {
    param(
        [string]$Path
    )

    $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $Path))
    $rootWithSeparator = $repoRoot.TrimEnd("\") + "\"

    if ($fullPath.StartsWith($rootWithSeparator, [System.StringComparison]::OrdinalIgnoreCase)) {
        return $fullPath.Substring($rootWithSeparator.Length).Replace("\", "/")
    }

    return $fullPath.Replace("\", "/")
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

function Write-ReviewExtractionFailureState {
    param(
        [string]$ErrorSummary
    )

    if (-not (Test-Path -LiteralPath $statePath -PathType Leaf)) {
        return
    }

    try {
        $state = Get-Content -Raw -Encoding UTF8 -LiteralPath $statePath | ConvertFrom-Json
        $failureCount = if ($state.stopReason -eq "review_json_extraction_failed" -and (Test-HasValue $state.repeatedFailureCount)) { [int]$state.repeatedFailureCount + 1 } else { 1 }

        Set-ObjectProperty $state "lastCommand" "run-review-codex"
        Set-ObjectProperty $state "lastCommandStatus" "failed"
        Set-ObjectProperty $state "lastErrorSummary" $ErrorSummary
        Set-ObjectProperty $state "lastReviewDecision" "blocked"
        Set-ObjectProperty $state "lastReviewSeverity" "critical"
        Set-ObjectProperty $state "repeatedFailureCount" $failureCount
        Set-ObjectProperty $state "stopReason" "review_json_extraction_failed"
        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))

        $stateJson = $state | ConvertTo-Json -Depth 20
        [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)
    } catch {
        Write-Warning "$stateRelativePath에 리뷰 JSON 추출 실패 상태를 기록하지 못했습니다: $($_.Exception.Message)"
    }
}

function Write-RunResult {
    param(
        [string]$Action,
        [bool]$Executed,
        [int]$ExitCode,
        [string]$Message
    )

    if ($Json) {
        [ordered]@{
            action = $Action
            executed = $Executed
            exitCode = $ExitCode
            reviewResponsePath = (ConvertTo-RepoRelativePath $ReviewResponsePath)
            resultPath = (ConvertTo-RepoRelativePath $ResultPath)
            message = $Message
        } | ConvertTo-Json -Depth 10
    } else {
        Write-Host $Message
    }

    exit $ExitCode
}

function Get-GitStatusLines {
    $statusOutput = & git status --short 2>&1

    if ($LASTEXITCODE -ne 0) {
        $message = "git status 확인에 실패했습니다: $($statusOutput -join "`n")"
        Write-RunResult "run_review_codex" $false 1 $message
    }

    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
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

    if ($normalized.Length -le 500) {
        return $normalized
    }

    return $normalized.Substring(0, 500)
}

function Get-JsonObjectCandidates {
    param(
        [string]$RawInput
    )

    $candidates = @()

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
                    $candidates += $RawInput.Substring($start, $index - $start + 1).Trim()
                    break
                }
            }
        }
    }

    return @($candidates | Select-Object -Unique)
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

function ConvertFrom-CodexReviewOutput {
    param(
        [string]$RawInput
    )

    foreach ($candidate in Get-JsonObjectCandidates $RawInput) {
        try {
            $parsed = $candidate | ConvertFrom-Json

            if ($null -eq $parsed -or $parsed -is [System.Array]) {
                continue
            }

            $validationErrors = @(Get-ValidationErrors $parsed)

            if ($validationErrors.Count -gt 0) {
                continue
            }

            return [PSCustomObject]@{
                Parsed = $parsed
                JsonText = ($parsed | ConvertTo-Json -Depth 20)
            }
        } catch {
        }
    }

    throw "Codex 출력에서 필수 필드를 포함한 유효한 JSON 리뷰 객체를 찾지 못했습니다."
}

function New-CodexReviewPrompt {
    param(
        [string]$PromptFilePath
    )

    return "Read and follow the full review prompt at this absolute file path: $PromptFilePath"
}

Set-Location $repoRoot

$reviewPromptRelativePath = ConvertTo-RepoRelativePath $ReviewPromptPath
$reviewResponseRelativePath = ConvertTo-RepoRelativePath $ReviewResponsePath
$resultRelativePath = ConvertTo-RepoRelativePath $ResultPath
$resolvedReviewPromptPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ReviewPromptPath))
$resolvedReviewResponsePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ReviewResponsePath))
$resolvedResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ResultPath))
$statusLines = @(Get-GitStatusLines)

if ($statusLines.Count -gt 0 -and -not $AllowDirty) {
    $dirtyText = ($statusLines -join "`n")
    $message = "작업 트리가 dirty 상태라 Codex 리뷰 실행을 중단합니다. 계속하려면 변경사항을 정리하거나 -AllowDirty를 명시하세요.`n$dirtyText"
    Write-RunResult "run_review_codex" $false 1 $message
}

$promptExists = Test-Path -LiteralPath $resolvedReviewPromptPath -PathType Leaf

if (-not $promptExists -and -not $GenerateReviewPromptIfMissing) {
    $message = "리뷰 프롬프트 파일이 없습니다: $reviewPromptRelativePath`n먼저 다음 명령을 실행하세요: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1"
    Write-RunResult "run_review_codex" $false 1 $message
}

$commandText = "codex exec <short wrapper pointing to $reviewPromptRelativePath>"
$saveReviewCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -ReviewFile $reviewResponseRelativePath"

if ($DryRun) {
    $message = @"
Codex 리뷰 실행 DryRun입니다.
- Repository: $repoRoot
- Review prompt: $reviewPromptRelativePath
- Review response: $reviewResponseRelativePath
- Result: $resultRelativePath
- Command: $commandText
- SaveReview: $([bool]$SaveReview)
- SaveReviewCommand: $saveReviewCommandText
- GenerateReviewPromptIfMissing: $([bool]$GenerateReviewPromptIfMissing)
- WouldGenerateReviewPrompt: $(-not $promptExists -and [bool]$GenerateReviewPromptIfMissing)
- AllowDirty: $([bool]$AllowDirty)
- DirtyCount: $($statusLines.Count)
"@

    Write-RunResult "run_review_codex" $false 0 $message
}

if (-not $promptExists -and $GenerateReviewPromptIfMissing) {
    $makeReviewPromptPath = Join-Path $PSScriptRoot "ai-dev-make-review-prompt.ps1"

    if (-not (Test-Path -LiteralPath $makeReviewPromptPath -PathType Leaf)) {
        Write-RunResult "run_review_codex" $false 1 "리뷰 프롬프트 생성 스크립트를 찾을 수 없습니다: scripts/ai-dev-make-review-prompt.ps1"
    }

    $makeReviewPromptOutput = & powershell -ExecutionPolicy Bypass -File $makeReviewPromptPath 2>&1 | Out-String

    if ($LASTEXITCODE -ne 0) {
        Write-RunResult "run_review_codex" $false 1 "리뷰 프롬프트 생성에 실패했습니다: $($makeReviewPromptOutput.Trim())"
    }
}

if (-not (Test-Path -LiteralPath $resolvedReviewPromptPath -PathType Leaf)) {
    Write-RunResult "run_review_codex" $false 1 "리뷰 프롬프트 파일을 찾을 수 없습니다: $reviewPromptRelativePath"
}

$codexCommand = Get-Command codex -ErrorAction SilentlyContinue

if ($null -eq $codexCommand) {
    Write-RunResult "run_review_codex" $false 1 "Codex CLI를 찾을 수 없습니다. codex 명령을 사용할 수 있는지 확인하세요."
}

$codexPrompt = New-CodexReviewPrompt $resolvedReviewPromptPath
$startedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$codexOutput = & codex exec $codexPrompt 2>&1 | Out-String
$codexExitCode = $LASTEXITCODE
$endedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$resultContent = @"
# Codex Review Result

## Run

- Started at: $startedAt
- Ended at: $endedAt
- Exit code: $codexExitCode
- Review prompt: $reviewPromptRelativePath
- Review response: $reviewResponseRelativePath
- Command: $commandText

## Output

${codeFence}text
$codexOutput
$codeFence
"@

[System.IO.File]::WriteAllText($resolvedResultPath, $resultContent, $utf8WithBom)

if ($codexExitCode -ne 0) {
    Write-RunResult "run_review_codex" $true 1 "Codex 리뷰 실행에 실패했습니다. 결과 파일을 확인하세요: $resultRelativePath"
}

try {
    $reviewResult = ConvertFrom-CodexReviewOutput $codexOutput
} catch {
    $preview = Get-InputPreview $codexOutput
    $errorSummary = "Codex 리뷰 JSON 추출에 실패했습니다: $($_.Exception.Message) 출력 preview: $preview"
    Write-ReviewExtractionFailureState $errorSummary
    Write-RunResult "run_review_codex" $true 1 $errorSummary
}

[System.IO.File]::WriteAllText($resolvedReviewResponsePath, $reviewResult.JsonText, $utf8WithBom)

if ($SaveReview) {
    $saveReviewPath = Join-Path $PSScriptRoot "ai-dev-save-review.ps1"

    if (-not (Test-Path -LiteralPath $saveReviewPath -PathType Leaf)) {
        Write-RunResult "run_review_codex" $true 1 "리뷰 저장 스크립트를 찾을 수 없습니다: scripts/ai-dev-save-review.ps1"
    }

    $saveReviewOutput = & powershell -ExecutionPolicy Bypass -File $saveReviewPath -ReviewFile $reviewResponseRelativePath 2>&1 | Out-String

    if ($LASTEXITCODE -ne 0) {
        Write-RunResult "run_review_codex" $true 1 "리뷰 JSON은 저장했지만 save-review 실행에 실패했습니다: $($saveReviewOutput.Trim())"
    }
}

$saveReviewMessage = if ($SaveReview) {
    " save-review 흐름까지 실행했습니다."
} else {
    " save-review를 실행하려면 -SaveReview를 사용하세요."
}

Write-RunResult "run_review_codex" $true 0 "Codex 리뷰 실행이 완료되었습니다. 리뷰 JSON: $reviewResponseRelativePath 결과 파일: $resultRelativePath$saveReviewMessage"
