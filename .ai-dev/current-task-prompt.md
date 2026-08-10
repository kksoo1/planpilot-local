# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
AI Software Company 무인 개발 흐름에서 사람이 개입하게 만드는 commit scope 처리와 비구현 task revise 자동화를 보강한다.

## 배경
현재 자동 commit 스크립트는 디렉터리 경로가 -Files로 전달될 때 해당 디렉터리 아래의 실제 변경 파일 범위를 안정적으로 해석하지 못할 수 있다. 또한 documentation, analysis, verification task에서 strict review가 revise를 요구하는 경우 허용 범위 안의 명확한 수정임에도 자동 복구가 끊길 수 있다.

## 성공 기준
- -Files에 .ai-company/, .ai-company/reports/, ai-software-company/ 같은 디렉터리 경로가 전달되면 해당 디렉터리 아래 변경 파일로 안전하게 확장된다.
- 파일 경로와 디렉터리 경로 혼합 입력, untracked 파일, 수정 파일, 삭제 파일이 정상 처리된다.
- 선택 디렉터리 내부 변경은 선택 파일 외 staged 파일로 오판하지 않는다.
- 선택 범위 밖 staged 파일은 기존처럼 차단한다.
- repo root 밖 경로와 .. traversal 경로는 차단된다.
- 비구현 task에서 strict review가 revise를 요구하면 조건이 명확하고 파일 범위가 허용될 때 Codex 자동 재수정을 최대 1회 수행한다.
- 비구현 task의 두 번째 revise는 추가 자동 수정 없이 명확한 stopped reason으로 중단된다.
- documentation task의 BuildOnly 검증 정책에서 npm test skipped는 실패로 보지 않는다.
- implementation task의 기존 build/test/lint 정책은 유지된다.
- scripts/ai-dev-test.ps1에 실제 임시 Git 저장소 또는 worktree 기반 테스트가 추가되고 기존 안전장치는 약화되지 않는다.
- 최종 검증에서 build, 전체 npm test, lint, strict review가 통과한다.

## 제약사항
- PowerShell 5.1 호환성을 유지한다.
- UTF-8 호환성을 유지한다.
- 기존 테스트를 삭제하거나 약화하지 않는다.
- Git pathspec 의미를 무분별하게 확장하지 않는다.
- 한 번에 필요한 범위의 스크립트와 테스트만 수정한다.

## 범위 제외
- GUI 또는 Supervisor 신규 구현은 포함하지 않는다.
- 데이터 저장 구조 변경은 포함하지 않는다.
- 알림, 동기화, 인증 관련 기능은 포함하지 않는다.
- 대규모 구조 재작성은 포함하지 않는다.

## 수동 검증
- scripts/ai-dev-test.ps1 실행 결과를 확인한다.
- build, 전체 npm test, lint 결과를 확인한다.
- strict review 결과가 pass인지 확인한다.

## Current Task

- Task ID: T001
- Title: commit scope 디렉터리 확장 보강
- Description: -Files로 전달된 파일 및 디렉터리 입력을 repo 내부 실제 변경 파일 목록으로 안전하게 정규화하고, 선택 범위 밖 staged 파일 차단 로직을 유지한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

- scripts/ai-dev-commit.ps1
- scripts/ai-dev-auto-cycle-full.ps1
- scripts/ai-dev-test.ps1

## Verification

- .ai-company/ 디렉터리 대상 여러 파일 commit 성공 테스트
- .ai-company/reports/ 하위 문서 commit 성공 테스트
- 디렉터리 내부 untracked 파일 포함 테스트
- 디렉터리 내부 삭제 파일 포함 테스트
- 디렉터리 밖 staged 파일 차단 테스트
- 파일과 디렉터리 혼합 scope 처리 테스트
- repo 외부 및 traversal 경로 차단 테스트

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