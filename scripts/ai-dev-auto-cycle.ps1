param(
    [int]$MaxSteps = 5,
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowCheck,
    [switch]$AllowSaveDiff,
    [switch]$AllowReviewPrompt
)

. "$PSScriptRoot\ai-dev-env.ps1"

function Write-CycleResult {
    param(
        [object]$Result
    )

    if ($Json) {
        $Result | ConvertTo-Json -Depth 20
        return
    }

    foreach ($step in $Result.steps) {
        Write-Host "Step $($step.step):"
        Write-Host "  Action: $($step.action)"
        Write-Host "  Executed: $($step.executed)"
        Write-Host "  Message: $($step.message)"
    }

    Write-Host "Stopped reason: $($Result.stoppedReason)"
    Write-Host "Completed: $($Result.completed)"
    Write-Host "Exit code: $($Result.exitCode)"
}

function New-CycleResult {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    return [ordered]@{
        steps = @($Steps)
        stoppedReason = $StoppedReason
        completed = $Completed
        exitCode = $ExitCode
    }
}

if ($MaxSteps -lt 1) {
    $result = New-CycleResult @() "max_steps_must_be_at_least_1" $false 1
    Write-CycleResult $result
    exit 1
}

$userInterventionActions = @(
    "run_codex_or_cline",
    "ask_gpt_review",
    "make_revise_prompt",
    "commit",
    "complete_task",
    "stop_for_user",
    "blocked",
    "inspect_status"
)
$terminalActions = @(
    "goal_completed",
    "no_task"
)
$steps = @()
$previousAction = $null
$autoStepPath = Join-Path $PSScriptRoot "ai-dev-auto-step.ps1"

if (-not (Test-Path -LiteralPath $autoStepPath -PathType Leaf)) {
    $result = New-CycleResult @() "auto_step_script_not_found" $false 1
    Write-CycleResult $result
    exit 1
}

for ($index = 1; $index -le $MaxSteps; $index++) {
    $arguments = @("-Json")

    if ($DryRun) {
        $arguments += "-DryRun"
    }

    if ($AllowCheck) {
        $arguments += "-AllowCheck"
    }

    if ($AllowSaveDiff) {
        $arguments += "-AllowSaveDiff"
    }

    if ($AllowReviewPrompt) {
        $arguments += "-AllowReviewPrompt"
    }

    $autoStepOutput = & powershell -ExecutionPolicy Bypass -File $autoStepPath @arguments 2>&1 | Out-String
    $autoStepExitCode = $LASTEXITCODE

    if ($autoStepExitCode -ne 0) {
        $step = [ordered]@{
            step = $index
            action = "auto_step_failed"
            executed = $false
            exitCode = $autoStepExitCode
            message = $autoStepOutput.Trim()
        }
        $steps += [PSCustomObject]$step
        $result = New-CycleResult $steps "auto_step_failed" $false 1
        Write-CycleResult $result
        exit 1
    }

    try {
        $autoStep = $autoStepOutput | ConvertFrom-Json
    } catch {
        $step = [ordered]@{
            step = $index
            action = "auto_step_json_parse_failed"
            executed = $false
            exitCode = 1
            message = $_.Exception.Message
        }
        $steps += [PSCustomObject]$step
        $result = New-CycleResult $steps "auto_step_json_parse_failed" $false 1
        Write-CycleResult $result
        exit 1
    }

    $action = [string]$autoStep.action
    $stepResult = [ordered]@{
        step = $index
        action = $action
        executed = [bool]$autoStep.executed
        exitCode = [int]$autoStep.exitCode
        message = [string]$autoStep.message
    }
    $steps += [PSCustomObject]$stepResult

    if ($terminalActions -contains $action) {
        $completed = $action -eq "goal_completed"
        $result = New-CycleResult $steps $action $completed 0
        Write-CycleResult $result
        exit 0
    }

    if ($userInterventionActions -contains $action) {
        $result = New-CycleResult $steps "user_intervention_required:$action" $false 0
        Write-CycleResult $result
        exit 0
    }

    if (-not [bool]$autoStep.executed) {
        $result = New-CycleResult $steps "no_automatic_work_remaining:$action" $false 0
        Write-CycleResult $result
        exit 0
    }

    if ($null -ne $previousAction -and $previousAction -eq $action) {
        $result = New-CycleResult $steps "repeated_action_without_progress:$action" $false 0
        Write-CycleResult $result
        exit 0
    }

    $previousAction = $action
}

$finalResult = New-CycleResult $steps "max_steps_reached" $false 0
Write-CycleResult $finalResult
exit 0
