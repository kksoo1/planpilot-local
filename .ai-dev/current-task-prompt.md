# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표

Verification task revise 자동 처리 문제를 수정한다.

## 배경

auto-cycle-full이 verification task에서 review decision=revise, next_step=revise_with_codex를 받는 경우, 실제로는 Codex 수정 루프로 이어져야 하지만 현재 non_implementation_revise로 중단되는 문제가 있다.

## 성공 기준

- verification task에서 revise_with_codex가 반환되어도 자동 수정 흐름이 중단되지 않는다.
- implementation task가 아닌 verification task에서도 의도된 수정 경로가 선택된다.
- 기존 중단 조건은 필요한 경우에만 유지된다.
- 변경 범위는 자동 루프의 분기 처리에 한정된다.

## 제약사항

- 기존 작업 큐와 상태 파일 형식을 유지한다.
- 현재 자동 루프의 기존 decision 및 next_step 의미를 보존한다.
- 불필요한 구조 변경은 하지 않는다.
- 한 번에 하나의 작은 수정으로 처리한다.

## 범위 제외

- 자동 루프 전체 구조 재설계
- 새로운 작업 유형 추가
- UI 변경
- 저장소 구조 변경

## 수동 검증

- verification task에서 review decision=revise, next_step=revise_with_codex가 발생하는 흐름을 재현한다.
- 해당 흐름이 non_implementation_revise로 중단되지 않는지 확인한다.
- 정상적인 중단 조건이 기존처럼 동작하는지 확인한다.

## Current Task

- Task ID: T001
- Title: verification revise 분기 수정
- Description: auto-cycle-full에서 verification task가 revise_with_codex를 받은 경우 non_implementation_revise로 중단하지 않고 수정 루프로 이어지도록 분기 조건을 조정한다.
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

- .ai-dev/scripts/auto-cycle-full.ps1

## Verification

- verification task에서 revise_with_codex 응답 시 중단 사유가 non_implementation_revise로 설정되지 않는지 확인한다.
- 기존 구현 작업의 revise 흐름이 유지되는지 확인한다.

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