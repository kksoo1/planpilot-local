$ProjectPath = "D:\ai-apps\planpilot-local"
$StatePath = Join-Path $ProjectPath "automation-state.json"
$LogDir = Join-Path $ProjectPath "automation-logs"

Set-Location $ProjectPath

if (!(Test-Path $LogDir)) {
  New-Item -ItemType Directory -Path $LogDir | Out-Null
}

$Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$LogFile = Join-Path $LogDir "monitor-$Timestamp.log"

function Write-Log {
  param([string]$Message)

  $line = "[$(Get-Date -Format o)] $Message"
  $line | Tee-Object -FilePath $LogFile -Append
}

function Load-State {
  if (!(Test-Path $StatePath)) {
    throw "automation-state.json 파일이 없습니다."
  }

  return Get-Content $StatePath -Raw | ConvertFrom-Json
}

function Save-State {
  param($State)

  $State | ConvertTo-Json -Depth 20 | Set-Content -Encoding UTF8 $StatePath
}

function Test-LimitText {
  param([string]$Text)

  return $Text -match "usage limit|credit limit|rate limit|quota|try again|upgrade|purchase credits|limit reset|You've hit your usage limit|out of credits|not enough credits|baseline quota|AI credits|사용량 한도|크레딧|한도|다시 시도"
}

function Parse-NextTryTime {
  param(
    [string]$Text,
    [int]$DefaultMinutes
  )

  return (Get-Date).AddMinutes($DefaultMinutes)
}

function Is-NextProbeInFuture {
  param($Provider)

  if ($null -eq $Provider.nextProbeAt -or $Provider.nextProbeAt -eq "") {
    return $false
  }

  $next = [DateTime]::Parse($Provider.nextProbeAt)
  return (Get-Date) -lt $next
}

function Set-ProviderUnavailable {
  param(
    $State,
    [string]$ProviderName,
    [string]$Message,
    [int]$CooldownMinutes
  )

  $provider = $State.providers.$ProviderName
  $next = Parse-NextTryTime $Message $CooldownMinutes

  $provider.available = $false
  $provider.lastProbeAt = (Get-Date).ToString("o")
  $provider.lastLimitAt = (Get-Date).ToString("o")
  $provider.nextProbeAt = $next.ToString("o")
  $provider.lastLimitMessage = $Message

  Save-State $State
}

function Set-ProviderAvailable {
  param(
    $State,
    [string]$ProviderName
  )

  $provider = $State.providers.$ProviderName

  $provider.available = $true
  $provider.lastProbeAt = (Get-Date).ToString("o")
  $provider.lastSuccessAt = (Get-Date).ToString("o")
  $provider.nextProbeAt = $null
  $provider.lastLimitMessage = $null

  Save-State $State
}

function Test-CodexAvailable {
  Write-Log "Codex probe 시작"

  $output = codex exec --sandbox read-only "파일을 수정하지 말고 OK만 출력해줘." 2>&1
  $text = $output | Out-String

  Write-Log "Codex probe 출력:"
  Write-Log $text

  if (Test-LimitText $text) {
    return @{
      Available = $false
      Message = $text
    }
  }

  if ($LASTEXITCODE -ne 0) {
    return @{
      Available = $false
      Message = $text
    }
  }

  return @{
    Available = $true
    Message = $text
  }
}

function Test-AntigravityCliCommand {
  $candidates = @("agy", "antigravity", "ag", "antigravity-cli")

  foreach ($candidate in $candidates) {
    $found = $null

    try {
      $found = where.exe $candidate 2>$null
    } catch {}

    if ($found) {
      return @{
        Found = $true
        Command = $candidate
        Path = ($found | Select-Object -First 1)
      }
    }
  }

  return @{
    Found = $false
    Command = $null
    Path = $null
  }
}

function Test-AntigravityAvailable {
  Write-Log "Antigravity probe 시작"

  $cli = Test-AntigravityCliCommand

  if (!$cli.Found) {
    $message = "Antigravity CLI 명령을 찾지 못했습니다. Desktop UI만 있는 상태일 수 있습니다."
    Write-Log $message

    return @{
      Available = $false
      Message = $message
      Command = $null
    }
  }

  $message = "Antigravity CLI 후보 발견: $($cli.Command), path: $($cli.Path)"
  Write-Log $message

  return @{
    Available = $true
    Message = $message
    Command = $cli.Command
  }
}

function Invoke-CodexDevLoop {
  Write-Log "Codex 자동 개발 루프 시작"

  $prompt = @"
AGENTS.md, ROADMAP.md, automation-state.json을 기준으로 자동 개발 루프를 진행해줘.

목표:
PlanPilot Local을 ROADMAP.md의 완성 기준까지 개발한다.

현재 브랜치는 auto/dev-loop이어야 한다.
master 브랜치에서 작업 중이면 중단해라.

진행 규칙:
- 최대 3개 작업만 수행한다.
- 코드 변경 작업은 최대 2개까지만 수행한다.
- 작업마다 reviewer를 실행하지 않는다.
- 모든 수정이 끝난 뒤 전체 diff 기준으로 reviewer 1회만 실행한다.
- npm run build는 최종 변경 후 실행한다.
- build 실패 시 한 번만 수정 재시도한다.
- 최종 build가 성공하고 review에 P1 문제가 없으면 commit한다.
- commit 후 origin auto/dev-loop로 push한다.
- master로 push하지 마라.

허용:
- 프로젝트 내부 파일 읽기
- 필요한 파일 수정
- npm run build
- git status
- git diff
- git diff --staged
- 수정한 파일만 git add
- git commit
- git push origin auto/dev-loop

금지:
- git add .
- git push origin master
- git reset
- git restore
- git checkout master
- git clean
- git rebase
- git merge
- npm install
- npm run dev
- npm run preview
- open dist/index.html
- 브라우저 자동 실행
- App.css 수정
- package-lock.json 수정
- DB schema 변경
- 서버 API 추가
- localStorage 사용
- 로그인/클라우드 동기화/알림/Capacitor 추가

한도/크레딧 관련:
- Codex usage limit, quota limit, credit limit, rate limit 메시지가 나오면 즉시 중단한다.
- 중단 전 automation-state.json에 현재 상태와 다음 재시작 때 이어갈 작업을 기록한다.
- 한도 문제가 있으면 파일을 더 수정하지 말고 종료한다.

최종 보고:
1. 완료 작업
2. 수정 파일
3. build 결과
4. review 결과
5. commit hash
6. push 결과
7. 중단 이유
8. 다음 실행 때 이어갈 작업
"@

  $output = codex exec --sandbox workspace-write $prompt 2>&1
  $text = $output | Out-String

  Write-Log "Codex 자동 개발 루프 출력:"
  Write-Log $text

  return @{
    ExitCode = $LASTEXITCODE
    Text = $text
  }
}

Write-Log "수시 감시 루프 시작"

$state = Load-State
$state.lastMonitorAt = (Get-Date).ToString("o")
Save-State $state

$branch = git branch --show-current
Write-Log "현재 브랜치: $branch"

if ($branch -ne "auto/dev-loop") {
  Write-Log "현재 브랜치가 auto/dev-loop가 아니므로 중단합니다."
  $state.stopReason = "Not on auto/dev-loop branch"
  Save-State $state
  exit 1
}

$status = git status --short
Write-Log "git status --short:"
Write-Log ($status | Out-String)

if ($status) {
  Write-Log "작업 트리가 깨끗하지 않습니다. 자동 개발을 시작하지 않습니다."
  $state.stopReason = "Working tree is not clean"
  Save-State $state
  exit 0
}

if ($state.providers.codex.enabled) {
  if (Is-NextProbeInFuture $state.providers.codex) {
    Write-Log "Codex는 nextProbeAt 이전이므로 이번 주기에서는 probe 생략"
  } else {
    $codexProbe = Test-CodexAvailable

    if ($codexProbe.Available) {
      Set-ProviderAvailable $state "codex"
      Write-Log "Codex 사용 가능"
    } else {
      Set-ProviderUnavailable $state "codex" $codexProbe.Message ([int]$state.policy.limitCooldownMinutes)
      Write-Log "Codex 사용 불가. cooldown 설정"
    }
  }
}

if ($state.providers.antigravity.enabled) {
  if (Is-NextProbeInFuture $state.providers.antigravity) {
    Write-Log "Antigravity는 nextProbeAt 이전이므로 이번 주기에서는 probe 생략"
  } else {
    $agProbe = Test-AntigravityAvailable

    if ($agProbe.Available) {
      Set-ProviderAvailable $state "antigravity"
      $state.providers.antigravity.cliCommand = $agProbe.Command
      Save-State $state
      Write-Log "Antigravity 사용 가능"
    } else {
      Set-ProviderUnavailable $state "antigravity" $agProbe.Message ([int]$state.policy.antigravityCooldownMinutes)
      Write-Log "Antigravity 사용 불가. cooldown 설정"
    }
  }
}

$state = Load-State

$codexReady = $state.providers.codex.available -eq $true
$antigravityReady = $state.providers.antigravity.available -eq $true

Write-Log "Codex ready: $codexReady"
Write-Log "Antigravity ready: $antigravityReady"

if ($state.policy.requireBothProviders -eq $true) {
  if (!($codexReady -and $antigravityReady)) {
    Write-Log "정책상 Codex와 Antigravity가 둘 다 사용 가능해야 하므로 개발 루프를 시작하지 않습니다."
    $state.stopReason = "Waiting for both Codex and Antigravity"
    Save-State $state
    exit 0
  }
}

Write-Log "두 provider가 모두 사용 가능하므로 자동 개발 루프를 시작합니다."

$run = Invoke-CodexDevLoop

if (Test-LimitText $run.Text) {
  Set-ProviderUnavailable $state "codex" $run.Text ([int]$state.policy.limitCooldownMinutes)
  Write-Log "개발 루프 중 Codex 한도 감지. 상태 저장 후 종료."
  exit 0
}

if ($run.ExitCode -eq 0) {
  $state = Load-State
  $state.lastRunAt = (Get-Date).ToString("o")
  $state.lastDevLoopAt = (Get-Date).ToString("o")
  $state.lastCompletedTask = "Auto dev loop completed"
  $state.stopReason = $null
  Save-State $state
  Write-Log "자동 개발 루프 완료"
  exit 0
}

$state = Load-State
$state.stopReason = "Auto dev loop failed"
Save-State $state

Write-Log "자동 개발 루프 실패"
exit 1

