# PlanPilot Local JSON 가져오기/복원 정책

이 문서는 PlanPilot Local의 JSON 백업 파일을 가져오거나 복원하기 전에 따라야 할 정책을 정리한다.

현재 문서는 정책 문서이며, JSON import, 파일 선택 UI, 복원, 덮어쓰기, 병합 기능은 아직 구현하지 않는다.

## 목표

- 사용자의 IndexedDB 데이터를 손상시키지 않는 복원 절차를 먼저 정의한다.
- JSON export 1차 구조와 호환되는 파일만 가져오기 후보로 본다.
- 실제 DB 반영 전 검증, 미리보기, 확인 절차를 분리한다.
- 서버 API, `localStorage`, 로그인, 클라우드 동기화 없이 로컬 파일만 다룬다.

## 가져오기/복원 대상 데이터

지원 후보 데이터는 현재 JSON export 1차 구조와 동일하게 제한한다.

- `tasks`
- `projects`
- `appSettings`

다른 데이터는 현재 schema에 없으므로 가져오기 대상에 포함하지 않는다.

## 지원할 백업 파일 형식

1차 지원 후보는 PlanPilot Local이 직접 내보낸 JSON 파일이다.

필수 최상위 필드:

- `format: "planpilot-local-backup"`
- `schemaVersion: 1`
- `exportedAt`
- `tasks`
- `projects`
- `appSettings`

정책:

- `format`이 다르면 가져오기를 중단한다.
- `schemaVersion`이 지원 범위가 아니면 가져오기를 중단한다.
- `tasks`와 `projects`는 배열이어야 한다.
- `appSettings`는 객체여야 한다.
- 알 수 없는 최상위 필드는 1차 구현에서 무시하는 후보로 두되, 사용자에게 호환성 주의 문구를 표시할지 별도 검토한다.

## 복원 방식 후보 비교

### 전체 덮어쓰기

기존 `tasks`, `projects`, `appSettings`를 백업 파일 내용으로 교체한다.

장점:

- 중복 ID 충돌을 가장 단순하게 처리할 수 있다.
- 백업 파일 상태를 그대로 되살리는 목적에 맞다.
- 병합보다 검증과 수동 테스트 범위가 작다.

위험:

- 현재 데이터가 사라질 수 있다.
- 취소/실패/부분 실패 시 기존 데이터 보존 기준이 반드시 필요하다.
- 사용자가 영향 범위를 충분히 이해해야 한다.

### 병합

기존 데이터와 백업 파일 데이터를 합친다.

장점:

- 현재 데이터와 백업 데이터를 함께 유지할 수 있다.

위험:

- 중복 ID 처리 정책이 복잡하다.
- 프로젝트 참조 무결성, 충돌 우선순위, 기존 데이터와 백업 데이터의 생성/수정 시각 의미가 흔들릴 수 있다.
- 업무 중복 생성이나 프로젝트 통계 회귀 위험이 크다.

### 선택적 복원

업무, 프로젝트, 설정 중 일부만 선택해 복원한다.

장점:

- 사용자가 필요한 데이터만 되돌릴 수 있다.

위험:

- task와 project 참조 관계가 깨질 수 있다.
- `appSettings`만 복원할 때 내부 상태가 사용자 기대와 다르게 바뀔 수 있다.
- UI와 수동 테스트 범위가 커진다.

## 현재 우선 제안

1차 구현은 실제 DB 반영 없이 `검증만` 또는 `미리보기만` 수행하는 단계로 시작한다.

권장 순서:

1. JSON 파일을 읽고 구조를 검증한다.
2. 검증 결과와 영향 범위를 미리보기로 보여준다.
3. 실제 DB 반영은 별도 작업으로 분리한다.
4. 실제 복원을 구현할 때는 병합보다 전체 덮어쓰기를 먼저 검토한다.
5. 병합 복원은 1차 복원이 안정화된 뒤 별도 정책으로 다룬다.

## 데이터 검증 기준

파일 수준 검증:

- JSON 파싱이 가능해야 한다.
- 최상위 값은 객체여야 한다.
- `format`은 `"planpilot-local-backup"`이어야 한다.
- `schemaVersion`은 `1`이어야 한다.
- `exportedAt`은 비어 있지 않은 문자열이어야 한다.
- `tasks`는 배열이어야 한다.
- `projects`는 배열이어야 한다.
- `appSettings`는 객체여야 한다.

task 검증:

- 필수 필드: `id`, `title`, `priority`, `status`, `projectId`, `tags`, `createdAt`, `updatedAt`
- `id`, `title`, `projectId`, `createdAt`, `updatedAt`은 문자열이어야 한다.
- `priority`는 `low`, `medium`, `high` 중 하나여야 한다.
- `status`는 `todo`, `in_progress`, `done` 중 하나여야 한다.
- `tags`는 배열이어야 한다.
- `dueDate`, `completedAt`이 있으면 문자열이어야 한다.
- 날짜 문자열은 ISO-8601 또는 현재 앱이 사용하는 `YYYY-MM-DD` 계열 문자열로 검토한다.
- `task.projectId`는 가져오기 파일 안의 `projects` 중 하나를 참조해야 한다.

project 검증:

- 필수 필드: `id`, `name`, `createdAt`, `updatedAt`
- `id`, `name`, `createdAt`, `updatedAt`은 문자열이어야 한다.
- `description`, `color`, `archivedAt`이 있으면 문자열이어야 한다.
- `default` 프로젝트가 없으면 가져오기를 중단하거나 기본 프로젝트 보정 정책을 먼저 확정해야 한다.

appSettings 검증:

- 필수 필드: `theme`, `language`, `aiProvider`, `enableNotifications`, `firstLaunchCompleted`, `createdAt`, `updatedAt`
- 현재 허용 값은 `theme: "light"`, `language: "ko"`, `aiProvider: "rule_based"`, `enableNotifications: false`다.
- `firstLaunchCompleted`는 boolean이어야 한다.
- `createdAt`, `updatedAt`은 문자열이어야 한다.

## 중복 ID 처리 정책

전체 덮어쓰기 후보:

- 기존 데이터와 백업 파일 사이의 중복 ID는 문제가 되지 않는다.
- 백업 파일 내부에서 task id 또는 project id가 중복되면 가져오기를 중단한다.

병합 후보:

- skip: 기존 ID가 있으면 백업 항목을 건너뛴다.
- replace: 기존 ID가 있으면 백업 항목으로 교체한다.
- new id: 백업 항목에 새 ID를 부여한다.

현재 제안:

- 1차 복원에서는 병합을 구현하지 않는다.
- 병합을 도입해야 한다면 먼저 중복 ID 정책을 별도 문서로 확정한다.
- 안전한 기본값은 중복 ID 발견 시 가져오기를 중단하고 사용자에게 이유를 표시하는 것이다.

## 기존 데이터 보호 정책

- 파일 선택 후 즉시 DB에 반영하지 않는다.
- 검증 실패 시 기존 IndexedDB 데이터는 변경하지 않는다.
- 사용자가 취소하면 기존 IndexedDB 데이터는 변경하지 않는다.
- 복원 실행 전 현재 데이터를 JSON으로 다시 내보내도록 안내하거나 자동 백업을 제공할지 결정해야 한다.
- 실제 복원 구현 전에는 복원 실패 시 기존 데이터 유지 또는 rollback 기준을 확정해야 한다.
- 부분 복원 실패가 발생할 수 있는 구조라면 transaction 또는 전체 rollback 전략이 필요하다.

## appSettings 처리 기준

`appSettings`는 백업 파일 검증 대상에 포함한다.

복원 시 처리 후보:

- 백업 파일의 `appSettings`로 덮어쓴다.
- 현재 사용자 설정을 유지하고 `tasks`, `projects`만 복원한다.
- 사용자가 설정 복원 여부를 선택한다.

현재 제안:

- 1차 검증/미리보기 단계에서는 `appSettings`를 포함해 검증한다.
- 실제 DB 반영 단계에서는 설정 덮어쓰기 여부를 사용자 확인 문구에 포함한다.
- `createdAt`은 백업 원본을 유지하는 후보로 둔다.
- `updatedAt`은 백업 원본 유지와 복원 시각 갱신 중 하나를 별도 확정한다.
- `firstLaunchCompleted`는 내부 onboarding 상태에 가까우므로 덮어쓰기 전 영향 범위를 명확히 표시한다.

## UX/안전장치

- 파일 선택 후 즉시 복원하지 않는다.
- 검증 결과를 먼저 표시한다.
- 가져올 업무 수, 프로젝트 수, 설정 포함 여부를 미리보기로 보여준다.
- 전체 덮어쓰기 복원이라면 “현재 데이터를 덮어씁니다” 확인 문구를 표시한다.
- 되돌리기 어렵다는 안내를 표시한다.
- 가져오기 취소가 가능해야 한다.
- 복원 전 현재 데이터 백업을 권장하거나 자동 백업을 제공할지 결정한다.
- 실패 원인은 가능한 범위에서 짧게 표시하되, 서버 전송이나 클라우드 복원으로 오해되지 않게 한다.

## 보류/중단 조건

다음 조건이 생기면 구현을 중단하고 정책을 먼저 보강한다.

- DB schema 변경이 필요하다.
- 기존 IndexedDB migration이 필요하다.
- rollback 정책이 정해지지 않았다.
- 중복 ID 정책이 정해지지 않았다.
- `appSettings` 덮어쓰기 정책이 정해지지 않았다.
- project 참조 무결성 보정 정책이 정해지지 않았다.
- `App.css` 대규모 수정이 필요하다.
- 서버 API, `localStorage`, 로그인, 클라우드 동기화, 알림 권한 요청, Capacitor가 필요해진다.

## 수동 테스트 항목 후보

- 정상 백업 파일을 선택하면 검증이 통과한다.
- 잘못된 JSON 파일을 선택하면 검증에 실패하고 기존 데이터가 유지된다.
- `format`이 다른 파일은 거부된다.
- 지원하지 않는 `schemaVersion` 파일은 거부된다.
- `tasks`, `projects`, `appSettings`가 빠진 파일은 거부된다.
- 필수 필드가 빠진 task/project/settings 항목은 거부된다.
- 허용되지 않는 `status` 또는 `priority` 값이 있으면 거부된다.
- 존재하지 않는 project를 참조하는 task가 있으면 거부된다.
- 가져오기 취소 시 기존 데이터가 유지된다.
- 검증 실패 시 기존 데이터가 유지된다.
- 실제 복원 구현 후에는 새로고침해도 복원된 데이터가 유지된다.
- 구현 후에도 서버 API, `localStorage`, 로그인, 클라우드 동기화, 알림 권한 요청, Capacitor가 추가되지 않는다.

## 다음 단계 제안

1. import/복원 정책 문서화
2. import 파일 검증 유틸만 구현
3. 검증 결과 미리보기 UI 구현
4. 전체 덮어쓰기 복원 구현
5. 병합 복원은 이후 별도 검토
