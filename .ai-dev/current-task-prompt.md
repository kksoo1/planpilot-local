# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표

auto-goal 실행 시 `ai-dev-auto-goal.ps1`이 full-cycle을 안정적으로 호출할 수 있도록 MaxSteps 기본값 및 전달 흐름을 정리한다.

## 배경

현재 auto-goal 흐름에서 내부적으로 `ai-dev-auto-cycle-full.ps1`을 호출할 때 전달되는 MaxSteps 값이 full-cycle의 최소 요구 단계보다 작아 `max_steps_too_small_for_full_cycle`로 중단될 수 있다. 이로 인해 auto-goal이 생성한 task가 별도 수동 재실행 없이 full-cycle까지 이어지지 못한다.

## 성공 기준

- `ai-dev-auto-goal.ps1`의 기본 MaxSteps가 full-cycle 최소 요구 단계보다 작지 않다.
- 사용자가 MaxSteps를 지정한 경우 full-cycle 호출 시 의도한 값이 안전하게 반영된다.
- 기존 `AllowCodex`, `AllowReviewCodex`, `AllowCommit`, `AllowDirty` 전달 흐름은 유지된다.
- auto-goal이 생성한 task가 기본 설정으로 full-cycle 단계까지 진행 가능하다.

## 제약사항

- 변경 범위는 auto-goal과 full-cycle 호출부 확인 및 최소 수정으로 제한한다.
- 기존 플래그 전달 방식은 유지한다.
- 관련 PowerShell 스크립트의 현재 구조를 우선 따른다.

## 범위 제외

- AI Dev Loop 전체 구조 재설계는 하지 않는다.
- unrelated 스크립트 동작 변경은 하지 않는다.
- UI나 앱 런타임 코드는 변경하지 않는다.

## 수동 검증

- `ai-dev-auto-goal.ps1`의 MaxSteps 기본값과 full-cycle 호출 인자를 확인한다.
- 기본 MaxSteps가 full-cycle 최소 요구 단계 이상인지 확인한다.
- 사용자가 MaxSteps를 지정했을 때 해당 값이 full-cycle 호출에 반영되는지 확인한다.
- 기존 허용 플래그들이 기존 이름과 의미로 전달되는지 확인한다.


## Current Task

- Task ID: T001
- Title: auto-goal MaxSteps 전달 안정화
- Description: auto-goal 스크립트의 MaxSteps 기본값과 full-cycle 호출부를 확인하고, full-cycle 최소 요구 단계보다 작아 중단되지 않도록 최소 범위로 조정한다. 기존 허용 플래그 전달 흐름은 유지한다.
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

## Verification

- MaxSteps 기본값이 full-cycle 최소 요구 단계 이상인지 확인한다.
- 사용자 지정 MaxSteps가 full-cycle 호출에 전달되는지 확인한다.
- AllowCodex, AllowReviewCodex, AllowCommit, AllowDirty 전달 흐름이 유지되는지 확인한다.

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