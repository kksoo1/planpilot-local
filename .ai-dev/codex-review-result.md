# Codex Review Result

## Run

- Started at: 2026-06-14 20:17:15
- Ended at: 2026-06-14 20:17:57
- Exit code: 0
- Review prompt: .ai-dev/review-prompt.md
- Review response: .ai-dev/review-response.json
- Command: codex exec <short wrapper pointing to .ai-dev/review-prompt.md>

## Output

```text
node.exe : OpenAI Codex v0.133.0
At C:\Users\SECUI\AppData\Roaming\npm\codex.ps1:24 char:5
+     & "node$exe"  "$basedir/node_modules/@openai/codex/bin/codex.js"  ...
+     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (OpenAI Codex v0.133.0:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 
--------
workdir: D:\ai-apps\planpilot-local
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: medium
reasoning summaries: none
session id: 019ec5d9-a6e0-7df2-9a89-7b93c52d675e
--------
user
Read and follow the full review prompt at this absolute file path: D:\ai-apps\planpilot-local\.ai-dev\review-prompt.md
codex
리뷰 지시문을 먼저 읽고, 그 안의 범위와 출력 형식에 맞춰 진행하겠습니다. 파일 내용만 확인합니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 'D:\\ai-apps\\planp
ilot-local\\.ai-dev\\review-prompt.md'" in D:\ai-apps\planpilot-local
 succeeded in 1027ms:
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

codex
지시문에 포함된 diff만으로도 핵심은 보이지만, `isUpcomingTask`의 실제 기준을 확인해야 판정할 수 있습니다. 앱 변경 파일 두 개만 읽겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 'D:\\ai-apps\\planp
ilot-local\\src\\utils\\dateUtils.ts'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 'D:\\ai-apps\\planp
ilot-local\\src\\components\\TaskCard.tsx'" in D:\ai-apps\planpilot-local
 succeeded in 1373ms:
import type { Task } from "../types";

export function startOfToday() {
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  return today;
}

export function parseDueDate(dueDate?: string) {
  if (!dueDate) return null;

  const dateOnlyMatch = /^(\d{4})-(\d{2})-(\d{2})$/.exec(dueDate);
  const parsed = dateOnlyMatch
    ? new Date(
        Number(dateOnlyMatch[1]),
        Number(dateOnlyMatch[2]) - 1,
        Number(dateOnlyMatch[3]),
      )
    : new Date(dueDate);
  return Number.isNaN(parsed.getTime()) ? null : parsed;
}

export function isOverdueTask(task: Task, today = startOfToday()) {
  if (task.status === "done") return false;
  const dueDate = parseDueDate(task.dueDate);
  return Boolean(dueDate && dueDate < today);
}

export function isUpcomingTask(task: Task, today = startOfToday(), days = 7) {
  if (task.status === "done") return false;

  const dueDate = parseDueDate(task.dueDate);
  if (!dueDate) return false;

  const daysLater = new Date(today);
  daysLater.setDate(today.getDate() + days);

  return dueDate >= today && dueDate <= daysLater;
}

 succeeded in 1415ms:
import { getPriorityLabel, getStatusLabel } from "../utils/taskLabels";
import { isUpcomingTask } from "../utils/dateUtils";
import type { Task } from "../types";

type TaskCardProps = {
  task: Task;
  projectName: string;
  onToggleDone: (task: Task) => void;
  onDelete: (task: Task) => void;
  onStartEdit: (task: Task) => void;
};

export function TaskCard({
  task,
  projectName,
  onToggleDone,
  onDelete,
  onStartEdit,
}: TaskCardProps) {
  const showDueSoonBadge = isUpcomingTask(task);

  return (
    <li className="task-card">
      <strong>{task.title}</strong>
      {showDueSoonBadge && (
        <span
          aria-label="留덇컧 ?꾨컯 諛곗?"
          style={{
            alignSelf: "flex-start",
            border: "1px solid #d97706",
            borderRadius: "999px",
            color: "#92400e",
            fontSize: "0.78rem",
            fontWeight: 700,
            padding: "0.15rem 0.5rem",
          }}
        >
          留덇컧 ?꾨컯
        </span>
      )}
      {task.memo && <span>硫붾え: {task.memo}</span>}
      <span>
        以묒슂?? {getPriorityLabel(task.priority)} 쨌 ?곹깭: {getStatusLabel(task.status)} 쨌 ?꾨줈?앺듃: {projectName}
      </span>
      <span>{task.dueDate ? `留덇컧?? ${task.dueDate}` : "留덇컧???놁쓬"}</span>
      <button type="button" onClick={() => onToggleDone(task)}>
        {task.status === "done" ? "誘몄셿猷뚮줈 蹂寃? : "?낅Т ?꾨즺 泥섎━"}
      </button>
      <button type="button" onClick={() => onDelete(task)}>
        ??젣
      </button>
      <button type="button" onClick={() => onStartEdit(task)}>
        ?섏젙
      </button>
    </li>
  );
}

codex
PowerShell 5.1의 기본 출력 인코딩 때문에 한글이 깨져 보였습니다. 동일 파일을 UTF-8로 다시 읽어 UI 문자열이 실제로 손상됐는지 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 'D:\\ai-apps\\planp
ilot-local\\src\\components\\TaskCard.tsx' -Encoding UTF8" in D:\ai-apps\planpilot-local
 succeeded in 1017ms:
import { getPriorityLabel, getStatusLabel } from "../utils/taskLabels";
import { isUpcomingTask } from "../utils/dateUtils";
import type { Task } from "../types";

type TaskCardProps = {
  task: Task;
  projectName: string;
  onToggleDone: (task: Task) => void;
  onDelete: (task: Task) => void;
  onStartEdit: (task: Task) => void;
};

export function TaskCard({
  task,
  projectName,
  onToggleDone,
  onDelete,
  onStartEdit,
}: TaskCardProps) {
  const showDueSoonBadge = isUpcomingTask(task);

  return (
    <li className="task-card">
      <strong>{task.title}</strong>
      {showDueSoonBadge && (
        <span
          aria-label="마감 임박 배지"
          style={{
            alignSelf: "flex-start",
            border: "1px solid #d97706",
            borderRadius: "999px",
            color: "#92400e",
            fontSize: "0.78rem",
            fontWeight: 700,
            padding: "0.15rem 0.5rem",
          }}
        >
          마감 임박
        </span>
      )}
      {task.memo && <span>메모: {task.memo}</span>}
      <span>
        중요도: {getPriorityLabel(task.priority)} · 상태: {getStatusLabel(task.status)} · 프로젝트: {projectName}
      </span>
      <span>{task.dueDate ? `마감일: ${task.dueDate}` : "마감일 없음"}</span>
      <button type="button" onClick={() => onToggleDone(task)}>
        {task.status === "done" ? "미완료로 변경" : "업무 완료 처리"}
      </button>
      <button type="button" onClick={() => onDelete(task)}>
        삭제
      </button>
      <button type="button" onClick={() => onStartEdit(task)}>
        수정
      </button>
    </li>
  );
}

codex
{
  "decision": "pass",
  "severity": "none",
  "summary": "현재 task 요구사항에 맞게 미완료 업무 중 오늘부터 7일 이내 마감일이 있는 카드에만 배지를 표시하며, 앱 변경 범위도 최소 수준으로 유지됐다.",
  "required_changes": [],
  "optional_suggestions": [
    {
      "file": "src/components/TaskCard.tsx",
      "suggestion": "반복 사용 가능성이 생기면 인라인 스타일을 컴포넌트 내부 상수로 분리할 수 있지만, 현재 범위에서는 필수는 아니다."
    }
  ],
  "scope_check": {
    "within_current_task": true,
    "scope_issues": []
  },
  "test_check": {
    "build_passed": true,
    "test_passed": false,
    "lint_passed": false,
    "issues": [
      "npm run test는 -BuildOnly 옵션으로 skipped 처리됐다.",
      "npm run lint는 -BuildOnly 옵션으로 skipped 처리됐다."
    ]
  },
  "next_step": "complete_task"
}
tokens used
19,049
{
  "decision": "pass",
  "severity": "none",
  "summary": "현재 task 요구사항에 맞게 미완료 업무 중 오늘부터 7일 이내 마감일이 있는 카드에만 배지를 표시하며, 앱 변경 범위도 최소 수준으로 유지됐다.",
  "required_changes": [],
  "optional_suggestions": [
    {
      "file": "src/components/TaskCard.tsx",
      "suggestion": "반복 사용 가능성이 생기면 인라인 스타일을 컴포넌트 내부 상수로 분리할 수 있지만, 현재 범위에서는 필수는 아니다."
    }
  ],
  "scope_check": {
    "within_current_task": true,
    "scope_issues": []
  },
  "test_check": {
    "build_passed": true,
    "test_passed": false,
    "lint_passed": false,
    "issues": [
      "npm run test는 -BuildOnly 옵션으로 skipped 처리됐다.",
      "npm run lint는 -BuildOnly 옵션으로 skipped 처리됐다."
    ]
  },
  "next_step": "complete_task"
}

```