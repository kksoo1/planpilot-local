# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표

AI Dev Loop의 auto-goal 실행 경로에서 Codex 리뷰가 pass 된 뒤 후속 완료 흐름이 자동으로 이어지도록 개선한다.

## 배경

이미 별도 자동 사이클 스크립트에는 리뷰 pass 이후 구현 변경 커밋, complete-task 호출, 메타 정보 반영 흐름이 포함되어 있다. 현재 목표는 그 흐름을 실제 auto-goal 실행 경로에도 연결해 수동 개입을 줄이는 것이다.

## 성공 기준

- auto-goal 실행 중 Codex 리뷰 결과가 pass이면 구현 변경 커밋 단계가 자동으로 진행된다.
- 생성된 커밋 해시가 complete-task 호출에 전달된다.
- complete-task 이후 .ai-dev 메타 변경 반영 단계가 자동으로 이어진다.
- 모든 단계가 끝난 뒤 작업 상태 확인이 수행되고 결과가 로그로 남는다.
- 기존 실패 처리와 중단 조건은 유지된다.

## 제약사항

- 기존 ai-dev-auto-cycle-full.ps1에 있는 검증된 흐름을 우선 재사용한다.
- 변경 범위는 auto-goal 실행 경로 연결에 한정한다.
- PowerShell 5.1 호환성을 유지한다.
- 사용자 데이터 저장 구조는 변경하지 않는다.
- 불필요한 대규모 구조 변경은 하지 않는다.

## 범위 제외

- 새로운 UI 추가는 제외한다.
- 데이터베이스 스키마 변경은 제외한다.
- 알림 기능 추가는 제외한다.
- 외부 연동 기능 추가는 제외한다.

## 수동 검증

- pass 결과를 반환하는 리뷰 흐름에서 auto-goal을 실행해 후속 단계가 순서대로 진행되는지 확인한다.
- complete-task에 커밋 해시가 전달되는지 로그로 확인한다.
- 마지막 상태 확인 로그가 남는지 확인한다.

## Current Task

- Task ID: T001
- Title: auto-goal pass 이후 완료 흐름 연결
- Description: Codex 리뷰 pass 이후 실제 auto-goal 실행 경로에서 구현 변경 커밋, complete-task 커밋 해시 전달, .ai-dev 메타 반영, 최종 상태 확인이 순서대로 이어지도록 기존 자동 사이클 흐름을 연결한다.
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

- .ai-dev/scripts/ai-dev-auto-goal.ps1
- .ai-dev/scripts/ai-dev-auto-cycle-full.ps1

## Verification

- pass 리뷰 결과를 기준으로 후속 단계가 자동 실행되는지 확인한다.
- complete-task 호출에 커밋 해시가 포함되는지 확인한다.
- 완료 후 상태 확인 로그가 출력되는지 확인한다.

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