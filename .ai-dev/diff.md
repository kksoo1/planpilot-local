# AI Dev Diff

## Generated At

2026-06-10 23:43:48

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
 src/components/TaskCard.tsx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
```

## Unstaged Diff

```text
diff --git a/src/components/TaskCard.tsx b/src/components/TaskCard.tsx
index 12597da..d6be8ef 100644
--- a/src/components/TaskCard.tsx
+++ b/src/components/TaskCard.tsx
@@ -25,7 +25,7 @@ export function TaskCard({
       </span>
       <span>{task.dueDate ? `마감일: ${task.dueDate}` : "마감일 없음"}</span>
       <button type="button" onClick={() => onToggleDone(task)}>
-        {task.status === "done" ? "미완료로 변경" : "완료"}
+        {task.status === "done" ? "미완료로 변경" : "업무 완료 처리"}
       </button>
       <button type="button" onClick={() => onDelete(task)}>
         삭제
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```