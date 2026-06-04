# AI Dev Plan

## Goal

AI Dev Loop 자동 실행 단계 도입

## 목표 범위

- 현재 queue/state/review/test/git 상태를 바탕으로 안전한 다음 단계를 판단하는 auto-step 정책을 먼저 문서화한다.
- 안전한 로컬 스크립트는 자동 실행하고, Codex/GPT/commit처럼 사용자 판단이 필요한 단계는 안내 후 중단한다.
- 제한 횟수 안에서 auto-step을 반복하는 auto-cycle 초기 버전을 도입한다.

## 범위 제한

- Codex CLI, Cline, GPT API 직접 호출은 구현하지 않는다.
- git commit, git push, destructive git 명령은 자동 실행하지 않는다.
- `src` 코드와 package 파일은 수정하지 않는다.
- auto-step/auto-cycle은 완전 자동 개발 루프가 아니라 수동 루프를 조금 더 이어주는 안전한 보조 단계로 둔다.

## 작업 순서

### T001 auto-step 동작 정책 문서화

- 자동 실행 허용 명령과 금지 명령을 구분한다.
- 사용자 개입이 필요한 지점과 중단 기준을 명시한다.
- Codex/GPT API 호출과 git commit은 이번 목표에서 자동 실행하지 않는다는 기준을 둔다.
- auto-step은 상태를 읽고 안전한 다음 한 단계만 처리한다.
- `make-prompt`, 제한된 `check`, `save-diff`, `make-review-prompt`는 자동 실행 후보로 둔다.
- Codex/Cline 작업, GPT 리뷰, revise, blocked, git commit, 데이터 삭제/복원/마이그레이션 위험은 중단 또는 안내 대상으로 둔다.
- auto-cycle은 auto-step을 제한 횟수만 반복하고 사용자 개입 필요 상태에서 중단한다.

T001 완료 기준:

- `docs/ai-dev-loop-policy.md`와 `.ai-dev/README.md`에 자동 실행 허용/금지 기준이 있다.
- Codex/GPT API 호출과 git commit을 자동 실행하지 않는 기준이 명확하다.
- next/manual-cycle/auto-step/auto-cycle 역할 구분 초안이 있다.

### T002 ai-dev-auto-step.ps1 추가

- 현재 상태를 보고 안전한 다음 한 단계를 자동 실행한다.
- 프롬프트 생성처럼 로컬 상태 파일만 다루는 단계는 자동 실행 후보로 둔다.
- Codex/GPT/review/commit 단계는 안내 또는 중단으로 처리한다.

### T003 auto-step DryRun과 Json 지원

- 실제 실행 전 어떤 작업을 할지 DryRun으로 확인한다.
- Json 출력은 텍스트와 섞이지 않게 한다.

### T004 auto-step과 next/manual-cycle 역할 정리

- `ai-dev-next.ps1`는 다음 행동 추천만 담당한다.
- `ai-dev-manual-cycle.ps1`는 상태와 다음 행동을 함께 보여준다.
- `ai-dev-auto-step.ps1`는 안전한 한 단계 실행을 담당한다.

### T005 ai-dev-auto-cycle.ps1 초기 버전 추가

- auto-step을 제한 횟수 안에서 반복 실행한다.
- 사용자 개입 필요 action, 실패, 반복 위험에서 중단한다.
- 무한 루프 방지 옵션을 둔다.

### T006 최종 검증 및 요약

- 새 스크립트의 PowerShell 문법을 검증한다.
- auto-step DryRun과 auto-cycle 제한 실행 또는 DryRun을 확인한다.
- 다음 목표로 Codex/GPT API 연동을 진행할 수 있는지 정리한다.

## Stop Conditions

- Codex/GPT API 직접 호출이 필요해지는 경우
- git commit 또는 push 자동 실행이 필요해지는 경우
- package 변경이나 새 의존성이 필요한 경우
- 앱 기능 또는 `src` 코드 수정이 필요해지는 경우
- 자동 실행 중 사용자 데이터 변경 가능성이 생기는 경우
