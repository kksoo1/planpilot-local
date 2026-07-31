# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표

Autopilot 후보 소진 시 자동 안내 개선

## 배경

모든 backlog 후보가 durable history 또는 완료 이력에 의해 제외되는 경우, 현재 흐름이 실패처럼 보이지 않도록 안내를 정리한다. `all_goal_candidates_excluded` 상황에서 신규 goal을 자동 생성하지 않고, 후보가 왜 소진되었는지와 사용자가 다음에 선택할 수 있는 행동을 명확히 보여준다.

## 성공 기준

- `all_goal_candidates_excluded` 상황에서 실패처럼 보이는 표현을 줄이고 정상적인 후보 소진 상태로 안내한다.
- 현재 상태와 제외된 후보 수가 사용자에게 명확히 표시된다.
- 사용자가 선택할 수 있는 다음 행동이 구체적으로 안내된다.
- 새 backlog 항목을 추가해야 계속 진행할 수 있음을 명확히 안내한다.
- 기존 중복 생성 방지 정책을 유지한다.
- 실제 신규 goal 후보가 없을 때 자동으로 goal을 생성하지 않는다.

## 제약사항

- 한 번에 하나의 작은 구현 범위로 진행한다.
- 기존 Autopilot 흐름과 중복 생성 방지 정책을 우선 유지한다.
- 사용자-facing 문구는 한국어를 기본으로 한다.
- 기존 타입과 상태 흐름을 먼저 확인한 뒤 최소 범위로 수정한다.

## 범위 제외

- Autopilot 후보 선정 정책의 대규모 변경은 제외한다.
- durable history 또는 완료 이력 저장 구조 변경은 제외한다.
- 새로운 화면 추가는 제외한다.
- 알림 기능 추가는 제외한다.

## 수동 검증

- backlog 후보가 모두 제외되는 상황을 재현한다.
- `all_goal_candidates_excluded` 결과에서 현재 상태, 제외된 후보 수, 다음 선택지, 새 backlog 추가 안내가 표시되는지 확인한다.
- 신규 goal 후보가 없을 때 자동 생성이 발생하지 않는지 확인한다.
- 기존 중복 생성 방지 동작이 유지되는지 확인한다.

## Current Task

- Task ID: T001
- Title: 후보 소진 안내 개선
- Description: `all_goal_candidates_excluded` 상황의 현재 출력 흐름을 확인하고, 모든 후보가 제외된 상태가 실패처럼 보이지 않도록 한국어 안내를 최소 범위로 개선한다.
- Type: implementation
- Status: in_progress
- Priority: P1
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
- Autopilot 안내를 처리하는 관련 소스 파일

## Verification

- 모든 후보가 제외된 상황에서 현재 상태와 제외된 후보 수가 표시되는지 확인
- 다음 사용자가 선택할 수 있는 행동과 새 backlog 추가 안내가 표시되는지 확인
- 신규 goal 후보가 없을 때 자동 생성되지 않는지 확인

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