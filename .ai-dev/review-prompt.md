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
업무 목록에 표시할 업무가 없을 때 더 자연스러운 한국어 안내 문구를 보여준다.

## 배경
현재 빈 상태 문구가 사용자에게 다소 어색하게 느껴질 수 있어, 기능 동작은 유지하면서 표시 문구만 개선한다.

## 성공 기준
- 업무 목록에 표시할 업무가 없을 때 개선된 한국어 안내 문구가 표시된다.
- 업무 생성, 필터링, 정렬 등 기존 기능 로직은 변경되지 않는다.
- 변경 범위는 빈 상태 UI 문구에 한정된다.

## 제약사항
- 사용자-facing UI 문자열은 한국어로 작성한다.
- 기능 로직, 상태 관리, 저장 구조는 변경하지 않는다.
- 최소 범위의 파일만 확인하고 수정한다.
- `src/App.css`는 수정하지 않는다.

## 범위 제외
- 새로운 화면 또는 컴포넌트 추가
- 업무 데이터 구조 변경
- 필터링 또는 목록 표시 조건 변경
- 스타일 변경

## 수동 검증
- 업무 목록에 표시할 업무가 없는 상태에서 안내 문구가 자연스럽게 보이는지 확인한다.
- 기존 업무가 있는 상태에서는 목록 표시가 이전과 동일하게 동작하는지 확인한다.

## Current Task

- Task ID: T001
- Title: 업무 목록 빈 상태 문구 수정
- Description: 업무 목록에 표시할 업무가 없을 때 나타나는 안내 문구를 찾아 더 자연스러운 한국어 문구로 최소 범위 수정한다.
- Type: implementation
- Status: in_progress
- Priority: P1
- Depends on:
- 없음
- Verification:
- 업무 목록 빈 상태에서 개선된 문구가 표시되는지 확인한다.
- 기존 업무 목록 표시 로직이 변경되지 않았는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-06-14 21:54:01

- Overall result: passed
- Current task: T001
- Commands:
  - npm run build: passed
  - npm run test: skipped
  - npm run lint: skipped

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
dist/index.html                   0.46 kB │ gzip:  0.30 kB
dist/assets/index-DvjxWt30.css    5.69 kB │ gzip:  1.93 kB
dist/assets/index-BCEAFpLX.js   316.26 kB │ gzip: 99.82 kB

[32m✓ built in 230ms[39m
```
### npm run test

- Status: skipped
- Exit code: 없음

```text
-BuildOnly 옵션으로 건너뛰었습니다.
```
### npm run lint

- Status: skipped
- Exit code: 없음

```text
-BuildOnly 옵션으로 건너뛰었습니다.
```
---

## Manual verification: 업무 목록 빈 상태 안내 문구 개선

### npm scripts

`	ext
{
  "dev": "vite",
  "build": "tsc -b && vite build",
  "lint": "eslint .",
  "preview": "vite preview"
}

`"
"


`	ext

> planpilot-local@0.0.0 lint
> eslint .


`"
"


- 앱 변경 범위는 src/views/TasksView.tsx의 빈 상태 안내 문구 수정으로 제한되었습니다.
- 기능 로직 변경 없이 사용자 안내 문구만 수정되었습니다.
- npm run lint를 수동 실행했고 오류 없이 종료되었습니다.
- npm run test는 package.json에 test 스크립트가 없으면 별도 실행 대상이 아닙니다.


## Diff To Review

# AI Dev Diff

## Generated At

2026-06-14 21:56:53

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
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M src/views/TasksView.tsx
```

## App Change Files

- src/views/TasksView.tsx

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
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 src/views/TasksView.tsx | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
```

## Unstaged Diff

```text
diff --git a/src/views/TasksView.tsx b/src/views/TasksView.tsx
index d887bf9..f23e7cd 100644
--- a/src/views/TasksView.tsx
+++ b/src/views/TasksView.tsx
@@ -96,10 +96,10 @@ export function TasksView({
   const hasVisibilityFilter = !showCompletedTasks;
   const emptyMessage =
     hasSearchQuery
-      ? "검색 결과가 없습니다."
+      ? "검색어와 일치하는 업무가 없어요."
       : hasProjectFilter || hasVisibilityFilter
-        ? "현재 필터 조건에 맞는 업무가 없습니다."
-        : "등록된 업무가 없습니다.";
+        ? "현재 조건에 맞는 업무가 없어요."
+        : "아직 등록된 업무가 없어요.";
 
   return (
     <section className="screen-card">
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