# AI Dev Revise Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.
이전 리뷰에서 지적된 사항만 수정한다.

## Goal

# 목표

Copilot CLI 또는 gh 연동 재검토 항목을 현재 로컬 앱 구조에서 바로 실행 가능한 최소 개발 목표로 정리한다.

## 배경

PlanPilot Local은 privacy-first 로컬 웹앱이며, 외부 연동은 사용자의 명시적 의도와 로컬 동작 범위를 기준으로 신중하게 판단해야 한다. 이번 목표는 Copilot CLI 또는 gh 연동을 실제 구현하기 전에 현재 프로젝트에 필요한지, 어떤 사용자 흐름에서 의미가 있는지, MVP 범위에 맞는 최소 검토 결과를 남기는 것이다.

## 성공 기준

- 현재 앱 제약사항에 맞춰 Copilot CLI 또는 gh 연동의 필요성과 제외 조건을 정리한다.
- 구현 여부를 판단할 수 있는 최소 기준을 문서화한다.
- 당장 코드 변경 없이도 다음 작업자가 이어받을 수 있는 짧은 결론을 남긴다.

## 제약사항

- 로컬 우선 동작과 개인정보 보호 방향을 유지한다.
- 사용자-facing 문구는 한국어를 기본으로 한다.
- 현재 MVP 범위를 넘는 기능 확장은 포함하지 않는다.
- 기존 앱 구조를 크게 바꾸지 않는다.

## 범위 제외

- 실제 연동 기능 구현
- 인증 흐름 추가
- 원격 저장소 조작 자동화
- 대규모 설정 화면 재구성

## 수동 검증

- 작성된 검토 결과가 현재 앱 제약사항과 충돌하지 않는지 확인한다.
- 다음 구현 후보가 하나의 작고 명확한 작업으로 분리되어 있는지 확인한다.

## 연동 필요성 검토

현재 MVP에서는 Copilot CLI 또는 gh 연동을 바로 구현하지 않는다. PlanPilot Local의 핵심 가치는 사용자의 일정, 업무, 프로젝트 정보를 외부 서버로 보내지 않고 로컬에서 관리하는 것이며, Copilot CLI나 gh 연동은 인증, 외부 프로세스 실행, 원격 저장소 상태 확인 같은 별도 위험과 복잡도를 만든다.

연동이 의미 있으려면 사용자가 명시적으로 "현재 계획을 개발 작업으로 넘기기"를 원하고, 전송되는 내용과 실행되는 명령을 작업 직전에 확인할 수 있어야 한다. 단순한 일정 관리, 프로젝트 메모, 로컬 업무 정리 흐름에는 외부 개발 도구 연동이 필수 기능이 아니다.

## 구현 판단 기준

- 사용자가 특정 업무를 GitHub issue, PR, 로컬 CLI 작업으로 연결하려는 반복 흐름이 확인된다.
- 전송 대상 데이터가 제목, 설명, 체크리스트 등 사용자가 선택한 최소 항목으로 제한된다.
- 인증 토큰, 계정 정보, 원격 저장소 정보는 앱이 저장하지 않거나, 저장이 필요하면 별도 보안 검토를 먼저 한다.
- 연동 실행 전 사용자에게 실행 대상, 명령 또는 전송 내용을 한국어로 명확히 보여준다.
- 실패해도 기존 로컬 데이터와 IndexedDB 저장 상태에 영향을 주지 않는다.

## 제외 조건

- 자동 git 조작, 자동 push, 자동 PR 생성처럼 원격 저장소를 사용자의 즉시 확인 없이 변경하는 기능은 제외한다.
- 로그인, 계정 연결, 토큰 저장, 클라우드 동기화가 필요한 흐름은 현재 MVP에서 제외한다.
- 알림, 백그라운드 실행, Android 권한 요청, Capacitor 추가가 필요한 흐름은 제외한다.
- 앱 내부 데이터를 외부 서비스에 일괄 전송하는 기능은 제외한다.

## 결론

Copilot CLI 또는 gh 연동은 현재 로컬 우선 MVP의 필수 기능이 아니다. 다음 단계로 구현을 검토한다면 "선택한 업무 1개를 사용자가 복사해 외부 CLI에 붙여넣을 수 있는 한국어 작업 요약 생성" 정도가 가장 작은 후보 작업이다. 이 후보는 인증, 원격 조작, 패키지 추가 없이 로컬 앱 내부의 표시 기능으로 분리할 수 있다.

## 다음 후보 작업

- 선택한 업무 1개를 개발 작업 요약 텍스트로 변환하는 UI 문구와 데이터 범위를 먼저 정의한다.


## Current Task

- Task ID: T001
- Title: 연동 필요성 검토 문서 작성
- Description: Copilot CLI 또는 gh 연동이 현재 PlanPilot Local의 로컬 우선 방향과 MVP 범위에 맞는지 검토하고, 구현 전 판단 기준을 짧은 문서로 정리한다.
- Type: documentation
- Status: in_progress
- Priority: P2
- Verification:
- 문서에 목표, 배경, 성공 기준, 제약사항, 범위 제외, 수동 검증 섹션이 포함되어 있는지 확인한다.
- 연동 구현을 바로 시작하지 않고 검토 결론과 다음 후보 작업만 남겼는지 확인한다.

## Review Result

- Decision: revise
- Severity: high
- Next step: revise_with_codex
- Summary: 문서 task인데 scripts/ai-dev-auto-cycle-full.ps1 자동화 로직이 함께 변경되어 현재 task 범위를 벗어났고, 문서 산출물도 
요구된 일부 섹션명을 그대로 충족하지 않습니다.

## Required Changes

- File: scripts/ai-dev-auto-cycle-full.ps1
  - Reason: 현재 task는 Copilot CLI 또는 gh 연동 필요성 검토 문서 작성인데, 자동화 루프의 review gate 로직이 116줄 추가되어 task
 범위를 벗어났습니다.
  - Suggestion: 이번 task에서는 해당 스크립트 변경을 제외하고, documentation revise 처리 개선은 별도 task로 분리하십시오.
- File: .ai-dev/copilot-cli-gh-integration-review.md
  - Reason: 검증 기준은 문서에 목표, 배경, 성공 기준, 제약사항, 범위 제외, 수동 검증 섹션 포함을 요구하지만 현재 문서에는 '성공 기준' 섹션이 없고 '제약
사항', '범위 제외'가 정확한 섹션명으로 정리되어 있지 않습니다.
  - Suggestion: 문서에 '성공 기준', '제약사항', '범위 제외' 섹션을 명시적으로 추가하거나 기존 내용을 해당 섹션명으로 재구성하십시오.

## Optional Suggestions

- optional_suggestions는 참고만 하며 구현하지 않는다.
- File: .ai-dev/copilot-cli-gh-integration-review.md
  - Suggestion: 후속 후보 작업이 여러 개로 넓게 나열되어 있으므로, 현재 Project Goal의 결론처럼 가장 작은 다음 후보 1개를 우선 항목으로 분리하면
 다음 작업자가 이어받기 쉽습니다.

## Diff Context

# AI Dev Diff

## Generated At

2026-07-18 19:33:52

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/codex-review-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/diff.md
 M .ai-dev/goal.md
 M .ai-dev/loop-log.md
 M .ai-dev/queue.json
 M .ai-dev/review-prompt.md
 M .ai-dev/review-response.json
 M .ai-dev/review.md
 M .ai-dev/revise-prompt.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-auto-cycle-full.ps1
?? .ai-dev/copilot-cli-gh-integration-review.md
?? .ai-dev/copilot-gh-documentation-revise-prompt.md
?? .ai-dev/documentation-revise-auto-cycle-fix-prompt.md
```

## App Change Files

- scripts/ai-dev-auto-cycle-full.ps1

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/codex-review-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/diff.md
- .ai-dev/goal.md
- .ai-dev/loop-log.md
- .ai-dev/queue.json
- .ai-dev/review-prompt.md
- .ai-dev/review-response.json
- .ai-dev/review.md
- .ai-dev/revise-prompt.md
- .ai-dev/state.json
- .ai-dev/test-result.md
- .ai-dev/copilot-cli-gh-integration-review.md
- .ai-dev/copilot-gh-documentation-revise-prompt.md
- .ai-dev/documentation-revise-auto-cycle-fix-prompt.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-auto-cycle-full.ps1 | 118 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 2 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 350b1b2..ec76202 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -603,6 +603,89 @@ function Get-ChangedNonAiDevFiles {
     )
 }
 
+function Get-ChangedFiles {
+    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
+    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
+
+    return @(
+        $changeLines |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+            Where-Object { (Test-HasValue $_) -and -not (Test-IsProtectedBaselineDirtyPath $_) } |
+            Select-Object -Unique
+    )
+}
+
+function Test-IsDocumentationArtifactPath {
+    param(
+        [string]$RelativePath
+    )
+
+    $normalizedRelativePath = ConvertTo-NormalizedChangedPath $RelativePath
+
+    if (-not (Test-HasValue $normalizedRelativePath)) {
+        return $false
+    }
+
+    return (
+        $normalizedRelativePath.EndsWith(".md", [System.StringComparison]::OrdinalIgnoreCase) -and
+        (
+            $normalizedRelativePath.StartsWith(".ai-dev/", [System.StringComparison]::OrdinalIgnoreCase) -or
+            $normalizedRelativePath.StartsWith("docs/", [System.StringComparison]::OrdinalIgnoreCase)
+        )
+    )
+}
+
+function Test-IsAppSourcePath {
+    param(
+        [string]$RelativePath
+    )
+
+    $normalizedRelativePath = ConvertTo-NormalizedChangedPath $RelativePath
+
+    if (-not (Test-HasValue $normalizedRelativePath)) {
+        return $false
+    }
+
+    return $normalizedRelativePath.StartsWith("src/", [System.StringComparison]::OrdinalIgnoreCase)
+}
+
+function Get-DocumentationTaskLikelyFiles {
+    param(
+        [object]$Task
+    )
+
+    if ($null -eq $Task -or -not ($Task.PSObject.Properties.Name -contains "likelyFiles")) {
+        return @()
+    }
+
+    return @(
+        @($Task.likelyFiles) |
+            Where-Object { Test-HasValue $_ } |
+            ForEach-Object { ConvertTo-NormalizedChangedPath ([string]$_) } |
+            Where-Object { Test-HasValue $_ } |
+            Select-Object -Unique
+    )
+}
+
+function Get-RawRequiredReviewChangeFiles {
+    param(
+        [object]$ReviewResponse
+    )
+
+    if ($null -eq $ReviewResponse -or -not ($ReviewResponse.PSObject.Properties.Name -contains "required_changes")) {
+        return @()
+    }
+
+    return @(
+        @($ReviewResponse.required_changes) |
+            Where-Object { $null -ne $_ -and ($_.PSObject.Properties.Name -contains "file") -and (Test-HasValue $_.file) } |
+            ForEach-Object { ConvertTo-NormalizedChangedPath ([string]$_.file) } |
+            Where-Object { (Test-HasValue $_) -and $_ -ne "unknown" -and -not (Test-IsProtectedBaselineDirtyPath $_) } |
+            Select-Object -Unique
+    )
+}
+
 function Get-RequiredReviewChangeFiles {
     param(
         [object]$ReviewResponse
@@ -644,18 +727,44 @@ function Get-ReviewImplementationGate {
 
     $taskType = if ($null -ne $CurrentTask -and (Test-HasValue $CurrentTask.type)) { [string]$CurrentTask.type } else { "" }
     $requiredFiles = @($ReviewGate.requiredChangeFiles)
+    $rawRequiredFiles = @($ReviewGate.rawRequiredChangeFiles)
+    $likelyFiles = @(Get-DocumentationTaskLikelyFiles $CurrentTask)
+    $allChangedFiles = @(Get-ChangedFiles)
     $changedFiles = @(Get-ChangedNonAiDevFiles)
     $isVerificationReviseWithCodex = $taskType -eq "verification" -and $ReviewGate.decision -eq "revise" -and $ReviewGate.normalizedNextStep -eq "revise_with_codex"
+    $isDocumentationReviseWithCodex = $taskType -eq "documentation" -and $ReviewGate.decision -eq "revise" -and $ReviewGate.normalizedNextStep -eq "revise_with_codex"
+    $documentationRequiredFiles = @($rawRequiredFiles | Where-Object { Test-IsDocumentationArtifactPath $_ })
+    $documentationLikelyFiles = @($likelyFiles | Where-Object { Test-IsDocumentationArtifactPath $_ })
+    $documentationChangedFiles = @($allChangedFiles | Where-Object { Test-IsDocumentationArtifactPath $_ })
+    $changedAppSourceFiles = @($allChangedFiles | Where-Object { Test-IsAppSourcePath $_ })
     $missingRequiredFiles = @(
         $requiredFiles |
             Where-Object { -not (Test-ReviewRequiredFileIsChanged $_ $changedFiles) }
     )
 
+    if ($isDocumentationReviseWithCodex) {
+        if ($changedAppSourceFiles.Count -gt 0) {
+            return [PSCustomObject][ordered]@{
+                passed = $false
+                reason = "documentation_revise_src_changed"
+                message = "documentation task의 revise + revise_with_codex 중 앱 src 변경이 감지되어 scope 문제로 중단합니다. changedAppSourceFiles=$($changedAppSourceFiles -join ', '), rawRequiredFiles=$($rawRequiredFiles -join ', '), likelyFiles=$($likelyFiles -join ', '), changedFiles=$($allChangedFiles -join ', ')"
+            }
+        }
+
+        if ($documentationRequiredFiles.Count -gt 0 -or $documentationLikelyFiles.Count -gt 0 -or $documentationChangedFiles.Count -gt 0) {
+            return [PSCustomObject][ordered]@{
+                passed = $true
+                reason = "documentation_revise_with_codex"
+                message = "documentation task의 revise + revise_with_codex는 문서 산출물 보강 흐름으로 허용합니다. documentationRequiredFiles=$($documentationRequiredFiles -join ', '), documentationLikelyFiles=$($documentationLikelyFiles -join ', '), documentationChangedFiles=$($documentationChangedFiles -join ', ')"
+            }
+        }
+    }
+
     if ($ReviewGate.decision -eq "revise" -and $taskType -ne "implementation" -and -not $isVerificationReviseWithCodex) {
         return [PSCustomObject][ordered]@{
             passed = $false
             reason = "non_implementation_revise"
-            message = "현재 task type이 implementation이 아닌데 review decision=revise입니다. 구현 없는 revise 반복을 성공 처리하지 않도록 중단합니다. taskType='$taskType', requiredFiles=$($requiredFiles -join ', '), changedFiles=$($changedFiles -join ', ')"
+            message = "현재 task type이 implementation이 아닌데 review decision=revise입니다. 구현 없는 revise 반복을 성공 처리하지 않도록 중단합니다. taskType='$taskType', rawRequiredFiles=$($rawRequiredFiles -join ', '), requiredFiles=$($requiredFiles -join ', '), likelyFiles=$($likelyFiles -join ', '), changedFiles=$($allChangedFiles -join ', ')"
         }
     }
 
@@ -751,6 +860,7 @@ function Get-ReviewGate {
         nextStep = $nextStep
         normalizedNextStep = $normalizedNextStep
         requiredChanges = @($requiredChanges)
+        rawRequiredChangeFiles = @(Get-RawRequiredReviewChangeFiles $reviewResponse)
         requiredChangeFiles = @(Get-RequiredReviewChangeFiles $reviewResponse)
     }
 }
@@ -1311,7 +1421,11 @@ while ($script:completedTaskCount -lt $MaxTasks) {
 
     $commitArguments = Get-CommitArguments
     $commitHashForComplete = $null
-    $resultSummary = "자동 완료: Codex 구현, build/check, Codex 리뷰 pass"
+    $resultSummary = if ($script:currentTask.type -eq "documentation") {
+        "자동 완료: Codex 문서 산출물 수정, build/check, Codex 리뷰 pass"
+    } else {
+        "자동 완료: Codex 구현, build/check, Codex 리뷰 pass"
+    }
 
     if ($commitArguments.Count -eq 0) {
         $script:steps += New-StepResult $stepNumber "commit" "git status --porcelain" $false $true 0 "커밋할 구현 변경사항이 없습니다. 저장된 리뷰 pass 상태를 유지하고 complete-task/meta-commit으로 계속 진행합니다."
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```

## Untracked File Content

내용을 포함할 추적되지 않은 텍스트 파일이 없습니다.

## Skipped Generated AI Dev Artifacts

- .ai-dev/copilot-cli-gh-integration-review.md
- .ai-dev/copilot-gh-documentation-revise-prompt.md
- .ai-dev/documentation-revise-auto-cycle-fix-prompt.md

## Test Result

# AI Dev Test Result

## 2026-07-18 19:33:43

- Overall result: passed
- Current task: T001
- Mode: BuildOnly (build + lint when available)
- Commands:
  - npm run build: passed
  - npm run test: skipped
  - npm run lint: passed

### npm run build

- Status: passed
- Exit code: 0

```text

> planpilot-local@0.0.0 build
> tsc -b && vite build

[36mvite v8.0.10 [32mbuilding client environment for production...[36m[39m
[2K
transforming...✓ 48 modules transformed.
rendering chunks...
computing gzip size...
dist/index.html                   0.46 kB │ gzip:   0.29 kB
dist/assets/index-DvjxWt30.css    5.69 kB │ gzip:   1.93 kB
dist/assets/index-DtLVvPCG.js   317.50 kB │ gzip: 100.16 kB

[32m✓ built in 197ms[39m
```
### npm run test

- Status: skipped
- Exit code: 없음

```text
package.json에 test script가 없습니다.
```
### npm run lint

- Status: passed
- Exit code: 0

```text

> planpilot-local@0.0.0 lint
> eslint .
```

## Allowed Scope

- required_changes에 필요한 최소 수정만 허용한다.
- 현재 task 범위를 벗어나지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 새 기능 추가보다 리뷰 지적사항 해결을 우선한다.

## Hard Rules

- `package.json`과 `package-lock.json`은 수정하지 않는다. 꼭 필요하면 중단하고 이유만 기록한다.
- 실제 DB 삭제 또는 초기화를 하지 않는다.
- 사용자 데이터 복원 또는 덮어쓰기를 하지 않는다.
- 대규모 리팩터링을 하지 않는다.
- git commit을 실행하지 않는다.
- git reset, git checkout, git clean을 실행하지 않는다.
- npm install을 실행하지 않는다.
- optional_suggestions는 기본적으로 구현하지 않는다.

## Required Output

- 반영한 required_changes 목록
- 수정한 파일 목록
- 검증 방법
- 반영하지 못한 항목과 이유
- 남은 위험
- `.ai-dev/loop-log.md`에 기록할 재수정 요약