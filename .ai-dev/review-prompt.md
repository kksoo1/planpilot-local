# AI Dev Review Prompt

## Role

너는 이 저장소의 엄격한 코드 리뷰어다.

## Review Goal

- 현재 task의 변경사항이 목표와 일치하는지 검토한다.
- 빌드/테스트 결과와 git diff를 함께 검토한다.
- 리뷰 판단은 App Change Files와 diff 본문의 실제 앱 변경 파일을 중심으로 수행한다.
- .ai-dev 파일은 자동화 상태/로그/프롬프트 산출물로 별도 확인하되, 앱 변경 결함으로 과대평가하지 않는다.
- 다음 task 범위까지 미리 구현했는지 확인한다.

## Project Goal

# 목표

Verification task revise 자동 처리 문제를 수정한다.

## 배경

auto-cycle-full이 verification task에서 review decision=revise, next_step=revise_with_codex를 받는 경우, 실제로는 Codex 수정 루프로 이어져야 하지만 현재 non_implementation_revise로 중단되는 문제가 있다.

## 성공 기준

- verification task에서 revise_with_codex가 반환되어도 자동 수정 흐름이 중단되지 않는다.
- implementation task가 아닌 verification task에서도 의도된 수정 경로가 선택된다.
- 기존 중단 조건은 필요한 경우에만 유지된다.
- 변경 범위는 자동 루프의 분기 처리에 한정된다.

## 제약사항

- 기존 작업 큐와 상태 파일 형식을 유지한다.
- 현재 자동 루프의 기존 decision 및 next_step 의미를 보존한다.
- 불필요한 구조 변경은 하지 않는다.
- 한 번에 하나의 작은 수정으로 처리한다.

## 범위 제외

- 자동 루프 전체 구조 재설계
- 새로운 작업 유형 추가
- UI 변경
- 저장소 구조 변경

## 수동 검증

- verification task에서 review decision=revise, next_step=revise_with_codex가 발생하는 흐름을 재현한다.
- 해당 흐름이 non_implementation_revise로 중단되지 않는지 확인한다.
- 정상적인 중단 조건이 기존처럼 동작하는지 확인한다.

## Current Task

- Task ID: T001
- Title: verification revise 분기 수정
- Description: auto-cycle-full에서 verification task가 revise_with_codex를 받은 경우 non_implementation_revise로 중단하지 않고 수정 루프로 이어지도록 분기 조건을 조정한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- verification task에서 revise_with_codex 응답 시 중단 사유가 non_implementation_revise로 설정되지 않는지 확인한다.
- 기존 구현 작업의 revise 흐름이 유지되는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-17 19:28:24

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

[32m✓ built in 206ms[39m
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

## Diff To Review

# AI Dev Diff

## Generated At

2026-07-17 19:28:31

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/codex-review-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/diff.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/review-prompt.md
 M .ai-dev/review-response.json
 M .ai-dev/review.md
 M .ai-dev/revise-prompt.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-auto-cycle-full.ps1
?? .ai-dev/verification-review-gate-fix-prompt.md
```

## App Change Files

- scripts/ai-dev-auto-cycle-full.ps1

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/codex-review-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/diff.md
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/review-prompt.md
- .ai-dev/review-response.json
- .ai-dev/review.md
- .ai-dev/revise-prompt.md
- .ai-dev/state.json
- .ai-dev/test-result.md
- .ai-dev/verification-review-gate-fix-prompt.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-auto-cycle-full.ps1 | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 53eba04..2e8c83a 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -496,12 +496,13 @@ function Get-ReviewImplementationGate {
     $taskType = if ($null -ne $CurrentTask -and (Test-HasValue $CurrentTask.type)) { [string]$CurrentTask.type } else { "" }
     $requiredFiles = @($ReviewGate.requiredChangeFiles)
     $changedFiles = @(Get-ChangedNonAiDevFiles)
+    $isVerificationReviseWithCodex = $taskType -eq "verification" -and $ReviewGate.decision -eq "revise" -and $ReviewGate.normalizedNextStep -eq "revise_with_codex"
     $missingRequiredFiles = @(
         $requiredFiles |
             Where-Object { -not (Test-ReviewRequiredFileIsChanged $_ $changedFiles) }
     )
 
-    if ($ReviewGate.decision -eq "revise" -and $taskType -ne "implementation") {
+    if ($ReviewGate.decision -eq "revise" -and $taskType -ne "implementation" -and -not $isVerificationReviseWithCodex) {
         return [PSCustomObject][ordered]@{
             passed = $false
             reason = "non_implementation_revise"
@@ -509,6 +510,14 @@ function Get-ReviewImplementationGate {
         }
     }
 
+    if ($isVerificationReviseWithCodex) {
+        return [PSCustomObject][ordered]@{
+            passed = $true
+            reason = "verification_revise_with_codex"
+            message = "verification task의 revise + revise_with_codex는 구현 파일 변경이 없는 검증 산출물 보강 흐름일 수 있으므로 implementation 전용 required files 검사를 건너뜁니다. requiredFiles=$($requiredFiles -join ', '), changedFiles=$($changedFiles -join ', ')"
+        }
+    }
+
     if ($requiredFiles.Count -gt 0 -and $changedFiles.Count -eq 0) {
         return [PSCustomObject][ordered]@{
             passed = $false
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```

## Review Criteria

- 현재 task 요구사항을 충족했는가
- 실제 앱 변경 파일과 .ai-dev 운영 산출물이 구분되어 있는가
- .ai-dev 운영 산출물만 변경된 경우 앱 변경 리뷰로 과대평가하지 않았는가
- 현재 task 범위를 벗어나지 않았는가
- 다음 task를 미리 구현하지 않았는가
- 기존 기능을 깨뜨릴 가능성이 있는가
- 데이터 삭제, 초기화, 복원 같은 위험 작업이 포함되었는가
- package.json 또는 package-lock.json을 불필요하게 수정했는가
- 검증 결과가 충분한가
- 문서나 수동검증 체크리스트 갱신이 필요한가
- 더 단순한 구현이 가능한가

### Strict Criteria

- 작은 불확실성도 revise로 판정한다.
- 테스트가 없거나 skipped이면 revise 후보로 본다.
- task 범위를 벗어난 파일 수정은 high 이상으로 판정한다.
- package 변경은 기본적으로 blocked 후보로 본다.

## Output Format

리뷰 결과는 아래 JSON 형식만 출력한다. JSON 앞뒤에 설명, Markdown 코드 펜스, 추가 문장을 출력하지 않는다.

{
  "decision": "pass | revise | blocked",
  "severity": "none | low | medium | high | critical",
  "summary": "짧은 요약",
  "required_changes": [
    {
      "file": "파일 경로 또는 unknown",
      "reason": "수정이 필요한 이유",
      "suggestion": "구체적 수정 방향"
    }
  ],
  "optional_suggestions": [
    {
      "file": "파일 경로 또는 unknown",
      "suggestion": "선택 개선 의견"
    }
  ],
  "scope_check": {
    "within_current_task": true,
    "scope_issues": []
  },
  "test_check": {
    "build_passed": true,
    "test_passed": true,
    "lint_passed": true,
    "issues": []
  },
  "next_step": "complete_task | revise_with_codex | stop_for_user"
}

## Decision Rules

- pass: 현재 task 요구사항 충족, 치명적 문제 없음, 다음 task로 넘어가도 됨
- revise: 수정이 필요하지만 자동 수정 가능
- blocked: 요구사항 충돌, 데이터 위험, 패키지 추가, 대규모 리팩터링 등 사용자 판단 필요