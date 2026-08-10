# AI Dev Review Prompt

## Role

너는 이 저장소의 엄격한 코드 리뷰어다.

## Review Goal

- 현재 task의 변경사항이 목표와 일치하는지 검토한다.
- 빌드/테스트 결과와 git diff를 함께 검토한다.
- 리뷰 판단은 App Change Files와 diff 본문의 실제 앱 변경 파일을 중심으로 수행한다.
- .ai-dev 파일은 자동화 상태/로그/프롬프트 산출물로 별도 확인하되, 앱 변경 결함으로 과대평가하지 않는다.
- 다음 task 범위까지 미리 구현했는지 확인한다.

## Project Goal

# 목표
AI Software Company 고객 포털과 자율 개발회사 운영 기반을 기존 PlanPilot AI Dev 자동화 엔진 위에 작고 안전한 단위로 설계하고 초기 상태 파일 계획을 준비한다.

## 배경
사용자는 개발팀 관리자가 아니라 고객/발주자 관점에서 제품을 의뢰하고, CEO Agent가 요구사항 분석부터 납품 검수까지 회사 운영 흐름을 조율하는 로컬 운영 플랫폼을 원한다. 기존 자동개발 스크립트와 회귀 테스트 안전장치는 재사용하며 약화하지 않는다.

## 성공 기준
- 고객 의뢰, CEO 검토, 내부 역할 흐름, 납품 준비 상태를 분리된 회사 상태 모델로 표현한다.
- 기존 AI Dev Goal/Task 흐름과 연결 가능한 어댑터 경계를 정의한다.
- 고객 포털과 회사 내부 보기를 PlanPilot 제품 UI와 섞지 않는 구조로 준비한다.
- 고객 의사결정이 필요한 상황과 회사가 자율 처리할 개발 세부사항의 경계를 명확히 한다.
- 이후 구현이 PowerShell 5.1, UTF-8, 로컬 파일 기반 상태 저장 정책을 유지하도록 한다.

## 제약사항
- 기존 PlanPilot 제품 UI와 회사 운영 GUI의 경계를 유지한다.
- 기존 테스트와 자동개발 안전장치를 약화하거나 중복 구현하지 않는다.
- 고객 baseline 변경을 보존한다.
- 상태 파일은 전용 회사 디렉터리에 분리하고 재시작 후 복원 가능해야 한다.
- 한 번에 하나의 기능 단위로 진행한다.

## 범위 제외
- 외부 서비스 연동은 포함하지 않는다.
- 대규모 기존 화면 재작성은 포함하지 않는다.
- 제품 요구사항과 무관한 리팩터링은 포함하지 않는다.
- 알림, 모바일 권한, 동기화 기능은 포함하지 않는다.

## 수동 검증
- 생성된 목표와 큐가 작고 순차적인지 확인한다.
- T001이 현재 진행 작업으로 설정되었는지 확인한다.
- 회사 상태와 기존 AI Dev 상태가 분리되는 방향인지 확인한다.
- 고객 의사결정 기준이 제품 수준 결정으로 제한되어 있는지 확인한다.

## T001 분석 결과: 회사 운영 상태 모델

### 상태 저장 경계
- 회사 운영 상태는 이후 `.ai-company/` 전용 디렉터리에 저장한다.
- 기존 `.ai-dev/` 파일은 자동 개발 목표, task 큐, 실행 상태, 검증/리뷰 기록만 담당한다.
- 회사 상태 파일은 고객 포털과 내부 회사 운영 GUI의 복원 가능한 원천 상태로 사용하며, PlanPilot 제품 데이터와 섞지 않는다.
- PowerShell 5.1 환경을 고려해 모든 회사 상태 파일은 UTF-8 JSON 또는 append-only JSONL로 유지한다.

### 프로젝트 생명주기
- `intake`: 고객 의뢰가 접수되었고 제품 수준 요구사항이 정리되기 전 상태.
- `ceo_review`: CEO Agent가 요구사항, 범위, 리스크, 고객 결정 필요 여부를 검토하는 상태.
- `planning`: 내부 역할들이 작업 단위, 검증 기준, 납품 기준을 작게 나누는 상태.
- `development`: 기존 AI Dev Goal/Task 흐름으로 전달 가능한 내부 개발 작업이 실행되는 상태.
- `qa_review`: 테스트, 회귀 안전장치, 리뷰 결과를 확인하는 상태.
- `delivery_preparation`: 고객에게 보여줄 요약, 변경 내역, 검수 기준을 준비하는 상태.
- `customer_acceptance`: 고객이 제품 수준 결과를 승인하거나 보완 요청을 남기는 상태.
- `closed`: 납품이 승인되어 회사 운영 관점에서 종료된 상태.
- `paused`: 고객 결정, 범위 충돌, 안전 규칙 충돌 등으로 진행을 멈춘 상태.

### 역할 상태
- `CEO`: 고객 의뢰 해석, 우선순위 판단, 고객 결정 필요 여부 판정, 납품 승인 준비를 담당한다.
- `Product`: 제품 수준 요구사항, 수용 기준, 고객-facing 변경 요약을 담당한다.
- `CTO`: 기술 범위, 기존 AI Dev 연결 가능성, 안전장치 유지 여부를 판단한다.
- `Developer`: 기존 AI Dev task 단위 구현을 수행한다.
- `QA`: build/test/lint/review 결과와 회귀 위험을 확인한다.
- 각 역할 상태는 `idle`, `assigned`, `working`, `blocked`, `done` 중 하나로 표현하고, 차단 사유는 회사 상태 파일에 기록한다.

### 고객 의사결정 경계
- 고객 결정이 필요한 항목은 목표 변경, 범위 확대/축소, 우선순위 변경, 납품 승인, 제품 동작 또는 UX 방향 선택으로 제한한다.
- 고객에게 내부 구현 방식, 파일 분리 방식, 테스트 명령 선택, 코드 스타일 같은 개발 세부사항을 묻지 않는다.
- 회사가 자율 처리할 항목은 task 분해, 기존 AI Dev 큐 생성, 검증 순서, 리뷰 대응, 작은 리팩터링 제안, 납품 요약 작성이다.
- 고객 결정 대기 상태에서는 개발 세부 task를 새로 시작하지 않고, 기존 진행 결과와 필요한 선택지를 요약한다.

### 납품 상태
- `not_ready`: 개발 또는 검증이 끝나지 않아 고객 검수가 불가능한 상태.
- `qa_pending`: 구현은 끝났지만 QA 또는 리뷰 확인이 남은 상태.
- `ready_for_customer`: QA와 리뷰가 통과되어 고객 검수 자료를 준비할 수 있는 상태.
- `changes_requested`: 고객이 제품 수준 보완을 요청한 상태.
- `accepted`: 고객이 납품을 승인한 상태.
- QA와 리뷰가 통과하기 전에는 `ready_for_customer`로 이동하지 않는다.

### 기존 AI Dev 어댑터 경계
- 회사 운영 모델은 내부 개발 작업을 기존 AI Dev Goal/Task 큐로 변환하는 계획까지만 담당한다.
- 실제 구현, 검증, 리뷰, 실패 복구는 기존 `.ai-dev/queue.json`, `.ai-dev/state.json`, 자동개발 스크립트의 책임으로 남긴다.
- 어댑터는 회사 프로젝트 ID, 내부 작업 목적, 성공 기준, 예상 변경 파일, 검증 방법을 AI Dev task 입력으로 전달한다.
- AI Dev 실행 결과는 고객에게 raw 로그가 아니라 상태 요약, 검증 결과, 남은 위험, 고객 결정 필요 여부로 변환해 보여준다.
- 기존 테스트와 자동개발 안전장치를 대체하거나 우회하는 별도 실행기를 만들지 않는다.

### 초기 회사 상태 파일 계획
- `.ai-company/company-state.json`: 회사 운영 런타임 상태, 현재 프로젝트, 역할별 상태, 차단 사유.
- `.ai-company/projects.json`: 고객 프로젝트 목록과 생명주기 상태.
- `.ai-company/customer-requests.json`: 고객 의뢰 원문과 정리된 제품 요구사항.
- `.ai-company/customer-decisions.json`: 고객 결정 대기/완료 항목과 선택지.
- `.ai-company/deliveries.json`: 납품 준비 상태, 검수 기준, 고객 승인 상태.
- `.ai-company/company-config.json`: 로컬 운영 정책과 역할 기본 설정.
- `.ai-company/events.jsonl`: 재시작 후 흐름 복원을 위한 append-only 회사 이벤트 로그.


## Current Task

- Task ID: T003
- Title: 기존 AI Dev 연결 경계 문서화
- Description: CEO/Product/CTO/Project 단계에서 만들어진 내부 Task가 기존 AI Dev Goal/Task 실행 흐름으로 전달되는 어댑터 책임과 검증 게이트를 문서화한다.
- Type: documentation
- Status: in_progress
- Priority: P1
- Depends on:
- T002
- Verification:
- QA와 Review 통과 전 납품 준비로 이동하지 않는지 확인
- Recovery 흐름이 기존 task 단위 제한과 실패 사유를 재사용하도록 명시되어 있는지 확인
- 고객 포털에 raw 로그보다 요약 이벤트를 우선 표시하는 원칙이 포함되어 있는지 확인

## Test Result

# AI Dev Test Result

## 2026-08-10 15:36:22

- Overall result: passed
- Current task: T003
- Mode: BuildOnly (build + lint when available)
- Commands:
  - npm run build: passed
  - npm run test: skipped
  - npm run lint: passed

### npm run build

- Status: passed
- Exit code: 0

```text

> planpilot-local@0.0.0 build
> tsc -b && vite build

[36mvite v8.0.10 [32mbuilding client environment for production...[36m[39m
[2K
transforming...✓ 48 modules transformed.
rendering chunks...
computing gzip size...
dist/index.html                   0.46 kB │ gzip:   0.29 kB
dist/assets/index-DvjxWt30.css    5.69 kB │ gzip:   1.93 kB
dist/assets/index-DtLVvPCG.js   317.50 kB │ gzip: 100.16 kB

[32m✓ built in 410ms[39m
```
### npm run test

- Status: skipped
- Exit code: 없음

```text
-BuildOnly 옵션으로 건너뛰었습니다.
```
### npm run lint

- Status: passed
- Exit code: 0

```text

> planpilot-local@0.0.0 lint
> eslint .
```

## Diff To Review

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

## Review Criteria

- 현재 task 요구사항을 충족했는가
- 실제 앱 변경 파일과 .ai-dev 운영 산출물이 구분되어 있는가
- .ai-dev 운영 산출물만 변경된 경우 앱 변경 리뷰로 과대평가하지 않았는가
- 현재 task 범위를 벗어나지 않았는가
- 다음 task를 미리 구현하지 않았는가
- 기존 기능을 깨뜨릴 가능성이 있는가
- 데이터 삭제, 초기화, 복원 같은 위험 작업이 포함되었는가
- package.json 또는 package-lock.json을 불필요하게 수정했는가
- 검증 결과가 충분한가
- 문서나 수동검증 체크리스트 갱신이 필요한가
- 더 단순한 구현이 가능한가

### Strict Criteria

- 작은 불확실성도 revise로 판정한다.
- 테스트가 없거나 skipped이면 revise 후보로 본다.
- task 범위를 벗어난 파일 수정은 high 이상으로 판정한다.
- package 변경은 기본적으로 blocked 후보로 본다.

## Output Format

리뷰 결과는 아래 JSON 형식만 출력한다. JSON 앞뒤에 설명, Markdown 코드 펜스, 추가 문장을 출력하지 않는다.

{
  "decision": "pass | revise | blocked",
  "severity": "none | low | medium | high | critical",
  "summary": "짧은 요약",
  "required_changes": [
    {
      "file": "파일 경로 또는 unknown",
      "reason": "수정이 필요한 이유",
      "suggestion": "구체적 수정 방향"
    }
  ],
  "optional_suggestions": [
    {
      "file": "파일 경로 또는 unknown",
      "suggestion": "선택 개선 의견"
    }
  ],
  "scope_check": {
    "within_current_task": true,
    "scope_issues": []
  },
  "test_check": {
    "build_passed": true,
    "test_passed": true,
    "lint_passed": true,
    "issues": []
  },
  "next_step": "complete_task | revise_with_codex | stop_for_user"
}

## Decision Rules

- pass: 현재 task 요구사항 충족, 치명적 문제 없음, 다음 task로 넘어가도 됨
- revise: 수정이 필요하지만 자동 수정 가능
- blocked: 요구사항 충돌, 데이터 위험, 패키지 추가, 대규모 리팩터링 등 사용자 판단 필요