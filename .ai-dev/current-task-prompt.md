# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# Goal

AI Dev Loop Codex CLI 완전 자동화 도입

## Background

Codex CLI를 사용해 AI Dev Loop의 구현, 검증, 리뷰, 커밋, task 완료 처리를 가능한 한 end-to-end로 자동화한다.

`current-task-prompt.md`를 Codex CLI에 전달해 코드 수정을 수행하고, `review-prompt.md`를 Codex CLI에 전달해 JSON 리뷰를 생성한 뒤, `pass`, `revise`, `blocked` 결과에 따라 자동 분기한다.

초기 버전은 안전을 위해 `MaxTasks 1`, 명시적 Allow 옵션, git status clean 확인, package 변경 감지 중단, build 실패 시 commit 금지 정책을 적용한다.

## Success Criteria

- Codex CLI 실행 정책이 문서화된다.
- `current-task-prompt.md`를 Codex CLI에 전달하는 `ai-dev-run-codex.ps1`이 추가된다.
- `review-prompt.md`를 Codex CLI에 전달하고 JSON 리뷰를 저장하는 `ai-dev-run-review-codex.ps1`이 추가된다.
- Codex 구현, build/check, diff, Codex 리뷰, save-review 흐름이 연결된다.
- pass 리뷰에서만 자동 커밋과 complete-task를 수행하는 full cycle 초안이 추가된다.
- git status가 dirty이면 Codex 실행을 중단한다.
- package.json 또는 package-lock.json 변경이 감지되면 자동 커밋하지 않는다.
- build 실패 시 자동 커밋하지 않는다.
- git reset, git clean, npm install은 자동 실행하지 않는다.
- PowerShell 문법 검증이 통과한다.
- 작은 앱 기능 task로 MaxTasks 1 end-to-end 검증이 가능하다.

## Constraints

- Codex CLI는 구현자와 리뷰어로 사용한다.
- GPT API 키 없이 진행한다.
- Cline은 삭제되어 사용하지 않는다.
- Copilot CLI와 gh는 현재 사용하지 않는다.
- 자동화는 명시적 Allow 옵션 없이는 위험한 단계를 실행하지 않는다.
- git status가 dirty이면 Codex 구현 실행을 기본 중단한다.
- package.json/package-lock.json 변경이 감지되면 자동 커밋하지 않는다.
- build/check 실패 시 자동 커밋하지 않는다.
- git reset, git clean, npm install은 자동 실행하지 않는다.
- src 코드는 각 구현 task에서만 수정한다.

## Out of Scope

- GPT API 직접 호출
- Cline 사용
- Copilot CLI 사용
- gh 또는 GitHub PR 자동 연동
- git push 자동화
- git reset/git clean 같은 destructive git 명령
- npm install 자동 실행
- package 대량 교체
- DB 삭제, 초기화, 복원, 마이그레이션 자동화

## Manual Verification

- Codex CLI 실행 정책이 문서화되어 있다.
- Codex 구현 실행 스크립트가 DryRun과 dirty worktree 중단을 지원한다.
- Codex 리뷰 실행 스크립트가 JSON 리뷰를 저장하고 save-review 흐름과 연결된다.
- full auto-cycle DryRun이 전체 단계를 보여준다.
- full auto-cycle은 MaxTasks 1 제한과 Allow 옵션을 가진다.
- pass 리뷰가 아니면 자동 커밋하지 않는다.
- build 실패 시 자동 커밋하지 않는다.
- package 파일 변경 감지 시 자동 커밋하지 않는다.
- PowerShell 문법 검증이 통과한다.
- 작은 task로 MaxTasks 1 end-to-end 검증이 가능하다.


## Current Task

- Task ID: T007
- Title: 목표 입력 기반 자동 goal 실행 스크립트 추가
- Description: 사용자가 GoalTitle과 GoalDescription만 입력하면 Codex CLI를 이용해 goal/queue/state를 생성하고, current-task-prompt 생성 후 auto-cycle-full을 실행할 수 있게 하는 ai-dev-auto-goal.ps1을 추가한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- T005

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

- scripts/ai-dev-auto-goal.ps1
- .ai-dev/README.md

## Verification

- DryRun에서 생성될 goal/task 계획과 실행 단계가 표시되는지 확인
- Json 출력이 가능한지 확인
- goal/queue/state JSON 파싱 검증을 수행하는지 확인
- auto-cycle-full 호출은 -AllowRun 또는 명시적 실행 옵션에서만 수행되는지 확인
- GoalTitle/GoalDescription이 비어 있으면 오류로 종료하는지 확인
- PowerShell 문법 검증

- 필요한 경우 `npm run build`는 사람이 별도로 실행한다.
- 이 프롬프트는 자동으로 build, test, lint를 실행하라고 지시하지 않는다.

## Required Output

- 변경한 파일 목록
- 구현 또는 분석 내용 요약
- 검증 방법
- 남은 위험
- 다음 task로 넘어가도 되는지 여부
- `.ai-dev/loop-log.md`에 기록할 작업 요약

## Hard Rules

- `src` 외 파일을 수정해야 하는 경우 이유를 기록한다.
- `package.json`과 `package-lock.json`은 수정하지 않는다. 꼭 필요하면 중단하고 이유만 기록한다.
- 실제 DB 삭제 또는 초기화를 하지 않는다.
- 사용자 데이터 복원 또는 덮어쓰기를 하지 않는다.
- 현재 task와 무관한 UI 전면 개편을 하지 않는다.
- 대규모 리팩터링을 하지 않는다.
- git commit을 실행하지 않는다.
- git reset, git checkout, git clean을 실행하지 않는다.
- npm install을 실행하지 않는다.

## Stop Conditions

- 요구사항이 충돌하는 경우
- 현재 task 범위 밖 수정이 필요한 경우
- 패키지 추가가 필요한 경우
- 데이터 삭제 또는 마이그레이션이 필요한 경우
- 같은 오류가 반복되는 경우