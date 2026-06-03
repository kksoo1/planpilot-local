param(
    [switch]$Json
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$statusRelativePath = "scripts/ai-dev-status.ps1"
$nextRelativePath = "scripts/ai-dev-next.ps1"
$statusPath = Join-Path $PSScriptRoot "ai-dev-status.ps1"
$nextPath = Join-Path $PSScriptRoot "ai-dev-next.ps1"

function Stop-WithError {
    param(
        [string]$Message
    )

    Write-Error $Message
    exit 1
}

foreach ($requiredPath in @($statusRelativePath, $nextRelativePath)) {
    $fullPath = Join-Path $projectRoot $requiredPath

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        Stop-WithError "필수 파일이 없습니다: $requiredPath"
    }
}

if ($Json) {
    $statusOutput = & $statusPath -Json | Out-String
    $statusExitCode = $LASTEXITCODE

    if ($statusExitCode -ne 0) {
        Stop-WithError "ai-dev-status.ps1 실행에 실패했습니다. exit code: $statusExitCode"
    }

    $nextOutput = & $nextPath -Json | Out-String
    $nextExitCode = $LASTEXITCODE

    if ($nextExitCode -ne 0) {
        Stop-WithError "ai-dev-next.ps1 실행에 실패했습니다. exit code: $nextExitCode"
    }

    try {
        $statusJson = $statusOutput | ConvertFrom-Json
    } catch {
        Stop-WithError "ai-dev-status.ps1 JSON 파싱에 실패했습니다: $($_.Exception.Message)"
    }

    try {
        $nextJson = $nextOutput | ConvertFrom-Json
    } catch {
        Stop-WithError "ai-dev-next.ps1 JSON 파싱에 실패했습니다: $($_.Exception.Message)"
    }

    [ordered]@{
        status = $statusJson
        next = $nextJson
    } | ConvertTo-Json -Depth 30

    exit 0
}

Write-Host "=== AI Dev Status ==="
& $statusPath
$statusExitCode = $LASTEXITCODE

if ($statusExitCode -ne 0) {
    Stop-WithError "ai-dev-status.ps1 실행에 실패했습니다. exit code: $statusExitCode"
}

Write-Host ""
Write-Host "========================================"
Write-Host ""
Write-Host "=== AI Dev Next Action ==="
& $nextPath
$nextExitCode = $LASTEXITCODE

if ($nextExitCode -ne 0) {
    Stop-WithError "ai-dev-next.ps1 실행에 실패했습니다. exit code: $nextExitCode"
}

Write-Host ""
Write-Host "========================================"
Write-Host ""
Write-Host "관련 파일:"

$relatedFiles = @(
    ".ai-dev/current-task-prompt.md",
    ".ai-dev/review-prompt.md",
    ".ai-dev/revise-prompt.md",
    ".ai-dev/test-result.md",
    ".ai-dev/diff.md",
    ".ai-dev/review.md"
)

foreach ($relativePath in $relatedFiles) {
    $exists = Test-Path -LiteralPath (Join-Path $projectRoot $relativePath) -PathType Leaf
    $statusText = if ($exists) { "있음" } else { "없음" }
    Write-Host "  - $relativePath`: $statusText"
}
