# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
GitHub PR 연동 검토를 현재 PlanPilot Local 구조에 맞춰 가장 작은 실행 가능한 개발 목표로 정리한다.

## 배경
P2 백로그 항목인 GitHub PR 연동 검토는 즉시 기능 구현보다 현재 React + Vite + TypeScript, Zustand, Dexie 기반 로컬 앱 구조에서 어떤 범위가 안전한지 먼저 확인하는 작업이다. 이번 목표는 실제 연동 구현이 아니라, 현재 저장소 상태에서 다음 작업으로 옮길 수 있는 최소 검토 결과를 남기는 것이다.

## 성공 기준
- 현재 코드 구조에서 PR 관련 정보를 표시하거나 관리할 수 있는 후보 위치를 확인한다.
- MVP에서 다룰 최소 사용자 흐름과 제외할 범위를 구분한다.
- 필요한 데이터 형태와 저장 위치 후보를 간단히 정리한다.
- 후속 구현 작업으로 바로 전환 가능한 작은 작업 단위를 제안한다.

## 제약사항
- privacy-first 방향을 유지한다.
- 로컬 앱 구조와 기존 상태 관리 방식을 우선한다.
- 기존 IndexedDB 데이터를 깨뜨리는 변경은 하지 않는다.
- App.tsx에 새 복잡도를 무리하게 추가하지 않는다.
- 이번 목표에서는 검토 문서 작성 범위로 제한한다.

## 범위 제외
- 실제 GitHub 연동 구현
- 인증 흐름 구현
- 원격 데이터 자동 수집
- 데이터베이스 schema 변경
- 대규모 화면 재구성

## 수동 검증
- 작성된 검토 내용이 현재 앱 구조와 충돌하지 않는지 확인한다.
- 후속 작업이 하나의 작은 구현 단위로 분리되어 있는지 확인한다.
- 사용자-facing 문구가 한국어 기준을 따르는지 확인한다.

## Current Task

- Task ID: T001
- Title: GitHub PR 연동 검토 문서 작성
- Description: 현재 저장소 구조를 기준으로 GitHub PR 정보를 어떤 방식으로 다룰 수 있는지 검토하고, MVP 범위와 후속 구현 단위를 한국어 문서로 정리한다.
- Type: documentation
- Status: in_progress
- Priority: P2
- Depends on:
- 없음

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

- .ai-dev/goal.md
- .ai-dev/github-pr-integration-review.md

## Verification

- 검토 문서에 현재 구조 요약, 최소 범위, 제외 범위, 후속 작업이 포함되어 있는지 확인한다.
- 데이터 저장 또는 화면 변경이 필요한 경우 별도 후속 작업으로 분리되어 있는지 확인한다.

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