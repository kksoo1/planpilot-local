# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
AI Dev 자동화의 반복 실패 유형을 분류하고, 안전하게 자동 복구 가능한 경우 task별 최대 1회 재시도하도록 강화한다.

## 배경
현재 AI Dev 흐름에서는 test_failed, review_json_extraction_failed, review_revise_repeated, stale_review_required_file_missing, missing_implementation, package_files_changed 같은 실패가 반복될 수 있다. 각 실패 유형을 명확히 구분하고, 이미 구현 커밋과 최신 검증 결과가 있는 재개 흐름은 불필요하게 Codex를 다시 실행하지 않도록 한다.

## 성공 기준
- test_failed 발생 시 실패 항목과 test-result를 포함한 수정 프롬프트로 Codex 재수정을 최대 1회 수행한다.
- review_json_extraction_failed 발생 시 원본 리뷰 응답을 보존하고 JSON 추출 또는 리뷰 생성을 최대 1회 재시도한다.
- review_revise_repeated와 stale_review_required_file_missing 발생 시 최신 required_changes와 실제 changedFiles를 비교해 누락 파일만 대상으로 재시도한다.
- 최신 review가 pass이고 검증 결과가 current이며 task 구현 커밋이 존재하면 Codex 재실행 없이 다음 흐름으로 진행한다.
- package.json의 scripts 필드만 변경되고 dependencies, devDependencies, package-lock.json이 변경되지 않은 경우에만 안전한 변경으로 허용한다.
- missing_implementation은 Codex 결과와 실제 diff가 모두 없을 때만 발생한다.
- task별 복구 횟수와 최종 stopped reason을 기록해 무한 반복을 방지한다.
- 기존 영어 판정 토큰, expected_non_work 처리, baseline 사용자 변경 보존, PowerShell 5.1 호환성을 유지한다.
- npm run build, npm test 20개 이상, npm run lint가 모두 통과한다.

## 제약사항
- 한 번에 하나의 복구 흐름만 작게 구현한다.
- 기존 AI Dev 상태 파일과 queue/state 형식을 유지한다.
- 사용자 변경 사항과 baseline 변경 사항을 보존한다.
- package 의존성 및 lock file 변경은 안전 복구 대상으로 보지 않는다.
- PowerShell 5.1에서 동작하는 명령 형식을 유지한다.

## 범위 제외
- 새로운 실행 환경 도입은 제외한다.
- 대규모 구조 재작성은 제외한다.
- 알림 기능 추가는 제외한다.
- UI 화면 변경은 제외한다.

## 수동 검증
- 실패 유형별 샘플 상태를 사용해 자동 복구 횟수가 task별 최대 1회로 제한되는지 확인한다.
- 최신 review pass, current 검증, 구현 커밋 존재 조건에서 Codex 재실행 없이 이어지는지 확인한다.
- package.json scripts 단독 변경과 의존성 변경 케이스가 각각 허용/차단되는지 확인한다.

## Current Task

- Task ID: T003
- Title: 전체 검증 실행
- Description: 자동 복구 변경 후 build, test, lint를 실행해 목표 성공 기준을 최종 확인한다.
- Type: verification
- Status: in_progress
- Priority: P1
- Depends on:
- T001
- T002

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

- 없음

## Verification

- npm run build를 통과한다.
- npm test에서 20개 이상의 테스트가 통과한다.
- npm run lint를 통과한다.

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