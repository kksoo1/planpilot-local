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

AI Dev Loop 상태 출력에서 stale 상태의 Review summary가 이전 task의 상세 결과를 현재 결과처럼 보이지 않게 숨긴다.

## 배경

새 goal 또는 새 task가 `not_started` 상태일 때 이전 goal/task의 review 요약 상세가 남아 있으면 사용자가 현재 결과로 오해할 수 있다. Test result summary의 stale 숨김 동작은 유지하면서 Review summary에도 같은 기준을 적용한다.

## 성공 기준

- `ai-dev-status.ps1`에서 Review summary가 stale 상태일 때 `Decision`, `Severity`, `Next step`, `Summary`를 출력하지 않는다.
- stale Review summary에는 `Status`, `Reason`, 숨김 안내만 표시된다.
- Test result summary의 기존 stale 숨김 동작은 유지된다.
- 새 goal 또는 새 task가 `not_started` 상태일 때 이전 review/test 요약이 현재 결과처럼 표시되지 않는다.
- 앱 `src` 파일은 수정하지 않는다.

## 제약사항

- 변경 범위는 AI Dev Loop 상태 출력 스크립트에 한정한다.
- 기존 출력 구조와 용어를 최대한 유지한다.
- 불필요한 구조 변경이나 대규모 재작성은 하지 않는다.
- 앱 소스 파일은 수정하지 않는다.

## 범위 제외

- 앱 UI 변경
- 데이터 저장 구조 변경
- 새 기능 추가
- 알림 또는 외부 연동 추가

## 수동 검증

- Review summary가 stale인 상태 파일로 `ai-dev-status.ps1`을 실행했을 때 상세 항목이 숨겨지는지 확인한다.
- Test result summary의 stale 숨김 출력이 기존처럼 동작하는지 확인한다.
- `not_started` 상태의 새 task에서 이전 review/test 결과가 현재 결과처럼 보이지 않는지 확인한다.

## Current Task

- Task ID: T001
- Title: stale Review summary 상세 숨김 구현
- Description: `ai-dev-status.ps1`에서 Review summary가 stale 상태일 때 이전 task의 상세 항목을 출력하지 않고 상태, 이유, 숨김 안내만 표시하도록 수정한다. Test result summary의 stale 숨김 동작은 유지한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- Review summary stale 상태에서 Decision, Severity, Next step, Summary가 출력되지 않는지 확인한다.
- Test result summary stale 숨김 동작이 유지되는지 확인한다.
- 새 goal 또는 새 task의 not_started 상태에서 이전 요약이 현재 결과처럼 보이지 않는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-06-28 19:56:36

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

[32m✓ built in 257ms[39m
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

### stale Review summary manual verification

- Status: passed
- Command: scripts/ai-dev-status.ps1
- Evidence:
  - Review summary shows `Status: stale`.
  - Review summary shows `Reason: previous review summary hidden because current task is initial state`.
  - After the stale status and reason, Review summary prints only `숨김`.
  - stale Review summary status에서는 stale `Decision`, `Severity`, `Next step`, `Summary`가 출력되지 않습니다.
  - Test result summary stale behavior remains unchanged.

```text
Review summary
- Status: stale
- Reason: previous review summary hidden because current task is initial state
- 숨김
```


## Diff To Review

# AI Dev Diff

## Generated At

2026-06-28 20:01:11

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
 M scripts/ai-dev-status.ps1
```

## App Change Files

- scripts/ai-dev-status.ps1

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

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-status.ps1 | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-status.ps1 b/scripts/ai-dev-status.ps1
index ec23aa9..54a7440 100644
--- a/scripts/ai-dev-status.ps1
+++ b/scripts/ai-dev-status.ps1
@@ -158,15 +158,15 @@ function Get-ReviewSummary {
         }
 
         if ($IsInitialState) {
-            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." $review
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." "숨김"
         }
 
         if ((Test-HasValue $LastReviewDecision) -and $LastReviewDecision -ne "not_started" -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
-            return New-SummaryStatus "stale" "review decision($decision)이 state lastReviewDecision($LastReviewDecision)와 다릅니다." $review
+            return New-SummaryStatus "stale" "review decision($decision)이 state lastReviewDecision($LastReviewDecision)와 다릅니다." "숨김"
         }
 
         if (-not (Test-HasValue $LastReviewDecision) -or $LastReviewDecision -eq "not_started") {
-            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 요약을 숨겼습니다." $review
+            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 요약을 숨겼습니다." "숨김"
         }
 
         return New-SummaryStatus "current" "현재 상태와 일치합니다." $review
@@ -333,10 +333,14 @@ Write-Host ""
 Write-Host "Review summary:"
 Write-Host "  Status: $($reviewSummary.status)"
 Write-Host "  Reason: $($reviewSummary.reason)"
-Write-Host "  Decision: $($reviewSummary.content.decision)"
-Write-Host "  Severity: $($reviewSummary.content.severity)"
-Write-Host "  Next step: $($reviewSummary.content.nextStep)"
-Write-Host "  Summary: $($reviewSummary.content.summary)"
+if ($reviewSummary.status -eq "stale") {
+    Write-Host $reviewSummary.content
+} else {
+    Write-Host "  Decision: $($reviewSummary.content.decision)"
+    Write-Host "  Severity: $($reviewSummary.content.severity)"
+    Write-Host "  Next step: $($reviewSummary.content.nextStep)"
+    Write-Host "  Summary: $($reviewSummary.content.summary)"
+}
 
 if ($reviewSummary.status -eq "current" -and (Test-HasValue $reviewSummary.content.fallback)) {
     Write-Host $reviewSummary.content.fallback
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