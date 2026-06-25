# AI Dev Diff

## Generated At

2026-06-25 15:58:00

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/codex-review-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/diff.md
 M .ai-dev/loop-log.md
 M .ai-dev/queue.json
 M .ai-dev/review-prompt.md
 M .ai-dev/review-response.json
 M .ai-dev/review.md
 M .ai-dev/revise-prompt.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M src/App.tsx
 M src/components/TaskCard.tsx
```

## App Change Files

- src/App.tsx
- src/components/TaskCard.tsx

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/codex-review-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/diff.md
- .ai-dev/loop-log.md
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
 src/App.tsx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
```

## Unstaged Diff

```text
diff --git a/src/App.tsx b/src/App.tsx
index 5e76eb3..cf3bfb3 100644
--- a/src/App.tsx
+++ b/src/App.tsx
@@ -140,7 +140,7 @@ function App() {
       <header className="app-header">
         <p className="eyebrow">Privacy-first local planner</p>
         <h1>PlanPilot Local</h1>
-        <p>서버 없이 로컬에 저장되는 개인 일정·업무 관리 앱</p>
+        <p>서버 없이 이 기기 안에 저장되는 개인 일정·업무 관리 앱</p>
       </header>
 
       <main className="app-main">
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```