# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
업무 카드의 보조 안내 문구 또는 aria-label을 더 자연스러운 한국어로 미세 개선한다.

## 배경
현재 업무 카드에 표시되거나 보조 기술에 전달되는 일부 안내 문구가 다소 어색할 수 있다. 기능 동작은 유지하면서 사용자-facing 문구만 작게 다듬는다.

## 성공 기준
- 업무 카드 관련 보조 안내 문구 또는 aria-label이 자연스러운 한국어로 개선된다.
- 기능 로직, 상태 관리, 저장 구조는 변경하지 않는다.
- 변경 범위는 UI 문구 수준의 최소 수정으로 제한한다.
- 기존 JSX 구조를 중복 생성하지 않는다.

## 제약사항
- 기본적으로 한 파일만 수정한다.
- src/App.css는 수정하지 않는다.
- localStorage를 사용하지 않는다.
- IndexedDB/Dexie schema는 변경하지 않는다.
- 빌드와 lint는 사용자 허용이 있을 때만 실행한다.

## 범위 제외
- 새 기능 추가
- 화면 구조 개편
- 상태 관리 변경
- 데이터 모델 변경
- 알림 기능 추가

## 수동 검증
- 업무 카드가 표시되는 화면에서 안내 문구가 자연스럽게 보이는지 확인한다.
- 버튼 또는 카드의 aria-label이 문맥에 맞는 한국어인지 확인한다.
- 기존 업무 카드 동작이 그대로 유지되는지 확인한다.

## Current Task

- Task ID: T001
- Title: 업무 카드 문구 확인 및 최소 수정
- Description: 업무 카드의 보조 안내 문구와 aria-label을 확인하고, 기능 로직을 바꾸지 않는 범위에서 자연스러운 한국어로 미세 조정한다.
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

- 변경된 문구가 업무 카드 문맥에 자연스럽게 맞는지 확인한다.
- 기능 로직이나 데이터 저장 관련 코드가 변경되지 않았는지 확인한다.

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