# Technical Context

## Environment
- Windows VSCode
- Windows PowerShell 5.1
- 명령어는 한 줄씩 실행
- PowerShell 5.1에서는 `&&` 사용 금지

## Stack
- React
- Vite
- TypeScript
- Dexie.js
- IndexedDB
- Zustand

## Storage
- IndexedDB + Dexie.js만 사용
- localStorage fallback 사용 금지
- 서버 API 사용 금지
- appSettings는 Dexie `appSettings` 테이블에 `id: "app-settings"` 단일 레코드로 저장
- store에서는 저장용 `id`를 제거한 `AppSettings` 상태를 사용
- 현재 `updateAppSettings`는 설정 저장 시 `updatedAt`을 자동 갱신하므로 설정 UI는 기존 `createdAt`을 유지한 설정 객체를 전달해야 함

## Current Architecture
- `src/types.ts`
  - Task
  - Project
  - AppSettings
  - StoredAppSettings

- `src/db.ts`
  - Dexie 기반 PlanPilotDatabase
  - tasks
  - projects
  - appSettings
  - ensureDefaultData()

- `src/store.ts`
  - Zustand store
  - initializeApp
  - fetchTasks
  - fetchProjects
  - fetchAppSettings
  - addTask
  - updateTask
  - deleteTask
  - addProject
  - updateProject
  - deleteProject
  - updateAppSettings

- `src/ai/AIProvider.ts`
  - AIProvider interface

- `src/ai/RuleBasedAIProvider.ts`
  - 서버 호출 없는 rule-based AI 구현
  - 추천 흐름 조립
  - 지난 마감/예정 업무 목록 제공
  - 업무 요약 문자열 생성

- `src/ai/recommendationScore.ts`
  - priorityScore
  - getTaskScore
  - compareRecommendedTasks

- `src/App.tsx`
  - 앱 초기화
  - 하단 탭 상태
  - 화면 컴포넌트 조립
  - 업무/프로젝트 hook 조립
  - view props 전달
  - RuleBasedAIProvider 추천 업무 연결
  - hook은 store action을 중복 구현하지 않고 기존 `addTask`, `updateTask`, `deleteTask`, `addProject`, `updateProject`, `deleteProject`를 호출하는 방향을 유지한다.
  - `useProjectFormState`는 프로젝트 입력값, 수정 대상 id, 수정 시작/취소/reset만 담당한다.
  - `useProjectActions`는 프로젝트 추가/수정 submit orchestration과 프로젝트 삭제를 담당한다.
  - `projectDeletion`은 기본 프로젝트와 업무 연결 프로젝트 삭제 방지 기준을 제공한다.
  - 프로젝트 삭제 handler는 `useProjectActions`에서 `projectDeletion` 방어 기준, 삭제 확인창, 실제 `deleteProject(projectId)` 호출 시점을 담당한다.
  - `useTaskFormState`는 업무 추가/수정 form state와 reset/start/cancel만 담당한다.
  - `useTaskActions`는 업무 추가/수정 submit orchestration, 완료/미완료 토글, 업무 삭제를 담당한다.
  - 업무 삭제 handler는 `useTaskActions`에서 `window.confirm("정말로 이 업무를 삭제하시겠습니까?")` 취소/확인 흐름과 `deleteTask(task.id)` 호출 시점을 담당한다.
  - 업무 삭제는 TasksView 목록뿐 아니라 TodayView 전체/완료/지난 마감/7일 이내/추천 업무, ProjectsView 프로젝트별 통계에 영향을 주므로 hook 이동 전 수동 회귀 확인이 필요하다.
  - 완료/미완료 토글 handler는 `useTaskActions`에서 `todo`와 `done` 상태 전환을 계산하고 `updateTask({ ...task, status })` 호출 시점을 담당한다.
  - 완료 상태는 완료 업무 표시/숨김 필터, TodayView 완료 수와 날짜 기반 목록, 추천 업무 제외 기준, ProjectsView 프로젝트별 완료/미완료 통계에 영향을 주므로 hook 이동 전 수동 회귀 확인이 필요하다.

- `src/hooks`
  - `useTaskFormState`
    - 업무 추가 form 입력값과 form open 상태
    - 업무 수정 form 입력값과 수정 대상 id
    - 수정 시작, 수정 취소, 추가/수정 form reset
    - 업무 CRUD handler는 담당하지 않음
  - `useTaskActions`
    - 업무 추가 submit
    - 업무 수정 submit
    - 빈 제목 방지, 제목 trim, dueDate 길이 방어
    - memo, priority, projectId 반영
    - 저장 후 reset 시점 유지
    - 완료/미완료 토글
    - 업무 삭제 확인창과 확인 시 `deleteTask(task.id)` 호출
  - `useProjectFormState`
    - 프로젝트 추가/수정 form 입력값
    - 수정 대상 id
    - 수정 시작, 수정 취소, 추가/수정 form reset
  - `useProjectActions`
    - 프로젝트 추가 submit
    - 프로젝트 수정 submit
    - 이름 trim, 빈 이름 방지, 저장 후 reset 시점 유지
    - 프로젝트 삭제 확인창과 확인 시 `deleteProject(projectId)` 호출
    - `projectDeletion`을 사용해 기본 프로젝트와 업무 연결 프로젝트 삭제를 방어

- `src/views`
  - SettingsView
  - TodayView
  - TasksView
  - ProjectsView

- `src/components`
  - TaskCard
  - ProjectCard
  - TaskForm
  - ProjectForm

- `src/utils`
  - dateUtils
  - taskLabels
  - taskDates
  - taskFilters
  - taskSummary
  - projectLookup
  - projectStats
  - projectDeletion

## MVP Completion Status
- 현재 구현은 코드 구조와 핵심 기능 기준으로 MVP 완료 상태다.
- `docs/manual-regression-test-result.md` 기준 수동 회귀 테스트 핵심 항목이 통과로 기록되었다.
- MVP 포함 범위는 Today, 전체 업무, 프로젝트, 설정 상태 화면, 업무/프로젝트 CRUD, 검색/필터/정렬, rule-based 추천, IndexedDB 저장이다.
- MVP 제외 범위는 서버 API, 로그인, 클라우드 동기화, 알림, Capacitor/Android, 외부 AI API, 다국어 전환, 다중 테마, 설정 직접 편집이다.
- 기능 고도화 전에는 데이터 백업/내보내기 정책, 오류/로딩 상태, 모바일 폭 UI 확인 범위를 별도 작업으로 검토한다.

## Data Backup / Export Policy
- 백업/내보내기 정책은 `docs/data-backup-export-policy.md`를 기준으로 한다.
- 1차 대상 데이터는 IndexedDB의 `tasks`, `projects`, `appSettings`다.
- 1차 내보내기 형식 후보는 사람이 읽기 쉬운 JSON이다.
- JSON에는 `format`, `version`, `exportedAt`, `data.tasks`, `data.projects`, `data.appSettings` 같은 구조를 포함하는 후보를 둔다.
- 가져오기/복원은 데이터 손상 위험이 있으므로 내보내기 이후 별도 단계로 분리한다.
- 가져오기 전에는 중복 ID 처리, 프로젝트 참조 무결성, 필수 필드 검증, appSettings의 `createdAt`/`updatedAt` 처리 기준을 확정해야 한다.
- 서버 API, `localStorage`, 로그인, 클라우드 동기화는 백업/내보내기 기능에서도 사용하지 않는다.

## Error / Loading / Empty State Policy
- 오류/로딩/빈 상태 정책은 `docs/error-loading-state-policy.md`를 기준으로 한다.
- 로딩 상태 후보는 앱 초기 데이터 로딩, IndexedDB 초기화, rule-based 추천 업무 생성, 향후 JSON 내보내기/가져오기다.
- 오류 상태 후보는 IndexedDB 읽기/쓰기 실패, 업무/프로젝트 CRUD 실패, 추천 업무 생성 실패, 향후 백업 파일 생성 실패, 향후 가져오기 파일 파싱/검증 실패다.
- 빈 상태 후보는 업무 없음, 기본 프로젝트만 있음, 검색 결과 없음, 필터 결과 없음, 추천 업무 없음, 지난 마감 업무 없음, 7일 이내 마감 업무 없음이다.
- 빈 상태는 오류가 아니라 정상 상태로 표시한다.
- 추천 업무 생성 실패는 업무/프로젝트 CRUD를 막지 않는 보조 오류로 취급한다.
- DB 오류는 일반 수동 재현이 어려우므로 별도 개발용 재현 절차가 준비될 때까지 보류 항목으로 둔다.
- JSON 내보내기/가져오기 오류 처리는 각 기능 구현 후 별도 수동 테스트 대상으로 둔다.
- 다음 코드 작업의 최소 적용 범위는 업무 없음, 검색 결과 없음, 필터 결과 없음, 추천 업무 없음, 지난 마감 업무 없음, 7일 이내 마감 업무 없음의 빈 상태 점검/보강이다.
- IndexedDB 오류 UI, CRUD 실패 error boundary, JSON export/import 실패 UI, 전역 loading overlay는 다음 코드 작업 범위에서 제외한다.
- JSON export는 전체 앱 공통 error/loading 체계보다 export 전용 성공/실패 메시지를 먼저 검토한다.
- JSON export 성공 기준은 파일 생성과 다운로드 시작이며, 메시지는 SettingsView 내부 버튼 근처의 짧은 문구를 1차 후보로 둔다.
- JSON export 실패 후보는 IndexedDB 읽기 실패, JSON 생성 실패, 브라우저 다운로드 실패 가능성, 알 수 없는 오류이며 실패해도 기존 IndexedDB 데이터는 변경하지 않는다.

## Codex Rules
- AGENTS.md를 우선 기준으로 작업
- ROADMAP.md의 우선순위와 리팩터링 계획을 참고
- 한 번에 하나의 기능 또는 하나의 작은 리팩터링만 작업
- 필요한 파일은 사용자에게 다시 요청하지 말고 직접 읽음
- `src/App.css`는 사용자가 직접 관리
- 서버 API, localStorage, 로그인, 클라우드 동기화, 알림, Capacitor 추가 금지
- DB schema 변경 전에는 migration 계획을 먼저 작성
- 새 기능을 `src/App.tsx`에 누적하기 전에 분리/정리 우선 여부를 검토
- 사용자가 허용한 경우 수정 후 `npm run build` 실행
- git 명령은 사용자가 "커밋까지 진행"을 명시한 작업에서만 제한적으로 실행

## Settings Persistence Policy
- `AppSettings`는 현재 `theme: "light"`, `language: "ko"`, `aiProvider: "rule_based"`, `enableNotifications: false`, `firstLaunchCompleted`, `createdAt`, `updatedAt`으로 구성된다.
- `StoredAppSettings`는 `AppSettings`에 `id`를 더한 IndexedDB 저장 타입이다.
- `db.ensureDefaultData()`는 `app-settings` 레코드가 없을 때 기본 설정을 생성한다.
- 설정 화면은 현재 읽기 전용 상태 확인 화면이며, 편집 기능은 DB schema 변경 없이 가능한 범위부터 별도 작업으로 검토한다.
- MVP에서 `theme`은 현재 허용 값 `light`를 읽기 전용으로 표시하는 범위에 머문다.
- `language`는 현재 허용 값 `ko`만 표시하며 실제 다국어 전환 기능은 없다.
- `aiProvider`는 현재 허용 값 `rule_based`만 표시하며 외부 AI API나 로컬 LLM 호출 기능은 없다.
- `enableNotifications`는 현재 허용 값 `false`만 표시하며 브라우저 Notification API, Android notification, Capacitor 알림 기능은 없다.
- 다국어 확장은 `AppSettings.language` 타입 확장, 기본값/IndexedDB 호환성 확인, 문자열 리소스 구조 결정 후 별도 작업으로 진행한다.
- AI provider 확장은 API Key 저장, 네트워크 호출, 개인정보 전송, local LLM endpoint 정책을 먼저 문서화한 뒤 별도 작업으로 진행한다.
- 알림 확장은 권한 요청 시점, 사용자 고지 문구, 로컬 알림/Android 알림/server push 범위 구분을 먼저 문서화한 뒤 별도 작업으로 진행한다.
- `firstLaunchCompleted`는 현재 SettingsView에서 읽기 전용으로 표시하며, 1차 정식 버전 전에는 내부 onboarding 상태로 완전히 숨길지 결정해야 한다.
