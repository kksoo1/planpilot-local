# AI Dev Plan

## Goal

AI Dev Loop Codex CLI 완전 자동화 도입

## 목표 범위

- Codex CLI를 구현자와 리뷰어로 사용해 AI Dev Loop를 end-to-end 자동화하는 초안을 만든다.
- `current-task-prompt.md`를 Codex CLI에 전달해 현재 task 구현을 수행한다.
- `review-prompt.md`를 Codex CLI에 전달해 JSON 리뷰를 생성한다.
- Codex 구현, check/build, diff 저장, Codex 리뷰, save-review, pass 시 commit/complete-task 흐름을 연결한다.
- 초기 버전은 `MaxTasks 1`, 명시적 Allow 옵션, dirty worktree 중단, package 변경 감지, build 실패 시 commit 금지를 적용한다.

## 범위 제한

- GPT API를 직접 호출하지 않는다.
- Cline은 삭제되어 사용하지 않는다.
- Copilot CLI와 gh는 현재 사용하지 않는다.
- git push 자동화는 구현하지 않는다.
- git reset, git clean, npm install은 자동 실행하지 않는다.
- package.json/package-lock.json 변경이 감지되면 자동 커밋하지 않는다.
- build/check 실패 시 자동 커밋하지 않는다.
- scripts/src/package 파일은 각 task 범위에서만 수정한다.

## 작업 순서

### T001 Codex CLI 완전 자동화 정책 문서화

- Codex CLI를 구현자와 리뷰어로 사용하는 정책을 문서화한다.
- `codex exec` 사용 범위와 안전 기준을 정리한다.
- dirty worktree, package 변경, build 실패, 리뷰 blocked/revise 상황의 중단 조건을 정리한다.
- Cline/Copilot/GPT API 없이 진행하는 구조를 명확히 한다.

완료 기준:

- Codex CLI 사용 방식이 문서화되어 있다.
- 자동 실행 허용/금지 명령 기준이 문서화되어 있다.
- git reset, git clean, npm install 금지가 명확하다.
- package 변경 감지와 build 실패 시 자동 commit 금지가 명확하다.

T001 문서화 결과:

- Codex CLI는 구현자 역할에서 `.ai-dev/current-task-prompt.md`를 입력으로 사용한다.
- Codex CLI는 리뷰어 역할에서 `.ai-dev/review-prompt.md`를 입력으로 사용하고 JSON 리뷰를 생성한다.
- GPT API, Cline, Copilot CLI, `gh` 없이 Codex CLI만으로 구현/리뷰 흐름을 구성한다.
- 초기 full auto-cycle은 `MaxTasks 1`과 명시적 Allow 옵션을 기준으로 제한한다.
- Codex 구현은 `AllowCodex`, Codex 리뷰는 `AllowReviewCodex`, git commit은 `AllowCommit`이 있을 때만 실행한다.
- git status dirty, package 파일 변경, build/check 실패, 리뷰 decision이 `pass`가 아닌 경우 자동 커밋하지 않는다.
- `git reset`, `git clean`, `npm install`, `git push`, DB 삭제/복원/마이그레이션은 자동 실행하지 않는다.
- 실행 결과는 `.ai-dev/codex-result.md`, `.ai-dev/review-response.json`, `.ai-dev/review.md`, `.ai-dev/test-result.md`, `.ai-dev/loop-log.md`, `.ai-dev/state.json`에 기록하는 기준으로 정리했다.
- T002에서는 위 정책을 바탕으로 `scripts/ai-dev-run-codex.ps1`을 추가할 수 있다.

### T002 Codex 구현 실행 스크립트 추가

- `scripts/ai-dev-run-codex.ps1`을 추가한다.
- `current-task-prompt.md`를 Codex CLI에 전달한다.
- DryRun을 지원한다.
- `current-task-prompt.md`가 없으면 명확히 안내한다.
- git status dirty 상태에서는 기본 중단한다.
- PowerShell 문법 검증을 수행한다.

### T003 Codex 리뷰 실행 스크립트 추가

- `scripts/ai-dev-run-review-codex.ps1`을 추가한다.
- `review-prompt.md`를 Codex CLI에 전달한다.
- Codex 출력에서 JSON 객체를 추출해 `.ai-dev/review-response.json`에 저장한다.
- `ai-dev-save-review.ps1` 흐름과 연결한다.
- DryRun과 PowerShell 문법 검증을 지원한다.

### T004 full auto-cycle 초안 추가

- `scripts/ai-dev-auto-cycle-full.ps1` 초안을 추가한다.
- make-prompt, run-codex, check, save-diff, make-review-prompt, run-review-codex를 연결한다.
- `MaxTasks`, `AllowCodex`, `AllowReviewCodex`, `AllowCommit` 같은 명시적 옵션을 둔다.
- DryRun에서 전체 단계가 표시되도록 한다.

### T005 자동 커밋과 task 완료 연결

- 리뷰 결과가 pass일 때만 commit과 complete-task를 수행하도록 연결한다.
- pass가 아니면 commit하지 않는다.
- build 실패 시 commit하지 않는다.
- package 파일 변경 감지 시 중단한다.
- complete-task는 pass 이후에만 실행한다.

### T006 작은 앱 task로 end-to-end 검증

- 작은 문서 또는 UI 변경 task를 `MaxTasks 1`로 실행한다.
- Codex 구현 로그를 확인한다.
- Codex 리뷰 JSON 저장을 확인한다.
- pass 시 커밋과 complete-task가 수행되는지 확인한다.
- 최종 git status clean 여부를 확인한다.

## Stop Conditions

- Codex CLI 실행이 현재 환경에서 실패하는 경우
- git status가 dirty인데 명시적으로 허용되지 않은 경우
- package.json/package-lock.json 변경이 감지되는 경우
- build/check 실패가 발생하는 경우
- 리뷰 decision이 pass가 아닌 경우
- git reset, git clean, npm install이 필요해지는 경우
- DB 삭제, 초기화, 복원, 마이그레이션 위험이 생기는 경우
- 같은 오류가 반복되어 자동 루프가 안전하게 진행할 수 없는 경우
