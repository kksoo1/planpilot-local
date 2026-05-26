# Active Context

## Current Status
기본 MVP 구조는 생성되어 있고, 화면/카드/폼/유틸 분리를 통해 `App.tsx` 책임을 줄이는 단계다.
최근 확인 기준으로 `npm run build`는 성공했다.

## Completed
- React + Vite + TypeScript 프로젝트 생성
- dexie 설치
- zustand 설치
- IndexedDB 기반 DB 구현
- Zustand store 구현
- AIProvider 인터페이스 구현
- RuleBasedAIProvider 구현
- App.tsx 기본 화면 구현
- 업무 추가 폼 구현
- 업무 수정/삭제 구현
- 업무 완료/미완료 토글 구현
- 업무 검색, 완료 업무 표시/숨김, 프로젝트 필터, 마감일 빠른 순 정렬 구현
- 프로젝트 추가/수정/삭제 구현
- 기본 프로젝트 삭제 방지 구현
- 업무가 있는 프로젝트 삭제 방지 구현
- 오늘 화면의 추천 업무, 지난 마감 업무, 7일 이내 마감 업무 표시 구현
- SettingsView, TodayView, TasksView, ProjectsView 화면 컴포넌트 분리
- TaskCard, ProjectCard 표시 컴포넌트 분리
- TaskForm, ProjectForm 폼 컴포넌트 분리
- taskLabels, taskDates, taskFilters, projectStats 유틸 분리
- taskSummary, projectLookup, dateUtils, recommendationScore 유틸 분리
- useProjectFormState, useProjectActions 프로젝트 hook 분리
- useTaskFormState 업무 form state hook 분리
- useTaskActions 업무 추가/수정 submit hook 분리
- projectDeletion 삭제 가능 여부 helper 분리
- RuleBasedAIProvider가 추천 흐름 조립, 지난 마감/예정 업무 목록, 요약 문자열 생성을 담당하도록 정리
- recommendationScore가 priorityScore, getTaskScore, compareRecommendedTasks를 담당하도록 정리
- README.md를 PlanPilot Local 전용 문서로 갱신
- AGENTS.md 작성 및 Codex 작업 규칙 정리
- ROADMAP.md 작성 및 App.tsx 분리 계획 정리
- App.css는 사용자가 직접 관리
- Git baseline 커밋 완료
- .clineignore 생성 및 커밋 완료
- .clinerules 생성 및 커밋 완료

## Current Development Approach
Codex는 AGENTS.md와 ROADMAP.md를 기준으로 작업한다.

- 한 번에 하나의 기능만 구현
- 기본적으로 한 번에 하나의 파일만 수정
- 필요한 파일은 사용자에게 다시 요청하지 말고 직접 읽음
- patch 실패 시 사용자에게 코드 조각을 요구하지 않고 파일을 다시 읽은 뒤 더 작은 범위로 재시도
- 같은 수정이 2회 실패하면 원인을 보고하고 멈춤
- `src/App.css`는 사용자가 명시적으로 요청하지 않는 한 수정하지 않음
- 새 기능을 `src/App.tsx`에 계속 누적하기 전에 분리/정리 우선 여부를 검토
- 사용자가 허용한 경우에만 `npm run build` 실행
- git 명령은 사용자가 "커밋까지 진행"을 명시한 작업에서만 제한적으로 실행

## Next Recommended Task
업무 삭제 handler와 완료/미완료 토글 handler를 옮기기 전에 현재 `useTaskFormState`, `useTaskActions` 구조를 수동 테스트 기준으로 확인한다. 코드 리팩터링을 계속한다면 삭제 handler 또는 완료 토글 중 하나만 별도 문서화 후 작은 범위로 검토한다.

## Next Task Scope
- 우선 후보: 업무 삭제 handler를 `App.tsx`에 유지한 상태에서 삭제 확인창과 통계 회귀를 수동 테스트로 확인
- 보조 후보: 완료/미완료 토글 handler 분리 전 Today/Projects 통계 회귀 기준 문서화
- 목표: 업무 추가/수정 submit은 `useTaskActions`에 두고, 삭제와 완료 토글은 안전성이 확인될 때까지 `App.tsx`에 유지
- 검증: `npm run build`
- 금지:
  - `src/App.css` 수정
  - DB schema 변경
  - 서버 API 사용
  - localStorage 사용
  - 로그인/클라우드 동기화/알림/Capacitor 추가
