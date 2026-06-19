# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
AI Dev Loop의 review revise 자동 재시도 흐름에서 재시도 중단 사유가 일반화되지 않도록 보강한다.

## 배경
현재 재수정 후 재리뷰 결과가 계속 decision=revise인 경우, next_step 값에 따라 최신 리뷰 사유가 충분히 보존되지 않을 수 있다. 특히 revise_with_codex 반복 제한 상황에서도 사용자가 최신 review summary, severity, next_step, lastReviewDecision을 확인할 수 있어야 한다.

## 성공 기준
- 재수정 후 재리뷰 결과가 계속 decision=revise이면 next_step 값과 관계없이 최신 review summary, severity, next_step, lastReviewDecision을 포함한 명확한 중단 메시지와 상태를 남긴다.
- next_step=revise_with_codex가 반복된 경우 기존 1회 재시도 제한 메시지를 유지하면서 최신 리뷰 사유를 함께 포함한다.
- DryRun은 Codex, check, review, commit, complete-task를 실행하지 않고 상태 변경 없이 preview만 출력한다.
- 기존 pass 처리, completed final clean, AllowCommit 처리, non-.ai-dev dirty 실패 동작은 유지한다.
- 앱 src 파일은 변경하지 않는다.
- build/lint 검증, DryRun no-mutation 검증 기록, 리뷰 pass, 구현 커밋, complete-task, .ai-dev 메타 커밋, 최종 clean 상태 확인까지 완료한다.

## 제약사항
- 변경 범위는 AI Dev Loop 스크립트와 관련 메타 파일로 제한한다.
- 기존 동작을 보존하면서 revise 중단 상태 기록만 좁게 보강한다.
- 사용자 변경 사항은 되돌리지 않는다.

## 범위 제외
- 앱 src 파일 변경은 제외한다.
- AI Dev Loop 전체 구조 재작성은 제외한다.
- 신규 기능 추가나 UI 변경은 제외한다.

## 수동 검증
- DryRun 실행 시 실행 예정 작업만 preview되고 실제 상태 변경이 없는지 확인한다.
- 재리뷰 revise 반복 시 최신 리뷰 사유가 상태와 메시지에 남는지 확인한다.
- 기존 pass 및 commit 허용 흐름이 유지되는지 확인한다.

## Current Task

- Task ID: T001
- Title: revise 재시도 중단 사유 보존 보강
- Description: ai-dev-auto-cycle-full.ps1의 review revise 자동 재시도 흐름을 좁게 수정해, 재리뷰가 계속 revise일 때 최신 리뷰 summary, severity, next_step, lastReviewDecision이 중단 메시지와 상태에 보존되도록 한다. DryRun preview-only 동작과 기존 pass, AllowCommit, final clean, dirty 실패 흐름은 유지한다.
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

- .ai-dev/ai-dev-auto-cycle-full.ps1
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json

## Verification

- build 통과 확인
- lint 통과 확인
- DryRun 실행 전후 상태 변경 없음 확인
- revise 반복 시 최신 리뷰 사유가 중단 상태에 기록되는지 확인
- 리뷰 pass 확인
- 최종 clean 상태 확인

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