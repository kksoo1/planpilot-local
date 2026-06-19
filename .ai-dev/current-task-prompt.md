# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표

AI Dev Loop의 완료 기준을 문서 또는 기존 안내 문구에 짧게 보강한다.

## 배경

현재 AI Dev Loop의 완료 조건을 더 명확히 안내할 필요가 있다. 사용자가 작업 종료 시 기대하는 기준을 빠르게 확인할 수 있도록 기존 문서나 안내 문구에 간결하게 반영한다.

## 성공 기준

- 완료 기준에 build/lint 통과가 포함된다.
- 리뷰 pass가 완료 기준에 포함된다.
- 구현 커밋이 완료 기준에 포함된다.
- complete-task 수행이 완료 기준에 포함된다.
- .ai-dev 메타 커밋이 완료 기준에 포함된다.
- 최종 git 상태가 깨끗해야 함을 명확히 적는다.
- 앱 기능 로직과 UI 동작은 변경하지 않는다.

## 제약사항

- 문서 또는 기존 안내 문구만 짧게 보강한다.
- 한 번에 하나의 작은 변경으로 처리한다.
- 기존 표현과 문서 구조를 최대한 유지한다.
- 앱 코드, 저장소 구조, 사용자 데이터 처리 방식은 변경하지 않는다.

## 범위 제외

- 앱 기능 로직 변경
- UI 동작 변경
- 새 화면 추가
- 대규모 문서 재작성
- 저장 구조 변경

## 수동 검증

- 변경된 문구가 완료 기준을 빠짐없이 포함하는지 확인한다.
- 앱 기능 또는 UI 동작 관련 파일이 변경되지 않았는지 확인한다.
- 문구가 짧고 기존 안내 흐름을 해치지 않는지 확인한다.

## Current Task

- Task ID: T001
- Title: 완료 기준 안내 문구 보강
- Description: AI Dev Loop 관련 문서 또는 기존 안내 문구에 완료 기준을 짧게 추가하고, 앱 기능 로직과 UI 동작은 변경하지 않는다.
- Type: documentation
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

## Verification

- 완료 기준에 build/lint 통과, 리뷰 pass, 구현 커밋, complete-task, .ai-dev 메타 커밋, 최종 정리 상태가 포함되는지 확인한다.
- 앱 기능 로직과 UI 동작 파일이 변경되지 않았는지 확인한다.

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