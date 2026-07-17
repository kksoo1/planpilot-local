# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
Autopilot durable history 기록 이후 nested auto-goal dirty-worktree-gate가 `.ai-dev/autopilot-goal-history.json` 때문에 중단되는 문제를 수정한다.

## 배경
현재 Autopilot 연속 실행 중 selected/prepared/completed durable history가 기록된 직후 nested `ai-dev-auto-goal.ps1` 호출에서 작업 트리가 dirty로 판단되어 `auto_goal_failed`로 중단된다. 특히 `.ai-dev/autopilot-goal-history.json`이 새로 생성되거나 변경된 상태가 dirty gate에 걸린다.

## 성공 기준
- Autopilot이 durable history를 기록해도 nested auto-goal dirty gate가 자기 자신의 history 파일만으로 실패하지 않는다.
- `AllowRun + AllowCommit` 경로에서 history/loop-log가 필요한 시점에 안전하게 meta commit되거나 nested auto-goal 호출 전 작업 트리가 깨끗하게 유지된다.
- DryRun에서는 파일 변경이 발생하지 않는다.
- durable history 중복 방지 기능이 유지된다.
- `.ai-dev/autopilot-goal-history.json`이 장기 추적 대상이면 자동화 commit 대상에 포함된다.
- 실제 Autopilot 연속 실행 명령이 최소 1개 goal을 준비/실행 단계로 넘길 수 있다.
- 앱 `src` 파일은 수정하지 않는다.
- build/lint 검증을 통과한다.

## 제약사항
- 변경은 Autopilot/auto-goal 스크립트와 `.ai-dev` 자동화 상태 파일 범위로 제한한다.
- 기존 durable history 중복 방지 로직을 제거하지 않는다.
- DryRun 경로는 어떤 파일도 쓰지 않도록 유지한다.
- 앱 UI와 `src` 파일은 변경하지 않는다.

## 범위 제외
- 앱 기능 변경
- 대규모 스크립트 재작성
- 저장소 구조 변경
- 알림 또는 외부 연동 추가

## 수동 검증
- DryRun 실행 후 파일 변경이 없는지 확인한다.
- `AllowRun + AllowCommit` Autopilot 연속 실행이 최소 1개 goal을 준비/실행 단계로 넘기는지 확인한다.
- build와 lint를 실행해 통과 여부를 확인한다.

## Current Task

- Task ID: T001
- Title: Autopilot history dirty gate 흐름 수정
- Description: Autopilot durable history 기록 후 nested auto-goal 호출 전에 history/loop-log 변경이 dirty gate에 걸리지 않도록 작은 범위로 수정하고, DryRun 무변경 및 history 중복 방지 동작을 유지한다.
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

- scripts/ai-dev-autopilot.ps1
- scripts/ai-dev-auto-goal.ps1
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json

## Verification

- DryRun 실행 후 파일 변경이 발생하지 않는지 확인
- AllowRun + AllowCommit Autopilot 연속 실행이 최소 1개 goal을 준비/실행 단계로 넘기는지 확인
- durable history 중복 방지 동작이 유지되는지 확인
- npm run build 실행
- npm run lint 실행

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