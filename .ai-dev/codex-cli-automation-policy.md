# Codex CLI 완전 자동화 정책

이 문서는 PlanPilot Local의 로컬 AI Dev Loop에서 Codex CLI 자동화를 사용할 때의 목적, 적용 범위, 작업 단위, 검증 기록, 중단 조건을 정리한다. 자동화는 작은 task를 안전하게 끝내기 위한 보조 흐름이며, 저장소 규칙과 사용자 지시보다 우선하지 않는다.

## 목적

- `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json`을 기준으로 현재 task 하나만 구현, 검증, 리뷰, 기록한다.
- Codex CLI를 구현자와 리뷰어로 사용할 때 필요한 허용 조건과 중단 조건을 명확히 한다.
- 자동화가 임의로 기능 범위, 파일 범위, 검증 범위를 넓히지 않도록 상태 파일에 근거를 남긴다.
- 검증하지 않은 결과를 통과로 기록하지 않고, 사람이 이어서 판단할 수 있는 최소 정보를 남긴다.

## 적용 범위

이 정책은 현재 저장소 `D:\ai-apps\planpilot-local` 안에서 실행되는 로컬 AI Dev Loop에만 적용한다.

적용 대상:

- 현재 goal과 current task 분석
- `current-task-prompt.md` 생성
- Codex CLI 기반 현재 task 구현
- 필요한 build, lint, test 또는 수동 검증 기록
- diff 저장과 Codex CLI 리뷰
- 리뷰 pass 이후 task 완료 처리와 필요한 경우 자동 커밋
- 실패, 중단, 검증 결과를 `.ai-dev` 상태 파일에 기록하는 작업

적용 제외:

- 새 기능을 current task 밖으로 확장하는 작업
- 서버 API, 로그인, 클라우드 동기화, 알림, Capacitor 추가
- DB 삭제, 초기화, 복원, 계획 없는 migration
- package 설치, package 파일 변경, lock file 변경
- git push, PR 생성, 배포
- 사용자 변경 사항 되돌리기

## 작업 단위 기준

- 한 번에 하나의 goal 안에서 하나의 current task만 처리한다.
- 자동화는 `queue.json`의 current task 목적, scope, verification에 직접 필요한 파일만 수정한다.
- 현재 task가 문서 작업이면 앱 런타임 코드와 저장 구조를 변경하지 않는다.
- 현재 task가 앱 기능 작업이면 문서 보강, 리팩터링, 후속 개선을 임의로 함께 묶지 않는다.
- 큰 변경이 필요하다고 판단되면 현재 task에서 확장하지 않고 별도 task로 분리하거나 중단한다.
- `src/App.tsx`, `src/db.ts`, package 파일처럼 영향 범위가 큰 파일은 task 요구와 migration 계획이 명확할 때만 다룬다.

## 자동 실행 허용 조건

Codex CLI 자동화는 아래 조건이 충족될 때만 다음 단계로 진행한다.

- 사용자 지시, `AGENTS.md`, 현재 task prompt가 서로 충돌하지 않는다.
- 작업 경로가 이 저장소 루트이며, 허용된 파일 범위가 명확하다.
- current task가 존재하고 상태가 `in_progress` 또는 실행 가능한 상태다.
- 필요한 prompt 파일이 현재 goal과 current task 기준으로 생성되어 있다.
- dirty worktree가 허용된 자동화 산출물 또는 명시적으로 허용된 변경에 한정된다.
- build, lint, test, 리뷰, 커밋 같은 위험 단계는 해당 스크립트의 명시 옵션이 있을 때만 실행한다.
- 자동 커밋은 검증 통과, 리뷰 pass, package 파일 미변경, task 범위 일치가 확인된 경우에만 허용한다.

## 검증 기록 기준

검증 결과는 실제로 수행한 항목만 기록한다.

- build, lint, test를 실행했다면 명령, 결과, 실패 요약을 `.ai-dev/test-result.md`와 필요한 상태 필드에 남긴다.
- 문서 작업처럼 명령 검증이 불필요하거나 허용되지 않은 경우에는 수동 검토 항목과 미실행 사유를 기록한다.
- 리뷰를 수행했다면 decision, severity, summary, required changes, next step을 `.ai-dev/review.md`와 `state.json`에 반영한다.
- 실패한 검증을 통과로 기록하지 않는다.
- 실행하지 않은 검증은 `미실행` 또는 `사람이 별도 실행`으로 명확히 남긴다.
- 같은 실패가 반복되면 반복 횟수와 마지막 실패 요약을 `state.json` 또는 `loop-log.md`에 남긴다.

## 상태 기록 기준

자동화는 사람이 이어서 판단할 수 있도록 다음 정보를 남긴다.

- `state.json`: 현재 goal/task, 마지막 명령, 명령 상태, 리뷰 decision, 검증 시각, 중단 사유, 반복 실패 횟수
- `test-result.md`: 실제 검증 명령 또는 수동 검토 결과
- `review.md`: Codex CLI 또는 수동 리뷰 결과
- `loop-log.md`: task 진행, 완료, 중단, 실패, 커밋 결과의 시간 순서 요약
- `diff.md`와 `review-prompt.md`: 리뷰에 필요한 경우에만 생성하며, 큰 diff나 민감 정보 포함 여부를 주의한다.

상태 파일은 기존 형식과 의미를 유지한다. 자동화 편의를 위해 enum 값이나 JSON 구조를 임의로 바꾸지 않는다.

## 중단 조건

아래 조건 중 하나라도 발생하면 자동화는 다음 단계로 진행하지 않고 중단 사유를 기록한다.

- 사용자 지시, 저장소 규칙, 현재 task 요구사항이 충돌한다.
- 현재 task 범위 밖 파일 수정이 필요하다.
- package 추가, package 파일 변경, lock file 변경이 필요하다.
- DB schema 변경, 데이터 삭제, 복원, migration이 필요하다.
- package 파일 변경, build/check 실패, 리뷰 `pass` 아님, 리뷰 JSON 파싱 실패가 발생한다.
- 예상하지 못한 사용자 변경이 작업 트리에 있다.
- 같은 오류가 반복되어 현재 task 범위 안에서 안전하게 해결할 수 없다.
- 민감 정보, 개인정보, 백업 데이터, API key가 diff나 prompt에 포함될 위험이 있다.
- 네트워크, 권한, sandbox 제한 때문에 검증 또는 실행 결과를 신뢰할 수 없다.
- 자동화가 현재 task 완료 기준을 판단할 근거를 충분히 확보하지 못했다.

중단 시에는 수정 가능한 범위를 임의로 넓히지 않는다. 필요한 다음 결정, 실패한 단계, 사람이 확인할 파일을 기록하고 멈춘다.

## 완료 기준

현재 task는 아래 조건이 충족될 때 완료로 볼 수 있다.

- current task의 성공 기준을 충족했다.
- 변경 파일이 task 범위 안에 있다.
- 필요한 검증 또는 수동 검토 결과가 기록됐다.
- 리뷰가 필요한 경우 pass 또는 사람이 승인한 상태다.
- 자동 커밋이 요구된 흐름에서는 커밋 hash가 상태에 기록됐다.
- 자동 커밋이 요구되지 않은 흐름에서는 미커밋 상태와 후속 조치를 명확히 남겼다.
- 다음 task로 넘어가도 되는지 여부가 `loop-log.md` 또는 최종 작업 요약에 기록됐다.
