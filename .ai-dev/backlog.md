# PlanPilot Local AI 개발 Backlog

이 문서는 추후 자동 개발 루프에서 검토할 목표 후보를 우선순위별로 정리한다.

현재 단계에서는 AI가 이 목록에서 다음 목표를 자동 선택하지 않는다. 실행할 항목은 사용자가 검토한 뒤 `.ai-dev/goal.md`로 옮긴다.

## 현재 진행 목표

- AI Dev Loop 수동 자동화 UX 개선

## P0

- 수동 자동화 UX 개선 정책 문서화
- `save-review` 실패 시 상태 오염 방지
- 최종 검증 및 전체 상태 점검

## P1

- `goal_completed` 안내 개선
- `ask_gpt_review` 상태의 `auto-cycle` 안내 개선
- 최종 검증 결과를 `test-result.md`에 남기는 흐름 개선
- auto-step/auto-cycle 사용자 개입 상태 메시지 정리

## P2

- Codex CLI/Cline 자동 호출 정책 검토
- GPT API 리뷰 자동 호출 정책 검토
- 장기 자동화 루프 GitHub PR 연동 검토
- 통계 화면 후보 검토

## 완료된 목표

- JSON 백업 import 검증 및 미리보기 기능 추가
- AI Dev Loop 운영 품질 개선 및 자동화 준비
- AI Dev Loop 자동 실행 단계 도입
- AI Dev Loop 수동 리뷰 브리지 자동화

## 관리 원칙

- backlog 항목은 자동 실행이 확정된 task가 아니다.
- 위험도가 높거나 범위가 큰 항목은 먼저 정책 문서화 task로 분리한다.
- 현재 goal과 직접 관련되지 않은 항목은 임의로 구현하지 않는다.
- 완료된 항목은 실행 결과와 문서 상태를 확인한 뒤 완료 목록으로 이동한다.
