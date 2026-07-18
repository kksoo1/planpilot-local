# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
Codex 리뷰 결과에서 JSON 추출이 실패하는 경우에도 루프가 중단되지 않도록 실패 처리를 보강한다.

## 배경
현재 AI Dev Loop는 Codex 리뷰 응답에서 JSON을 추출해 다음 판단에 사용한다. 리뷰 응답 형식이 예상과 다르거나 JSON 파싱에 실패하면 후속 상태 기록과 재시도 판단이 불안정해질 수 있다.

## 성공 기준
- Codex 리뷰 응답에서 JSON 추출 또는 파싱이 실패해도 명확한 실패 상태가 기록된다.
- 실패 원인이 로그나 상태 파일에서 확인 가능하다.
- 기존 정상 JSON 리뷰 처리 흐름은 유지된다.
- 변경 범위는 리뷰 JSON 추출 및 실패 처리 주변으로 제한된다.

## 제약사항
- 한 번에 하나의 작은 구현 변경만 진행한다.
- 기존 상태 파일 구조와 루프 흐름을 우선 유지한다.
- 사용자 변경 사항은 되돌리지 않는다.
- 로컬 저장 및 privacy-first 제약을 유지한다.

## 범위 제외
- 리뷰 프롬프트의 전면 재작성은 하지 않는다.
- 전체 AI Dev Loop 구조 개편은 하지 않는다.
- 새로운 외부 의존성 추가는 하지 않는다.
- UI 변경은 포함하지 않는다.

## 수동 검증
- JSON이 포함된 정상 리뷰 응답에서 기존처럼 decision과 severity가 처리되는지 확인한다.
- JSON이 없거나 깨진 리뷰 응답에서 상태 파일에 실패 요약이 남고 루프가 예측 가능하게 종료 또는 재시도되는지 확인한다.

## Current Task

- Task ID: T001
- Title: 리뷰 JSON 추출 실패 처리 보강
- Description: Codex 리뷰 응답에서 JSON 추출 또는 파싱에 실패하는 경로를 확인하고, 실패 원인이 상태에 남도록 최소 범위로 보강한다.
- Type: implementation
- Status: in_progress
- Priority: P1
- Depends on:
- 없음

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

- .ai-dev 관련 루프 스크립트 또는 리뷰 처리 스크립트

## Verification

- 정상 JSON 리뷰 응답 처리 흐름이 유지되는지 확인
- JSON이 없거나 잘못된 리뷰 응답에서 실패 요약이 기록되는지 확인

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