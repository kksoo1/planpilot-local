# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
full auto-cycle 초안을 추가한다.

## 배경
현재 저장소의 P0 백로그 항목인 full auto-cycle 초안 추가를 가장 작은 실행 가능한 단위로 진행한다. 자동 개발 루프의 흐름과 책임 범위를 문서 초안으로 정리해 이후 구현 또는 검토의 기준을 만든다.

## 성공 기준
- full auto-cycle의 목적, 입력, 처리 흐름, 종료 조건이 초안 문서에 정리된다.
- 기존 로컬 우선 구조와 현재 프로젝트 제약을 벗어나지 않는다.
- 후속 작업자가 바로 검토하거나 보완할 수 있을 만큼 항목이 구체적이다.

## 제약사항
- 한 번에 하나의 작은 문서 작업만 수행한다.
- 기존 앱 동작과 저장 구조는 변경하지 않는다.
- 사용자-facing 문구는 한국어를 기본으로 한다.
- 기존 파일 구조와 현재 프로젝트 규칙을 따른다.

## 범위 제외
- 실제 자동 실행 로직 구현은 포함하지 않는다.
- UI 변경은 포함하지 않는다.
- 저장소 구조의 대규모 정리는 포함하지 않는다.
- 배포, 외부 연동, 계정 기반 기능은 포함하지 않는다.

## 수동 검증
- 추가된 초안 문서를 열어 섹션 구성이 자연스러운지 확인한다.
- 성공 기준과 범위 제외가 이번 목표에 맞게 좁게 유지되는지 확인한다.
- 후속 구현자가 다음 작업을 식별할 수 있는지 확인한다.

## Current Task

- Task ID: T001
- Title: full auto-cycle 초안 문서 추가
- Description: full auto-cycle의 목적, 입력, 처리 흐름, 종료 조건을 작은 문서 초안으로 정리한다.
- Type: documentation
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
- .ai-dev/full-auto-cycle-draft.md

## Verification

- 문서에 목적, 입력, 처리 흐름, 종료 조건이 포함되어 있는지 확인한다.
- 이번 목표의 범위가 문서 초안 추가로 제한되어 있는지 확인한다.

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