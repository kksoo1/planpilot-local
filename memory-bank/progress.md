# Progress

## 2026-05-10

### Completed
- Windows VSCode + Cline 개발 환경 구성
- Qwen3-Coder 30B Q5 모델 서버 연결
- React + Vite + TypeScript 앱 생성
- Dexie/Zustand 설치
- `src/types.ts` 작성
- `src/db.ts` 작성
- `src/store.ts` 작성
- `src/ai/AIProvider.ts` 작성
- `src/ai/RuleBasedAIProvider.ts` 작성
- `src/App.tsx` 기본 UI 작성
- 업무 추가 폼 작성
- `npm run build` 성공
- Git baseline 커밋
- `.clineignore` 커밋
- `.clinerules` 커밋

## 2026-05-21

### Completed
- 업무 완료/미완료 토글 구현 확인
- 업무 수정/삭제 구현 확인
- 업무 검색, 완료 업무 표시/숨김, 프로젝트 필터, 마감일 빠른 순 정렬 구현 확인
- 프로젝트 추가/수정/삭제 구현 확인
- 기본 프로젝트와 업무가 있는 프로젝트의 삭제 방지 구현 확인
- 오늘 화면의 추천 업무, 지난 마감 업무, 7일 이내 마감 업무 표시 구현 확인
- `README.md`를 PlanPilot Local 전용 문서로 갱신
- `AGENTS.md`에 Codex 작업 규칙 정리
- `ROADMAP.md`에 현재 상태와 `App.tsx` 분리 계획 정리

### Current Stable Commit
- `Stable MVP baseline`
- `Add Cline ignore rules`
- `Add Cline project rules`

### Next
1. 현재 memory-bank 문서를 Codex 운영 방식과 현재 구현 상태에 맞게 유지
2. `src/App.tsx` 분리 전 현재 빌드 상태 확인
3. 의존성이 적은 `SettingsView`부터 화면 컴포넌트 분리
4. 각 작은 리팩터링 후 `npm run build`로 확인
5. 사용자가 "커밋까지 진행"을 명시한 경우에만 제한된 git 명령으로 커밋

## 2026-05-24

### Completed
- `SettingsView`, `TodayView`, `TasksView`, `ProjectsView` 화면 컴포넌트 분리
- `TaskCard`, `ProjectCard` 표시 컴포넌트 분리
- `TaskForm`, `ProjectForm` 폼 컴포넌트 분리
- `taskLabels`, `taskDates`, `taskFilters`, `taskSummary`, `projectLookup`, `projectStats` 유틸 분리
- `dateUtils`에 `startOfToday`, `parseDueDate`, `isOverdueTask`, `isUpcomingTask` 공용 날짜 helper 정리
- `recommendationScore`에 `priorityScore`, `getTaskScore`, `compareRecommendedTasks` 추천 점수/정렬 helper 정리
- `RuleBasedAIProvider`는 추천 흐름 조립, 지난 마감/예정 업무 목록 제공, 업무 요약 문자열 생성을 담당하도록 정리
- ROADMAP에 앱 완성 기준과 리팩터링 진행 상태 보강

### Next
1. `App.tsx`에 남은 업무/프로젝트 form state를 custom hook으로 분리할지 검토
2. 먼저 `useProjectFormState` 또는 `useTaskFormState`처럼 form state만 분리하고, submit/CRUD handler 이동은 이후 단계로 분리
3. 설정 화면은 현재 읽기 전용 상태 확인 화면으로 유지하고, 실제 편집 기능은 별도 정책 확정 후 검토
4. 추천 로직 수동 테스트 후 기능 추가 진입 여부 결정
5. DB migration 규칙 문서화
