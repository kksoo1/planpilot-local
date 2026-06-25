# AI Dev Revise Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.
이전 리뷰에서 지적된 사항만 수정한다.

## Goal

# 목표
PlanPilot Local의 자동 개발 루프가 여러 개의 작은 task를 연속으로 처리할 수 있는지 검증한다.

## 배경
이번 목표는 앱 자체를 크게 완성하는 것이 아니라, 작은 UI 문구 개선 작업을 순차적으로 처리하면서 구현, 검증, 리뷰, 수정, 완료 기록 흐름이 안정적으로 이어지는지 확인하는 데 있다.

## 성공 기준
- 빈 상태와 필터 결과 없음 안내가 더 명확해진다.
- 업무 카드의 상태 안내와 다음 행동 안내가 더 일관되게 정리된다.
- 로컬 저장 기반 앱이라는 점을 과하지 않은 작은 안내 문구로 보강한다.
- 각 task가 순서대로 완료 상태로 전환된다.
- 모든 task 완료 후 목표 상태가 completed로 기록된다.

## 제약사항
- 한 번에 하나의 작은 변경만 진행한다.
- 기존 React, Vite, TypeScript, Zustand, Dexie 구조를 유지한다.
- 사용자-facing UI 문자열은 한국어를 기본으로 한다.
- 화면 문구 개선 중심으로 작업하고 저장 구조 변경은 하지 않는다.
- 사용자가 관리하는 스타일 파일은 수정하지 않는다.

## 범위 제외
- 계정 기반 기능 추가
- 원격 연동 기능 추가
- 결제 기능 추가
- 외부 서비스 연결
- 대규모 화면 재작성

## 수동 검증
- 빈 데이터 상태에서 안내 문구가 자연스럽게 보이는지 확인한다.
- 필터 결과가 없을 때 사용자가 다음 행동을 이해할 수 있는지 확인한다.
- 업무 카드의 상태 및 다음 행동 안내가 서로 어색하지 않은지 확인한다.
- 로컬 저장 안내 문구가 과도하게 강조되지 않는지 확인한다.

## Current Task

- Task ID: T003
- Title: 로컬 저장 안내 문구 보강
- Description: 앱이 이 기기 안에 데이터를 저장한다는 점을 사용자가 부담 없이 이해할 수 있도록 작은 안내 문구를 보강한다.
- Type: implementation
- Status: pending
- Priority: P1
- Verification:
- 로컬 저장 안내가 과하게 강조되지 않는지 확인한다.
- 기존 privacy-first 방향과 충돌하지 않는지 확인한다.
- 허용된 검증 명령이 있으면 실행 결과를 기록한다.

## Review Result

- Decision: revise
- Severity: high
- Next step: revise_with_codex
- Summary: 현재 앱 변경은 T003의 로컬 저장 안내 문구 보강이 아니라 업무 카드 상태/다음 행동 문구 변경에 해당한다.

## Required Changes

- File: src/components/TaskCard.tsx
  - Reason: Current Task T003은 앱이 이 기기 안에 데이터를 저장한다는 작은 안내 문구를 보강하는 작업인데, 실제 diff는 업무
 카드의 상태/다음 행동 라벨을 변경하고 있어 task 범위를 벗어난다.
  - Suggestion: 업무 카드 상태/다음 행동 문구 변경은 되돌리거나 T003 범위에서 제외하고, 로컬 저장 안내가 표시되는 적절한 기존 UI 
위치에 과하지 않은 한국어 안내 문구를 추가한다.

## Optional Suggestions

- optional_suggestions는 참고만 하며 구현하지 않는다.
- 없음

## Diff Context

# AI Dev Diff

## Generated At

2026-06-25 15:55:32

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/loop-log.md
 M .ai-dev/queue.json
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M src/components/TaskCard.tsx
```

## App Change Files

- src/components/TaskCard.tsx

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/loop-log.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 src/components/TaskCard.tsx | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)
```

## Unstaged Diff

```text
diff --git a/src/components/TaskCard.tsx b/src/components/TaskCard.tsx
index 1ef5a96..4f713c1 100644
--- a/src/components/TaskCard.tsx
+++ b/src/components/TaskCard.tsx
@@ -18,6 +18,9 @@ export function TaskCard({
   onStartEdit,
 }: TaskCardProps) {
   const showDueSoonBadge = isUpcomingTask(task);
+  const statusLabel = getStatusLabel(task.status);
+  const nextActionLabel =
+    task.status === "done" ? "미완료로 되돌리기" : "완료로 표시";
 
   return (
     <li className="task-card">
@@ -40,19 +43,15 @@ export function TaskCard({
       )}
       {task.memo && <span>메모: {task.memo}</span>}
       <span>
-        중요도: {getPriorityLabel(task.priority)} · 상태: {getStatusLabel(task.status)} · 프로젝트: {projectName}
+        중요도: {getPriorityLabel(task.priority)} · 상태: {statusLabel} · 다음 행동: {nextActionLabel} · 프로젝트: {projectName}
       </span>
       <span>{task.dueDate ? `마감일: ${task.dueDate}` : "마감일 없음"}</span>
       <button
         type="button"
-        aria-label={
-          task.status === "done"
-            ? `'${task.title}' 업무를 미완료로 되돌리기`
-            : `'${task.title}' 업무를 완료로 표시하기`
-        }
+        aria-label={`'${task.title}' 업무를 ${nextActionLabel}`}
         onClick={() => onToggleDone(task)}
       >
-        {task.status === "done" ? "미완료로 되돌리기" : "업무 완료로 표시"}
+        {nextActionLabel}
       </button>
       <button
         type="button"
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```

## Test Result

# AI Dev Test Result

## 2026-06-25 15:55:26

- Overall result: passed
- Current task: T003
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
dist/assets/index-C_1JY54w.js   317.43 kB │ gzip: 100.19 kB

[32m✓ built in 243ms[39m
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

## Allowed Scope

- required_changes에 필요한 최소 수정만 허용한다.
- 현재 task 범위를 벗어나지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 새 기능 추가보다 리뷰 지적사항 해결을 우선한다.

## Hard Rules

- `package.json`과 `package-lock.json`은 수정하지 않는다. 꼭 필요하면 중단하고 이유만 기록한다.
- 실제 DB 삭제 또는 초기화를 하지 않는다.
- 사용자 데이터 복원 또는 덮어쓰기를 하지 않는다.
- 대규모 리팩터링을 하지 않는다.
- git commit을 실행하지 않는다.
- git reset, git checkout, git clean을 실행하지 않는다.
- npm install을 실행하지 않는다.
- optional_suggestions는 기본적으로 구현하지 않는다.

## Required Output

- 반영한 required_changes 목록
- 수정한 파일 목록
- 검증 방법
- 반영하지 못한 항목과 이유
- 남은 위험
- `.ai-dev/loop-log.md`에 기록할 재수정 요약