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