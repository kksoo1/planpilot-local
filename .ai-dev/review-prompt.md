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
업무 카드 버튼 접근성 라벨 개선

## 배경
업무 카드의 버튼 또는 상태 표시 문구 중 사용자가 의미를 더 명확하게 이해할 수 있는 안내 문구를 최소 범위로 개선한다.

## 성공 기준
- 업무 카드의 버튼 또는 상태 표시와 관련된 UI 문구 또는 aria-label이 더 명확해진다.
- 기능 로직과 데이터 흐름은 변경하지 않는다.
- 변경 범위는 관련 문구 수정에 한정한다.

## 제약사항
- 기존 컴포넌트 구조와 상태 관리 방식을 유지한다.
- 사용자-facing UI 문자열은 한국어를 기본으로 한다.
- 내부 enum 값은 변경하지 않는다.
- `src/App.css`는 수정하지 않는다.

## 범위 제외
- 새 기능 추가는 제외한다.
- 화면 구조 개편은 제외한다.
- 데이터 저장 구조 변경은 제외한다.

## 수동 검증
- 업무 카드에서 버튼 또는 상태 표시 문구가 자연스럽고 명확하게 보이는지 확인한다.
- 기존 업무 카드 조작 흐름이 동일하게 동작하는지 확인한다.
- 접근성 라벨이 버튼의 동작을 과장하거나 오해하게 만들지 않는지 확인한다.


## Current Task

- Task ID: T001
- Title: 업무 카드 문구 최소 개선
- Description: 업무 카드의 버튼 또는 상태 표시 중 의미가 모호한 문구를 확인하고, 기능 로직 변경 없이 UI 문구 또는 aria-label만 최소 범위로 개선한다.
- Type: implementation
- Status: in_progress
- Priority: P1
- Depends on:
- 없음
- Verification:
- 변경된 문구가 업무 카드의 실제 동작과 일치하는지 확인한다.
- 기능 로직이나 데이터 저장 관련 코드가 변경되지 않았는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-06-14 22:11:05

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
dist/assets/index-Ct_unKMl.js   316.48 kB │ gzip: 99.86 kB

[32m✓ built in 195ms[39m
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

2026-06-14 22:11:09

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M src/components/TaskCard.tsx
?? .ai-dev/auto-goal-planning-prompt.md
```

## App Change Files

- src/components/TaskCard.tsx

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev/test-result.md
- .ai-dev/auto-goal-planning-prompt.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 src/components/TaskCard.tsx | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)
```

## Unstaged Diff

```text
diff --git a/src/components/TaskCard.tsx b/src/components/TaskCard.tsx
index 8d388a2..0386f49 100644
--- a/src/components/TaskCard.tsx
+++ b/src/components/TaskCard.tsx
@@ -24,7 +24,7 @@ export function TaskCard({
       <strong>{task.title}</strong>
       {showDueSoonBadge && (
         <span
-          aria-label="마감 임박 배지"
+          aria-label="마감일이 가까운 업무"
           style={{
             alignSelf: "flex-start",
             border: "1px solid #d97706",
@@ -43,13 +43,29 @@ export function TaskCard({
         중요도: {getPriorityLabel(task.priority)} · 상태: {getStatusLabel(task.status)} · 프로젝트: {projectName}
       </span>
       <span>{task.dueDate ? `마감일: ${task.dueDate}` : "마감일 없음"}</span>
-      <button type="button" onClick={() => onToggleDone(task)}>
-        {task.status === "done" ? "미완료로 변경" : "업무 완료 처리"}
+      <button
+        type="button"
+        aria-label={
+          task.status === "done"
+            ? `${task.title} 업무를 미완료 상태로 변경`
+            : `${task.title} 업무를 완료 상태로 변경`
+        }
+        onClick={() => onToggleDone(task)}
+      >
+        {task.status === "done" ? "미완료로 변경" : "완료로 변경"}
       </button>
-      <button type="button" onClick={() => onDelete(task)}>
+      <button
+        type="button"
+        aria-label={`${task.title} 업무 삭제`}
+        onClick={() => onDelete(task)}
+      >
         삭제
       </button>
-      <button type="button" onClick={() => onStartEdit(task)}>
+      <button
+        type="button"
+        aria-label={`${task.title} 업무 수정`}
+        onClick={() => onStartEdit(task)}
+      >
         수정
       </button>
     </li>
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