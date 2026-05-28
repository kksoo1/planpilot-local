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
- `useProjectFormState`로 프로젝트 추가/수정 form state, reset, 수정 시작/취소 흐름 분리
- `projectDeletion`으로 기본 프로젝트 삭제 방지와 업무 연결 프로젝트 삭제 방지 기준 분리
- `useProjectActions`로 프로젝트 추가/수정 submit orchestration과 프로젝트 삭제 분리
- `useTaskFormState`로 업무 추가/수정 form state, reset, 수정 시작/취소 흐름 분리
- `useTaskActions`로 업무 추가/수정 submit orchestration, 완료/미완료 토글, 업무 삭제 분리
- 업무 삭제 handler 분리 전 삭제 확인창, 삭제 취소/확인, Today/Projects 통계 회귀 기준 문서화
- 업무 완료/미완료 토글 handler 분리 전 완료 필터, Today 날짜 목록, Projects 통계, 추천 업무 회귀 기준 문서화
- ROADMAP에 앱 완성 기준과 리팩터링 진행 상태 보강
- 현재 구현 기준 MVP 완료 후보 상태 문서화
- MVP 수동 회귀 테스트 결과 기록용 `docs/manual-regression-test-result.md` 템플릿 준비
- `docs/manual-regression-test-result.md` 확인 결과 실제 수동 테스트 결과는 아직 기록되지 않아 MVP 판정은 미수행으로 유지
- 수동 회귀 테스트 결과 문서를 재확인했지만 통과로 기록된 항목이 없어 MVP 완료 판정은 계속 미수행으로 유지
- 최신 수동 회귀 테스트 결과 기준으로 대부분 핵심 항목은 통과했지만 추천 업무 rule-based 기준과 완료 업무 표시/숨김이 보류로 남아 MVP 완료 판정은 보류
- 보류였던 추천 업무 rule-based 기준과 완료 업무 표시/숨김이 통과로 갱신되어 핵심 기능 항목은 통과 상태가 되었지만, 테스트 개요/발견 이슈/후속 조치가 미수행으로 남아 MVP 완료 확정은 아직 보류

### Next
1. `docs/manual-regression-test-result.md`의 테스트 일자, 대상 커밋, 테스트 환경, 전체 결과를 실제 값으로 정리
2. 발견 이슈와 후속 조치를 "없음", "보류", 또는 구체 이슈로 정리
3. 미수행 항목이 모두 해소되면 MVP 완료 확정 후보로 ROADMAP과 memory-bank를 갱신
4. 데이터 백업/내보내기 정책 문서화
5. 오류/로딩 상태 보강 범위 문서화
6. 기능 고도화 단계 진입 여부 결정
7. DB migration 규칙 문서화
