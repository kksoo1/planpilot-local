param(
    [switch]$IncludeUntrackedContent
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$stateRelativePath = ".ai-dev/state.json"
$diffRelativePath = ".ai-dev/diff.md"
$statePath = Join-Path $projectRoot $stateRelativePath
$diffPath = Join-Path $projectRoot $diffRelativePath
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
$maxUntrackedFileSize = 200KB

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

function Save-StateResult {
    param(
        [object]$State,
        [string]$Status,
        [string]$ErrorSummary
    )

    Set-ObjectProperty $State "lastCommand" "save-diff"
    Set-ObjectProperty $State "lastCommandStatus" $Status
    Set-ObjectProperty $State "lastErrorSummary" $ErrorSummary
    Set-ObjectProperty $State "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))

    $stateJson = $State | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)
}

function Invoke-GitCapture {
    param(
        [string[]]$Arguments,
        [string]$DisplayName
    )

    $output = & git @Arguments 2>&1 | Out-String
    $exitCode = $LASTEXITCODE

    if ($exitCode -ne 0) {
        throw "$DisplayName 실행에 실패했습니다. exit code: $exitCode`n$output"
    }

    return $output.TrimEnd()
}

function Convert-ToCodeBlock {
    param(
        [string]$Content
    )

    $codeFence = '```'
    $text = if ([string]::IsNullOrWhiteSpace($Content)) { "변경 없음" } else { $Content }

    return "${codeFence}text`r`n$text`r`n$codeFence"
}

function Get-UntrackedFileSections {
    param(
        [string]$RepositoryRoot,
        [string]$PorcelainStatus
    )

    $sections = @()
    $repositoryRootFullPath = [System.IO.Path]::GetFullPath($RepositoryRoot).TrimEnd('\', '/') + [System.IO.Path]::DirectorySeparatorChar
    $untrackedLines = @($PorcelainStatus -split "`r?`n" | Where-Object { $_ -like "?? *" })

    foreach ($line in $untrackedLines) {
        $relativePath = $line.Substring(3).Trim()
        $sectionTitle = "### $relativePath"

        if ($relativePath.StartsWith('"') -and $relativePath.EndsWith('"')) {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 따옴표로 인코딩된 경로는 자동 읽기 대상에서 제외합니다."
            continue
        }

        try {
            $fullPath = [System.IO.Path]::GetFullPath((Join-Path $RepositoryRoot $relativePath))
        } catch {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 경로를 해석할 수 없습니다."
            continue
        }

        if (-not $fullPath.StartsWith($repositoryRootFullPath, [System.StringComparison]::OrdinalIgnoreCase)) {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 저장소 밖 경로입니다."
            continue
        }

        if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 파일이 아니거나 읽을 수 없습니다."
            continue
        }

        try {
            $fileInfo = Get-Item -LiteralPath $fullPath

            if ($fileInfo.Length -gt $maxUntrackedFileSize) {
                $sections += "$sectionTitle`r`n`r`n내용 생략: 파일 크기가 200KB를 초과합니다."
                continue
            }

            $bytes = [System.IO.File]::ReadAllBytes($fullPath)

            if ($bytes -contains 0) {
                $sections += "$sectionTitle`r`n`r`n내용 생략: 바이너리 파일로 판단했습니다."
                continue
            }

            $content = [System.Text.Encoding]::UTF8.GetString($bytes)
            $sections += "$sectionTitle`r`n`r`n$(Convert-ToCodeBlock $content)"
        } catch {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 파일 읽기에 실패했습니다."
        }
    }

    if ($sections.Count -eq 0) {
        return @("추적되지 않은 파일이 없습니다.")
    }

    return $sections
}

if (-not (Test-Path -LiteralPath $statePath -PathType Leaf)) {
    Stop-WithError "필수 파일이 없습니다: $stateRelativePath"
}

$state = Read-JsonFile $statePath $stateRelativePath

try {
    $repositoryRoot = Invoke-GitCapture -Arguments @("rev-parse", "--show-toplevel") -DisplayName "git rev-parse --show-toplevel"
} catch {
    Save-StateResult $state "failed" $_.Exception.Message
    Stop-WithError "현재 위치가 git repository가 아닙니다."
}

try {
    $statusShort = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "git status --short"
    $statusPorcelain = Invoke-GitCapture -Arguments @("status", "--porcelain") -DisplayName "git status --porcelain"
    $unstagedStat = Invoke-GitCapture -Arguments @("diff", "--stat") -DisplayName "git diff --stat"
    $unstagedDiff = Invoke-GitCapture -Arguments @("diff") -DisplayName "git diff"
    $stagedStat = Invoke-GitCapture -Arguments @("diff", "--staged", "--stat") -DisplayName "git diff --staged --stat"
    $stagedDiff = Invoke-GitCapture -Arguments @("diff", "--staged") -DisplayName "git diff --staged"

    $generatedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $sections = @(
        "# AI Dev Diff",
        "## Generated At`r`n`r`n$generatedAt",
        "## Git Status`r`n`r`n$(Convert-ToCodeBlock $statusShort)",
        "## Unstaged Diff Stat`r`n`r`n$(Convert-ToCodeBlock $unstagedStat)",
        "## Unstaged Diff`r`n`r`n$(Convert-ToCodeBlock $unstagedDiff)",
        "## Staged Diff Stat`r`n`r`n$(Convert-ToCodeBlock $stagedStat)",
        "## Staged Diff`r`n`r`n$(Convert-ToCodeBlock $stagedDiff)"
    )

    if ($IncludeUntrackedContent) {
        $untrackedSections = Get-UntrackedFileSections $repositoryRoot $statusPorcelain
        $sections += "## Untracked File Content`r`n`r`n$($untrackedSections -join "`r`n`r`n")"
    }

    $diffContent = $sections -join "`r`n`r`n"
    [System.IO.File]::WriteAllText($diffPath, $diffContent, $utf8WithBom)
    Save-StateResult $state "passed" ""
} catch {
    Save-StateResult $state "failed" $_.Exception.Message
    Stop-WithError "git diff 저장에 실패했습니다: $($_.Exception.Message)"
}

Write-Host "git diff 저장 완료: $diffRelativePath"
Write-Host "상태 저장 완료: $stateRelativePath"
