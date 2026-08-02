<#
.SYNOPSIS
Runs the Codex review entry point for the AI Dev Loop.

.DESCRIPTION
This is a thin wrapper around scripts/ai-dev-run-review-codex.ps1.
Automation can call this stable path while the existing root script owns
the review execution behavior.

.EXAMPLE
powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -DryRun

.EXAMPLE
powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -AllowDirty -SaveReview
#>

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

$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot "..\.."))
$envPath = Join-Path $repoRoot "scripts\ai-dev-env.ps1"
$reviewRunnerPath = Join-Path $repoRoot "scripts\ai-dev-run-review-codex.ps1"

if (Test-Path -LiteralPath $envPath -PathType Leaf) {
    . $envPath
}

if (-not (Test-Path -LiteralPath $reviewRunnerPath -PathType Leaf)) {
    Write-Error "Codex review runner was not found: scripts/ai-dev-run-review-codex.ps1"
    exit 1
}

$arguments = @(
    "-ExecutionPolicy",
    "Bypass",
    "-File",
    $reviewRunnerPath,
    "-ReviewPromptPath",
    $ReviewPromptPath,
    "-ReviewResponsePath",
    $ReviewResponsePath,
    "-ResultPath",
    $ResultPath
)

if ($DryRun) {
    $arguments += "-DryRun"
}

if ($Json) {
    $arguments += "-Json"
}

if ($AllowDirty) {
    $arguments += "-AllowDirty"
}

if ($GenerateReviewPromptIfMissing) {
    $arguments += "-GenerateReviewPromptIfMissing"
}

if ($SaveReview) {
    $arguments += "-SaveReview"
}

& powershell -NoProfile @arguments
exit $LASTEXITCODE
