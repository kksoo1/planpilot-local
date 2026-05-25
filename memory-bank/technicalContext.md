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
  - 업무 form 상태와 업무 CRUD 핸들러
  - 프로젝트 삭제 handler, confirm 흐름, 실제 deleteProject store action 호출
  - RuleBasedAIProvider 추천 업무 연결
  - 다음 리팩터링 후보는 form state와 CRUD orchestration을 custom hook으로 나누는 작업이다.
  - 첫 단계에서는 `useTaskFormState` 또는 `useProjectFormState`처럼 상태/reset/start/cancel만 분리하고, submit/삭제/토글 handler 이동은 별도 단계로 검토한다.
  - hook은 store action을 중복 구현하지 않고 기존 `addTask`, `updateTask`, `deleteTask`, `addProject`, `updateProject`, `deleteProject`를 호출하는 방향을 유지한다.
  - `useProjectFormState`는 프로젝트 입력값, 수정 대상 id, 수정 시작/취소/reset만 담당한다.
  - `useProjectActions`는 프로젝트 추가/수정 submit orchestration만 담당한다.
  - `projectDeletion`은 기본 프로젝트와 업무 연결 프로젝트 삭제 방지 기준을 제공한다.
  - 프로젝트 삭제 handler는 아직 `App.tsx`에 있으며, 삭제 확인창과 실제 `deleteProject` 호출을 유지한다.
  - `useTaskFormState`는 업무 추가/수정 form state와 reset/start/cancel만 담당한다.
  - 업무 추가/수정/삭제/완료 토글 handler는 아직 `App.tsx`에 있으며, `useTaskActions`로 옮기기 전 submit handler만 먼저 검토한다.

- `src/hooks`
  - `useTaskFormState`
    - 업무 추가 form 입력값과 form open 상태
    - 업무 수정 form 입력값과 수정 대상 id
    - 수정 시작, 수정 취소, 추가/수정 form reset
    - 업무 CRUD handler는 담당하지 않음
  - `useProjectFormState`
    - 프로젝트 추가/수정 form 입력값
    - 수정 대상 id
    - 수정 시작, 수정 취소, 추가/수정 form reset
  - `useProjectActions`
    - 프로젝트 추가 submit
    - 프로젝트 수정 submit
    - 이름 trim, 빈 이름 방지, 저장 후 reset 시점 유지
    - 프로젝트 삭제 handler는 담당하지 않음

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
