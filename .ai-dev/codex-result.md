# Codex Implementation Result

## Run

- Started at: 2026-07-31 11:33:52
- Ended at: 2026-07-31 11:34:48
- Exit code: 0
- Prompt: .ai-dev/maxsteps-targeted-fix-prompt.md
- Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -PromptPath .ai-dev/maxsteps-targeted-fix-prompt.md -AllowDirty

## Output

```text
node.exe : OpenAI Codex v0.133.0
위치 C:\Users\SECUI\AppData\Roaming\npm\codex.ps1:24 문자:5
+     & "node$exe"  "$basedir/node_modules/@openai/codex/bin/codex.js"  ...
+     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (OpenAI Codex v0.133.0:String) 
    [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 
--------
workdir: D:\ai-apps\planpilot-local
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: medium
reasoning summaries: none
session id: 019fb605-611a-7dc0-90d1-8e6a1a882674
--------
user
Read and follow the full task prompt at this absolute file path: D:\ai-apps
\planpilot-local\.ai-dev\maxsteps-targeted-fix-prompt.md

Additional safety rules for this local AI Dev Loop run:
- Do not run git commit, git reset, git checkout, git clean, git rebase, gi
t merge, or git push.
- Do not run npm install.
- Do not modify package.json, package-lock.json, node_modules, dist, or .gi
t.
- Do not broaden the current task scope beyond the prompt file.
- If the task requirements conflict with repository rules, stop and report 
the conflict.
codex
작업 프롬프트 파일만 먼저 읽어서 요구사항과 수정 범위를 확인하겠습니다. 이후 필요한 파일을 읽기 전에 이유와 범위를 짧게 공유하겠습니
다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\maxsteps-t
argeted-fix-prompt.md'" in D:\ai-apps\planpilot-local
 succeeded in 2061ms:
현재 task는 "auto-goal MaxSteps 전달 안정화"입니다.

이전 구현에서 예상 파일 경로가 잘못 지정되어 실제 구현 변경이 생성되지 않았습니다.

반드시 실제 파일인 다음 파일을 확인하고 수정하세요.

scripts/ai-dev-auto-goal.ps1

요구사항:
1. ai-dev-auto-goal.ps1의 MaxSteps 기본값을 full-cycle 실행에 충분한 값으로 변경하세요. 기본값은 4
0으로 설정합니다.
2. 사용자가 -MaxSteps 값을 직접 지정하면 그 값을 ai-dev-auto-cycle-full.ps1 호출에 그대로 전달하세요.
3. 기존 -AllowCodex, -AllowReviewCodex, -AllowCommit, -AllowDirty, -MaxTasks 
전달 흐름은 유지하세요.
4. auto-goal이 생성한 task가 기본 실행만으로 max_steps_too_small_for_full_cycle에서 중단되지 
않아야 합니다.
5. .ai-dev/scripts 경로는 존재하지 않으므로 사용하지 마세요.
6. 이 task와 관계없는 파일은 수정하지 마세요.
7. 실제 구현 변경을 반드시 저장하세요.

codex
프롬프트가 지정한 실제 대상은 `scripts/ai-dev-auto-goal.ps1` 하나입니다. MaxSteps 파라미터 기본값과 f
ull-cycle 호출부만 확인해서 최소 수정하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-aut
o-goal.ps1'" in D:\ai-apps\planpilot-local
 succeeded in 1982ms:
param(
    [AllowEmptyString()]
    [string]$GoalTitle,
    [AllowEmptyString()]
    [string]$GoalDescription,
    [int]$MaxTasks = 1,
    [int]$MaxSteps = 20,
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowRun,
    [switch]$AllowCodex,
    [switch]$AllowReviewCodex,
    [switch]$AllowCommit,
    [switch]$AllowDirty,
    [string[]]$CommitFiles,
    [string]$ResultPath = ".ai-dev/codex-result.md"
)

. "$PSScriptRoot\ai-dev-env.ps1"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
$codeFence = '```'
$goalRelativePath = ".ai-dev/goal.md"
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$promptRelativePath = ".ai-dev/current-task-prompt.md"
$planningPromptRelativePath = ".ai-dev/auto-goal-planning-prompt.md"
$legacyAutoGoalResultRelativePath = ".ai-dev/auto-goal-codex-result.md"
$aiDevOperationalRoot = ".ai-dev/"
$script:autoGoalCanWriteResultFile = $true
$script:autoGoalCanCleanTempArtifacts = $true

function Resolve-RepoPath {
    param([string]$Path)

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return $Path
    }

    return Join-Path $repoRoot $Path
}

function ConvertTo-RepoRelativePath {
    param([string]$Path)

    $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $Path))
    $rootWithSeparator = $repoRoot.TrimEnd("\") + "\"

    if ($fullPath.StartsWith($rootWithSeparator, [System.StringComparison]:
:OrdinalIgnoreCase)) {
        return $fullPath.Substring($rootWithSeparator.Length).Replace("\", 
"/")
    }

    return $fullPath.Replace("\", "/")
}

function Test-HasValue {
    param([object]$Value)

    if ($null -eq $Value) {
        return $false
    }

    if ($Value -is [string]) {
        return -not [string]::IsNullOrWhiteSpace($Value)
    }

    return $true
}

function New-StepResult {
    param(
        [int]$Step,
        [string]$Name,
        [string]$Command,
        [bool]$Executed,
        [bool]$Skipped,
        [int]$ExitCode,
        [string]$Message
    )

    return [PSCustomObject][ordered]@{
        step = $Step
        name = $Name
        command = $Command
        executed = $Executed
        skipped = $Skipped
        exitCode = $ExitCode
        message = $Message
    }
}

function New-AutoGoalResult {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    return [PSCustomObject][ordered]@{
        steps = @($Steps)
        stoppedReason = $StoppedReason
        completed = $Completed
        exitCode = $ExitCode
        plan = $script:autoGoalPlanPreview
        goalPath = $goalRelativePath
        queuePath = $queueRelativePath
        statePath = $stateRelativePath
        promptPath = $promptRelativePath
        resultPath = (ConvertTo-RepoRelativePath $ResultPath)
    }
}

function Write-AutoGoalResult {
    param([object]$Result)

    if ($Json) {
        $Result | ConvertTo-Json -Depth 30
        return
    }

    foreach ($step in @($Result.steps)) {
        Write-Host "Step $($step.step): $($step.name)"
        Write-Host "  Command: $($step.command)"
        Write-Host "  Executed: $($step.executed)"
        Write-Host "  Skipped: $($step.skipped)"
        Write-Host "  Exit code: $($step.exitCode)"
        Write-Host "  Message: $($step.message)"
    }

    if ($null -ne $Result.plan) {
        Write-Host "Plan preview:"
        Write-Host "  Goal title: $($Result.plan.queue.goalTitle)"
        Write-Host "  Current task id: $($Result.plan.queue.currentTaskId)"

        foreach ($task in @($Result.plan.queue.tasks)) {
            Write-Host "  Task $($task.id): $($task.title)"
            Write-Host "    Type: $($task.type)"
            Write-Host "    Status: $($task.status)"
            Write-Host "    Priority: $($task.priority)"
            Write-Host "    Likely files: $((@($task.filesLikelyToChange) -
join ', '))"
            Write-Host "    Verification: $((@($task.verification) -join ' 
/ '))"
        }
    }

    Write-Host "Stopped reason: $($Result.stoppedReason)"
    Write-Host "Completed: $($Result.completed)"
    Write-Host "Exit code: $($Result.exitCode)"
}

function Save-AutoGoalResultFile {
    param(
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    $result = New-AutoGoalResult $script:steps $StoppedReason $Completed $E
xitCode
    $stepLines = @()

    foreach ($step in @($result.steps)) {
        $stepLines += "- Step $($step.step) $($step.name): exitCode=$($step
.exitCode), executed=$($step.executed), skipped=$($step.skipped)"
        if (Test-HasValue $step.message) {
            $stepLines += "  - Message: $($step.message)"
        }
    }

    $content = @"
# Codex Auto Goal Final Result

## Summary

- Stopped reason: $($result.stoppedReason)
- Completed: $($result.completed)
- Exit code: $($result.exitCode)
- Result path: $($result.resultPath)

## Steps

$($stepLines -join "`r`n")
"@

    [System.IO.File]::WriteAllText($resolvedResultPath, $content, $utf8With
Bom)
}

function Clear-AutoGoalTempArtifacts {
    if (-not $script:autoGoalCanCleanTempArtifacts) {
        return
    }

    $currentResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $R
esultPath))

    foreach ($relativePath in @($planningPromptRelativePath, $legacyAutoGoa
lResultRelativePath)) {
        $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $relati
vePath))

        if (-not $fullPath.StartsWith($repoRoot.TrimEnd("\") + "\", [System
.StringComparison]::OrdinalIgnoreCase)) {
            continue
        }

        if ($fullPath.Equals($currentResultPath, [System.StringComparison]:
:OrdinalIgnoreCase)) {
            continue
        }

        try {
            if ([System.IO.File]::Exists($fullPath)) {
                [System.IO.File]::Delete($fullPath)
            }
        } catch {
            Write-Warning "Failed to clean auto-goal temp artifact: $relati
vePath"
        }
    }
}

function Stop-AutoGoal {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    if (-not $DryRun) {
        Clear-AutoGoalTempArtifacts
    }

    if (-not $DryRun -and (-not $Completed -or $ExitCode -ne 0)) {
        if ($script:autoGoalCanWriteResultFile) {
            Save-AutoGoalResultFile $StoppedReason $false $ExitCode
        }
    }
    Write-AutoGoalResult (New-AutoGoalResult $Steps $StoppedReason $Complet
ed $ExitCode)
    exit $ExitCode
}

function Get-InputPreview {
    param([string]$RawInput)

    if ($null -eq $RawInput) {
        return "<null>"
    }

    $normalized = $RawInput.Replace("`r", " ").Replace("`n", " ").Trim()

    if ($normalized.Length -eq 0) {
        return "<empty>"
    }

    if ($normalized.Length -le 500) {
        return $normalized
    }

    return $normalized.Substring(0, 500)
}

function Invoke-GitStatusLines {
    param(
        [string[]]$Arguments,
        [string]$CommandText,
        [int]$FailureStep = 2,
        [string]$FailureName = "dirty-worktree-gate"
    )

    $statusOutput = & git @Arguments 2>&1

    if ($LASTEXITCODE -ne 0) {
        $script:steps += New-StepResult $FailureStep $FailureName $CommandT
ext $false $false 1 "git status failed: $($statusOutput -join "`n")"
        Stop-AutoGoal $script:steps "git_status_failed" $false 1
    }

    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpa
ce($_) })
}

function Get-GitStatusLines {
    param(
        [int]$FailureStep = 2,
        [string]$FailureName = "dirty-worktree-gate"
    )

    return @(Invoke-GitStatusLines -Arguments @("status", "--short") -Comma
ndText "git status --short" -FailureStep $FailureStep -FailureName $Failure
Name)
}

function Get-GitPorcelainStatusLines {
    param(
        [int]$FailureStep = 2,
        [string]$FailureName = "dirty-worktree-gate"
    )

    return @(Invoke-GitStatusLines -Arguments @("status", "--porcelain") -C
ommandText "git status --porcelain" -FailureStep $FailureStep -FailureName 
$FailureName)
}

function Convert-ToChangedPath {
    param([string]$ChangeLine)

    if ([string]::IsNullOrWhiteSpace($ChangeLine)) {
        return @()
    }

    $pathText = $ChangeLine

    if ($ChangeLine.Length -ge 4 -and $ChangeLine.Substring(2, 1) -eq " ") 
{
        $pathText = $ChangeLine.Substring(3)
    }

    if ($pathText.Contains(" -> ")) {
        return @($pathText -split " -> " | Where-Object { Test-HasValue $_ 
})
    }

    return @($pathText)
}

function ConvertTo-NormalizedChangedPath {
    param([string]$RelativePath)

    if (-not (Test-HasValue $RelativePath)) {
        return $null
    }

    return $RelativePath.Trim().Trim('"').Replace('\', '/')
}

function Test-IsAiDevOperationalPath {
    param([string]$RelativePath)

    $normalizedRelativePath = ConvertTo-NormalizedChangedPath $RelativePath
    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [Syste
m.StringComparison]::OrdinalIgnoreCase)
}

function Get-PlannedAutoGoalOutputPaths {
    return @(
        $ResultPath,
        $goalRelativePath,
        $queueRelativePath,
        $stateRelativePath,
        $promptRelativePath,
        $planningPromptRelativePath,
        ".ai-dev/codex-result.md",
        $legacyAutoGoalResultRelativePath
    ) |
        Where-Object { Test-HasValue $_ } |
        ForEach-Object { ConvertTo-NormalizedChangedPath (ConvertTo-RepoRel
ativePath $_) } |
        Select-Object -Unique
}

function Invoke-BaselineOutputConflictGate {
    param(
        [string[]]$BaselineDirtyPaths,
        [string[]]$PlannedOutputPaths
    )

    $conflictingPaths = @(
        $BaselineDirtyPaths |
            Where-Object { $PlannedOutputPaths -contains $_ } |
            Select-Object -Unique
    )

    if ($conflictingPaths.Count -eq 0) {
        return
    }

    $script:autoGoalCanWriteResultFile = $false
    $script:autoGoalCanCleanTempArtifacts = $false
    $message = "Baseline dirty paths conflict with planned auto-goal output
 paths. Auto-goal stopped before writing or deleting protected output files
.`nConflicting paths:`n$($conflictingPaths -join "`n")"
    $script:steps += New-StepResult 2 "baseline-output-conflict-gate" "comp
are baseline dirty paths with planned auto-goal outputs" $true $false 1 $me
ssage
    Stop-AutoGoal $script:steps "baseline_output_conflict" $false 1
}

function Invoke-FinalAutoGoalChangeGate {
    param(
        [int]$StepNumber
    )

    Clear-AutoGoalTempArtifacts

    $statusLines = @(Get-GitStatusLines $StepNumber "final-change-gate")
    $command = "cleanup auto-goal temp artifacts, git status --short"
    $baselineDirtyPaths = @($script:autoGoalBaselineDirtyPaths)
    $baselineDirtyCount = $baselineDirtyPaths.Count
    $finalDirtyCount = $statusLines.Count

    if ($statusLines.Count -eq 0 -and $baselineDirtyCount -gt 0) {
        $message = "Final clean verification failed: baseline dirty paths f
rom auto-goal start are no longer visible in git status. They may have been
 committed or otherwise swallowed, so auto-goal will not report completed.`
nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyC
ount`nFinal .ai-dev meta commit created: skipped (baseline dirty disappeare
d).`nBaseline dirty paths:`n$($baselineDirtyPaths -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $co
mmand $true $false 1 $message
        Stop-AutoGoal $script:steps "final_baseline_dirty_disappeared" $fal
se 1
    }

    if ($statusLines.Count -eq 0) {
        $message = "Baseline dirty count: $baselineDirtyCount`nFinal dirty 
count: $finalDirtyCount`nFinal .ai-dev meta commit created: skipped (no fin
al changes).`nFinal clean verification: git status --short returned no chan
ges."
        $script:steps += New-StepResult $StepNumber "final-change-gate" $co
mmand $true $false 0 $message
        return
    }

    $changedPaths = @(
        $statusLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            Where-Object { Test-HasValue $_ } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Select-Object -Unique
    )
    $baselineRemainingPaths = @($changedPaths | Where-Object { $baselineDir
tyPaths -contains $_ })
    $baselineMissingPaths = @($baselineDirtyPaths | Where-Object { $changed
Paths -notcontains $_ })
    $nonAiDevPaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOpe
rationalPath $_) })
    $newAiDevPaths = @($changedPaths | Where-Object { (Test-IsAiDevOperatio
nalPath $_) -and ($baselineDirtyPaths -notcontains $_) })

    if ($baselineMissingPaths.Count -gt 0) {
        $message = "Final clean verification failed: baseline dirty paths f
rom auto-goal start disappeared before completion. They may have been commi
tted or otherwise swallowed, so auto-goal will not report completed.`nBasel
ine dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`n
Final .ai-dev meta commit created: skipped (baseline dirty disappeared).`nM
issing baseline dirty paths:`n$($baselineMissingPaths -join "`n")`n$($statu
sLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $co
mmand $true $false 1 $message
        Stop-AutoGoal $script:steps "final_baseline_dirty_disappeared" $fal
se 1
    }

    if ($baselineRemainingPaths.Count -gt 0) {
        $message = "Final clean verification failed: baseline dirty files r
emain, so auto-goal will not report completed.`nBaseline dirty count: $base
lineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta com
mit created: skipped (baseline dirty remains).`nRemaining baseline dirty pa
ths:`n$($baselineRemainingPaths -join "`n")`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $co
mmand $true $false 1 $message
        Stop-AutoGoal $script:steps "final_baseline_dirty_remains" $false 1
    }

    if ($nonAiDevPaths.Count -gt 0) {
        $message = "Final clean verification failed: non-.ai-dev changes re
main, so auto-goal will not report completed.`nBaseline dirty count: $basel
ineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta comm
it created: skipped (non-.ai-dev dirty remains).`n$($statusLines -join "`n"
)"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $co
mmand $true $false 1 $message
        Stop-AutoGoal $script:steps "final_non_ai_dev_changes" $false 1
    }

    if ($newAiDevPaths.Count -eq 0) {
        $message = "Final clean verification failed: dirty paths remain, bu
t none are new .ai-dev operational changes that auto-goal may commit.`nBase
line dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`
nFinal .ai-dev meta commit created: skipped (no eligible .ai-dev changes).`
n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $co
mmand $true $false 1 $message
        Stop-AutoGoal $script:steps "final_no_eligible_meta_changes" $false
 1
    }

    if (-not $AllowCommit) {
        $message = "Final clean verification failed: only new .ai-dev opera
tional changes remain, but -AllowCommit is required to create the final met
a commit.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $f
inalDirtyCount`nFinal .ai-dev meta commit created: skipped (-AllowCommit mi
ssing).`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $co
mmand $true $false 1 $message
        Stop-AutoGoal $script:steps "final_ai_dev_changes_require_commit" $
false 1
    }

    $addArguments = @("add", "--") + $newAiDevPaths
    $addOutput = & git @addArguments 2>&1 | Out-String
    $addExitCode = $LASTEXITCODE

    if ($addExitCode -ne 0) {
        $message = "auto-goal 최종 .ai-dev 메타 변경 git add 실패. exit code: $addE
xitCode`n$addOutput"
        $script:steps += New-StepResult $StepNumber "final-change-gate" "gi
t add -- <final .ai-dev files>" $true $false 1 $message
        Stop-AutoGoal $script:steps "final_meta_add_failed" $false 1
    }

    $metaCommitMessage = "chore(ai-dev): record final auto-goal state"
    $commitArguments = @("commit", "-m", $metaCommitMessage, "--") + $newAi
DevPaths
    $commitOutput = & git @commitArguments 2>&1 | Out-String
    $commitExitCode = $LASTEXITCODE

    if ($commitExitCode -ne 0) {
        $message = "auto-goal 최종 .ai-dev 메타 커밋 실패. exit code: $commitExitCo
de`n$commitOutput"
        $script:steps += New-StepResult $StepNumber "final-change-gate" "gi
t commit -m '$metaCommitMessage' -- <final .ai-dev files>" $true $false 1 $
message
        Stop-AutoGoal $script:steps "final_meta_commit_failed" $false 1
    }

    $remainingStatus = @(Get-GitStatusLines $StepNumber "final-change-gate"
)

    if ($remainingStatus.Count -gt 0) {
        $message = "Final clean verification failed: changes remain after t
he final .ai-dev meta commit, so auto-goal will not report completed.`nBase
line dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`
nFinal .ai-dev meta commit created: yes`nFinal clean verification: failed; 
git status --short still reports $($remainingStatus.Count) change(s).`n$($r
emainingStatus -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" "gi
t status --short" $true $false 1 $message
        Stop-AutoGoal $script:steps "final_worktree_dirty" $false 1
    }

    $message = ($commitOutput.Trim(), "Baseline dirty count: $baselineDirty
Count", "Final dirty count: $finalDirtyCount", "Final .ai-dev meta commit c
reated: yes", "Final clean verification: git status --short returned no cha
nges.") -join "`n"
    $script:steps += New-StepResult $StepNumber "final-change-gate" "git ad
d/commit final .ai-dev operational changes, git status --short" $true $fals
e 0 $message
}

function Invoke-CompletedCleanVerification {
    param([int]$StepNumber)

    $remainingStatus = @(Get-GitStatusLines $StepNumber "completed-clean-ga
te")

    if ($remainingStatus.Count -gt 0) {
        $message = "Completed clean verification failed: git status --short
 still reports $($remainingStatus.Count) change(s) after all result/state f
iles were written and the final gate ran.`n$($remainingStatus -join "`n")"
        $script:steps += New-StepResult $StepNumber "completed-clean-gate" 
"git status --short" $true $false 1 $message
        Stop-AutoGoal $script:steps "completed_worktree_dirty" $false 1
    }

    $script:steps += New-StepResult $StepNumber "completed-clean-gate" "git
 status --short" $true $false 0 "Completed clean verification passed: git s
tatus --short returned no changes after all result/state files were written
."
}

function Invoke-FinalPreparedResultGate {
    param(
        [int]$StepNumber,
        [int]$CleanGateStepNumber,
        [string]$StoppedReason
    )

    Clear-AutoGoalTempArtifacts

    $command = "write final result, git add/commit final .ai-dev operationa
l changes, git status --short"
    $baselineDirtyPaths = @($script:autoGoalBaselineDirtyPaths)
    $baselineDirtyCount = $baselineDirtyPaths.Count
    $preparedGateStepsWritten = $false

    Save-AutoGoalResultFile $StoppedReason $true 0

    $statusLines = @(Get-GitStatusLines $StepNumber "final-change-gate")
    $finalDirtyCount = $statusLines.Count

    if ($statusLines.Count -eq 0 -and $baselineDirtyCount -gt 0) {
        $message = "Final clean verification failed: baseline dirty paths f
rom auto-goal start are no longer visible in git status. They may have been
 committed or otherwise swallowed, so auto-goal will not report completed.`
nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyC
ount`nFinal .ai-dev meta commit created: skipped (baseline dirty disappeare
d).`nBaseline dirty paths:`n$($baselineDirtyPaths -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $co
mmand $true $false 1 $message
        Stop-AutoGoal $script:steps "final_baseline_dirty_disappeared" $fal
se 1
    }

    if ($statusLines.Count -eq 0) {
        $message = "Baseline dirty count: $baselineDirtyCount`nFinal dirty 
count: $finalDirtyCount before writing final gate entries.`nFinal .ai-dev m
eta commit created: pending if final gate entries dirty the result file.`nF
inal clean verification: git status --short will be required after the fina
l result file is written."
        $script:steps += New-StepResult $StepNumber "final-change-gate" $co
mmand $true $false 0 $message
        $script:steps += New-StepResult $CleanGateStepNumber "completed-cle
an-gate" "git status --short" $true $false 0 "Completed clean verification 
passed: git status --short returned no changes after the final result file 
was written."
        Save-AutoGoalResultFile $StoppedReason $true 0
        $preparedGateStepsWritten = $true
        $statusLines = @(Get-GitStatusLines $StepNumber "final-change-gate"
)
        $finalDirtyCount = $statusLines.Count

        if ($statusLines.Count -eq 0) {
            return
        }
    }

    $changedPaths = @(
        $statusLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            Where-Object { Test-HasValue $_ } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Select-Object -Unique
    )
    $baselineRemainingPaths = @($changedPaths | Where-Object { $baselineDir
tyPaths -contains $_ })
    $baselineMissingPaths = @($baselineDirtyPaths | Where-Object { $changed
Paths -notcontains $_ })
    $nonAiDevPaths = @($changedPaths | Where-Object { -not (Test-IsAiDevOpe
rationalPath $_) })
    $newAiDevPaths = @($changedPaths | Where-Object { (Test-IsAiDevOperatio
nalPath $_) -and ($baselineDirtyPaths -notcontains $_) })

    if ($baselineMissingPaths.Count -gt 0) {
        $message = "Final clean verification failed: baseline dirty paths f
rom auto-goal start disappeared before completion. They may have been commi
tted or otherwise swallowed, so auto-goal will not report completed.`nBasel
ine dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`n
Final .ai-dev meta commit created: skipped (baseline dirty disappeared).`nM
issing baseline dirty paths:`n$($baselineMissingPaths -join "`n")`n$($statu
sLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $co
mmand $true $false 1 $message
        Stop-AutoGoal $script:steps "final_baseline_dirty_disappeared" $fal
se 1
    }

    if ($baselineRemainingPaths.Count -gt 0) {
        $message = "Final clean verification failed: baseline dirty files r
emain, so auto-goal will not report completed.`nBaseline dirty count: $base
lineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta com
mit created: skipped (baseline dirty remains).`nRemaining baseline dirty pa
ths:`n$($baselineRemainingPaths -join "`n")`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $co
mmand $true $false 1 $message
        Stop-AutoGoal $script:steps "final_baseline_dirty_remains" $false 1
    }

    if ($nonAiDevPaths.Count -gt 0) {
        $message = "Final clean verification failed: non-.ai-dev changes re
main, so auto-goal will not report completed.`nBaseline dirty count: $basel
ineDirtyCount`nFinal dirty count: $finalDirtyCount`nFinal .ai-dev meta comm
it created: skipped (non-.ai-dev dirty remains).`n$($statusLines -join "`n"
)"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $co
mmand $true $false 1 $message
        Stop-AutoGoal $script:steps "final_non_ai_dev_changes" $false 1
    }

    if ($newAiDevPaths.Count -eq 0) {
        $message = "Final clean verification failed: dirty paths remain, bu
t none are new .ai-dev operational changes that auto-goal may commit.`nBase
line dirty count: $baselineDirtyCount`nFinal dirty count: $finalDirtyCount`
nFinal .ai-dev meta commit created: skipped (no eligible .ai-dev changes).`
n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $co
mmand $true $false 1 $message
        Stop-AutoGoal $script:steps "final_no_eligible_meta_changes" $false
 1
    }

    if (-not $AllowCommit) {
        $message = "Final clean verification failed: only new .ai-dev opera
tional changes remain, but -AllowCommit is required to create the final met
a commit.`nBaseline dirty count: $baselineDirtyCount`nFinal dirty count: $f
inalDirtyCount`nFinal .ai-dev meta commit created: skipped (-AllowCommit mi
ssing).`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $co
mmand $true $false 1 $message
        Stop-AutoGoal $script:steps "final_ai_dev_changes_require_commit" $
false 1
    }

    if (-not $preparedGateStepsWritten) {
        $message = "Baseline dirty count: $baselineDirtyCount`nFinal dirty 
count: $finalDirtyCount`nFinal .ai-dev meta commit created: pending; this f
inal result file is written before that commit and included in it.`nFinal .
ai-dev paths to commit:`n$($newAiDevPaths -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $co
mmand $true $false 0 $message
        $script:steps += New-StepResult $CleanGateStepNumber "completed-cle
an-gate" "git status --short" $true $false 0 "Completed clean verification 
is enforced immediately after the final .ai-dev meta commit; completed=true
 is returned only if git status --short reports no changes."
        Save-AutoGoalResultFile $StoppedReason $true 0
    }

    $statusLines = @(Get-GitStatusLines $StepNumber "final-change-gate")
    $newAiDevPaths = @(
        $statusLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            Where-Object { Test-HasValue $_ } |
            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
            Where-Object { (Test-IsAiDevOperationalPath $_) -and ($baseline
DirtyPaths -notcontains $_) } |
            Select-Object -Unique
    )

    if ($newAiDevPaths.Count -eq 0) {
        $message = "Final clean verification failed: no final .ai-dev opera
tional paths were available to commit after the final result file was writt
en.`n$($statusLines -join "`n")"
        $script:steps += New-StepResult $StepNumber "final-change-gate" $co
mmand $true $false 1 $message
        Stop-AutoGoal $script:steps "final_no_eligible_meta_changes" $false
 1
    }

    $addArguments = @("add", "--") + $newAiDevPaths
    $addOutput = & git @addArguments 2>&1 | Out-String
    $addExitCode = $LASTEXITCODE

    if ($addExitCode -ne 0) {
        $message = "auto-goal 최종 .ai-dev 메타 변경 git add 실패. exit code: $addE
xitCode`n$addOutput"
        $script:steps += New-StepResult $StepNumber "final-change-gate" "gi
t add -- <final .ai-dev files>" $true $false 1 $message
        Stop-AutoGoal $script:steps "final_meta_add_failed" $false 1
    }

    $metaCommitMessage = "chore(ai-dev): record final auto-goal state"
    $commitArguments = @("commit", "-m", $metaCommitMessage, "--") + $newAi
DevPaths
    $commitOutput = & git @commitArguments 2>&1 | Out-String
    $commitExitCode = $LASTEXITCODE

    if ($commitExitCode -ne 0) {
        $message = "auto-goal 최종 .ai-dev 메타 커밋 실패. exit code: $commitExitCo
de`n$commitOutput"
        $script:steps += New-StepResult $StepNumber "final-change-gate" "gi
t commit -m '$metaCommitMessage' -- <final .ai-dev files>" $true $false 1 $
message
        Stop-AutoGoal $script:steps "final_meta_commit_failed" $false 1
    }

    $remainingStatus = @(Get-GitStatusLines $CleanGateStepNumber "completed
-clean-gate")

    if ($remainingStatus.Count -gt 0) {
        $message = "Completed clean verification failed: changes remain aft
er the final .ai-dev meta commit, so auto-goal will not report completed.`n
$($remainingStatus -join "`n")"
        $script:steps += New-StepResult $CleanGateStepNumber "completed-cle
an-gate" "git status --short" $true $false 1 $message
        Stop-AutoGoal $script:steps "completed_worktree_dirty" $false 1
    }
}

function Complete-AutoGoal {
    param(
        [int]$PreFinalGateStepNumber,
        [int]$ResultStepNumber,
        [int]$PostFinalGateStepNumber,
        [int]$CleanGateStepNumber,
        [string]$StoppedReason
    )

    Invoke-FinalAutoGoalChangeGate $PreFinalGateStepNumber
    $script:steps += New-StepResult $ResultStepNumber "write-final-result" 
(ConvertTo-RepoRelativePath $ResultPath) $true $false 0 "Final success resu
lt file is written after the pre-result final change gate and before the fi
nal .ai-dev meta commit."
    Invoke-FinalPreparedResultGate $PostFinalGateStepNumber $CleanGateStepN
umber $StoppedReason
    $script:autoGoalCanCleanTempArtifacts = $false
    Stop-AutoGoal $script:steps $StoppedReason $true 0
}

function Get-JsonObjectCandidates {
    param([string]$RawInput)

    $candidates = @()
    $seen = @{}

    for ($start = 0; $start -lt $RawInput.Length; $start++) {
        if ($RawInput[$start] -ne "{") {
            continue
        }

        $depth = 0
        $inString = $false
        $escaped = $false

        for ($index = $start; $index -lt $RawInput.Length; $index++) {
            $char = $RawInput[$index]

            if ($escaped) {
                $escaped = $false
                continue
            }

            if ($char -eq "\") {
                $escaped = $true
                continue
            }

            if ($char -eq '"') {
                $inString = -not $inString
                continue
            }

            if ($inString) {
                continue
            }

            if ($char -eq "{") {
                $depth++
                continue
            }

            if ($char -eq "}") {
                $depth--

                if ($depth -eq 0) {
                    $candidateText = $RawInput.Substring($start, $index - $
start + 1).Trim()

                    if (-not $seen.ContainsKey($candidateText)) {
                        $seen[$candidateText] = $true
                        $candidates += [PSCustomObject]@{
                            Start = $start
                            Text = $candidateText
                            HasPlanShape = ($candidateText -match '"goalMar
kdown"\s*:' -and $candidateText -match '"queue"\s*:' -and $candidateText -m
atch '"state"\s*:')
                        }
                    }

                    break
                }
            }
        }
    }

    return @($candidates | Sort-Object -Property @{ Expression = "HasPlanSh
ape"; Descending = $true }, @{ Expression = "Start"; Descending = $true } |
 ForEach-Object { $_.Text })
}

function Get-MissingFields {
    param(
        [object]$InputObject,
        [string[]]$RequiredFields
    )

    $missingFields = @()

    foreach ($field in $RequiredFields) {
        if (-not ($InputObject.PSObject.Properties.Name -contains $field)) 
{
            $missingFields += $field
        }
    }

    return $missingFields
}

function Get-QueueValidationErrors {
    param([object]$Queue)

    $errors = @()
    $requiredFields = @("goalTitle", "goalSource", "createdAt", "updatedAt"
, "currentTaskId", "tasks")

    foreach ($field in @(Get-MissingFields $Queue $requiredFields)) {
        $errors += "queue missing field: $field"
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (-not (Test-HasValue $Queue.goalTitle)) {
        $errors += "queue.goalTitle must not be empty."
    }

    if ($Queue.goalSource -ne $goalRelativePath) {
        $errors += "queue.goalSource must be $goalRelativePath."
    }

    if ($Queue.tasks -isnot [System.Collections.IEnumerable] -or $Queue.tas
ks -is [string]) {
        $errors += "queue.tasks must be an array."
        return $errors
    }

    $tasks = @($Queue.tasks)

    if ($tasks.Count -lt 1) {
        $errors += "queue.tasks must contain at least one task."
        return $errors
    }

    if ($tasks.Count -gt 3) {
        $errors += "queue.tasks must contain no more than three tasks."
    }

    if ($Queue.currentTaskId -ne "T001") {
        $errors += "queue.currentTaskId must be T001."
    }

    $taskIds = @()

    foreach ($task in $tasks) {
        $taskRequiredFields = @("id", "title", "description", "type", "stat
us", "priority", "dependsOn", "filesLikelyToChange", "verification", "commi
tMessage")
        $taskMissingFields = @(Get-MissingFields $task $taskRequiredFields)

        foreach ($field in $taskMissingFields) {
            $errors += "task missing field: $field"
        }

        if ($taskMissingFields.Count -gt 0) {
            continue
        }

        if (-not (Test-HasValue $task.id)) {
            $errors += "task.id must not be empty."
        } else {
            $taskIds += [string]$task.id
        }

        if (-not (Test-HasValue $task.title)) {
            $errors += "task.title must not be empty."
        }

        if (-not (Test-HasValue $task.description)) {
            $errors += "task.description must not be empty."
        }

        if (@("analysis", "implementation", "documentation", "verification"
) -notcontains $task.type) {
            $errors += "invalid task.type: $($task.type)"
        }

        if (@("pending", "in_progress", "done", "blocked") -notcontains $ta
sk.status) {
            $errors += "invalid task.status: $($task.status)"
        }

        if (@("P0", "P1", "P2") -notcontains $task.priority) {
            $errors += "invalid task.priority: $($task.priority)"
        }

        if ($task.dependsOn -isnot [System.Collections.IEnumerable] -or $ta
sk.dependsOn -is [string]) {
            $errors += "task.dependsOn must be an array: $($task.id)"
        }

        if ($task.filesLikelyToChange -isnot [System.Collections.IEnumerabl
e] -or $task.filesLikelyToChange -is [string]) {
            $errors += "task.filesLikelyToChange must be an array: $($task.
id)"
        }

        if ($task.verification -isnot [System.Collections.IEnumerable] -or 
$task.verification -is [string]) {
            $errors += "task.verification must be an array: $($task.id)"
        }
    }

    if ((@($tasks | Where-Object { $_.status -eq "in_progress" })).Count -n
e 1) {
        $errors += "queue.tasks must contain exactly one in_progress task."
    }

    if (-not (Test-HasValue $Queue.currentTaskId)) {
        $errors += "queue.currentTaskId must not be empty."
    } elseif ($taskIds -notcontains [string]$Queue.currentTaskId) {
        $errors += "queue.currentTaskId does not match a task: $($Queue.cur
rentTaskId)"
    }

    $firstTask = $tasks | Where-Object { $_.id -eq "T001" } | Select-Object
 -First 1
    if ($null -eq $firstTask) {
        $errors += "queue.tasks must include T001."
    } elseif ($firstTask.status -ne "in_progress") {
        $errors += "T001 must be in_progress."
    }

    foreach ($laterTask in @($tasks | Where-Object { $_.id -ne "T001" })) {
        if ($laterTask.status -ne "pending") {
            $errors += "later tasks must be pending: $($laterTask.id)"
        }
    }

    return $errors
}

function Get-StateValidationErrors {
    param(
        [object]$State,
        [object]$Queue
    )

    $errors = @()
    $requiredFields = @("goalStatus", "currentTaskId", "currentLoop", "maxL
oopsPerTask", "repeatedFailureCount", "lastCommand", "lastCommandStatus", "
lastErrorSummary", "lastReviewDecision", "lastReviewSeverity", "lastCommitH
ash", "startedAt", "updatedAt", "stopReason")

    foreach ($field in @(Get-MissingFields $State $requiredFields)) {
        $errors += "state missing field: $field"
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (@("idle", "in_progress", "completed", "blocked") -notcontains $Stat
e.goalStatus) {
        $errors += "invalid state.goalStatus: $($State.goalStatus)"
    }

    if ($State.currentTaskId -ne $Queue.currentTaskId) {
        $errors += "state.currentTaskId must match queue.currentTaskId."
    }

    if ($State.currentTaskId -ne "T001") {
        $errors += "state.currentTaskId must be T001."
    }

    if (@("not_started", "passed", "failed", "blocked") -notcontains $State
.lastCommandStatus) {
        $errors += "invalid state.lastCommandStatus: $($State.lastCommandSt
atus)"
    }

    if (@("not_started", "pass", "revise", "blocked") -notcontains $State.l
astReviewDecision) {
        $errors += "invalid state.lastReviewDecision: $($State.lastReviewDe
cision)"
    }

    return $errors
}

function Get-AutoGoalValidationErrors {
    param([object]$Plan)

    $errors = @()

    foreach ($field in @(Get-MissingFields $Plan @("goalMarkdown", "queue",
 "state"))) {
        $errors += "plan missing field: $field"
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (-not (Test-HasValue $Plan.goalMarkdown)) {
        $errors += "goalMarkdown must not be empty."
    }

    $errors += @(Get-QueueValidationErrors $Plan.queue)
    $errors += @(Get-StateValidationErrors $Plan.state $Plan.queue)

    return $errors
}

function New-DryRunAutoGoalPlan {
    param(
        [string]$Title,
        [string]$Description
    )

    $now = (Get-Date).ToUniversalTime().ToString("o")
    $safeTitle = $Title.Trim()
    $safeDescription = $Description.Trim()

    $plan = [PSCustomObject][ordered]@{
        goalMarkdown = @"
# 목표

$safeTitle

## 배경

$safeDescription

## 성공 기준

- 입력한 목표에서 현재 작업을 준비한다.
- full auto-cycle 실행 전에 현재 작업 프롬프트가 생성된다.
- full auto-cycle은 명시적인 허용 옵션이 있을 때만 실행된다.

## 제약사항

- 서버 API, 로그인, 클라우드 동기화, npm install, 위험한 git 명령은 사용하지 않는다.
- 저장소 정책과 현재 작업 범위를 따른다.

## 범위 제외

- 패키지 변경
- DB 삭제 또는 초기화
- 광범위한 리팩터링

## 수동 검증

- DryRun 계획과 JSON 출력을 검토한다.
- 현재 작업 프롬프트 생성 여부를 확인한다.
- 필요한 경우 빌드와 검증은 별도로 실행한다.
"@
        queue = [PSCustomObject][ordered]@{
            goalTitle = $safeTitle
            goalSource = $goalRelativePath
            createdAt = $now
            updatedAt = $now
            currentTaskId = "T001"
            tasks = @(
                [PSCustomObject][ordered]@{
                    id = "T001"
                    title = $safeTitle
                    description = $safeDescription
                    type = "implementation"
                    status = "in_progress"
                    priority = "P0"
                    dependsOn = @()
                    filesLikelyToChange = @()
                    verification = @(
                        "변경 범위가 현재 목표와 일치하는지 확인한다.",
                        "필요한 경우 npm run build를 별도로 실행한다."
                    )
                    commitMessage = $null
                }
            )
        }
        state = [PSCustomObject][ordered]@{
            goalStatus = "in_progress"
            currentTaskId = "T001"
            currentLoop = 0
            maxLoopsPerTask = 2
            repeatedFailureCount = 0
            lastCommand = $null
            lastCommandStatus = "not_started"
            lastErrorSummary = $null
            lastReviewDecision = "not_started"
            lastReviewSeverity = $null
            lastCommitHash = $null
            startedAt = $now
            updatedAt = $now
            stopReason = $null
        }
    }

    return $plan
}

function ConvertFrom-CodexAutoGoalOutput {
    param([string]$RawInput)

    $validationFailures = @()

    foreach ($candidate in Get-JsonObjectCandidates $RawInput) {
        try {
            $parsed = $candidate | ConvertFrom-Json

            if ($null -eq $parsed -or $parsed -is [System.Array]) {
                continue
            }

            $validationErrors = @(Get-AutoGoalValidationErrors $parsed)

            if ($validationErrors.Count -gt 0) {
                $validationFailures += "Candidate validation failed: $($val
idationErrors -join '; ')"
                continue
            }

            return [PSCustomObject]@{
                Parsed = $parsed
                JsonText = ($parsed | ConvertTo-Json -Depth 30)
            }
        } catch {
        }
    }

    if ($validationFailures.Count -gt 0) {
        throw "No valid auto-goal JSON object was found in Codex output. Va
lidation errors: $($validationFailures -join ' | ')"
    }

    throw "No valid auto-goal JSON object was found in Codex output."
}

function New-CodexAutoGoalPrompt {
    param(
        [string]$Title,
        [string]$Description
    )

    return @"
You are preparing local AI Dev Loop state files for the repository at $repo
Root.

Return exactly one JSON object and no markdown fences or commentary.

The user supplied this new goal:
Title: $Title
Description: $Description

Create a small, safe goal plan for this repository. The response object mus
t have these fields:
- goalMarkdown: .ai-dev/goal.md에 작성할 마크다운 문자열입니다. "# 목표", "배경", "성공 기준", "제
약사항", "범위 제외", "수동 검증" 섹션을 한국어로 포함해야 합니다.
- queue: an object for .ai-dev/queue.json.
- state: an object for .ai-dev/state.json.

queue rules:
- goalTitle must equal the supplied title.
- goalSource must be ".ai-dev/goal.md".
- createdAt and updatedAt are required and must be ISO 8601 strings.
- currentTaskId must be "T001".
- tasks must contain one to three tasks.
- T001 must be status "in_progress"; later tasks, if any, must be "pending"
.
- each task must include id, title, description, type, status, priority, de
pendsOn, filesLikelyToChange, verification, commitMessage.
- type must be one of analysis, implementation, documentation, verification
.
- priority must be P0, P1, or P2.
- dependsOn, filesLikelyToChange, and verification must be arrays.
- commitMessage must be null or a short English commit message.

state rules:
- goalStatus must be "in_progress".
- currentTaskId must be "T001".
- currentLoop must be 0.
- maxLoopsPerTask must be 2.
- repeatedFailureCount must be 0.
- lastCommand must be null.
- lastCommandStatus must be "not_started".
- lastErrorSummary must be null.
- lastReviewDecision must be "not_started".
- lastReviewSeverity must be null.
- lastCommitHash must be null.
- startedAt and updatedAt must be ISO 8601 strings.
- stopReason must be null.

Safety rules:
- Do not mention server APIs, login, cloud sync, npm install, git reset, gi
t clean, git push, DB deletion, or broad rewrites as implementation steps.
- Prefer one small implementation task when the goal is small.
- Use Korean for user-facing task titles, descriptions, verification, and g
oalMarkdown.
"@
}

function New-CodexAutoGoalWrapperPrompt {
    param(
        [string]$PromptFilePath
    )

    return "Read and follow the full auto-goal planning prompt at this abso
lute file path: $PromptFilePath"
}

function Invoke-CycleCommand {
    param(
        [int]$StepNumber,
        [string]$Name,
        [string]$Command,
        [string]$ScriptPath,
        [string[]]$Arguments
    )

    if ($DryRun) {
        $script:steps += New-StepResult $StepNumber $Name $Command $false $
true 0 "DryRun: child script was not executed."
        return
    }

    $output = & powershell -ExecutionPolicy Bypass -File $ScriptPath @Argum
ents 2>&1 | Out-String
    $exitCode = $LASTEXITCODE
    $message = $output.Trim()

    if ([string]::IsNullOrWhiteSpace($message)) {
        $message = "completed"
    }

    $script:steps += New-StepResult $StepNumber $Name $Command $true $false
 $exitCode $message

    if ($exitCode -ne 0) {
        Stop-AutoGoal $script:steps "$Name`_failed" $false 1
    }
}

function Get-FullCycleArguments {
    $arguments = @("-MaxTasks", ([string]$MaxTasks), "-MaxSteps", ([string]
$MaxSteps))

    if ($AllowCodex) {
        $arguments += "-AllowCodex"
    }

    if ($AllowReviewCodex) {
        $arguments += "-AllowReviewCodex"
    }

    if ($AllowCommit) {
        $arguments += "-AllowCommit"
    }

    # auto-goal writes goal/queue/state/current prompt/result files after t
he initial dirty gate.
    # The downstream full cycle must tolerate those intended artifacts.
    $arguments += "-AllowDirty"

    if ($script:autoGoalBaselineDirtyPaths.Count -gt 0) {
        $arguments += "-ProtectedBaselineDirtyPaths"
        $arguments += ($script:autoGoalBaselineDirtyPaths -join ",")
    }

    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," 
} | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })

        if ($normalizedFiles.Count -gt 0) {
            $arguments += "-CommitFiles"
            $arguments += ($normalizedFiles -join ",")
        }
    }

    return $arguments
}

function Get-CurrentGoalStatus {
    $statePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $stateRela
tivePath))

    try {
        $state = Get-Content -Raw -Encoding UTF8 -LiteralPath $statePath | 
ConvertFrom-Json
    } catch {
        throw "$stateRelativePath JSON 파싱에 실패했습니다: $($_.Exception.Message)"
    }

    if ($null -eq $state -or -not ($state.PSObject.Properties.Name -contain
s "goalStatus")) {
        throw "$stateRelativePath 파일에서 goalStatus를 찾을 수 없습니다."
    }

    return [string]$state.goalStatus
}

Set-Location $repoRoot

$script:steps = @()
$script:autoGoalPlanPreview = $null
$script:autoGoalBaselineStatusLines = @()
$script:autoGoalBaselineDirtyPaths = @()
$resolvedGoalPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $goalRe
lativePath))
$resolvedQueuePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $queue
RelativePath))
$resolvedStatePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $state
RelativePath))
$resolvedPlanningPromptPath = [System.IO.Path]::GetFullPath((Resolve-RepoPa
th $planningPromptRelativePath))
$resolvedResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $Resu
ltPath))

if (-not (Test-HasValue $GoalTitle)) {
    $script:steps += New-StepResult 0 "validate-input" "check GoalTitle" $f
alse $false 1 "GoalTitle must not be empty."
    Stop-AutoGoal $script:steps "invalid_goal_title" $false 1
}

if (-not (Test-HasValue $GoalDescription)) {
    $script:steps += New-StepResult 0 "validate-input" "check GoalDescripti
on" $false $false 1 "GoalDescription must not be empty."
    Stop-AutoGoal $script:steps "invalid_goal_description" $false 1
}

if ($MaxTasks -lt 1) {
    $script:steps += New-StepResult 0 "validate-input" "check MaxTasks" $fa
lse $false 1 "MaxTasks must be at least 1."
    Stop-AutoGoal $script:steps "max_tasks_must_be_at_least_1" $false 1
}

if ($MaxSteps -lt 1) {
    $script:steps += New-StepResult 0 "validate-input" "check MaxSteps" $fa
lse $false 1 "MaxSteps must be at least 1."
    Stop-AutoGoal $script:steps "max_steps_must_be_at_least_1" $false 1
}

$makePromptPath = Join-Path $PSScriptRoot "ai-dev-make-prompt.ps1"
$autoCycleFullPath = Join-Path $PSScriptRoot "ai-dev-auto-cycle-full.ps1"

foreach ($requiredScript in @($makePromptPath, $autoCycleFullPath)) {
    if (-not (Test-Path -LiteralPath $requiredScript -PathType Leaf)) {
        $script:steps += New-StepResult 0 "prepare" "check required scripts
" $false $false 1 "Missing required script: $requiredScript"
        Stop-AutoGoal $script:steps "prepare_failed" $false 1
    }
}

$shouldRunFullCycle = [bool]($AllowRun -or $AllowCodex -or $AllowReviewCode
x -or $AllowCommit)
$fullCycleArguments = @(Get-FullCycleArguments)
$fullCycleCommandText = "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-auto-cycle-full.ps1 $($fullCycleArguments -join ' ')".Trim()

$script:steps += New-StepResult 1 "validate-input" "check GoalTitle/GoalDes
cription" $false $false 0 "Input validation completed: $GoalTitle"

if ($DryRun) {
    $script:autoGoalPlanPreview = New-DryRunAutoGoalPlan $GoalTitle.Trim() 
$GoalDescription.Trim()
    $previewValidationErrors = @(Get-AutoGoalValidationErrors $script:autoG
oalPlanPreview)

    if ($previewValidationErrors.Count -gt 0) {
        $script:steps += New-StepResult 2 "preview-plan" "local dry-run pla
n preview" $false $false 1 "DryRun preview plan validation failed: $($previ
ewValidationErrors -join '; ')"
        Stop-AutoGoal $script:steps "dry_run_preview_invalid" $false 1
    }

    $plannedAutoGoalOutputPaths = @(Get-PlannedAutoGoalOutputPaths)
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --p
orcelain; compare baseline dirty paths with planned auto-goal outputs" $fal
se $true 0 "DryRun: baseline dirty capture, dirty worktree gate, and baseli
ne output conflict gate were not executed. Would check planned output paths
: $($plannedAutoGoalOutputPaths -join ', ')"
    $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal pl
anning prompt>" $false $true 0 "DryRun: Codex goal planning was not execute
d. Preview currentTaskId: T001, task: $GoalTitle"
    $script:steps += New-StepResult 4 "validate-generated-json" "goal/queue
/state JSON validation" $false $true 0 "DryRun: preview goal/queue/state pl
an passed local schema validation."
    $script:steps += New-StepResult 5 "write-state-files" "$goalRelativePat
h, $queueRelativePath, $stateRelativePath" $false $true 0 "DryRun: state fi
les were not written."
    $script:steps += New-StepResult 6 "make-prompt" "powershell -ExecutionP
olicy Bypass -File scripts/ai-dev-make-prompt.ps1" $false $true 0 "DryRun: 
current-task-prompt.md was not generated."

    if ($shouldRunFullCycle) {
        $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleComma
ndText $false $true 0 "DryRun: explicit run option is present, but full cyc
le was not executed. -AllowRun only invokes the full-cycle wrapper; impleme
ntation and review still require -AllowCodex and -AllowReviewCodex."
    } else {
        $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleComma
ndText $false $true 0 "DryRun: full cycle requires -AllowRun or explicit ex
ecution options. -AllowRun only invokes the full-cycle wrapper; implementat
ion and review still require -AllowCodex and -AllowReviewCodex."
    }

    Stop-AutoGoal $script:steps "dry_run" $false 0
}

$script:autoGoalBaselineStatusLines = @(Get-GitPorcelainStatusLines)
$script:autoGoalBaselineDirtyPaths = @(
    $script:autoGoalBaselineStatusLines |
        ForEach-Object { Convert-ToChangedPath $_ } |
        Where-Object { Test-HasValue $_ } |
        ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
        Select-Object -Unique
)
$plannedAutoGoalOutputPaths = @(Get-PlannedAutoGoalOutputPaths)
Invoke-BaselineOutputConflictGate $script:autoGoalBaselineDirtyPaths $plann
edAutoGoalOutputPaths

$statusLines = @($script:autoGoalBaselineStatusLines)
$baselineDirtyCount = $script:autoGoalBaselineDirtyPaths.Count

if ($statusLines.Count -gt 0 -and -not $AllowDirty) {
    $dirtyText = ($statusLines -join "`n")
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --p
orcelain" $false $true 1 "Baseline dirty count: $baselineDirtyCount`nWorktr
ee is dirty. Use -AllowDirty only when this is intentional.`n$dirtyText"
    Stop-AutoGoal $script:steps "dirty_worktree" $false 1
}

if ($statusLines.Count -gt 0) {
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --p
orcelain" $true $false 0 "AllowDirty is set. Baseline dirty count: $baselin
eDirtyCount"
} else {
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --p
orcelain" $true $false 0 "Baseline dirty count: 0. Worktree is clean."
}

$fullCycleArguments = @(Get-FullCycleArguments)
$fullCycleCommandText = "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-auto-cycle-full.ps1 $($fullCycleArguments -join ' ')".Trim()

$codexCommand = Get-Command codex -ErrorAction SilentlyContinue

if ($null -eq $codexCommand) {
    $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal pl
anning prompt>" $false $false 1 "Codex CLI was not found."
    Stop-AutoGoal $script:steps "codex_not_found" $false 1
}

$plannerPrompt = New-CodexAutoGoalPrompt $GoalTitle.Trim() $GoalDescription
.Trim()
$codexPrompt = New-CodexAutoGoalWrapperPrompt $resolvedPlanningPromptPath
$commandText = "codex exec <short wrapper pointing to $planningPromptRelati
vePath>"
[System.IO.File]::WriteAllText($resolvedPlanningPromptPath, $plannerPrompt,
 $utf8WithBom)
$startedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$codexOutput = & codex exec $codexPrompt 2>&1 | Out-String
$codexExitCode = $LASTEXITCODE
$endedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$resultContent = @"
# Codex Auto Goal Result

## Run

- Started at: $startedAt
- Ended at: $endedAt
- Exit code: $codexExitCode
- Goal title: $($GoalTitle.Trim())
- Planning prompt: $planningPromptRelativePath
- Command: $commandText

## Output

${codeFence}text
$codexOutput
$codeFence
"@

[System.IO.File]::WriteAllText($resolvedResultPath, $resultContent, $utf8Wi
thBom)

if ($codexExitCode -ne 0) {
    $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal pl
anning prompt>" $true $false 1 "Codex goal planning failed. Result: $(Conve
rtTo-RepoRelativePath $ResultPath)"
    Stop-AutoGoal $script:steps "codex_plan_failed" $false 1
}

$script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planni
ng prompt>" $true $false 0 "Codex goal planning completed. Result: $(Conver
tTo-RepoRelativePath $ResultPath)"

try {
    $autoGoalPlan = ConvertFrom-CodexAutoGoalOutput $codexOutput
} catch {
    $preview = Get-InputPreview $codexOutput
    $script:steps += New-StepResult 4 "validate-generated-json" "goal/queue
/state JSON validation" $false $false 1 "Codex plan JSON extraction failed:
 $($_.Exception.Message) Output preview: $preview"
    Stop-AutoGoal $script:steps "generated_json_invalid" $false 1
}

$script:steps += New-StepResult 4 "validate-generated-json" "goal/queue/sta
te JSON validation" $false $false 0 "goalMarkdown, queue, and state JSON va
lidation completed. currentTaskId: $($autoGoalPlan.Parsed.queue.currentTask
Id)"
$script:autoGoalPlanPreview = $autoGoalPlan.Parsed

$goalMarkdown = [string]$autoGoalPlan.Parsed.goalMarkdown
$queueJson = $autoGoalPlan.Parsed.queue | ConvertTo-Json -Depth 30
$stateJson = $autoGoalPlan.Parsed.state | ConvertTo-Json -Depth 30

[System.IO.File]::WriteAllText($resolvedGoalPath, $goalMarkdown, $utf8WithB
om)
[System.IO.File]::WriteAllText($resolvedQueuePath, $queueJson, $utf8WithBom
)
[System.IO.File]::WriteAllText($resolvedStatePath, $stateJson, $utf8WithBom
)

$script:steps += New-StepResult 5 "write-state-files" "$goalRelativePath, $
queueRelativePath, $stateRelativePath" $true $false 0 "New goal, queue, and
 state files were written."

Invoke-CycleCommand 6 "make-prompt" "powershell -ExecutionPolicy Bypass -Fi
le scripts/ai-dev-make-prompt.ps1" $makePromptPath @()

if (-not $shouldRunFullCycle) {
    $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleCommandTe
xt $false $true 0 "Full cycle requires -AllowRun or explicit execution opti
ons. -AllowRun only invokes the full-cycle wrapper; implementation and revi
ew still require -AllowCodex and -AllowReviewCodex."
    Complete-AutoGoal 8 9 10 11 "prepared_without_full_cycle"
}

Invoke-CycleCommand 7 "auto-cycle-full" $fullCycleCommandText $autoCycleFul
lPath $fullCycleArguments

try {
    $goalStatusAfterFullCycle = Get-CurrentGoalStatus
} catch {
    $script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativeP
ath goalStatus 확인" $false $false 1 $_.Exception.Message
    Stop-AutoGoal $script:steps "goal_status_verify_failed" $false 1
}

if ($goalStatusAfterFullCycle -ne "completed") {
    $script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativeP
ath goalStatus 확인" $false $true 1 "auto-cycle-full은 성공 종료했지만 goalStatus가 co
mpleted가 아닙니다: $goalStatusAfterFullCycle"
    Stop-AutoGoal $script:steps "auto_cycle_incomplete" $false 1
}

$script:steps += New-StepResult 8 "verify-goal-status" "$stateRelativePath 
goalStatus 확인" $false $false 0 "auto-cycle-full 성공 후 goalStatus completed 확
인."

Complete-AutoGoal 9 10 11 12 "completed"


codex
확인 결과 full-cycle 인자 구성은 이미 `-MaxSteps`에 현재 파라미터 값을 그대로 넣고 있어 전달 흐름은 유지되어 있습
니다. 요구사항 1에 맞춰 기본값만 `20`에서 `40`으로 바꾸겠습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\scripts\ai-dev-auto-goal.ps1
diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 3378b17b55f90e832e60e74a356e70656891b493..f788e01146290132b6f1e0245b6
eb3601d62de95
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -4,7 +4,7 @@
     [AllowEmptyString()]
     [string]$GoalDescription,
     [int]$MaxTasks = 1,
-    [int]$MaxSteps = 20,
+    [int]$MaxSteps = 40,
     [switch]$DryRun,
     [switch]$Json,
     [switch]$AllowRun,

diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 3378b17b55f90e832e60e74a356e70656891b493..f788e01146290132b6f1e0245b6
eb3601d62de95
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -4,7 +4,7 @@
     [AllowEmptyString()]
     [string]$GoalDescription,
     [int]$MaxTasks = 1,
-    [int]$MaxSteps = 20,
+    [int]$MaxSteps = 40,
     [switch]$DryRun,
     [switch]$Json,
     [switch]$AllowRun,

codex
수정은 대상 파일 한 곳에만 적용했습니다. 이제 기본값과 full-cycle 호출 인자 부분을 필요한 줄만 다시 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Select-String -LiteralPath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-a
uto-goal.ps1' -Pattern 'if \\(\\"'$AllowCodex'"\\)|if \\(\\"'$AllowReviewCo
dex'"\\)|if \\(\\"'$AllowCommit'"\\)|\\"'$arguments '"\\+= \"-AllowDirty\"'
 -Context 0,1" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Select-String -LiteralPath 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-a
uto-goal.ps1' -Pattern '\\[int\\]\\"'$MaxSteps|'"\\"'$arguments = @'"\\(\"-
MaxTasks\"' -Context 0,2" in D:\ai-apps\planpilot-local
 succeeded in 2447ms:

> scripts\ai-dev-auto-goal.ps1:1117:    if ($AllowCodex) {
  scripts\ai-dev-auto-goal.ps1:1118:        $arguments += "-AllowCodex"
> scripts\ai-dev-auto-goal.ps1:1121:    if ($AllowReviewCodex) {
  scripts\ai-dev-auto-goal.ps1:1122:        $arguments += "-AllowReviewCode
x"
> scripts\ai-dev-auto-goal.ps1:1125:    if ($AllowCommit) {
  scripts\ai-dev-auto-goal.ps1:1126:        $arguments += "-AllowCommit"
> scripts\ai-dev-auto-goal.ps1:1131:    $arguments += "-AllowDirty"
  scripts\ai-dev-auto-goal.ps1:1132:



 succeeded in 2478ms:

> scripts\ai-dev-auto-goal.ps1:7:    [int]$MaxSteps = 40,
  scripts\ai-dev-auto-goal.ps1:8:    [switch]$DryRun,
  scripts\ai-dev-auto-goal.ps1:9:    [switch]$Json,
> scripts\ai-dev-auto-goal.ps1:1115:    $arguments = @("-MaxTasks", ([strin
g]$MaxTasks), "-MaxSteps", ([string]$MaxStep
s))
  scripts\ai-dev-auto-goal.ps1:1116:
  scripts\ai-dev-auto-goal.ps1:1117:    if ($AllowCodex) {



diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 3378b17b55f90e832e60e74a356e70656891b493..f788e01146290132b6f1e0245b6
eb3601d62de95
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -4,7 +4,7 @@
     [AllowEmptyString()]
     [string]$GoalDescription,
     [int]$MaxTasks = 1,
-    [int]$MaxSteps = 20,
+    [int]$MaxSteps = 40,
     [switch]$DryRun,
     [switch]$Json,
     [switch]$AllowRun,

codex
수정 완료했습니다.

변경 파일: [scripts/ai-dev-auto-goal.ps1](D:/ai-apps/planpilot-local/scripts/ai
-dev-auto-goal.ps1:7)

적용 내용:
- `MaxSteps` 기본값을 `20`에서 `40`으로 변경했습니다.
- 기존 full-cycle 호출부는 이미 `"-MaxSteps", ([string]$MaxSteps)` 형태로 전달하고 있어, 사용자
가 `-MaxSteps`를 직접 지정하면 그대로 `ai-dev-auto-cycle-full.ps1`에 전달됩니다.
- `AllowCodex`, `AllowReviewCodex`, `AllowCommit`, `AllowDirty`, `MaxTasks`
 전달 흐름은 유지했습니다.

검증:
- 대상 파일에서 `MaxSteps = 40` 및 full-cycle 인자 전달부를 재확인했습니다.
- 규칙에 따라 `npm run build`, `npm run lint`, `npm run test`, `git` 명령은 실행하지 않았
습니다.
diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 3378b17b55f90e832e60e74a356e70656891b493..f788e01146290132b6f1e0245b6
eb3601d62de95
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -4,7 +4,7 @@
     [AllowEmptyString()]
     [string]$GoalDescription,
     [int]$MaxTasks = 1,
-    [int]$MaxSteps = 20,
+    [int]$MaxSteps = 40,
     [switch]$DryRun,
     [switch]$Json,
     [switch]$AllowRun,

tokens used
16,225
수정 완료했습니다.

변경 파일: [scripts/ai-dev-auto-goal.ps1](D:/ai-apps/planpilot-local/scripts/ai-dev-auto-goal.ps1:7)

적용 내용:
- `MaxSteps` 기본값을 `20`에서 `40`으로 변경했습니다.
- 기존 full-cycle 호출부는 이미 `"-MaxSteps", ([string]$MaxSteps)` 형태로 전달하고 있어, 사용자가 `-MaxSteps`를 직접 지정하면 그대로 `ai-dev-auto-cycle-full.ps1`에 전달됩니다.
- `AllowCodex`, `AllowReviewCodex`, `AllowCommit`, `AllowDirty`, `MaxTasks` 전달 흐름은 유지했습니다.

검증:
- 대상 파일에서 `MaxSteps = 40` 및 full-cycle 인자 전달부를 재확인했습니다.
- 규칙에 따라 `npm run build`, `npm run lint`, `npm run test`, `git` 명령은 실행하지 않았습니다.

```