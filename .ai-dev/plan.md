# AI Dev Plan

## Goal

AI Dev Loop 수동 리뷰 브리지 자동화

## 목표 범위

- GPT API 키 없이 ChatGPT 웹 화면을 사용하는 수동 리뷰 흐름을 더 편하게 만든다.
- `review-prompt.md`를 복사하고, ChatGPT에 붙여넣고, JSON 리뷰 결과를 다시 저장하는 흐름을 정리한다.
- `auto-step`과 `manual-cycle`이 수동 리뷰 브리지 흐름을 더 구체적으로 안내하도록 준비한다.
- 이번 목표는 AI Dev Loop 운영 보조 스크립트와 문서 개선에 한정한다.

## 범위 제한

- GPT API 직접 호출은 구현하지 않는다.
- Codex CLI 또는 Cline 자동 호출은 구현하지 않는다.
- git commit, git push, destructive git 명령은 자동 실행하지 않는다.
- `src` 코드, 앱 기능, DB schema, package 파일은 수정하지 않는다.

## 작업 순서

### T001 수동 GPT 리뷰 브리지 정책 문서화

- GPT API 없이 ChatGPT 화면을 쓰는 리뷰 흐름을 문서화한다.
- `review-prompt.md` 복사, ChatGPT 붙여넣기, 리뷰 JSON 저장, `save-review -FromClipboard` 연결을 정리한다.
- 수동 단계와 자동화 가능한 단계를 구분한다.

### T002 review-prompt 클립보드 복사 스크립트 추가

- `.ai-dev/review-prompt.md`를 클립보드에 복사하는 helper를 추가한다.
- prompt가 없을 때 안내 또는 생성 옵션을 제공할지 검토한다.
- PowerShell 문법을 검증한다.

### T003 리뷰 JSON 클립보드 저장 흐름 개선

- 기존 `ai-dev-save-review.ps1 -FromClipboard` 흐름의 안내와 오류 메시지를 보강한다.
- 필요 시 얇은 wrapper 스크립트를 검토하되, 과도한 자동화는 피한다.
- 잘못된 JSON 입력 시 디버깅 가능한 메시지를 확인한다.

### T004 auto-step ask_gpt_review 안내 개선

- `ask_gpt_review` 상태에서 `copy-review-prompt`와 `save-review -FromClipboard` 명령을 더 구체적으로 안내한다.
- GPT API나 git commit은 자동 실행하지 않는다.

### T005 manual-cycle 리뷰 브리지 안내 개선

- `manual-cycle`, `auto-step`, `copy-review-prompt`, `save-review`의 연결 흐름을 README와 정책 문서에 정리한다.
- 사용자가 어떤 순서로 수동 리뷰 브리지를 사용하면 되는지 확인 가능하게 한다.

### T006 최종 검증 및 요약

- 수정된 PowerShell 스크립트 문법을 검증한다.
- 클립보드 복사 흐름과 `save-review -FromClipboard` 안내를 확인한다.
- 전체 상태를 점검하고 다음 자동화 후보를 정리한다.

## Stop Conditions

- GPT API 직접 호출이 필요해지는 경우
- Codex CLI/Cline 자동 호출이 필요해지는 경우
- git commit 또는 push 자동 실행이 필요해지는 경우
- package 변경이나 테스트 라이브러리 추가가 필요해지는 경우
- `src` 코드 또는 앱 기능 수정이 필요해지는 경우
- 사용자 데이터 변경 가능성이 생기는 경우
