# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
Codex 리뷰 실행 스크립트 추가

## 배경
현재 저장소에서 AI Dev Loop가 Codex 리뷰를 반복적으로 실행할 수 있도록, 로컬에서 호출 가능한 최소 실행 스크립트가 필요하다. 기존 구조를 해치지 않고 자동화 루프가 사용할 수 있는 작은 단위의 실행 경로를 마련한다.

## 성공 기준
- Codex 리뷰 실행을 위한 스크립트 또는 명령 진입점이 추가된다.
- 기존 프로젝트 구조와 PowerShell 5.1 환경에서 사용할 수 있다.
- 실행 방법이 저장소 안에서 확인 가능하다.
- 변경 범위가 리뷰 실행에 필요한 파일로 제한된다.

## 제약사항
- 한 번에 하나의 작은 기능만 구현한다.
- 기존 사용자 변경 사항을 되돌리지 않는다.
- lock file은 수정하지 않는다.
- `src/App.css`는 수정하지 않는다.
- 로컬 앱의 privacy-first 제약을 유지한다.

## 범위 제외
- 앱 기능 UI 변경은 포함하지 않는다.
- 저장소 전반의 구조 재작성은 포함하지 않는다.
- 알림, 동기화, 계정 관련 기능은 포함하지 않는다.

## 수동 검증
- 추가된 스크립트 또는 명령을 PowerShell 5.1 기준으로 검토한다.
- 실행 명령이 예상 입력과 출력 흐름을 갖는지 확인한다.
- 변경 파일이 목표 범위 안에 있는지 확인한다.

## Current Task

- Task ID: T001
- Title: Codex 리뷰 실행 스크립트 추가
- Description: 현재 저장소 구조를 확인한 뒤 AI Dev Loop에서 호출할 수 있는 최소 Codex 리뷰 실행 스크립트 또는 명령 진입점을 추가한다.
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

- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev/scripts/run-codex-review.ps1

## Verification

- PowerShell 5.1에서 스크립트 문법이 유효한지 확인한다.
- 스크립트가 리뷰 실행에 필요한 입력을 명확히 다루는지 확인한다.
- 변경 범위가 Codex 리뷰 실행 스크립트 추가에 한정되는지 확인한다.

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