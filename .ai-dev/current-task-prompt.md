# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
업무 검색창 placeholder 문구를 더 명확한 한국어 문구로 개선한다.

## 배경
현재 업무 검색창의 안내 문구가 사용자가 무엇을 검색할 수 있는지 충분히 분명하지 않을 수 있다.

## 성공 기준
- 업무 검색창 placeholder가 자연스럽고 명확한 한국어 문구로 변경된다.
- 변경 범위는 placeholder 문구 수정에 한정된다.
- 기존 검색 동작과 상태 관리 방식은 유지된다.

## 제약사항
- 기존 코드 스타일과 컴포넌트 구조를 따른다.
- 사용자-facing UI 문자열은 한국어를 사용한다.
- 불필요한 리팩터링이나 구조 변경은 하지 않는다.
- 한 번에 하나의 작은 변경만 수행한다.

## 범위 제외
- 검색 기능의 동작 변경은 제외한다.
- 새 화면, 새 상태, 새 저장 구조 추가는 제외한다.
- 디자인 전반 수정은 제외한다.

## 수동 검증
- 업무 화면의 검색창에 더 명확한 placeholder 문구가 표시되는지 확인한다.
- 검색어 입력과 기존 필터링 동작이 그대로 유지되는지 확인한다.

## Current Task

- Task ID: T001
- Title: 업무 검색창 placeholder 문구 수정
- Description: 업무 검색창 입력 요소를 찾아 placeholder 문구만 더 명확한 한국어 표현으로 변경한다.
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

- src/App.tsx

## Verification

- 업무 검색창 placeholder 문구가 변경되었는지 확인한다.
- 검색 입력 동작과 기존 필터링 동작이 유지되는지 확인한다.

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