# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
AI Dev Loop에 제한된 autopilot 모드를 추가해, 저장된 프로젝트 비전과 backlog, 현재 상태를 바탕으로 다음 개발 goal을 자동 생성하고 기존 실행 흐름에 전달할 수 있게 한다.

## 배경
현재 AI Dev Loop는 사용자가 매번 목표 제목과 설명을 제공하는 goal 단위 실행에 가깝다. 반복 개발을 줄이려면 로컬 상태 파일을 기준으로 다음 작업을 제안하고 실행 준비까지 이어 주는 자동화 진입점이 필요하다.

## 성공 기준
- autopilot 모드를 실행하는 스크립트 또는 기존 스크립트 옵션이 추가된다.
- autopilot은 최대 실행 goal 수를 제한값으로 받거나 기본 제한값을 사용한다.
- 현재 상태와 완료 조건을 확인한 뒤 다음 goal 후보를 생성한다.
- goal 생성 실패, 검증 실패, 반복 실패, 작업 불가 상태를 state 또는 log에 명확히 기록하고 중단한다.
- 앱 src 기능 코드는 변경하지 않는다.
- 관련 사용법 문서 또는 템플릿이 함께 정리된다.

## 제약사항
- React 앱 기능 개발은 하지 않는다.
- 자동화 스크립트와 필요한 문서, 템플릿만 최소 범위로 수정한다.
- 기존 AI Dev Loop의 상태 파일 형식과 실행 흐름을 우선 재사용한다.
- 무한 반복이 아닌 제한된 반복만 허용한다.
- 실패 시 원인을 추적할 수 있는 상태 기록을 남긴다.

## 범위 제외
- 앱 화면, IndexedDB 스키마, 사용자 데이터 구조 변경은 제외한다.
- 새로운 제품 기능 구현은 제외한다.
- 대규모 구조 변경은 제외한다.

## 수동 검증
- autopilot 모드가 제한값을 인식하는지 확인한다.
- 다음 goal 생성 결과가 `.ai-dev` 상태 파일에 반영되는지 확인한다.
- 실패 조건에서 중단 사유가 기록되는지 확인한다.
- 기존 단일 goal 실행 흐름이 깨지지 않는지 확인한다.

## Current Task

- Task ID: T003
- Title: 사용법과 검증 기준 문서화
- Description: autopilot 모드 실행 방법, 제한값, 중단 조건, 수동 검증 절차를 문서나 템플릿에 정리한다.
- Type: documentation
- Status: in_progress
- Priority: P1
- Depends on:
- T002

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev

## Verification

- 문서에 실행 방법과 제한값 설명이 포함되어 있는지 확인한다.
- 중단 조건과 확인할 상태 파일이 명확히 적혀 있는지 확인한다.

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