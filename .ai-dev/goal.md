# Goal

AI Dev Loop 자동 실행 단계 도입

## Background

현재 state/queue/review/test/git 상태를 기반으로 다음 안전한 자동 실행 단계를 판단하고, 일부 명령을 자동 실행하는 `ai-dev-auto-step.ps1`과 반복형 `ai-dev-auto-cycle.ps1`의 초기 버전을 도입한다.

Codex/GPT API 직접 호출은 이번 목표 범위에서 제외하고, 사람이 필요한 지점에서는 프롬프트 파일 생성 후 중단한다.

## Success Criteria

- auto-step 동작 정책이 문서화된다.
- `ai-dev-auto-step.ps1`이 추가된다.
- auto-step은 DryRun과 Json 출력을 지원한다.
- auto-step은 안전한 로컬 스크립트만 자동 실행하고, Codex/GPT/commit 같은 위험 단계는 명령 안내 또는 중단으로 처리한다.
- `ai-dev-next.ps1`, `ai-dev-manual-cycle.ps1`, `ai-dev-auto-step.ps1`의 역할이 정리된다.
- `ai-dev-auto-cycle.ps1` 초기 버전이 추가된다.
- auto-cycle은 제한 횟수 내에서 auto-step을 반복하고, 사용자 개입이 필요한 지점에서 중단한다.
- PowerShell 문법 검증이 통과한다.

## Constraints

- 이번 목표는 AI Dev Loop 자동 실행 보조 스크립트와 운영 정책 개선에 한정한다.
- Codex CLI, Cline, GPT API 직접 호출은 구현하지 않는다.
- git commit, git push, destructive git 명령은 자동 실행하지 않는다.
- 사람이 필요한 지점에서는 프롬프트 파일 생성 또는 다음 명령 안내 후 중단한다.
- `src` 코드는 수정하지 않는다.
- `package.json`, `package-lock.json`은 수정하지 않는다.
- 앱 데이터, DB schema, 사용자 기능을 변경하지 않는다.

## Out of Scope

- 앱 기능 추가 또는 UI 변경
- `src` 코드 리팩터링
- package 추가 또는 교체
- Codex CLI/Cline 자동 호출
- GPT API 직접 호출
- 자동 git commit 또는 push
- CI, GitHub PR 자동 연동

## Manual Verification

- auto-step이 자동 실행 가능한 로컬 스크립트와 중단해야 하는 위험 단계를 구분한다.
- auto-step DryRun이 실제 하위 스크립트를 실행하지 않는다.
- auto-step Json 출력이 사람이 읽는 텍스트와 섞이지 않는다.
- auto-cycle이 제한 횟수 안에서만 반복한다.
- auto-cycle이 사용자 개입 필요 action에서 중단한다.
- next/manual-cycle/auto-step/auto-cycle 역할 차이가 문서화되어 있다.
- 수정된 PowerShell 스크립트가 문법 오류 없이 파싱된다.
