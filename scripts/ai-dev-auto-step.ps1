param(
    [switch]$Json,
    [switch]$DryRun,
    [switch]$AllowCheck,
    [switch]$AllowReviewPrompt,
    [switch]$AllowSaveDiff
)

. "$PSScriptRoot\ai-dev-env.ps1"

function Stop-WithJsonError {
    param(
        [string]$Message
    )

    $result = [ordered]@{
        action = "error"
        executed = $false
        dryRun = [bool]$DryRun
        exitCode = 1
        message = $Message
        recommendedCommands = @()
    }

    if ($Json) {
        $result | ConvertTo-Json -Depth 10
    } else {
        Write-Error $Message
    }

    exit 1
}

function New-StepResult {
    param(
        [string]$Action,
        [bool]$Executed,
        [int]$ExitCode,
        [string]$Message,
        [string[]]$RecommendedCommands
    )

    return [ordered]@{
        action = $Action
        executed = $Executed
        dryRun = [bool]$DryRun
        exitCode = $ExitCode
        message = $Message
        recommendedCommands = @($RecommendedCommands)
    }
}

function Invoke-AiDevScript {
    param(
        [string]$ScriptName,
        [string[]]$Arguments
    )

    $scriptPath = Join-Path $PSScriptRoot $ScriptName

    if (-not (Test-Path -LiteralPath $scriptPath -PathType Leaf)) {
        throw "스크립트를 찾을 수 없습니다: $ScriptName"
    }

    $output = & powershell -ExecutionPolicy Bypass -File $scriptPath @Arguments 2>&1 | Out-String
    $exitCode = $LASTEXITCODE

    return [PSCustomObject]@{
        ExitCode = $exitCode
        Output = $output.TrimEnd()
    }
}

function Write-StepResult {
    param(
        [object]$Result
    )

    if ($Json) {
        $Result | ConvertTo-Json -Depth 10
        return
    }

    Write-Host "Action: $($Result.action)"
    Write-Host "Executed: $($Result.executed)"
    Write-Host "Dry run: $($Result.dryRun)"
    Write-Host "Exit code: $($Result.exitCode)"
    Write-Host "Message: $($Result.message)"
    Write-Host "Recommended commands:"

    if ($Result.recommendedCommands.Count -eq 0) {
        Write-Host "  - 없음"
    } else {
        foreach ($command in $Result.recommendedCommands) {
            Write-Host "  - $command"
        }
    }
}

try {
    $nextOutput = & powershell -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "ai-dev-next.ps1") -Json 2>&1 | Out-String

    if ($LASTEXITCODE -ne 0) {
        Stop-WithJsonError "ai-dev-next.ps1 실행에 실패했습니다: $nextOutput"
    }

    $next = $nextOutput | ConvertFrom-Json
} catch {
    Stop-WithJsonError "다음 action 판단에 실패했습니다: $($_.Exception.Message)"
}

$action = [string]$next.action
$recommendedCommands = @($next.recommendedCommands)
$commandDisplay = if ($recommendedCommands.Count -gt 0) { $recommendedCommands[0] } else { "" }
$scriptToRun = $null
$scriptArguments = @()
$shouldExecute = $false
$message = ""

switch ($action) {
    "make_task_prompt" {
        $scriptToRun = "ai-dev-make-prompt.ps1"
        $shouldExecute = $true
        $message = "현재 task 프롬프트를 생성합니다."
    }
    "run_check" {
        $scriptToRun = "ai-dev-check.ps1"
        $scriptArguments = @("-BuildOnly")
        $shouldExecute = [bool]$AllowCheck
        $message = if ($AllowCheck) {
            "검증을 실행합니다: ai-dev-check.ps1 -BuildOnly"
        } else {
            "검증 단계는 기본 자동 실행 대상이 아닙니다. 실행하려면 -AllowCheck를 사용하세요."
        }
    }
    "save_diff" {
        $scriptToRun = "ai-dev-save-diff.ps1"
        $scriptArguments = @("-IncludeUntrackedContent")
        $shouldExecute = [bool]$AllowSaveDiff
        $message = if ($AllowSaveDiff) {
            "diff를 저장합니다: ai-dev-save-diff.ps1 -IncludeUntrackedContent"
        } else {
            "diff 저장은 기본 자동 실행 대상이 아닙니다. 실행하려면 -AllowSaveDiff를 사용하세요."
        }
    }
    "make_review_prompt" {
        $scriptToRun = "ai-dev-make-review-prompt.ps1"
        $scriptArguments = @("-Strict")
        $shouldExecute = [bool]$AllowReviewPrompt
        $message = if ($AllowReviewPrompt) {
            "리뷰 프롬프트를 생성합니다: ai-dev-make-review-prompt.ps1 -Strict"
        } else {
            "리뷰 프롬프트 생성은 기본 자동 실행 대상이 아닙니다. 실행하려면 -AllowReviewPrompt를 사용하세요."
        }
    }
    default {
        $forbiddenActions = @(
            "run_codex_or_cline",
            "ask_gpt_review",
            "make_revise_prompt",
            "commit",
            "complete_task",
            "stop_for_user",
            "blocked",
            "goal_completed",
            "no_task",
            "inspect_status"
        )

        if ($forbiddenActions -contains $action) {
            $result = New-StepResult `
                -Action $action `
                -Executed $false `
                -ExitCode 0 `
                -Message "이 action은 auto-step에서 자동 실행하지 않습니다. 추천 명령 또는 사용자 판단이 필요합니다." `
                -RecommendedCommands $recommendedCommands
            Write-StepResult $result
            exit 0
        }

        $result = New-StepResult `
            -Action $action `
            -Executed $false `
            -ExitCode 0 `
            -Message "알 수 없는 action입니다. 상태를 수동으로 확인하세요." `
            -RecommendedCommands @("powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1")
        Write-StepResult $result
        exit 0
    }
}

if ($DryRun -or -not $shouldExecute) {
    $result = New-StepResult `
        -Action $action `
        -Executed $false `
        -ExitCode 0 `
        -Message $message `
        -RecommendedCommands $(if ([string]::IsNullOrWhiteSpace($commandDisplay)) { @() } else { @($commandDisplay) })
    Write-StepResult $result
    exit 0
}

try {
    $childResult = Invoke-AiDevScript -ScriptName $scriptToRun -Arguments $scriptArguments

    if ($childResult.ExitCode -ne 0) {
        $result = New-StepResult `
            -Action $action `
            -Executed $true `
            -ExitCode $childResult.ExitCode `
            -Message "하위 스크립트 실행에 실패했습니다: $($childResult.Output)" `
            -RecommendedCommands $recommendedCommands
        Write-StepResult $result
        exit 1
    }

    $result = New-StepResult `
        -Action $action `
        -Executed $true `
        -ExitCode 0 `
        -Message $message `
        -RecommendedCommands $recommendedCommands
    Write-StepResult $result
    exit 0
} catch {
    $result = New-StepResult `
        -Action $action `
        -Executed $true `
        -ExitCode 1 `
        -Message "auto-step 실행에 실패했습니다: $($_.Exception.Message)" `
        -RecommendedCommands $recommendedCommands
    Write-StepResult $result
    exit 1
}
