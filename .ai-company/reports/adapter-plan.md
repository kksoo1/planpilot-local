# 기존 AI Dev 연결 경계 문서

## 목적

이 문서는 AI Software Company 운영 상태 모델에서 만들어진 내부 작업을 기존 PlanPilot AI Dev Goal/Task 실행 흐름으로 넘기는 어댑터의 책임과 검증 게이트를 정의한다.

어댑터는 회사 운영 상태와 기존 AI Dev 실행 상태를 연결하는 경계 계층이다. 어댑터는 기존 `.ai-dev/` 큐, 실행 상태, 검증, 리뷰, recovery, commit 안전장치를 대체하거나 중복 구현하지 않는다.

## 상태 소유권

회사 운영 상태와 AI Dev 실행 상태는 서로 다른 디렉터리와 책임을 가진다.

`.ai-company/`가 소유하는 상태:

- 고객 의뢰 원문과 정리된 제품 요구사항
- 회사 프로젝트 생명주기 상태
- CEO/Product/CTO/Developer/QA 역할 상태
- 고객 의사결정 필요 여부와 선택지
- 고객에게 보여줄 납품 준비 상태와 요약 이벤트
- 회사 운영 이벤트 로그

`.ai-dev/`가 소유하는 상태:

- AI Dev Goal
- AI Dev Task 큐와 현재 task
- Codex 실행 상태
- build/test/lint/review 결과
- task 단위 recovery 상태
- scoped commit 상태
- baseline, package, expected non-work 보호 기록

어댑터는 두 상태를 같은 파일이나 같은 모델로 병합하지 않는다. PlanPilot 제품 UI 상태, React 상태, IndexedDB 데이터와도 섞지 않는다.

## 내부 Task 생성 경계

CEO/Product/CTO/Project 단계에서 내부 task가 AI Dev로 전달되려면 다음 조건이 충족되어야 한다.

- `CEO`: 고객 의도, 우선순위, 범위 제한, 고객 결정 필요 여부가 정리되어야 한다.
- `Product`: 제품 수준 objective, acceptance criteria, 고객-facing 변경 요약 기준이 있어야 한다.
- `CTO`: 예상 변경 범위, 기존 AI Dev 안전장치 유지 여부, 금지 작업 여부가 확인되어야 한다.
- `Project`: 한 번에 하나의 AI Dev task로 처리 가능한 작은 작업으로 분해되어야 한다.

어느 단계든 `blocked` 상태이면 새 AI Dev task를 생성하지 않는다. 고객 결정이 필요한 경우에는 회사 상태에 decision record를 남기고, 고객에게는 제품 수준 선택지만 제시한다.

단계별 산출물은 다음 경계를 넘지 않는다.

- `CEO` 산출물은 고객 목표, 우선순위, 범위 판단, 고객 결정 필요 여부까지로 제한한다.
- `Product` 산출물은 제품 요구사항, acceptance criteria, 고객 검수 기준까지로 제한한다.
- `CTO` 산출물은 기술 영향 범위, 허용 파일 후보, 금지 명령 및 안전장치 유지 확인까지로 제한한다.
- `Project` 산출물은 AI Dev에 넘길 단일 task 후보와 검증 계획까지로 제한한다.

이 단계들은 `.ai-dev/queue.json`을 직접 편집하거나 AI Dev 실행 결과를 임의로 성공 처리하지 않는다. 내부 task가 아직 제품 수준 acceptance criteria와 연결되지 않았으면 handoff 대상이 아니라 회사 planning 상태에 남긴다.

## 어댑터 책임

Company -> AI Dev 어댑터의 책임은 다음으로 제한한다.

- 회사 프로젝트와 내부 task를 기존 AI Dev Goal/Task 입력으로 변환한다.
- company project ID와 AI Dev goal/task ID의 매핑을 저장한다.
- 제품 objective, project brief, acceptance criteria를 task 입력에 포함한다.
- `task type`, `priority`, 예상 변경 파일, 허용 파일, 범위 제외 항목을 전달한다.
- repository safety rules와 task별 검증 방법을 handoff payload에 포함한다.
- 고객 의사결정 dependency가 있으면 AI Dev task 생성 여부를 차단하거나 보류한다.
- AI Dev 실행 결과를 회사 상태와 고객-facing 이벤트로 요약한다.

어댑터는 내부 task를 전달하기 전에 다음 값을 명확히 보존해야 한다.

- 회사 프로젝트 ID와 내부 task ID
- 고객-facing objective와 acceptance criteria
- 이번 task에서 허용된 변경 범위와 범위 제외 항목
- 기존 AI Dev 안전 규칙과 수동 검증 조건
- 실패 시 기존 AI Dev recovery 상태를 참조할 수 있는 매핑 키

어댑터가 직접 수행하지 않는 일:

- build/test/lint/review/recovery/commit 실행
- `.ai-dev/queue.json` 또는 `.ai-dev/state.json` 우회 수정
- 기존 자동개발 스크립트 재구현
- task 크기 제한, baseline 보호, package 변경 보호 약화
- 고객에게 내부 구현 세부사항 질의

## Handoff 차단 조건

다음 중 하나라도 해당하면 어댑터는 AI Dev task 생성을 보류하고 회사 프로젝트 또는 내부 task를 `blocked`로 표시한다.

- 고객이 제품 목표, 범위, 우선순위, 납품 승인 중 하나를 결정해야 한다.
- task가 둘 이상의 독립 기능을 포함해 one-task-at-a-time 제한을 위반한다.
- 허용 파일 또는 예상 변경 파일 범위가 불명확하다.
- package 추가, 외부 서비스 연동, 로그인, 클라우드 동기화, 알림, 모바일 권한처럼 현재 정책에서 제외된 작업이 필요하다.
- 기존 build/test/lint/review/recovery 안전장치를 우회해야만 진행할 수 있다.
- 고객 baseline 변경을 덮어쓰거나 복구할 위험이 있다.

차단 사유는 고객 포털에 raw 오류로 표시하지 않는다. 회사 내부 상태에는 구체 사유를 남기고, 고객에게는 필요한 제품 수준 결정만 요약한다.

## Handoff Payload

AI Dev로 넘기는 최소 입력은 다음 필드를 포함해야 한다.

- `companyProjectId`
- `companyInternalTaskId`
- `objective`
- `projectBrief`
- `acceptanceCriteria`
- `taskType`
- `priority`
- `allowedFiles`
- `expectedChangeFiles`
- `outOfScope`
- `verificationPlan`
- `repositorySafetyRules`
- `customerDecisionDependency`

AI Dev 실행 결과를 회사 상태로 되돌릴 때의 최소 출력은 다음 필드를 포함해야 한다.

- `aiDevGoalId`
- `aiDevTaskId`
- `executionStatusSummary`
- `verificationSummary`
- `reviewSummary`
- `recoverySummary`
- `commitSummary`
- `customerFacingChangeSummary`
- `remainingRisks`
- `customerDecisionNeeded`

결과 payload는 AI Dev 로그의 원문 복사본이 아니라 회사 상태 전이를 판단할 수 있는 요약이어야 한다. raw command output, stack trace, 내부 경로 목록은 내부 진단용으로만 참조하고 고객-facing record에는 필요한 의미만 변환해 기록한다.

## 호출 순서

기본 흐름은 다음 순서를 따른다.

1. 회사 상태에 고객 의뢰와 프로젝트 상태를 기록한다.
2. CEO/Product/CTO/Project 단계가 제품 수준 요구사항과 작은 내부 task를 확정한다.
3. 어댑터가 내부 task를 AI Dev Goal/Task 입력으로 변환한다.
4. 어댑터가 company project ID와 AI Dev goal/task ID 매핑을 저장한다.
5. 기존 AI Dev 엔진이 한 번에 하나의 current task를 실행한다.
6. 기존 AI Dev 엔진이 검증, 리뷰, recovery, commit 상태를 기록한다.
7. 어댑터가 AI Dev 결과를 회사 이벤트와 납품 상태 요약으로 변환한다.
8. CEO Delivery Review가 고객 요구사항 충족 여부와 고객 검수 가능 여부를 판단한다.

## 검증 게이트

Company planning에서 AI Dev execution으로 넘어가기 전에는 다음을 확인한다.

- task가 한 번에 하나의 AI Dev task로 처리될 만큼 작다.
- acceptance criteria가 제품 수준으로 명확하다.
- 예상 변경 파일 또는 허용 파일 범위가 제한되어 있다.
- repository safety rules가 handoff payload에 포함되어 있다.
- 고객 결정 dependency가 없거나 blocking 상태로 표시되어 있다.
- 외부 서비스, 로그인, 클라우드 동기화, 알림, 모바일 권한, package 추가가 요구되지 않는다.

`qa_review`에서 납품 준비로 넘어가기 전에는 다음을 확인한다.

- 구현이 완료되었거나 미완료 사유가 명시되어 있다.
- QA 결과가 통과했거나 실행하지 못한 이유가 기록되어 있다.
- Review 결과가 통과했거나 남은 위험이 기록되어 있다.
- 기존 회귀 안전장치를 건너뛰거나 대체하지 않았다.
- 고객-facing delivery record에 변경 요약, 검증 결과, 남은 위험이 포함되어 있다.

QA와 Review가 통과하기 전에는 `delivery_preparation`, `ready_for_customer`, `customer_acceptance`로 이동하지 않는다. `development`에서 고객 검수 상태로 직접 이동하는 것도 금지한다.

AI Dev 결과 수신 후에는 다음 전이 규칙을 적용한다.

- 구현이 완료되고 QA/Review가 통과하면 `qa_review`에서 `delivery_preparation`으로 이동할 수 있다.
- 구현은 완료되었지만 QA 또는 Review가 미실행이면 `delivery_preparation`으로 이동하지 않고 `qa_pending` 요약을 남긴다.
- QA 또는 Review가 실패하면 기존 AI Dev 실패 사유와 recovery 요약을 참조해 `development`, `planning`, 또는 `paused` 중 하나로 되돌린다.
- 고객 제품 결정이 필요한 실패만 `customer_decision_needed`로 표시한다.
- AI Dev task가 실패했더라도 회사 상태에서 새 task를 자동 생성하지 않는다.

## Recovery 경계

Company 모델은 recovery 실행기를 새로 만들지 않는다. 기존 AI Dev task 단위 recovery 상태와 제한을 재사용한다.

Company가 저장하는 recovery 정보는 요약으로 제한한다.

- 실패한 AI Dev task ID
- 기존 AI Dev state record의 실패 사유
- 마지막으로 완료된 안전 단계
- 다음 조치가 retry, task split, requirement clarification, pause 중 무엇인지
- 문제가 내부 개발 사항인지 고객 제품 의사결정인지 여부

Recovery는 기존 one-task-at-a-time 제한을 유지한다. task split이 필요하면 다음 사이클에서 처리 가능한 가장 작은 task 하나만 queue에 넣는 방향으로 기록한다.

AI Dev가 `blocked` 또는 `stopped`를 보고해도 Company는 자동으로 고객 결정 대기로 바꾸지 않는다. 기술적 자동복구가 가능한 실패는 내부 처리 상태로 남기고, 제품 방향, 범위, 우선순위, 요구사항 해석이 필요한 경우에만 `customer_decision_needed`로 요약한다.

## Resume 원칙

Supervisor 또는 회사 운영 GUI가 재시작되면 company project ID와 AI Dev goal/task ID 매핑으로 기존 작업을 복원한다.

Resume 시에는 새로운 검증, 리뷰, commit 상태를 임의로 만들지 않는다. 기존 AI Dev current/stale 판정과 state record를 읽어 이어갈 단계만 판단한다. 매핑이 없거나 손상되어 올바른 AI Dev task를 찾을 수 없으면 새 task를 만들지 않고 Company project를 `blocked`로 둔다.

## 고객 포털 표시 원칙

고객 포털은 raw command output, stack trace, 내부 로그를 기본 표시하지 않는다. 고객에게는 다음처럼 요약된 회사 이벤트를 우선 표시한다.

- `request_received`: 요청 접수
- `requirements_clarified`: 요구사항 정리 완료
- `planning_started`: 계획 시작
- `development_in_progress`: 개발 진행 중
- `qa_in_progress`: QA 진행 중
- `delivery_ready_for_review`: 납품 검수 준비
- `customer_decision_needed`: 고객 의사결정 필요
- `changes_requested`: 보완 요청
- `accepted`: 승인 완료

내부 실패 정보는 고객에게 `검증 상태`, `실패 원인 요약`, `남은 위험`, `필요한 고객 결정`으로 변환해 보여준다. 파일 분리 방식, 테스트 명령 선택, 코드 스타일, 내부 recovery 단계 같은 개발 세부사항은 고객 의사결정 항목으로 노출하지 않는다.

## 금지 사항

어댑터는 다음을 수행하면 안 된다.

- 구현 단계를 직접 실행한다.
- 기존 `.ai-dev/` 자동개발 안전장치를 우회한다.
- build, lint, test, review, recovery, commit 로직을 중복 구현한다.
- 기존 AI Dev task 크기 제한을 완화한다.
- Company 상태와 AI Dev 상태를 같은 파일에 저장한다.
- 고객 baseline 변경을 덮어쓴다.
- 고객에게 내부 구현 세부사항 결정을 요구한다.
- QA/Review 통과 또는 미실행 사유 기록 없이 납품 준비 상태로 이동한다.

## 로컬 상태 정책

어댑터 관련 회사 상태는 `.ai-company/` 아래에 UTF-8 JSON 또는 append-only JSONL로 저장한다. PowerShell 5.1에서 읽고 쓸 수 있는 단순 파일 형식을 유지하며, 외부 서비스 연동, 클라우드 동기화, 로그인, 알림, 모바일 권한 흐름은 추가하지 않는다.
