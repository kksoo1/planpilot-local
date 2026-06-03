# AI Dev Plan

## Goal

JSON 백업 파일을 실제로 복원하지 않고, 파일 검증과 미리보기까지만 제공한다.

## Scope Guard

- 실제 IndexedDB 반영, 복원, 덮어쓰기, 병합은 구현하지 않는다.
- `src/store.ts`, `src/db.ts`, DB schema는 수정하지 않는다.
- 지원 형식은 `format: "planpilot-local-backup"`, `schemaVersion: 1`로 제한한다.
- 파일 선택 후 검증 결과를 먼저 보여주며 사용자 데이터를 변경하지 않는다.

## 확인된 기존 구조

- 백업 export 정책: `docs/data-backup-export-policy.md`
- import/복원 정책: `docs/data-import-restore-policy.md`
- export 구현: `src/utils/exportData.ts`
- 기존 순수 검증 유틸: `src/utils/importValidation.ts`
- 설정 화면 연결 지점: `src/views/SettingsView.tsx`
- 설정 화면 props 조립: `src/App.tsx`
- 수동 확인 기준: `docs/manual-test-checklist.md`

## Follow-up Tasks

### T002 기존 백업 JSON 검증 유틸 확인

- `src/utils/importValidation.ts`의 `validateBackupData(input: unknown)`가 이미 존재한다.
- 신규 유틸을 중복 구현하지 않고 현재 goal의 필수 검증과 요약 요구사항을 충족하는지 먼저 확인한다.
- 부족한 검증이 있을 때만 현재 task 범위에서 최소 수정한다.
- 검증 유틸은 store, db, IndexedDB 쓰기 경로를 사용하지 않아야 한다.

### T003 import 미리보기 UI 추가

- 주 연결 위치는 `src/views/SettingsView.tsx`다.
- `SettingsView`는 이미 `tasks`, `projects`, `appSettings`를 받고 있으므로 `App.tsx` 변경은 필요하지 않을 가능성이 높다.
- 파일 선택, JSON 파싱, 검증 함수 호출, 로컬 미리보기 상태만 추가한다.
- 파일 선택 후에도 DB 데이터는 변경하지 않는다.

### T004 검증 실패 메시지와 성공 요약 표시

- `src/views/SettingsView.tsx`에서 검증 실패 이유를 짧게 표시한다.
- 성공 시 tasks 개수, projects 개수, appSettings 포함 여부를 표시한다.
- 복원 버튼, 덮어쓰기 확인, 병합 UI는 추가하지 않는다.

### T005 수동검증 체크리스트 업데이트

- `docs/manual-test-checklist.md`에 정상 파일, 잘못된 JSON, format/schemaVersion 불일치, 필수 필드 누락, 참조 무결성, DB 비변경 확인 항목을 현재 구현과 맞게 정리한다.
- 문서에서 import/복원이 구현된 것으로 표현하지 않는다.

### T006 빌드 검증 및 최종 요약

- `npm run build`를 실행한다.
- 전체 diff에서 DB 반영, 복원, 덮어쓰기, 병합 기능이 추가되지 않았는지 확인한다.
- 현재 goal 범위를 벗어난 수정이 없는지 리뷰한다.

## Stop Conditions

- 실제 DB 쓰기 또는 사용자 데이터 변경이 필요해지는 경우
- 복원, 덮어쓰기, 병합 정책 구현이 요구되는 경우
- DB schema 변경이나 migration이 필요한 경우
- package 추가 또는 대규모 UI 개편이 필요한 경우
