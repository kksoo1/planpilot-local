# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
AI Dev Loop 상태 출력에서 새 goal 또는 새 task가 `not_started` 상태일 때 이전 작업의 테스트 결과나 리뷰 응답 요약이 섞여 보이지 않도록 개선한다.

## 배경
현재 자동 개발 루프 상태 표시에서 오래된 test-result 또는 review-response 요약이 현재 task의 `lastCommand`, `lastReviewDecision`, `currentTaskId`, goal 상태와 맞지 않게 노출될 수 있다. 이로 인해 새 작업이 시작되지 않았거나 초기 상태인데도 이전 작업 결과가 현재 상태처럼 보이는 혼선이 생긴다.

## 성공 기준
- 현재 task가 `not_started` 또는 초기 상태일 때 이전 task의 리뷰/테스트 요약이 현재 결과처럼 표시되지 않는다.
- `currentTaskId`, goal 상태, `lastCommand`, `lastReviewDecision`과 맞지 않는 오래된 요약은 숨기거나 stale 상태로 구분된다.
- 상태 출력 로직의 변경 범위가 작고 기존 자동 개발 루프 파일 구조를 유지한다.
- 관련 상태 표시 동작을 검증할 수 있는 최소 확인 절차가 정리된다.

## 제약사항
- 앱 기능 변경이 아니라 자동 개발 루프 운영 상태 표시 개선에만 집중한다.
- 기존 상태 파일 구조와 명명 규칙을 우선 사용한다.
- 불필요한 대규모 재작성이나 추상화는 피한다.
- 사용자 변경 사항은 되돌리지 않는다.

## 범위 제외
- React 앱의 사용자 기능 변경은 포함하지 않는다.
- IndexedDB 스키마 변경은 포함하지 않는다.
- 알림, 동기화, 계정 관련 기능은 포함하지 않는다.

## 수동 검증
- 새 goal 또는 새 task를 `not_started` 상태로 두고 상태 출력에서 이전 리뷰/테스트 요약이 현재 결과처럼 보이지 않는지 확인한다.
- 현재 task와 일치하는 최신 리뷰/테스트 요약은 정상적으로 표시되는지 확인한다.
- 오래된 요약을 stale로 표시하는 경우 현재 상태와 구분 가능한지 확인한다.

## Current Task

- Task ID: T001
- Title: 상태 출력의 오래된 요약 차단
- Description: ai-dev-status 출력 로직에서 현재 task와 goal 상태에 맞지 않는 이전 리뷰 또는 테스트 요약이 표시되지 않도록 작은 범위로 개선한다.
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

## Verification

- 새 task 초기 상태에서 이전 리뷰/테스트 요약이 현재 결과처럼 표시되지 않는지 확인한다.
- 현재 task와 일치하는 최신 요약은 정상 표시되는지 확인한다.

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