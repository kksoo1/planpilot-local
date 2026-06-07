# PlanPilot Local AI 자동 개발 루프 정책

이 문서는 사용자가 목표를 입력하면 AI가 작업을 분해하고, 구현하고, 검증하고, 리뷰하고, 작업 단위로 자동 커밋하는 Level 5 자동 개발 루프의 기준을 정리한다.

현재 문서는 정책 문서이며, 실제 자동화 스크립트, 실행기, 감시 프로세스, CI 연동은 구현하지 않는다.

## 목적

- 사용자는 구현 세부사항보다 달성할 목표와 우선순위를 입력한다.
- AI는 목표를 작은 작업으로 분해하고 한 번에 하나씩 안전하게 처리한다.
- 각 작업은 구현, 검증, 리뷰, 커밋 결과를 독립적으로 추적할 수 있어야 한다.
- 자동화가 장시간 실행되더라도 현재 작업 범위를 벗어나지 않아야 한다.
- 저장소의 `AGENTS.md`, 보안 정책, 금지 사항, 사용자 지시는 자동 개발 루프보다 항상 우선한다.

## Level 5 자동 개발 루프 정의

Level 5 자동 개발 루프는 사용자가 `.ai-dev/goal.md`에 목표를 작성한 뒤, AI가 다음 작업을 스스로 선택하고 완료 상태까지 진행하는 운영 방식이다.

AI가 담당하는 범위:

- 목표 분석
- 작업 분해
- 실행 순서 결정
- 현재 작업 구현
- build, test, lint 실행
- 실패 원인 분석과 허용 범위 내 재수정
- GPT 기반 변경 리뷰
- 리뷰 지적사항 반영
- 자동 커밋
- 다음 작업 선택
- 진행 상태와 로그 기록

AI는 목표가 불명확하거나 안전하게 판단할 수 없는 경우 임의로 범위를 확장하지 않고 중단한다.

## 기본 동작 흐름

1. `.ai-dev/goal.md`와 `.ai-dev/backlog.md`를 읽는다.
2. 저장소의 `AGENTS.md`와 현재 작업 트리 상태를 확인한다.
3. 목표를 작은 task로 분해하고 `.ai-dev/plan.md`와 `.ai-dev/queue.json`을 갱신한다.
4. queue에서 우선순위가 가장 높고 실행 가능한 task 하나를 선택한다.
5. 선택한 task의 수정 예정 파일, 위험도, 검증 방법을 기록한다.
6. 현재 task 범위 안에서만 구현한다.
7. task에 필요한 build, test, lint를 실행한다.
8. 실패하면 같은 task 범위 안에서 원인을 수정하고 다시 검증한다.
9. 검증이 성공하면 전체 변경 diff를 GPT가 리뷰한다.
10. 리뷰 지적사항이 있으면 같은 task 범위 안에서 수정하고 다시 검증한다.
11. 자동 커밋 조건을 모두 만족하면 task 단위 커밋을 만든다.
12. `.ai-dev/state.json`, `.ai-dev/test-result.md`, `.ai-dev/review.md`, `.ai-dev/loop-log.md`를 갱신한다.
13. 다음 task를 선택하거나 중단 조건에 따라 루프를 종료한다.

## 사람이 입력하는 파일

### `.ai-dev/goal.md`

사용자가 달성하려는 목표를 작성하는 파일이다.

포함 권장 항목:

- 목표
- 완료 기준
- 허용 범위
- 금지 범위
- 우선순위
- 참고 문서
- 검증 방법
- 커밋 또는 배포 제한

목표는 가능한 한 결과 중심으로 작성한다. 구현 방식은 저장소 구조와 정책에 맞춰 AI가 판단할 수 있다.

### `.ai-dev/backlog.md`

사용자가 원하는 후속 작업, 아이디어, 낮은 우선순위 후보를 기록하는 파일이다.

정책:

- backlog 항목은 자동 실행이 확정된 task가 아니다.
- AI는 현재 goal과 직접 관련된 항목만 queue 후보로 올린다.
- 위험도가 높거나 범위가 큰 항목은 문서화 task로 전환할 수 있다.
- 현재 goal과 무관한 backlog 항목은 임의로 구현하지 않는다.

## AI가 생성하거나 수정하는 파일

### `.ai-dev/plan.md`

현재 goal을 어떤 단계로 처리할지 사람이 읽을 수 있는 형태로 정리한다.

포함 항목:

- 목표 요약
- 작업 분해 결과
- 작업 순서
- 예상 수정 파일
- 작업별 위험도
- 검증 계획
- 중단 조건

### `.ai-dev/queue.json`

자동 개발 루프가 처리할 task 목록과 상태를 구조화해 저장한다.

task 상태 후보:

- `pending`
- `in_progress`
- `blocked`
- `completed`
- `skipped`

각 task는 최소한 다음 정보를 포함해야 한다.

- 고유 id
- 제목
- 목적
- 우선순위
- 허용 수정 파일
- 검증 명령
- 커밋 메시지 후보
- 현재 상태

### `.ai-dev/state.json`

자동 개발 루프의 현재 실행 상태를 기록한다.

포함 항목:

- 현재 goal
- 현재 task id
- 마지막 완료 task id
- 마지막 성공 검증 시각
- 마지막 커밋 hash
- 재시도 횟수
- 중단 사유

### `.ai-dev/test-result.md`

작업별 build, test, lint 실행 결과를 기록한다.

정책:

- 실행하지 않은 검증은 통과로 기록하지 않는다.
- 실패한 검증은 원인과 재시도 결과를 남긴다.
- 검증 명령이 저장소에 없거나 실행이 허용되지 않으면 미수행 사유를 남긴다.

### `.ai-dev/review.md`

작업별 GPT 리뷰 결과를 기록한다.

검토 항목:

- 타입 오류 가능성
- 빌드 또는 테스트 실패 가능성
- 런타임 오류 가능성
- 기존 기능 회귀 가능성
- 현재 task 범위 밖 수정 여부
- `AGENTS.md` 위반 여부
- 보안, 데이터 손상, 개인정보 유출 위험

### `.ai-dev/loop-log.md`

자동 개발 루프의 실행 이력을 시간 순서로 기록한다.

포함 항목:

- task 선택
- 수정 파일
- 검증 결과
- 리뷰 결과
- 커밋 결과
- 중단 또는 재시도 사유

## 작업 단위 원칙

- 한 번에 하나의 task만 수행한다.
- 하나의 task는 하나의 명확한 목적만 가져야 한다.
- task 범위 밖 파일은 수정하지 않는다.
- 각 task는 독립적으로 검증할 수 있어야 한다.
- 각 task는 검증 성공 후 하나의 커밋으로 만든다.
- 관련성이 낮은 변경을 하나의 커밋에 묶지 않는다.
- 큰 기능은 구현, 정책 문서화, 검증 보강을 별도 task로 나눈다.
- 대규모 변경이 필요한 경우 작은 선행 task로 다시 분해한다.

## 자동화 단계

### 1. goal 분석

- 목표와 완료 기준을 확인한다.
- 허용 범위와 금지 범위를 분리한다.
- 저장소 정책과 충돌하는 요구가 있는지 확인한다.
- 불명확한 조건이 안전성에 영향을 주면 중단하고 사용자 확인을 요청한다.

### 2. queue 생성

- 목표를 작은 task로 분해한다.
- 위험도가 낮고 선행 조건이 충족된 task를 앞에 둔다.
- DB schema 변경, 대규모 리팩터링, 외부 네트워크 연동은 별도 검토 task로 분리한다.

### 3. current task 선택

- `pending` 상태 중 우선순위가 가장 높은 task 하나를 선택한다.
- 이전 task가 실패했거나 검증되지 않았으면 다음 task로 넘어가지 않는다.
- 현재 작업 트리가 예상하지 못한 변경을 포함하면 새 task를 시작하지 않는다.

### 4. 구현

- 수정 예정 파일과 위험도를 기록한다.
- 기존 코드 스타일, 타입, store, DB 구조를 우선 사용한다.
- task 범위 밖 리팩터링이나 기능 추가를 하지 않는다.

### 5. build/test/lint 실행

- task에 필요한 검증 명령만 실행한다.
- 실행 권한과 저장소 정책을 먼저 확인한다.
- 실행하지 않은 검증은 미수행으로 기록한다.

### 6. 실패 시 재수정

- 실패 원인을 현재 task 범위 안에서만 수정한다.
- 같은 문제가 반복되면 재시도 횟수를 기록한다.
- 허용 범위를 넘어야 해결할 수 있으면 중단한다.

### 7. GPT 리뷰

- 전체 diff를 기준으로 변경을 검토한다.
- P1 수준의 데이터 손상, 보안, 런타임 오류, 주요 회귀 위험이 있으면 커밋하지 않는다.
- P2/P3 지적사항은 현재 task 범위 안에서 안전하게 해결할 수 있을 때만 반영한다.

## 수동 GPT 리뷰 브리지 정책

현재 AI Dev Loop는 GPT API 키가 없는 환경에서도 ChatGPT 웹 화면을 사용해 리뷰를 진행할 수 있어야 한다. 이 흐름은 API 자동 호출이 아니라 사람이 검토 내용을 옮기는 수동 브리지이며, 자동화 스크립트는 프롬프트 생성, 클립보드 복사, 리뷰 JSON 저장 안내까지만 돕는다.

### 기본 원칙

- GPT API를 직접 호출하지 않는다.
- ChatGPT 웹 화면에 자동으로 접속하거나 입력하지 않는다.
- `review-prompt.md`는 로컬에서 생성한다.
- 사용자는 prompt 내용을 확인한 뒤 ChatGPT 웹 화면에 직접 붙여넣는다.
- ChatGPT에는 리뷰 결과를 지정된 JSON 형식만 출력하도록 요청한다.
- 사용자는 ChatGPT가 반환한 JSON 리뷰를 복사한다.
- 리뷰 JSON은 `ai-dev-save-review.ps1 -FromClipboard` 또는 별도 수동 브리지 helper를 통해 저장한다.
- 리뷰 저장 뒤에는 기존 decision 규칙에 따라 `pass`, `revise`, `blocked` 흐름을 계속 진행한다.

### 수동 리뷰 흐름

1. `ai-dev-make-review-prompt.ps1`가 `.ai-dev/review-prompt.md`를 생성한다.
2. 사용자는 `review-prompt.md` 내용을 클립보드에 복사한다.
3. 사용자는 ChatGPT 웹 화면에 prompt를 붙여넣는다.
4. ChatGPT는 JSON 리뷰만 출력해야 한다.
5. 사용자는 JSON 리뷰 전체를 클립보드에 복사한다.
6. `ai-dev-save-review.ps1 -FromClipboard`가 클립보드의 JSON을 파싱해 `.ai-dev/review.md`와 `.ai-dev/state.json`을 갱신한다.
7. decision이 `pass`이면 complete-task 또는 commit 단계로 진행한다.
8. decision이 `revise`이면 revise prompt를 생성해 Codex/Cline에 수동으로 전달한다.
9. decision이 `blocked`이면 사용자 판단을 기다린다.

### auto-step과 수동 브리지

`ai-dev-auto-step.ps1`는 `ask_gpt_review` 상태에서 GPT API를 호출하지 않는다. 대신 수동 리뷰 브리지에 필요한 다음 행동을 안내해야 한다.

안내 후보:

- `review-prompt.md` 생성 여부 확인
- `review-prompt.md` 클립보드 복사 명령 안내
- ChatGPT 웹 화면에 붙여넣으라는 안내
- JSON 리뷰만 받아야 한다는 안내
- 리뷰 JSON을 복사한 뒤 `ai-dev-save-review.ps1 -FromClipboard`를 실행하라는 안내

### manual-cycle과 수동 브리지

`ai-dev-manual-cycle.ps1`는 현재 상태와 다음 action을 함께 보여주는 수동 운영 대시보드다. 사용자는 `manual-cycle` 결과에서 `ask_gpt_review`를 확인한 뒤 수동 리뷰 브리지로 전환한다.

권장 흐름:

1. `ai-dev-manual-cycle.ps1`로 현재 task, git 상태, test-result, review 상태, next action을 확인한다.
2. next action이 `ask_gpt_review`이면 `ai-dev-copy-review-prompt.ps1`로 `review-prompt.md`를 클립보드에 복사한다.
3. 사용자가 ChatGPT 웹 화면에 prompt를 붙여넣는다.
4. ChatGPT에는 JSON 리뷰만 출력하도록 요청한다.
5. 사용자가 JSON 리뷰를 클립보드에 복사한다.
6. `ai-dev-save-review.ps1 -FromClipboard`로 리뷰 결과를 저장한다.
7. 저장된 decision에 따라 다음 단계를 선택한다.

decision별 기준:

- `pass`: 현재 task 완료 처리 또는 커밋 조건 검토로 진행한다.
- `revise`: `ai-dev-make-revise-prompt.ps1`로 재수정 프롬프트를 만들고 Codex/Cline에 수동으로 전달한다.
- `blocked`: 사용자 판단이 필요하므로 루프를 중단하고 요구사항, 범위, 위험도를 다시 확인한다.

이 흐름은 GPT API 키가 없어도 동작한다. 단, `review-prompt.md`에는 diff와 테스트 결과가 포함될 수 있으므로 ChatGPT에 붙여넣기 전에 사용자가 민감 정보와 대형 diff 포함 여부를 확인해야 한다.

### 민감 정보와 공유 범위

`review-prompt.md`에는 git diff, 테스트 결과, 현재 task 설명이 포함될 수 있다. diff 안에 민감 정보, 백업 데이터, 개인정보, API Key, 대형 파일 내용이 포함될 수 있으므로 사용자는 ChatGPT에 붙여넣기 전에 prompt 내용을 확인해야 한다.

정책:

- API Key, 개인정보, 백업 데이터가 포함된 prompt는 외부 ChatGPT 화면에 붙여넣지 않는다.
- `diff.md`와 `review-prompt.md`가 너무 크면 범위를 줄이거나 산출물을 정리한 뒤 다시 생성한다.
- 민감 정보가 의심되면 리뷰 브리지 흐름을 중단하고 사용자 판단을 받는다.
- 수동 리뷰 브리지는 편의 기능일 뿐, 보안 판단을 자동화하지 않는다.

### 8. 리뷰 반영

- 리뷰 수정 후 필요한 검증을 다시 실행한다.
- 수정으로 task 범위가 커지면 중단하고 queue를 다시 분해한다.

### 9. 자동 커밋

- 자동 커밋 조건을 모두 만족한 경우에만 수정한 파일을 명시적으로 stage한다.
- `git add .`는 사용하지 않는다.
- 커밋 메시지는 짧고 명확한 영어 문장으로 작성한다.

### 10. 다음 task 선택

- 현재 task의 상태, 검증 결과, 리뷰 결과, 커밋 hash를 기록한다.
- 다음 task의 선행 조건을 확인한다.
- 중단 조건이 없을 때만 다음 task를 시작한다.

## auto-step 동작 정책

`ai-dev-auto-step.ps1`는 현재 queue, state, review, test, git 상태를 읽고 안전한 다음 한 단계만 처리하는 보조 스크립트다. 완전 자동 개발 루프 실행기가 아니며, 사용자 판단이나 외부 AI 호출이 필요한 순간에는 중단하거나 다음 명령만 안내한다.

### 기본 원칙

- 한 번 실행할 때 하나의 action만 처리한다.
- `ai-dev-next.ps1`가 판단하는 다음 action을 기반으로 동작한다.
- 상태 파일과 프롬프트 파일을 갱신하는 안전한 로컬 스크립트만 자동 실행한다.
- Codex, Cline, GPT API, git commit, git push는 자동 실행하지 않는다.
- destructive git 명령, DB 삭제/복원/마이그레이션, package 설치는 자동 실행하지 않는다.
- 실패하면 state와 출력에 실패 이유를 남기고 다음 action으로 진행하지 않는다.

### 자동 실행 허용 후보

초기 auto-step에서 자동 실행할 수 있는 후보는 로컬 파일 생성 또는 검증 보조 작업으로 제한한다.

- `current-task-prompt.md`가 없을 때 `scripts/ai-dev-make-prompt.ps1` 실행
- 검증이 필요한 상태에서 명시적으로 안전한 옵션이 선택된 경우 `scripts/ai-dev-check.ps1` 실행
- diff 저장이 필요한 상태에서 `scripts/ai-dev-save-diff.ps1` 실행
- review prompt 생성이 필요한 상태에서 `scripts/ai-dev-make-review-prompt.ps1` 실행
- revise prompt 생성이 필요한 상태에서 사용자가 명시적으로 허용한 경우 `scripts/ai-dev-make-revise-prompt.ps1` 실행 후보 검토

`ai-dev-check.ps1`는 프로젝트 명령을 실행할 수 있으므로 기본 자동 실행 범위는 보수적으로 둔다. 초기 구현은 DryRun 또는 명시적 안전 옵션에서만 check 실행을 허용한다.

### 자동 실행 금지 또는 중단 후보

다음 상태에서는 auto-step이 직접 작업하지 않고 사용자에게 다음 행동을 안내하거나 중단한다.

- Codex 또는 Cline이 현재 task 구현을 수행해야 하는 경우
- GPT 리뷰가 필요한 경우
- 리뷰 결과가 `blocked`인 경우
- 리뷰 결과가 `revise`이고 재수정 범위가 불명확한 경우
- git commit이 필요한 경우
- git push, PR 생성, 배포가 필요한 경우
- 사용자 데이터 삭제, 복원, 덮어쓰기, 마이그레이션 위험이 있는 경우
- package 설치 또는 package 파일 변경이 필요한 경우
- 예상하지 못한 사용자 변경이 작업 트리에 있는 경우

특히 git commit은 이번 목표의 auto-step 자동 실행 범위에서 제외한다. auto-step은 커밋이 필요하다는 사실과 추천 명령을 안내할 수는 있지만 `ai-dev-commit.ps1`를 직접 실행하지 않는다.

### auto-cycle 동작 기준

`ai-dev-auto-cycle.ps1`는 auto-step을 제한 횟수 안에서 반복하는 보조 스크립트다.

- `-MaxSteps` 같은 반복 제한을 둔다.
- 각 반복은 auto-step 한 번의 결과를 확인한 뒤 다음 반복 여부를 판단한다.
- 사용자 개입 필요 action, blocked, failed, commit 필요, Codex/GPT 필요 상태에서는 중단한다.
- 같은 action이 반복되거나 상태가 변하지 않으면 무한 루프 위험으로 중단한다.
- auto-cycle도 Codex/GPT API 호출, git commit, git push를 자동 실행하지 않는다.

### 관련 명령 역할 구분

- `ai-dev-next.ps1`: 현재 상태를 읽고 다음 추천 action과 명령만 안내한다. 파일 수정이나 하위 명령 실행을 하지 않는다. “다음에 무엇을 해야 하지?”만 알고 싶을 때 사용한다.
- `ai-dev-manual-cycle.ps1`: 상태 요약과 다음 행동 안내를 한 번에 보여주는 수동 운영 대시보드다. 현재 task, 검증, 리뷰, diff 파일 상태를 함께 보며 사람이 직접 다음 명령을 고를 때 사용한다.
- `ai-dev-auto-step.ps1`: `next` 판단 결과를 기반으로 안전하다고 정의된 다음 한 단계를 실행한다. 프롬프트 생성 같은 로컬 보조 작업은 실행할 수 있지만 Codex/GPT/commit 단계에서는 멈춘다.
- `ai-dev-auto-cycle.ps1`: 제한 횟수 안에서 auto-step을 반복한다. 여러 안전 단계를 이어가고 싶을 때 사용하지만, 사용자 개입 필요 action, 실패, blocked, commit 필요 상태에서는 멈춘다.

사용 추천:

- 상황 파악: `ai-dev-manual-cycle.ps1`
- 다음 행동만 확인: `ai-dev-next.ps1`
- 안전한 자동 1단계 실행: `ai-dev-auto-step.ps1`
- 안전 단계 반복 실행: `ai-dev-auto-cycle.ps1`

`ai-dev-auto-step.ps1`와 `ai-dev-auto-cycle.ps1`는 Codex/Cline 실행, GPT 리뷰 요청, git commit을 자동 실행하지 않는다.

## 수동 자동화 UX 개선 기준

AI Dev Loop는 GPT API 없이도 사람이 다음 행동을 빠르게 판단할 수 있어야 한다. 자동화 스크립트는 실행 여부보다 현재 상태, 중단 이유, 추천 명령, 위험 여부를 명확히 보여주는 것을 우선한다.

### 다음 행동 판단 순서

사용자가 현재 상태를 판단할 때는 아래 명령을 우선 확인한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-next.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-manual-cycle.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -DryRun
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -DryRun -MaxSteps 3
```

- `status`: 현재 goal/task/test/review/git 상태를 확인한다.
- `next`: 다음 action과 추천 명령만 확인한다.
- `manual-cycle`: 상태와 다음 action을 한 화면에서 확인한다.
- `auto-step -DryRun`: 실제 실행 없이 auto-step이 무엇을 할지 확인한다.
- `auto-cycle -DryRun -MaxSteps 3`: 제한된 반복 안에서 어디에서 멈출지 확인한다.

### goal_completed 상태 UX

`goal_completed` 상태에서는 더 이상 실행할 task가 없음을 명확히 안내해야 한다.

정책:

- `auto-step`은 완료된 goal에서 추가 작업을 실행하지 않는다.
- `auto-cycle`은 완료 상태를 반복하지 않고 `completed: true`로 종료해야 한다.
- 출력에는 새 목표를 시작하려면 `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json`을 새 goal 기준으로 초기화해야 한다는 안내를 포함한다.
- 완료 상태에서 build/test/review/commit을 자동으로 실행하지 않는다.

### ask_gpt_review 상태 UX

`ask_gpt_review` 상태는 사람이 ChatGPT 웹 화면에서 리뷰를 수행해야 하는 지점이다.

정책:

- `auto-step`과 `auto-cycle`은 GPT API를 호출하지 않는다.
- `auto-cycle`은 `ask_gpt_review`에서 멈출 때 수동 리뷰 브리지 명령을 함께 보여줘야 한다.
- JSON 출력에도 `ai-dev-copy-review-prompt.ps1`와 `ai-dev-save-review.ps1 -FromClipboard` 명령이 포함되어야 한다.
- message에는 review-prompt 복사, ChatGPT 붙여넣기, JSON 리뷰 복사, save-review 실행 흐름을 짧게 설명한다.

### save-review 실패와 상태 오염 방지

리뷰 JSON 파싱 실패는 사용자가 잘못된 클립보드 내용을 복사했을 때 자주 발생할 수 있다. 이 실패가 이미 완료된 goal이나 정상 review 상태를 불필요하게 오염시키면 안 된다.

개선 방향:

- 잘못된 JSON 입력은 preview를 포함해 원인을 설명한다.
- 가능한 경우 실패 입력을 기존 `review.md`와 `state.json`에 즉시 덮어쓰기 전에 보존 여부를 선택할 수 있게 한다.
- `goalStatus`가 `completed`인 상태에서는 실패한 임시 리뷰 입력만으로 완료 상태를 `blocked`처럼 보이게 만들지 않는다.
- 정상 JSON 저장 흐름과 실패 기록 흐름을 구분한다.
- 상태 파일을 갱신하는 경우 어떤 필드를 바꾸는지 출력 또는 문서로 확인할 수 있어야 한다.

### 최종 검증 결과 기록 UX

T006 같은 최종 검증 task는 build/test/lint 외에도 PowerShell 문법 검증, `auto-step`/`auto-cycle` DryRun, `save-review` 성공/실패 흐름 확인이 필요하다.

정책:

- 실행한 검증 명령과 결과를 `test-result.md`에 남긴다.
- 실행하지 않은 검증은 통과로 기록하지 않는다.
- 최종 검증에서 확인한 수동 명령, exit code, 주요 출력 요약을 기록한다.
- build/test/lint 흐름은 기존 `ai-dev-check.ps1` 동작과 충돌하지 않아야 한다.
- 문법 검증이나 DryRun 결과를 기록할 때는 `ai-dev-check.ps1 -ManualSummaryOnly -ManualSummary "..."`를 사용할 수 있다.
- 수동 요약 기록 모드는 npm build/test/lint를 실행하지 않는다.
- 수동 요약에는 PowerShell 문법 검증 결과, `auto-step` DryRun 결과, `auto-cycle` DryRun 결과, `save-review` 실패/성공 흐름 확인, git status 확인처럼 사람이 실제로 수행한 항목만 적는다.
- 실행하지 않은 검증 항목은 수동 요약에 통과로 적지 않는다.
- 수동 요약 모드의 `state.json.lastCommandStatus`는 기록 작업 성공 여부를 뜻하며, 검증 자체의 통과/실패/미수행 판단은 `test-result.md` 본문에 남긴다.

## Codex CLI 완전 자동화 정책

AI Dev Loop의 다음 자동화 단계는 Codex CLI를 구현자와 리뷰어로 사용한다. GPT API Key, Cline, Copilot CLI, `gh` 없이 로컬 저장소 안에서 `codex exec` 기반 실행 흐름을 구성한다.

현재 환경 기준:

- Codex CLI: `codex-cli 0.133.0`
- 실행 방식: `codex exec`
- workdir: `D:\ai-apps\planpilot-local`
- approval: `never`
- sandbox: `workspace-write`
- Cline: 삭제되어 사용하지 않음
- Copilot CLI, `gh`: 현재 사용하지 않음

### 역할 분리

- 구현자 역할: `current-task-prompt.md`를 Codex CLI에 전달해 현재 task 범위 안의 코드 또는 문서 수정을 수행한다.
- 리뷰어 역할: `review-prompt.md`를 Codex CLI에 전달해 지정된 JSON 형식의 리뷰 결과를 생성한다.
- 리뷰 저장: Codex 리뷰 결과는 `.ai-dev/review-response.json`에 저장한 뒤 `ai-dev-save-review.ps1` 흐름으로 `.ai-dev/review.md`와 `.ai-dev/state.json`에 반영한다.
- 루프 기록: 구현 결과, 리뷰 결과, 실패 요약은 `.ai-dev/codex-result.md`, `.ai-dev/review-response.json`, `.ai-dev/loop-log.md`, `.ai-dev/state.json`에 남긴다.

### 초기 full auto-cycle 제한

초기 `ai-dev-auto-cycle-full.ps1`는 안전을 위해 작은 범위에서만 동작해야 한다.

- 기본 검증 단위는 `MaxTasks 1`로 제한한다.
- Codex 구현 실행은 명시적 `AllowCodex` 옵션이 있을 때만 수행한다.
- Codex 리뷰 실행은 명시적 `AllowReviewCodex` 옵션이 있을 때만 수행한다.
- git commit은 명시적 `AllowCommit` 옵션이 있을 때만 수행한다.
- git push, PR 생성, 배포는 자동화 범위에서 제외한다.

### 허용 명령과 허용 단계

명시적 Allow 옵션과 안전 조건을 만족할 때만 다음 단계를 자동화 후보로 둔다.

- `ai-dev-make-prompt.ps1`로 현재 task prompt 생성
- `ai-dev-run-codex.ps1`로 Codex 구현 실행
- `ai-dev-check.ps1`로 build/check 실행
- `ai-dev-save-diff.ps1`로 diff 저장
- `ai-dev-make-review-prompt.ps1`로 리뷰 prompt 생성
- `ai-dev-run-review-codex.ps1`로 Codex 리뷰 실행
- `ai-dev-save-review.ps1`로 리뷰 JSON 저장
- 리뷰가 `pass`이고 모든 게이트를 통과한 경우에만 `ai-dev-commit.ps1`와 `ai-dev-complete-task.ps1` 연결

### 금지 명령과 금지 단계

다음 작업은 full auto-cycle에서 자동 실행하지 않는다.

- GPT API 직접 호출
- Cline 실행
- Copilot CLI 실행
- `gh` 또는 GitHub PR 자동 연동
- `git push`
- `git reset`
- `git clean`
- destructive `git checkout` 또는 사용자 변경 되돌리기
- `npm install`
- package 대량 교체
- DB 삭제, 초기화, 복원, 마이그레이션
- 사용자 데이터 덮어쓰기

### 자동 커밋 게이트

자동 커밋은 다음 조건을 모두 만족해야만 가능하다.

- `AllowCommit`이 명시적으로 지정되어 있다.
- build/check가 성공했다.
- 리뷰 decision이 `pass`다.
- `package.json`과 `package-lock.json`이 변경되지 않았다.
- 현재 task 범위 밖 파일이 포함되지 않았다.
- dirty worktree가 예상 변경만 포함한다.
- `git reset`, `git clean`, `npm install` 없이 완료 가능하다.

다음 경우에는 자동 커밋하지 않는다.

- build/check 실패
- 리뷰 decision이 `revise` 또는 `blocked`
- 리뷰 JSON 파싱 실패
- package 파일 변경 감지
- 예상하지 못한 사용자 변경 감지
- 현재 task 범위 밖 수정 감지

### 안전 중단 조건

Codex CLI 자동화는 아래 조건에서 즉시 중단한다.

- Codex 구현 실행 전 `git status`가 dirty인 경우
- `current-task-prompt.md` 또는 `review-prompt.md`가 없거나 현재 task와 맞지 않는 경우
- Codex 실행 결과가 실패하거나 출력이 비어 있는 경우
- Codex 리뷰 결과에서 JSON 객체를 추출할 수 없는 경우
- build/check가 실패한 경우
- package 파일 변경이 감지된 경우
- 리뷰 decision이 `pass`가 아닌 경우
- DB schema 변경, 데이터 삭제, 복원, 마이그레이션이 필요한 경우
- 같은 오류가 반복되어 안전하게 진행할 수 없는 경우

실패 시에는 실패를 리뷰 결과로 오인하지 않도록 주의한다. 특히 이미 `completed`인 goal을 임시 입력 오류나 Codex 실행 실패만으로 `blocked`처럼 보이게 만들지 않는다. 필요한 경우 `state.json`에는 실패 요약만 기록하고, 기존 완료 상태를 덮어쓸지 여부는 별도 정책과 사용자 판단을 따른다.

## 자동 커밋 조건

다음 조건을 모두 만족해야 자동 커밋할 수 있다.

- 현재 task의 완료 기준을 충족했다.
- 허용된 파일만 수정되었다.
- 예상하지 못한 사용자 변경이 없다.
- 필요한 build, test, lint가 성공했다.
- 실행하지 못한 필수 검증이 없다.
- GPT 리뷰에서 P1 문제가 없다.
- 리뷰 지적사항을 반영한 뒤 재검증이 성공했다.
- `AGENTS.md`와 사용자 지시를 위반하지 않았다.
- lock file, DB schema, 보안 관련 변경이 허용 범위 밖에서 발생하지 않았다.
- 커밋에는 현재 task와 직접 관련된 변경만 포함된다.

저장소 정책이나 사용자 지시가 자동 커밋을 허용하지 않으면 커밋하지 않고 결과만 기록한다.

## `.ai-dev` 실행 산출물 커밋/무시 정책

AI Dev Loop는 실제 기능 변경과 루프 운영 상태를 분리해서 다룬다. 실행 중 생성된 파일이 존재한다는 이유만으로 기능 커밋에 함께 포함하지 않는다.

### 기능 커밋

기능 커밋에는 현재 task의 완료 기준을 충족하기 위해 실제로 수정한 코드와 문서만 포함한다.

포함 후보:

- 현재 task의 구현 코드
- 현재 task에 직접 필요한 정책 문서 또는 수동 검증 체크리스트
- 현재 task가 명시적으로 생성하도록 요구한 템플릿이나 예시 파일

기능 커밋에서 기본적으로 제외할 후보:

- `.ai-dev/queue.json`
- `.ai-dev/state.json`
- `.ai-dev/loop-log.md`
- `.ai-dev/test-result.md`
- `.ai-dev/review.md`
- `.ai-dev/diff.md`
- `.ai-dev/review-prompt.md`
- `.ai-dev/review-response.json`

### 루프 상태 커밋

루프 상태 커밋은 goal, queue, state, 검증, 리뷰, 실행 이력을 저장소에 남길 필요가 있을 때 기능 커밋과 별도로 만든다.

포함 가능 후보:

- `.ai-dev/goal.md`
- `.ai-dev/backlog.md`
- `.ai-dev/plan.md`
- `.ai-dev/queue.json`
- `.ai-dev/state.json`
- `.ai-dev/loop-log.md`
- `.ai-dev/test-result.md`
- `.ai-dev/review.md`

루프 상태 커밋도 현재 목표와 직접 관련된 파일만 선택한다. 모든 실행 산출물을 매번 커밋하는 것은 기본값이 아니다.

### 대형 또는 민감 산출물

- `.ai-dev/diff.md`와 `.ai-dev/review-prompt.md`는 전체 diff나 문서 내용을 포함해 빠르게 커질 수 있으므로 항상 커밋하지 않는다.
- `.ai-dev/review-response.json`은 외부 리뷰 응답, 민감 정보, 장문 diff를 포함할 수 있으므로 내용을 확인하기 전에는 커밋하지 않는다.
- 크기가 큰 산출물은 필요 시 정리하거나 별도 보존 정책에 따라 제외한다.
- API Key, 개인정보, 백업 데이터, 인증 정보가 포함된 산출물은 커밋하지 않는다.
- 실제 `.gitignore` 변경은 별도 task에서 필요성과 영향 범위를 검토한 뒤 진행한다.

### untracked 파일과 리뷰 입력

- untracked 텍스트 파일의 내용은 신규 파일 리뷰를 위해 diff 산출물에 포함할 수 있다.
- 리뷰에 포함했다는 사실은 해당 파일을 커밋해야 한다는 의미가 아니다.
- untracked 파일은 현재 task 범위, 민감 정보, 파일 크기, 저장소 보존 필요성을 별도로 확인한 뒤 커밋 대상을 결정한다.
- 바이너리, 대형 파일, 읽기 실패 파일은 리뷰 산출물에서 내용을 생략할 수 있다.

### 커밋 전 확인

- 커밋 전에는 `git status --short`로 변경 파일을 확인한다.
- 가능하면 커밋 스크립트의 `-DryRun` 또는 선택 파일 커밋 방식을 우선한다.
- 기능 커밋과 루프 상태 커밋이 섞여 있으면 커밋을 분리한다.
- 예상하지 못한 사용자 변경이나 현재 task 범위 밖 파일이 있으면 자동 커밋을 중단한다.
- `git add .` 또는 무조건적인 전체 stage는 사용하지 않는다.

## 중단 조건

다음 중 하나라도 발생하면 현재 task 또는 자동 개발 루프를 중단한다.

- 현재 브랜치 또는 작업 환경이 정책과 다르다.
- 작업 트리에 예상하지 못한 변경이 있다.
- 같은 검증 실패를 허용된 재시도 횟수 안에 해결하지 못한다.
- task 범위 밖 파일 수정이 필요하다.
- DB schema 변경이나 migration이 필요하다.
- 기존 데이터 손상 가능성을 안전하게 판단할 수 없다.
- 대규모 리팩터링 또는 광범위한 UI 변경이 필요하다.
- 새로운 패키지 설치나 대량 패키지 교체가 필요하다.
- 외부 네트워크, 서버 API, 인증 정보, API Key가 필요하다.
- 테스트 또는 리뷰 결과에 P1 문제가 남아 있다.
- 사용자 지시와 저장소 정책이 충돌한다.
- 사용량 한도, 권한 제한, 네트워크 제한으로 안전하게 계속할 수 없다.

중단 시 `.ai-dev/state.json`과 `.ai-dev/loop-log.md`에 중단 사유와 다음에 필요한 사용자 결정을 기록한다.

## 금지 사항

- 현재 task 범위 밖 파일을 임의로 수정하지 않는다.
- 사용자 변경 사항을 되돌리지 않는다.
- 검증 실패 상태에서 다음 task로 넘어가지 않는다.
- 검증하지 않은 결과를 통과로 기록하지 않는다.
- 리뷰에서 확인되지 않은 변경을 자동 커밋하지 않는다.
- `git add .`, 강제 push, destructive git 명령을 사용하지 않는다.
- 사용자 승인 없이 배포하거나 원격 브랜치에 push하지 않는다.
- 실제 사용자 데이터를 삭제하거나 초기화하지 않는다.
- DB schema를 계획 없이 변경하지 않는다.
- 서버 API, 로그인, 클라우드 동기화, `localStorage`를 임의로 추가하지 않는다.
- API Key, 개인정보, 백업 데이터를 외부로 전송하지 않는다.
- 자동화 편의를 위해 보안 정책이나 저장소 규칙을 완화하지 않는다.

## 초기 실험 범위

Level 5 자동 개발 루프의 초기 실험은 위험도가 낮고 되돌리기 쉬운 작업으로 제한한다.

허용 후보:

- 문서 정리
- 작은 순수 유틸 분리
- unused import 또는 helper 정리
- 기존 기능을 바꾸지 않는 작은 컴포넌트 정리
- 수동 테스트 체크리스트 보강

초기 실험에서 금지하는 작업:

- 실제 DB 삭제 또는 초기화
- DB schema 변경 또는 migration
- 대규모 리팩터링
- 패키지 대량 교체
- 현재 task 범위 밖 수정
- 파일 가져오기, 복원, 덮어쓰기, 병합처럼 데이터 손상 위험이 있는 기능
- 서버 API, 로그인, 클라우드 동기화, 알림, Capacitor 추가
- 사용자 승인 없는 push 또는 배포

## 도입 전 확인 사항

실제 자동화 스크립트를 만들기 전에 다음 항목을 별도 작업으로 확정한다.

- `.ai-dev` 파일의 JSON schema와 필수 필드
- task별 최대 재시도 횟수
- build, test, lint 명령 선택 기준
- GPT 리뷰의 P1/P2/P3 판정 기준
- 자동 커밋 허용 범위와 브랜치 정책
- 사용량 한도 또는 권한 제한 발생 시 복구 절차
- 로그 보존 기간과 민감 정보 기록 금지 기준
- 사람이 루프를 중지하거나 재개하는 방법
