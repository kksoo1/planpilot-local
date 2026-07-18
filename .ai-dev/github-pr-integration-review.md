# GitHub PR 연동 검토

## 목적

GitHub PR 정보를 실제로 연동하기 전에, PlanPilot Local의 현재 구조에서 안전하게 다룰 수 있는 최소 범위를 정리한다. 이번 검토는 문서 작성만 수행하며, 인증, 네트워크 연동, DB schema 변경, UI 구현은 포함하지 않는다.

## 현재 구조 요약

- 앱은 React + Vite + TypeScript 기반 로컬 웹앱이다.
- 화면 진입점인 `src/App.tsx`는 하단 탭 상태와 파생 데이터 계산을 맡고, 실제 화면은 `src/views/TodayView.tsx`, `src/views/TasksView.tsx`, `src/views/ProjectsView.tsx`, `src/views/SettingsView.tsx`로 분리되어 있다.
- 상태 관리는 `src/store.ts`의 Zustand store가 담당하며, 현재 도메인은 `tasks`, `projects`, `appSettings`이다.
- 로컬 저장은 `src/db.ts`의 Dexie v1 schema가 담당하며, 현재 테이블은 `tasks`, `projects`, `appSettings`뿐이다.
- 타입은 `src/types.ts`에 `Task`, `Project`, `AppSettings`, `StoredAppSettings`로 정의되어 있다.
- 백업/가져오기 검증 흐름은 설정 화면과 `src/utils/exportData.ts`, `src/utils/importValidation.ts` 계열에 붙어 있다.

## PR 정보 후보 위치

### 1. 업무 메모 또는 태그 기반 수동 기록

가장 작은 범위는 기존 `Task`의 `memo` 또는 `tags`에 PR URL, 저장소명, PR 번호를 사용자가 직접 적는 방식이다.

- 장점: DB schema 변경이 필요 없고, 현재 IndexedDB 데이터를 건드리지 않는다.
- 장점: `TasksView`와 `TaskCard`의 기존 업무 흐름 안에서 바로 이해할 수 있다.
- 단점: 구조화된 PR 상태, 리뷰어, merge 상태, 체크 상태를 안정적으로 필터링하기 어렵다.
- 판단: 1차 MVP 검토 결과로는 가장 안전한 시작점이다.

### 2. 프로젝트 단위 설명에 저장소/PR 맥락 기록

`Project.description`에 GitHub 저장소 URL 또는 관련 PR 기준을 적고, 개별 PR은 업무로 관리하는 방식이다.

- 장점: 저장소나 팀 단위 맥락은 프로젝트와 자연스럽게 맞는다.
- 장점: 새 테이블 없이 프로젝트 화면의 기존 데이터 구조를 재사용할 수 있다.
- 단점: PR 단위 상태 관리는 결국 업무 또는 별도 구조가 필요하다.
- 판단: 저장소 맥락 표시는 후보가 될 수 있으나, PR 목록 관리의 핵심 위치로는 부족하다.

### 3. 별도 PR 도메인 추가

`PullRequest` 같은 새 타입, Zustand 상태, Dexie 테이블을 추가하는 방식이다.

- 장점: PR 번호, URL, 상태, 리뷰 상태, 연결 업무를 구조화할 수 있다.
- 단점: `src/types.ts`, `src/db.ts`, `src/store.ts`, 화면 컴포넌트, 백업/가져오기 정책까지 함께 바뀐다.
- 단점: Dexie schema version과 migration 계획이 필요해 이번 task 범위를 넘는다.
- 판단: 실제 연동 또는 구조화된 관리가 필요해진 뒤 별도 task로 다뤄야 한다.

## MVP 최소 사용자 흐름

이번 기능의 첫 구현 후보는 "GitHub PR 연동"이 아니라 "업무에 PR 링크를 수동으로 연결해 추적한다"로 좁히는 것이 안전하다.

1. 사용자가 업무를 만들거나 수정할 때 PR URL을 메모에 적는다.
2. 사용자가 업무 제목, 메모, 태그 검색으로 PR 관련 업무를 찾는다.
3. 사용자는 PR 상태를 GitHub에서 직접 확인하고, PlanPilot에는 할 일 상태만 수동으로 관리한다.

이 흐름은 서버 API, GitHub 인증, 원격 데이터 수집, DB schema 변경 없이 현재 구조와 충돌하지 않는다.

## MVP 제외 범위

- GitHub OAuth 또는 Personal Access Token 입력
- GitHub API 호출
- `gh` CLI 또는 Copilot CLI 호출
- PR 자동 수집, 자동 동기화, polling
- PR 상태, 리뷰어, 체크 결과, merge 가능 여부 자동 반영
- 서버 API, 로그인, 클라우드 동기화
- `localStorage` 저장
- Dexie schema 변경과 migration
- 별도 PR 탭 또는 대규모 화면 재구성
- 알림 또는 Android notification 권한 요청

## 필요한 데이터 형태 후보

### 1차 후보: 기존 Task 재사용

별도 schema 변경 없이 다음 값을 사람이 입력한다.

- `Task.title`: PR과 연결된 업무 제목
- `Task.memo`: PR URL, 저장소명, PR 번호, 처리 메모
- `Task.tags`: `github`, `pr`, 저장소 별칭 같은 수동 분류
- `Task.status`: PlanPilot 안에서의 처리 상태
- `Task.projectId`: 관련 프로젝트

이 방식은 현재 백업/export/import 대상인 `tasks` 안에 자연스럽게 포함된다.

### 후속 후보: 구조화된 PR 링크 필드

정식 구조화가 필요해질 때 검토할 수 있는 형태는 다음과 같다.

```ts
type PullRequestLink = {
  id: string;
  taskId?: string;
  projectId?: string;
  provider: "github";
  repository: string;
  number: number;
  url: string;
  title?: string;
  state?: "open" | "closed" | "merged" | "draft";
  lastCheckedAt?: string;
  createdAt: string;
  updatedAt: string;
};
```

다만 이 구조는 새 table 또는 `Task` 확장을 요구하므로, migration 계획과 백업/가져오기 정책 업데이트가 선행되어야 한다.

## 저장 위치 후보

- 1차: 기존 `tasks` 테이블의 `memo`, `tags`, `projectId`를 사용한다.
- 2차: 프로젝트별 GitHub 저장소 맥락이 필요하면 기존 `projects.description`을 사용한다.
- 보류: 별도 `pullRequests` 테이블은 Dexie schema 변경이므로 이번 범위에서 제외한다.
- 보류: `appSettings`에 GitHub 설정을 저장하는 방식은 인증/토큰 저장 문제와 연결되므로 제외한다.

## 후속 구현 작업 제안

다음 task로 바로 전환 가능한 가장 작은 구현 단위는 다음 하나다.

**Task 후보: 업무 메모의 PR URL 표시 기준 정리 및 수동 테스트**

- 범위: 코드 변경 없이, 사용자가 업무 메모에 GitHub PR URL을 적고 검색으로 찾는 수동 흐름을 테스트 체크리스트에 추가한다.
- 포함: PR URL 예시, 태그 예시, 검색어 예시, 제외 기능 명시
- 제외: 링크 자동 파싱, 외부 API 호출, DB schema 변경
- 검증: 기존 업무 추가/수정/검색/백업 흐름과 충돌하지 않는지 수동 확인

그 다음 구현이 필요하다면 두 번째 작은 task는 "TaskCard 또는 TaskForm에서 PR URL을 사람이 읽기 쉽게 보여줄 수 있는 최소 UI 검토"가 적절하다. 이 경우에도 `App.tsx`에 복잡도를 추가하지 않고 `TaskCard` 또는 작은 utility부터 검토해야 한다.

## 중단 조건

다음 요구가 들어오면 별도 task로 분리하고, 구현 전에 추가 검토가 필요하다.

- GitHub 인증 정보 저장
- GitHub API 또는 `gh` CLI 호출
- PR 상태 자동 동기화
- 새 Dexie table 추가
- `Task` 타입에 구조화된 PR 필드 추가
- 백업/가져오기 schema 확장
- 새 탭 또는 큰 화면 재구성

## 수동 검증 결과

- 현재 구조에서 PR 정보를 표시하거나 관리할 후보 위치를 `Task.memo`, `Task.tags`, `Project.description`, 별도 PR 도메인으로 구분했다.
- MVP 최소 흐름은 기존 업무에 PR URL을 수동 기록하고 검색하는 방식으로 제한했다.
- 제외 범위는 인증, API 호출, 자동 수집, schema 변경, 대규모 UI 변경으로 명확히 분리했다.
- 필요한 데이터 형태는 기존 Task 재사용안을 우선하고, 구조화된 `PullRequestLink`는 후속 후보로만 남겼다.
- 후속 작업은 코드 변경 없는 수동 흐름 테스트 체크리스트 작성으로 분리했다.

## src 외 파일 수정 이유

이번 task의 산출물이 검토 문서이며, 프롬프트의 Likely Files가 `.ai-dev/goal.md`와 `.ai-dev/github-pr-integration-review.md`를 지정했다. 따라서 `src` 밖의 `.ai-dev/github-pr-integration-review.md`를 새로 작성하는 것이 task 완료에 필요하다.
