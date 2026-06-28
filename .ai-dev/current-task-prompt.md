# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표

AI Dev Loop 상태 출력에서 stale 상태의 Review summary가 이전 task의 상세 결과를 현재 결과처럼 보이지 않게 숨긴다.

## 배경

새 goal 또는 새 task가 `not_started` 상태일 때 이전 goal/task의 review 요약 상세가 남아 있으면 사용자가 현재 결과로 오해할 수 있다. Test result summary의 stale 숨김 동작은 유지하면서 Review summary에도 같은 기준을 적용한다.

## 성공 기준

- `ai-dev-status.ps1`에서 Review summary가 stale 상태일 때 `Decision`, `Severity`, `Next step`, `Summary`를 출력하지 않는다.
- stale Review summary에는 `Status`, `Reason`, 숨김 안내만 표시된다.
- Test result summary의 기존 stale 숨김 동작은 유지된다.
- 새 goal 또는 새 task가 `not_started` 상태일 때 이전 review/test 요약이 현재 결과처럼 표시되지 않는다.
- 앱 `src` 파일은 수정하지 않는다.

## 제약사항

- 변경 범위는 AI Dev Loop 상태 출력 스크립트에 한정한다.
- 기존 출력 구조와 용어를 최대한 유지한다.
- 불필요한 구조 변경이나 대규모 재작성은 하지 않는다.
- 앱 소스 파일은 수정하지 않는다.

## 범위 제외

- 앱 UI 변경
- 데이터 저장 구조 변경
- 새 기능 추가
- 알림 또는 외부 연동 추가

## 수동 검증

- Review summary가 stale인 상태 파일로 `ai-dev-status.ps1`을 실행했을 때 상세 항목이 숨겨지는지 확인한다.
- Test result summary의 stale 숨김 출력이 기존처럼 동작하는지 확인한다.
- `not_started` 상태의 새 task에서 이전 review/test 결과가 현재 결과처럼 보이지 않는지 확인한다.

## Current Task

- Task ID: T001
- Title: stale Review summary 상세 숨김 구현
- Description: `ai-dev-status.ps1`에서 Review summary가 stale 상태일 때 이전 task의 상세 항목을 출력하지 않고 상태, 이유, 숨김 안내만 표시하도록 수정한다. Test result summary의 stale 숨김 동작은 유지한다.
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

- .ai-dev/ai-dev-status.ps1

## Verification

- Review summary stale 상태에서 Decision, Severity, Next step, Summary가 출력되지 않는지 확인한다.
- Test result summary stale 숨김 동작이 유지되는지 확인한다.
- 새 goal 또는 새 task의 not_started 상태에서 이전 요약이 현재 결과처럼 보이지 않는지 확인한다.

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