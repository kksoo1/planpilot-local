# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표

AI Dev Loop auto-goal 완료 직전의 최종 상태 검증을 보강하여, completed 상태로 종료된 뒤에도 .ai-dev 운영 파일 변경이 남지 않도록 한다.

## 배경

현재 ai-dev-auto-goal 실행이 goal completed로 끝난 뒤 .ai-dev/auto-goal-planning-prompt.md 삭제 같은 후처리 변경이 남아 작업 트리가 변경된 상태가 될 수 있다. 완료 상태의 의미와 실제 저장소 상태가 어긋나므로, auto-cycle-full의 메타 커밋 이후 또는 auto-goal 종료 직전에 최종 변경 상태를 확인하는 보호 장치가 필요하다.

## 성공 기준

- auto-goal이 completed 상태로 종료되기 직전에 최종 변경 상태를 확인한다.
- 남은 변경이 .ai-dev 운영 파일의 후처리 변경이면 메타 커밋 흐름에 포함되도록 처리한다.
- 메타 커밋에 포함할 수 없는 남은 변경이 있으면 completed로 종료하지 않고 실패로 처리한다.
- completed 상태에서는 후속 실행자가 즉시 확인해도 남은 변경이 없는 상태다.
- 기존 사용자 변경 사항을 되돌리거나 무시하지 않는다.

## 제약사항

- 한 번에 하나의 작은 구현 변경으로 처리한다.
- 기존 AI Dev Loop 흐름과 파일 구조를 우선 따른다.
- 사용자 변경 사항을 되돌리지 않는다.
- 서버 API, 로그인, 클라우드 동기화, DB 구조 변경은 다루지 않는다.
- 광범위한 재작성 없이 종료 검증과 메타 커밋 흐름 주변만 수정한다.

## 범위 제외

- AI Dev Loop 전체 구조 재설계
- 새로운 저장소 관리 정책 도입
- UI 변경
- 앱 런타임 기능 변경
- 데이터베이스 마이그레이션

## 수동 검증

- auto-goal 완료 직전 후처리 변경이 생기는 상황을 재현하거나 시뮬레이션한다.
- completed 종료 후 남은 변경 상태가 없는지 확인한다.
- 남은 변경을 메타 커밋에 포함할 수 없는 경우 completed가 아닌 실패 상태로 종료되는지 확인한다.

## Current Task

- Task ID: T001
- Title: auto-goal 종료 전 최종 변경 상태 검증 보강
- Description: auto-cycle-full의 메타 커밋 이후 또는 auto-goal 종료 직전에 남은 .ai-dev 운영 변경을 확인하고, 처리 가능한 변경은 메타 커밋 흐름에 포함하며 처리할 수 없는 변경은 완료가 아닌 실패로 종료하도록 보강한다.
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

- .ai-dev/auto-goal 관련 PowerShell 스크립트
- .ai-dev/auto-cycle-full 관련 PowerShell 스크립트

## Verification

- 완료 직전 남은 .ai-dev 운영 변경이 메타 커밋 흐름에 포함되는지 확인한다.
- 처리할 수 없는 남은 변경이 있을 때 completed로 종료하지 않는지 확인한다.
- 기존 사용자 변경 사항을 되돌리지 않는지 확인한다.

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