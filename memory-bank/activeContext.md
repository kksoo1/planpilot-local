# Active Context

## Current Status
기본 MVP 구조는 생성되어 있고 빌드는 성공한 상태다.

## Completed
- React + Vite + TypeScript 프로젝트 생성
- dexie 설치
- zustand 설치
- IndexedDB 기반 DB 구현
- Zustand store 구현
- AIProvider 인터페이스 구현
- RuleBasedAIProvider 구현
- App.tsx 기본 화면 구현
- 업무 추가 폼 구현
- App.css는 사용자가 직접 관리
- Git baseline 커밋 완료
- .clineignore 생성 및 커밋 완료
- .clinerules 생성 및 커밋 완료

## Current Development Approach
Cline은 자동 개발자처럼 사용하되, 다음 규칙을 따른다.

- 한 번에 하나의 기능만 구현
- 기본적으로 한 번에 하나의 파일만 수정
- 반복 read가 발생하면 중단
- CSS는 Cline이 수정하지 않음
- 빌드 성공 후 커밋

## Next Recommended Task
업무 완료/미완료 토글 기능 추가

## Next Task Scope
- 수정 파일: `src/App.tsx`
- 사용할 store 함수: `updateTask`
- 금지:
  - App.css 수정
  - deleteTask 사용
  - 다른 파일 수정
  - 서버 API 사용
  - localStorage 사용
