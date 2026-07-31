$ErrorActionPreference = "Stop"

[Console]::OutputEncoding = New-Object System.Text.UTF8Encoding($false)
$OutputEncoding = [Console]::OutputEncoding

$repoRoot = Split-Path -Parent $PSScriptRoot

$script:PassedCount = 0
$script:FailedCount = 0

function Write-TestResult {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [bool]$Passed,

        [string]$Detail = ""
    )

    if ($Passed) {
        $script:PassedCount++
        Write-Host "[PASS] $Name"

        if (-not [string]::IsNullOrWhiteSpace($Detail)) {
            Write-Host "       $Detail"
        }

        return
    }

    $script:FailedCount++
    Write-Host "[FAIL] $Name"

    if (-not [string]::IsNullOrWhiteSpace($Detail)) {
        Write-Host "       $Detail"
    }
}

function Get-ChangedPaths {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Root
    )

    $statusLines = @(& git -C $Root status --porcelain)

    return @(
        $statusLines |
            Where-Object { $_.Length -ge 4 } |
            ForEach-Object { $_.Substring(3).Trim() }
    )
}

function New-IsolatedScenarioRoot {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [string]$Root
    )

    $previousErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = "Continue"

    try {
        $worktreeOutput = & git -C $repoRoot worktree add --detach $Root HEAD 2>&1 | Out-String
        $worktreeExitCode = $LASTEXITCODE
    }
    finally {
        $ErrorActionPreference = $previousErrorActionPreference
    }

    if ($worktreeExitCode -eq 0) {
        return [PSCustomObject][ordered]@{
            Path = $Root
            Cleanup = "worktree"
            Error = ""
        }
    }

    if ([System.IO.Directory]::Exists($Root)) {
        [System.IO.Directory]::Delete($Root, $true)
    }

    $previousErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = "Continue"

    try {
        $cloneOutput = & git clone --no-local --quiet $repoRoot $Root 2>&1 | Out-String
        $cloneExitCode = $LASTEXITCODE
    }
    finally {
        $ErrorActionPreference = $previousErrorActionPreference
    }

    if ($cloneExitCode -eq 0) {
        return [PSCustomObject][ordered]@{
            Path = $Root
            Cleanup = "directory"
            Error = ""
        }
    }

    return [PSCustomObject][ordered]@{
        Path = $Root
        Cleanup = "none"
        Error = (
            "git worktree add failed: " +
            $worktreeOutput.Trim() +
            "`n" +
            "git clone fallback failed: " +
            $cloneOutput.Trim()
        )
    }
}

function Remove-IsolatedScenarioRoot {
    param(
        [Parameter(Mandatory = $true)]
        [object]$ScenarioRoot
    )

    if ($ScenarioRoot.Cleanup -eq "worktree") {
        & git -C $repoRoot worktree remove $ScenarioRoot.Path --force |
            Out-Null
        return
    }

    if ($ScenarioRoot.Cleanup -eq "directory" -and [System.IO.Directory]::Exists($ScenarioRoot.Path)) {
        Get-ChildItem -LiteralPath $ScenarioRoot.Path -Recurse -Force |
            ForEach-Object {
                $_.Attributes = [System.IO.FileAttributes]::Normal
            }

        [System.IO.Directory]::Delete($ScenarioRoot.Path, $true)
    }
}

function Test-MaxStepsForwarding {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Content
    )

    $forwardingPatterns = @(
        '-MaxSteps\s+(?:\(\s*)?(?:\[string\]\s*)?\$MaxSteps',
        '["'']-MaxSteps["'']\s*,\s*(?:\(\s*)?(?:\[string\]\s*)?\$MaxSteps'
    )

    foreach ($pattern in $forwardingPatterns) {
        if ([regex]::IsMatch($Content, $pattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)) {
            return $true
        }
    }

    return $false
}

function Invoke-IsolatedScenario {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [string]$ExpectedReason,

        [Parameter(Mandatory = $true)]
        [ValidateSet(
            "none",
            "dirty_worktree",
            "baseline_output_conflict"
        )]
        [string]$SetupType,

        [Parameter(Mandatory = $true)]
        [string[]]$CommandArguments
    )

    $tmpRoot = Join-Path $env:TEMP (
        "planpilot-test-" +
        $Name +
        "-" +
        (Get-Date -Format "yyyyMMddHHmmssfff")
    )

    $scenarioRoot = New-IsolatedScenarioRoot -Name $Name -Root $tmpRoot

    if ($scenarioRoot.Cleanup -eq "none") {
        Write-TestResult `
            -Name "$Name isolated repository creation" `
            -Passed $false `
            -Detail $scenarioRoot.Error

        return
    }

    try {
        Copy-Item `
            -LiteralPath (
                Join-Path $repoRoot "scripts\ai-dev-auto-goal.ps1"
            ) `
            -Destination (
                Join-Path $tmpRoot "scripts\ai-dev-auto-goal.ps1"
            ) `
            -Force

        Copy-Item `
            -LiteralPath (
                Join-Path $repoRoot "scripts\ai-dev-autopilot.ps1"
            ) `
            -Destination (
                Join-Path $tmpRoot "scripts\ai-dev-autopilot.ps1"
            ) `
            -Force

        $marker = (
            "BASELINE_USER_CHANGE_" +
            $Name +
            "_" +
            (Get-Date -Format "yyyyMMddHHmmssfff")
        )

        $markerPath = $null

        if ($SetupType -eq "dirty_worktree") {
            $markerPath = Join-Path $tmpRoot ".ai-dev\loop-log.md"

            Add-Content `
                -LiteralPath $markerPath `
                -Encoding UTF8 `
                -Value $marker
        }

        if ($SetupType -eq "baseline_output_conflict") {
            $markerPath = Join-Path $tmpRoot ".ai-dev\codex-result.md"

            Add-Content `
                -LiteralPath $markerPath `
                -Encoding UTF8 `
                -Value $marker
        }

        $baselinePaths = @(Get-ChangedPaths -Root $tmpRoot)

        Push-Location $tmpRoot

        try {
            $output = & powershell @CommandArguments 2>&1
            $scenarioExitCode = $LASTEXITCODE
            $outputText = $output | Out-String
        }
        finally {
            Pop-Location
        }

        $afterPaths = @(Get-ChangedPaths -Root $tmpRoot)

        $newDirtyPaths = @(
            $afterPaths |
                Where-Object { $_ -notin $baselinePaths }
        )

        $stagedPaths = @(
            & git -C $tmpRoot diff --cached --name-only
        )

        $reasonMatched = $outputText.Contains(
            "Stopped reason: $ExpectedReason"
        )

        $classificationMatched = $outputText.Contains(
            "expected_non_work"
        )

        $markerPreserved = $true

        if ($null -ne $markerPath) {
            $markerContent = Get-Content `
                -LiteralPath $markerPath `
                -Raw

            $markerPreserved = $markerContent.Contains($marker)
        }

        Write-TestResult `
            -Name "$Name stopped reason" `
            -Passed $reasonMatched `
            -Detail "Expected=$ExpectedReason ExitCode=$scenarioExitCode"

        Write-TestResult `
            -Name "$Name expected_non_work classification" `
            -Passed $classificationMatched

        Write-TestResult `
            -Name "$Name baseline marker preservation" `
            -Passed $markerPreserved

        Write-TestResult `
            -Name "$Name no new dirty paths" `
            -Passed ($newDirtyPaths.Count -eq 0) `
            -Detail (
                "NewDirtyPaths=" +
                ($newDirtyPaths -join ", ")
            )

        Write-TestResult `
            -Name "$Name no staged paths" `
            -Passed ($stagedPaths.Count -eq 0) `
            -Detail (
                "StagedPaths=" +
                ($stagedPaths -join ", ")
            )
    }
    catch {
        Write-TestResult `
            -Name "$Name execution" `
            -Passed $false `
            -Detail $_.Exception.Message
    }
    finally {
        Remove-IsolatedScenarioRoot -ScenarioRoot $scenarioRoot
    }
}

Write-Host "AI Dev automation tests"
Write-Host "Repository: $repoRoot"
Write-Host ""

$autoGoalPath = Join-Path $repoRoot "scripts\ai-dev-auto-goal.ps1"
$autoGoalContent = Get-Content -LiteralPath $autoGoalPath -Raw

$maxStepsMatch = [regex]::Match(
    $autoGoalContent,
    '\$MaxSteps\s*=\s*(\d+)'
)

$defaultMaxStepsValid = $false
$defaultMaxStepsValue = 0

if ($maxStepsMatch.Success) {
    $defaultMaxStepsValue = [int]$maxStepsMatch.Groups[1].Value
    $defaultMaxStepsValid = ($defaultMaxStepsValue -ge 40)
}

Write-TestResult `
    -Name "auto-goal MaxSteps default is at least 40" `
    -Passed $defaultMaxStepsValid `
    -Detail "Detected=$defaultMaxStepsValue"

$maxStepsForwarded = Test-MaxStepsForwarding -Content $autoGoalContent

Write-TestResult `
    -Name "auto-goal forwards user MaxSteps" `
    -Passed $maxStepsForwarded `
    -Detail "Accepted forms: direct argument, array argument, or splatted helper arguments"

Invoke-IsolatedScenario `
    -Name "all-goal-candidates-excluded" `
    -ExpectedReason "all_goal_candidates_excluded" `
    -SetupType "none" `
    -CommandArguments @(
        "-ExecutionPolicy", "Bypass",
        "-File", ".\scripts\ai-dev-autopilot.ps1",
        "-AllowRun",
        "-AllowDirty",
        "-MaxGoals", "1",
        "-MaxTasks", "1",
        "-MaxSteps", "40"
    )

Invoke-IsolatedScenario `
    -Name "dirty-worktree" `
    -ExpectedReason "dirty_worktree" `
    -SetupType "dirty_worktree" `
    -CommandArguments @(
        "-ExecutionPolicy", "Bypass",
        "-File", ".\scripts\ai-dev-auto-goal.ps1",
        "-GoalTitle", "Dirty worktree test",
        "-GoalDescription", "Verify expected non-work cleanup.",
        "-MaxTasks", "1",
        "-MaxSteps", "40"
    )

Invoke-IsolatedScenario `
    -Name "baseline-output-conflict" `
    -ExpectedReason "baseline_output_conflict" `
    -SetupType "baseline_output_conflict" `
    -CommandArguments @(
        "-ExecutionPolicy", "Bypass",
        "-File", ".\scripts\ai-dev-auto-goal.ps1",
        "-GoalTitle", "Baseline conflict test",
        "-GoalDescription", "Verify protected output preservation.",
        "-MaxTasks", "1",
        "-MaxSteps", "40"
    )

Write-Host ""
Write-Host (
    "Test summary: Passed={0}, Failed={1}" -f `
        $script:PassedCount,
        $script:FailedCount
)

if ($script:FailedCount -gt 0) {
    exit 1
}

exit 0
