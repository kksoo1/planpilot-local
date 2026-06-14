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
업무 카드에서 마감일이 오늘부터 7일 이내인 미완료 업무에 `마감 임박` 배지를 표시한다.

## 배경
사용자가 가까운 마감 업무를 목록에서 빠르게 식별할 수 있도록, 기존 업무 카드 UI에 최소한의 시각적 표시를 추가한다.

## 성공 기준
- 마감일이 오늘부터 7일 이내인 미완료 업무 카드에 `마감 임박` 배지가 표시된다.
- 완료된 업무에는 `마감 임박` 배지가 표시되지 않는다.
- 마감일이 없거나 7일 범위를 벗어난 업무에는 배지가 표시되지 않는다.
- 기존 업무 생성, 수정, 완료 로직은 변경하지 않는다.
- UI 변경은 업무 카드 주변의 최소 범위로 유지한다.
- 허용된 build 검증을 통과한다.

## 제약사항
- React + Vite + TypeScript 기존 구조를 따른다.
- 상태 관리는 기존 Zustand store와 타입을 우선 사용한다.
- 로컬 저장 구조나 Dexie schema는 변경하지 않는다.
- `src/App.css`는 수정하지 않는다.
- 불필요한 컴포넌트 분리나 대규모 재작성은 하지 않는다.

## 범위 제외
- 업무 생성/수정/완료 동작 변경
- 새 설정 추가
- 알림 기능 추가
- 데이터 마이그레이션
- 전체 UI 재설계

## 수동 검증
- 오늘부터 7일 이내 마감일을 가진 미완료 업무 카드에 `마감 임박` 배지가 보이는지 확인한다.
- 완료 처리된 같은 업무에는 배지가 사라지는지 확인한다.
- 마감일이 없거나 8일 이후인 업무에는 배지가 보이지 않는지 확인한다.

## Current Task

- Task ID: T001
- Title: 마감 임박 배지 표시 구현
- Description: 업무 카드 렌더링 위치를 확인하고, 마감일이 오늘부터 7일 이내인 미완료 업무에만 `마감 임박` 배지를 최소 UI 변경으로 표시한다.
- Type: implementation
- Status: in_progress
- Priority: P1
- Depends on:
- 없음
- Verification:
- 허용 시 npm run build 실행
- 미완료 업무 중 마감일이 오늘부터 7일 이내인 카드에만 배지가 표시되는지 확인
- 완료 업무와 범위 밖 업무에는 배지가 표시되지 않는지 확인

## Test Result

# AI Dev Test Result

## 2026-06-14 20:17:10

- Overall result: passed
- Current task: T001
- Commands:
  - npm run build: passed
  - npm run test: skipped
  - npm run lint: skipped

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
dist/index.html                   0.46 kB │ gzip:  0.29 kB
dist/assets/index-DvjxWt30.css    5.69 kB │ gzip:  1.93 kB
dist/assets/index-D00vtd0_.js   316.25 kB │ gzip: 99.81 kB

[32m✓ built in 180ms[39m
```
### npm run test

- Status: skipped
- Exit code: 없음

```text
-BuildOnly 옵션으로 건너뛰었습니다.
```
### npm run lint

- Status: skipped
- Exit code: 없음

```text
-BuildOnly 옵션으로 건너뛰었습니다.
```

## Diff To Review

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