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