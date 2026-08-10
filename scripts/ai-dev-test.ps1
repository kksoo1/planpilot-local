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

function Test-MaxStepsForwardingBehavior {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [int]$ExpectedMaxSteps
    )

    $expectedMaxTasks = 3

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

        $fakeBinPath = Join-Path $env:TEMP (
            "planpilot-fake-bin-" +
            $Name +
            "-" +
            (Get-Date -Format "yyyyMMddHHmmssfff")
        )
        [System.IO.Directory]::CreateDirectory($fakeBinPath) | Out-Null

        $fakeCodexPath = Join-Path $fakeBinPath "codex.cmd"
        $fakeAutoCyclePath = Join-Path $tmpRoot "scripts\ai-dev-auto-cycle-full.ps1"
        $forwardedArgsPath = Join-Path $env:TEMP (
            "planpilot-maxsteps-forwarding-args-" +
            $Name +
            "-" +
            (Get-Date -Format "yyyyMMddHHmmssfff") +
            ".txt"
        )
        $childStatusPath = Join-Path $env:TEMP (
            "planpilot-maxsteps-forwarding-child-status-" +
            $Name +
            "-" +
            (Get-Date -Format "yyyyMMddHHmmssfff") +
            ".txt"
        )

        $fakeCodexContent = @'
@echo off
echo {"goalMarkdown":"# Goal","queue":{"goalTitle":"Forwarding test","goalSource":".ai-dev/goal.md","createdAt":"2026-01-01T00:00:00Z","updatedAt":"2026-01-01T00:00:00Z","currentTaskId":"T001","tasks":[{"id":"T001","title":"Forwarding test","description":"Verify MaxSteps forwarding.","type":"implementation","status":"in_progress","priority":"P0","dependsOn":[],"filesLikelyToChange":["scripts/ai-dev-test.ps1"],"verification":["Verify MaxSteps forwarding."],"commitMessage":null}]},"state":{"goalStatus":"in_progress","currentTaskId":"T001","currentLoop":0,"maxLoopsPerTask":2,"repeatedFailureCount":0,"lastCommand":null,"lastCommandStatus":"not_started","lastErrorSummary":null,"lastReviewDecision":"not_started","lastReviewSeverity":null,"lastCommitHash":null,"startedAt":"2026-01-01T00:00:00Z","updatedAt":"2026-01-01T00:00:00Z","stopReason":null}}
'@

        [System.IO.File]::WriteAllText(
            $fakeCodexPath,
            $fakeCodexContent,
            [System.Text.Encoding]::ASCII
        )

        $escapedForwardedArgsPath = $forwardedArgsPath.Replace("'", "''")
        $escapedChildStatusPath = $childStatusPath.Replace("'", "''")
        $fakeAutoCycleContent = @"
param(
    [Parameter(ValueFromRemainingArguments = `$true)]
    [string[]]`$RemainingArguments
)

`$argsToRecord = @(`$RemainingArguments)

if (`$argsToRecord.Count -eq 0) {
    `$argsToRecord = @(`$args)
}

[System.IO.File]::WriteAllLines('$escapedForwardedArgsPath', [string[]]`$argsToRecord)
[System.IO.File]::WriteAllText('$escapedChildStatusPath', 'exit 0', [System.Text.Encoding]::ASCII)

`$statePath = Join-Path (Get-Location) '.ai-dev\state.json'
`$state = Get-Content -LiteralPath `$statePath -Raw | ConvertFrom-Json
`$state.goalStatus = 'completed'
`$stateJson = `$state | ConvertTo-Json -Depth 30
`$utf8WithBom = New-Object System.Text.UTF8Encoding(`$true)
[System.IO.File]::WriteAllText(`$statePath, `$stateJson, `$utf8WithBom)

exit 0
"@

        [System.IO.File]::WriteAllText(
            $fakeAutoCyclePath,
            $fakeAutoCycleContent,
            (New-Object System.Text.UTF8Encoding($true))
        )

        $previousPath = $env:PATH
        $env:PATH = $fakeBinPath + [System.IO.Path]::PathSeparator + $previousPath

        Push-Location $tmpRoot

        try {
            $output = & powershell `
                -NoProfile `
                -ExecutionPolicy Bypass `
                -File ".\scripts\ai-dev-auto-goal.ps1" `
                -GoalTitle "MaxSteps forwarding test" `
                -GoalDescription "Verify custom MaxSteps reaches the child full cycle script." `
                -MaxTasks $expectedMaxTasks `
                -MaxSteps $ExpectedMaxSteps `
                -AllowCodex `
                -AllowReviewCodex `
                -AllowCommit `
                -AllowRun `
                -AllowDirty 2>&1
            $scenarioExitCode = $LASTEXITCODE
            $outputText = $output | Out-String
        }
        finally {
            Pop-Location
            $env:PATH = $previousPath
        }

        $forwardedArgs = @()

        if ([System.IO.File]::Exists($forwardedArgsPath)) {
            $forwardedArgs = @(Get-Content -LiteralPath $forwardedArgsPath)
        }

        $maxStepsIndex = [array]::IndexOf([object[]]$forwardedArgs, "-MaxSteps")
        $actualMaxSteps = ""

        if ($maxStepsIndex -ge 0 -and ($maxStepsIndex + 1) -lt $forwardedArgs.Count) {
            $actualMaxSteps = [string]$forwardedArgs[$maxStepsIndex + 1]
        }

        $maxStepsMatched = ($actualMaxSteps -eq ([string]$ExpectedMaxSteps))
        $maxTasksIndex = [array]::IndexOf([object[]]$forwardedArgs, "-MaxTasks")
        $actualMaxTasks = ""

        if ($maxTasksIndex -ge 0 -and ($maxTasksIndex + 1) -lt $forwardedArgs.Count) {
            $actualMaxTasks = [string]$forwardedArgs[$maxTasksIndex + 1]
        }

        $requiredSwitches = @(
            "-AllowCodex",
            "-AllowReviewCodex",
            "-AllowCommit",
            "-AllowDirty"
        )
        $missingSwitches = @(
            $requiredSwitches |
                Where-Object { $forwardedArgs -notcontains $_ }
        )

        Write-TestResult `
            -Name "$Name forwards MaxSteps $ExpectedMaxSteps to child script" `
            -Passed $maxStepsMatched `
            -Detail (
                "Expected=$ExpectedMaxSteps Actual=$actualMaxSteps ExitCode=$scenarioExitCode Args=" +
                ($forwardedArgs -join " ")
            )

        Write-TestResult `
            -Name "$Name forwards MaxTasks and allow switches" `
            -Passed (
                $actualMaxTasks -eq ([string]$expectedMaxTasks) -and
                $missingSwitches.Count -eq 0
            ) `
            -Detail (
                "ExpectedMaxTasks=$expectedMaxTasks ActualMaxTasks=$actualMaxTasks MissingSwitches=" +
                ($missingSwitches -join ", ")
            )

        Write-TestResult `
            -Name "$Name fake child exited successfully" `
            -Passed (
                [System.IO.File]::Exists($childStatusPath) -and
                ((Get-Content -LiteralPath $childStatusPath -Raw).Trim() -eq "exit 0")
            ) `
            -Detail "AutoGoalExitCode=$scenarioExitCode"

        Write-TestResult `
            -Name "$Name child script was invoked" `
            -Passed ([System.IO.File]::Exists($forwardedArgsPath)) `
            -Detail (
                "ExitCode=$scenarioExitCode OutputPreview=" +
                (($outputText.Replace("`r", " ").Replace("`n", " ")).Trim())
            )
    }
    catch {
        Write-TestResult `
            -Name "$Name execution" `
            -Passed $false `
            -Detail ("Line={0} Message={1}" -f $_.InvocationInfo.ScriptLineNumber, $_.Exception.Message)
    }
    finally {
        Remove-IsolatedScenarioRoot -ScenarioRoot $scenarioRoot

        if ([System.IO.Directory]::Exists($fakeBinPath)) {
            [System.IO.Directory]::Delete($fakeBinPath, $true)
        }

        foreach ($tempFile in @($forwardedArgsPath, $childStatusPath)) {
            if ([System.IO.File]::Exists($tempFile)) {
                [System.IO.File]::Delete($tempFile)
            }
        }
    }
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
            "all_goal_candidates_excluded",
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

        if ($SetupType -eq "all_goal_candidates_excluded") {
            $queuePath = Join-Path $tmpRoot ".ai-dev\queue.json"
            $statePath = Join-Path $tmpRoot ".ai-dev\state.json"
            $backlogPath = Join-Path $tmpRoot ".ai-dev\backlog.md"
            $fixtureTitle = "Only backlog task"
            $utf8WithBom = New-Object System.Text.UTF8Encoding($true)

            $queue = [PSCustomObject][ordered]@{
                goalTitle = $fixtureTitle
                goalSource = ".ai-dev/goal.md"
                currentTaskId = $null
                tasks = @(
                    [PSCustomObject][ordered]@{
                        id = "T001"
                        title = $fixtureTitle
                        status = "done"
                    }
                )
            }

            $state = [PSCustomObject][ordered]@{
                goalStatus = "completed"
                currentTaskId = $null
            }

            $backlog = @"
# Test Backlog

## P0

- $fixtureTitle
"@

            [System.IO.File]::WriteAllText(
                $queuePath,
                ($queue | ConvertTo-Json -Depth 30),
                $utf8WithBom
            )
            [System.IO.File]::WriteAllText(
                $statePath,
                ($state | ConvertTo-Json -Depth 30),
                $utf8WithBom
            )
            [System.IO.File]::WriteAllText(
                $backlogPath,
                $backlog,
                $utf8WithBom
            )
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
            $output = & powershell -NoProfile @CommandArguments 2>&1
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

function Invoke-CommitScopeScenario {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [string[]]$ScopeArgs,

        [string[]]$ExpectedCommittedFiles = @(),

        [string[]]$ChangedFiles = @(),

        [string[]]$DeletedFiles = @(),

        [string[]]$StagedOutsideFiles = @(),

        [bool]$ExpectSuccess = $true,

        [string]$ExpectedOutputFragment = ""
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
                Join-Path $repoRoot "scripts\ai-dev-commit.ps1"
            ) `
            -Destination (
                Join-Path $tmpRoot "scripts\ai-dev-commit.ps1"
            ) `
            -Force

        & git -C $tmpRoot config user.email "ai-dev-test@example.invalid" | Out-Null
        & git -C $tmpRoot config user.name "AI Dev Test" | Out-Null

        $utf8WithBom = New-Object System.Text.UTF8Encoding($true)

        foreach ($changedFile in @($ChangedFiles)) {
            $changedPath = Join-Path $tmpRoot $changedFile
            $changedDirectory = Split-Path -Parent $changedPath

            if (-not [string]::IsNullOrWhiteSpace($changedDirectory)) {
                [System.IO.Directory]::CreateDirectory($changedDirectory) | Out-Null
            }

            [System.IO.File]::WriteAllText(
                $changedPath,
                "changed by commit scope test $Name",
                $utf8WithBom
            )
        }

        foreach ($deletedFile in @($DeletedFiles)) {
            $deletedPath = Join-Path $tmpRoot $deletedFile

            if ([System.IO.File]::Exists($deletedPath)) {
                [System.IO.File]::Delete($deletedPath)
            }
        }

        foreach ($stagedOutsideFile in @($StagedOutsideFiles)) {
            $stagedPath = Join-Path $tmpRoot $stagedOutsideFile
            $stagedDirectory = Split-Path -Parent $stagedPath

            if (-not [string]::IsNullOrWhiteSpace($stagedDirectory)) {
                [System.IO.Directory]::CreateDirectory($stagedDirectory) | Out-Null
            }

            [System.IO.File]::WriteAllText(
                $stagedPath,
                "staged outside commit scope test $Name",
                $utf8WithBom
            )

            & git -C $tmpRoot add -- $stagedOutsideFile | Out-Null
        }

        Push-Location $tmpRoot

        try {
            $previousErrorActionPreference = $ErrorActionPreference
            $ErrorActionPreference = "Continue"
            $output = & powershell `
                -NoProfile `
                -ExecutionPolicy Bypass `
                -File ".\scripts\ai-dev-commit.ps1" `
                -Message "test: commit scope $Name" `
                -Files ($ScopeArgs -join ",") `
                -AllowWithoutPassedCheck `
                -AllowWithoutPassedReview 2>&1
            $scenarioExitCode = $LASTEXITCODE
            $outputText = $output | Out-String
        }
        finally {
            $ErrorActionPreference = $previousErrorActionPreference
            Pop-Location
        }

        if ($ExpectSuccess) {
            $committedFiles = @(
                & git -C $tmpRoot diff-tree --no-commit-id --name-only -r HEAD |
                    ForEach-Object { $_.Replace('\', '/') } |
                    Sort-Object
            )
            $expectedFiles = @(
                $ExpectedCommittedFiles |
                    ForEach-Object { $_.Replace('\', '/') } |
                    Sort-Object
            )
            $unexpectedCommittedFiles = @($committedFiles | Where-Object { $expectedFiles -notcontains $_ })
            $missingCommittedFiles = @($expectedFiles | Where-Object { $committedFiles -notcontains $_ })

            Write-TestResult `
                -Name "$Name commit succeeds" `
                -Passed ($scenarioExitCode -eq 0) `
                -Detail "ExitCode=$scenarioExitCode OutputPreview=$((($outputText.Replace("`r", " ").Replace("`n", " ")).Trim()))"

            Write-TestResult `
                -Name "$Name committed file scope" `
                -Passed ($unexpectedCommittedFiles.Count -eq 0 -and $missingCommittedFiles.Count -eq 0) `
                -Detail (
                    "Expected=" +
                    ($expectedFiles -join ", ") +
                    " Actual=" +
                    ($committedFiles -join ", ") +
                    " Missing=" +
                    ($missingCommittedFiles -join ", ") +
                    " Unexpected=" +
                    ($unexpectedCommittedFiles -join ", ")
                )
        } else {
            $fragmentMatched = (
                [string]::IsNullOrWhiteSpace($ExpectedOutputFragment) -or
                $outputText.Contains($ExpectedOutputFragment)
            )

            Write-TestResult `
                -Name "$Name commit blocked" `
                -Passed ($scenarioExitCode -ne 0 -and $fragmentMatched) `
                -Detail "ExitCode=$scenarioExitCode ExpectedFragment=$ExpectedOutputFragment OutputPreview=$((($outputText.Replace("`r", " ").Replace("`n", " ")).Trim()))"
        }
    }
    catch {
        Write-TestResult `
            -Name "$Name execution" `
            -Passed $false `
            -Detail ("Line={0} Message={1}" -f $_.InvocationInfo.ScriptLineNumber, $_.Exception.Message)
    }
    finally {
        Remove-IsolatedScenarioRoot -ScenarioRoot $scenarioRoot
    }
}

function Set-JsonFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [object]$Value
    )

    $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
    [System.IO.File]::WriteAllText(
        $Path,
        ($Value | ConvertTo-Json -Depth 30),
        $utf8WithBom
    )
}

function Get-MissingRequiredFilesSection {
    param(
        [string]$PromptText
    )

    $startMarker = "## Missing Required Files"
    $endMarker = "## Latest required_changes"
    $startIndex = $PromptText.IndexOf($startMarker, [System.StringComparison]::Ordinal)

    if ($startIndex -lt 0) {
        return ""
    }

    $endIndex = $PromptText.IndexOf($endMarker, $startIndex, [System.StringComparison]::Ordinal)

    if ($endIndex -lt 0) {
        return ""
    }

    $section = $PromptText.Substring(
        $startIndex + $startMarker.Length,
        $endIndex - ($startIndex + $startMarker.Length)
    )

    $lines = @(
        $section -split "`r?`n" |
            ForEach-Object { $_.Trim() } |
            Where-Object {
                -not [string]::IsNullOrWhiteSpace($_) -and
                -not $_.StartsWith('```') -and
                -not $_.StartsWith('`')
            }
    )

    $joinedLines = $lines -join "`n"
    return $joinedLines.Trim()
}

function Invoke-ReviewRequiredFilesRecoveryScenario {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [string[]]$RequiredFiles,

        [Parameter(Mandatory = $true)]
        [string[]]$ChangedFiles,

        [string[]]$ExpectedMissingFiles = @(),

        [string[]]$ExpectedExcludedFiles = @(),

        [int]$ExistingRecoveryCount = 0,

        [bool]$ExpectRecoveryPrompt = $true
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
                Join-Path $repoRoot "scripts\ai-dev-auto-cycle-full.ps1"
            ) `
            -Destination (
                Join-Path $tmpRoot "scripts\ai-dev-auto-cycle-full.ps1"
            ) `
            -Force

        $utf8WithBom = New-Object System.Text.UTF8Encoding($true)

        foreach ($changedFile in @($ChangedFiles)) {
            $changedPath = Join-Path $tmpRoot $changedFile
            $changedDirectory = Split-Path -Parent $changedPath

            if (-not [string]::IsNullOrWhiteSpace($changedDirectory)) {
                [System.IO.Directory]::CreateDirectory($changedDirectory) | Out-Null
            }

            [System.IO.File]::WriteAllText(
                $changedPath,
                "changed by test",
                $utf8WithBom
            )
        }

        $fakeScripts = @(
            "ai-dev-check.ps1",
            "ai-dev-save-diff.ps1",
            "ai-dev-make-review-prompt.ps1"
        )

        foreach ($fakeScript in $fakeScripts) {
            [System.IO.File]::WriteAllText(
                (Join-Path $tmpRoot "scripts\$fakeScript"),
                "exit 0`r`n",
                $utf8WithBom
            )
        }

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot "scripts\ai-dev-make-revise-prompt.ps1"),
            @'
$promptPath = Join-Path (Get-Location) ".ai-dev\revise-prompt.md"
[System.IO.File]::WriteAllText($promptPath, "GENERAL REVISE PROMPT", (New-Object System.Text.UTF8Encoding($true)))
exit 0
'@,
            $utf8WithBom
        )

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot "scripts\ai-dev-run-codex.ps1"),
            "exit 0`r`n",
            $utf8WithBom
        )

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot "scripts\ai-dev-run-review-codex.ps1"),
            @'
$repoRoot = Get-Location
$statePath = Join-Path $repoRoot ".ai-dev\state.json"
$reviewPath = Join-Path $repoRoot ".ai-dev\review-response.json"
$state = Get-Content -LiteralPath $statePath -Raw -Encoding UTF8 | ConvertFrom-Json
$review = Get-Content -LiteralPath $reviewPath -Raw -Encoding UTF8 | ConvertFrom-Json
$state.lastCommand = "save-review"
$state.lastCommandStatus = "passed"
$state.lastReviewDecision = "revise"
$state.updatedAt = "2026-01-01T00:00:00Z"
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllText($statePath, ($state | ConvertTo-Json -Depth 30), $utf8WithBom)
[System.IO.File]::WriteAllText($reviewPath, ($review | ConvertTo-Json -Depth 30), $utf8WithBom)
exit 0
'@,
            $utf8WithBom
        )

        $queue = [PSCustomObject][ordered]@{
            goalTitle = "Review recovery test"
            goalSource = ".ai-dev/goal.md"
            currentTaskId = "T001"
            tasks = @(
                [PSCustomObject][ordered]@{
                    id = "T001"
                    title = "Review recovery test"
                    description = "Verify required_changes recovery compares actual changedFiles."
                    type = "verification"
                    status = "in_progress"
                    priority = "P0"
                    dependsOn = @()
                    filesLikelyToChange = @($RequiredFiles)
                    verification = @("Run behavior test.")
                    commitMessage = $null
                }
            )
        }

        $counts = [PSCustomObject][ordered]@{}

        if ($ExistingRecoveryCount -gt 0) {
            $counts | Add-Member `
                -NotePropertyName "review_revise_repeated" `
                -NotePropertyValue $ExistingRecoveryCount
        }

        $state = [PSCustomObject][ordered]@{
            goalStatus = "in_progress"
            currentTaskId = "T001"
            currentLoop = 0
            maxLoopsPerTask = 2
            repeatedFailureCount = 0
            lastCommand = "save-review"
            lastCommandStatus = "passed"
            lastErrorSummary = $null
            lastReviewDecision = "revise"
            lastReviewSeverity = "medium"
            lastReviewNextStep = "revise_with_codex"
            lastCommitHash = $null
            startedAt = "2026-01-01T00:00:00Z"
            updatedAt = "2026-01-01T00:00:00Z"
            stopReason = $null
            autoRecovery = [PSCustomObject][ordered]@{
                T001 = [PSCustomObject][ordered]@{
                    counts = $counts
                    lastStoppedReason = $null
                }
            }
        }

        $requiredChanges = @(
            @($RequiredFiles) |
                ForEach-Object {
                    [PSCustomObject][ordered]@{
                        file = $_
                        reason = "required by test"
                        suggestion = "change only if missing"
                    }
                }
        )

        $reviewResponse = [PSCustomObject][ordered]@{
            decision = "revise"
            severity = "medium"
            summary = "Review repeated with required files."
            required_changes = @($requiredChanges)
            next_step = "revise_with_codex"
        }

        Set-JsonFile `
            -Path (Join-Path $tmpRoot ".ai-dev\queue.json") `
            -Value $queue

        Set-JsonFile `
            -Path (Join-Path $tmpRoot ".ai-dev\state.json") `
            -Value $state

        Set-JsonFile `
            -Path (Join-Path $tmpRoot ".ai-dev\review-response.json") `
            -Value $reviewResponse

        Push-Location $tmpRoot

        try {
            $protectedPaths = @(
                "scripts/ai-dev-auto-cycle-full.ps1",
                "scripts/ai-dev-make-prompt.ps1",
                "scripts/ai-dev-run-codex.ps1",
                "scripts/ai-dev-check.ps1",
                "scripts/ai-dev-save-diff.ps1",
                "scripts/ai-dev-make-review-prompt.ps1",
                "scripts/ai-dev-run-review-codex.ps1",
                "scripts/ai-dev-complete-task.ps1"
            )
            $protectedPathArgument = $protectedPaths -join ","

            $output = & powershell `
                -NoProfile `
                -ExecutionPolicy Bypass `
                -File ".\scripts\ai-dev-auto-cycle-full.ps1" `
                -AllowCodex `
                -AllowReviewCodex `
                -AllowDirty `
                -ProtectedBaselineDirtyPaths $protectedPathArgument `
                -MaxTasks 1 `
                -MaxSteps 40 2>&1
            $scenarioExitCode = $LASTEXITCODE
            $outputText = $output | Out-String
        }
        finally {
            Pop-Location
        }

        $promptPath = Join-Path $tmpRoot ".ai-dev\revise-prompt.md"
        $promptText = ""

        if ([System.IO.File]::Exists($promptPath)) {
            $promptText = Get-Content -LiteralPath $promptPath -Raw -Encoding UTF8
        }

        $isRecoveryPrompt = $promptText.Contains("# Required Files Recovery Prompt")
        $missingSection = Get-MissingRequiredFilesSection $promptText
        $missingFilesPresent = $true

        foreach ($expectedMissingFile in @($ExpectedMissingFiles)) {
            if (-not $missingSection.Contains($expectedMissingFile)) {
                $missingFilesPresent = $false
            }
        }

        $excludedFilesAbsent = $true

        foreach ($expectedExcludedFile in @($ExpectedExcludedFiles)) {
            if ($missingSection.Contains($expectedExcludedFile)) {
                $excludedFilesAbsent = $false
            }
        }

        $unexpectedRecovery = (-not $ExpectRecoveryPrompt) -and $isRecoveryPrompt
        $staleStopped = $outputText.Contains("Stopped reason: stale_review_required_file_missing")

        Write-TestResult `
            -Name "$Name recovery prompt expectation" `
            -Passed (($ExpectRecoveryPrompt -and $isRecoveryPrompt) -or (-not $ExpectRecoveryPrompt -and -not $isRecoveryPrompt)) `
            -Detail "ExpectedRecoveryPrompt=$ExpectRecoveryPrompt ExitCode=$scenarioExitCode"

        Write-TestResult `
            -Name "$Name missing files section includes only expected targets" `
            -Passed (
                (-not $unexpectedRecovery) -and
                $missingFilesPresent -and
                $excludedFilesAbsent
            ) `
            -Detail "MissingSection=$missingSection"

        Write-TestResult `
            -Name "$Name does not stop as stale required file missing" `
            -Passed (-not $staleStopped) `
            -Detail "ExitCode=$scenarioExitCode"
    }
    catch {
        Write-TestResult `
            -Name "$Name execution" `
            -Passed $false `
            -Detail ("Line={0} Message={1}" -f $_.InvocationInfo.ScriptLineNumber, $_.Exception.Message)
    }
    finally {
        Remove-IsolatedScenarioRoot -ScenarioRoot $scenarioRoot
    }
}

function New-TestResultContent {
    param(
        [string]$TaskId,
        [string]$OverallResult = "passed"
    )

    $commandStatus = if ($OverallResult -eq "passed") { "passed" } else { "failed" }

    return @"
# AI Dev Test Result

## 2026-01-01 00:00:00

- Overall result: $OverallResult
- Current task: $TaskId
- Mode: standard
- Commands:
  - npm run build: $commandStatus
  - npm run test: $commandStatus
  - npm run lint: $commandStatus
"@
}

function New-ReviewPromptContent {
    param(
        [string]$TaskId
    )

    return @"
# AI Dev Review Prompt

## Current Task

- Task ID: $TaskId
- Title: Resume review test
- Type: implementation
"@
}

function New-DiffContent {
    param(
        [string[]]$AppChangeFiles
    )

    $appFilesText = if ($AppChangeFiles.Count -gt 0) {
        (@($AppChangeFiles) | ForEach-Object { "- $_" }) -join "`r`n"
    } else {
        "- 없음"
    }

    return @"
# AI Dev Diff

## Generated At

2026-01-01 00:00:00

## App Change Files

$appFilesText

## Unstaged Diff

~~~text
변경 없음
~~~
"@
}

function New-PassReviewResponse {
    return [PSCustomObject][ordered]@{
        decision = "pass"
        severity = "none"
        summary = "Saved pass review."
        required_changes = @()
        optional_suggestions = @()
        next_step = "complete_task"
    }
}

function Invoke-AutoCycleResumeScenario {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [bool]$InitialSavedReview = $false,

        [string]$InitialReviewTaskId = "T001",

        [string]$InitialTestTaskId = "T001",

        [string]$InitialTestResult = "passed",

        [string[]]$InitialDiffAppFiles = @(),

        [string]$InitialLastCommitHash = "",

        [string]$InitialTaskCommitHash = "",

        [string]$CodexResultAfterRun = "",

        [bool]$FakeCheckPasses = $true,

        [string]$ExpectedStoppedReason = "",

        [bool]$ExpectRunCodex = $false,

        [bool]$ExpectRunReviewCodex = $false,

        [bool]$ExpectCompleteTask = $false,

        [bool]$ExpectMissingImplementation = $false
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

    $markerRoot = Join-Path $env:TEMP (
        "planpilot-marker-" +
        $Name +
        "-" +
        (Get-Date -Format "yyyyMMddHHmmssfff")
    )

    try {
        [System.IO.Directory]::CreateDirectory($markerRoot) | Out-Null

        Copy-Item `
            -LiteralPath (
                Join-Path $repoRoot "scripts\ai-dev-auto-cycle-full.ps1"
            ) `
            -Destination (
                Join-Path $tmpRoot "scripts\ai-dev-auto-cycle-full.ps1"
            ) `
            -Force

        $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
        $headCommitHash = (& git -C $tmpRoot rev-parse HEAD 2>&1 | Out-String).Trim()
        $lastCommitHash = if ($InitialLastCommitHash -eq "HEAD") {
            $headCommitHash
        } elseif ($InitialLastCommitHash -eq "NOT_HEAD") {
            "0000000000000000000000000000000000000000"
        } else {
            $InitialLastCommitHash
        }
        $taskCommitHash = if ($InitialTaskCommitHash -eq "HEAD") {
            $headCommitHash
        } elseif ($InitialTaskCommitHash -eq "NOT_HEAD") {
            "0000000000000000000000000000000000000000"
        } else {
            $InitialTaskCommitHash
        }

        $queue = [PSCustomObject][ordered]@{
            goalTitle = "Resume review test"
            goalSource = ".ai-dev/goal.md"
            currentTaskId = "T001"
            tasks = @(
                [PSCustomObject][ordered]@{
                    id = "T001"
                    title = "Resume review test"
                    description = "Verify saved review resume behavior."
                    type = "implementation"
                    status = "in_progress"
                    priority = "P0"
                    dependsOn = @()
                    filesLikelyToChange = @("scripts/ai-dev-auto-cycle-full.ps1")
                    verification = @("Run behavior test.")
                    commitMessage = $null
                }
            )
        }

        if (-not [string]::IsNullOrWhiteSpace($taskCommitHash)) {
            $queue.tasks[0] | Add-Member -NotePropertyName "commitHash" -NotePropertyValue $taskCommitHash -Force
        }

        $state = [PSCustomObject][ordered]@{
            goalStatus = "in_progress"
            currentTaskId = "T001"
            currentLoop = 0
            maxLoopsPerTask = 2
            repeatedFailureCount = 0
            lastCommand = if ($InitialSavedReview) { "save-review" } else { $null }
            lastCommandStatus = if ($InitialSavedReview) { "passed" } else { "not_started" }
            lastErrorSummary = $null
            lastReviewDecision = if ($InitialSavedReview) { "pass" } else { "not_started" }
            lastReviewSeverity = if ($InitialSavedReview) { "none" } else { $null }
            lastReviewNextStep = if ($InitialSavedReview) { "complete_task" } else { $null }
            lastCommitHash = if ([string]::IsNullOrWhiteSpace($lastCommitHash)) { $null } else { $lastCommitHash }
            startedAt = "2026-01-01T00:00:00Z"
            updatedAt = "2026-01-01T00:00:00Z"
            stopReason = $null
        }

        Set-JsonFile -Path (Join-Path $tmpRoot ".ai-dev\queue.json") -Value $queue
        Set-JsonFile -Path (Join-Path $tmpRoot ".ai-dev\state.json") -Value $state
        Set-JsonFile -Path (Join-Path $tmpRoot ".ai-dev\review-response.json") -Value (New-PassReviewResponse)

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot ".ai-dev\test-result.md"),
            (New-TestResultContent -TaskId $InitialTestTaskId -OverallResult $InitialTestResult),
            $utf8WithBom
        )

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot ".ai-dev\review-prompt.md"),
            (New-ReviewPromptContent -TaskId $InitialReviewTaskId),
            $utf8WithBom
        )

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot ".ai-dev\diff.md"),
            (New-DiffContent -AppChangeFiles $InitialDiffAppFiles),
            $utf8WithBom
        )

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot ".ai-dev\codex-result.md"),
            "",
            $utf8WithBom
        )

        $escapedMarkerRoot = ([string]$markerRoot).Replace("'", "''")
        $escapedCodexResult = ([string]$CodexResultAfterRun).Replace("'", "''")
        $checkExitCode = if ($FakeCheckPasses) { 0 } else { 1 }
        $checkOverallResult = if ($FakeCheckPasses) { "passed" } else { "failed" }

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot "scripts\ai-dev-make-prompt.ps1"),
            "exit 0`r`n",
            $utf8WithBom
        )

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot "scripts\ai-dev-run-codex.ps1"),
            @"
[System.IO.File]::WriteAllText('$escapedMarkerRoot\run-codex.txt', 'called', [System.Text.Encoding]::ASCII)
[System.IO.File]::WriteAllText((Join-Path (Get-Location) '.ai-dev\codex-result.md'), '$escapedCodexResult', (New-Object System.Text.UTF8Encoding(`$true)))
exit 0
"@,
            $utf8WithBom
        )

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot "scripts\ai-dev-check.ps1"),
            @"
`$statePath = Join-Path (Get-Location) '.ai-dev\state.json'
`$state = Get-Content -LiteralPath `$statePath -Raw -Encoding UTF8 | ConvertFrom-Json
`$state.lastCommand = 'npm run lint'
`$state.lastCommandStatus = '$checkOverallResult'
`$state.updatedAt = '2026-01-01T00:00:00Z'
`$utf8WithBom = New-Object System.Text.UTF8Encoding(`$true)
[System.IO.File]::WriteAllText(`$statePath, (`$state | ConvertTo-Json -Depth 30), `$utf8WithBom)
[System.IO.File]::WriteAllText((Join-Path (Get-Location) '.ai-dev\test-result.md'), @'
$(New-TestResultContent -TaskId "T001" -OverallResult $checkOverallResult)
'@, `$utf8WithBom)
exit $checkExitCode
"@,
            $utf8WithBom
        )

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot "scripts\ai-dev-save-diff.ps1"),
            @"
`$statePath = Join-Path (Get-Location) '.ai-dev\state.json'
`$state = Get-Content -LiteralPath `$statePath -Raw -Encoding UTF8 | ConvertFrom-Json
`$state.lastCommand = 'save-diff'
`$state.lastCommandStatus = 'passed'
`$state.updatedAt = '2026-01-01T00:00:00Z'
`$utf8WithBom = New-Object System.Text.UTF8Encoding(`$true)
[System.IO.File]::WriteAllText(`$statePath, (`$state | ConvertTo-Json -Depth 30), `$utf8WithBom)
[System.IO.File]::WriteAllText((Join-Path (Get-Location) '.ai-dev\diff.md'), @'
$(New-DiffContent -AppChangeFiles @())
'@, `$utf8WithBom)
exit 0
"@,
            $utf8WithBom
        )

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot "scripts\ai-dev-make-review-prompt.ps1"),
            @"
[System.IO.File]::WriteAllText((Join-Path (Get-Location) '.ai-dev\review-prompt.md'), @'
$(New-ReviewPromptContent -TaskId "T001")
'@, (New-Object System.Text.UTF8Encoding(`$true)))
exit 0
"@,
            $utf8WithBom
        )

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot "scripts\ai-dev-run-review-codex.ps1"),
            @"
[System.IO.File]::WriteAllText('$escapedMarkerRoot\run-review-codex.txt', 'called', [System.Text.Encoding]::ASCII)
`$statePath = Join-Path (Get-Location) '.ai-dev\state.json'
`$reviewPath = Join-Path (Get-Location) '.ai-dev\review-response.json'
`$state = Get-Content -LiteralPath `$statePath -Raw -Encoding UTF8 | ConvertFrom-Json
`$state.lastCommand = 'save-review'
`$state.lastCommandStatus = 'passed'
`$state.lastReviewDecision = 'pass'
`$state.lastReviewSeverity = 'none'
`$state.lastReviewNextStep = 'complete_task'
`$state.updatedAt = '2026-01-01T00:00:00Z'
`$review = [PSCustomObject][ordered]@{
    decision = 'pass'
    severity = 'none'
    summary = 'Fresh pass review.'
    required_changes = @()
    optional_suggestions = @()
    next_step = 'complete_task'
}
`$utf8WithBom = New-Object System.Text.UTF8Encoding(`$true)
[System.IO.File]::WriteAllText(`$statePath, (`$state | ConvertTo-Json -Depth 30), `$utf8WithBom)
[System.IO.File]::WriteAllText(`$reviewPath, (`$review | ConvertTo-Json -Depth 30), `$utf8WithBom)
exit 0
"@,
            $utf8WithBom
        )

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot "scripts\ai-dev-complete-task.ps1"),
            @"
[System.IO.File]::WriteAllText('$escapedMarkerRoot\complete-task.txt', 'called', [System.Text.Encoding]::ASCII)
exit 0
"@,
            $utf8WithBom
        )

        $fixtureScriptPaths = @(
            "scripts/ai-dev-auto-cycle-full.ps1",
            "scripts/ai-dev-make-prompt.ps1",
            "scripts/ai-dev-run-codex.ps1",
            "scripts/ai-dev-check.ps1",
            "scripts/ai-dev-save-diff.ps1",
            "scripts/ai-dev-make-review-prompt.ps1",
            "scripts/ai-dev-run-review-codex.ps1",
            "scripts/ai-dev-complete-task.ps1"
        )
        $protectedPathArgument = $fixtureScriptPaths -join ","

        & git -C $tmpRoot update-index --assume-unchanged -- $fixtureScriptPaths |
            Out-Null

        Push-Location $tmpRoot

        try {
            $previousErrorActionPreference = $ErrorActionPreference
            $ErrorActionPreference = "Continue"
            $output = & powershell `
                -NoProfile `
                -ExecutionPolicy Bypass `
                -File ".\scripts\ai-dev-auto-cycle-full.ps1" `
                -AllowCodex `
                -AllowReviewCodex `
                -AllowDirty `
                -ProtectedBaselineDirtyPaths $protectedPathArgument `
                -MaxTasks 1 `
                -MaxSteps 40 2>&1
            $scenarioExitCode = $LASTEXITCODE
            $outputText = $output | Out-String
        }
        finally {
            $ErrorActionPreference = $previousErrorActionPreference
            Pop-Location
        }

        $runCodexCalled = [System.IO.File]::Exists((Join-Path $markerRoot "run-codex.txt"))
        $runReviewCalled = [System.IO.File]::Exists((Join-Path $markerRoot "run-review-codex.txt"))
        $completeTaskCalled = [System.IO.File]::Exists((Join-Path $markerRoot "complete-task.txt"))
        $stoppedReasonMatched = if ([string]::IsNullOrWhiteSpace($ExpectedStoppedReason)) {
            $true
        } else {
            $outputText.Contains("Stopped reason: $ExpectedStoppedReason")
        }
        $missingImplementationDetected = $outputText.Contains("Stopped reason: missing_implementation")
        $stoppedReasonDetail = if ($stoppedReasonMatched) {
            "Expected=$ExpectedStoppedReason ExitCode=$scenarioExitCode"
        } else {
            "Expected=$ExpectedStoppedReason ExitCode=$scenarioExitCode OutputPreview=" +
                (($outputText.Replace("`r", " ").Replace("`n", " ")).Trim())
        }

        Write-TestResult `
            -Name "$Name stopped reason expectation" `
            -Passed $stoppedReasonMatched `
            -Detail $stoppedReasonDetail

        Write-TestResult `
            -Name "$Name run-codex expectation" `
            -Passed ($runCodexCalled -eq $ExpectRunCodex) `
            -Detail "Expected=$ExpectRunCodex Actual=$runCodexCalled"

        Write-TestResult `
            -Name "$Name run-review-codex expectation" `
            -Passed ($runReviewCalled -eq $ExpectRunReviewCodex) `
            -Detail "Expected=$ExpectRunReviewCodex Actual=$runReviewCalled"

        Write-TestResult `
            -Name "$Name complete-task expectation" `
            -Passed ($completeTaskCalled -eq $ExpectCompleteTask) `
            -Detail "Expected=$ExpectCompleteTask Actual=$completeTaskCalled"

        Write-TestResult `
            -Name "$Name missing_implementation expectation" `
            -Passed ($missingImplementationDetected -eq $ExpectMissingImplementation) `
            -Detail "Expected=$ExpectMissingImplementation Actual=$missingImplementationDetected"
    }
    catch {
        Write-TestResult `
            -Name "$Name execution" `
            -Passed $false `
            -Detail ("Line={0} Message={1}" -f $_.InvocationInfo.ScriptLineNumber, $_.Exception.Message)
    }
    finally {
        Remove-IsolatedScenarioRoot -ScenarioRoot $scenarioRoot

        if ([System.IO.Directory]::Exists($markerRoot)) {
            [System.IO.Directory]::Delete($markerRoot, $true)
        }
    }
}

function Invoke-RecoveryCoverageScenario {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [int]$CheckFailuresBeforeSuccess = 0,

        [int]$ReviewJsonFailuresBeforeSuccess = 0,

        [bool]$StaleReviewJsonFailureState = $false,

        [ValidateSet("none", "scripts", "dependencies", "packageLock")]
        [string]$PackageMutation = "none",

        [string]$CurrentTaskId = "T001",

        [string]$SeedRecoveryTaskId = "",

        [string]$SeedRecoveryType = "",

        [int]$SeedRecoveryCount = 0,

        [string]$ExpectedStoppedReason = "allow_commit_required",

        [int]$ExpectedRunCodexCount = 1,

        [int]$ExpectedCheckCount = 1,

        [int]$ExpectedReviewCodexCount = 1,

        [string]$ExpectedRecoveryType = "",

        [int]$ExpectedRecoveryCount = 0,

        [bool]$ExpectRawPreserved = $false,

        [bool]$ExpectRevisePromptHasTestResult = $false
    )

    $tmpRoot = Join-Path $env:TEMP (
        "planpilot-recovery-" +
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

    $markerRoot = Join-Path $env:TEMP (
        "planpilot-recovery-marker-" +
        $Name +
        "-" +
        (Get-Date -Format "yyyyMMddHHmmssfff")
    )

    try {
        [System.IO.Directory]::CreateDirectory($markerRoot) | Out-Null

        Copy-Item `
            -LiteralPath (
                Join-Path $repoRoot "scripts\ai-dev-auto-cycle-full.ps1"
            ) `
            -Destination (
                Join-Path $tmpRoot "scripts\ai-dev-auto-cycle-full.ps1"
            ) `
            -Force

        $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
        $escapedMarkerRoot = ([string]$markerRoot).Replace("'", "''")
        $escapedCheckFailures = [int]$CheckFailuresBeforeSuccess
        $escapedReviewFailures = [int]$ReviewJsonFailuresBeforeSuccess
        $escapedCurrentTaskId = ([string]$CurrentTaskId).Replace("'", "''")
        $escapedStaleReviewJsonFailureState = if ($StaleReviewJsonFailureState) { '$true' } else { '$false' }

        $queue = [PSCustomObject][ordered]@{
            goalTitle = "Recovery coverage test"
            goalSource = ".ai-dev/goal.md"
            currentTaskId = $CurrentTaskId
            tasks = @(
                [PSCustomObject][ordered]@{
                    id = $CurrentTaskId
                    title = "Recovery coverage test"
                    description = "Verify automatic recovery branches."
                    type = "implementation"
                    status = "in_progress"
                    priority = "P0"
                    dependsOn = @()
                    filesLikelyToChange = @("scripts/ai-dev-auto-cycle-full.ps1")
                    verification = @("Run behavior test.")
                    commitMessage = $null
                }
            )
        }

        $state = [PSCustomObject][ordered]@{
            goalStatus = "in_progress"
            currentTaskId = $CurrentTaskId
            currentLoop = 0
            maxLoopsPerTask = 2
            repeatedFailureCount = 0
            lastCommand = $null
            lastCommandStatus = "not_started"
            lastErrorSummary = $null
            lastReviewDecision = "not_started"
            lastReviewSeverity = $null
            lastReviewNextStep = $null
            lastCommitHash = $null
            startedAt = "2026-01-01T00:00:00Z"
            updatedAt = "2026-01-01T00:00:00Z"
            stopReason = $null
        }

        if ($StaleReviewJsonFailureState) {
            $state.lastCommand = "save-review"
            $state.lastCommandStatus = "failed"
            $state.stopReason = "review_json_extraction_failed"
        }

        if (
            -not [string]::IsNullOrWhiteSpace($SeedRecoveryTaskId) -and
            -not [string]::IsNullOrWhiteSpace($SeedRecoveryType) -and
            $SeedRecoveryCount -gt 0
        ) {
            $seedCounts = [PSCustomObject][ordered]@{}
            $seedCounts | Add-Member -NotePropertyName $SeedRecoveryType -NotePropertyValue $SeedRecoveryCount
            $seedTaskState = [PSCustomObject][ordered]@{
                counts = $seedCounts
                lastStoppedReason = $null
            }
            $seedRecovery = [PSCustomObject][ordered]@{}
            $seedRecovery | Add-Member -NotePropertyName $SeedRecoveryTaskId -NotePropertyValue $seedTaskState
            $state | Add-Member -NotePropertyName "autoRecovery" -NotePropertyValue $seedRecovery
        }

        Set-JsonFile -Path (Join-Path $tmpRoot ".ai-dev\queue.json") -Value $queue
        Set-JsonFile -Path (Join-Path $tmpRoot ".ai-dev\state.json") -Value $state
        Set-JsonFile -Path (Join-Path $tmpRoot ".ai-dev\review-response.json") -Value (New-PassReviewResponse)

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot ".ai-dev\codex-result.md"),
            "",
            $utf8WithBom
        )

        switch ($PackageMutation) {
            "scripts" {
                $packagePath = Join-Path $tmpRoot "package.json"
                $package = Get-Content -LiteralPath $packagePath -Raw -Encoding UTF8 | ConvertFrom-Json
                if (-not ($package.PSObject.Properties.Name -contains "scripts") -or $null -eq $package.scripts) {
                    $package | Add-Member -NotePropertyName "scripts" -NotePropertyValue ([PSCustomObject][ordered]@{})
                }
                $package.scripts | Add-Member -NotePropertyName "ai-dev-safe-script" -NotePropertyValue "echo safe" -Force
                [System.IO.File]::WriteAllText($packagePath, ($package | ConvertTo-Json -Depth 50), $utf8WithBom)
            }
            "dependencies" {
                $packagePath = Join-Path $tmpRoot "package.json"
                $package = Get-Content -LiteralPath $packagePath -Raw -Encoding UTF8 | ConvertFrom-Json
                if (-not ($package.PSObject.Properties.Name -contains "dependencies") -or $null -eq $package.dependencies) {
                    $package | Add-Member -NotePropertyName "dependencies" -NotePropertyValue ([PSCustomObject][ordered]@{})
                }
                $package.dependencies | Add-Member -NotePropertyName "ai-dev-blocked-dep" -NotePropertyValue "1.0.0" -Force
                [System.IO.File]::WriteAllText($packagePath, ($package | ConvertTo-Json -Depth 50), $utf8WithBom)
            }
            "packageLock" {
                $lockPath = Join-Path $tmpRoot "package-lock.json"
                [System.IO.File]::AppendAllText($lockPath, "`r`n", $utf8WithBom)
            }
        }

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot "scripts\ai-dev-make-prompt.ps1"),
            "exit 0`r`n",
            $utf8WithBom
        )

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot "scripts\ai-dev-run-codex.ps1"),
            @"
`$countPath = '$escapedMarkerRoot\run-codex-count.txt'
`$argsPath = '$escapedMarkerRoot\run-codex-args.txt'
`$count = if ([System.IO.File]::Exists(`$countPath)) { [int]([System.IO.File]::ReadAllText(`$countPath).Trim()) } else { 0 }
`$count++
[System.IO.File]::WriteAllText(`$countPath, [string]`$count, [System.Text.Encoding]::ASCII)
[System.IO.File]::AppendAllText(`$argsPath, ((`$args -join ' ') + "`r`n"), [System.Text.Encoding]::ASCII)
[System.IO.File]::WriteAllText((Join-Path (Get-Location) '.ai-dev\codex-result.md'), 'fake implementation', (New-Object System.Text.UTF8Encoding(`$true)))
exit 0
"@,
            $utf8WithBom
        )

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot "scripts\ai-dev-check.ps1"),
            @"
`$countPath = '$escapedMarkerRoot\check-count.txt'
`$count = if ([System.IO.File]::Exists(`$countPath)) { [int]([System.IO.File]::ReadAllText(`$countPath).Trim()) } else { 0 }
`$count++
[System.IO.File]::WriteAllText(`$countPath, [string]`$count, [System.Text.Encoding]::ASCII)
`$failed = `$count -le $escapedCheckFailures
`$overall = if (`$failed) { 'failed' } else { 'passed' }
`$statePath = Join-Path (Get-Location) '.ai-dev\state.json'
`$state = Get-Content -LiteralPath `$statePath -Raw -Encoding UTF8 | ConvertFrom-Json
`$state.lastCommand = 'npm run lint'
`$state.lastCommandStatus = `$overall
`$state.updatedAt = '2026-01-01T00:00:00Z'
`$utf8WithBom = New-Object System.Text.UTF8Encoding(`$true)
[System.IO.File]::WriteAllText(`$statePath, (`$state | ConvertTo-Json -Depth 30), `$utf8WithBom)
`$testLines = @(
    '# Test Result',
    '',
    '- Task ID: $escapedCurrentTaskId',
    ('- Overall Result: ' + `$overall),
    '',
    'Failure detail marker from fake check.'
)
[System.IO.File]::WriteAllText((Join-Path (Get-Location) '.ai-dev\test-result.md'), (`$testLines -join "`r`n"), `$utf8WithBom)
if (`$failed) { exit 1 }
exit 0
"@,
            $utf8WithBom
        )

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot "scripts\ai-dev-save-diff.ps1"),
            @"
`$statePath = Join-Path (Get-Location) '.ai-dev\state.json'
`$state = Get-Content -LiteralPath `$statePath -Raw -Encoding UTF8 | ConvertFrom-Json
`$state.lastCommand = 'save-diff'
`$state.lastCommandStatus = 'passed'
`$state.updatedAt = '2026-01-01T00:00:00Z'
`$changedFiles = @('scripts/ai-dev-auto-cycle-full.ps1')
if ('$PackageMutation' -eq 'scripts' -or '$PackageMutation' -eq 'dependencies') { `$changedFiles += 'package.json' }
if ('$PackageMutation' -eq 'packageLock') { `$changedFiles += 'package-lock.json' }
`$diffLines = @('# Diff Summary', '', '## App Change Files') + (`$changedFiles | ForEach-Object { '- ' + `$_ })
`$utf8WithBom = New-Object System.Text.UTF8Encoding(`$true)
[System.IO.File]::WriteAllText(`$statePath, (`$state | ConvertTo-Json -Depth 30), `$utf8WithBom)
[System.IO.File]::WriteAllText((Join-Path (Get-Location) '.ai-dev\diff.md'), (`$diffLines -join "`r`n"), `$utf8WithBom)
exit 0
"@,
            $utf8WithBom
        )

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot "scripts\ai-dev-make-review-prompt.ps1"),
            @"
[System.IO.File]::WriteAllText((Join-Path (Get-Location) '.ai-dev\review-prompt.md'), @'
$(New-ReviewPromptContent -TaskId $CurrentTaskId)
'@, (New-Object System.Text.UTF8Encoding(`$true)))
exit 0
"@,
            $utf8WithBom
        )

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot "scripts\ai-dev-run-review-codex.ps1"),
            @"
`$countPath = '$escapedMarkerRoot\run-review-count.txt'
`$count = if ([System.IO.File]::Exists(`$countPath)) { [int]([System.IO.File]::ReadAllText(`$countPath).Trim()) } else { 0 }
`$count++
[System.IO.File]::WriteAllText(`$countPath, [string]`$count, [System.Text.Encoding]::ASCII)
`$statePath = Join-Path (Get-Location) '.ai-dev\state.json'
`$reviewPath = Join-Path (Get-Location) '.ai-dev\review-response.json'
`$rawPath = Join-Path (Get-Location) '.ai-dev\codex-review-result.md'
`$state = Get-Content -LiteralPath `$statePath -Raw -Encoding UTF8 | ConvertFrom-Json
`$utf8WithBom = New-Object System.Text.UTF8Encoding(`$true)
if ($escapedStaleReviewJsonFailureState) {
    [System.IO.File]::WriteAllText(`$rawPath, "NON JSON FAILURE WITH STALE STATE", `$utf8WithBom)
    exit 1
}
if (`$count -le $escapedReviewFailures) {
    `$state.lastCommand = 'save-review'
    `$state.lastCommandStatus = 'failed'
    `$state.stopReason = 'review_json_extraction_failed'
    `$state.updatedAt = '2026-01-01T00:00:00Z'
    [System.IO.File]::WriteAllText(`$statePath, (`$state | ConvertTo-Json -Depth 30), `$utf8WithBom)
    [System.IO.File]::WriteAllText(`$rawPath, "RAW REVIEW RESPONSE `$count", `$utf8WithBom)
    exit 1
}
`$state.lastCommand = 'save-review'
`$state.lastCommandStatus = 'passed'
`$state.lastReviewDecision = 'pass'
`$state.lastReviewSeverity = 'none'
`$state.lastReviewNextStep = 'complete_task'
`$state.stopReason = `$null
`$state.updatedAt = '2026-01-01T00:00:00Z'
`$review = [PSCustomObject][ordered]@{
    decision = 'pass'
    severity = 'none'
    summary = 'Fresh pass review.'
    required_changes = @()
    optional_suggestions = @()
    next_step = 'complete_task'
}
[System.IO.File]::WriteAllText(`$statePath, (`$state | ConvertTo-Json -Depth 30), `$utf8WithBom)
[System.IO.File]::WriteAllText(`$reviewPath, (`$review | ConvertTo-Json -Depth 30), `$utf8WithBom)
exit 0
"@,
            $utf8WithBom
        )

        [System.IO.File]::WriteAllText(
            (Join-Path $tmpRoot "scripts\ai-dev-complete-task.ps1"),
            "exit 0`r`n",
            $utf8WithBom
        )

        $fixtureScriptPaths = @(
            "scripts/ai-dev-auto-cycle-full.ps1",
            "scripts/ai-dev-make-prompt.ps1",
            "scripts/ai-dev-run-codex.ps1",
            "scripts/ai-dev-check.ps1",
            "scripts/ai-dev-save-diff.ps1",
            "scripts/ai-dev-make-review-prompt.ps1",
            "scripts/ai-dev-run-review-codex.ps1",
            "scripts/ai-dev-complete-task.ps1"
        )
        $protectedPathArgument = $fixtureScriptPaths -join ","

        & git -C $tmpRoot update-index --assume-unchanged -- $fixtureScriptPaths |
            Out-Null

        Push-Location $tmpRoot

        try {
            $previousErrorActionPreference = $ErrorActionPreference
            $ErrorActionPreference = "Continue"
            $output = & powershell `
                -NoProfile `
                -ExecutionPolicy Bypass `
                -File ".\scripts\ai-dev-auto-cycle-full.ps1" `
                -AllowCodex `
                -AllowReviewCodex `
                -AllowDirty `
                -ProtectedBaselineDirtyPaths $protectedPathArgument `
                -MaxTasks 1 `
                -MaxSteps 40 2>&1
            $scenarioExitCode = $LASTEXITCODE
            $outputText = $output | Out-String
        }
        finally {
            $ErrorActionPreference = $previousErrorActionPreference
            Pop-Location
        }

        $runCodexCountPath = Join-Path $markerRoot "run-codex-count.txt"
        $checkCountPath = Join-Path $markerRoot "check-count.txt"
        $runReviewCountPath = Join-Path $markerRoot "run-review-count.txt"
        $runCodexCount = if ([System.IO.File]::Exists($runCodexCountPath)) { [int]([System.IO.File]::ReadAllText($runCodexCountPath).Trim()) } else { 0 }
        $checkCount = if ([System.IO.File]::Exists($checkCountPath)) { [int]([System.IO.File]::ReadAllText($checkCountPath).Trim()) } else { 0 }
        $runReviewCount = if ([System.IO.File]::Exists($runReviewCountPath)) { [int]([System.IO.File]::ReadAllText($runReviewCountPath).Trim()) } else { 0 }
        $stateAfter = Get-Content -LiteralPath (Join-Path $tmpRoot ".ai-dev\state.json") -Raw -Encoding UTF8 | ConvertFrom-Json
        $rawFiles = @(Get-ChildItem -LiteralPath (Join-Path $tmpRoot ".ai-dev") -Filter "codex-review-result.review_json_extraction_failed.*.raw.md" -File)
        $rawTextMatched = $false

        if ($rawFiles.Count -gt 0) {
            $rawTextMatched = ((Get-Content -LiteralPath $rawFiles[0].FullName -Raw -Encoding UTF8).Contains("RAW REVIEW RESPONSE 1"))
        }

        $actualRecoveryCount = 0

        if (
            -not [string]::IsNullOrWhiteSpace($ExpectedRecoveryType) -and
            ($stateAfter.PSObject.Properties.Name -contains "autoRecovery") -and
            $null -ne $stateAfter.autoRecovery -and
            ($stateAfter.autoRecovery.PSObject.Properties.Name -contains $CurrentTaskId) -and
            $null -ne $stateAfter.autoRecovery.$CurrentTaskId.counts -and
            ($stateAfter.autoRecovery.$CurrentTaskId.counts.PSObject.Properties.Name -contains $ExpectedRecoveryType)
        ) {
            $actualRecoveryCount = [int]$stateAfter.autoRecovery.$CurrentTaskId.counts.$ExpectedRecoveryType
        }

        $sameTaskSeedStillPresent = $true

        if (
            -not [string]::IsNullOrWhiteSpace($SeedRecoveryTaskId) -and
            $SeedRecoveryTaskId -ne $CurrentTaskId
        ) {
            $sameTaskSeedStillPresent = (
                ($stateAfter.autoRecovery.PSObject.Properties.Name -contains $SeedRecoveryTaskId) -and
                ($stateAfter.autoRecovery.$SeedRecoveryTaskId.counts.PSObject.Properties.Name -contains $SeedRecoveryType) -and
                ([int]$stateAfter.autoRecovery.$SeedRecoveryTaskId.counts.$SeedRecoveryType -eq $SeedRecoveryCount)
            )
        }

        $revisePromptHasTestResult = $false
        $revisePromptPath = Join-Path $tmpRoot ".ai-dev\revise-prompt.md"

        if ([System.IO.File]::Exists($revisePromptPath)) {
            $revisePrompt = Get-Content -LiteralPath $revisePromptPath -Raw -Encoding UTF8
            $revisePromptHasTestResult = $revisePrompt.Contains("Failure detail marker from fake check.")
        }

        Write-TestResult `
            -Name "$Name stopped reason expectation" `
            -Passed ($outputText.Contains("Stopped reason: $ExpectedStoppedReason")) `
            -Detail "Expected=$ExpectedStoppedReason ExitCode=$scenarioExitCode"

        Write-TestResult `
            -Name "$Name run-codex count" `
            -Passed ($runCodexCount -eq $ExpectedRunCodexCount) `
            -Detail "Expected=$ExpectedRunCodexCount Actual=$runCodexCount"

        Write-TestResult `
            -Name "$Name check count" `
            -Passed ($checkCount -eq $ExpectedCheckCount) `
            -Detail "Expected=$ExpectedCheckCount Actual=$checkCount"

        Write-TestResult `
            -Name "$Name review-codex count" `
            -Passed ($runReviewCount -eq $ExpectedReviewCodexCount) `
            -Detail "Expected=$ExpectedReviewCodexCount Actual=$runReviewCount"

        if (-not [string]::IsNullOrWhiteSpace($ExpectedRecoveryType)) {
            Write-TestResult `
                -Name "$Name recovery count" `
                -Passed ($actualRecoveryCount -eq $ExpectedRecoveryCount) `
                -Detail "Type=$ExpectedRecoveryType Expected=$ExpectedRecoveryCount Actual=$actualRecoveryCount"
        }

        Write-TestResult `
            -Name "$Name raw review preservation" `
            -Passed (($rawFiles.Count -gt 0 -and $rawTextMatched) -eq $ExpectRawPreserved) `
            -Detail "Expected=$ExpectRawPreserved RawFiles=$($rawFiles.Count)"

        Write-TestResult `
            -Name "$Name revise prompt test-result content" `
            -Passed ($revisePromptHasTestResult -eq $ExpectRevisePromptHasTestResult) `
            -Detail "Expected=$ExpectRevisePromptHasTestResult Actual=$revisePromptHasTestResult"

        Write-TestResult `
            -Name "$Name seeded recovery isolation" `
            -Passed $sameTaskSeedStillPresent `
            -Detail "SeedTask=$SeedRecoveryTaskId CurrentTask=$CurrentTaskId"
    }
    catch {
        Write-TestResult `
            -Name "$Name execution" `
            -Passed $false `
            -Detail ("Line={0} Message={1}" -f $_.InvocationInfo.ScriptLineNumber, $_.Exception.Message)
    }
    finally {
        Remove-IsolatedScenarioRoot -ScenarioRoot $scenarioRoot

        if ([System.IO.Directory]::Exists($markerRoot)) {
            [System.IO.Directory]::Delete($markerRoot, $true)
        }
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

Test-MaxStepsForwardingBehavior `
    -Name "maxsteps-forwarding" `
    -ExpectedMaxSteps 57

Invoke-IsolatedScenario `
    -Name "all-goal-candidates-excluded" `
    -ExpectedReason "all_goal_candidates_excluded" `
    -SetupType "all_goal_candidates_excluded" `
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

Invoke-CommitScopeScenario `
    -Name "commit-scope-ai-company-directory" `
    -ScopeArgs @(".ai-company/") `
    -ChangedFiles @(
        ".ai-company/customer-requests.json",
        ".ai-company/reports/adapter-plan.md",
        ".ai-company/reports/new-scope-report.md"
    ) `
    -DeletedFiles @(".ai-company/customer-decisions.json") `
    -ExpectedCommittedFiles @(
        ".ai-company/customer-requests.json",
        ".ai-company/reports/adapter-plan.md",
        ".ai-company/reports/new-scope-report.md",
        ".ai-company/customer-decisions.json"
    )

Invoke-CommitScopeScenario `
    -Name "commit-scope-reports-directory" `
    -ScopeArgs @(".ai-company/reports/") `
    -ChangedFiles @(".ai-company/reports/adapter-plan.md") `
    -ExpectedCommittedFiles @(".ai-company/reports/adapter-plan.md")

Invoke-CommitScopeScenario `
    -Name "commit-scope-new-directory" `
    -ScopeArgs @("ai-software-company/") `
    -ChangedFiles @(
        "ai-software-company/notes.md",
        "ai-software-company/reports/summary.md"
    ) `
    -ExpectedCommittedFiles @(
        "ai-software-company/notes.md",
        "ai-software-company/reports/summary.md"
    )

Invoke-CommitScopeScenario `
    -Name "commit-scope-file-and-directory" `
    -ScopeArgs @(".ai-company/reports/", "scripts/ai-dev-status.ps1") `
    -ChangedFiles @(
        ".ai-company/reports/adapter-plan.md",
        "scripts/ai-dev-status.ps1"
    ) `
    -ExpectedCommittedFiles @(
        ".ai-company/reports/adapter-plan.md",
        "scripts/ai-dev-status.ps1"
    )

Invoke-CommitScopeScenario `
    -Name "commit-scope-blocks-outside-staged-file" `
    -ScopeArgs @(".ai-company/") `
    -ChangedFiles @(".ai-company/customer-requests.json") `
    -StagedOutsideFiles @("scripts/ai-dev-status.ps1") `
    -ExpectedCommittedFiles @() `
    -ExpectSuccess $false `
    -ExpectedOutputFragment "선택 파일 외에 이미 staged 된 파일"

Invoke-CommitScopeScenario `
    -Name "commit-scope-blocks-repo-outside-path" `
    -ScopeArgs @($env:TEMP) `
    -ChangedFiles @(".ai-company/customer-requests.json") `
    -ExpectedCommittedFiles @() `
    -ExpectSuccess $false `
    -ExpectedOutputFragment "저장소 밖 파일"

Invoke-CommitScopeScenario `
    -Name "commit-scope-blocks-traversal-path" `
    -ScopeArgs @("../outside.txt") `
    -ChangedFiles @(".ai-company/customer-requests.json") `
    -ExpectedCommittedFiles @() `
    -ExpectSuccess $false `
    -ExpectedOutputFragment "traversal"

Invoke-ReviewRequiredFilesRecoveryScenario `
    -Name "review-required-files-partial-diff" `
    -RequiredFiles @("A.ps1", "B.ps1") `
    -ChangedFiles @("A.ps1") `
    -ExpectedMissingFiles @("B.ps1") `
    -ExpectedExcludedFiles @("A.ps1") `
    -ExpectRecoveryPrompt $true

Invoke-ReviewRequiredFilesRecoveryScenario `
    -Name "review-required-files-all-changed" `
    -RequiredFiles @("A.ps1", "B.ps1") `
    -ChangedFiles @("A.ps1", "B.ps1") `
    -ExpectedMissingFiles @() `
    -ExpectedExcludedFiles @("A.ps1", "B.ps1") `
    -ExpectRecoveryPrompt $false

Invoke-ReviewRequiredFilesRecoveryScenario `
    -Name "review-required-files-recovery-limit" `
    -RequiredFiles @("A.ps1", "B.ps1") `
    -ChangedFiles @("A.ps1") `
    -ExpectedMissingFiles @() `
    -ExpectedExcludedFiles @("A.ps1", "B.ps1") `
    -ExistingRecoveryCount 1 `
    -ExpectRecoveryPrompt $false

Invoke-AutoCycleResumeScenario `
    -Name "missing-implementation-no-diff-no-commit" `
    -InitialSavedReview $false `
    -CodexResultAfterRun "" `
    -ExpectedStoppedReason "missing_implementation" `
    -ExpectRunCodex $true `
    -ExpectRunReviewCodex $true `
    -ExpectCompleteTask $false `
    -ExpectMissingImplementation $true

Invoke-AutoCycleResumeScenario `
    -Name "saved-review-current-commit-resumes" `
    -InitialSavedReview $true `
    -InitialReviewTaskId "T001" `
    -InitialTestTaskId "T001" `
    -InitialTestResult "passed" `
    -InitialDiffAppFiles @("scripts/ai-dev-auto-cycle-full.ps1") `
    -InitialLastCommitHash "HEAD" `
    -InitialTaskCommitHash "HEAD" `
    -ExpectedStoppedReason "allow_commit_required" `
    -ExpectRunCodex $false `
    -ExpectRunReviewCodex $false `
    -ExpectCompleteTask $false `
    -ExpectMissingImplementation $false

Invoke-AutoCycleResumeScenario `
    -Name "saved-review-pass-current-skips-review-codex" `
    -InitialSavedReview $true `
    -InitialReviewTaskId "T001" `
    -InitialTestTaskId "T001" `
    -InitialTestResult "passed" `
    -InitialDiffAppFiles @("scripts/ai-dev-auto-cycle-full.ps1") `
    -InitialLastCommitHash "HEAD" `
    -InitialTaskCommitHash "HEAD" `
    -ExpectedStoppedReason "allow_commit_required" `
    -ExpectRunCodex $false `
    -ExpectRunReviewCodex $false `
    -ExpectCompleteTask $false `
    -ExpectMissingImplementation $false

Invoke-AutoCycleResumeScenario `
    -Name "saved-review-previous-task-head-reruns-codex" `
    -InitialSavedReview $true `
    -InitialReviewTaskId "T001" `
    -InitialTestTaskId "T001" `
    -InitialTestResult "passed" `
    -InitialDiffAppFiles @("scripts/ai-dev-auto-cycle-full.ps1") `
    -InitialLastCommitHash "HEAD" `
    -CodexResultAfterRun "fresh implementation" `
    -ExpectedStoppedReason "allow_commit_required" `
    -ExpectRunCodex $true `
    -ExpectRunReviewCodex $true `
    -ExpectCompleteTask $false `
    -ExpectMissingImplementation $false

Invoke-AutoCycleResumeScenario `
    -Name "saved-review-different-task-reruns-review" `
    -InitialSavedReview $true `
    -InitialReviewTaskId "T999" `
    -InitialTestTaskId "T001" `
    -InitialTestResult "passed" `
    -InitialDiffAppFiles @("scripts/ai-dev-auto-cycle-full.ps1") `
    -InitialLastCommitHash "HEAD" `
    -CodexResultAfterRun "fresh implementation" `
    -ExpectedStoppedReason "allow_commit_required" `
    -ExpectRunCodex $true `
    -ExpectRunReviewCodex $true `
    -ExpectCompleteTask $false `
    -ExpectMissingImplementation $false

Invoke-AutoCycleResumeScenario `
    -Name "saved-review-stale-fingerprint-reruns-review" `
    -InitialSavedReview $true `
    -InitialReviewTaskId "T001" `
    -InitialTestTaskId "T999" `
    -InitialTestResult "passed" `
    -InitialDiffAppFiles @("stale-file.ps1") `
    -InitialLastCommitHash "HEAD" `
    -CodexResultAfterRun "fresh implementation" `
    -ExpectedStoppedReason "allow_commit_required" `
    -ExpectRunCodex $true `
    -ExpectRunReviewCodex $true `
    -ExpectCompleteTask $false `
    -ExpectMissingImplementation $false

Invoke-AutoCycleResumeScenario `
    -Name "saved-review-pass-test-failed-does-not-complete" `
    -InitialSavedReview $true `
    -InitialReviewTaskId "T001" `
    -InitialTestTaskId "T001" `
    -InitialTestResult "failed" `
    -InitialDiffAppFiles @("scripts/ai-dev-auto-cycle-full.ps1") `
    -InitialLastCommitHash "HEAD" `
    -FakeCheckPasses $false `
    -ExpectedStoppedReason "test_failed" `
    -ExpectRunCodex $true `
    -ExpectRunReviewCodex $false `
    -ExpectCompleteTask $false `
    -ExpectMissingImplementation $false

Invoke-AutoCycleResumeScenario `
    -Name "previous-task-head-commit-not-implementation" `
    -InitialSavedReview $false `
    -InitialLastCommitHash "HEAD" `
    -CodexResultAfterRun "" `
    -ExpectedStoppedReason "missing_implementation" `
    -ExpectRunCodex $true `
    -ExpectRunReviewCodex $true `
    -ExpectCompleteTask $false `
    -ExpectMissingImplementation $true

Invoke-AutoCycleResumeScenario `
    -Name "previous-task-commit-not-implementation" `
    -InitialSavedReview $false `
    -InitialLastCommitHash "NOT_HEAD" `
    -CodexResultAfterRun "" `
    -ExpectedStoppedReason "missing_implementation" `
    -ExpectRunCodex $true `
    -ExpectRunReviewCodex $true `
    -ExpectCompleteTask $false `
    -ExpectMissingImplementation $true

Invoke-RecoveryCoverageScenario `
    -Name "test-failed-recovers-once-then-passes" `
    -CheckFailuresBeforeSuccess 1 `
    -ExpectedStoppedReason "allow_commit_required" `
    -ExpectedRunCodexCount 2 `
    -ExpectedCheckCount 2 `
    -ExpectedReviewCodexCount 1 `
    -ExpectedRecoveryType "test_failed" `
    -ExpectedRecoveryCount 1 `
    -ExpectRawPreserved $false `
    -ExpectRevisePromptHasTestResult $true

Invoke-RecoveryCoverageScenario `
    -Name "test-failed-twice-stops-without-extra-codex" `
    -CheckFailuresBeforeSuccess 2 `
    -ExpectedStoppedReason "test_failed" `
    -ExpectedRunCodexCount 2 `
    -ExpectedCheckCount 2 `
    -ExpectedReviewCodexCount 0 `
    -ExpectedRecoveryType "test_failed" `
    -ExpectedRecoveryCount 1 `
    -ExpectRawPreserved $false `
    -ExpectRevisePromptHasTestResult $true

Invoke-RecoveryCoverageScenario `
    -Name "review-json-extraction-recovers-once" `
    -ReviewJsonFailuresBeforeSuccess 1 `
    -ExpectedStoppedReason "allow_commit_required" `
    -ExpectedRunCodexCount 1 `
    -ExpectedCheckCount 1 `
    -ExpectedReviewCodexCount 2 `
    -ExpectedRecoveryType "review_json_extraction_failed" `
    -ExpectedRecoveryCount 1 `
    -ExpectRawPreserved $true `
    -ExpectRevisePromptHasTestResult $false

Invoke-RecoveryCoverageScenario `
    -Name "review-json-extraction-twice-stops" `
    -ReviewJsonFailuresBeforeSuccess 2 `
    -ExpectedStoppedReason "review_json_extraction_failed" `
    -ExpectedRunCodexCount 1 `
    -ExpectedCheckCount 1 `
    -ExpectedReviewCodexCount 2 `
    -ExpectedRecoveryType "review_json_extraction_failed" `
    -ExpectedRecoveryCount 1 `
    -ExpectRawPreserved $true `
    -ExpectRevisePromptHasTestResult $false

Invoke-RecoveryCoverageScenario `
    -Name "stale-review-json-stop-reason-does-not-recover" `
    -StaleReviewJsonFailureState $true `
    -ExpectedStoppedReason "run-review-codex_failed" `
    -ExpectedRunCodexCount 1 `
    -ExpectedCheckCount 1 `
    -ExpectedReviewCodexCount 1 `
    -ExpectedRecoveryType "review_json_extraction_failed" `
    -ExpectedRecoveryCount 0 `
    -ExpectRawPreserved $false `
    -ExpectRevisePromptHasTestResult $false

Invoke-RecoveryCoverageScenario `
    -Name "package-scripts-only-allowed" `
    -PackageMutation "scripts" `
    -ExpectedStoppedReason "allow_commit_required" `
    -ExpectedRunCodexCount 1 `
    -ExpectedCheckCount 1 `
    -ExpectedReviewCodexCount 1 `
    -ExpectRawPreserved $false `
    -ExpectRevisePromptHasTestResult $false

Invoke-RecoveryCoverageScenario `
    -Name "package-dependencies-blocked" `
    -PackageMutation "dependencies" `
    -ExpectedStoppedReason "package_files_changed" `
    -ExpectedRunCodexCount 1 `
    -ExpectedCheckCount 1 `
    -ExpectedReviewCodexCount 1 `
    -ExpectRawPreserved $false `
    -ExpectRevisePromptHasTestResult $false

Invoke-RecoveryCoverageScenario `
    -Name "package-lock-blocked" `
    -PackageMutation "packageLock" `
    -ExpectedStoppedReason "package_files_changed" `
    -ExpectedRunCodexCount 1 `
    -ExpectedCheckCount 1 `
    -ExpectedReviewCodexCount 1 `
    -ExpectRawPreserved $false `
    -ExpectRevisePromptHasTestResult $false

Invoke-RecoveryCoverageScenario `
    -Name "same-task-used-test-recovery-does-not-repeat" `
    -CheckFailuresBeforeSuccess 1 `
    -SeedRecoveryTaskId "T001" `
    -SeedRecoveryType "test_failed" `
    -SeedRecoveryCount 1 `
    -ExpectedStoppedReason "test_failed" `
    -ExpectedRunCodexCount 1 `
    -ExpectedCheckCount 1 `
    -ExpectedReviewCodexCount 0 `
    -ExpectedRecoveryType "test_failed" `
    -ExpectedRecoveryCount 1 `
    -ExpectRawPreserved $false `
    -ExpectRevisePromptHasTestResult $false

Invoke-RecoveryCoverageScenario `
    -Name "new-task-test-recovery-count-is-independent" `
    -CurrentTaskId "T002" `
    -CheckFailuresBeforeSuccess 1 `
    -SeedRecoveryTaskId "T001" `
    -SeedRecoveryType "test_failed" `
    -SeedRecoveryCount 1 `
    -ExpectedStoppedReason "allow_commit_required" `
    -ExpectedRunCodexCount 2 `
    -ExpectedCheckCount 2 `
    -ExpectedReviewCodexCount 1 `
    -ExpectedRecoveryType "test_failed" `
    -ExpectedRecoveryCount 1 `
    -ExpectRawPreserved $false `
    -ExpectRevisePromptHasTestResult $true

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
