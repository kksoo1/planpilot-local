param(
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowDirty,
    [switch]$GeneratePromptIfMissing,
    [string]$PromptPath = ".ai-dev/current-task-prompt.md",
    [string]$ResultPath = ".ai-dev/codex-result.md"
)

. "$PSScriptRoot\ai-dev-env.ps1"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
$codeFence = '```'

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
        Write-RunResult "run_codex" $false 1 $message
    }

    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
}

function Get-GitStatusPath {
    param(
        [string]$StatusLine
    )

    if ($StatusLine.Length -lt 4) {
        return $StatusLine.Trim().Replace("\", "/")
    }

    $path = $StatusLine.Substring(3).Trim()

    if ($path.Contains(" -> ")) {
        $path = ($path -split " -> ")[-1].Trim()
    }

    return $path.Replace("\", "/")
}

function Test-OnlyAllowedPromptDirty {
    param(
        [string[]]$StatusLines,
        [string]$PromptRelativePath
    )

    if ($StatusLines.Count -eq 0) {
        return $true
    }

    foreach ($line in $StatusLines) {
        $statusPath = Get-GitStatusPath $line

        if ($statusPath -ne $PromptRelativePath) {
            return $false
        }
    }

    return $true
}

function New-CodexPrompt {
    param(
        [string]$BasePrompt
    )

    return @"
$BasePrompt

## Codex CLI Additional Safety Rules

- git commit을 실행하지 않는다.
- git reset, git checkout, git clean을 실행하지 않는다.
- npm install을 실행하지 않는다.
- package.json 또는 package-lock.json을 수정하지 않는다. 꼭 필요하면 작업을 중단하고 이유만 기록한다.
- 현재 task 범위 밖 작업을 하지 않는다.
- build, test, lint는 이 프롬프트가 명시적으로 요청하지 않는 한 실행하지 않는다.
"@
}

Set-Location $repoRoot

$promptRelativePath = ConvertTo-RepoRelativePath $PromptPath
$resultRelativePath = ConvertTo-RepoRelativePath $ResultPath
$resolvedPromptPath = Resolve-RepoPath $PromptPath
$resolvedResultPath = Resolve-RepoPath $ResultPath
$statusLines = @(Get-GitStatusLines)

if ($statusLines.Count -gt 0 -and -not $AllowDirty) {
    if (-not (Test-OnlyAllowedPromptDirty $statusLines $promptRelativePath)) {
        $dirtyText = ($statusLines -join "`n")
        $message = "작업 트리가 dirty 상태라 Codex 실행을 중단합니다. 계속하려면 변경사항을 정리하거나 -AllowDirty를 명시하세요.`n$dirtyText"
        Write-RunResult "run_codex" $false 1 $message
    }
}

if (-not (Test-Path -LiteralPath $resolvedPromptPath -PathType Leaf)) {
    if (-not $GeneratePromptIfMissing) {
        $message = "프롬프트 파일이 없습니다: $promptRelativePath`n먼저 다음 명령을 실행하세요: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1"
        Write-RunResult "run_codex" $false 1 $message
    }

    $makePromptPath = Join-Path $PSScriptRoot "ai-dev-make-prompt.ps1"

    if (-not (Test-Path -LiteralPath $makePromptPath -PathType Leaf)) {
        Write-RunResult "run_codex" $false 1 "프롬프트 생성 스크립트를 찾을 수 없습니다: scripts/ai-dev-make-prompt.ps1"
    }

    $makePromptOutput = & powershell -ExecutionPolicy Bypass -File $makePromptPath 2>&1 | Out-String

    if ($LASTEXITCODE -ne 0) {
        Write-RunResult "run_codex" $false 1 "프롬프트 생성에 실패했습니다: $($makePromptOutput.Trim())"
    }
}

if (-not (Test-Path -LiteralPath $resolvedPromptPath -PathType Leaf)) {
    Write-RunResult "run_codex" $false 1 "프롬프트 파일을 찾을 수 없습니다: $promptRelativePath"
}

$basePrompt = Get-Content -Raw -Encoding UTF8 -LiteralPath $resolvedPromptPath
$codexPrompt = New-CodexPrompt $basePrompt
$commandText = "codex exec <content from $promptRelativePath plus safety rules>"

if ($DryRun) {
    $message = @"
Codex 구현 실행 DryRun입니다.
- Repository: $repoRoot
- Prompt: $promptRelativePath
- Result: $resultRelativePath
- Command: $commandText
- AllowDirty: $([bool]$AllowDirty)
- DirtyCount: $($statusLines.Count)
"@

    Write-RunResult "run_codex" $false 0 $message
}

$codexCommand = Get-Command codex -ErrorAction SilentlyContinue

if ($null -eq $codexCommand) {
    Write-RunResult "run_codex" $false 1 "Codex CLI를 찾을 수 없습니다. codex 명령을 사용할 수 있는지 확인하세요."
}

$startedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$codexOutput = & codex exec $codexPrompt 2>&1 | Out-String
$codexExitCode = $LASTEXITCODE
$endedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$resultContent = @"
# Codex Implementation Result

## Run

- Started at: $startedAt
- Ended at: $endedAt
- Exit code: $codexExitCode
- Prompt: $promptRelativePath
- Command: $commandText

## Output

${codeFence}text
$codexOutput
$codeFence
"@

[System.IO.File]::WriteAllText($resolvedResultPath, $resultContent, $utf8WithBom)

if ($codexExitCode -ne 0) {
    Write-RunResult "run_codex" $true 1 "Codex 실행에 실패했습니다. 결과 파일을 확인하세요: $resultRelativePath"
}

Write-RunResult "run_codex" $true 0 "Codex 실행이 완료되었습니다. 결과 파일: $resultRelativePath"
