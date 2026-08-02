param(
    [switch]$BuildOnly,
    [switch]$SkipBuild,
    [switch]$SkipTest,
    [switch]$SkipLint,
    [switch]$ManualSummaryOnly,
    [string]$ManualSummary
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$packageRelativePath = "package.json"
$stateRelativePath = ".ai-dev/state.json"
$testResultRelativePath = ".ai-dev/test-result.md"

$packagePath = Join-Path $projectRoot $packageRelativePath
$statePath = Join-Path $projectRoot $stateRelativePath
$testResultPath = Join-Path $projectRoot $testResultRelativePath
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

function Test-HasScript {
    param(
        [object]$Package,
        [string]$Name
    )

    return $null -ne $Package.scripts -and ($Package.scripts.PSObject.Properties.Name -contains $Name)
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

function Invoke-NpmCheck {
    param(
        [string]$Name,
        [bool]$ShouldRun,
        [string]$SkipReason
    )

    $command = "npm run $Name"

    if (-not $ShouldRun) {
        return [PSCustomObject]@{
            Name = $Name
            Command = $command
            Status = "skipped"
            ExitCode = $null
            Log = $SkipReason
        }
    }

    Write-Host "실행 중: $command"
    $output = & npm.cmd run $Name 2>&1 | Out-String
    $exitCode = $LASTEXITCODE
    $status = if ($exitCode -eq 0) { "passed" } else { "failed" }

    return [PSCustomObject]@{
        Name = $Name
        Command = $command
        Status = $status
        ExitCode = $exitCode
        Log = $output.TrimEnd()
    }
}

$requiredPaths = if ($ManualSummaryOnly) {
    @($stateRelativePath, $testResultRelativePath)
} else {
    @($packageRelativePath, $stateRelativePath, $testResultRelativePath)
}

foreach ($requiredPath in $requiredPaths) {
    $fullPath = Join-Path $projectRoot $requiredPath

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        Stop-WithError "필수 파일이 없습니다: $requiredPath"
    }
}

$state = Read-JsonFile $statePath $stateRelativePath

if ($ManualSummaryOnly) {
    if ([string]::IsNullOrWhiteSpace($ManualSummary)) {
        Stop-WithError "-ManualSummaryOnly를 사용할 때는 -ManualSummary 내용을 입력해야 합니다."
    }

    $currentTaskId = if ($null -ne $state.currentTaskId -and -not [string]::IsNullOrWhiteSpace([string]$state.currentTaskId)) {
        [string]$state.currentTaskId
    } else {
        "없음"
    }

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $codeFence = '```'
    $testResultContent = @"
# AI Dev Test Result

## $timestamp

- Overall result: recorded
- Current task: $currentTaskId
- Mode: manual-summary
- Commands:
  - npm run build: skipped
  - npm run test: skipped
  - npm run lint: skipped

### Manual Verification Summary

${codeFence}text
$ManualSummary
$codeFence
"@

    [System.IO.File]::WriteAllText($testResultPath, $testResultContent, $utf8WithBom)

    $now = [DateTimeOffset]::UtcNow.ToString("o")
    Set-ObjectProperty $state "lastCommand" "manual-summary"
    Set-ObjectProperty $state "lastCommandStatus" "passed"
    Set-ObjectProperty $state "lastErrorSummary" ""
    Set-ObjectProperty $state "updatedAt" $now

    $stateJson = $state | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)

    Write-Host "수동 검증 요약 기록 완료: $testResultRelativePath"
    Write-Host "상태 저장 완료: $stateRelativePath"
    exit 0
}

$package = Read-JsonFile $packagePath $packageRelativePath

$hasBuild = Test-HasScript $package "build"
$hasTest = Test-HasScript $package "test"
$hasLint = Test-HasScript $package "lint"

$runBuild = $hasBuild -and -not $SkipBuild
$runTest = $hasTest -and -not $SkipTest -and -not $BuildOnly
$runLint = $hasLint -and -not $SkipLint

$buildSkipReason = if (-not $hasBuild) {
    "package.json에 build script가 없습니다."
} elseif ($SkipBuild) {
    "-SkipBuild 옵션으로 건너뛰었습니다."
} else {
    ""
}

$testSkipReason = if (-not $hasTest) {
    "package.json에 test script가 없습니다."
} elseif ($SkipTest) {
    "-SkipTest 옵션으로 건너뛰었습니다."
} elseif ($BuildOnly) {
    "-BuildOnly 옵션으로 건너뛰었습니다."
} else {
    ""
}

$lintSkipReason = if (-not $hasLint) {
    "package.json에 lint script가 없습니다."
} elseif ($SkipLint) {
    "-SkipLint 옵션으로 건너뛰었습니다."
} else {
    ""
}

$results = @(
    Invoke-NpmCheck "build" $runBuild $buildSkipReason
    Invoke-NpmCheck "test" $runTest $testSkipReason
    Invoke-NpmCheck "lint" $runLint $lintSkipReason
)

$failedResults = @($results | Where-Object { $_.Status -eq "failed" })
$executedResults = @($results | Where-Object { $_.Status -ne "skipped" })
$overallResult = if ($failedResults.Count -gt 0) { "failed" } else { "passed" }
$currentTaskId = if ($null -ne $state.currentTaskId -and -not [string]::IsNullOrWhiteSpace([string]$state.currentTaskId)) {
    [string]$state.currentTaskId
} else {
    "없음"
}

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$modeText = if ($BuildOnly) { "BuildOnly (build + lint when available)" } else { "standard" }
$commandSummary = ($results | ForEach-Object { "  - $($_.Command): $($_.Status)" }) -join "`r`n"
$detailSections = @()
$codeFence = '```'

foreach ($result in $results) {
    $logText = if ([string]::IsNullOrWhiteSpace($result.Log)) { "출력 없음" } else { $result.Log }
    $exitCodeText = if ($null -eq $result.ExitCode) { "없음" } else { [string]$result.ExitCode }

    $detailSections += @"
### $($result.Command)

- Status: $($result.Status)
- Exit code: $exitCodeText

${codeFence}text
$logText
$codeFence
"@
}

$testResultContent = @"
# AI Dev Test Result

## $timestamp

- Overall result: $overallResult
- Current task: $currentTaskId
- Mode: $modeText
- Commands:
$commandSummary

$($detailSections -join "`r`n")
"@

[System.IO.File]::WriteAllText($testResultPath, $testResultContent, $utf8WithBom)

$now = [DateTimeOffset]::UtcNow.ToString("o")
$lastCommand = if ($executedResults.Count -gt 0) {
    $executedResults[-1].Command
} else {
    "ai-dev-check"
}
$lastCommandStatus = if ($executedResults.Count -eq 0) {
    "skipped"
} else {
    $overallResult
}
$lastErrorSummary = if ($failedResults.Count -gt 0) {
    ($failedResults | ForEach-Object { "$($_.Command) exit code $($_.ExitCode)" }) -join "; "
} else {
    ""
}

Set-ObjectProperty $state "lastCommand" $lastCommand
Set-ObjectProperty $state "lastCommandStatus" $lastCommandStatus
Set-ObjectProperty $state "lastErrorSummary" $lastErrorSummary
Set-ObjectProperty $state "updatedAt" $now

$stateJson = $state | ConvertTo-Json -Depth 20
[System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)

Write-Host "검증 결과: $overallResult"
foreach ($result in $results) {
    Write-Host "  - $($result.Command): $($result.Status)"
}
Write-Host "기록 완료: $testResultRelativePath"
Write-Host "상태 저장 완료: $stateRelativePath"

if ($overallResult -eq "failed") {
    exit 1
}

exit 0
