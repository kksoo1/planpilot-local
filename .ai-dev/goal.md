# Goal

AI Dev Loop 수동 자동화 UX 개선

## Background

GPT API 없이 사용하는 AI Dev Loop의 수동 자동화 흐름을 개선한다. `auto-step`/`auto-cycle`의 안내 메시지, `save-review` 실패 시 상태 오염 방지, 검증 결과 기록, goal completed 상태 안내, 사용자가 다음 행동을 판단하기 쉬운 출력 구조를 정리한다.

## Success Criteria

- `goal_completed` 상태에서 `auto-step`/`auto-cycle` 안내가 명확해진다.
- `ask_gpt_review` 상태에서 `auto-cycle`이 수동 리뷰 브리지 명령을 더 잘 안내한다.
- `save-review` 실패 시 `state.json`/`review.md` 오염을 줄이는 안전 정책 또는 옵션이 추가된다.
- T006 같은 최종 검증 결과를 `test-result.md`에 남기는 흐름이 개선된다.
- README와 정책 문서에 수동 자동화 UX 기준이 정리된다.
- PowerShell 문법 검증이 통과한다.
- GPT API 호출, Codex/Cline 자동 호출, git commit 자동 실행은 이번 목표 범위에서 제외한다.

## Constraints

- 이번 목표는 AI Dev Loop 수동 자동화 UX 개선에 한정한다.
- GPT API를 직접 호출하지 않는다.
- Codex CLI 또는 Cline을 자동 호출하지 않는다.
- git commit, git push, destructive git 명령은 자동 실행하지 않는다.
- `src` 코드는 수정하지 않는다.
- `package.json`, `package-lock.json`은 수정하지 않는다.
- 앱 데이터, DB schema, 사용자 기능을 변경하지 않는다.

## Out of Scope

- GPT API 직접 호출
- Codex CLI/Cline 자동 호출
- 자동 git commit 또는 push
- 앱 기능 추가 또는 UI 변경
- `src` 코드 리팩터링
- package 추가 또는 교체
- CI, GitHub PR 자동 연동

## Manual Verification

- `goal_completed` 상태의 안내가 다음 목표 시작 흐름을 이해하기 쉽게 보여준다.
- `ask_gpt_review` 상태의 `auto-cycle` 출력에서 copy-review-prompt와 save-review 명령을 확인할 수 있다.
- 잘못된 리뷰 JSON 입력이 기존 완료 상태를 불필요하게 오염시키지 않는다.
- 최종 검증 결과를 `test-result.md`에 남기는 방법이 명확하다.
- README와 정책 문서에서 GPT API 없이 쓰는 수동 자동화 UX 기준을 확인할 수 있다.
- 수정된 PowerShell 스크립트가 문법 오류 없이 파싱된다.
