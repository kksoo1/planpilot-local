# AI Dev Diff

## Generated At

2026-06-14 20:17:13

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
 M src/utils/dateUtils.ts
```

## App Change Files

- src/components/TaskCard.tsx
- src/utils/dateUtils.ts

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
 src/components/TaskCard.tsx | 19 +++++++++++++++++++
 src/utils/dateUtils.ts      |  9 ++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)
```

## Unstaged Diff

```text
diff --git a/src/components/TaskCard.tsx b/src/components/TaskCard.tsx
index d6be8ef..8d388a2 100644
--- a/src/components/TaskCard.tsx
+++ b/src/components/TaskCard.tsx
@@ -1,4 +1,5 @@
 import { getPriorityLabel, getStatusLabel } from "../utils/taskLabels";
+import { isUpcomingTask } from "../utils/dateUtils";
 import type { Task } from "../types";
 
 type TaskCardProps = {
@@ -16,9 +17,27 @@ export function TaskCard({
   onDelete,
   onStartEdit,
 }: TaskCardProps) {
+  const showDueSoonBadge = isUpcomingTask(task);
+
   return (
     <li className="task-card">
       <strong>{task.title}</strong>
+      {showDueSoonBadge && (
+        <span
+          aria-label="마감 임박 배지"
+          style={{
+            alignSelf: "flex-start",
+            border: "1px solid #d97706",
+            borderRadius: "999px",
+            color: "#92400e",
+            fontSize: "0.78rem",
+            fontWeight: 700,
+            padding: "0.15rem 0.5rem",
+          }}
+        >
+          마감 임박
+        </span>
+      )}
       {task.memo && <span>메모: {task.memo}</span>}
       <span>
         중요도: {getPriorityLabel(task.priority)} · 상태: {getStatusLabel(task.status)} · 프로젝트: {projectName}
diff --git a/src/utils/dateUtils.ts b/src/utils/dateUtils.ts
index a45a39e..f470eb7 100644
--- a/src/utils/dateUtils.ts
+++ b/src/utils/dateUtils.ts
@@ -9,7 +9,14 @@ export function startOfToday() {
 export function parseDueDate(dueDate?: string) {
   if (!dueDate) return null;
 
-  const parsed = new Date(dueDate);
+  const dateOnlyMatch = /^(\d{4})-(\d{2})-(\d{2})$/.exec(dueDate);
+  const parsed = dateOnlyMatch
+    ? new Date(
+        Number(dateOnlyMatch[1]),
+        Number(dateOnlyMatch[2]) - 1,
+        Number(dateOnlyMatch[3]),
+      )
+    : new Date(dueDate);
   return Number.isNaN(parsed.getTime()) ? null : parsed;
 }
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```