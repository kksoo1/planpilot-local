# AI Dev Loop Log

## 2026-06-03 22:50:39 - T001 analysis completed

- Task: T001 기존 백업 export/import 관련 문서와 코드 위치 확인
- 백업 export 정책과 구현 위치:
  - `docs/data-backup-export-policy.md`
  - `src/utils/exportData.ts`
  - `src/views/SettingsView.tsx`
- JSON import/복원 정책과 수동 확인 기준 위치:
  - `docs/data-import-restore-policy.md`
  - `docs/manual-test-checklist.md`
- 기존 검증 유틸 확인:
  - `src/utils/importValidation.ts`에 `validateBackupData(input: unknown)` 순수 검증 함수가 이미 존재한다.
  - 이 함수는 백업 메타데이터, task/project/appSettings 필드, 중복 ID, project 참조 무결성, 요약 개수를 검증한다.
  - store, db, IndexedDB 쓰기 경로를 사용하지 않는다.
- 설정 화면 연결 지점 확인:
  - `SettingsView`는 현재 JSON export UI를 담당하며 `tasks`, `projects`, `appSettings`를 이미 props로 받는다.
  - `App.tsx`는 이 세 값을 `SettingsView`에 전달하고 있으므로, 검증/미리보기 UI는 설정 화면 내부의 로컬 상태로 연결할 수 있다.
- DB 비반영 범위 확인:
  - `.ai-dev/goal.md`와 `docs/data-import-restore-policy.md`는 실제 DB 반영, 복원, 덮어쓰기, 병합을 현재 goal 범위에서 제외한다.
  - `src/store.ts`와 `src/db.ts`는 이번 goal에서 수정할 필요가 없다.
- Result: T001 분석 완료. 앱 코드와 데이터는 변경하지 않았다.
