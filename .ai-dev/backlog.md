# PlanPilot Local AI 개발 Backlog

이 문서는 추후 자동 개발 루프에서 검토할 목표 후보를 우선순위별로 정리한다.

현재 단계에서는 AI가 이 목록에서 다음 목표를 자동 선택하지 않는다. 사용자가 실행할 항목을 검토한 뒤 `.ai-dev/goal.md`에 명시해야 한다.

## 현재 진행 목표

- AI Dev Loop 자동 실행 단계 도입

## P0

- auto-step 동작 정책 문서화
- `ai-dev-auto-step.ps1` 초기 버전 추가
- auto-step DryRun/Json 지원
- `ai-dev-auto-cycle.ps1` 초기 버전 추가
- 오류/로딩 상태 정책에 맞는 UI 점검

## P1

- next/manual-cycle/auto-step 역할 정리
- Codex/GPT API 연동 전 보안 정책 문서화
- 프로젝트 필터 UX 개선
- 완료 태스크 표시/보관 정책 정리
- 설정 화면 구조 정리

## P2

- Codex CLI/Cline 자동 호출 정책 검토
- GPT API 리뷰 자동 호출 정책 검토
- 장기 자동화 루프 GitHub PR 연동 검토
- 통계 화면 후보 검토

## 완료된 목표

- JSON 백업 import 검증 및 미리보기 기능 추가
- AI Dev Loop 운영 품질 개선 및 자동화 준비

## 관리 원칙

- backlog 항목은 자동 실행이 확정된 task가 아니다.
- 위험도가 높거나 범위가 큰 항목은 먼저 정책 문서화 task로 분리한다.
- 현재 goal과 직접 관련되지 않은 항목은 임의로 구현하지 않는다.
- 완료한 항목은 실행 결과와 문서 상태를 확인한 뒤 목록에서 정리한다.
