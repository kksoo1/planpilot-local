# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표

AI Dev 자동화 테스트 체계를 추가한다.

## 배경

현재 `package.json`에 `test` 스크립트가 없어 `ai-dev-check.ps1` 실행 시 테스트 단계가 항상 skipped 처리된다. PowerShell 5.1에서 실행 가능한 자동화 검증을 추가해 AI Dev Loop의 핵심 동작을 반복 확인할 수 있게 한다.

## 성공 기준

- `npm test`로 실행되는 테스트 스크립트가 추가된다.
- PowerShell 5.1에서 실행 가능한 단위 및 통합 smoke test가 포함된다.
- 테스트는 임시 Git worktree 또는 임시 디렉터리를 사용해 실제 저장소를 오염시키지 않는다.
- auto-goal MaxSteps 기본값과 사용자 지정 값 전달을 검증한다.
- `all_goal_candidates_excluded`의 `expected_non_work` 분류를 검증한다.
- `dirty_worktree`와 `baseline_output_conflict` 상황에서 baseline 사용자 변경이 보존되는지 검증한다.
- 실행 후 새로운 staged 또는 dirty 운영 파일이 남지 않는지 검증한다.
- 테스트 실패 시 0이 아닌 종료 코드를 반환한다.
- 성공 및 실패 항목이 명확히 출력된다.
- 기존 build와 lint 흐름은 유지된다.

## 제약사항

- PowerShell 5.1 호환성을 유지한다.
- 저장소 운영 파일을 테스트 과정에서 오염시키지 않는다.
- 기존 스크립트 구조와 파일 배치를 우선 따른다.
- 한 번에 필요한 최소 파일만 변경한다.
- 기존 build와 lint 동작을 변경하지 않는다.

## 범위 제외

- 앱 기능 변경은 포함하지 않는다.
- UI 변경은 포함하지 않는다.
- 데이터 저장 구조 변경은 포함하지 않는다.
- 대규모 스크립트 재작성은 포함하지 않는다.

## 수동 검증

- `npm test` 실행 결과가 성공하는지 확인한다.
- `ai-dev-check.ps1` 실행 시 테스트 단계가 skipped되지 않는지 확인한다.
- 테스트 실행 후 작업 트리에 의도하지 않은 운영 파일 변경이 남지 않는지 확인한다.

## Current Task

- Task ID: T001
- Title: AI Dev 테스트 스크립트 추가
- Description: 현재 AI Dev 관련 스크립트 구조를 확인한 뒤 PowerShell 5.1에서 실행 가능한 자동화 테스트를 추가하고 `npm test`로 연결한다.
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

- package.json
- .ai-dev/scripts/ai-dev-test.ps1

## Verification

- `npm test`가 테스트 스크립트를 실행한다.
- MaxSteps 기본값과 사용자 지정 값 전달이 검증된다.
- `expected_non_work`, baseline 사용자 변경 보존, 실행 후 작업 트리 청결성이 검증된다.
- 실패 시 0이 아닌 종료 코드와 명확한 실패 출력이 제공된다.

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