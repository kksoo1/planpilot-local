# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
자동화가 구현 시작 전 예상 가능한 사유로 중단될 때, 이번 실행에서 생성하거나 수정한 운영 파일만 안전하게 정리해 다음 auto-goal 실행이 수동 정리 없이 시작될 수 있게 한다.

## 배경
`ai-dev-autopilot.ps1` 또는 `ai-dev-auto-goal.ps1`이 `all_goal_candidates_excluded`, `baseline_output_conflict`, `dirty_worktree`, `max_steps_too_small_for_full_cycle` 같은 사유로 구현 단계 전에 종료되면 `state.json`, `codex-result.md`, `loop-log.md`, `autopilot-goal-history.json` 등 운영 파일이 불필요하게 dirty 상태로 남을 수 있다. 실행 전부터 존재하던 사용자 변경은 보존해야 하며, 자동화가 이번 실행에서 만든 변경만 정리 대상이어야 한다.

## 성공 기준
- 구현 시작 전 예상된 비작업 종료와 실제 실패를 구분해 기록한다.
- 이번 실행에서 만든 운영 파일 변경만 정리하거나 메타 커밋 대상으로 분류한다.
- 실행 전부터 존재하던 사용자 변경은 삭제하거나 복원하지 않는다.
- 다음 auto-goal 실행이 수동 정리 없이 시작될 수 있다.
- 정리 대상과 보존 대상의 판단 근거가 코드상 명확하다.

## 제약사항
- 기존 사용자 변경을 되돌리지 않는다.
- 운영 파일 정리 범위는 자동화 실행 중 생성된 변경으로 제한한다.
- 한 번에 작은 변경으로 구현한다.
- 기존 스크립트 구조와 기록 방식을 우선 따른다.

## 범위 제외
- 자동화 실행 흐름의 대규모 재작성은 제외한다.
- 새로운 저장소 구조 도입은 제외한다.
- UI 기능 추가는 제외한다.
- 알림 기능 추가는 제외한다.

## 수동 검증
- 구현 시작 전 중단 사유별로 운영 파일이 불필요하게 dirty 상태로 남지 않는지 확인한다.
- 실행 전부터 수정되어 있던 운영 파일이 보존되는지 확인한다.
- 성공, 예상된 비작업 종료, 실제 실패 기록이 구분되는지 확인한다.

## Current Task

- Task ID: T001
- Title: 운영 파일 정리 흐름 안정화
- Description: 자동화가 구현 시작 전 예상된 사유로 중단될 때 이번 실행에서 만든 운영 파일 변경만 정리하거나 메타 기록 대상으로 분류하도록 기존 흐름을 점검하고 최소 수정한다.
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

- .ai-dev/ai-dev-autopilot.ps1
- .ai-dev/ai-dev-auto-goal.ps1

## Verification

- 예상된 비작업 종료 사유에서 운영 파일 변경 처리 경로를 확인한다.
- 실행 전부터 있던 사용자 변경을 보존하는 조건을 확인한다.
- 성공, 예상된 비작업 종료, 실제 실패 기록이 구분되는지 확인한다.

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