# Goal

AI Dev Loop 수동 리뷰 브리지 자동화

## Background

GPT API 키 없이 ChatGPT 웹 화면을 사용하는 리뷰 흐름을 개선한다. `review-prompt.md` 생성, 클립보드 복사, ChatGPT 붙여넣기 안내, 리뷰 JSON 클립보드 저장, `save-review` 연동, `auto-step` 안내 개선을 통해 사람이 해야 하는 복사/붙여넣기 단계를 줄인다.

## Success Criteria

- GPT API 없이 동작하는 수동 리뷰 브리지 정책이 문서화된다.
- `review-prompt.md`를 클립보드에 복사하는 스크립트가 추가된다.
- 리뷰 JSON을 클립보드에서 저장하는 흐름이 명확해진다.
- `auto-step`이 `ask_gpt_review` 상태에서 더 구체적인 안내를 제공한다.
- `manual-cycle`과 README에 수동 리뷰 브리지 사용법이 정리된다.
- PowerShell 문법 검증이 통과한다.
- GPT API 호출, Codex/Cline 자동 호출, git commit 자동 실행은 이번 목표 범위에서 제외한다.

## Constraints

- 이번 목표는 AI Dev Loop 수동 리뷰 브리지와 운영 안내 개선에 한정한다.
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

- 수동 GPT 리뷰 브리지 정책이 GPT API 없이 동작하는 흐름으로 문서화되어 있다.
- `review-prompt.md`를 클립보드에 복사하는 흐름이 확인된다.
- ChatGPT에서 받은 리뷰 JSON을 클립보드에서 저장하는 흐름이 확인된다.
- `ask_gpt_review` 상태에서 `auto-step` 안내가 구체적이다.
- `manual-cycle`, `auto-step`, `copy-review-prompt`, `save-review`의 연결 흐름이 README에서 이해 가능하다.
- 수정된 PowerShell 스크립트가 문법 오류 없이 파싱된다.
