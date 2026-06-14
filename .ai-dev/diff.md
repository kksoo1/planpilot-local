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