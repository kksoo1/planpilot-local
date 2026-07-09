# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
Codex CLI 완전 자동화 정책을 현재 저장소의 로컬 AI Dev Loop 운영 문서로 작고 명확하게 정리한다.

## 배경
현재 프로젝트는 로컬 우선 React + Vite + TypeScript 앱이며, AI Dev Loop 상태 파일을 기준으로 작은 단위의 작업을 안전하게 진행해야 한다. Codex CLI 자동화가 어떤 조건에서 진행되고, 언제 멈추며, 어떤 검증 정보를 남겨야 하는지 문서화가 필요하다.

## 성공 기준
- Codex CLI 자동화 정책의 목적, 적용 범위, 중단 조건, 검증 기록 방식을 한국어로 문서화한다.
- 기존 프로젝트 제약을 해치지 않는 작은 문서 변경으로 제한한다.
- 자동화가 임의로 기능 범위를 넓히지 않도록 작업 단위와 상태 기록 기준을 명확히 한다.

## 제약사항
- 앱 런타임 코드와 저장 구조는 변경하지 않는다.
- 사용자-facing 문서는 한국어로 작성한다.
- 기존 AI Dev Loop 상태 파일 형식과 충돌하지 않게 작성한다.
- 한 번에 하나의 작은 문서 작업으로 진행한다.

## 범위 제외
- 새 기능 구현은 포함하지 않는다.
- UI 변경은 포함하지 않는다.
- 저장소 구조 개편은 포함하지 않는다.
- 자동화 실행 도구 자체의 구현 변경은 포함하지 않는다.

## 수동 검증
- 작성된 정책 문서가 현재 저장소 작업 규칙과 모순되지 않는지 확인한다.
- 정책 문서에 목표 진행, 검증, 중단 조건이 구체적으로 포함되어 있는지 확인한다.
- 변경 파일 수가 최소 범위인지 확인한다.


## Current Task

- Task ID: T001
- Title: Codex CLI 자동화 정책 문서 작성
- Description: 현재 저장소의 로컬 AI Dev Loop 운영 방식에 맞춰 Codex CLI 완전 자동화 정책을 한국어 문서로 정리한다.
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

- .ai-dev/goal.md
- .ai-dev/codex-cli-automation-policy.md

## Verification

- 정책 문서에 목적, 적용 범위, 작업 단위, 검증 기록, 중단 조건이 포함되어 있는지 확인한다.
- 문서 내용이 현재 저장소 작업 규칙과 충돌하지 않는지 확인한다.

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