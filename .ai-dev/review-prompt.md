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
PlanPilot Local 자동 개발 루프 검증을 위해 작은 MVP 개선을 수행한다.

## 배경
이번 목표는 앱 자체의 대규모 완성이 아니라 자동 개발 루프가 구현, 검증, 리뷰, 수정, 커밋 흐름을 안정적으로 처리하는지 확인하기 위한 것이다. 업무 추가, 수정, 완료, 삭제 흐름에서 사용자가 다음 행동을 더 쉽게 이해하도록 안내 문구를 보강한다.

## 성공 기준
- 업무가 없는 상태에서 사용자가 다음에 할 일을 알 수 있다.
- 필터 결과가 없는 상태에서 필터 해제 또는 새 업무 추가 같은 다음 행동을 알 수 있다.
- 업무 추가, 수정, 완료, 삭제 흐름의 안내 문구가 더 명확하다.
- 로컬 저장 기반 앱이라는 점과 목표를 작은 업무로 나누는 방향성이 UI 또는 문서에 작게 반영된다.
- 기존 데이터 구조와 주요 동작을 변경하지 않는다.

## 제약사항
- 한 번에 하나의 작은 개선만 수행한다.
- 기존 React, Vite, TypeScript, Zustand, Dexie 구조를 따른다.
- 사용자-facing 문구는 한국어로 작성한다.
- 기존 저장 방식과 데이터 일관성을 유지한다.
- 불필요한 대규모 구조 변경을 하지 않는다.

## 범위 제외
- 계정 기반 기능
- 외부 연동 기능
- 결제 기능
- 대규모 화면 재구성
- 저장소 구조 변경

## 수동 검증
- 업무가 하나도 없을 때 빈 상태 안내가 자연스러운지 확인한다.
- 필터 적용 후 결과가 없을 때 다음 행동 안내가 보이는지 확인한다.
- 업무 추가, 수정, 완료, 삭제 흐름의 문구가 실제 동작과 맞는지 확인한다.
- 작은 업무로 목표를 나누는 제품 방향성이 과하지 않게 드러나는지 확인한다.

## Current Task

- Task ID: T001
- Title: 업무 흐름 안내 문구 개선
- Description: 빈 상태, 필터 결과 없음, 업무 추가·수정·완료·삭제 흐름에서 사용자가 다음 행동을 이해할 수 있도록 한국어 안내 문구를 작게 보강한다. 로컬 저장 기반 앱이라는 점과 목표를 작은 업무로 나누는 방향성을 과하지 않게 반영한다.
- Type: implementation
- Status: in_progress
- Priority: P1
- Depends on:
- 없음
- Verification:
- 변경 파일을 확인해 기존 JSX 구조가 중복되지 않았는지 검토한다.
- 업무 없음 상태와 필터 결과 없음 상태의 안내 문구가 서로 구분되는지 확인한다.
- 업무 추가, 수정, 완료, 삭제 관련 문구가 실제 동작과 일치하는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-06-25 15:13:45

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
dist/index.html                   0.46 kB │ gzip:   0.30 kB
dist/assets/index-DvjxWt30.css    5.69 kB │ gzip:   1.93 kB
dist/assets/index-6B6Ll8UE.js   317.52 kB │ gzip: 100.16 kB

[32m✓ built in 227ms[39m
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

2026-06-25 15:13:51

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
 M src/components/TaskCard.tsx
 M src/views/TasksView.tsx
```

## App Change Files

- src/components/TaskCard.tsx
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
- .ai-dev/revise-prompt.md
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 src/components/TaskCard.tsx |  6 +++---
 src/views/TasksView.tsx     | 22 ++++++++++++++++------
 2 files changed, 19 insertions(+), 9 deletions(-)
```

## Unstaged Diff

```text
diff --git a/src/components/TaskCard.tsx b/src/components/TaskCard.tsx
index 7218a1c..1ef5a96 100644
--- a/src/components/TaskCard.tsx
+++ b/src/components/TaskCard.tsx
@@ -52,21 +52,21 @@ export function TaskCard({
         }
         onClick={() => onToggleDone(task)}
       >
-        {task.status === "done" ? "미완료로 되돌리기" : "완료로 표시"}
+        {task.status === "done" ? "미완료로 되돌리기" : "업무 완료로 표시"}
       </button>
       <button
         type="button"
         aria-label={`'${task.title}' 업무 삭제하기`}
         onClick={() => onDelete(task)}
       >
-        삭제
+        업무 삭제
       </button>
       <button
         type="button"
         aria-label={`'${task.title}' 업무 수정하기`}
         onClick={() => onStartEdit(task)}
       >
-        수정
+        업무 수정
       </button>
     </li>
   );
diff --git a/src/views/TasksView.tsx b/src/views/TasksView.tsx
index b2129c1..ba68ad2 100644
--- a/src/views/TasksView.tsx
+++ b/src/views/TasksView.tsx
@@ -117,6 +117,16 @@ export function TasksView({
       : hasProjectFilter || hasVisibilityFilter
         ? "현재 조건에 맞는 업무가 없어요."
         : "아직 등록된 업무가 없어요.";
+  const emptyActionMessage =
+    hasSearchQuery
+      ? "검색어를 바꾸거나 비운 뒤 다시 확인해보세요."
+      : hasProjectFilter && hasVisibilityFilter
+        ? "프로젝트 필터를 전체로 바꾸거나 완료 업무 표시를 켜서 숨은 업무를 확인해보세요."
+        : hasProjectFilter
+          ? "프로젝트 필터를 전체로 바꾸면 다른 업무를 확인할 수 있어요."
+          : hasVisibilityFilter
+            ? "완료 업무 표시를 켜면 숨은 완료 업무를 확인할 수 있어요."
+            : "목표를 바로 실행할 수 있는 작은 업무로 나누어 로컬에 먼저 기록해보세요.";
 
   return (
     <section className="screen-card">
@@ -177,20 +187,20 @@ export function TasksView({
         type="button"
         onClick={() => onTaskFormOpenChange((current) => !current)}
       >
-        {isTaskFormOpen ? "새 업무 추가 닫기" : "새 업무 추가"}
+        {isTaskFormOpen ? "작은 업무 추가 닫기" : "작은 업무 추가"}
       </button>
 
       {isTaskFormOpen && (
         <TaskForm
-          title="새 업무 추가"
-          ariaLabel="업무 추가"
+          title="새 작은 업무 추가"
+          ariaLabel="새 작은 업무 추가"
           taskTitle={newTaskTitle}
           memo={newTaskMemo}
           dueDate={newTaskDueDate}
           priority={newTaskPriority}
           projectId={newTaskProjectId}
           projects={projects}
-          submitLabel="업무 추가"
+          submitLabel="로컬에 업무 추가"
           onTitleChange={onNewTaskTitleChange}
           onMemoChange={onNewTaskMemoChange}
           onDueDateChange={onNewTaskDueDateChange}
@@ -203,7 +213,7 @@ export function TasksView({
       {filteredTasks.length === 0 ? (
         <div className="empty">
           <p>{emptyMessage}</p>
-          {hasSearchQuery && <p>다른 검색어를 입력해보세요.</p>}
+          <p>{emptyActionMessage}</p>
         </div>
       ) : (
         <ul className="task-list">
@@ -220,7 +230,7 @@ export function TasksView({
                     priority={editTaskPriority}
                     projectId={editTaskProjectId}
                     projects={projects}
-                    submitLabel="저장"
+                    submitLabel="수정 저장"
                     onTitleChange={onEditTaskTitleChange}
                     onMemoChange={onEditTaskMemoChange}
                     onDueDateChange={onEditTaskDueDateChange}
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