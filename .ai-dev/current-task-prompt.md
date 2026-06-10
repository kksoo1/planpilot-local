# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
AI Dev Loop에서 커밋 완료 후 `.ai-dev/state.json`의 `lastCommitHash`가 항상 최신 커밋 해시로 기록되도록 개선한다.

## 배경
현재 자동 또는 수동 커밋 흐름이 끝난 뒤 `lastCommitHash`가 비어 있을 수 있어, 후속 단계에서 커밋 결과를 일관되게 추적하기 어렵다. `ai-dev-commit`, `commit-result-gate`, `complete-task` 흐름에서 동일한 기준으로 최신 커밋 해시를 남기도록 정리한다.

## 성공 기준
- 커밋이 성공한 뒤 `.ai-dev/state.json`의 `lastCommitHash`가 null 또는 빈 값으로 남지 않는다.
- `ai-dev-commit`, `commit-result-gate`, `complete-task` 흐름에서 최신 커밋 해시 기록 방식이 일관된다.
- 커밋이 없는 상태나 실패 상태에서는 기존 상태 흐름을 깨뜨리지 않는다.
- 변경 범위가 AI Dev Loop 상태 갱신 로직에 한정된다.

## 제약사항
- 기존 작업 큐와 상태 파일 구조를 유지한다.
- 한 번에 하나의 작은 구현 변경으로 처리한다.
- 사용자가 만든 변경 사항은 되돌리지 않는다.
- 불필요한 대규모 구조 변경은 하지 않는다.

## 범위 제외
- 새로운 기능 화면 추가는 하지 않는다.
- 상태 파일 포맷의 전면 변경은 하지 않는다.
- AI Dev Loop와 직접 관련 없는 앱 기능은 수정하지 않는다.

## 수동 검증
- 커밋 완료 흐름 이후 `.ai-dev/state.json`의 `lastCommitHash`에 최신 커밋 해시가 기록되는지 확인한다.
- 커밋 실패 또는 커밋 없음 상황에서 상태 값이 부정확하게 갱신되지 않는지 확인한다.

## Current Task

- Task ID: T001
- Title: 커밋 해시 상태 기록 흐름 개선
- Description: AI Dev Loop의 커밋 완료 처리 흐름을 확인하고, 자동 또는 수동 커밋 성공 후 `.ai-dev/state.json`의 `lastCommitHash`가 최신 커밋 해시로 남도록 상태 갱신 로직을 보강한다.
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

- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev/scripts/ai-dev-commit.ps1
- .ai-dev/scripts/commit-result-gate.ps1
- .ai-dev/scripts/complete-task.ps1

## Verification

- 커밋 성공 흐름 뒤 `.ai-dev/state.json`의 `lastCommitHash`가 최신 커밋 해시와 일치하는지 확인한다.
- 커밋이 생성되지 않은 흐름에서 `lastCommitHash`가 잘못된 값으로 갱신되지 않는지 확인한다.
- 관련 스크립트의 상태 갱신 경로가 동일한 기준을 사용하는지 확인한다.

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