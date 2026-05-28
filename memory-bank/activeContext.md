# Active Context

## Current Status
기본 MVP 구조는 생성되어 있고, 화면/카드/폼/유틸/hook 분리를 통해 `App.tsx` 책임을 orchestration 중심으로 줄인 상태다.
`docs/manual-regression-test-result.md` 기준 핵심 수동 회귀 테스트가 통과로 기록되어 MVP 완료 상태로 판정했다.
현재 단계는 MVP 이후 기능 고도화이며, JSON 내보내기 구현 전에 데이터 백업/내보내기 정책과 오류/로딩/빈 상태 정책을 문서화하는 흐름이다.

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
- useProjectFormState 프로젝트 form state hook 분리
- useProjectActions 프로젝트 추가/수정 submit, 프로젝트 삭제 hook 분리
- useTaskFormState 업무 form state hook 분리
- useTaskActions 업무 추가/수정 submit, 완료/미완료 토글, 업무 삭제 hook 분리
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
JSON 내보내기 기능을 바로 구현하기 전에 공통 오류/로딩/빈 상태 표시 기준을 실제 화면에 어떻게 적용할지 검토한다. 구현 범위가 커지면 먼저 문서화하고, 작은 단위로 진행한다.

## Next Task Scope
- 우선 후보: 공통 empty/error/loading 표시 기준 구체화
- 보조 후보: JSON 내보내기 전용 기능 구현 여부 검토
- 추가 후보: 업무 필터/정렬 UX 개선 후보 정리
- 목표: MVP 이후 기능 고도화에서 데이터 손상이나 회귀 없이 작은 단위로 안정화
- 검증: `npm run build`
- 금지:
  - `src/App.css` 수정
  - DB schema 변경
  - 서버 API 사용
  - localStorage 사용
  - 로그인/클라우드 동기화/알림/Capacitor 추가
