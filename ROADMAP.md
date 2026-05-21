# PlanPilot Local Roadmap

이 문서는 PlanPilot Local의 현재 상태와 앞으로의 개발 순서를 정리한다.

## 1. 현재 MVP 상태

- React + Vite + TypeScript 기반 로컬 웹앱이 생성되어 있다.
- Zustand store와 Dexie.js + IndexedDB 기반 저장소가 구현되어 있다.
- 서버 없이 동작하는 privacy-first 개인 일정/업무 관리 앱 방향을 따른다.
- 로그인, 서버 API, 클라우드 동기화, 알림, Capacitor는 아직 도입하지 않는다.
- UI는 `src/App.tsx` 중심으로 구현되어 있으며, 현재 파일이 커진 상태다.

## 2. 현재 구현된 기능

- 하단 탭 기반 화면 전환
  - 오늘
  - 업무
  - 프로젝트
  - 설정
- 업무 기능
  - 업무 추가
  - 업무 수정
  - 업무 삭제
  - 완료/미완료 토글
  - 검색
  - 완료 업무 표시/숨김
  - 프로젝트 필터
  - 마감일 빠른 순 정렬
- 프로젝트 기능
  - 프로젝트 추가
  - 프로젝트 수정
  - 프로젝트 삭제
  - 기본 프로젝트 삭제 방지
  - 업무가 있는 프로젝트 삭제 방지
  - 프로젝트별 전체/완료/미완료 업무 수 표시
- 오늘 화면
  - 전체 업무 수 표시
  - 완료 업무 수 표시
  - 지난 마감 업무 수 표시
  - 7일 이내 마감 업무 수 표시
  - 추천 업무 표시
  - 지난 마감 업무 목록 표시
  - 7일 이내 마감 업무 목록 표시
- 설정 화면
  - 테마, 언어, AI Provider, 알림, 첫 실행 완료 상태 표시
- AI 기능
  - `RuleBasedAIProvider` 기반 추천 업무
  - 지난 마감 업무 찾기
  - 예정 업무 찾기
  - 업무 요약 문자열 생성

## 3. 현재 구조의 문제점

- `src/App.tsx`가 약 700줄 규모로 커졌다.
- `App.tsx` 안에 탭 화면, 폼 상태, 편집 상태, 필터/정렬, CRUD 핸들러가 모두 들어 있다.
- `useState`가 많아 기능 추가 시 상태 관리가 더 복잡해질 수 있다.
- 날짜 계산 로직이 `App.tsx`와 `RuleBasedAIProvider`에 중복되어 있다.
- `README.md`가 아직 Vite 기본 템플릿 문서 상태다.
- `memory-bank` 문서 일부는 현재 구현 상태와 어긋날 수 있다.
- DB schema migration 전략이 아직 없다.
- 에러/로딩 상태 처리가 부족하다.
- 테스트 파일과 자동 검증 흐름이 아직 정리되어 있지 않다.

## 4. 단기 개발 목표

1. 현재 구현 상태에 맞게 README와 내부 문서를 정리한다.
2. `src/App.tsx` 분리 계획을 세운다.
3. 기능 추가 전 현재 빌드 상태를 확인한다.
4. `TodayView`, `TasksView`, `ProjectsView`, `SettingsView` 분리 후보를 검토한다.
5. 업무 추가/수정 폼과 프로젝트 추가/수정 폼의 중복을 줄인다.
6. 날짜 계산과 추천 업무 계산의 중복을 정리한다.
7. 설정 화면을 단순 표시에서 실제 설정 편집 화면으로 확장할지 결정한다.

## 5. 중기 개발 목표

- 프로젝트별 업무 보기 개선
- 업무 상태를 `todo`, `in_progress`, `done` 전체로 자연스럽게 조작하는 UI 추가
- 태그 입력 및 필터 기능 추가
- 예상 소요 시간 입력/표시 기능 개선
- 업무 정렬 옵션 확장
- RuleBasedAIProvider 추천 기준 개선
- 데이터 내보내기/가져오기 기능 검토
- IndexedDB 데이터 백업 전략 검토
- 접근성 및 키보드 조작성 개선

## 6. 리팩터링 계획

- 1단계: `App.tsx`에서 화면 컴포넌트 분리
  - `TodayView`
  - `TasksView`
  - `ProjectsView`
  - `SettingsView`
- 2단계: 폼 컴포넌트 분리
  - `TaskForm`
  - `ProjectForm`
- 3단계: 반복 표시 컴포넌트 분리
  - `TaskCard`
  - `ProjectCard`
  - summary 표시 컴포넌트
- 4단계: 파생 데이터 로직 분리
  - overdue tasks
  - upcoming tasks
  - filtered tasks
  - sorted tasks
  - project stats
- 5단계: 라벨 매핑 분리
  - priority label
  - status label
  - settings label

## 7. 데이터/DB 개선 계획

- Dexie schema 변경 전 migration 계획을 작성한다.
- `dueDate` 기반 조회가 많으므로 인덱스 추가가 필요한지 검토한다.
- 프로젝트 삭제 시 관련 업무 처리 정책을 명확히 한다.
- 업무가 없는 프로젝트만 삭제하는 현재 UI 정책을 store/문서에서도 명확히 유지한다.
- `updateAppSettings`에서 `updatedAt` 갱신이 필요한지 검토한다.
- settings의 `firstLaunchCompleted` 사용 시점을 정의한다.
- 날짜 값은 `YYYY-MM-DD` 문자열로 유지할지, 별도 날짜 유틸을 둘지 결정한다.
- future schema version 추가 시 기존 IndexedDB 데이터 보존을 우선한다.

## 8. 테스트/검증 계획

- 변경 허용 시 기본 검증은 `npm run build`로 한다.
- lint 실행은 사용자 허용 후 `npm run lint`로 한다.
- 테스트 도구 도입 전까지는 핵심 시나리오를 수동 체크리스트로 관리한다.
- 우선 검증해야 할 시나리오
  - 앱 초기 실행 시 기본 프로젝트 생성
  - 업무 추가
  - 업무 수정
  - 업무 삭제
  - 완료/미완료 토글
  - 프로젝트 추가
  - 프로젝트 수정
  - 기본 프로젝트 삭제 방지
  - 업무가 있는 프로젝트 삭제 방지
  - 오늘 화면 추천/지난 마감/예정 업무 표시
- 추후 테스트 도입 시 우선 대상
  - `RuleBasedAIProvider`
  - 날짜 계산 유틸
  - store CRUD 로직
  - 필터/정렬 selector

## 9. Android/Capacitor 전환 전 체크리스트

- 웹 MVP 핵심 기능 안정화
- `App.tsx` 분리 완료
- IndexedDB 저장 정책 확인
- 데이터 백업/복구 전략 검토
- Android WebView에서 IndexedDB 동작 확인 계획 수립
- 알림 기능 도입 여부 재검토
- Android notification 권한 요청 정책 결정
- 개인정보 처리 방향 문서화
- 오프라인 동작 검증
- 화면 크기별 모바일 UI 검증
- Google Play 등록에 필요한 앱 이름, 아이콘, 설명, 개인정보처리방침 준비

## 10. 다음 작업 우선순위

1. 현재 문서와 코드 상태 동기화
2. 현재 빌드 가능 여부 확인
3. `App.tsx` 분리 설계
4. `TodayView` 또는 `TasksView`부터 작은 단위로 분리
5. 날짜 계산 로직 중복 제거
6. 업무/프로젝트 폼 컴포넌트 분리
7. 설정 편집 기능 추가 여부 결정
8. DB migration 규칙 문서화
9. RuleBasedAIProvider 개선
10. Android/Capacitor 전환 준비 문서 작성
