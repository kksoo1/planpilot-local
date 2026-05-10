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

- `src/App.tsx`
  - 하단 탭 UI
  - 오늘/업무/프로젝트/설정 화면
  - 업무 추가 폼
  - RuleBasedAIProvider 추천 업무 표시

## Cline Rules
- 실제 LLM 서버 context size는 16K
- 한 번에 하나의 파일만 작업
- 요청하지 않은 파일은 읽거나 수정하지 않음
- `src/App.css`는 사용자가 직접 관리
- 수정 후 `npm run build` 실행
