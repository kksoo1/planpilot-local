# AI Dev Plan

## Goal

PlanPilot Local 업무 검색/필터 UX 개선

## 목표 범위

- PlanPilot Local의 업무 목록에서 검색/필터 UX를 작게 개선한다.
- 기존 데이터 구조, IndexedDB 저장 방식, package 구성을 유지한다.
- 업무 목록 UI 상태와 파생 필터링 로직 중심으로 구현한다.
- 이번 목표는 AI Dev Loop가 실제 앱 기능 개발에도 안정적으로 적용되는지 확인하는 실험이다.

## 범위 제한

- DB schema를 변경하지 않는다.
- package.json과 package-lock.json을 수정하지 않는다.
- 새 package를 추가하지 않는다.
- 서버 API, localStorage, 로그인, 클라우드 동기화를 추가하지 않는다.
- 대규모 리팩터링이나 UI 전면 개편을 하지 않는다.
- 검색/필터 과정에서 IndexedDB 데이터 쓰기 코드를 추가하지 않는다.

## 작업 순서

### T001 업무 목록 구조와 필터 위치 확인

- 업무 목록 렌더링 위치를 확인한다.
- task 타입과 검색 가능한 필드를 확인한다.
- 기존 검색/필터/정렬 상태와 파생 데이터 계산 위치를 확인한다.
- 프로젝트명 검색을 위해 프로젝트 데이터와 연결 가능한지 확인한다.
- DB schema 변경 없이 구현 가능한 범위를 확정한다.

완료 기준:

- 업무 목록 UI 파일 위치를 확인한다.
- 검색 상태를 둘 위치를 확인한다.
- 기존 완료/미완료 또는 상태 필터를 깨지 않는 구현 방향을 정리한다.
- DB schema 변경이 필요 없는지 확인한다.

T001 확인 결과:

- 업무 목록 UI는 `src/views/TasksView.tsx`에서 렌더링한다.
- `src/App.tsx`가 `tasks`, `projects`를 store에서 읽고, 업무 목록 파생 데이터인 `filteredTasks`, `sortedTasks`를 계산한 뒤 `TasksView`에 전달한다.
- 검색어 상태는 이미 `src/App.tsx`의 `taskSearchQuery` state로 존재하며 `TasksView`에 `taskSearchQuery`, `onTaskSearchQueryChange` props로 전달된다.
- `TasksView`에는 이미 업무 검색 input이 있으며, 빈 상태 메시지는 검색어 있음/프로젝트 필터/완료 업무 숨김 상태를 구분한다.
- Task 타입은 `src/types.ts`에 있고 제목 필드는 `title`, 메모 필드는 선택 필드 `memo`, 프로젝트 연결 필드는 `projectId`다.
- Project 타입은 `src/types.ts`에 있고 프로젝트명 필드는 `name`이다.
- 프로젝트명 표시는 `src/App.tsx`에서 `getProjectName(projects, projectId)`를 `TasksView`와 `TaskCard`에 전달하는 방식으로 연결된다.
- 기존 필터/정렬 로직은 `src/utils/taskFilters.ts`의 `filterTasks`, `sortTasks`에 있다.
- 현재 `filterTasks`는 프로젝트 필터, 완료 업무 표시 여부, 제목 검색만 처리한다.
- 검색어는 `trim().toLowerCase()`로 처리되어 앞뒤 공백과 대소문자 차이를 이미 무시한다.
- 현재 검색 대상은 업무 제목뿐이며, 메모와 프로젝트명은 아직 포함되지 않는다.
- 검색/필터는 `tasks` 배열을 대상으로 한 파생 데이터 계산이므로 IndexedDB 쓰기, DB schema 변경, package 추가가 필요 없다.
- 다음 구현 task는 새 구조를 만들기보다 기존 `App.tsx`/`TasksView.tsx`/`taskFilters.ts` 흐름을 유지하며 보강하는 방식이 안전하다.

후속 task 제안:

- T002는 이미 검색 input과 검색어 state가 존재하므로, 코드 수정이 필요한지 먼저 확인한다. 요구사항이 이미 충족되어 있으면 코드 수정 없이 already-satisfied 처리할 수 있다.
- T003는 `taskFilters.ts` 검색 대상에 `memo`와 프로젝트명을 포함할지 검토한다. 프로젝트명 검색을 넣으려면 `filterTasks`에 projects 또는 projectName lookup을 전달하는 최소 변경이 필요하다.
- T004는 검색 결과 없음 empty 상태가 이미 존재하므로, 문구와 조건이 충분한지 먼저 확인한다.

### T002 업무 검색 입력 UI 추가

- 업무 목록 화면에 검색어 입력 UI를 추가한다.
- 검색어 상태를 관리한다.
- 검색어가 없을 때 기존 목록이 유지되는지 확인한다.
- `npm run build`를 실행한다.

### T003 업무 검색 필터 로직 추가

- 검색어를 기준으로 업무 목록을 필터링한다.
- 최소 업무 제목 검색을 지원한다.
- 가능한 경우 메모 또는 프로젝트명 검색도 포함한다.
- 대소문자와 앞뒤 공백을 무시한다.
- 검색 과정에서 DB 쓰기 코드가 없는지 확인한다.
- `npm run build`를 실행한다.

### T004 검색 결과 빈 상태 표시

- 검색 결과가 없을 때 사용자에게 빈 상태 메시지를 표시한다.
- 검색어를 지우면 기존 목록이 다시 표시되는지 확인한다.
- `npm run build`를 실행한다.

### T005 수동 테스트 체크리스트 업데이트

- `docs/manual-test-checklist.md`에 업무 검색/필터 수동 테스트 항목을 추가한다.
- 검색어 없음, 제목 검색, 결과 없음, 검색어 삭제, 데이터 미변경 항목을 포함한다.

### T006 빌드 검증 및 최종 요약

- `npm run build`를 실행한다.
- 전체 git diff를 리뷰한다.
- DB schema 변경이 없는지 확인한다.
- package 파일 변경이 없는지 확인한다.
- 최종 상태와 다음 후보 작업을 정리한다.

## Stop Conditions

- DB schema 변경이 필요해지는 경우
- package 추가가 필요해지는 경우
- App.css 대규모 수정이 필요해지는 경우
- 기존 완료/미완료 필터 동작을 바꿔야 하는 경우
- 검색/필터 구현을 위해 IndexedDB 쓰기 로직이 필요해지는 경우
- 현재 task 범위 밖 파일을 수정해야 하는 경우
- 같은 오류가 반복되어 작은 범위 안에서 해결하기 어려운 경우
