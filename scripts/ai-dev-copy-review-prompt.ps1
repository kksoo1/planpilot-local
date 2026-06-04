param(
    [switch]$GenerateIfMissing,
    [switch]$Strict,
    [switch]$Json
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$reviewPromptRelativePath = ".ai-dev/review-prompt.md"
$reviewPromptPath = Join-Path $projectRoot $reviewPromptRelativePath
$makeReviewPromptPath = Join-Path $PSScriptRoot "ai-dev-make-review-prompt.ps1"
$saveReviewCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard"

function Write-CopyResult {
    param(
        [bool]$Copied,
        [bool]$Generated,
        [string]$Message,
        [string[]]$RecommendedCommands,
        [int]$ExitCode
    )

    if ($Json) {
        [ordered]@{
            copied = $Copied
            generated = $Generated
            reviewPromptPath = $reviewPromptRelativePath
            message = $Message
            recommendedCommands = @($RecommendedCommands)
        } | ConvertTo-Json -Depth 10
        exit $ExitCode
    }

    Write-Host $Message

    if ($Copied) {
        Write-Host "붙여넣을 위치: ChatGPT 웹 화면"
        Write-Host "ChatGPT가 리뷰 결과를 JSON만 출력하도록 요청하세요."
        Write-Host "리뷰 JSON을 받은 뒤 다음 명령을 실행하세요."
        Write-Host "  $saveReviewCommand"
    } elseif ($RecommendedCommands.Count -gt 0) {
        Write-Host "추천 명령:"
        foreach ($command in $RecommendedCommands) {
            Write-Host "  $command"
        }
    }

    exit $ExitCode
}

function Copy-ReviewPromptToClipboard {
    param(
        [string]$Path
    )

    try {
        $content = Get-Content -Raw -Encoding UTF8 -LiteralPath $Path
        Set-Clipboard -Value $content
    } catch {
        Write-CopyResult `
            $false `
            $false `
            "review-prompt.md 클립보드 복사에 실패했습니다: $($_.Exception.Message)" `
            @() `
            1
    }
}

$generated = $false

if (-not (Test-Path -LiteralPath $reviewPromptPath -PathType Leaf)) {
    if (-not $GenerateIfMissing) {
        $commands = @(
            "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1",
            "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1"
        )

        Write-CopyResult `
            $false `
            $false `
            "review-prompt.md가 없습니다. 먼저 리뷰 프롬프트를 생성하세요." `
            $commands `
            1
    }

    if (-not (Test-Path -LiteralPath $makeReviewPromptPath -PathType Leaf)) {
        Write-CopyResult `
            $false `
            $false `
            "리뷰 프롬프트 생성 스크립트를 찾을 수 없습니다: scripts/ai-dev-make-review-prompt.ps1" `
            @() `
            1
    }

    $arguments = @()

    if ($Strict) {
        $arguments += "-Strict"
    }

    $makeReviewOutput = & powershell -ExecutionPolicy Bypass -File $makeReviewPromptPath @arguments 2>&1 | Out-String

    if ($LASTEXITCODE -ne 0) {
        Write-CopyResult `
            $false `
            $false `
            "review-prompt.md 생성에 실패했습니다: $($makeReviewOutput.Trim())" `
            @() `
            1
    }

    $generated = $true
}

if (-not (Test-Path -LiteralPath $reviewPromptPath -PathType Leaf)) {
    Write-CopyResult `
        $false `
        $generated `
        "review-prompt.md를 찾을 수 없습니다: $reviewPromptRelativePath" `
        @() `
        1
}

Copy-ReviewPromptToClipboard $reviewPromptPath

$message = if ($generated) {
    "review-prompt.md를 생성하고 클립보드에 복사했습니다."
} else {
    "review-prompt.md를 클립보드에 복사했습니다."
}

Write-CopyResult `
    $true `
    $generated `
    $message `
    @($saveReviewCommand) `
    0
