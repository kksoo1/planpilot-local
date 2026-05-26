# PlanPilot Local

PlanPilot Local은 서버 없이 동작하는 개인 일정·업무 관리 앱입니다. 현재는 React + Vite + TypeScript 기반 웹앱 MVP이며, 나중에 Android 앱으로 확장할 수 있도록 로컬 우선 구조를 유지합니다.

## 목표

- 개인 업무와 프로젝트를 로컬에서 관리한다.
- 개인정보가 외부 서버로 나가지 않는 privacy-first 앱을 만든다.
- 서버 API, 로그인, 클라우드 동기화 없이 동작한다.
- 현재 MVP를 안정화한 뒤 Android/Capacitor 전환을 검토한다.

## 기술 스택

- React
- TypeScript
- Vite
- Zustand
- Dexie.js
- IndexedDB
- ESLint

## 현재 구현된 기능

- 하단 탭 기반 화면 전환
  - 오늘
  - 업무
  - 프로젝트
  - 설정
- 업무 관리
  - 업무 추가
  - 업무 수정
  - 업무 삭제
  - 완료/미완료 토글
  - 검색
  - 프로젝트 필터
  - 완료 업무 표시/숨김
  - 마감일 빠른 순 정렬
- 프로젝트 관리
  - 프로젝트 추가
  - 프로젝트 수정
  - 프로젝트 삭제
  - 기본 프로젝트 삭제 방지
  - 업무가 있는 프로젝트 삭제 방지
  - 프로젝트별 업무 통계 표시
- 오늘 화면
  - 전체 업무 수
  - 완료 업무 수
  - 지난 마감 업무
  - 7일 이내 마감 업무
  - 추천 업무
- 설정 화면
  - 현재 설정 값 표시
  - theme, language, AI Provider, 알림, 첫 실행 완료 상태를 읽기 전용으로 표시
- AI Provider
  - 서버 호출 없는 `RuleBasedAIProvider`
  - 우선순위와 마감일 기반 추천
  - 현재 `aiProvider`는 `rule_based` 단일 값만 사용

## 데이터 저장 방식

PlanPilot Local은 Dexie.js를 통해 IndexedDB에 데이터를 저장합니다.

현재 주요 테이블은 다음과 같습니다.

- `tasks`
- `projects`
- `appSettings`

`localStorage`는 사용하지 않습니다.

## 주요 파일

- `src/App.tsx`
  - 앱 초기화, 탭 상태, 화면 조립, 주요 CRUD 핸들러를 담당합니다.
  - 화면 JSX와 반복 UI는 `src/views`, `src/components`, `src/utils`로 분리 중입니다.
- `src/store.ts`
  - Zustand store와 업무/프로젝트/설정 액션을 정의합니다.
- `src/db.ts`
  - Dexie database와 기본 데이터 생성을 정의합니다.
- `src/types.ts`
  - 업무, 프로젝트, 앱 설정 타입을 정의합니다.
- `src/ai/AIProvider.ts`
  - AI Provider 인터페이스입니다.
- `src/ai/RuleBasedAIProvider.ts`
  - 로컬 rule-based 추천 구현입니다.
  - 외부 AI API 호출과 API Key 저장은 구현되어 있지 않습니다.
- `src/views`
  - 오늘, 업무, 프로젝트, 설정 화면 컴포넌트를 담습니다.
- `src/components`
  - 업무/프로젝트 카드와 폼 컴포넌트를 담습니다.
- `src/utils`
  - 날짜 계산, 프로젝트 통계, 라벨 매핑, 업무 필터/정렬 유틸을 담습니다.
- `AGENTS.md`
  - Codex 작업 규칙입니다.
- `ROADMAP.md`
  - 현재 상태와 개발 순서입니다.

## 실행 스크립트

```bash
npm run dev
npm run build
npm run lint
npm run preview
```

주의: 이 프로젝트에서는 사용자가 허용한 경우에만 빌드, 린트, preview를 실행합니다.

## 개발 제약

- 서버 API 사용 금지
- 로그인 기능 구현 금지
- 클라우드 동기화 구현 금지
- `localStorage` 사용 금지
- MVP 단계에서 알림 기능 구현 금지
- 현재 알림 설정은 `enableNotifications: false` 표시용이며 권한 요청을 하지 않음
- Android notification 권한 요청 금지
- 명시 요청 전까지 Capacitor 추가 금지
- `src/App.css`는 사용자가 직접 관리

## 다음 개발 방향

우선순위는 `ROADMAP.md`를 따릅니다.

1. 문서와 실제 코드 상태 동기화
2. 현재 빌드 가능 여부 확인
3. `src/App.tsx` 분리 설계
4. 남은 `App.tsx` 상태/핸들러 책임 축소
5. 날짜 계산과 추천 로직 정리
6. DB migration 정책 문서화
7. Android/Capacitor 전환 준비

## 추천/날짜 유틸 구조

최근 리팩터링 기준으로 추천 업무와 날짜 계산은 다음 역할로 나뉜다.

- `src/ai/recommendationScore.ts`
  - `priorityScore`: 업무 우선순위 값을 추천 점수로 변환한다.
  - `getTaskScore`: 우선순위와 마감일 기준 점수를 합산한다.
  - `compareRecommendedTasks`: 추천 업무 정렬 기준을 담당한다.
- `src/ai/RuleBasedAIProvider.ts`
  - 추천 흐름을 조립한다.
  - 완료되지 않은 업무를 추천 후보로 필터링하고, 추천 comparator를 적용한 뒤 기본 3개를 반환한다.
  - 지난 마감/예정 업무 목록과 업무 요약 문자열을 제공한다.
- `src/utils/dateUtils.ts`
  - `startOfToday`, `parseDueDate`, `isOverdueTask`, `isUpcomingTask` 같은 공용 날짜 helper를 제공한다.
- `src/utils/taskDates.ts`
  - Today 화면에서 사용할 지난 마감 업무와 7일 이내 마감 업무 목록 계산을 담당한다.

다음 리팩터링은 `App.tsx`에 남은 unused import/state/helper 정리, 읽기 전용 설정 화면 문서 동기화, 추천 로직 수동 테스트 후 기능 추가 진입 순서로 검토한다.

## 프로젝트 hook/helper 구조

최근 리팩터링 기준으로 프로젝트 화면의 form state와 submit orchestration은 `src/hooks`로 일부 분리되어 있습니다.

- `src/hooks/useProjectFormState.ts`
  - 프로젝트 추가/수정 form 입력값을 관리합니다.
  - 수정 대상 id, 수정 시작, 수정 취소, 추가/수정 form reset을 담당합니다.
- `src/hooks/useProjectActions.ts`
  - 프로젝트 추가 submit과 프로젝트 수정 submit만 담당합니다.
  - 이름 trim, 빈 이름 방지, 저장 후 form reset 시점을 유지합니다.
  - 프로젝트 삭제 handler는 아직 담당하지 않습니다.
- `src/utils/projectDeletion.ts`
  - 기본 프로젝트 삭제 방지와 업무가 연결된 프로젝트 삭제 방지 기준을 제공합니다.
  - `ProjectCard`의 삭제 버튼 비활성 기준과 `App.tsx`의 삭제 handler 방어 기준을 같은 helper로 맞춥니다.

`src/App.tsx`에는 아직 프로젝트 삭제 확인창, 삭제 가능 여부 최종 방어, 실제 `deleteProject` store action 호출 책임이 남아 있습니다. 삭제는 파괴적인 동작이므로 다음 리팩터링 전 수동 테스트 기준을 먼저 확인합니다.

## 업무 hook 구조

최근 리팩터링 기준으로 업무 form state와 업무 추가/수정 submit orchestration은 `src/hooks`로 일부 분리되어 있습니다.

- `src/hooks/useTaskFormState.ts`
  - 업무 추가 form 입력값과 form open 상태를 관리합니다.
  - 업무 수정 form 입력값과 수정 대상 id를 관리합니다.
  - 수정 시작, 수정 취소, 추가/수정 form reset을 담당합니다.
- `src/hooks/useTaskActions.ts`
  - 업무 추가 submit과 업무 수정 submit만 담당합니다.
  - 빈 제목 방지, 제목 trim, dueDate 길이 방어, memo/priority/projectId 반영, 저장 후 reset 시점을 유지합니다.
  - 업무 삭제 handler와 완료/미완료 토글 handler는 아직 담당하지 않습니다.

`src/App.tsx`에는 아직 업무 삭제 확인창, 실제 `deleteTask` 호출, 완료/미완료 토글 status 계산과 `updateTask` 호출 책임이 남아 있습니다. 삭제와 완료 토글은 Today/Projects 통계와 함께 회귀 범위가 넓으므로 별도 문서화와 수동 테스트 후 분리 여부를 결정합니다.
