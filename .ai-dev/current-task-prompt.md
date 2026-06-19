# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표

AI Dev Loop 운영 기준을 `docs/ai-dev-loop-operation.md`에 짧게 보강한다.

## 배경

Goal 입력 후 자동 계획부터 최종 작업 완료 확인까지 이어지는 운영 순서를 문서에 명확히 남긴다.

## 성공 기준

- `docs/ai-dev-loop-operation.md`에 운영 완료 순서가 3~5줄로 추가 또는 보강된다.
- 포함 순서: Goal 입력 후 자동 계획, Codex 구현, build/lint 검증, 리뷰 pass, 구현 커밋, complete-task, `.ai-dev` 메타 커밋, 최종 git clean 확인.
- 기존 문서 흐름을 해치지 않고 짧고 명확한 한국어 문장으로 정리된다.

## 제약사항

- 앱 기능 로직, UI, `src` 파일은 변경하지 않는다.
- `.ai-dev/README.md`는 변경하지 않는다.
- 변경 범위는 문서 보강에 한정한다.

## 범위 제외

- 앱 기능 추가 또는 수정.
- UI 문구 변경.
- 데이터 구조나 저장 로직 변경.

## 수동 검증

- `docs/ai-dev-loop-operation.md` 변경 내용을 읽어 운영 순서가 누락 없이 포함되었는지 확인한다.
- 변경 파일이 문서 파일로만 제한되는지 확인한다.

## Current Task

- Task ID: T001
- Title: AI Dev Loop 운영 순서 문서 보강
- Description: `docs/ai-dev-loop-operation.md`에 Goal 입력 후 자동 계획부터 최종 git clean 확인까지의 완료 순서를 3~5줄로 짧게 추가하거나 보강한다.
- Type: documentation
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

- docs/ai-dev-loop-operation.md

## Verification

- 문서에 지정된 운영 순서가 모두 포함되었는지 확인한다.
- 변경 범위가 `docs/ai-dev-loop-operation.md`로 제한되었는지 확인한다.

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