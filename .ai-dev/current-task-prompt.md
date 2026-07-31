# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표

auto-cycle 전체 테스트 실행과 MaxSteps 전달 검증을 보강한다.

## 배경

현재 `scripts/ai-dev-auto-cycle-full.ps1`은 implementation 및 verification task의 check와 check-revise 단계에서 `ai-dev-check.ps1`을 항상 `-BuildOnly`로 실행해 `npm test` 결과가 skipped로 덮어써질 수 있다. 또한 `scripts/ai-dev-test.ps1`의 MaxSteps 사용자 지정 검증은 정규식 확인에 머물러 실제 하위 호출 인수 전달을 충분히 검증하지 못한다.

## 성공 기준

- implementation 및 verification task의 check/check-revise 단계에서 package.json에 test script가 있으면 build, test, lint 전체 검증을 실행한다.
- documentation 또는 analysis task에서 필요한 경우에만 BuildOnly 흐름을 사용한다.
- MaxSteps 사용자 지정 검증은 격리된 임시 작업 공간에서 fake `ai-dev-auto-cycle-full.ps1`을 사용해 `ai-dev-auto-goal.ps1`이 지정된 MaxSteps 값을 실제 하위 호출 인수로 전달했는지 동작 기반으로 확인한다.
- 예시로 MaxSteps 57 지정 시 하위 스크립트가 받은 인수에 57이 기록되는지 검증한다.
- 기존 17개 expected_non_work 테스트와 baseline 보존 테스트를 유지한다.
- 전체 `npm test`가 Failed=0으로 종료되어야 한다.

## 제약사항

- 변경 범위는 관련 PowerShell 스크립트와 테스트에 한정한다.
- 기존 테스트 의도를 유지하고 필요한 검증만 보강한다.
- 로컬 저장소 구조와 기존 AI Dev Loop 상태 파일 형식을 존중한다.
- 큰 구조 변경은 피하고 작은 수정으로 해결한다.

## 범위 제외

- 신규 기능 추가는 제외한다.
- UI 변경은 제외한다.
- 데이터 저장 구조 변경은 제외한다.
- 배포 관련 변경은 제외한다.

## 수동 검증

- 허용된 경우 `npm test`를 실행해 Failed=0인지 확인한다.
- MaxSteps 57 전달 검증 로그 또는 결과가 실제 하위 호출 인수 기반인지 확인한다.

## Current Task

- Task ID: T001
- Title: auto-cycle 검증 흐름 수정
- Description: implementation 및 verification task의 check/check-revise 단계에서 test script가 있으면 build, test, lint 전체 검증을 실행하도록 `scripts/ai-dev-auto-cycle-full.ps1`의 BuildOnly 사용 조건을 조정한다.
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

- scripts/ai-dev-auto-cycle-full.ps1

## Verification

- package.json에 test script가 있는 경우 check/check-revise가 전체 검증 경로를 사용하는지 확인한다.
- analysis 또는 documentation task에서만 필요한 경우 BuildOnly가 유지되는지 확인한다.

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