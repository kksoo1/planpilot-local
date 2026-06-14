# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
AI Dev Loop auto-goal pass 이후 완료 재시도 흐름을 수정한다.

## 배경
ai-dev-auto-goal 실행 중 리뷰 결과가 pass이고 next_step이 complete_task인 상태에서도 구현 커밋, complete-task -CommitHash 처리, .ai-dev 메타 커밋으로 이어지지 않고 멈추는 문제가 있다. 또한 auto-cycle-full이 미완료 상태로 끝났을 때 auto-goal이 성공으로 오판하지 않도록 보완이 필요하다.

## 성공 기준
- 리뷰 결과 pass 이후 next_step 값이 complete_task 또는 complete-task인 경우 모두 완료 처리 흐름으로 이어진다.
- 구현 커밋 해시가 complete-task -CommitHash 단계에 정상 전달된다.
- complete-task 처리 후 .ai-dev 메타 변경 커밋 흐름이 누락되지 않는다.
- auto-cycle-full이 미완료 상태로 끝난 경우 auto-goal이 성공으로 판단하지 않는다.
- 기존 자동 루프의 정상 완료 경로는 유지된다.

## 제약사항
- 한 번에 하나의 작은 구현 변경으로 처리한다.
- 기존 스크립트 구조와 상태 파일 형식을 우선 유지한다.
- 불필요한 대규모 재작성은 하지 않는다.
- 사용자 변경 사항은 되돌리지 않는다.

## 범위 제외
- 새로운 기능 추가는 제외한다.
- UI 변경은 제외한다.
- 저장소 구조 변경은 제외한다.
- 자동 루프 전체 설계 변경은 제외한다.

## 수동 검증
- pass와 complete_task 조합에서 완료 처리 단계가 이어지는지 확인한다.
- pass와 complete-task 조합에서도 동일하게 처리되는지 확인한다.
- auto-cycle-full이 미완료 상태로 끝난 경우 실패 또는 재시도 대상으로 남는지 확인한다.

## Current Task

- Task ID: T001
- Title: auto-goal 완료 판정 흐름 수정
- Description: 리뷰 pass 이후 next_step의 complete_task와 complete-task 표기를 모두 허용하고, auto-cycle-full 미완료 종료를 성공으로 오판하지 않도록 완료 판정 조건을 보강한다.
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

- complete_task 표기에서 완료 처리 흐름이 이어지는지 확인
- complete-task 표기에서 완료 처리 흐름이 이어지는지 확인
- auto-cycle-full 미완료 종료 시 auto-goal이 성공으로 처리하지 않는지 확인

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