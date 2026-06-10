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
$aiDevOperationalRoot = ".ai-dev/"
$reviewDiffPathspecExcludes = @(":(exclude).ai-dev/**")

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

    $argumentText = ($Arguments | ForEach-Object {
        if ($_ -match '[\s"]') {
            '"' + $_.Replace('"', '\"') + '"'
        } else {
            $_
        }
    }) -join " "

    $startInfo = New-Object System.Diagnostics.ProcessStartInfo
    $startInfo.FileName = "git"
    $startInfo.Arguments = $argumentText
    $startInfo.UseShellExecute = $false
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    $startInfo.CreateNoWindow = $true

    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $startInfo

    if (-not $process.Start()) {
        throw "$DisplayName 실행을 시작하지 못했습니다."
    }

    $output = $process.StandardOutput.ReadToEnd()
    $errorOutput = $process.StandardError.ReadToEnd()
    $process.WaitForExit()
    $exitCode = $process.ExitCode

    if ($exitCode -ne 0) {
        throw "$DisplayName 실행에 실패했습니다. exit code: $exitCode`n$errorOutput"
    }

    if (-not [string]::IsNullOrWhiteSpace($errorOutput)) {
        Write-Warning "$DisplayName 경고: $($errorOutput.Trim())"
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

function Test-IsAiDevOperationalPath {
    param(
        [string]$RelativePath
    )

    $normalizedRelativePath = $RelativePath.Replace('\', '/')
    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::OrdinalIgnoreCase)
}

function Get-ChangedPathsFromPorcelain {
    param(
        [string]$PorcelainStatus
    )

    $paths = @()
    $statusLines = @($PorcelainStatus -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })

    foreach ($line in $statusLines) {
        if ($line.StartsWith("?? ")) {
            $paths += $line.Substring(3)
            continue
        }

        if ($line.Length -lt 4) {
            continue
        }

        $relativePath = $line.Substring(3)
        $paths += $relativePath
    }

    return @($paths | Select-Object -Unique)
}

function Convert-ToFileList {
    param(
        [string[]]$Paths
    )

    if ($null -eq $Paths -or $Paths.Count -eq 0) {
        return "- 없음"
    }

    return ($Paths | ForEach-Object { "- $_" }) -join "`r`n"
}

function Get-UntrackedFileSections {
    param(
        [string]$RepositoryRoot,
        [string]$PorcelainStatus
    )

    $sections = @()
    $skippedGeneratedArtifacts = @()
    $repositoryRootFullPath = [System.IO.Path]::GetFullPath($RepositoryRoot).TrimEnd('\', '/') + [System.IO.Path]::DirectorySeparatorChar
    $untrackedLines = @($PorcelainStatus -split "`r?`n" | Where-Object { $_.StartsWith("?? ") })

    foreach ($line in $untrackedLines) {
        $relativePath = $line.Substring(3)
        $sectionTitle = "### $relativePath"
        $normalizedRelativePath = $relativePath.Replace('\', '/')

        if ($relativePath.StartsWith('"') -and $relativePath.EndsWith('"')) {
            $sections += "$sectionTitle`r`n`r`n내용 생략: 따옴표로 인코딩된 경로는 자동 읽기 대상에서 제외합니다."
            continue
        }

        if (Test-IsAiDevOperationalPath $normalizedRelativePath) {
            $skippedGeneratedArtifacts += $relativePath
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
        $sections = @("내용을 포함할 추적되지 않은 텍스트 파일이 없습니다.")
    }

    return [PSCustomObject]@{
        ContentSections = $sections
        SkippedGeneratedArtifacts = $skippedGeneratedArtifacts
    }
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
    $diffPathspecArguments = @("--", ".") + $reviewDiffPathspecExcludes
    $unstagedStat = Invoke-GitCapture -Arguments (@("diff", "--stat") + $diffPathspecArguments) -DisplayName "git diff --stat"
    $unstagedDiff = Invoke-GitCapture -Arguments (@("diff") + $diffPathspecArguments) -DisplayName "git diff"
    $stagedStat = Invoke-GitCapture -Arguments (@("diff", "--staged", "--stat") + $diffPathspecArguments) -DisplayName "git diff --staged --stat"
    $stagedDiff = Invoke-GitCapture -Arguments (@("diff", "--staged") + $diffPathspecArguments) -DisplayName "git diff --staged"
    $changedPaths = Get-ChangedPathsFromPorcelain $statusPorcelain
    $appChangePaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOperationalPath $_) })
    $aiDevOperationalPaths = @($changedPaths | Where-Object { Test-IsAiDevOperationalPath $_ })

    $generatedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $sections = @(
        "# AI Dev Diff",
        "## Generated At`r`n`r`n$generatedAt",
        "## Git Status`r`n`r`n$(Convert-ToCodeBlock $statusShort)",
        "## App Change Files`r`n`r`n$(Convert-ToFileList $appChangePaths)",
        "## AI Dev Operational Artifact Files`r`n`r`n$(Convert-ToFileList $aiDevOperationalPaths)",
        "## Review Diff Scope`r`n`r`n아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 `.ai-dev` 운영 산출물 diff를 제외합니다. `.ai-dev` 변경은 위 운영 산출물 목록에서 별도로 확인합니다.",
        "## Unstaged Diff Stat`r`n`r`n$(Convert-ToCodeBlock $unstagedStat)",
        "## Unstaged Diff`r`n`r`n$(Convert-ToCodeBlock $unstagedDiff)",
        "## Staged Diff Stat`r`n`r`n$(Convert-ToCodeBlock $stagedStat)",
        "## Staged Diff`r`n`r`n$(Convert-ToCodeBlock $stagedDiff)"
    )

    if ($IncludeUntrackedContent) {
        $untrackedResult = Get-UntrackedFileSections $repositoryRoot $statusPorcelain
        $sections += "## Untracked File Content`r`n`r`n$($untrackedResult.ContentSections -join "`r`n`r`n")"

        if ($untrackedResult.SkippedGeneratedArtifacts.Count -gt 0) {
            $skippedArtifactList = $untrackedResult.SkippedGeneratedArtifacts | ForEach-Object { "- $_" }
            $sections += "## Skipped Generated AI Dev Artifacts`r`n`r`n$($skippedArtifactList -join "`r`n")"
        }
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

if (-not $IncludeUntrackedContent) {
    Write-Host "untracked 파일 내용이 필요하면 -IncludeUntrackedContent 옵션을 사용하세요."
}
