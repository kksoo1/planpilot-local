# AI Dev Diff

## Generated At

2026-08-10 15:36:39

## Git Status

```text
 M .ai-company/reports/adapter-plan.md
 M .ai-dev/codex-result.md
 M .ai-dev/codex-review-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/diff.md
 M .ai-dev/loop-log.md
 M .ai-dev/review-prompt.md
 M .ai-dev/review-response.json
 M .ai-dev/review.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
```

## App Change Files

- .ai-company/reports/adapter-plan.md

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/codex-review-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/diff.md
- .ai-dev/loop-log.md
- .ai-dev/review-prompt.md
- .ai-dev/review-response.json
- .ai-dev/review.md
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 .ai-company/reports/adapter-plan.md | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
```

## Unstaged Diff

```text
diff --git a/.ai-company/reports/adapter-plan.md b/.ai-company/reports/adapter-plan.md
index 0899f3d..7499e03 100644
--- a/.ai-company/reports/adapter-plan.md
+++ b/.ai-company/reports/adapter-plan.md
@@ -42,6 +42,15 @@ CEO/Product/CTO/Project 단계에서 내부 task가 AI Dev로 전달되려면 
 
 어느 단계든 `blocked` 상태이면 새 AI Dev task를 생성하지 않는다. 고객 결정이 필요한 경우에는 회사 상태에 decision record를 남기고, 고객에게는 제품 수준 선택지만 제시한다.
 
+단계별 산출물은 다음 경계를 넘지 않는다.
+
+- `CEO` 산출물은 고객 목표, 우선순위, 범위 판단, 고객 결정 필요 여부까지로 제한한다.
+- `Product` 산출물은 제품 요구사항, acceptance criteria, 고객 검수 기준까지로 제한한다.
+- `CTO` 산출물은 기술 영향 범위, 허용 파일 후보, 금지 명령 및 안전장치 유지 확인까지로 제한한다.
+- `Project` 산출물은 AI Dev에 넘길 단일 task 후보와 검증 계획까지로 제한한다.
+
+이 단계들은 `.ai-dev/queue.json`을 직접 편집하거나 AI Dev 실행 결과를 임의로 성공 처리하지 않는다. 내부 task가 아직 제품 수준 acceptance criteria와 연결되지 않았으면 handoff 대상이 아니라 회사 planning 상태에 남긴다.
+
 ## 어댑터 책임
 
 Company -> AI Dev 어댑터의 책임은 다음으로 제한한다.
@@ -54,6 +63,14 @@ Company -> AI Dev 어댑터의 책임은 다음으로 제한한다.
 - 고객 의사결정 dependency가 있으면 AI Dev task 생성 여부를 차단하거나 보류한다.
 - AI Dev 실행 결과를 회사 상태와 고객-facing 이벤트로 요약한다.
 
+어댑터는 내부 task를 전달하기 전에 다음 값을 명확히 보존해야 한다.
+
+- 회사 프로젝트 ID와 내부 task ID
+- 고객-facing objective와 acceptance criteria
+- 이번 task에서 허용된 변경 범위와 범위 제외 항목
+- 기존 AI Dev 안전 규칙과 수동 검증 조건
+- 실패 시 기존 AI Dev recovery 상태를 참조할 수 있는 매핑 키
+
 어댑터가 직접 수행하지 않는 일:
 
 - build/test/lint/review/recovery/commit 실행
@@ -62,6 +79,19 @@ Company -> AI Dev 어댑터의 책임은 다음으로 제한한다.
 - task 크기 제한, baseline 보호, package 변경 보호 약화
 - 고객에게 내부 구현 세부사항 질의
 
+## Handoff 차단 조건
+
+다음 중 하나라도 해당하면 어댑터는 AI Dev task 생성을 보류하고 회사 프로젝트 또는 내부 task를 `blocked`로 표시한다.
+
+- 고객이 제품 목표, 범위, 우선순위, 납품 승인 중 하나를 결정해야 한다.
+- task가 둘 이상의 독립 기능을 포함해 one-task-at-a-time 제한을 위반한다.
+- 허용 파일 또는 예상 변경 파일 범위가 불명확하다.
+- package 추가, 외부 서비스 연동, 로그인, 클라우드 동기화, 알림, 모바일 권한처럼 현재 정책에서 제외된 작업이 필요하다.
+- 기존 build/test/lint/review/recovery 안전장치를 우회해야만 진행할 수 있다.
+- 고객 baseline 변경을 덮어쓰거나 복구할 위험이 있다.
+
+차단 사유는 고객 포털에 raw 오류로 표시하지 않는다. 회사 내부 상태에는 구체 사유를 남기고, 고객에게는 필요한 제품 수준 결정만 요약한다.
+
 ## Handoff Payload
 
 AI Dev로 넘기는 최소 입력은 다음 필드를 포함해야 한다.
@@ -93,6 +123,8 @@ AI Dev 실행 결과를 회사 상태로 되돌릴 때의 최소 출력은 다
 - `remainingRisks`
 - `customerDecisionNeeded`
 
+결과 payload는 AI Dev 로그의 원문 복사본이 아니라 회사 상태 전이를 판단할 수 있는 요약이어야 한다. raw command output, stack trace, 내부 경로 목록은 내부 진단용으로만 참조하고 고객-facing record에는 필요한 의미만 변환해 기록한다.
+
 ## 호출 순서
 
 기본 흐름은 다음 순서를 따른다.
@@ -127,6 +159,14 @@ Company planning에서 AI Dev execution으로 넘어가기 전에는 다음을 
 
 QA와 Review가 통과하기 전에는 `delivery_preparation`, `ready_for_customer`, `customer_acceptance`로 이동하지 않는다. `development`에서 고객 검수 상태로 직접 이동하는 것도 금지한다.
 
+AI Dev 결과 수신 후에는 다음 전이 규칙을 적용한다.
+
+- 구현이 완료되고 QA/Review가 통과하면 `qa_review`에서 `delivery_preparation`으로 이동할 수 있다.
+- 구현은 완료되었지만 QA 또는 Review가 미실행이면 `delivery_preparation`으로 이동하지 않고 `qa_pending` 요약을 남긴다.
+- QA 또는 Review가 실패하면 기존 AI Dev 실패 사유와 recovery 요약을 참조해 `development`, `planning`, 또는 `paused` 중 하나로 되돌린다.
+- 고객 제품 결정이 필요한 실패만 `customer_decision_needed`로 표시한다.
+- AI Dev task가 실패했더라도 회사 상태에서 새 task를 자동 생성하지 않는다.
+
 ## Recovery 경계
 
 Company 모델은 recovery 실행기를 새로 만들지 않는다. 기존 AI Dev task 단위 recovery 상태와 제한을 재사용한다.
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```