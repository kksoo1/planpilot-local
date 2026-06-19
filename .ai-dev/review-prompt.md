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
업무 카드의 접근성 보조 문구 또는 aria-label을 자연스러운 한국어로 미세 개선한다.

## 배경
업무 카드에서 스크린 리더나 보조 기술에 전달되는 문구가 어색하지 않도록 최종 점검이 필요하다. 기능 로직, 상태 관리, 저장 구조는 유지하고 UI 문구 수준에서만 최소 변경한다.

## 성공 기준
- 업무 카드 관련 접근성 보조 문구 또는 aria-label이 자연스러운 한국어로 정리된다.
- 기존 기능 동작, 상태 관리, 저장 구조가 변경되지 않는다.
- 변경 범위가 업무 카드 문구 수준으로 제한된다.

## 제약사항
- 한 번에 하나의 작은 변경만 수행한다.
- 기존 타입, store 액션, DB 구조를 변경하지 않는다.
- 사용자-facing UI 문자열은 한국어를 기본으로 한다.
- src/App.css는 수정하지 않는다.

## 범위 제외
- 새로운 기능 추가는 하지 않는다.
- 화면 구조 개편이나 대규모 컴포넌트 분리는 하지 않는다.
- 데이터 저장 구조 변경은 하지 않는다.

## 수동 검증
- 업무 카드 화면에서 접근성 보조 문구가 자연스럽게 읽히는지 확인한다.
- 주요 업무 카드 조작 버튼의 aria-label이 문맥에 맞는지 확인한다.
- 기존 업무 생성, 수정, 완료 표시 흐름에 영향이 없는지 확인한다.

## Current Task

- Task ID: T001
- Title: 업무 카드 접근성 문구 점검 및 미세 수정
- Description: 업무 카드 관련 aria-label 또는 접근성 보조 문구를 확인하고 자연스러운 한국어로 최소 수정한다.
- Type: implementation
- Status: in_progress
- Priority: P1
- Depends on:
- 없음
- Verification:
- 변경된 문구가 업무 카드 문맥에 자연스럽게 맞는지 확인한다.
- 기능 로직, 상태 관리, 저장 구조 변경이 없는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-06-19 21:46:43

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
dist/index.html                   0.46 kB │ gzip:  0.30 kB
dist/assets/index-DvjxWt30.css    5.69 kB │ gzip:  1.93 kB
dist/assets/index-Bc7EYrNn.js   316.52 kB │ gzip: 99.88 kB

[32m✓ built in 204ms[39m
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

2026-06-19 21:46:48

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
 M src/components/TaskCard.tsx
```

## App Change Files

- src/components/TaskCard.tsx

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
 src/components/TaskCard.tsx | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
```

## Unstaged Diff

```text
diff --git a/src/components/TaskCard.tsx b/src/components/TaskCard.tsx
index aff165e..7218a1c 100644
--- a/src/components/TaskCard.tsx
+++ b/src/components/TaskCard.tsx
@@ -24,7 +24,7 @@ export function TaskCard({
       <strong>{task.title}</strong>
       {showDueSoonBadge && (
         <span
-          aria-label="마감일이 곧 다가오는 업무"
+          aria-label="마감일이 곧 다가오는 업무입니다"
           style={{
             alignSelf: "flex-start",
             border: "1px solid #d97706",
@@ -47,8 +47,8 @@ export function TaskCard({
         type="button"
         aria-label={
           task.status === "done"
-            ? `${task.title} 업무를 미완료로 되돌리기`
-            : `${task.title} 업무를 완료로 표시하기`
+            ? `'${task.title}' 업무를 미완료로 되돌리기`
+            : `'${task.title}' 업무를 완료로 표시하기`
         }
         onClick={() => onToggleDone(task)}
       >
@@ -56,14 +56,14 @@ export function TaskCard({
       </button>
       <button
         type="button"
-        aria-label={`${task.title} 업무 삭제하기`}
+        aria-label={`'${task.title}' 업무 삭제하기`}
         onClick={() => onDelete(task)}
       >
         삭제
       </button>
       <button
         type="button"
-        aria-label={`${task.title} 업무 수정하기`}
+        aria-label={`'${task.title}' 업무 수정하기`}
         onClick={() => onStartEdit(task)}
       >
         수정
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