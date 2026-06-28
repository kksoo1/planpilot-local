# AI Dev Revise Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.
이전 리뷰에서 지적된 사항만 수정한다.

## Goal

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
- Verification:
- Review summary stale 상태에서 Decision, Severity, Next step, Summary가 출력되지 않는지 확인한다.
- Test result summary stale 숨김 동작이 유지되는지 확인한다.
- 새 goal 또는 새 task의 not_started 상태에서 이전 요약이 현재 결과처럼 보이지 않는지 확인한다.

## Review Result

- Decision: revise
- Severity: low
- Next step: revise_with_codex
- Summary: 구현 자체는 stale Review summary 상세 숨김 요구를 충족하지만, 요구된 수동 검증 결과가 확인되지 않았고 npm run test도 
스크립트 부재로 skipped라 검증이 부족합니다.

## Required Changes

- File: unknown
  - Reason: 성공 기준의 핵심인 stale Review summary 출력 검증 결과가 제공되지 않았습니다.
  - Suggestion: Review summary가 stale인 상태, Test result summary stale 상태, 새 goal/task not_st
arted 상태에서 scripts/ai-dev-status.ps1 출력이 요구대로 동작하는지 수동 검증하고 결과를 남기세요.

## Optional Suggestions

- optional_suggestions는 참고만 하며 구현하지 않는다.
- 없음

## Diff Context

# AI Dev Diff

## Generated At

2026-06-28 19:53:21

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-status.ps1
```

## App Change Files

- scripts/ai-dev-status.ps1

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/goal.md
- .ai-dev/queue.json
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

## Test Result

# AI Dev Test Result

## 2026-06-28 19:53:12

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

[32m✓ built in 250ms[39m
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