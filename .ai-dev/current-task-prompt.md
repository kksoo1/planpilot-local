# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# Goal

JSON 백업 파일 import 시 실제 복원은 하지 않고, 파일 검증과 미리보기까지만 제공하는 기능을 추가한다.

## Background

PlanPilot Local은 `tasks`, `projects`, `appSettings`를 포함한 JSON 백업 파일을 내보낼 수 있다.

현재 JSON import/복원 정책과 순수 검증 유틸은 준비되어 있지만, 사용자가 파일을 선택하고 검증 결과를 확인할 수 있는 흐름은 아직 없다.

데이터 손상 위험을 줄이기 위해 실제 IndexedDB 반영보다 파일 검증과 영향 범위 미리보기를 먼저 제공한다.

## Success Criteria

- 사용자가 PlanPilot Local JSON 백업 파일을 선택할 수 있다.
- `format`이 `planpilot-local-backup`인지 확인한다.
- `schemaVersion`이 `1`인지 확인한다.
- `exportedAt`, `tasks`, `projects`, `appSettings` 필수 항목을 확인한다.
- 검증 실패 시 사용자에게 실패 이유를 표시한다.
- 검증 성공 시 `tasks` 개수, `projects` 개수, `appSettings` 포함 여부를 표시한다.
- 파일 검증과 미리보기 과정에서 IndexedDB 데이터는 변경되지 않는다.
- `docs/manual-test-checklist.md`에 검증과 미리보기 수동 테스트 항목을 반영한다.
- `npm run build`가 성공한다.

## Constraints

- 실제 DB 반영을 하지 않는다.
- 복원, 덮어쓰기, 병합을 구현하지 않는다.
- `format`은 `planpilot-local-backup`만 허용한다.
- `schemaVersion`은 `1`만 허용한다.
- `exportedAt`, `tasks`, `projects`, `appSettings`를 필수로 확인한다.
- 검증 실패 이유를 사용자에게 표시한다.
- 검증 성공 시 데이터 개수와 설정 포함 여부를 표시한다.
- 서버 API, `localStorage`, 로그인, 클라우드 동기화를 추가하지 않는다.
- DB schema를 변경하지 않는다.
- `App.css`를 수정하지 않는다.
- 현재 task 범위 밖 파일을 수정하지 않는다.

## Out of Scope

- JSON 백업 데이터를 IndexedDB에 저장하는 기능
- 전체 덮어쓰기 복원
- 기존 데이터와의 병합
- 중복 ID 자동 수정
- 프로젝트 참조 자동 복구
- appSettings 자동 덮어쓰기
- 복원 전 자동 백업
- JSON export 구조 변경

## Manual Verification

- 정상 백업 파일을 선택하면 검증 성공 상태가 표시된다.
- 정상 백업 파일의 `tasks`와 `projects` 개수가 표시된다.
- 정상 백업 파일에 `appSettings`가 포함되어 있는지 표시된다.
- 잘못된 JSON 파일을 선택하면 검증 실패 이유가 표시된다.
- `format`이 다른 파일은 거부된다.
- `schemaVersion`이 `1`이 아닌 파일은 거부된다.
- 필수 항목이 누락된 파일은 거부된다.
- 파일을 선택하거나 검증한 뒤에도 기존 업무, 프로젝트, 설정 데이터가 유지된다.
- `npm run build`가 성공한다.


## Current Task

- Task ID: T001
- Title: 기존 백업 export/import 관련 문서와 코드 위치 확인
- Description: JSON 백업 구조, import 정책, 기존 검증 유틸, SettingsView 연결 지점을 확인하고 구현 범위를 확정한다.
- Type: analysis
- Status: pending
- Priority: P0
- Depends on:
- 없음

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

- 없음

## Verification

- 관련 문서와 코드 위치 확인
- 실제 DB 반영이 범위에서 제외되었는지 확인

- 필요한 경우 `npm run build`는 사람이 별도로 실행한다.
- 이 프롬프트는 자동으로 build, test, lint를 실행하라고 지시하지 않는다.

## Required Output

- 변경한 파일 목록
- 구현 또는 분석 내용 요약
- 검증 방법
- 남은 위험
- 다음 task로 넘어가도 되는지 여부
- `.ai-dev/loop-log.md`에 기록할 작업 요약

## Hard Rules

- `src` 외 파일을 수정해야 하는 경우 이유를 기록한다.
- `package.json`과 `package-lock.json`은 수정하지 않는다. 꼭 필요하면 중단하고 이유만 기록한다.
- 실제 DB 삭제 또는 초기화를 하지 않는다.
- 사용자 데이터 복원 또는 덮어쓰기를 하지 않는다.
- 현재 task와 무관한 UI 전면 개편을 하지 않는다.
- 대규모 리팩터링을 하지 않는다.
- git commit을 실행하지 않는다.
- git reset, git checkout, git clean을 실행하지 않는다.
- npm install을 실행하지 않는다.

## Stop Conditions

- 요구사항이 충돌하는 경우
- 현재 task 범위 밖 수정이 필요한 경우
- 패키지 추가가 필요한 경우
- 데이터 삭제 또는 마이그레이션이 필요한 경우
- 같은 오류가 반복되는 경우