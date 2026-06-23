# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
AI Dev Loop에서 구현 없는 revise 반복을 실패로 중단하도록 자동화 검증을 보강한다.

## 배경
현재 자동 실행 중 현재 task가 implementation이 아니거나 실제 구현 대상 파일 변경이 없는데도 review decision=revise가 반복될 수 있다. 또한 review-response.json이 특정 구현 파일 수정을 요구했지만 diff에 해당 파일 변경이 없으면 이전 리뷰 결과를 다시 소비하거나 구현 누락을 놓칠 위험이 있다.

## 성공 기준
- auto-goal 또는 auto-cycle 흐름에서 implementation task가 아닌 상태의 revise 반복을 성공 처리하지 않는다.
- review-response.json이 요구한 구현 파일 변경이 현재 diff에 없으면 stale review 또는 missing implementation으로 판정한다.
- 위 판정 시 후속 완료 처리와 목표 완료 처리를 막고 명확한 실패 사유를 남긴다.
- 자동화 스크립트 변경만으로 동작을 보강한다.
- 빌드와 린트가 통과하고 리뷰가 pass 상태가 된다.

## 제약사항
- 이 목표는 implementation task 1개로만 처리한다.
- 앱 src 파일은 변경하지 않는다.
- 필요한 자동화 스크립트만 최소 범위로 수정한다.
- 기존 상태 파일 형식과 자동화 흐름을 최대한 유지한다.

## 범위 제외
- 앱 기능, 화면, 저장소 구조 변경은 제외한다.
- 분석 전용 task나 문서 전용 task를 별도로 만들지 않는다.
- 자동화 흐름 전체 재작성은 제외한다.

## 수동 검증
- review-response.json이 구현 파일 변경을 요구하지만 diff에 해당 파일이 없는 상황을 확인한다.
- implementation이 아닌 task에서 revise가 반복되는 상황을 확인한다.
- 두 상황 모두 성공이나 완료로 진행되지 않고 실패 사유가 기록되는지 확인한다.

## Current Task

- Task ID: T001
- Title: 구현 없는 revise 반복 실패 처리 보강
- Description: auto-goal 또는 auto-cycle 실행 중 implementation task가 아니거나 리뷰가 요구한 구현 파일 변경이 diff에 없을 때 stale review 또는 missing implementation으로 판단하고 완료 흐름을 차단한다.
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

- scripts/ai-dev-auto-goal.ps1
- scripts/ai-dev-auto-cycle.ps1
- scripts/ai-dev-auto-cycle-full.ps1
- scripts/ai-dev-auto-step.ps1

## Verification

- implementation task가 아닌 상태에서 revise 반복 시 실패 처리되는지 확인한다.
- review-response.json이 요구한 구현 파일 변경이 diff에 없을 때 완료 흐름이 차단되는지 확인한다.
- 허용된 검증 범위에서 빌드와 린트 결과를 확인한다.

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