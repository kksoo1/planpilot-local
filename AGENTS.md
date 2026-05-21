# PlanPilot Local Codex Rules

이 문서는 Codex가 `D:\ai-apps\planpilot-local` 프로젝트에서 작업할 때 반드시 따라야 하는 규칙이다.

## 1. 언어 규칙

- 사용자와의 대화, 작업 요약, 문서 작성은 한국어로 한다.
- 코드의 내부 식별자는 기존 스타일을 따른다.
- 사용자-facing UI 문자열은 한국어를 기본으로 한다.
- 내부 enum 값은 영어 값을 유지하고, 화면 표시 라벨만 한국어로 매핑한다.

## 2. 작업 환경

- 작업 경로는 `D:\ai-apps\planpilot-local`이다.
- 기본 터미널은 Windows PowerShell 5.1이다.
- 현재 앱은 React + Vite + TypeScript 기반 로컬 웹앱이다.
- 상태 관리는 Zustand를 사용한다.
- 데이터 저장은 Dexie.js + IndexedDB를 사용한다.

## 3. PowerShell 5.1 명령 규칙

- PowerShell 5.1에서는 `&&`를 사용하지 않는다.
- 명령은 한 줄씩 독립적으로 실행한다.
- 여러 명령을 이어 붙여 실행하지 않는다.
- 명령 실행 전에 목적과 범위를 분명히 한다.
- 읽기 명령은 필요한 파일만 대상으로 한다.

## 4. 수정 금지/주의 파일

- `src/App.css`는 사용자가 직접 관리하므로 수정하지 않는다.
- `node_modules`, `dist`, `.git` 폴더는 읽거나 수정하지 않는다.
- lock file은 사용자가 명시적으로 요청하기 전까지 수정하지 않는다.
- 사용자가 특정 파일 하나만 지정하면 그 파일 하나만 작업한다.
- 다른 파일을 읽거나 수정해야 하면 먼저 이유를 설명한다.
- 사용자가 만든 변경 사항을 되돌리지 않는다.

## 5. 앱 제약사항

- 서버 API를 사용하지 않는다.
- 로그인 기능을 구현하지 않는다.
- 클라우드 동기화 기능을 구현하지 않는다.
- `localStorage`를 사용하지 않는다.
- 로컬 저장은 IndexedDB + Dexie.js만 사용한다.
- 알림 기능은 MVP에서 구현하지 않는다.
- Android notification 권한 요청을 추가하지 않는다.
- Capacitor는 사용자가 명시적으로 요청하기 전까지 추가하지 않는다.
- 개인정보가 외부 서버로 나가지 않는 privacy-first 방향을 유지한다.

## 6. 개발 워크플로우

- 한 번에 하나의 기능만 구현한다.
- 기본적으로 한 번에 하나의 파일만 수정한다.
- 큰 변경 전에는 현재 구조와 영향 범위를 먼저 확인한다.
- 기능 추가보다 구조 정리가 필요한 상황이면 리팩터링을 먼저 제안한다.
- 수정 후에는 변경 요약과 검증 결과를 간단히 보고한다.
- 빌드나 테스트가 허용되지 않은 경우 실행하지 않고, 미검증 상태를 명확히 말한다.

## 7. Codex 작업 방식

- 파일 내용을 사용자에게 다시 요청하지 말고, 허용된 범위에서 Codex가 직접 읽는다.
- replace 또는 patch 적용이 실패하면 사용자에게 코드 조각을 요구하지 않는다.
- patch 실패 시 파일을 다시 읽고 더 작은 범위로 수정한다.
- 같은 수정이 2회 실패하면 현재 상태와 실패 원인을 보고하고 멈춘다.
- 기존 JSX 블록을 중복 생성하지 않는다.
- form, map, li 구조를 수정할 때는 기존 블록을 복사해 추가하지 말고 필요한 기존 블록만 조정한다.
- 불필요한 추상화나 대규모 재작성은 피한다.
- 기존 타입, store 액션, DB 구조를 우선 사용한다.

## 8. 빌드/검증 규칙

- 사용자가 허용한 경우에만 `npm run build`를 실행한다.
- 사용자가 허용한 경우에만 `npm run lint`를 실행한다.
- `npm run test`는 테스트 스크립트와 실행 허용 여부를 먼저 확인한다.
- 빌드 실패 시 실패 원인을 요약하고, 허용된 범위에서 수정한다.
- 브라우저 자동 실행은 하지 않는다.
- 검증을 실행하지 못한 경우 최종 답변에 반드시 명시한다.

## 9. Git 규칙

- Codex는 사용자가 "커밋까지 진행"을 명시한 작업에서만 git 명령을 실행할 수 있다.
- 허용되는 git 명령은 아래로 제한한다.
  - `git status`
  - `git diff`
  - `git diff --staged`
  - `git add <수정한 파일>`
  - `git commit -m "<작업 내용>"`
- `git add .`는 사용하지 않는다.
- `git push`는 실행하지 않는다.
- `git reset`, `git checkout`, `git restore`, `git clean`, `git rebase`, `git merge`, force push는 실행하지 않는다.
- 예상하지 못한 수정 파일이 있으면 커밋하지 말고 멈춘다.
- `npm run build`가 필요한 작업은 build 성공 후에만 commit한다.
- commit message는 영어로 짧고 명확하게 작성한다.
- 한 작업당 하나의 commit을 만든다.
- commit 후 `git status`를 확인하고 결과를 보고한다.
- 작업 중 발견한 사용자 변경 사항은 되돌리지 않는다.

## 10. App.tsx 비대화 방지 규칙

- `src/App.tsx`는 이미 커진 상태이므로 새 기능을 무조건 추가하지 않는다.
- 새 화면이나 복잡한 UI를 추가하기 전에 컴포넌트 분리를 먼저 검토한다.
- 후보 분리 단위는 `TodayView`, `TasksView`, `ProjectsView`, `SettingsView`, task form, project form 등이다.
- 파생 데이터 계산과 날짜 계산은 필요하면 유틸 또는 selector로 분리한다.
- 단순 문구 수정처럼 작은 작업이 아니면 `App.tsx`에 상태를 계속 추가하지 않는다.
- JSX 중복을 만들지 않는다.

## 11. Dexie/IndexedDB Schema 변경 규칙

- `src/db.ts`의 Dexie schema 변경 전에는 migration 계획을 먼저 세운다.
- 기존 사용자의 IndexedDB 데이터를 깨뜨리지 않는다.
- 새 필드를 추가할 때는 타입, 기본값, 이전 데이터 처리 방식을 함께 정한다.
- schema version을 올리는 경우 기존 version에서 새 version으로 이전하는 로직을 작성한다.
- `tasks`, `projects`, `appSettings` 간 데이터 일관성을 유지한다.
- 프로젝트 삭제 정책과 업무 orphan 방지 정책을 명확히 유지한다.

## 12. 금지 명령

- 사용자 허용 없이 다음 명령을 실행하지 않는다.
- `npm install`
- `npm run build`
- `npm run test`
- `npm run lint`
- `git` 관련 명령
- `Remove-Item`
- `Rename-Item`
- `Set-Content`
- `Add-Content`
- `New-Item`
- `open dist/index.html`
- 브라우저 자동 실행 명령

## 13. Preview 규칙

- 빌드 후 `open dist/index.html`을 실행하지 않는다.
- Windows PowerShell 5.1 환경에서는 `open` 명령을 사용하지 않는다.
- 사용자가 화면 확인을 요청한 경우에만 preview 실행 또는 안내를 한다.
- `npm run preview`도 사용자 허용이 있을 때만 실행한다.
- 브라우저를 자동으로 열지 않는다.
