# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표

AI Dev Loop 자동 사이클에서 lint 검증 결과를 자동으로 기록하도록 개선한다.

## 배경

현재 strict 리뷰에서 lint 실행 여부가 명확히 기록되지 않으면 `lint skipped`로 판단되어 반려될 수 있다. `npm run lint` 스크립트가 존재하는 경우 BuildOnly 검증과 별개로 lint를 실행하거나 그 결과를 `test-result.md`에 남겨 리뷰 기준을 만족해야 한다. 또한 `package.json`에 test 스크립트가 없는 경우에는 테스트를 실행하지 않은 사유를 명확히 기록해야 한다.

## 성공 기준

- `package.json`에 lint 스크립트가 있으면 AI Dev Loop 검증 기록에 lint 결과가 포함된다.
- BuildOnly 검증과 lint 검증 기록이 구분되어 남는다.
- test 스크립트가 없으면 `test-result.md`에 test 미실행 사유가 명확히 기록된다.
- strict 리뷰에서 lint 미기록으로 반려되지 않는다.

## 제약사항

- 기존 AI Dev Loop 흐름을 크게 바꾸지 않는다.
- 검증 기록 생성 로직의 변경 범위를 작게 유지한다.
- 사용자 변경 사항을 되돌리지 않는다.
- 기존 프로젝트 구조와 TypeScript 스타일을 따른다.

## 범위 제외

- 새로운 테스트 프레임워크 추가는 제외한다.
- 대규모 구조 재작성은 제외한다.
- UI 변경은 제외한다.

## 수동 검증

- lint 스크립트가 있는 상태에서 자동 사이클 결과 파일에 lint 결과가 기록되는지 확인한다.
- test 스크립트가 없는 상태에서 `test-result.md`에 미실행 사유가 기록되는지 확인한다.
- 기존 BuildOnly 검증 기록이 유지되는지 확인한다.


## Current Task

- Task ID: T001
- Title: 검증 기록 흐름 분석 및 lint 기록 개선
- Description: AI Dev Loop의 검증 결과 기록 흐름을 확인하고, lint 스크립트가 있을 때 lint 결과가 test-result.md에 자동 기록되도록 작게 수정한다. test 스크립트가 없을 때는 테스트 미실행 사유를 명확히 남긴다.
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

- .ai-dev/test-result.md
- .ai-dev 관련 자동 사이클 스크립트

## Verification

- lint 스크립트가 있는 경우 lint 결과 기록 여부 확인
- test 스크립트가 없는 경우 미실행 사유 기록 여부 확인
- BuildOnly 검증 기록과 lint 기록이 구분되는지 확인

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