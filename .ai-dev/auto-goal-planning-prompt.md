You are preparing local AI Dev Loop state files for the repository at D:\ai-apps\planpilot-local.

Return exactly one JSON object and no markdown fences or commentary.

The user supplied this new goal:
Title: AI Software Company 고객 포털과 자율 개발회사 운영 기반 구축
Description: 기존 PlanPilot AI Dev 자동화 엔진을 기반으로 고객이 제품을 의뢰하고 AI 소프트웨어 회사가 CEO 중심으로 분석, 개발, 검증, 납품하는 로컬 AI Software Company 운영 플랫폼을 구축한다. 기존 scripts/ai-dev-* 자동화와 151개 이상의 회귀 테스트를 재사용하고 약화하거나 중복 구현하지 않는다.

[최상위 운영 모델]
사용자는 개발팀 관리자가 아니라 고객/발주자다. 고객은 제품 요구사항을 회사에 의뢰하고 진행상황을 확인하며 제품 방향에 영향을 주는 중요한 의사결정에만 응답하고 최종 납품을 승인 또는 수정 요청한다. 회사 내부의 세부 기술 결정, Task 분해, 구현, 테스트, 리뷰, 자동복구, 커밋은 회사가 자율적으로 수행한다.

[회사 조직]
CEO Agent를 최상위 의사결정자로 둔다.
CEO 아래에 Product, CTO/Architecture, Project Management, Development, QA, Code Review, Recovery, Release 역할을 둔다.
논리적인 Agent 역할이며 반드시 별도 LLM 프로세스를 동시에 실행할 필요는 없다.
기존 Codex 실행기를 역할별 프롬프트와 상태로 재사용한다.

CEO 책임:
- 고객 제품 의뢰 접수
- 요구사항 요약 및 Project Brief 생성
- 프로젝트 개발 가능 여부 판단
- 고객 요구사항과 회사 내부 Task의 경계 관리
- Product/CTO/PM에 내부 업무 배정
- 고객 의사결정이 필요한 상황 판정
- QA와 Review 결과 확인
- 최초 고객 요구사항과 최종 결과 비교
- DELIVERY_APPROVED 또는 BLOCKED 결정
- 고객에게 최종 납품 보고서 제공

고객에게 질문하는 것은 제품 자체가 달라지는 결정으로 제한한다.
버튼 위치, 함수명, 컴포넌트 분리, 파일 구조, 테스트 방식, 일반적인 리팩터링, 구현 순서 같은 개발 세부사항은 회사가 자율적으로 결정한다.
기존 기능 삭제, 대규모 데이터 구조 변경, 유료 외부 서비스 도입, 보안 위험, 서로 충돌하는 제품 요구사항, 요구범위의 중대한 확대처럼 제품 의사결정이 필요한 경우에만 CUSTOMER_DECISION_REQUIRED 상태를 만든다.
이때 CEO 추천안, 이유, 선택지, 직접 의견 입력을 고객 포털에 표시한다.

[프로젝트 생명주기]
CUSTOMER_REQUEST
→ CEO_REVIEW
→ PRODUCT_ANALYSIS
→ TECH_DESIGN
→ PROJECT_PLANNING
→ DEVELOPMENT
→ QA
→ REVIEW
→ RECOVERY 필요 시 DEVELOPMENT/QA/REVIEW 재진입
→ RELEASE_PREP
→ CEO_DELIVERY_REVIEW
→ DELIVERY_READY
→ CUSTOMER_ACCEPTED 또는 REVISION_REQUESTED

각 상태와 변경 시각을 영속 저장한다.

[회사 상태 저장]
.ai-company 또는 동등한 전용 디렉터리를 만들고 기존 .ai-dev task 상태와 분리한다.
최소 상태:
- company-state.json
- projects.json
- customer-requests.json
- customer-decisions.json
- deliveries.json
- company-config.json
- events.jsonl
- reports/

모든 JSON은 UTF-8이고 PowerShell 5.1 및 Windows 환경에서 한글이 깨지지 않아야 한다.
events.jsonl은 append-only 이벤트 로그로 사용한다.

[GUI]
AI Dev Company 관리 GUI를 개발 대상 PlanPilot UI와 논리적으로 분리한다.
초기 구현은 현재 저장소 안에서 독립된 ai-software-company 디렉터리 또는 동등한 명확한 경계로 구현하되 PlanPilot src의 제품 UI와 섞지 않는다.
후속 단계에서 별도 저장소로 쉽게 분리 가능해야 한다.

GUI는 개발자 도구가 아니라 AI 소프트웨어 회사 고객 포털 형태로 설계한다.

메인 메뉴:
1. 회사 현황
2. 프로젝트
3. 새 제품 의뢰
4. 납품 센터
5. 개발 기록
6. 회사 설정
7. 회사 내부 보기

[회사 현황 화면]
상단:
AI SOFTWARE COMPANY
회사 상태 OPERATING / PAUSED / STOPPED / BLOCKED
현재 시간과 heartbeat

회사 제어:
- 회사 시작
- 일시정지
- 재개
- 안전정지
- 긴급정지

긴급정지는 별도 확인 절차를 둔다.

메인 영역:
현재 프로젝트
CEO 메시지
전체 프로젝트 진행률
현재 프로젝트 단계
고객 결정 필요 여부

프로젝트 단계 시각화:
요구사항 분석
기술 설계
프로젝트 계획
개발
QA
Review
CEO 최종검수
납품

회사 조직 상태:
CEO
Product
CTO
Project
Development
QA
Review
Recovery
Release

각 조직 상태:
IDLE
WAITING
RUNNING
PASSED
FAILED
BLOCKED
PAUSED

고객 화면에서는 raw Codex 로그보다 사람이 이해할 수 있는 회사 이벤트를 우선 표시한다.

예:
12:01 CEO 제품 의뢰 접수
12:05 Product 요구사항 분석 완료
12:11 CTO 기술 설계 완료
12:13 Project 6개 Task 생성
12:16 Development T001 개발 시작
12:41 QA 151 tests PASS
12:47 Review PASS
12:50 CEO 납품 검수 시작

[새 제품 의뢰 화면]
입력:
- 대상 프로젝트
- 제품/기능 이름
- 요청 내용
- 추가 요구사항
- 제약사항
- 우선순위

회사에 의뢰 버튼을 제공한다.
의뢰 후 CEO가 Project Brief를 자동 생성한다.

Project Brief 최소 항목:
- 프로젝트명
- 고객 요청 원문
- 제품 목적
- 납품 범위
- 제외 범위
- acceptance criteria
- 위험요소
- CEO 판단
- 내부 Task 계획

[프로젝트 화면]
프로젝트 목록과 상세 화면을 제공한다.
상태, 진행률, CEO 메시지, 현재 단계, Task 완료율, 시작시각, 최근 활동을 표시한다.
고객은 내부 Task를 볼 수 있지만 평상시에 직접 관리하지 않아도 된다.
고급 내부 보기에서만 Task Queue와 세부 Agent 흐름을 표시한다.

[고객 의사결정]
CUSTOMER_DECISION_REQUIRED가 있을 때만 회사 현황 상단에 강조한다.
표시:
- 결정 제목
- 현재 상황
- CEO 추천
- 추천 이유
- 선택지
- 직접 의견 입력
고객 선택은 이벤트와 프로젝트 상태에 기록한다.

[납품 센터]
DELIVERY_READY 프로젝트를 표시한다.
납품 상세:
- 최초 고객 요구사항
- 구현된 기능
- CEO 요구사항 충족 체크
- Build 결과
- Test 통과 개수
- Lint
- Review
- Recovery 이력
- commit hash
- branch
- 변경 파일 수
- 제한사항 또는 알려진 이슈

버튼:
- 납품 승인
- 수정 요청

납품 승인 시 CUSTOMER_ACCEPTED.
수정 요청 시 고객 의견을 보존하고 REVISION_REQUESTED 상태로 새 회사 작업 사이클을 시작한다.

[개발 기록]
날짜별 회사 활동을 볼 수 있어야 한다.
완료 프로젝트
완료 Task
생성 Commit
Recovery 횟수
최종 실패
납품 건수
고객 승인 건수
이벤트 타임라인을 표시한다.

[회사 내부 보기]
고객 포털에서 별도 고급 화면으로 제공한다.
여기에서만:
- Goal/Task Queue
- 현재 Agent
- Codex 로그
- QA raw 로그
- Review 결과
- Recovery reason/count
- changed files
- commit/push
를 확인할 수 있다.
로그 필터:
ALL, CEO, PRODUCT, CTO, PROJECT, DEV, QA, REVIEW, RECOVERY, RELEASE, ERROR

[로컬 서버]
외부 프레임워크 의존성 추가를 최소화한다.
가능하면 Node.js 기본 http 모듈 또는 현재 프로젝트 의존성을 재사용한다.
관리 서버는 기본적으로 127.0.0.1:4177에만 바인딩하고 외부 네트워크에 노출하지 않는다.
상태 조회 REST API와 실시간 이벤트 SSE를 제공한다.

최소 API:
GET /api/company
GET /api/projects
GET /api/projects/:id
GET /api/deliveries
GET /api/events
POST /api/company/start
POST /api/company/pause
POST /api/company/resume
POST /api/company/safe-stop
POST /api/company/emergency-stop
POST /api/requests
POST /api/decisions/:id
POST /api/deliveries/:id/accept
POST /api/deliveries/:id/revise
GET /api/events/stream

서버와 GUI는 파일 기반 영속 상태를 읽고 Supervisor 명령을 전달한다.
GUI를 닫아도 Supervisor는 종료되지 않아야 한다.
GUI를 다시 열면 현재 회사 상태를 즉시 복원한다.

[회사 제어 의미]
START:
회사 Supervisor 실행 및 대기 프로젝트 처리 시작.

PAUSE:
현재 실행 중인 원자 작업을 안전하게 종료한 후 다음 Agent 실행 전에 PAUSED.

RESUME:
저장된 단계부터 재개.

SAFE STOP:
현재 원자 작업을 정상 종료하고 모든 상태를 저장한 뒤 회사 프로세스를 정상 종료.

EMERGENCY STOP:
Codex, npm, 하위 PowerShell 등 회사가 실행한 자식 프로세스를 강제 종료하되 baseline 사용자 변경을 삭제하지 않는다.

[기존 AI Dev 엔진 연결]
새 회사 시스템이 기존 ai-dev-auto-goal.ps1, ai-dev-auto-cycle-full.ps1, ai-dev-run-codex.ps1, ai-dev-run-review-codex.ps1, ai-dev-check.ps1, ai-dev-commit.ps1, ai-dev-complete-task.ps1 및 Recovery 로직을 재사용해야 한다.
기존 151개 테스트 기반 안전장치를 우회하지 않는다.
회사 Project의 내부 Task를 기존 AI Dev Goal/Task 형식으로 변환할 adapter 계층을 만든다.

Product/CTO/PM 단계가 Task를 정의하면 기존 AI Dev 실행 엔진에 전달한다.
QA는 build/test/lint 전체 검증을 사용한다.
Review pass와 QA pass 이전에는 Release로 갈 수 없다.
Recovery는 기존 task별 recovery limit와 stopped reason 로직을 사용한다.
Release는 scoped commit 후 필요 시 push한다.

[안전 정책]
- 고객 baseline 변경 보존
- 테스트 실패 상태 commit 금지
- Review 없이 commit 금지
- dependency 자동 변경 기본 차단
- package-lock 자동 변경 기본 차단
- 동일 Task 무한 반복 금지
- 연속 실패 제한
- 다른 Project/Task의 review/commit/recovery 상태 재사용 금지
- 동일 Task 동시 실행 금지
- 회사 상태 파일 atomic write
- 비정상 종료 후 resume 가능
- local-only 서버
- PowerShell 5.1
- UTF-8
- 기존 영어 stopped reason/token 유지

[Supervisor]
ai-dev-company 또는 동등한 Supervisor 진입점을 만든다.
회사는 다음 흐름을 자동 반복한다:
고객 의뢰 선택
→ CEO
→ Product
→ CTO
→ Project
→ Development
→ QA
→ Review
→ Recovery
→ Release
→ CEO Delivery Review
→ DELIVERY_READY
→ 다음 승인된 프로젝트 또는 IDLE

Queue가 없으면 새로운 기능을 임의로 만들지 말고 IDLE로 대기한다.

[테스트]
scripts/ai-dev-test.ps1 또는 별도 company test를 기존 테스트와 통합한다.
기존 151개 테스트를 삭제하거나 약화하지 않는다.

실제 동작 기반으로 최소 다음을 검증한다:
- 고객 제품 의뢰 생성
- CEO Project Brief 생성
- 회사 단계 순서
- customer decision required
- customer decision 후 resume
- Development → QA → Review → Release 순서
- QA failure → Recovery
- Review revise → Recovery
- QA/Review 이전 commit 금지
- CEO Delivery Review
- Delivery Ready
- 고객 납품 승인
- 수정 요청 후 새 cycle
- Start
- Pause
- Resume
- Safe Stop
- Emergency Stop
- GUI가 닫혀도 company state 유지
- restart resume
- 동일 task lock
- idle queue
- events.jsonl append
- SSE event 전달
- 다른 project state 격리
- 기존 AI Dev Recovery 안전장치 유지

GUI와 서버에 대한 최소 smoke test도 추가한다.

[완료 기준]
- 고객이 브라우저에서 AI Software Company GUI를 열 수 있음
- 새 제품 의뢰 가능
- CEO가 의뢰를 프로젝트로 전환
- 회사 내부 단계가 상태로 표시됨
- Start/Pause/Resume/Safe Stop 제어 가능
- 실시간 회사 로그 확인 가능
- 고객 결정 요청 표시 가능
- 납품 센터에서 납품 결과 확인 가능
- 납품 승인/수정 요청 가능
- 회사 내부 보기에서 기존 AI Dev 로그와 Task 확인 가능
- 기존 자동개발 엔진과 실제 연결
- build passed
- 전체 test Failed=0
- lint passed
- strict review pass
- 기존 151개 테스트 유지 또는 증가
- PowerShell 5.1 호환
- 한글 UTF-8 정상 출력

불필요한 외부 서비스나 클라우드를 추가하지 말고 로컬 전용으로 구현한다. 구현 범위가 큰 경우 기능을 생략하지 말고 독립 Task로 분해하여 순차적으로 완성한다.

Create a small, safe goal plan for this repository. The response object must have these fields:
- goalMarkdown: .ai-dev/goal.md에 작성할 마크다운 문자열입니다. "# 목표", "배경", "성공 기준", "제약사항", "범위 제외", "수동 검증" 섹션을 한국어로 포함해야 합니다.
- queue: an object for .ai-dev/queue.json.
- state: an object for .ai-dev/state.json.

queue rules:
- goalTitle must equal the supplied title.
- goalSource must be ".ai-dev/goal.md".
- createdAt and updatedAt are required and must be ISO 8601 strings.
- currentTaskId must be "T001".
- tasks must contain one to three tasks.
- T001 must be status "in_progress"; later tasks, if any, must be "pending".
- each task must include id, title, description, type, status, priority, dependsOn, filesLikelyToChange, verification, commitMessage.
- type must be one of analysis, implementation, documentation, verification.
- priority must be P0, P1, or P2.
- dependsOn, filesLikelyToChange, and verification must be arrays.
- commitMessage must be null or a short English commit message.

state rules:
- goalStatus must be "in_progress".
- currentTaskId must be "T001".
- currentLoop must be 0.
- maxLoopsPerTask must be 2.
- repeatedFailureCount must be 0.
- lastCommand must be null.
- lastCommandStatus must be "not_started".
- lastErrorSummary must be null.
- lastReviewDecision must be "not_started".
- lastReviewSeverity must be null.
- lastCommitHash must be null.
- startedAt and updatedAt must be ISO 8601 strings.
- stopReason must be null.

Safety rules:
- Do not mention server APIs, login, cloud sync, npm install, git reset, git clean, git push, DB deletion, or broad rewrites as implementation steps.
- Prefer one small implementation task when the goal is small.
- Use Korean for user-facing task titles, descriptions, verification, and goalMarkdown.