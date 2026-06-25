# AI Dev Diff

## Generated At

2026-06-25 15:51:04

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M src/views/TasksView.tsx
```

## App Change Files

- src/views/TasksView.tsx

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 src/views/TasksView.tsx | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
```

## Unstaged Diff

```text
diff --git a/src/views/TasksView.tsx b/src/views/TasksView.tsx
index ba68ad2..b78f327 100644
--- a/src/views/TasksView.tsx
+++ b/src/views/TasksView.tsx
@@ -113,20 +113,20 @@ export function TasksView({
     : `완료 ${completedTaskCount}개(숨김)`;
   const emptyMessage =
     hasSearchQuery
-      ? "검색어와 일치하는 업무가 없어요."
+      ? "검색 결과에 맞는 업무가 없어요."
       : hasProjectFilter || hasVisibilityFilter
-        ? "현재 조건에 맞는 업무가 없어요."
+        ? "선택한 조건에 표시할 업무가 없어요."
         : "아직 등록된 업무가 없어요.";
   const emptyActionMessage =
     hasSearchQuery
-      ? "검색어를 바꾸거나 비운 뒤 다시 확인해보세요."
+      ? "검색어를 줄이거나 비운 뒤 다시 확인해보세요."
       : hasProjectFilter && hasVisibilityFilter
-        ? "프로젝트 필터를 전체로 바꾸거나 완료 업무 표시를 켜서 숨은 업무를 확인해보세요."
+        ? "프로젝트를 전체로 바꾸거나 완료 업무 표시를 켜서 숨은 업무를 확인해보세요."
         : hasProjectFilter
-          ? "프로젝트 필터를 전체로 바꾸면 다른 업무를 확인할 수 있어요."
+          ? "프로젝트를 전체로 바꾸면 다른 업무를 확인할 수 있어요."
           : hasVisibilityFilter
             ? "완료 업무 표시를 켜면 숨은 완료 업무를 확인할 수 있어요."
-            : "목표를 바로 실행할 수 있는 작은 업무로 나누어 로컬에 먼저 기록해보세요.";
+            : "작은 업무를 하나 추가하면 이 기기 안에 바로 저장돼요.";
 
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