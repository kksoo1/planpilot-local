# AI Dev Diff

## Generated At

2026-06-19 22:17:17

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/codex-review-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/diff.md
 M .ai-dev/loop-log.md
 M .ai-dev/review-prompt.md
 M .ai-dev/review-response.json
 M .ai-dev/review.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M src/App.tsx
 M src/utils/taskLabels.ts
 M src/views/TasksView.tsx
```

## App Change Files

- src/App.tsx
- src/utils/taskLabels.ts
- src/views/TasksView.tsx

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/codex-review-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/diff.md
- .ai-dev/loop-log.md
- .ai-dev/review-prompt.md
- .ai-dev/review-response.json
- .ai-dev/review.md
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 src/App.tsx             |  8 ++++++++
 src/utils/taskLabels.ts | 11 ++++++++++-
 src/views/TasksView.tsx | 22 +++++++++++++++++++++-
 3 files changed, 39 insertions(+), 2 deletions(-)
```

## Unstaged Diff

```text
diff --git a/src/App.tsx b/src/App.tsx
index 95d64ec..5e76eb3 100644
--- a/src/App.tsx
+++ b/src/App.tsx
@@ -116,6 +116,13 @@ function App() {
     projects,
   });
 
+  const summaryTasks = filterTasks(tasks, {
+    selectedProjectFilter,
+    showCompletedTasks: true,
+    taskSearchQuery,
+    projects,
+  });
+
   const sortedTasks = sortTasks(filteredTasks, taskSortOrder);
 
   const aiProvider = useMemo(() => new RuleBasedAIProvider(), []);
@@ -152,6 +159,7 @@ function App() {
           <TasksView
             projects={projects}
             filteredTasks={filteredTasks}
+            summaryTasks={summaryTasks}
             sortedTasks={sortedTasks}
             selectedProjectFilter={selectedProjectFilter}
             showCompletedTasks={showCompletedTasks}
diff --git a/src/utils/taskLabels.ts b/src/utils/taskLabels.ts
index 1beb326..4c11ca7 100644
--- a/src/utils/taskLabels.ts
+++ b/src/utils/taskLabels.ts
@@ -14,5 +14,14 @@ export function getPriorityLabel(priority: Task["priority"]) {
 }
 
 export function getStatusLabel(status: Task["status"]) {
-  return status === "done" ? "완료" : "미완료";
+  switch (status) {
+    case "in_progress":
+      return "진행 중";
+    case "done":
+      return "완료";
+    case "todo":
+      return "남은 업무";
+    default:
+      return status;
+  }
 }
diff --git a/src/views/TasksView.tsx b/src/views/TasksView.tsx
index f23e7cd..b2129c1 100644
--- a/src/views/TasksView.tsx
+++ b/src/views/TasksView.tsx
@@ -7,6 +7,7 @@ import type { TaskSortOrder } from "../utils/taskFilters";
 type TasksViewProps = {
   projects: Project[];
   filteredTasks: Task[];
+  summaryTasks: Task[];
   sortedTasks: Task[];
   selectedProjectFilter: string;
   showCompletedTasks: boolean;
@@ -51,6 +52,7 @@ type TasksViewProps = {
 export function TasksView({
   projects,
   filteredTasks,
+  summaryTasks,
   sortedTasks,
   selectedProjectFilter,
   showCompletedTasks,
@@ -94,6 +96,21 @@ export function TasksView({
   const hasSearchQuery = taskSearchQuery.trim().length > 0;
   const hasProjectFilter = selectedProjectFilter !== "all";
   const hasVisibilityFilter = !showCompletedTasks;
+  const completedTaskCount = summaryTasks.filter(
+    (task) => task.status === "done",
+  ).length;
+  const inProgressTaskCount = summaryTasks.filter(
+    (task) => task.status === "in_progress",
+  ).length;
+  const remainingTaskCount = summaryTasks.filter(
+    (task) => task.status === "todo",
+  ).length;
+  const totalTaskSummary = showCompletedTasks
+    ? `총 ${summaryTasks.length}개`
+    : `표시 ${filteredTasks.length}개 / 조건 일치 ${summaryTasks.length}개`;
+  const completedTaskSummary = showCompletedTasks
+    ? `완료 ${completedTaskCount}개`
+    : `완료 ${completedTaskCount}개(숨김)`;
   const emptyMessage =
     hasSearchQuery
       ? "검색어와 일치하는 업무가 없어요."
@@ -104,7 +121,10 @@ export function TasksView({
   return (
     <section className="screen-card">
       <h2>전체 업무</h2>
-      <p className="summary">총 {filteredTasks.length}개</p>
+      <p className="summary">
+        {totalTaskSummary} · 진행 중 {inProgressTaskCount}개 ·{" "}
+        {completedTaskSummary} · 남은 업무 {remainingTaskCount}개
+      </p>
 
       <label>
         업무 검색
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```