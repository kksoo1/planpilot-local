# PlanPilot Local AI 개발 Backlog

이 문서는 추후 AI Dev Loop에서 검토할 목표 후보를 우선순위별로 정리한다.

현재 단계에서는 AI가 이 목록에서 다음 목표를 자동 선택하지 않는다. 실행할 항목은 사용자가 검토한 뒤 `.ai-dev/goal.md`로 옮긴다.

## 현재 진행 목표

- AI Dev Loop Codex CLI 완전 자동화 도입

## P0

- Codex CLI 완전 자동화 정책 문서화
- Codex 구현 실행 스크립트 추가
- Codex 리뷰 실행 스크립트 추가
- full auto-cycle 초안 추가
- 자동 커밋과 task 완료 연결
- MaxTasks 1 end-to-end 검증

## P1

- full auto-cycle 로그 구조 개선
- package 변경 감지 메시지 개선
- build/check 실패 후 revise 흐름 자동 안내
- Codex 리뷰 JSON 추출 실패 처리 보강

## P2

- GitHub PR 연동 검토
- Copilot CLI 또는 gh 연동 재검토
- 장기 실행 자동화 모니터링 정책
- 병렬 task 실행 가능성 검토

## 잠시 중단한 목표

- PlanPilot Local 업무 검색/필터 UX 개선

## 완료된 목표

- JSON 백업 import 검증 및 미리보기 기능 추가
- AI Dev Loop 운영 품질 개선 및 자동화 준비
- AI Dev Loop 자동 실행 단계 도입
- AI Dev Loop 수동 리뷰 브리지 자동화
- AI Dev Loop 수동 자동화 UX 개선

## 관리 원칙

- backlog 항목은 자동 실행이 확정된 task가 아니다.
- 위험하거나 범위가 큰 항목은 먼저 정책 문서화 task로 분리한다.
- 현재 goal과 직접 관련되지 않은 항목은 임의로 구현하지 않는다.
- 완료한 항목은 실행 결과와 문서 상태를 확인한 뒤 완료 목록으로 이동한다.
