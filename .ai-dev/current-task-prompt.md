# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
AI Dev Loop의 리뷰 결과가 pass인 경우 구현 변경사항 커밋, task 완료 처리, 메타 상태 커밋까지 자동으로 이어지도록 개선한다.

## 배경
현재 AI Dev Loop pass 이후에도 사용자가 후속 완료 명령과 정리 절차를 수동으로 진행해야 하는 흐름이 남아 있다. pass 결과를 신뢰할 수 있는 완료 신호로 사용해, 구현 커밋 해시를 완료 처리에 전달하고 최종 메타 상태까지 기록되도록 한다.

## 성공 기준
- 리뷰 결과가 pass일 때 구현 변경사항이 자동 커밋된다.
- 생성된 구현 커밋 해시가 complete-task 흐름에 전달된다.
- task 완료 처리 후 변경된 .ai-dev 메타 상태가 별도 커밋으로 기록된다.
- 정상 종료 시 goal completed 상태가 확인 가능하다.
- pass가 아닌 리뷰 결과에서는 자동 완료 처리가 실행되지 않는다.

## 제약사항
- 기존 AI Dev Loop 흐름과 파일 구조를 우선 사용한다.
- 한 번에 하나의 작은 구현 변경으로 처리한다.
- 사용자 변경사항을 되돌리지 않는다.
- 앱의 로컬 우선 동작 원칙을 유지한다.

## 범위 제외
- 리뷰 판단 로직 자체의 기준 변경은 제외한다.
- 대규모 구조 재작성은 제외한다.
- 새로운 외부 연동 기능 추가는 제외한다.

## 수동 검증
- pass 결과를 반환하는 로컬 루프 시나리오에서 자동 커밋과 완료 처리가 순서대로 실행되는지 확인한다.
- pass가 아닌 결과에서 자동 완료 처리가 건너뛰어지는지 확인한다.
- 종료 후 .ai-dev 상태 파일이 완료 상태를 반영하는지 확인한다.

## Current Task

- Task ID: T001
- Title: pass 이후 자동 완료 흐름 구현
- Description: AI Dev Loop 리뷰 결과가 pass일 때 구현 변경사항 커밋, complete-task 호출, .ai-dev 메타 상태 커밋이 순서대로 실행되도록 기존 루프 흐름에 최소 변경을 적용한다.
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

- .ai-dev 관련 루프 실행 스크립트
- complete-task 호출부

## Verification

- pass 리뷰 결과 시 구현 커밋 해시가 complete-task에 전달되는지 확인한다.
- task 완료 후 .ai-dev 메타 상태 커밋이 생성되는지 확인한다.
- pass가 아닌 리뷰 결과에서는 자동 완료 처리가 실행되지 않는지 확인한다.

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