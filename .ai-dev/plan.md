# AI Dev Plan

## Goal

AI Dev Loop 수동 자동화 UX 개선

## 목표 범위

- GPT API 없이 사용하는 AI Dev Loop의 수동 자동화 흐름을 더 안전하고 이해하기 쉽게 개선한다.
- `auto-step`, `auto-cycle`, `save-review`, `check`, `test-result.md` 기록 흐름의 사용자 안내를 정리한다.
- 완료 상태, 리뷰 대기 상태, 검증 결과 기록, 실패 입력 처리처럼 사용자가 다음 행동을 판단해야 하는 지점을 명확하게 만든다.

## 범위 제한

- GPT API 직접 호출은 구현하지 않는다.
- Codex CLI 또는 Cline 자동 호출은 구현하지 않는다.
- git commit, git push, destructive git 명령은 자동 실행하지 않는다.
- `src` 코드, 앱 기능, DB schema, package 파일은 수정하지 않는다.

## 작업 순서

### T001 수동 자동화 UX 개선 정책 문서화

- `auto-step`/`auto-cycle`/`save-review`/`check`/`test-result.md`의 UX 개선 방향과 안전 기준을 문서화한다.
- 상태 오염 방지와 사용자 안내 기준을 정리한다.

### T002 goal_completed 안내 개선

- `goal_completed` 상태에서 `auto-step`과 `auto-cycle`이 더 명확한 완료 안내와 다음 목표 시작 안내를 출력하도록 개선한다.
- DryRun과 JSON 출력에서 완료 상태가 이해 가능한지 확인한다.

### T003 ask_gpt_review auto-cycle 안내 개선

- `auto-cycle`이 `ask_gpt_review`에서 멈출 때 수동 리뷰 브리지 명령을 더 잘 보여주도록 개선한다.
- JSON 출력에도 copy-review-prompt와 save-review 명령이 포함되는지 확인한다.

### T004 save-review 실패 시 상태 오염 방지

- `save-review`가 잘못된 JSON 입력을 받았을 때 기존 완료 상태를 불필요하게 덮어쓰지 않도록 정책 또는 옵션을 개선한다.
- 오류 preview와 정상 저장 흐름은 유지한다.

### T005 최종 검증 기록 흐름 개선

- 최종 검증에서 PowerShell 문법 검증, `auto-step`/`auto-cycle` DryRun 결과를 `test-result.md`에 남기기 쉬운 흐름을 추가하거나 문서화한다.
- 기존 build/test/lint 흐름을 깨지 않는다.

### T006 최종 검증 및 요약

- 수정된 PowerShell 스크립트 문법을 검증한다.
- `auto-step`/`auto-cycle` DryRun을 확인한다.
- `save-review` 실패/성공 흐름을 확인한다.
- 전체 상태를 점검하고 다음 자동화 후보를 정리한다.

## Stop Conditions

- GPT API 직접 호출이 필요해지는 경우
- Codex CLI/Cline 자동 호출이 필요해지는 경우
- git commit 또는 push 자동 실행이 필요해지는 경우
- package 변경이나 테스트 라이브러리 추가가 필요해지는 경우
- `src` 코드 또는 앱 기능 수정이 필요해지는 경우
- 사용자 데이터 변경 가능성이 생기는 경우
