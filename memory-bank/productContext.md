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
- 업무 목록 표시
- 프로젝트 목록 표시
- RuleBasedAIProvider 기반 추천 업무 표시

## Future Features
- 업무 완료 토글
- 업무 삭제
- 업무 수정
- 프로젝트 추가/수정/삭제
- 프로젝트별 업무 필터
- 온디바이스 AI 기반 업무 추천
- Android Capacitor 패키징
