# AI Dev Diff

## Generated At

2026-06-03 23:13:57

## Git Status

```text
 M .ai-dev/current-task-prompt.md
 M .ai-dev/loop-log.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M src/views/SettingsView.tsx
```

## Unstaged Diff Stat

```text
git.exe : warning: in the working copy of '.ai-dev/current-task-prompt.md', LF will be replaced by CRLF the next time G
it touches it
At D:\ai-apps\planpilot-local\scripts\ai-dev-save-diff.ps1:73 char:15
+     $output = & git @Arguments 2>&1 | Out-String
+               ~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (warning: in the... Git touches it:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 
warning: in the working copy of '.ai-dev/loop-log.md', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of '.ai-dev/test-result.md', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'src/views/SettingsView.tsx', LF will be replaced by CRLF the next time Git touches it
 .ai-dev/current-task-prompt.md | 49 ++++++++++++++++++++++++++++++--------
 .ai-dev/loop-log.md            | 11 ++++++++-
 .ai-dev/state.json             |  4 ++--
 .ai-dev/test-result.md         | 23 +++++-------------
 src/views/SettingsView.tsx     | 54 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 111 insertions(+), 30 deletions(-)
```

## Unstaged Diff

```text
git.exe : warning: in the working copy of '.ai-dev/current-task-prompt.md', LF will be replaced by CRLF the next time G
it touches it
At D:\ai-apps\planpilot-local\scripts\ai-dev-save-diff.ps1:73 char:15
+     $output = & git @Arguments 2>&1 | Out-String
+               ~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (warning: in the... Git touches it:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 
warning: in the working copy of '.ai-dev/loop-log.md', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of '.ai-dev/test-result.md', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'src/views/SettingsView.tsx', LF will be replaced by CRLF the next time Git touches it
diff --git a/.ai-dev/current-task-prompt.md b/.ai-dev/current-task-prompt.md
index c67f57e..ed149f1 100644
--- a/.ai-dev/current-task-prompt.md
+++ b/.ai-dev/current-task-prompt.md
@@ -70,14 +70,14 @@ PlanPilot Local은 `tasks`, `projects`, `appSettings`를 포함한 JSON 백업 
 
 ## Current Task
 
-- Task ID: T001
-- Title: 기존 백업 export/import 관련 문서와 코드 위치 확인
-- Description: JSON 백업 구조, import 정책, 기존 검증 유틸, SettingsView 연결 지점을 확인하고 구현 범위를 확정한다.
-- Type: analysis
-- Status: pending
+- Task ID: T003
+- Title: import 미리보기 UI 추가
+- Description: 사용자가 JSON 백업 파일을 선택하고 검증 결과 요약을 확인할 수 있는 미리보기 UI를 추가한다.
+- Type: implementation
+- Status: in_progress
 - Priority: P0
 - Depends on:
-- 없음
+- T002
 
 ## Task Scope
 
@@ -88,12 +88,13 @@ PlanPilot Local은 `tasks`, `projects`, `appSettings`를 포함한 JSON 백업 
 
 ## Likely Files
 
-- 없음
+- src/views/SettingsView.tsx
+- src/App.tsx
 
 ## Verification
 
-- 관련 문서와 코드 위치 확인
-- 실제 DB 반영이 범위에서 제외되었는지 확인
+- 파일 선택 후 DB 데이터가 변경되지 않는지 확인
+- npm run build
 
 - 필요한 경우 `npm run build`는 사람이 별도로 실행한다.
 - 이 프롬프트는 자동으로 build, test, lint를 실행하라고 지시하지 않는다.
@@ -125,4 +126,32 @@ PlanPilot Local은 `tasks`, `projects`, `appSettings`를 포함한 JSON 백업 
 - 현재 task 범위 밖 수정이 필요한 경우
 - 패키지 추가가 필요한 경우
 - 데이터 삭제 또는 마이그레이션이 필요한 경우
-- 같은 오류가 반복되는 경우
\ No newline at end of file
+- 같은 오류가 반복되는 경우
+
+이번 작업은 T003 import 미리보기 UI 추가입니다.
+
+중요 제한:
+- 실제 복원 기능은 구현하지 마세요.
+- IndexedDB, store, db 쓰기 코드를 추가하지 마세요.
+- 기존 tasks/projects/appSettings 데이터를 변경하지 마세요.
+- 복원, 덮어쓰기, 병합 버튼을 만들지 마세요.
+- App.css는 수정하지 마세요.
+- package.json, package-lock.json은 수정하지 마세요.
+- src/views/SettingsView.tsx 중심으로 최소 수정하세요.
+- App.tsx는 필요한 경우에만 최소 수정하세요.
+
+구현 목표:
+1. 설정 화면에서 PlanPilot Local JSON 백업 파일을 선택할 수 있게 한다.
+2. 선택한 파일을 JSON으로 파싱한다.
+3. src/utils/importValidation.ts의 validateBackupData를 호출한다.
+4. 검증 실패 시 실패 이유를 화면에 표시한다.
+5. 검증 성공 시 tasks 개수, projects 개수, appSettings 포함 여부를 표시한다.
+6. 파일 선택/검증 과정에서 기존 IndexedDB 데이터가 변경되지 않게 한다.
+7. npm run build가 성공해야 한다.
+
+작업 후 출력:
+- 변경 파일 목록
+- 구현 요약
+- DB를 수정하지 않는 이유
+- 검증 방법
+- 남은 위험
\ No newline at end of file
diff --git a/.ai-dev/loop-log.md b/.ai-dev/loop-log.md
index c8ba333..6f62395 100644
--- a/.ai-dev/loop-log.md
+++ b/.ai-dev/loop-log.md
@@ -31,4 +31,13 @@
 
 - Task: T002 백업 JSON 검증 유틸 추가
 - Result: T002 완료: 백업 JSON 검증 유틸 추가, npm run build 통과, 커밋 4297d35 생성
-- Next task: T003 import 미리보기 UI 추가
\ No newline at end of file
+- Next task: T003 import 미리보기 UI 추가
+
+## 2026-06-03 23:12:18 - T003 implementation completed
+
+- Task: T003 import 미리보기 UI 추가
+- Result: SettingsView에 JSON 백업 파일 선택, 파싱, `validateBackupData` 호출, 검증 성공 요약과 실패 이유 표시를 추가했다.
+- Scope: `src/views/SettingsView.tsx`의 로컬 상태만 사용하며 store, db, IndexedDB 쓰기 경로는 추가하지 않았다.
+- Verification: 코드 리뷰로 복원, 덮어쓰기, 병합, 기존 데이터 변경 기능이 없음을 확인했다. `npm run build`는 이 프롬프트 지시에 따라 실행하지 않았다.
+- Remaining risk: 브라우저에서 정상/비정상 JSON 파일 선택 흐름과 파일 읽기 실패 상황은 아직 수동 확인하지 않았다.
+- Next task: T004 검증 실패 메시지와 성공 요약 표시 요구사항과 현재 구현의 중복 범위를 먼저 확인한다.
diff --git a/.ai-dev/state.json b/.ai-dev/state.json
index b661656..e085bd9 100644
--- a/.ai-dev/state.json
+++ b/.ai-dev/state.json
@@ -4,13 +4,13 @@
     "currentLoop":  0,
     "maxLoopsPerTask":  2,
     "repeatedFailureCount":  0,
-    "lastCommand":  "complete-task",
+    "lastCommand":  "npm run build",
     "lastCommandStatus":  "passed",
     "lastErrorSummary":  "",
     "lastReviewDecision":  "pass",
     "lastReviewSeverity":  "low",
     "lastCommitHash":  null,
     "startedAt":  null,
-    "updatedAt":  "2026-06-03T14:07:29.5652637+00:00",
+    "updatedAt":  "2026-06-03T14:13:50.2242987+00:00",
     "stopReason":  null
 }
\ No newline at end of file
diff --git a/.ai-dev/test-result.md b/.ai-dev/test-result.md
index 3ab9fc6..3c0bd07 100644
--- a/.ai-dev/test-result.md
+++ b/.ai-dev/test-result.md
@@ -1,9 +1,9 @@
 ﻿# AI Dev Test Result
 
-## 2026-06-03 22:58:27
+## 2026-06-03 23:13:50
 
 - Overall result: passed
-- Current task: T002
+- Current task: T003
 - Commands:
   - npm run build: passed
   - npm run test: skipped
@@ -21,25 +21,14 @@
 
 [36mvite v8.0.10 [32mbuilding client environment for production...[36m[39m
 [2K
-transforming...✓ 47 modules transformed.
+transforming...✓ 48 modules transformed.
 rendering chunks...
 computing gzip size...
 dist/index.html                   0.46 kB │ gzip:  0.29 kB
 dist/assets/index-DvjxWt30.css    5.69 kB │ gzip:  1.93 kB
-dist/assets/index-BlI1jiCI.js   310.90 kB │ gzip: 98.05 kB
-
-[32m✓ built in 571ms[39m
-node.exe : npm notice
-At C:\Program Files\nodejs\npm.ps1:29 char:3
-+   & $NODE_EXE $NPM_CLI_JS $args
-+   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-    + CategoryInfo          : NotSpecified: (npm notice:String) [], RemoteException
-    + FullyQualifiedErrorId : NativeCommandError
- 
-npm notice New major version of npm available! 10.9.2 -> 11.16.0
-npm notice Changelog: https://github.com/npm/cli/releases/tag/v11.16.0
-npm notice To update run: npm install -g npm@11.16.0
-npm notice
+dist/assets/index-DoMHun72.js   315.46 kB │ gzip: 99.46 kB
+
+[32m✓ built in 208ms[39m
 ```
 ### npm run test
 
diff --git a/src/views/SettingsView.tsx b/src/views/SettingsView.tsx
index 1e2a32d..2b14dfb 100644
--- a/src/views/SettingsView.tsx
+++ b/src/views/SettingsView.tsx
@@ -1,6 +1,10 @@
 import { useState } from "react";
 import type { AppSettings, Project, Task } from "../types";
 import { exportPlanPilotData } from "../utils/exportData";
+import {
+  validateBackupData,
+  type BackupValidationResult,
+} from "../utils/importValidation";
 
 type SettingsViewProps = {
   appSettings: AppSettings;
@@ -10,6 +14,9 @@ type SettingsViewProps = {
 
 export function SettingsView({ appSettings, tasks, projects }: SettingsViewProps) {
   const [exportMessage, setExportMessage] = useState("");
+  const [importFilename, setImportFilename] = useState("");
+  const [importResult, setImportResult] = useState<BackupValidationResult | null>(null);
+  const [importParseError, setImportParseError] = useState("");
 
   const handleExportData = () => {
     try {
@@ -20,6 +27,23 @@ export function SettingsView({ appSettings, tasks, projects }: SettingsViewProps
     }
   };
 
+  const handleImportFile = async (file: File | undefined) => {
+    setImportFilename(file?.name ?? "");
+    setImportResult(null);
+    setImportParseError("");
+
+    if (!file) {
+      return;
+    }
+
+    try {
+      const input: unknown = JSON.parse(await file.text());
+      setImportResult(validateBackupData(input));
+    } catch {
+      setImportParseError("JSON 파일을 읽거나 파싱하지 못했습니다.");
+    }
+  };
+
   return (
     <section className="screen-card">
       <h2>설정</h2>
@@ -41,6 +65,36 @@ export function SettingsView({ appSettings, tasks, projects }: SettingsViewProps
         </button>
         {exportMessage && <p className="summary">{exportMessage}</p>}
       </div>
+
+      <div className="settings-list">
+        <h3>데이터 가져오기 미리보기</h3>
+        <p>백업 파일을 검증하고 포함된 데이터만 확인합니다. 기존 데이터는 변경하지 않습니다.</p>
+        <input
+          type="file"
+          accept=".json,application/json"
+          onChange={(event) => void handleImportFile(event.target.files?.[0])}
+        />
+        {importFilename && <p>선택한 파일: {importFilename}</p>}
+        {importParseError && <p className="summary">{importParseError}</p>}
+        {importResult?.valid && (
+          <div className="summary">
+            <p>백업 파일 검증에 성공했습니다.</p>
+            <p>업무: {importResult.summary.taskCount}개</p>
+            <p>프로젝트: {importResult.summary.projectCount}개</p>
+            <p>설정 포함: {importResult.summary.hasAppSettings ? "예" : "아니오"}</p>
+          </div>
+        )}
+        {importResult && !importResult.valid && (
+          <div className="summary">
+            <p>백업 파일 검증에 실패했습니다.</p>
+            <ul>
+              {importResult.errors.map((error) => (
+                <li key={error}>{error}</li>
+              ))}
+            </ul>
+          </div>
+        )}
+      </div>
     </section>
   );
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

## Untracked File Content

### .ai-dev/current-task-prompt.md

```text
﻿# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# Goal

JSON 백업 파일 import 시 실제 복원은 하지 않고, 파일 검증과 미리보기까지만 제공하는 기능을 추가한다.

## Background

PlanPilot Local은 `tasks`, `projects`, `appSettings`를 포함한 JSON 백업 파일을 내보낼 수 있다.

현재 JSON import/복원 정책과 순수 검증 유틸은 준비되어 있지만, 사용자가 파일을 선택하고 검증 결과를 확인할 수 있는 흐름은 아직 없다.

데이터 손상 위험을 줄이기 위해 실제 IndexedDB 반영보다 파일 검증과 영향 범위 미리보기를 먼저 제공한다.

## Success Criteria

- 사용자가 PlanPilot Local JSON 백업 파일을 선택할 수 있다.
- `format`이 `planpilot-local-backup`인지 확인한다.
- `schemaVersion`이 `1`인지 확인한다.
- `exportedAt`, `tasks`, `projects`, `appSettings` 필수 항목을 확인한다.
- 검증 실패 시 사용자에게 실패 이유를 표시한다.
- 검증 성공 시 `tasks` 개수, `projects` 개수, `appSettings` 포함 여부를 표시한다.
- 파일 검증과 미리보기 과정에서 IndexedDB 데이터는 변경되지 않는다.
- `docs/manual-test-checklist.md`에 검증과 미리보기 수동 테스트 항목을 반영한다.
- `npm run build`가 성공한다.

## Constraints

- 실제 DB 반영을 하지 않는다.
- 복원, 덮어쓰기, 병합을 구현하지 않는다.
- `format`은 `planpilot-local-backup`만 허용한다.
- `schemaVersion`은 `1`만 허용한다.
- `exportedAt`, `tasks`, `projects`, `appSettings`를 필수로 확인한다.
- 검증 실패 이유를 사용자에게 표시한다.
- 검증 성공 시 데이터 개수와 설정 포함 여부를 표시한다.
- 서버 API, `localStorage`, 로그인, 클라우드 동기화를 추가하지 않는다.
- DB schema를 변경하지 않는다.
- `App.css`를 수정하지 않는다.
- 현재 task 범위 밖 파일을 수정하지 않는다.

## Out of Scope

- JSON 백업 데이터를 IndexedDB에 저장하는 기능
- 전체 덮어쓰기 복원
- 기존 데이터와의 병합
- 중복 ID 자동 수정
- 프로젝트 참조 자동 복구
- appSettings 자동 덮어쓰기
- 복원 전 자동 백업
- JSON export 구조 변경

## Manual Verification

- 정상 백업 파일을 선택하면 검증 성공 상태가 표시된다.
- 정상 백업 파일의 `tasks`와 `projects` 개수가 표시된다.
- 정상 백업 파일에 `appSettings`가 포함되어 있는지 표시된다.
- 잘못된 JSON 파일을 선택하면 검증 실패 이유가 표시된다.
- `format`이 다른 파일은 거부된다.
- `schemaVersion`이 `1`이 아닌 파일은 거부된다.
- 필수 항목이 누락된 파일은 거부된다.
- 파일을 선택하거나 검증한 뒤에도 기존 업무, 프로젝트, 설정 데이터가 유지된다.
- `npm run build`가 성공한다.


## Current Task

- Task ID: T003
- Title: import 미리보기 UI 추가
- Description: 사용자가 JSON 백업 파일을 선택하고 검증 결과 요약을 확인할 수 있는 미리보기 UI를 추가한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- T002

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

- src/views/SettingsView.tsx
- src/App.tsx

## Verification

- 파일 선택 후 DB 데이터가 변경되지 않는지 확인
- npm run build

- 필요한 경우 `npm run build`는 사람이 별도로 실행한다.
- 이 프롬프트는 자동으로 build, test, lint를 실행하라고 지시하지 않는다.

## Required Output

- 변경한 파일 목록
- 구현 또는 분석 내용 요약
- 검증 방법
- 남은 위험
- 다음 task로 넘어가도 되는지 여부
- `.ai-dev/loop-log.md`에 기록할 작업 요약

## Hard Rules

- `src` 외 파일을 수정해야 하는 경우 이유를 기록한다.
- `package.json`과 `package-lock.json`은 수정하지 않는다. 꼭 필요하면 중단하고 이유만 기록한다.
- 실제 DB 삭제 또는 초기화를 하지 않는다.
- 사용자 데이터 복원 또는 덮어쓰기를 하지 않는다.
- 현재 task와 무관한 UI 전면 개편을 하지 않는다.
- 대규모 리팩터링을 하지 않는다.
- git commit을 실행하지 않는다.
- git reset, git checkout, git clean을 실행하지 않는다.
- npm install을 실행하지 않는다.

## Stop Conditions

- 요구사항이 충돌하는 경우
- 현재 task 범위 밖 수정이 필요한 경우
- 패키지 추가가 필요한 경우
- 데이터 삭제 또는 마이그레이션이 필요한 경우
- 같은 오류가 반복되는 경우

이번 작업은 T003 import 미리보기 UI 추가입니다.

중요 제한:
- 실제 복원 기능은 구현하지 마세요.
- IndexedDB, store, db 쓰기 코드를 추가하지 마세요.
- 기존 tasks/projects/appSettings 데이터를 변경하지 마세요.
- 복원, 덮어쓰기, 병합 버튼을 만들지 마세요.
- App.css는 수정하지 마세요.
- package.json, package-lock.json은 수정하지 마세요.
- src/views/SettingsView.tsx 중심으로 최소 수정하세요.
- App.tsx는 필요한 경우에만 최소 수정하세요.

구현 목표:
1. 설정 화면에서 PlanPilot Local JSON 백업 파일을 선택할 수 있게 한다.
2. 선택한 파일을 JSON으로 파싱한다.
3. src/utils/importValidation.ts의 validateBackupData를 호출한다.
4. 검증 실패 시 실패 이유를 화면에 표시한다.
5. 검증 성공 시 tasks 개수, projects 개수, appSettings 포함 여부를 표시한다.
6. 파일 선택/검증 과정에서 기존 IndexedDB 데이터가 변경되지 않게 한다.
7. npm run build가 성공해야 한다.

작업 후 출력:
- 변경 파일 목록
- 구현 요약
- DB를 수정하지 않는 이유
- 검증 방법
- 남은 위험
```

### .ai-dev/loop-log.md

```text
# AI Dev Loop Log

## 2026-06-03 22:50:39 - T001 analysis completed

- Task: T001 기존 백업 export/import 관련 문서와 코드 위치 확인
- 백업 export 정책과 구현 위치:
  - `docs/data-backup-export-policy.md`
  - `src/utils/exportData.ts`
  - `src/views/SettingsView.tsx`
- JSON import/복원 정책과 수동 확인 기준 위치:
  - `docs/data-import-restore-policy.md`
  - `docs/manual-test-checklist.md`
- 기존 검증 유틸 확인:
  - `src/utils/importValidation.ts`에 `validateBackupData(input: unknown)` 순수 검증 함수가 이미 존재한다.
  - 이 함수는 백업 메타데이터, task/project/appSettings 필드, 중복 ID, project 참조 무결성, 요약 개수를 검증한다.
  - store, db, IndexedDB 쓰기 경로를 사용하지 않는다.
- 설정 화면 연결 지점 확인:
  - `SettingsView`는 현재 JSON export UI를 담당하며 `tasks`, `projects`, `appSettings`를 이미 props로 받는다.
  - `App.tsx`는 이 세 값을 `SettingsView`에 전달하고 있으므로, 검증/미리보기 UI는 설정 화면 내부의 로컬 상태로 연결할 수 있다.
- DB 비반영 범위 확인:
  - `.ai-dev/goal.md`와 `docs/data-import-restore-policy.md`는 실제 DB 반영, 복원, 덮어쓰기, 병합을 현재 goal 범위에서 제외한다.
  - `src/store.ts`와 `src/db.ts`는 이번 goal에서 수정할 필요가 없다.
- Result: T001 분석 완료. 앱 코드와 데이터는 변경하지 않았다.

## 2026-06-03 22:58:12 - Task completed

- Task: T001 기존 백업 export/import 관련 문서와 코드 위치 확인
- Result: T001 분석 완료: 백업 export/import 정책 문서, validateBackupData 위치, SettingsView 연결 지점 확인
- Next task: T002 백업 JSON 검증 유틸 추가
## 2026-06-03 23:07:29 - Task completed

- Task: T002 백업 JSON 검증 유틸 추가
- Result: T002 완료: 백업 JSON 검증 유틸 추가, npm run build 통과, 커밋 4297d35 생성
- Next task: T003 import 미리보기 UI 추가

## 2026-06-03 23:12:18 - T003 implementation completed

- Task: T003 import 미리보기 UI 추가
- Result: SettingsView에 JSON 백업 파일 선택, 파싱, `validateBackupData` 호출, 검증 성공 요약과 실패 이유 표시를 추가했다.
- Scope: `src/views/SettingsView.tsx`의 로컬 상태만 사용하며 store, db, IndexedDB 쓰기 경로는 추가하지 않았다.
- Verification: 코드 리뷰로 복원, 덮어쓰기, 병합, 기존 데이터 변경 기능이 없음을 확인했다. `npm run build`는 이 프롬프트 지시에 따라 실행하지 않았다.
- Remaining risk: 브라우저에서 정상/비정상 JSON 파일 선택 흐름과 파일 읽기 실패 상황은 아직 수동 확인하지 않았다.
- Next task: T004 검증 실패 메시지와 성공 요약 표시 요구사항과 현재 구현의 중복 범위를 먼저 확인한다.

```

### .ai-dev/state.json

```text
﻿{
    "goalStatus":  "in_progress",
    "currentTaskId":  "T003",
    "currentLoop":  0,
    "maxLoopsPerTask":  2,
    "repeatedFailureCount":  0,
    "lastCommand":  "npm run build",
    "lastCommandStatus":  "passed",
    "lastErrorSummary":  "",
    "lastReviewDecision":  "pass",
    "lastReviewSeverity":  "low",
    "lastCommitHash":  null,
    "startedAt":  null,
    "updatedAt":  "2026-06-03T14:13:50.2242987+00:00",
    "stopReason":  null
}
```

### .ai-dev/test-result.md

```text
﻿# AI Dev Test Result

## 2026-06-03 23:13:50

- Overall result: passed
- Current task: T003
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
dist/assets/index-DoMHun72.js   315.46 kB │ gzip: 99.46 kB

[32m✓ built in 208ms[39m
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
```

### src/views/SettingsView.tsx

```text
import { useState } from "react";
import type { AppSettings, Project, Task } from "../types";
import { exportPlanPilotData } from "../utils/exportData";
import {
  validateBackupData,
  type BackupValidationResult,
} from "../utils/importValidation";

type SettingsViewProps = {
  appSettings: AppSettings;
  tasks: Task[];
  projects: Project[];
};

export function SettingsView({ appSettings, tasks, projects }: SettingsViewProps) {
  const [exportMessage, setExportMessage] = useState("");
  const [importFilename, setImportFilename] = useState("");
  const [importResult, setImportResult] = useState<BackupValidationResult | null>(null);
  const [importParseError, setImportParseError] = useState("");

  const handleExportData = () => {
    try {
      const { filename } = exportPlanPilotData({ tasks, projects, appSettings });
      setExportMessage(`JSON 백업 파일을 만들었습니다: ${filename}`);
    } catch {
      setExportMessage("JSON 파일을 만들지 못했습니다. 잠시 후 다시 시도하세요.");
    }
  };

  const handleImportFile = async (file: File | undefined) => {
    setImportFilename(file?.name ?? "");
    setImportResult(null);
    setImportParseError("");

    if (!file) {
      return;
    }

    try {
      const input: unknown = JSON.parse(await file.text());
      setImportResult(validateBackupData(input));
    } catch {
      setImportParseError("JSON 파일을 읽거나 파싱하지 못했습니다.");
    }
  };

  return (
    <section className="screen-card">
      <h2>설정</h2>
      <div className="settings-list">
        <h3>현재 설정 상태</h3>
        <p>현재 MVP에서는 설정 값을 읽기 전용으로 확인합니다.</p>
        <p>테마: {appSettings.theme}</p>
        <p>언어: {appSettings.language}</p>
        <p>AI Provider: {appSettings.aiProvider}</p>
        <p>알림: {appSettings.enableNotifications ? "사용" : "MVP에서는 사용하지 않음"}</p>
        <p>첫 실행 완료: {String(appSettings.firstLaunchCompleted)}</p>
      </div>

      <div className="settings-list">
        <h3>데이터 백업</h3>
        <p>업무, 프로젝트, 설정 데이터를 로컬 JSON 파일로 내보냅니다.</p>
        <button type="button" onClick={handleExportData}>
          데이터 내보내기
        </button>
        {exportMessage && <p className="summary">{exportMessage}</p>}
      </div>

      <div className="settings-list">
        <h3>데이터 가져오기 미리보기</h3>
        <p>백업 파일을 검증하고 포함된 데이터만 확인합니다. 기존 데이터는 변경하지 않습니다.</p>
        <input
          type="file"
          accept=".json,application/json"
          onChange={(event) => void handleImportFile(event.target.files?.[0])}
        />
        {importFilename && <p>선택한 파일: {importFilename}</p>}
        {importParseError && <p className="summary">{importParseError}</p>}
        {importResult?.valid && (
          <div className="summary">
            <p>백업 파일 검증에 성공했습니다.</p>
            <p>업무: {importResult.summary.taskCount}개</p>
            <p>프로젝트: {importResult.summary.projectCount}개</p>
            <p>설정 포함: {importResult.summary.hasAppSettings ? "예" : "아니오"}</p>
          </div>
        )}
        {importResult && !importResult.valid && (
          <div className="summary">
            <p>백업 파일 검증에 실패했습니다.</p>
            <ul>
              {importResult.errors.map((error) => (
                <li key={error}>{error}</li>
              ))}
            </ul>
          </div>
        )}
      </div>
    </section>
  );
}

```