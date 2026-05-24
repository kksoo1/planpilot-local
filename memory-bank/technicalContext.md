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
  - 업무/프로젝트 form 상태
  - 업무/프로젝트 CRUD 핸들러
  - RuleBasedAIProvider 추천 업무 연결

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
