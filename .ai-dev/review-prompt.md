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
Codex 리뷰 결과에서 JSON 추출이 실패하는 경우에도 루프가 중단되지 않도록 실패 처리를 보강한다.

## 배경
현재 AI Dev Loop는 Codex 리뷰 응답에서 JSON을 추출해 다음 판단에 사용한다. 리뷰 응답 형식이 예상과 다르거나 JSON 파싱에 실패하면 후속 상태 기록과 재시도 판단이 불안정해질 수 있다.

## 성공 기준
- Codex 리뷰 응답에서 JSON 추출 또는 파싱이 실패해도 명확한 실패 상태가 기록된다.
- 실패 원인이 로그나 상태 파일에서 확인 가능하다.
- 기존 정상 JSON 리뷰 처리 흐름은 유지된다.
- 변경 범위는 리뷰 JSON 추출 및 실패 처리 주변으로 제한된다.

## 제약사항
- 한 번에 하나의 작은 구현 변경만 진행한다.
- 기존 상태 파일 구조와 루프 흐름을 우선 유지한다.
- 사용자 변경 사항은 되돌리지 않는다.
- 로컬 저장 및 privacy-first 제약을 유지한다.

## 범위 제외
- 리뷰 프롬프트의 전면 재작성은 하지 않는다.
- 전체 AI Dev Loop 구조 개편은 하지 않는다.
- 새로운 외부 의존성 추가는 하지 않는다.
- UI 변경은 포함하지 않는다.

## 수동 검증
- JSON이 포함된 정상 리뷰 응답에서 기존처럼 decision과 severity가 처리되는지 확인한다.
- JSON이 없거나 깨진 리뷰 응답에서 상태 파일에 실패 요약이 남고 루프가 예측 가능하게 종료 또는 재시도되는지 확인한다.

## Current Task

- Task ID: T001
- Title: 리뷰 JSON 추출 실패 처리 보강
- Description: Codex 리뷰 응답에서 JSON 추출 또는 파싱에 실패하는 경로를 확인하고, 실패 원인이 상태에 남도록 최소 범위로 보강한다.
- Type: implementation
- Status: in_progress
- Priority: P1
- Depends on:
- 없음
- Verification:
- 정상 JSON 리뷰 응답 처리 흐름이 유지되는지 확인
- JSON이 없거나 잘못된 리뷰 응답에서 실패 요약이 기록되는지 확인

## Test Result

# AI Dev Test Result

## 2026-07-18 17:40:56

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

[32m✓ built in 187ms[39m
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
## Review JSON extraction verification - real git worktree evidence

- Verification method: git worktree with .git metadata and fake codex.cmd output modes.
- Target script: scripts/ai-dev-run-review-codex.ps1
- App src files modified: no
- This evidence was appended after ai-dev-check.ps1 output.

### Normal JSON review response
- Result: normal JSON path reached JSON extraction/parsing.
- review-response.json exists:
True
- exit code:
0
- parsed decision:
pass
- parsed severity:
none
- parsed next_step:
complete_task
- output:
Codex 由щ럭 ?ㅽ뻾???꾨즺?섏뿀?듬땲?? 由щ럭 JSON: .ai-dev/review-response.json 寃곌낵 ?뚯씪: .ai-dev/codex-review-result.md save-review ?먮쫫源뚯? ?ㅽ뻾?덉뒿?덈떎.

### Missing JSON review response
- Result: missing JSON path reached extraction failure handling.
- review-response.json exists:
False
- exit code:
1
- state.lastCommandStatus:
failed
- state.lastErrorSummary:
Codex 리뷰 JSON 추출에 실패했습니다: Codex 출력에서 필수 필드를 포함한 유효한 JSON 리뷰 객체를 찾지 못했습니다. 출력 preview: Fake reviewer response without a JSON object.  No decision object is present in this output.
- state.lastReviewDecision:
blocked
- state.lastReviewSeverity:
critical
- state.stopReason:
review_json_extraction_failed
- state.repeatedFailureCount:
1
- output:
Codex 由щ럭 JSON 異붿텧???ㅽ뙣?덉뒿?덈떎: Codex 異쒕젰?먯꽌 ?꾩닔 ?꾨뱶瑜??ы븿???좏슚??JSON 由щ럭 媛앹껜瑜?李얠? 紐삵뻽?듬땲?? 異쒕젰 preview: Fake reviewer response without a JSON object.  No decision object is present in this output.

### Malformed JSON review response
- Result: malformed JSON path reached extraction failure handling.
- review-response.json exists:
False
- exit code:
1
- state.lastCommandStatus:
failed
- state.lastErrorSummary:
Codex 리뷰 JSON 추출에 실패했습니다: Codex 출력에서 필수 필드를 포함한 유효한 JSON 리뷰 객체를 찾지 못했습니다. 출력 preview: before malformed json  {    "decision": "pass",    "severity": "none",    "next_step": "complete_task"
- state.lastReviewDecision:
blocked
- state.lastReviewSeverity:
critical
- state.stopReason:
review_json_extraction_failed
- state.repeatedFailureCount:
2
- output:
Codex 由щ럭 JSON 異붿텧???ㅽ뙣?덉뒿?덈떎: Codex 異쒕젰?먯꽌 ?꾩닔 ?꾨뱶瑜??ы븿???좏슚??JSON 由щ럭 媛앹껜瑜?李얠? 紐삵뻽?듬땲?? 異쒕젰 preview: before malformed json  {    "decision": "pass",    "severity": "none",    "next_step": "complete_task"

### Verification conclusion
- Normal JSON path verified in a real git worktree: decision/severity/next_step were extracted.
- Missing JSON path verified in a real git worktree: extraction failure handling updated state fields.
- Malformed JSON path verified in a real git worktree: extraction failure handling updated state fields.
- repeatedFailureCount behavior was captured for missing and malformed JSON failure states.


## Diff To Review

# AI Dev Diff

## Generated At

2026-07-18 18:18:49

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
 M scripts/ai-dev-run-review-codex.ps1
?? .ai-dev/review-json-extraction-verification-prompt.md
?? .ai-dev/review-json-failure-count-fix-prompt.md
```

## App Change Files

- scripts/ai-dev-run-review-codex.ps1

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
- .ai-dev/review-json-extraction-verification-prompt.md
- .ai-dev/review-json-failure-count-fix-prompt.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-run-review-codex.ps1 | 65 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-run-review-codex.ps1 b/scripts/ai-dev-run-review-codex.ps1
index 88f9b03..389f5b4 100644
--- a/scripts/ai-dev-run-review-codex.ps1
+++ b/scripts/ai-dev-run-review-codex.ps1
@@ -14,6 +14,8 @@
 $repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
 $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
 $codeFence = '```'
+$stateRelativePath = ".ai-dev/state.json"
+$statePath = Join-Path $repoRoot $stateRelativePath
 
 function Resolve-RepoPath {
     param(
@@ -42,6 +44,65 @@ function ConvertTo-RepoRelativePath {
     return $fullPath.Replace("\", "/")
 }
 
+function Test-HasValue {
+    param(
+        [object]$Value
+    )
+
+    if ($null -eq $Value) {
+        return $false
+    }
+
+    if ($Value -is [string]) {
+        return -not [string]::IsNullOrWhiteSpace($Value)
+    }
+
+    return $true
+}
+
+function Set-ObjectProperty {
+    param(
+        [object]$InputObject,
+        [string]$Name,
+        [object]$Value
+    )
+
+    if ($InputObject.PSObject.Properties.Name -contains $Name) {
+        $InputObject.$Name = $Value
+    } else {
+        $InputObject | Add-Member -NotePropertyName $Name -NotePropertyValue $Value
+    }
+}
+
+function Write-ReviewExtractionFailureState {
+    param(
+        [string]$ErrorSummary
+    )
+
+    if (-not (Test-Path -LiteralPath $statePath -PathType Leaf)) {
+        return
+    }
+
+    try {
+        $state = Get-Content -Raw -Encoding UTF8 -LiteralPath $statePath | ConvertFrom-Json
+        $failureCount = if ($state.stopReason -eq "review_json_extraction_failed" -and (Test-HasValue $state.repeatedFailureCount)) { [int]$state.repeatedFailureCount + 1 } else { 1 }
+
+        Set-ObjectProperty $state "lastCommand" "run-review-codex"
+        Set-ObjectProperty $state "lastCommandStatus" "failed"
+        Set-ObjectProperty $state "lastErrorSummary" $ErrorSummary
+        Set-ObjectProperty $state "lastReviewDecision" "blocked"
+        Set-ObjectProperty $state "lastReviewSeverity" "critical"
+        Set-ObjectProperty $state "repeatedFailureCount" $failureCount
+        Set-ObjectProperty $state "stopReason" "review_json_extraction_failed"
+        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
+
+        $stateJson = $state | ConvertTo-Json -Depth 20
+        [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)
+    } catch {
+        Write-Warning "$stateRelativePath에 리뷰 JSON 추출 실패 상태를 기록하지 못했습니다: $($_.Exception.Message)"
+    }
+}
+
 function Write-RunResult {
     param(
         [string]$Action,
@@ -346,7 +407,9 @@ try {
     $reviewResult = ConvertFrom-CodexReviewOutput $codexOutput
 } catch {
     $preview = Get-InputPreview $codexOutput
-    Write-RunResult "run_review_codex" $true 1 "Codex 리뷰 JSON 추출에 실패했습니다: $($_.Exception.Message) 출력 preview: $preview"
+    $errorSummary = "Codex 리뷰 JSON 추출에 실패했습니다: $($_.Exception.Message) 출력 preview: $preview"
+    Write-ReviewExtractionFailureState $errorSummary
+    Write-RunResult "run_review_codex" $true 1 $errorSummary
 }
 
 [System.IO.File]::WriteAllText($resolvedReviewResponsePath, $reviewResult.JsonText, $utf8WithBom)
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