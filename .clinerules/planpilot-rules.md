# PlanPilot Local Rules

## Language
- 모든 답변은 한국어로 작성한다.

## Environment
- Windows VSCode에서 작업한다.
- 기본 터미널은 Windows PowerShell 5.1이다.
- && 연산자를 사용하지 않는다.
- 명령어는 반드시 한 줄씩 따로 실행한다.
- 현재 프로젝트 경로는 D:\ai-apps\planpilot-local 이다.

## Context Limit
- 실제 LLM 서버 context size는 16K다.
- 한 번에 많은 파일을 읽지 않는다.
- 요청한 파일만 읽고 수정한다.
- 같은 파일을 반복해서 읽지 않는다.
- 파일을 20개 이상 읽기 시작하면 작업을 멈추고 사용자에게 확인한다.

## File Scope
- 사용자가 특정 파일 하나를 지정하면 그 파일 하나만 작업한다.
- 다른 파일을 읽어야 하면 먼저 이유를 설명하고 허락을 요청한다.
- src/App.css는 사용자가 직접 관리하므로 읽거나 수정하지 않는다.
- node_modules, dist, .git, lock file은 읽지 않는다.

## App Constraints
- localStorage 사용 금지.
- 서버 API 사용 금지.
- 로그인 기능 구현 금지.
- 알림 기능 구현 금지.
- Android notification 권한 요청 금지.
- Capacitor는 아직 추가하지 않는다.
- 클라우드 동기화 기능 구현 금지.

## Development Workflow
- 한 번에 하나의 기능만 구현한다.
- 한 번에 하나의 파일만 수정하는 것을 기본으로 한다.
- 부분 수정이 실패하면 반복하지 말고 멈춘다.
- 필요한 경우 파일 전체를 짧고 명확하게 다시 작성한다.
- 수정 후 npm run build를 실행한다.
- 빌드 실패 시 원인을 설명하고 수정한다.
