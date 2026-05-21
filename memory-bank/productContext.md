# Product Context

## App Name
PlanPilot Local

## Goal
개인 일정·업무 관리 앱을 만든다.

## Final Direction
- Google Play 등록 가능한 Android 앱으로 확장 예정
- 지금은 React + Vite + TypeScript 웹앱 MVP부터 개발
- 서버 없이 동작
- 로그인 없이 로컬 저장
- 개인정보가 외부 서버로 나가지 않는 privacy-first 앱
- 나중에 온디바이스 AI 기능 추가 예정

## Core Product Principles
- 서버 API 사용 금지
- localStorage 사용 금지
- 로그인 기능 없음
- 클라우드 동기화 없음
- 알림 기능은 MVP에서 구현하지 않음
- Android notification 권한 요청 금지
- Capacitor는 아직 추가하지 않음

## MVP Features
- 오늘 화면
- 전체 업무 화면
- 프로젝트 화면
- 설정 화면
- 업무 추가
- 업무 수정
- 업무 삭제
- 업무 완료/미완료 토글
- 업무 검색
- 완료 업무 표시/숨김
- 프로젝트 필터
- 마감일 빠른 순 정렬
- 업무 목록 표시
- 프로젝트 추가
- 프로젝트 수정
- 프로젝트 삭제
- 프로젝트 목록 표시
- 프로젝트별 업무 통계 표시
- RuleBasedAIProvider 기반 추천 업무 표시
- 지난 마감 업무 표시
- 7일 이내 마감 업무 표시

## Future Features
- `src/App.tsx` 화면 단위 분리
- 업무/프로젝트 폼 컴포넌트 분리
- 날짜 계산과 추천 로직 정리
- 설정 편집 기능
- 업무 상태 `todo`, `in_progress`, `done` 전체를 자연스럽게 조작하는 UI
- 태그 입력 및 필터
- 예상 소요 시간 입력/표시 개선
- 데이터 내보내기/가져오기 검토
- 온디바이스 AI 기반 업무 추천
- Android/Capacitor 전환 준비
