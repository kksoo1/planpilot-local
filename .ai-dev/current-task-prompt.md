# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
AI Dev Loop의 `auto-cycle-full` 완료 종료 경로에서 운영 산출물 변경을 최종 정리하도록 보강한다.

## 배경
기존 `in_progress` 목표를 이어 실행했을 때 모든 task가 `done`이 되어 `goalStatus`가 `completed`가 되었지만 `.ai-dev` 운영 산출물이 작업 트리에 남는 문제가 있다. 완료 상태 재실행 시에도 운영 산출물만 남아 있으면 최종 메타 커밋으로 정리되어야 한다.

## 성공 기준
- `ai-dev-auto-cycle-full.ps1`의 completed 종료 경로에서 남은 변경을 최종 분류한다.
- 남은 변경이 `.ai-dev` 운영 파일뿐이고 커밋 허용 옵션이 켜져 있으면 final meta commit을 생성한다.
- final meta commit 후 작업 트리 상태가 비어 있는지 검증한다.
- `.ai-dev` 외 변경이 남아 있거나 커밋 허용 옵션이 꺼져 있으면 completed 성공으로 종료하지 않고 실패로 처리한다.
- 이미 `goalStatus`가 `completed`인 상태에서 `.ai-dev` 운영 변경만 남아 있는 경우에도 재실행 시 최종 메타 커밋 후 정리된다.
- 앱 `src` 파일은 변경하지 않는다.
- build/lint 통과, 리뷰 pass, 구현 커밋, complete-task, `.ai-dev` 메타 커밋, 최종 작업 트리 정리 검증까지 완료한다.

## 제약사항
- 앱 `src` 파일은 변경하지 않는다.
- 한 번에 하나의 작은 구현 변경으로 제한한다.
- 기존 AI Dev Loop 상태 파일 형식과 스크립트 흐름을 유지한다.
- 사용자가 만든 변경 사항을 되돌리지 않는다.

## 범위 제외
- 앱 기능 변경
- IndexedDB 또는 데이터 모델 변경
- 대규모 스크립트 재작성
- 알림, 동기화, 인증 관련 기능

## 수동 검증
- 완료 상태에서 `.ai-dev` 운영 산출물만 남은 상황을 만든 뒤 `-AllowCommit` 옵션으로 재실행해 final meta commit이 생성되는지 확인한다.
- `.ai-dev` 외 변경이 남은 상황에서는 completed 성공으로 처리되지 않는지 확인한다.
- 최종 작업 트리 상태가 비어 있는지 확인한다.

## Current Task

- Task ID: T001
- Title: 완료 종료 경로 최종 정리 보강
- Description: `ai-dev-auto-cycle-full.ps1`의 completed 종료 경로와 이미 completed 상태 재실행 경로에서 남은 변경을 분류하고, `.ai-dev` 운영 파일만 남은 경우 허용 옵션에 따라 final meta commit을 생성한 뒤 작업 트리 정리 상태를 검증한다. `.ai-dev` 외 변경이 있거나 커밋이 허용되지 않으면 명확한 실패로 종료한다.
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

- .ai-dev/scripts/ai-dev-auto-cycle-full.ps1

## Verification

- build 통과 확인
- lint 통과 확인
- 리뷰 pass 확인
- 완료 상태에서 `.ai-dev` 운영 변경만 남은 재실행 케이스 확인
- `.ai-dev` 외 변경이 남은 실패 케이스 확인
- 최종 작업 트리 정리 상태 확인

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