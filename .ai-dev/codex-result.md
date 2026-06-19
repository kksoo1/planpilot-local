# Codex Implementation Result

## Run

- Started at: 2026-06-19 22:09:02
- Ended at: 2026-06-19 22:12:01
- Exit code: 0
- Prompt: .ai-dev/current-task-prompt.md
- Command: codex exec <short wrapper pointing to .ai-dev/current-task-prompt.md>

## Output

```text
node.exe : OpenAI Codex v0.133.0
At C:\Users\SECUI\AppData\Roaming\npm\codex.ps1:24 char:5
+     & "node$exe"  "$basedir/node_modules/@openai/codex/bin/codex.js"  ...
+     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (OpenAI Codex v0.133.0:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 
--------
workdir: D:\ai-apps\planpilot-local
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: medium
reasoning summaries: none
session id: 019edfff-ca20-7562-a8ee-1b4ddf6d4810
--------
user
Read and follow the full task prompt at this absolute file path: D:\ai-apps\planpilot-local\.ai-
dev\current-task-prompt.md
codex
작업 지시 파일을 먼저 읽어 요구사항과 수정 범위를 확인하겠습니다. 지금은 파일 내용 확인만 수행합니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\current-task-prompt.md'" in D:\ai-apps\planpilot-loc
al
 succeeded in 1027ms:
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
PlanPilot Local MVP에서 사용자가 현재 진행 중인 업무, 완료된 업무, 남은 업무를 더 빠르게 이해할 수 있도록 업무 목록 또는 대시보드 영역의 안내 문구와 
상태 표시를 개선한다.

## 배경
현재 MVP는 기존 업무 데이터를 기반으로 로컬에서 동작한다. 1차 사용성을 높이기 위해 기능 로직을 크게 바꾸기보다, 기존 화면에서 업무 상태를 더 명확하게 읽을 수 있는
 작은 개선이 필요하다.

## 성공 기준
- 진행 중인 업무, 완료된 업무, 남은 업무의 의미가 화면에서 더 명확하게 드러난다.
- 기존 데이터 구조와 저장 방식은 유지한다.
- 사용자-facing 문구는 한국어로 제공한다.
- 변경 범위는 업무 목록 또는 대시보드 영역의 작은 UI 개선으로 제한한다.
- 허용된 검증을 통과하고 리뷰 결과가 통과 상태가 된다.
- 구현 변경과 AI Dev Loop 메타 변경이 각각 기록된다.
- 최종 상태에서 예상하지 못한 변경 파일이 남아 있지 않음을 확인한다.

## 제약사항
- 서버 연동이나 외부 전송 없이 로컬 앱 방향을 유지한다.
- 로그인, 동기화, 알림, 모바일 권한 요청은 추가하지 않는다.
- IndexedDB와 Dexie.js 기반 저장 구조를 유지한다.
- `src/App.css`, lock file, `node_modules`, `dist`, `.git`은 수정하지 않는다.
- 한 번에 하나의 기능만 작게 구현한다.

## 범위 제외
- 새 화면 추가
- 대규모 컴포넌트 재작성
- 데이터 schema 변경
- 새 상태 관리 구조 도입
- 알림 또는 반복 업무 기능

## 수동 검증
- 앱 화면에서 진행 중, 완료, 남은 업무 상태 안내가 자연스럽게 보이는지 확인한다.
- 빈 업무 목록 또는 완료 업무가 있는 상태에서 문구가 어색하지 않은지 확인한다.
- 기존 업무 생성, 완료 전환, 필터 흐름이 깨지지 않는지 확인한다.

## Current Task

- Task ID: T002
- Title: 업무 흐름 상태 표시 개선
- Description: 진행 중인 업무, 완료된 업무, 남은 업무를 사용자가 한눈에 이해할 수 있도록 기존 화면의 안내 문구와 상태 라벨을 한국어로 다듬는다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- T001

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

- src/App.tsx

## Verification

- 업무가 없을 때와 업무가 있을 때의 안내 문구가 모두 자연스러운지 확인한다.
- 기존 업무 생성과 완료 상태 전환 흐름이 유지되는지 확인한다.

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

codex
요구사항은 `src/App.tsx`의 작은 문구/상태 라벨 개선이 중심이고, 별도 메타 기록은 `.ai-dev/loop-log.md`에 남기는 흐름입니다. 우선 기존 업무 
목록/대시보드 문구 위치를 찾겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -Path '
D:\\ai-apps\\planpilot-local\\src\\App.tsx' -Pattern '완료|진행|남은|업무|task|Task|empty|Empty'" in D:\
ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\loop-log.md'" in D:\ai-apps\planpilot-local
 succeeded in 1390ms:

src\App.tsx:5:import { useTaskActions } from "./hooks/useTaskActions";
src\App.tsx:6:import { useTaskFormState } from "./hooks/useTaskFormState";
src\App.tsx:10:import { getOverdueTasks, getUpcomingTasks } from "./utils/taskDates";
src\App.tsx:11:import { filterTasks, sortTasks, type TaskSortOrder } from "./utils/taskFilters";
src\App.tsx:12:import { getTaskSummary } from "./utils/taskSummary";
src\App.tsx:14:import { TasksView } from "./views/TasksView";
src\App.tsx:17:import type { Task } from "./types";
src\App.tsx:20:type Tab = "today" | "tasks" | "projects" | "settings";
src\App.tsx:24:  const [recommendedTasks, setRecommendedTasks] = useState<Task[]>([]);
src\App.tsx:26:  const [showCompletedTasks, setShowCompletedTasks] = useState(true);
src\App.tsx:27:  const [taskSortOrder, setTaskSortOrder] = useState<TaskSortOrder>("none");
src\App.tsx:28:  const [taskSearchQuery, setTaskSearchQuery] = useState("");
src\App.tsx:30:  const { tasks, projects, appSettings, initializeApp, addTask, updateTask, delet
eTask, deleteProject, a
ddProject, updateProject } = useStore();
src\App.tsx:31:  const taskFormState = useTaskFormState();
src\App.tsx:33:    editingTaskId,
src\App.tsx:34:    editTaskTitle,
src\App.tsx:35:    editTaskDueDate,
src\App.tsx:36:    editTaskPriority,
src\App.tsx:37:    editTaskMemo,
src\App.tsx:38:    editTaskProjectId,
src\App.tsx:39:    newTaskTitle,
src\App.tsx:40:    newTaskDueDate,
src\App.tsx:41:    newTaskPriority,
src\App.tsx:42:    newTaskProjectId,
src\App.tsx:43:    newTaskMemo,
src\App.tsx:44:    isTaskFormOpen,
src\App.tsx:45:    setEditTaskTitle,
src\App.tsx:46:    setEditTaskDueDate,
src\App.tsx:47:    setEditTaskPriority,
src\App.tsx:48:    setEditTaskMemo,
src\App.tsx:49:    setEditTaskProjectId,
src\App.tsx:50:    setNewTaskTitle,
src\App.tsx:51:    setNewTaskDueDate,
src\App.tsx:52:    setNewTaskPriority,
src\App.tsx:53:    setNewTaskProjectId,
src\App.tsx:54:    setNewTaskMemo,
src\App.tsx:55:    setIsTaskFormOpen,
src\App.tsx:56:    resetNewTaskForm,
src\App.tsx:57:    resetEditTaskForm,
src\App.tsx:58:    startEditTask,
src\App.tsx:59:  } = taskFormState;
src\App.tsx:60:  const { handleAddTask, handleSaveEditTask, handleToggleTaskDone, handleDeleteTa
sk } = useTaskActions({
src\App.tsx:61:    addTask,
src\App.tsx:62:    updateTask,
src\App.tsx:63:    deleteTask,
src\App.tsx:64:    newTaskTitle,
src\App.tsx:65:    newTaskDueDate,
src\App.tsx:66:    newTaskPriority,
src\App.tsx:67:    newTaskProjectId,
src\App.tsx:68:    newTaskMemo,
src\App.tsx:69:    editTaskTitle,
src\App.tsx:70:    editTaskDueDate,
src\App.tsx:71:    editTaskPriority,
src\App.tsx:72:    editTaskMemo,
src\App.tsx:73:    editTaskProjectId,
src\App.tsx:74:    resetNewTaskForm,
src\App.tsx:75:    resetEditTaskForm,
src\App.tsx:97:    tasks,
src\App.tsx:108:  const overdueTasks = getOverdueTasks(tasks, today);
src\App.tsx:109:  const upcomingTasks = getUpcomingTasks(tasks, today, 7);
src\App.tsx:110:  const taskSummary = getTaskSummary(tasks);
src\App.tsx:112:  const filteredTasks = filterTasks(tasks, {
src\App.tsx:114:    showCompletedTasks,
src\App.tsx:115:    taskSearchQuery,
src\App.tsx:119:  const sortedTasks = sortTasks(filteredTasks, taskSortOrder);
src\App.tsx:128:    void aiProvider.suggestTodayTasks(tasks, 3).then(setRecommendedTasks);
src\App.tsx:129:  }, [aiProvider, tasks]);
src\App.tsx:136:        <p>서버 없이 로컬에 저장되는 개인 일정·업무 관리 앱</p>
src\App.tsx:142:    totalTasks={taskSummary.totalTasks}
src\App.tsx:143:    completedTasks={taskSummary.completedTasks}
src\App.tsx:144:    recommendedTasks={recommendedTasks}
src\App.tsx:145:    overdueTasks={overdueTasks}
src\App.tsx:146:    upcomingTasks={upcomingTasks}
src\App.tsx:151:        {activeTab === "tasks" && (
src\App.tsx:152:          <TasksView
src\App.tsx:154:            filteredTasks={filteredTasks}
src\App.tsx:155:            sortedTasks={sortedTasks}
src\App.tsx:157:            showCompletedTasks={showCompletedTasks}
src\App.tsx:158:            taskSortOrder={taskSortOrder}
src\App.tsx:159:            taskSearchQuery={taskSearchQuery}
src\App.tsx:160:            isTaskFormOpen={isTaskFormOpen}
src\App.tsx:161:            newTaskTitle={newTaskTitle}
src\App.tsx:162:            newTaskMemo={newTaskMemo}
src\App.tsx:163:            newTaskDueDate={newTaskDueDate}
src\App.tsx:164:            newTaskPriority={newTaskPriority}
src\App.tsx:165:            newTaskProjectId={newTaskProjectId}
src\App.tsx:166:            editingTaskId={editingTaskId}
src\App.tsx:167:            editTaskTitle={editTaskTitle}
src\App.tsx:168:            editTaskMemo={editTaskMemo}
src\App.tsx:169:            editTaskDueDate={editTaskDueDate}
src\App.tsx:170:            editTaskPriority={editTaskPriority}
src\App.tsx:171:            editTaskProjectId={editTaskProjectId}
src\App.tsx:173:            onTaskSearchQueryChange={setTaskSearchQuery}
src\App.tsx:174:            onShowCompletedTasksChange={setShowCompletedTasks}
src\App.tsx:175:            onTaskSortOrderChange={setTaskSortOrder}
src\App.tsx:177:            onTaskFormOpenChange={setIsTaskFormOpen}
src\App.tsx:178:            onNewTaskTitleChange={setNewTaskTitle}
src\App.tsx:179:            onNewTaskMemoChange={setNewTaskMemo}
src\App.tsx:180:            onNewTaskDueDateChange={setNewTaskDueDate}
src\App.tsx:181:            onNewTaskPriorityChange={setNewTaskPriority}
src\App.tsx:182:            onNewTaskProjectIdChange={setNewTaskProjectId}
src\App.tsx:183:            onEditTaskTitleChange={setEditTaskTitle}
src\App.tsx:184:            onEditTaskMemoChange={setEditTaskMemo}
src\App.tsx:185:            onEditTaskDueDateChange={setEditTaskDueDate}
src\App.tsx:186:            onEditTaskPriorityChange={setEditTaskPriority}
src\App.tsx:187:            onEditTaskProjectIdChange={setEditTaskProjectId}
src\App.tsx:188:            onAddTask={handleAddTask}
src\App.tsx:189:            onSaveEditTask={handleSaveEditTask}
src\App.tsx:190:            onCancelEditTask={resetEditTaskForm}
src\App.tsx:191:            onToggleTaskDone={handleToggleTaskDone}
src\App.tsx:192:            onDeleteTask={handleDeleteTask}
src\App.tsx:193:            onStartEditTask={startEditTask}
src\App.tsx:200:            tasks={tasks}
src\App.tsx:221:            tasks={tasks}
src\App.tsx:235:          className={activeTab === "tasks" ? "active" : ""}
src\App.tsx:236:          onClick={() => setActiveTab("tasks")}
src\App.tsx:238:          업무



 succeeded in 1316ms:
# AI Dev Loop Log

## 2026-06-07 19:59:48 - New goal initialized

- Previous goal: PlanPilot Local 업무 검색/필터 UX 개선
- Previous status: 업무 검색/필터 UX 개선 목표는 진행 중이었으나 Codex CLI 기반 완전 자동화 도입을 위해 잠시 중단함
- New goal: AI Dev Loop Codex CLI 완전 자동화 도입
- Current task: T001 Codex CLI 완전 자동화 정책 문서화
- Scope: Codex CLI를 구현자와 리뷰어로 사용해 AI Dev Loop의 구현, 검증, 리뷰, 커밋, task 완료 처리 자동화 초안을 만든다.
- Known environment: `codex --version`은 `codex-cli 0.133.0`으로 확인되었고, `codex exec`는 현재 저장소에서 파일 수
정 없이 응답하는 테스트를 통과했다.
- Excluded: scripts/src/package 파일 수정은 이번 목표 전환 단계에서 하지 않음, build/test 실행 안 함, git add/commit 안 
함, Codex CLI 호출 안 함, Cline/Copilot/gh/GPT API 사용 안 함
- Result: `goal.md`, `backlog.md`, `queue.json`, `state.json`, `plan.md`, `test-result.md`, `rev
iew.md`, `loop-log.md`를 새 목표 기준으로 초기화함

## 2026-06-07 21:46:14 - Task completed

- Task: T001 Codex CLI 완전 자동화 정책 문서화
- Result: T001 완료: Codex CLI를 구현자/리뷰어로 사용하는 완전 자동화 정책, 허용/금지 명령, 안전 중단 조건 문서화
- Next task: T002 Codex 구현 실행 스크립트 추가
## 2026-06-07 21:48:36 - Task completed

- Task: T002 Codex 구현 실행 스크립트 추가
- Result: T001 완료: Codex CLI를 구현자/리뷰어로 사용하는 완전 자동화 정책, 허용/금지 명령, 안전 중단 조건 문서화
- Next task: T003 Codex 리뷰 실행 스크립트 추가
## 2026-06-07 21:58:28 - Task completed

- Task: T003 Codex 리뷰 실행 스크립트 추가
- Result: T002 완료: current-task-prompt.md를 codex exec에 전달하는 ai-dev-run-codex.ps1 추가, 문법 검증과 DryR
un/Json/dirty 상태 중단 확인
- Next task: T004 full auto-cycle 초안 추가

## 2026-06-07 22:10:00 - Goal expanded

- Goal: AI Dev Loop Codex CLI 완전 자동화 도입
- Change: T001~T006 진행 상태는 유지하고 T007 목표 입력 기반 자동 goal 실행 스크립트 추가 task를 queue에 추가함
- Final target command: `powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1
 -GoalTitle "업무 검색 결과 하이라이트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -Allo
wCodex -AllowReviewCodex -AllowCommit -MaxTasks 1`
- Scope: scripts/src/package 파일은 수정하지 않고 queue, plan, README, 정책 문서에 auto-goal 목표와 안전 기준만 반영함

## 2026-06-07 22:20:00 - State repaired

- Reason: T003 `Codex 리뷰 실행 스크립트 추가`가 `done`으로 표시되어 있었지만 실제 `scripts/ai-dev-run-review-codex.ps1
` 산출물이 누락됨
- Change: T003 상태를 `in_progress`로 되돌리고 T004 `full auto-cycle 초안 추가` 상태를 `pending`으로 되돌림
- Current task: T003 Codex 리뷰 실행 스크립트 추가
- Preserved: T001/T002는 `done` 유지, T005/T006/T007은 `pending` 유지, T007 추가 내용 유지
- Excluded: scripts/src/package 파일 수정 없음, git add/commit 없음, Codex CLI 호출 없음

## 2026-06-07 22:35:00 - Task progress

- Task: T003 Codex 리뷰 실행 스크립트 추가
- Result: `scripts/ai-dev-run-review-codex.ps1` 추가, `review-prompt.md`를 Codex CLI에 전달하고 JSON 리뷰를
 `review-response.json`에 저장하며 `-SaveReview`로 `ai-dev-save-review.ps1 -ReviewFile` 흐름에 연결하도록 구현
- Docs: `.ai-dev/README.md`에 DryRun, 기본 실행, `-GenerateReviewPromptIfMissing`, `-SaveReview`, `-A
llowDirty` 주의사항을 추가
- Verification: PowerShell 문법 검증 예정. 실제 Codex 실행, build/test/lint, git add/commit은 수행하지 않음

## 2026-06-07 22:23:42 - Task completed

- Task: T003 Codex 리뷰 실행 스크립트 추가
- Result: T003 완료: review-prompt.md를 codex exec에 전달해 JSON 리뷰를 생성하는 ai-dev-run-review-codex.ps1 추
가, 문법 검증과 DryRun/Json 확인
- Next task: T004 full auto-cycle 초안 추가
## 2026-06-07 22:57:13 - Task completed

- Task: T004 full auto-cycle 초안 추가
- Result: T004 완료: make-prompt/run-codex/check/save-diff/make-review-prompt/run-review-codex를 연결
하는 ai-dev-auto-cycle-full.ps1 초안 추가, DryRun/Json/AllowCodex 중단 확인
- Next task: T005 자동 커밋과 task 완료 연결
## 2026-06-08 23:11:23 - Task completed

- Task: T005 자동 커밋과 task 완료 연결
- Result: T004 완료: make-prompt/run-codex/check/save-diff/make-review-prompt/run-review-codex를 연결
하는 ai-dev-auto-cycle-full.ps1 초안 추가, DryRun/Json/AllowCodex 중단 확인
- Next task: T006 작은 앱 task로 end-to-end 검증

## 2026-06-08 23:30:00 - Task progress

- Task: T005 자동 커밋과 task 완료 연결
- Result: `ai-dev-auto-cycle-full.ps1`에서 review pass 이후 package 변경 게이트, `-AllowCommit` 기반 자동 커밋,
 커밋 확인 후 complete-task 실행, `MaxTasks` 반복 구조를 정리함
- Docs: `.ai-dev/README.md`에 DryRun, MaxTasks 1/3, `AllowCodex + AllowReviewCodex + AllowCommit`
, 선택 파일 커밋 예시를 추가함
- Verification: PowerShell AST 문법 검증 통과, full auto-cycle DryRun/Json 출력에서 commit 및 complete-task
 단계 포함 확인
- Excluded: 실제 Codex 실행, build/test/lint, git add/commit은 수행하지 않음

## 2026-06-09 00:17:52 - Task completed

- Task: T006 작은 앱 task로 end-to-end 검증
- Result: T006 완료: full auto-cycle DryRun/Json 구조 검증 및 Codex runner 인자 길이 버그 수정 확인, 실제 end-to-en
d 검증은 T007 auto-goal 이후 작은 앱 목표로 수행
- Next task: T007 목표 입력 기반 자동 goal 실행 스크립트 추가
## 2026-06-09 23:05:15 - Task completed

- Task: T007 목표 입력 기반 자동 goal 실행 스크립트 추가
- Result: T007 완료: 목표 제목/설명 입력 기반 auto-goal 실행 스크립트 추가, DryRun/Json 출력, 입력 검증, dirty 처리, full au
to-cycle 연결 및 Codex 리뷰 pass 확인
- Next task: 없음
## 2026-06-09 23:50:32 - Task completed

- Task: T001 업무 검색창 placeholder 문구 수정
- Result: T001 완료: 업무 검색창 placeholder를 업무명과 프로젝트명 검색 대상에 맞는 명확한 한국어 문구로 개선하고 build 및 Codex 리뷰 결과
를 확인함
- Next task: 없음
## 2026-06-10 22:22:07 - Task completed

- Task: T001 리뷰 diff 범위 분리 로직 정리
- Result: T001 완료: 리뷰 diff 생성과 리뷰 프롬프트에서 실제 변경 파일과 .ai-dev 운영 산출물을 분리하고, 앱 변경 중심 리뷰가 가능하도록 개선함
- Next task: 없음

## 2026-06-10 23:09:10 - Task progress

- Task: T001 커밋 해시 상태 기록 흐름 개선
- Result: `ai-dev-auto-cycle-full.ps1`의 commit-result-gate가 커밋 전 HEAD와 커밋 후 HEAD를 비교하고, commit/p
assed 상태에서 최신 HEAD를 `lastCommitHash`에 보강하도록 수정함. `ai-dev-complete-task.ps1`은 완료 처리 전 commit/pass
ed 상태에서 기록된 해시가 있거나 HEAD 커밋 시각이 상태 갱신 이후인 경우에만 `lastCommitHash`를 동기화하도록 수정함
- Verification: 관련 PowerShell 스크립트 2개 AST 문법 검증 통과
- Excluded: build/test/lint, 실제 커밋 생성, git 명령 직접 실행은 수행하지 않음

## 2026-06-10 23:34:13 - Task completed

- Task: T001 커밋 해시 상태 기록 흐름 개선
- Result: T001 완료: 커밋 성공 후 명시적으로 전달된 커밋 해시를 검증하여 state.lastCommitHash에 기록하도록 commit-result-gate와
 complete-task 흐름을 개선함
- Next task: 없음
## 2026-06-13 00:33:57 - Task completed

- Task: T001 업무 카드 완료 버튼 문구 수정
- Result: T001 완료: 업무 카드의 미완료 상태 완료 버튼 문구를 더 명확한 한국어 표현으로 개선했으며, 동작 로직이나 구조 변경 없이 UI 문구만 최소 범위로 
수정함
- Next task: 없음
## 2026-06-14 20:18:29 - Task completed

- Task: T001 마감 임박 배지 표시 구현
- Result: T001 완료: 미완료 업무 중 마감일이 오늘부터 7일 이내인 경우 업무 카드에 마감 임박 배지를 표시하도록 구현함
- Next task: 없음
## 2026-06-14 21:50:57 - Commit created

- Task: T001 pass 이후 자동 완료 흐름 구현
- Commit: be79d21ea8edc7f08d3634575ad8ccd76c38079d
- Message: Auto-complete passed dev loop tasks
## 2026-06-14 21:51:07 - Task completed

- Task: T001 pass 이후 자동 완료 흐름 구현
- Result: T001 완료: pass 이후 구현 커밋, CommitHash 전달 complete-task, .ai-dev 메타 커밋 및 clean 검증 흐름 구현 완료
- Next task: 없음
## 2026-06-14 22:01:20 - Commit created

- Task: T001 업무 목록 빈 상태 문구 수정
- Commit: 3f53ac6c1b9fd7f43ab7dcb161eb112c78c7cbb4
- Message: Improve empty task list copy
## 2026-06-14 22:01:28 - Task completed

- Task: T001 업무 목록 빈 상태 문구 수정
- Result: T001 완료: 업무 목록 빈 상태 안내 문구를 자연스러운 한국어로 개선하고 lint 검증을 통과함
- Next task: 없음
## 2026-06-14 22:06:40 - Commit created

- Task: T001 검증 기록 흐름 분석 및 lint 기록 개선
- Commit: db479f4caa4afbac65caefb6105394df18d9211c
- Message: Record lint validation results
## 2026-06-14 22:06:51 - Task completed

- Task: T001 검증 기록 흐름 분석 및 lint 기록 개선
- Result: T001 완료: BuildOnly에서도 lint 실행 결과를 자동 기록하고 test script 부재 사유를 명확히 남기도록 개선함
- Next task: 없음
## 2026-06-14 22:13:29 - Commit created

- Task: T001 업무 카드 문구 최소 개선
- Commit: 151cfa8a95b068d55a652a29c306cbdf5c19e4f5
- Message: Improve task card accessibility labels
## 2026-06-14 22:13:38 - Task completed

- Task: T001 업무 카드 문구 최소 개선
- Result: T001 완료: 업무 카드 버튼 및 상태 표시의 접근성/안내 문구를 최소 범위로 개선하고 build/lint 검증을 통과함
- Next task: 없음
## 2026-06-14 22:29:29 - Commit created

- Task: T001 auto-goal pass 이후 완료 흐름 연결
- Commit: a41df7ba976d41328ac39cd92a3eefed1e04ba19
- Message: Wire auto-goal pass completion flow
## 2026-06-14 22:29:48 - Task completed

- Task: T001 auto-goal pass 이후 완료 흐름 연결
- Result: T001 완료: auto-goal 실행 경로에서 리뷰 pass 이후 커밋, complete-task -CommitHash 전달, .ai-dev 메타 커밋,
 최종 상태 확인까지 이어지도록 개선함
- Next task: 없음
## 2026-06-14 23:00:14 - Commit created

- Task: T001 업무 카드 완료 문구 개선
- Commit: 14b1d6137c5a0fd09b671793c2925f7cd6981bae
- Message: Refine completed task card copy
## 2026-06-14 23:00:21 - Task completed

- Task: T001 업무 카드 완료 문구 개선
- Result: T001 완료: 업무 카드 완료 버튼과 aria-label 문구를 자연스러운 한국어로 최소 개선하고 build/lint 검증을 통과함
- Next task: 없음
## 2026-06-14 23:23:51 - Commit created

- Task: T001 auto-goal 완료 판정 흐름 수정
- Commit: 541b9d02569576d0c56cbe60ede92fe924dbd64c
- Message: Fix auto-goal completion handling
## 2026-06-14 23:24:03 - Task completed

- Task: T001 auto-goal 완료 판정 흐름 수정
- Result: T001 완료: complete_task/complete-task 정규화, 저장된 리뷰 pass 이후 완료 재개, auto-goal 미완료 판정 실패 처리
를 반영함
- Next task: 없음
## 2026-06-14 23:28:13 - Commit created

- Task: T001 업무 카드 문구 확인 및 최소 수정
- Commit: 3dd089ad71e0b17ac45dbc9af09db4e48db57d01
- Message: Refine task card helper copy
## 2026-06-14 23:28:16 - Task completed

- Task: T001 업무 카드 문구 확인 및 최소 수정
- Result: 자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료
- Next task: 없음
## 2026-06-19 21:36:52 - Commit created

- Task: T001 auto-goal 종료 전 최종 변경 상태 검증 보강
- Commit: 058a75bb425c1f488c7b466945f7c2baf66504e1
- Message: Ensure auto goal final clean state
## 2026-06-19 21:37:24 - Task completed

- Task: T001 auto-goal 종료 전 최종 변경 상태 검증 보강
- Result: T001 완료: auto-goal 종료 전 최종 변경 상태 검증을 보강하고, 완료 직전 .ai-dev 운영 변경의 최종 메타 커밋, baseline dir
ty 보호, non-.ai-dev dirty 실패, completed 상태의 git clean 보장을 반영함
- Next task: 없음
## 2026-06-19 21:49:07 - Commit created

- Task: T001 업무 카드 접근성 문구 점검 및 미세 수정
- Commit: 3591ee2bb9a7be7a72d8c360fc294a643d06ab85
- Message: Polish task card accessibility labels
## 2026-06-19 21:49:21 - Task completed

- Task: T001 업무 카드 접근성 문구 점검 및 미세 수정
- Result: T001 완료: 업무 카드의 aria-label 문구를 자연스러운 한국어로 최소 수정하고 build/lint 검증 및 리뷰 pass를 확인함
- Next task: 없음
## 2026-06-19 21:57:00 - Task completed

- Task: T001 완료 기준 안내 문구 보강
- Result: T001 완료: AI Dev Loop 완료 기준을 .ai-dev/README.md 운영 원칙에 짧게 보강하고 build/lint 검증 및 리뷰 pass를 
확인함
- Next task: 없음
## 2026-06-19 22:00:35 - Commit created

- Task: T001 AI Dev Loop 운영 순서 문서 보강
- Commit: 1f8952d265ae7d889e5a4033cba46876f9272972
- Message: Document AI dev loop operation flow
## 2026-06-19 22:00:37 - Task completed

- Task: T001 AI Dev Loop 운영 순서 문서 보강
- Result: 자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료
- Next task: 없음
## 2026-06-19 22:08:47 - Task completed

- Task: T001 업무 상태 안내 개선 범위 확인
- Result: T001 완료: 업무 상태 안내 개선 범위를 확인하고, 앱 변경 없이 TaskList 중심으로 개선 위치를 정리했으며 build/lint 검증 및 리뷰 p
ass를 확인함
- Next task: T002 업무 흐름 상태 표시 개선

codex
`App.tsx`는 이미 화면 컴포넌트로 분리되어 있고, 실제 업무 목록 문구는 `TasksView` 쪽에 있을 가능성이 큽니다. 범위를 업무 목록 UI로 유지하면서 관련 
컴포넌트만 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\src\\views\\TasksView.tsx'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\src\\components\\TaskList.tsx'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\src\\utils\\taskSummary.ts'" in D:\ai-apps\planpilot-local
 succeeded in 1749ms:
import type { FormEvent } from "react";
import { TaskCard } from "../components/TaskCard";
import { TaskForm } from "../components/TaskForm";
import type { Project, Task } from "../types";
import type { TaskSortOrder } from "../utils/taskFilters";

type TasksViewProps = {
  projects: Project[];
  filteredTasks: Task[];
  sortedTasks: Task[];
  selectedProjectFilter: string;
  showCompletedTasks: boolean;
  taskSortOrder: TaskSortOrder;
  taskSearchQuery: string;
  isTaskFormOpen: boolean;
  newTaskTitle: string;
  newTaskMemo: string;
  newTaskDueDate: string;
  newTaskPriority: Task["priority"];
  newTaskProjectId: string;
  editingTaskId: string | null;
  editTaskTitle: string;
  editTaskMemo: string;
  editTaskDueDate: string;
  editTaskPriority: Task["priority"];
  editTaskProjectId: string;
  getProjectName: (projectId: string) => string;
  onTaskSearchQueryChange: (value: string) => void;
  onShowCompletedTasksChange: (value: boolean) => void;
  onTaskSortOrderChange: (value: TaskSortOrder) => void;
  onSelectedProjectFilterChange: (value: string) => void;
  onTaskFormOpenChange: (updater: (current: boolean) => boolean) => void;
  onNewTaskTitleChange: (value: string) => void;
  onNewTaskMemoChange: (value: string) => void;
  onNewTaskDueDateChange: (value: string) => void;
  onNewTaskPriorityChange: (value: Task["priority"]) => void;
  onNewTaskProjectIdChange: (value: string) => void;
  onEditTaskTitleChange: (value: string) => void;
  onEditTaskMemoChange: (value: string) => void;
  onEditTaskDueDateChange: (value: string) => void;
  onEditTaskPriorityChange: (value: Task["priority"]) => void;
  onEditTaskProjectIdChange: (value: string) => void;
  onAddTask: (event: FormEvent<HTMLFormElement>) => void;
  onSaveEditTask: (task: Task) => void;
  onCancelEditTask: () => void;
  onToggleTaskDone: (task: Task) => void;
  onDeleteTask: (task: Task) => void;
  onStartEditTask: (task: Task) => void;
};

export function TasksView({
  projects,
  filteredTasks,
  sortedTasks,
  selectedProjectFilter,
  showCompletedTasks,
  taskSortOrder,
  taskSearchQuery,
  isTaskFormOpen,
  newTaskTitle,
  newTaskMemo,
  newTaskDueDate,
  newTaskPriority,
  newTaskProjectId,
  editingTaskId,
  editTaskTitle,
  editTaskMemo,
  editTaskDueDate,
  editTaskPriority,
  editTaskProjectId,
  getProjectName,
  onTaskSearchQueryChange,
  onShowCompletedTasksChange,
  onTaskSortOrderChange,
  onSelectedProjectFilterChange,
  onTaskFormOpenChange,
  onNewTaskTitleChange,
  onNewTaskMemoChange,
  onNewTaskDueDateChange,
  onNewTaskPriorityChange,
  onNewTaskProjectIdChange,
  onEditTaskTitleChange,
  onEditTaskMemoChange,
  onEditTaskDueDateChange,
  onEditTaskPriorityChange,
  onEditTaskProjectIdChange,
  onAddTask,
  onSaveEditTask,
  onCancelEditTask,
  onToggleTaskDone,
  onDeleteTask,
  onStartEditTask,
}: TasksViewProps) {
  const hasSearchQuery = taskSearchQuery.trim().length > 0;
  const hasProjectFilter = selectedProjectFilter !== "all";
  const hasVisibilityFilter = !showCompletedTasks;
  const emptyMessage =
    hasSearchQuery
      ? "寃?됱뼱? ?쇱튂?섎뒗 ?낅Т媛 ?놁뼱??"
      : hasProjectFilter || hasVisibilityFilter
        ? "?꾩옱 議곌굔??留욌뒗 ?낅Т媛 ?놁뼱??"
        : "?꾩쭅 ?깅줉???낅Т媛 ?놁뼱??";

  return (
    <section className="screen-card">
      <h2>?꾩껜 ?낅Т</h2>
      <p className="summary">珥?{filteredTasks.length}媛?/p>

      <label>
        ?낅Т 寃??        <input
          type="text"
          value={taskSearchQuery}
          onChange={(event) => onTaskSearchQueryChange(event.target.value)}
          placeholder="?낅Т ?쒕ぉ ?먮뒗 硫붾え ?댁슜??寃?됲븯?몄슂"
        />
      </label>

      <label>
        <input
          type="checkbox"
          checked={showCompletedTasks}
          onChange={(event) => onShowCompletedTasksChange(event.target.checked)}
        />
        ?꾨즺 ?낅Т ?쒖떆
      </label>

      <label>
        ?뺣젹
        <select
          value={taskSortOrder}
          onChange={(event) =>
            onTaskSortOrderChange(event.target.value as TaskSortOrder)
          }
        >
          <option value="none">湲곕낯 ?쒖꽌</option>
          <option value="dueDateAsc">留덇컧??鍮좊Ⅸ ??/option>
        </select>
      </label>

      <label>
        ?꾨줈?앺듃 ?꾪꽣
        <select
          value={selectedProjectFilter}
          onChange={(event) => onSelectedProjectFilterChange(event.target.value)}
        >
          <option value="all">?꾩껜 ?꾨줈?앺듃</option>
          {projects.map((project) => (
            <option key={project.id} value={project.id}>
              {project.name}
            </option>
          ))}
        </select>
      </label>

      <button
        type="button"
        onClick={() => onTaskFormOpenChange((current) => !current)}
      >
        {isTaskFormOpen ? "???낅Т 異붽? ?リ린" : "???낅Т 異붽?"}
      </button>

      {isTaskFormOpen && (
        <TaskForm
          title="???낅Т 異붽?"
          ariaLabel="?낅Т 異붽?"
          taskTitle={newTaskTitle}
          memo={newTaskMemo}
          dueDate={newTaskDueDate}
          priority={newTaskPriority}
          projectId={newTaskProjectId}
          projects={projects}
          submitLabel="?낅Т 異붽?"
          onTitleChange={onNewTaskTitleChange}
          onMemoChange={onNewTaskMemoChange}
          onDueDateChange={onNewTaskDueDateChange}
          onPriorityChange={onNewTaskPriorityChange}
          onProjectIdChange={onNewTaskProjectIdChange}
          onSubmit={onAddTask}
        />
      )}

      {filteredTasks.length === 0 ? (
        <div className="empty">
          <p>{emptyMessage}</p>
          {hasSearchQuery && <p>?ㅻⅨ 寃?됱뼱瑜??낅젰?대낫?몄슂.</p>}
        </div>
      ) : (
        <ul className="task-list">
          {sortedTasks.map((task) => {
            if (editingTaskId === task.id) {
              return (
                <li key={task.id} className="task-card">
                  <TaskForm
                    title="?낅Т ?섏젙"
                    ariaLabel="?낅Т ?섏젙"
                    taskTitle={editTaskTitle}
                    memo={editTaskMemo}
                    dueDate={editTaskDueDate}
                    priority={editTaskPriority}
                    projectId={editTaskProjectId}
                    projects={projects}
                    submitLabel="???
                    onTitleChange={onEditTaskTitleChange}
                    onMemoChange={onEditTaskMemoChange}
                    onDueDateChange={onEditTaskDueDateChange}
                    onPriorityChange={onEditTaskPriorityChange}
                    onProjectIdChange={onEditTaskProjectIdChange}
                    onSubmit={(event) => {
                      event.preventDefault();
                      onSaveEditTask(task);
                    }}
                    onCancel={onCancelEditTask}
                    className=""
                  />
                </li>
              );
            }

            return (
              <TaskCard
                key={task.id}
                task={task}
                projectName={getProjectName(task.projectId)}
                onToggleDone={onToggleTaskDone}
                onDelete={onDeleteTask}
                onStartEdit={onStartEditTask}
              />
            );
          })}
        </ul>
      )}
    </section>
  );
}

 succeeded in 1730ms:
import type { Task } from "../types";

export function getTaskSummary(tasks: Task[]) {
  const totalTasks = tasks.length;
  const completedTasks = tasks.filter((task) => task.status === "done").length;

  return { totalTasks, completedTasks };
}

 exited 1 in 1854ms:
Get-Content : 'D:\ai-apps\planpilot-local\src\components\TaskList.tsx' 경로는 존재하지 않으므로 찾을 수 없습니다.
위치 줄:2 문자:1
+ Get-Content -LiteralPath 'D:\ai-apps\planpilot-local\src\components\T ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (D:\ai-apps\plan...ts\TaskList.tsx:String) [Get-Co
ntent], ItemNotFoundEx 
   ception
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetContentCommand
 

2026-06-19T13:09:35.231324Z ERROR codex_core::tools::router: error=Exit code: 1
Wall time: 1.9 seconds
Output:
Get-Content : 'D:\ai-apps\planpilot-local\src\components\TaskList.tsx' 경로는 존재하지 않으므로 찾을 수 없습니다.
위치 줄:2 문자:1
+ Get-Content -LiteralPath 'D:\ai-apps\planpilot-local\src\components\T ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (D:\ai-apps\plan...ts\TaskList.tsx:String) [Get-Co
ntent], ItemNotFoundEx 
   ception
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetContentCommand
 

codex
업무 목록 화면의 실제 문자열은 `src/views/TasksView.tsx`에 있습니다. 출력 인코딩이 깨져 보여서 UTF-8로 다시 읽고, 상태 요약을 이 파일 안에서 
최소로 추가할지 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\src\\views\\TasksView.tsx' -Encoding UTF8" in D:\ai-apps\plan
pilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\src\\components\\TaskCard.tsx' -Encoding UTF8" in D:\ai-apps\
planpilot-local
 succeeded in 1377ms:
import { getPriorityLabel, getStatusLabel } from "../utils/taskLabels";
import { isUpcomingTask } from "../utils/dateUtils";
import type { Task } from "../types";

type TaskCardProps = {
  task: Task;
  projectName: string;
  onToggleDone: (task: Task) => void;
  onDelete: (task: Task) => void;
  onStartEdit: (task: Task) => void;
};

export function TaskCard({
  task,
  projectName,
  onToggleDone,
  onDelete,
  onStartEdit,
}: TaskCardProps) {
  const showDueSoonBadge = isUpcomingTask(task);

  return (
    <li className="task-card">
      <strong>{task.title}</strong>
      {showDueSoonBadge && (
        <span
          aria-label="마감일이 곧 다가오는 업무입니다"
          style={{
            alignSelf: "flex-start",
            border: "1px solid #d97706",
            borderRadius: "999px",
            color: "#92400e",
            fontSize: "0.78rem",
            fontWeight: 700,
            padding: "0.15rem 0.5rem",
          }}
        >
          마감 임박
        </span>
      )}
      {task.memo && <span>메모: {task.memo}</span>}
      <span>
        중요도: {getPriorityLabel(task.priority)} · 상태: {getStatusLabel(task.status)} · 프로젝트: {proj
ectName}
      </span>
      <span>{task.dueDate ? `마감일: ${task.dueDate}` : "마감일 없음"}</span>
      <button
        type="button"
        aria-label={
          task.status === "done"
            ? `'${task.title}' 업무를 미완료로 되돌리기`
            : `'${task.title}' 업무를 완료로 표시하기`
        }
        onClick={() => onToggleDone(task)}
      >
        {task.status === "done" ? "미완료로 되돌리기" : "완료로 표시"}
      </button>
      <button
        type="button"
        aria-label={`'${task.title}' 업무 삭제하기`}
        onClick={() => onDelete(task)}
      >
        삭제
      </button>
      <button
        type="button"
        aria-label={`'${task.title}' 업무 수정하기`}
        onClick={() => onStartEdit(task)}
      >
        수정
      </button>
    </li>
  );
}

 succeeded in 1436ms:
import type { FormEvent } from "react";
import { TaskCard } from "../components/TaskCard";
import { TaskForm } from "../components/TaskForm";
import type { Project, Task } from "../types";
import type { TaskSortOrder } from "../utils/taskFilters";

type TasksViewProps = {
  projects: Project[];
  filteredTasks: Task[];
  sortedTasks: Task[];
  selectedProjectFilter: string;
  showCompletedTasks: boolean;
  taskSortOrder: TaskSortOrder;
  taskSearchQuery: string;
  isTaskFormOpen: boolean;
  newTaskTitle: string;
  newTaskMemo: string;
  newTaskDueDate: string;
  newTaskPriority: Task["priority"];
  newTaskProjectId: string;
  editingTaskId: string | null;
  editTaskTitle: string;
  editTaskMemo: string;
  editTaskDueDate: string;
  editTaskPriority: Task["priority"];
  editTaskProjectId: string;
  getProjectName: (projectId: string) => string;
  onTaskSearchQueryChange: (value: string) => void;
  onShowCompletedTasksChange: (value: boolean) => void;
  onTaskSortOrderChange: (value: TaskSortOrder) => void;
  onSelectedProjectFilterChange: (value: string) => void;
  onTaskFormOpenChange: (updater: (current: boolean) => boolean) => void;
  onNewTaskTitleChange: (value: string) => void;
  onNewTaskMemoChange: (value: string) => void;
  onNewTaskDueDateChange: (value: string) => void;
  onNewTaskPriorityChange: (value: Task["priority"]) => void;
  onNewTaskProjectIdChange: (value: string) => void;
  onEditTaskTitleChange: (value: string) => void;
  onEditTaskMemoChange: (value: string) => void;
  onEditTaskDueDateChange: (value: string) => void;
  onEditTaskPriorityChange: (value: Task["priority"]) => void;
  onEditTaskProjectIdChange: (value: string) => void;
  onAddTask: (event: FormEvent<HTMLFormElement>) => void;
  onSaveEditTask: (task: Task) => void;
  onCancelEditTask: () => void;
  onToggleTaskDone: (task: Task) => void;
  onDeleteTask: (task: Task) => void;
  onStartEditTask: (task: Task) => void;
};

export function TasksView({
  projects,
  filteredTasks,
  sortedTasks,
  selectedProjectFilter,
  showCompletedTasks,
  taskSortOrder,
  taskSearchQuery,
  isTaskFormOpen,
  newTaskTitle,
  newTaskMemo,
  newTaskDueDate,
  newTaskPriority,
  newTaskProjectId,
  editingTaskId,
  editTaskTitle,
  editTaskMemo,
  editTaskDueDate,
  editTaskPriority,
  editTaskProjectId,
  getProjectName,
  onTaskSearchQueryChange,
  onShowCompletedTasksChange,
  onTaskSortOrderChange,
  onSelectedProjectFilterChange,
  onTaskFormOpenChange,
  onNewTaskTitleChange,
  onNewTaskMemoChange,
  onNewTaskDueDateChange,
  onNewTaskPriorityChange,
  onNewTaskProjectIdChange,
  onEditTaskTitleChange,
  onEditTaskMemoChange,
  onEditTaskDueDateChange,
  onEditTaskPriorityChange,
  onEditTaskProjectIdChange,
  onAddTask,
  onSaveEditTask,
  onCancelEditTask,
  onToggleTaskDone,
  onDeleteTask,
  onStartEditTask,
}: TasksViewProps) {
  const hasSearchQuery = taskSearchQuery.trim().length > 0;
  const hasProjectFilter = selectedProjectFilter !== "all";
  const hasVisibilityFilter = !showCompletedTasks;
  const emptyMessage =
    hasSearchQuery
      ? "검색어와 일치하는 업무가 없어요."
      : hasProjectFilter || hasVisibilityFilter
        ? "현재 조건에 맞는 업무가 없어요."
        : "아직 등록된 업무가 없어요.";

  return (
    <section className="screen-card">
      <h2>전체 업무</h2>
      <p className="summary">총 {filteredTasks.length}개</p>

      <label>
        업무 검색
        <input
          type="text"
          value={taskSearchQuery}
          onChange={(event) => onTaskSearchQueryChange(event.target.value)}
          placeholder="업무 제목 또는 메모 내용을 검색하세요"
        />
      </label>

      <label>
        <input
          type="checkbox"
          checked={showCompletedTasks}
          onChange={(event) => onShowCompletedTasksChange(event.target.checked)}
        />
        완료 업무 표시
      </label>

      <label>
        정렬
        <select
          value={taskSortOrder}
          onChange={(event) =>
            onTaskSortOrderChange(event.target.value as TaskSortOrder)
          }
        >
          <option value="none">기본 순서</option>
          <option value="dueDateAsc">마감일 빠른 순</option>
        </select>
      </label>

      <label>
        프로젝트 필터
        <select
          value={selectedProjectFilter}
          onChange={(event) => onSelectedProjectFilterChange(event.target.value)}
        >
          <option value="all">전체 프로젝트</option>
          {projects.map((project) => (
            <option key={project.id} value={project.id}>
              {project.name}
            </option>
          ))}
        </select>
      </label>

      <button
        type="button"
        onClick={() => onTaskFormOpenChange((current) => !current)}
      >
        {isTaskFormOpen ? "새 업무 추가 닫기" : "새 업무 추가"}
      </button>

      {isTaskFormOpen && (
        <TaskForm
          title="새 업무 추가"
          ariaLabel="업무 추가"
          taskTitle={newTaskTitle}
          memo={newTaskMemo}
          dueDate={newTaskDueDate}
          priority={newTaskPriority}
          projectId={newTaskProjectId}
          projects={projects}
          submitLabel="업무 추가"
          onTitleChange={onNewTaskTitleChange}
          onMemoChange={onNewTaskMemoChange}
          onDueDateChange={onNewTaskDueDateChange}
          onPriorityChange={onNewTaskPriorityChange}
          onProjectIdChange={onNewTaskProjectIdChange}
          onSubmit={onAddTask}
        />
      )}

      {filteredTasks.length === 0 ? (
        <div className="empty">
          <p>{emptyMessage}</p>
          {hasSearchQuery && <p>다른 검색어를 입력해보세요.</p>}
        </div>
      ) : (
        <ul className="task-list">
          {sortedTasks.map((task) => {
            if (editingTaskId === task.id) {
              return (
                <li key={task.id} className="task-card">
                  <TaskForm
                    title="업무 수정"
                    ariaLabel="업무 수정"
                    taskTitle={editTaskTitle}
                    memo={editTaskMemo}
                    dueDate={editTaskDueDate}
                    priority={editTaskPriority}
                    projectId={editTaskProjectId}
                    projects={projects}
                    submitLabel="저장"
                    onTitleChange={onEditTaskTitleChange}
                    onMemoChange={onEditTaskMemoChange}
                    onDueDateChange={onEditTaskDueDateChange}
                    onPriorityChange={onEditTaskPriorityChange}
                    onProjectIdChange={onEditTaskProjectIdChange}
                    onSubmit={(event) => {
                      event.preventDefault();
                      onSaveEditTask(task);
                    }}
                    onCancel={onCancelEditTask}
                    className=""
                  />
                </li>
              );
            }

            return (
              <TaskCard
                key={task.id}
                task={task}
                projectName={getProjectName(task.projectId)}
                onToggleDone={onToggleTaskDone}
                onDelete={onDeleteTask}
                onStartEdit={onStartEditTask}
              />
            );
          })}
        </ul>
      )}
    </section>
  );
}

codex
현재 업무 카드는 이미 상태 라벨을 표시하지만, 목록 상단 요약은 총 개수만 보여서 완료/남은 업무 흐름이 약합니다. `TasksView.tsx` 안에서 필터된 목록 기준의
 진행 중/완료/남은 업무 요약과 빈 상태 문구만 보강하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\src\\types.ts' -Encoding UTF8" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\src\\utils\\taskLabels.ts' -Encoding UTF8" in D:\ai-apps\plan
pilot-local
 succeeded in 1379ms:
// src/types.ts

export type Task = {
  id: string;
  title: string;
  memo?: string;
  dueDate?: string;
  priority: "low" | "medium" | "high";
  status: "todo" | "in_progress" | "done";
  projectId: string;
  tags: string[];
  estimatedMinutes?: number;
  createdAt: string;
  updatedAt: string;
  completedAt?: string;
  sortOrder?: number;
};

export type Project = {
  id: string;
  name: string;
  description?: string;
  color?: string;
  createdAt: string;
  updatedAt: string;
  archivedAt?: string;
};

export type AppSettings = {
  theme: "light";
  language: "ko";
  aiProvider: "rule_based";
  enableNotifications: false;
  firstLaunchCompleted: boolean;
  createdAt: string;
  updatedAt: string;
};

export type StoredAppSettings = AppSettings & {
  id: string;
};

 succeeded in 1446ms:
import type { Task } from "../types";

export function getPriorityLabel(priority: Task["priority"]) {
  switch (priority) {
    case "high":
      return "높음";
    case "medium":
      return "보통";
    case "low":
      return "낮음";
    default:
      return priority;
  }
}

export function getStatusLabel(status: Task["status"]) {
  return status === "done" ? "완료" : "미완료";
}

codex
상태 타입은 `todo`, `in_progress`, `done` 세 가지인데 현재 라벨 유틸은 `done` 외 전부 `미완료`로 묶고 있습니다. 이 유틸 라벨을 보강하면 
카드 상태 표시도 자연스럽게 개선되므로, `TasksView.tsx` 요약과 `taskLabels.ts` 라벨만 작게 수정하겠습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\src\utils\taskLabels.ts
diff --git a/src/utils/taskLabels.ts b/src/utils/taskLabels.ts
index 1beb326e6b30ca0a59c582dfef00543eb33f4f67..4c11ca74020845258297cb362dd8dfd25bda5be9
--- a/src/utils/taskLabels.ts
+++ b/src/utils/taskLabels.ts
@@ -14,5 +14,14 @@
 }
 
 export function getStatusLabel(status: Task["status"]) {
-  return status === "done" ? "완료" : "미완료";
+  switch (status) {
+    case "in_progress":
+      return "진행 중";
+    case "done":
+      return "완료";
+    case "todo":
+      return "남은 업무";
+    default:
+      return status;
+  }
 }

diff --git a/src/utils/taskLabels.ts b/src/utils/taskLabels.ts
index 1beb326e6b30ca0a59c582dfef00543eb33f4f67..4c11ca74020845258297cb362dd8dfd25bda5be9
--- a/src/utils/taskLabels.ts
+++ b/src/utils/taskLabels.ts
@@ -14,5 +14,14 @@
 }
 
 export function getStatusLabel(status: Task["status"]) {
-  return status === "done" ? "완료" : "미완료";
+  switch (status) {
+    case "in_progress":
+      return "진행 중";
+    case "done":
+      return "완료";
+    case "todo":
+      return "남은 업무";
+    default:
+      return status;
+  }
 }

codex
상태 라벨 유틸을 세 상태가 각각 보이도록 바꿨습니다. 이제 목록 상단에 같은 기준의 요약 문구를 추가해, 필터 결과에서도 남은 업무와 완료 업무를 바로 읽을 수 있게 하겠
습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\src\views\TasksView.tsx
diff --git a/src/utils/taskLabels.ts b/src/utils/taskLabels.ts
index 1beb326e6b30ca0a59c582dfef00543eb33f4f67..4c11ca74020845258297cb362dd8dfd25bda5be9
--- a/src/utils/taskLabels.ts
+++ b/src/utils/taskLabels.ts
@@ -14,5 +14,14 @@
 }
 
 export function getStatusLabel(status: Task["status"]) {
-  return status === "done" ? "완료" : "미완료";
+  switch (status) {
+    case "in_progress":
+      return "진행 중";
+    case "done":
+      return "완료";
+    case "todo":
+      return "남은 업무";
+    default:
+      return status;
+  }
 }
diff --git a/src/views/TasksView.tsx b/src/views/TasksView.tsx
index f23e7cd889a557887c26f9e201c00aa5c2de6553..5d873e3b4812b0e9ae59dc501f8c1439bc16331a
--- a/src/views/TasksView.tsx
+++ b/src/views/TasksView.tsx
@@ -94,6 +94,9 @@
   const hasSearchQuery = taskSearchQuery.trim().length > 0;
   const hasProjectFilter = selectedProjectFilter !== "all";
   const hasVisibilityFilter = !showCompletedTasks;
+  const completedTaskCount = filteredTasks.filter((task) => task.status === "done").length;
+  const inProgressTaskCount = filteredTasks.filter((task) => task.status === "in_progress").len
gth;
+  const remainingTaskCount = filteredTasks.length - completedTaskCount;
   const emptyMessage =
     hasSearchQuery
       ? "검색어와 일치하는 업무가 없어요."
@@ -104,7 +107,9 @@
   return (
     <section className="screen-card">
       <h2>전체 업무</h2>
-      <p className="summary">총 {filteredTasks.length}개</p>
+      <p className="summary">
+        총 {filteredTasks.length}개 · 진행 중 {inProgressTaskCount}개 · 완료 {completedTaskCount}개 · 남은
 업무 {remainingTaskCount}개
+      </p>
 
       <label>
         업무 검색

diff --git a/src/utils/taskLabels.ts b/src/utils/taskLabels.ts
index 1beb326e6b30ca0a59c582dfef00543eb33f4f67..4c11ca74020845258297cb362dd8dfd25bda5be9
--- a/src/utils/taskLabels.ts
+++ b/src/utils/taskLabels.ts
@@ -14,5 +14,14 @@
 }
 
 export function getStatusLabel(status: Task["status"]) {
-  return status === "done" ? "완료" : "미완료";
+  switch (status) {
+    case "in_progress":
+      return "진행 중";
+    case "done":
+      return "완료";
+    case "todo":
+      return "남은 업무";
+    default:
+      return status;
+  }
 }
diff --git a/src/views/TasksView.tsx b/src/views/TasksView.tsx
index f23e7cd889a557887c26f9e201c00aa5c2de6553..5d873e3b4812b0e9ae59dc501f8c1439bc16331a
--- a/src/views/TasksView.tsx
+++ b/src/views/TasksView.tsx
@@ -94,6 +94,9 @@
   const hasSearchQuery = taskSearchQuery.trim().length > 0;
   const hasProjectFilter = selectedProjectFilter !== "all";
   const hasVisibilityFilter = !showCompletedTasks;
+  const completedTaskCount = filteredTasks.filter((task) => task.status === "done").length;
+  const inProgressTaskCount = filteredTasks.filter((task) => task.status === "in_progress").len
gth;
+  const remainingTaskCount = filteredTasks.length - completedTaskCount;
   const emptyMessage =
     hasSearchQuery
       ? "검색어와 일치하는 업무가 없어요."
@@ -104,7 +107,9 @@
   return (
     <section className="screen-card">
       <h2>전체 업무</h2>
-      <p className="summary">총 {filteredTasks.length}개</p>
+      <p className="summary">
+        총 {filteredTasks.length}개 · 진행 중 {inProgressTaskCount}개 · 완료 {completedTaskCount}개 · 남은
 업무 {remainingTaskCount}개
+      </p>
 
       <label>
         업무 검색

codex
구현 변경은 업무 목록 영역으로 제한했습니다. 다음으로 타입스크립트 문법 수준에서 눈에 띄는 문제와 줄 길이/표현을 확인하고, AI Dev Loop 로그에 이번 작업 요약을
 남기겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\src\\views\\TasksView.tsx' -Encoding UTF8" in D:\ai-apps\plan
pilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\src\\utils\\taskLabels.ts' -Encoding UTF8" in D:\ai-apps\plan
pilot-local
 succeeded in 1293ms:
import type { Task } from "../types";

export function getPriorityLabel(priority: Task["priority"]) {
  switch (priority) {
    case "high":
      return "높음";
    case "medium":
      return "보통";
    case "low":
      return "낮음";
    default:
      return priority;
  }
}

export function getStatusLabel(status: Task["status"]) {
  switch (status) {
    case "in_progress":
      return "진행 중";
    case "done":
      return "완료";
    case "todo":
      return "남은 업무";
    default:
      return status;
  }
}

 succeeded in 1349ms:
import type { FormEvent } from "react";
import { TaskCard } from "../components/TaskCard";
import { TaskForm } from "../components/TaskForm";
import type { Project, Task } from "../types";
import type { TaskSortOrder } from "../utils/taskFilters";

type TasksViewProps = {
  projects: Project[];
  filteredTasks: Task[];
  sortedTasks: Task[];
  selectedProjectFilter: string;
  showCompletedTasks: boolean;
  taskSortOrder: TaskSortOrder;
  taskSearchQuery: string;
  isTaskFormOpen: boolean;
  newTaskTitle: string;
  newTaskMemo: string;
  newTaskDueDate: string;
  newTaskPriority: Task["priority"];
  newTaskProjectId: string;
  editingTaskId: string | null;
  editTaskTitle: string;
  editTaskMemo: string;
  editTaskDueDate: string;
  editTaskPriority: Task["priority"];
  editTaskProjectId: string;
  getProjectName: (projectId: string) => string;
  onTaskSearchQueryChange: (value: string) => void;
  onShowCompletedTasksChange: (value: boolean) => void;
  onTaskSortOrderChange: (value: TaskSortOrder) => void;
  onSelectedProjectFilterChange: (value: string) => void;
  onTaskFormOpenChange: (updater: (current: boolean) => boolean) => void;
  onNewTaskTitleChange: (value: string) => void;
  onNewTaskMemoChange: (value: string) => void;
  onNewTaskDueDateChange: (value: string) => void;
  onNewTaskPriorityChange: (value: Task["priority"]) => void;
  onNewTaskProjectIdChange: (value: string) => void;
  onEditTaskTitleChange: (value: string) => void;
  onEditTaskMemoChange: (value: string) => void;
  onEditTaskDueDateChange: (value: string) => void;
  onEditTaskPriorityChange: (value: Task["priority"]) => void;
  onEditTaskProjectIdChange: (value: string) => void;
  onAddTask: (event: FormEvent<HTMLFormElement>) => void;
  onSaveEditTask: (task: Task) => void;
  onCancelEditTask: () => void;
  onToggleTaskDone: (task: Task) => void;
  onDeleteTask: (task: Task) => void;
  onStartEditTask: (task: Task) => void;
};

export function TasksView({
  projects,
  filteredTasks,
  sortedTasks,
  selectedProjectFilter,
  showCompletedTasks,
  taskSortOrder,
  taskSearchQuery,
  isTaskFormOpen,
  newTaskTitle,
  newTaskMemo,
  newTaskDueDate,
  newTaskPriority,
  newTaskProjectId,
  editingTaskId,
  editTaskTitle,
  editTaskMemo,
  editTaskDueDate,
  editTaskPriority,
  editTaskProjectId,
  getProjectName,
  onTaskSearchQueryChange,
  onShowCompletedTasksChange,
  onTaskSortOrderChange,
  onSelectedProjectFilterChange,
  onTaskFormOpenChange,
  onNewTaskTitleChange,
  onNewTaskMemoChange,
  onNewTaskDueDateChange,
  onNewTaskPriorityChange,
  onNewTaskProjectIdChange,
  onEditTaskTitleChange,
  onEditTaskMemoChange,
  onEditTaskDueDateChange,
  onEditTaskPriorityChange,
  onEditTaskProjectIdChange,
  onAddTask,
  onSaveEditTask,
  onCancelEditTask,
  onToggleTaskDone,
  onDeleteTask,
  onStartEditTask,
}: TasksViewProps) {
  const hasSearchQuery = taskSearchQuery.trim().length > 0;
  const hasProjectFilter = selectedProjectFilter !== "all";
  const hasVisibilityFilter = !showCompletedTasks;
  const completedTaskCount = filteredTasks.filter((task) => task.status === "done").length;
  const inProgressTaskCount = filteredTasks.filter((task) => task.status === "in_progress").leng
th;
  const remainingTaskCount = filteredTasks.length - completedTaskCount;
  const emptyMessage =
    hasSearchQuery
      ? "검색어와 일치하는 업무가 없어요."
      : hasProjectFilter || hasVisibilityFilter
        ? "현재 조건에 맞는 업무가 없어요."
        : "아직 등록된 업무가 없어요.";

  return (
    <section className="screen-card">
      <h2>전체 업무</h2>
      <p className="summary">
        총 {filteredTasks.length}개 · 진행 중 {inProgressTaskCount}개 · 완료 {completedTaskCount}개 · 남은 
업무 {remainingTaskCount}개
      </p>

      <label>
        업무 검색
        <input
          type="text"
          value={taskSearchQuery}
          onChange={(event) => onTaskSearchQueryChange(event.target.value)}
          placeholder="업무 제목 또는 메모 내용을 검색하세요"
        />
      </label>

      <label>
        <input
          type="checkbox"
          checked={showCompletedTasks}
          onChange={(event) => onShowCompletedTasksChange(event.target.checked)}
        />
        완료 업무 표시
      </label>

      <label>
        정렬
        <select
          value={taskSortOrder}
          onChange={(event) =>
            onTaskSortOrderChange(event.target.value as TaskSortOrder)
          }
        >
          <option value="none">기본 순서</option>
          <option value="dueDateAsc">마감일 빠른 순</option>
        </select>
      </label>

      <label>
        프로젝트 필터
        <select
          value={selectedProjectFilter}
          onChange={(event) => onSelectedProjectFilterChange(event.target.value)}
        >
          <option value="all">전체 프로젝트</option>
          {projects.map((project) => (
            <option key={project.id} value={project.id}>
              {project.name}
            </option>
          ))}
        </select>
      </label>

      <button
        type="button"
        onClick={() => onTaskFormOpenChange((current) => !current)}
      >
        {isTaskFormOpen ? "새 업무 추가 닫기" : "새 업무 추가"}
      </button>

      {isTaskFormOpen && (
        <TaskForm
          title="새 업무 추가"
          ariaLabel="업무 추가"
          taskTitle={newTaskTitle}
          memo={newTaskMemo}
          dueDate={newTaskDueDate}
          priority={newTaskPriority}
          projectId={newTaskProjectId}
          projects={projects}
          submitLabel="업무 추가"
          onTitleChange={onNewTaskTitleChange}
          onMemoChange={onNewTaskMemoChange}
          onDueDateChange={onNewTaskDueDateChange}
          onPriorityChange={onNewTaskPriorityChange}
          onProjectIdChange={onNewTaskProjectIdChange}
          onSubmit={onAddTask}
        />
      )}

      {filteredTasks.length === 0 ? (
        <div className="empty">
          <p>{emptyMessage}</p>
          {hasSearchQuery && <p>다른 검색어를 입력해보세요.</p>}
        </div>
      ) : (
        <ul className="task-list">
          {sortedTasks.map((task) => {
            if (editingTaskId === task.id) {
              return (
                <li key={task.id} className="task-card">
                  <TaskForm
                    title="업무 수정"
                    ariaLabel="업무 수정"
                    taskTitle={editTaskTitle}
                    memo={editTaskMemo}
                    dueDate={editTaskDueDate}
                    priority={editTaskPriority}
                    projectId={editTaskProjectId}
                    projects={projects}
                    submitLabel="저장"
                    onTitleChange={onEditTaskTitleChange}
                    onMemoChange={onEditTaskMemoChange}
                    onDueDateChange={onEditTaskDueDateChange}
                    onPriorityChange={onEditTaskPriorityChange}
                    onProjectIdChange={onEditTaskProjectIdChange}
                    onSubmit={(event) => {
                      event.preventDefault();
                      onSaveEditTask(task);
                    }}
                    onCancel={onCancelEditTask}
                    className=""
                  />
                </li>
              );
            }

            return (
              <TaskCard
                key={task.id}
                task={task}
                projectName={getProjectName(task.projectId)}
                onToggleDone={onToggleTaskDone}
                onDelete={onDeleteTask}
                onStartEdit={onStartEditTask}
              />
            );
          })}
        </ul>
      )}
    </section>
  );
}

diff --git a/src/utils/taskLabels.ts b/src/utils/taskLabels.ts
index 1beb326e6b30ca0a59c582dfef00543eb33f4f67..4c11ca74020845258297cb362dd8dfd25bda5be9
--- a/src/utils/taskLabels.ts
+++ b/src/utils/taskLabels.ts
@@ -14,5 +14,14 @@
 }
 
 export function getStatusLabel(status: Task["status"]) {
-  return status === "done" ? "완료" : "미완료";
+  switch (status) {
+    case "in_progress":
+      return "진행 중";
+    case "done":
+      return "완료";
+    case "todo":
+      return "남은 업무";
+    default:
+      return status;
+  }
 }
diff --git a/src/views/TasksView.tsx b/src/views/TasksView.tsx
index f23e7cd889a557887c26f9e201c00aa5c2de6553..5d873e3b4812b0e9ae59dc501f8c1439bc16331a
--- a/src/views/TasksView.tsx
+++ b/src/views/TasksView.tsx
@@ -94,6 +94,9 @@
   const hasSearchQuery = taskSearchQuery.trim().length > 0;
   const hasProjectFilter = selectedProjectFilter !== "all";
   const hasVisibilityFilter = !showCompletedTasks;
+  const completedTaskCount = filteredTasks.filter((task) => task.status === "done").length;
+  const inProgressTaskCount = filteredTasks.filter((task) => task.status === "in_progress").len
gth;
+  const remainingTaskCount = filteredTasks.length - completedTaskCount;
   const emptyMessage =
     hasSearchQuery
       ? "검색어와 일치하는 업무가 없어요."
@@ -104,7 +107,9 @@
   return (
     <section className="screen-card">
       <h2>전체 업무</h2>
-      <p className="summary">총 {filteredTasks.length}개</p>
+      <p className="summary">
+        총 {filteredTasks.length}개 · 진행 중 {inProgressTaskCount}개 · 완료 {completedTaskCount}개 · 남은
 업무 {remainingTaskCount}개
+      </p>
 
       <label>
         업무 검색

apply patch
patch: completed
D:\ai-apps\planpilot-local\src\views\TasksView.tsx
diff --git a/src/utils/taskLabels.ts b/src/utils/taskLabels.ts
index 1beb326e6b30ca0a59c582dfef00543eb33f4f67..4c11ca74020845258297cb362dd8dfd25bda5be9
--- a/src/utils/taskLabels.ts
+++ b/src/utils/taskLabels.ts
@@ -14,5 +14,14 @@
 }
 
 export function getStatusLabel(status: Task["status"]) {
-  return status === "done" ? "완료" : "미완료";
+  switch (status) {
+    case "in_progress":
+      return "진행 중";
+    case "done":
+      return "완료";
+    case "todo":
+      return "남은 업무";
+    default:
+      return status;
+  }
 }
diff --git a/src/views/TasksView.tsx b/src/views/TasksView.tsx
index f23e7cd889a557887c26f9e201c00aa5c2de6553..2f3f8557146e85ad61334edd99d79444b0fc0229
--- a/src/views/TasksView.tsx
+++ b/src/views/TasksView.tsx
@@ -94,6 +94,13 @@
   const hasSearchQuery = taskSearchQuery.trim().length > 0;
   const hasProjectFilter = selectedProjectFilter !== "all";
   const hasVisibilityFilter = !showCompletedTasks;
+  const completedTaskCount = filteredTasks.filter(
+    (task) => task.status === "done",
+  ).length;
+  const inProgressTaskCount = filteredTasks.filter(
+    (task) => task.status === "in_progress",
+  ).length;
+  const remainingTaskCount = filteredTasks.length - completedTaskCount;
   const emptyMessage =
     hasSearchQuery
       ? "검색어와 일치하는 업무가 없어요."
@@ -104,7 +111,10 @@
   return (
     <section className="screen-card">
       <h2>전체 업무</h2>
-      <p className="summary">총 {filteredTasks.length}개</p>
+      <p className="summary">
+        총 {filteredTasks.length}개 · 진행 중 {inProgressTaskCount}개 · 완료{" "}
+        {completedTaskCount}개 · 남은 업무 {remainingTaskCount}개
+      </p>
 
       <label>
         업무 검색

diff --git a/src/utils/taskLabels.ts b/src/utils/taskLabels.ts
index 1beb326e6b30ca0a59c582dfef00543eb33f4f67..4c11ca74020845258297cb362dd8dfd25bda5be9
--- a/src/utils/taskLabels.ts
+++ b/src/utils/taskLabels.ts
@@ -14,5 +14,14 @@
 }
 
 export function getStatusLabel(status: Task["status"]) {
-  return status === "done" ? "완료" : "미완료";
+  switch (status) {
+    case "in_progress":
+      return "진행 중";
+    case "done":
+      return "완료";
+    case "todo":
+      return "남은 업무";
+    default:
+      return status;
+  }
 }
diff --git a/src/views/TasksView.tsx b/src/views/TasksView.tsx
index f23e7cd889a557887c26f9e201c00aa5c2de6553..2f3f8557146e85ad61334edd99d79444b0fc0229
--- a/src/views/TasksView.tsx
+++ b/src/views/TasksView.tsx
@@ -94,6 +94,13 @@
   const hasSearchQuery = taskSearchQuery.trim().length > 0;
   const hasProjectFilter = selectedProjectFilter !== "all";
   const hasVisibilityFilter = !showCompletedTasks;
+  const completedTaskCount = filteredTasks.filter(
+    (task) => task.status === "done",
+  ).length;
+  const inProgressTaskCount = filteredTasks.filter(
+    (task) => task.status === "in_progress",
+  ).length;
+  const remainingTaskCount = filteredTasks.length - completedTaskCount;
   const emptyMessage =
     hasSearchQuery
       ? "검색어와 일치하는 업무가 없어요."
@@ -104,7 +111,10 @@
   return (
     <section className="screen-card">
       <h2>전체 업무</h2>
-      <p className="summary">총 {filteredTasks.length}개</p>
+      <p className="summary">
+        총 {filteredTasks.length}개 · 진행 중 {inProgressTaskCount}개 · 완료{" "}
+        {completedTaskCount}개 · 남은 업무 {remainingTaskCount}개
+      </p>
 
       <label>
         업무 검색

codex
코드 변경은 완료했고, 빌드/린트는 이번 지시에서 자동 실행 대상이 아니라 실행하지 않습니다. 메타 기록을 남기기 위해 현재 시각만 확인한 뒤 `.ai-dev/loop-lo
g.md`에 작업 요약을 추가하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Date -Format 'yyy
y-MM-dd HH:mm:ss'" in D:\ai-apps\planpilot-local
 succeeded in 1088ms:
2026-06-19 22:10:34

diff --git a/src/utils/taskLabels.ts b/src/utils/taskLabels.ts
index 1beb326e6b30ca0a59c582dfef00543eb33f4f67..4c11ca74020845258297cb362dd8dfd25bda5be9
--- a/src/utils/taskLabels.ts
+++ b/src/utils/taskLabels.ts
@@ -14,5 +14,14 @@
 }
 
 export function getStatusLabel(status: Task["status"]) {
-  return status === "done" ? "완료" : "미완료";
+  switch (status) {
+    case "in_progress":
+      return "진행 중";
+    case "done":
+      return "완료";
+    case "todo":
+      return "남은 업무";
+    default:
+      return status;
+  }
 }
diff --git a/src/views/TasksView.tsx b/src/views/TasksView.tsx
index f23e7cd889a557887c26f9e201c00aa5c2de6553..2f3f8557146e85ad61334edd99d79444b0fc0229
--- a/src/views/TasksView.tsx
+++ b/src/views/TasksView.tsx
@@ -94,6 +94,13 @@
   const hasSearchQuery = taskSearchQuery.trim().length > 0;
   const hasProjectFilter = selectedProjectFilter !== "all";
   const hasVisibilityFilter = !showCompletedTasks;
+  const completedTaskCount = filteredTasks.filter(
+    (task) => task.status === "done",
+  ).length;
+  const inProgressTaskCount = filteredTasks.filter(
+    (task) => task.status === "in_progress",
+  ).length;
+  const remainingTaskCount = filteredTasks.length - completedTaskCount;
   const emptyMessage =
     hasSearchQuery
       ? "검색어와 일치하는 업무가 없어요."
@@ -104,7 +111,10 @@
   return (
     <section className="screen-card">
       <h2>전체 업무</h2>
-      <p className="summary">총 {filteredTasks.length}개</p>
+      <p className="summary">
+        총 {filteredTasks.length}개 · 진행 중 {inProgressTaskCount}개 · 완료{" "}
+        {completedTaskCount}개 · 남은 업무 {remainingTaskCount}개
+      </p>
 
       <label>
         업무 검색

codex
`.ai-dev/loop-log.md`는 구현 변경과 별도로 요구된 AI Dev Loop 메타 기록입니다. 앱 동작에는 영향을 주지 않는 작업 로그만 끝에 추가하겠습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\.ai-dev\loop-log.md
diff --git a/.ai-dev/loop-log.md b/.ai-dev/loop-log.md
index 2580698a6cddb192c5cfc98ff5239be81b73d3e9..addb38f81cbf4518b9545d8f3c1dccd757b54f21
--- a/.ai-dev/loop-log.md
+++ b/.ai-dev/loop-log.md
@@ -235,4 +235,11 @@
 
 - Task: T001 업무 상태 안내 개선 범위 확인
 - Result: T001 완료: 업무 상태 안내 개선 범위를 확인하고, 앱 변경 없이 TaskList 중심으로 개선 위치를 정리했으며 build/lint 검증 및 리뷰 
pass를 확인함
-- Next task: T002 업무 흐름 상태 표시 개선
\ No newline at end of file
+- Next task: T002 업무 흐름 상태 표시 개선
+
+## 2026-06-19 22:10:34 - Task progress
+
+- Task: T002 업무 흐름 상태 표시 개선
+- Result: 업무 목록 상단 요약에 진행 중, 완료, 남은 업무 개수를 표시하고 업무 카드 상태 라벨을 todo/in_progress/done 상태별 한국어 문구로 
구분함
+- Verification: build/test/lint는 현재 프롬프트에서 자동 실행 지시가 없어 실행하지 않음
+- Excluded: DB schema 변경, 저장 구조 변경, 새 화면 추가, 대규모 리팩터링, git commit 없음
diff --git a/src/utils/taskLabels.ts b/src/utils/taskLabels.ts
index 1beb326e6b30ca0a59c582dfef00543eb33f4f67..4c11ca74020845258297cb362dd8dfd25bda5be9
--- a/src/utils/taskLabels.ts
+++ b/src/utils/taskLabels.ts
@@ -14,5 +14,14 @@
 }
 
 export function getStatusLabel(status: Task["status"]) {
-  return status === "done" ? "완료" : "미완료";
+  switch (status) {
+    case "in_progress":
+      return "진행 중";
+    case "done":
+      return "완료";
+    case "todo":
+      return "남은 업무";
+    default:
+      return status;
+  }
 }
diff --git a/src/views/TasksView.tsx b/src/views/TasksView.tsx
index f23e7cd889a557887c26f9e201c00aa5c2de6553..2f3f8557146e85ad61334edd99d79444b0fc0229
--- a/src/views/TasksView.tsx
+++ b/src/views/TasksView.tsx
@@ -94,6 +94,13 @@
   const hasSearchQuery = taskSearchQuery.trim().length > 0;
   const hasProjectFilter = selectedProjectFilter !== "all";
   const hasVisibilityFilter = !showCompletedTasks;
+  const completedTaskCount = filteredTasks.filter(
+    (task) => task.status === "done",
+  ).length;
+  const inProgressTaskCount = filteredTasks.filter(
+    (task) => task.status === "in_progress",
+  ).length;
+  const remainingTaskCount = filteredTasks.length - completedTaskCount;
   const emptyMessage =
     hasSearchQuery
       ? "검색어와 일치하는 업무가 없어요."
@@ -104,7 +111,10 @@
   return (
     <section className="screen-card">
       <h2>전체 업무</h2>
-      <p className="summary">총 {filteredTasks.length}개</p>
+      <p className="summary">
+        총 {filteredTasks.length}개 · 진행 중 {inProgressTaskCount}개 · 완료{" "}
+        {completedTaskCount}개 · 남은 업무 {remainingTaskCount}개
+      </p>
 
       <label>
         업무 검색

diff --git a/.ai-dev/loop-log.md b/.ai-dev/loop-log.md
index 2580698a6cddb192c5cfc98ff5239be81b73d3e9..addb38f81cbf4518b9545d8f3c1dccd757b54f21
--- a/.ai-dev/loop-log.md
+++ b/.ai-dev/loop-log.md
@@ -235,4 +235,11 @@
 
 - Task: T001 업무 상태 안내 개선 범위 확인
 - Result: T001 완료: 업무 상태 안내 개선 범위를 확인하고, 앱 변경 없이 TaskList 중심으로 개선 위치를 정리했으며 build/lint 검증 및 리뷰 
pass를 확인함
-- Next task: T002 업무 흐름 상태 표시 개선
\ No newline at end of file
+- Next task: T002 업무 흐름 상태 표시 개선
+
+## 2026-06-19 22:10:34 - Task progress
+
+- Task: T002 업무 흐름 상태 표시 개선
+- Result: 업무 목록 상단 요약에 진행 중, 완료, 남은 업무 개수를 표시하고 업무 카드 상태 라벨을 todo/in_progress/done 상태별 한국어 문구로 
구분함
+- Verification: build/test/lint는 현재 프롬프트에서 자동 실행 지시가 없어 실행하지 않음
+- Excluded: DB schema 변경, 저장 구조 변경, 새 화면 추가, 대규모 리팩터링, git commit 없음
diff --git a/src/utils/taskLabels.ts b/src/utils/taskLabels.ts
index 1beb326e6b30ca0a59c582dfef00543eb33f4f67..4c11ca74020845258297cb362dd8dfd25bda5be9
--- a/src/utils/taskLabels.ts
+++ b/src/utils/taskLabels.ts
@@ -14,5 +14,14 @@
 }
 
 export function getStatusLabel(status: Task["status"]) {
-  return status === "done" ? "완료" : "미완료";
+  switch (status) {
+    case "in_progress":
+      return "진행 중";
+    case "done":
+      return "완료";
+    case "todo":
+      return "남은 업무";
+    default:
+      return status;
+  }
 }
diff --git a/src/views/TasksView.tsx b/src/views/TasksView.tsx
index f23e7cd889a557887c26f9e201c00aa5c2de6553..2f3f8557146e85ad61334edd99d79444b0fc0229
--- a/src/views/TasksView.tsx
+++ b/src/views/TasksView.tsx
@@ -94,6 +94,13 @@
   const hasSearchQuery = taskSearchQuery.trim().length > 0;
   const hasProjectFilter = selectedProjectFilter !== "all";
   const hasVisibilityFilter = !showCompletedTasks;
+  const completedTaskCount = filteredTasks.filter(
+    (task) => task.status === "done",
+  ).length;
+  const inProgressTaskCount = filteredTasks.filter(
+    (task) => task.status === "in_progress",
+  ).length;
+  const remainingTaskCount = filteredTasks.length - completedTaskCount;
   const emptyMessage =
     hasSearchQuery
       ? "검색어와 일치하는 업무가 없어요."
@@ -104,7 +111,10 @@
   return (
     <section className="screen-card">
       <h2>전체 업무</h2>
-      <p className="summary">총 {filteredTasks.length}개</p>
+      <p className="summary">
+        총 {filteredTasks.length}개 · 진행 중 {inProgressTaskCount}개 · 완료{" "}
+        {completedTaskCount}개 · 남은 업무 {remainingTaskCount}개
+      </p>
 
       <label>
         업무 검색

codex
수정 파일을 다시 읽어 JSX와 라벨 분기만 점검하겠습니다. 자동 빌드/린트/테스트와 git 상태 확인은 현재 규칙상 실행하지 않습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -Path '
D:\\ai-apps\\planpilot-local\\src\\views\\TasksView.tsx' -Pattern 'completedTaskCount|inProgress
TaskCount|remainingTaskCount|진행 중|남은 업무'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -Path '
D:\\ai-apps\\planpilot-local\\.ai-dev\\loop-log.md' -Pattern 'T002 업무 흐름 상태 표시 개선|진행 중, 완료, 남은 업
무|build/test/lint'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -Path '
D:\\ai-apps\\planpilot-local\\src\\utils\\taskLabels.ts' -Pattern 'in_progress|done|todo|진행 중|완료
|남은 업무'" in D:\ai-apps\planpilot-local
 succeeded in 1700ms:

src\views\TasksView.tsx:97:  const completedTaskCount = filteredTasks.filter(
src\views\TasksView.tsx:100:  const inProgressTaskCount = filteredTasks.filter(
src\views\TasksView.tsx:103:  const remainingTaskCount = filteredTasks.length - completedTaskCou
nt;
src\views\TasksView.tsx:115:        총 {filteredTasks.length}개 · 진행 중 {inProgressTaskCount}개 · 완료
{" "}
src\views\TasksView.tsx:116:        {completedTaskCount}개 · 남은 업무 {remainingTaskCount}개



 succeeded in 1756ms:

.ai-dev\loop-log.md:50:- Verification: PowerShell 문법 검증 예정. 실제 Codex 실행, build/test/lint, git ad
d/commit은 수행하지 않음
.ai-dev\loop-log.md:74:- Excluded: 실제 Codex 실행, build/test/lint, git add/commit은 수행하지 않음
.ai-dev\loop-log.md:102:- Excluded: build/test/lint, 실제 커밋 생성, git 명령 직접 실행은 수행하지 않음
.ai-dev\loop-log.md:238:- Next task: T002 업무 흐름 상태 표시 개선
.ai-dev\loop-log.md:242:- Task: T002 업무 흐름 상태 표시 개선
.ai-dev\loop-log.md:243:- Result: 업무 목록 상단 요약에 진행 중, 완료, 남은 업무 개수를 표시하고 업무 카드 상태 라벨을 todo/in_pro
gress/done 상태별 한국어 문구로 
구분함
.ai-dev\loop-log.md:244:- Verification: build/test/lint는 현재 프롬프트에서 자동 실행 지시가 없어 실행하지 않음



 succeeded in 1752ms:

src\utils\taskLabels.ts:18:    case "in_progress":
src\utils\taskLabels.ts:19:      return "진행 중";
src\utils\taskLabels.ts:20:    case "done":
src\utils\taskLabels.ts:21:      return "완료";
src\utils\taskLabels.ts:22:    case "todo":
src\utils\taskLabels.ts:23:      return "남은 업무";



diff --git a/.ai-dev/loop-log.md b/.ai-dev/loop-log.md
index 2580698a6cddb192c5cfc98ff5239be81b73d3e9..addb38f81cbf4518b9545d8f3c1dccd757b54f21
--- a/.ai-dev/loop-log.md
+++ b/.ai-dev/loop-log.md
@@ -235,4 +235,11 @@
 
 - Task: T001 업무 상태 안내 개선 범위 확인
 - Result: T001 완료: 업무 상태 안내 개선 범위를 확인하고, 앱 변경 없이 TaskList 중심으로 개선 위치를 정리했으며 build/lint 검증 및 리뷰 
pass를 확인함
-- Next task: T002 업무 흐름 상태 표시 개선
\ No newline at end of file
+- Next task: T002 업무 흐름 상태 표시 개선
+
+## 2026-06-19 22:10:34 - Task progress
+
+- Task: T002 업무 흐름 상태 표시 개선
+- Result: 업무 목록 상단 요약에 진행 중, 완료, 남은 업무 개수를 표시하고 업무 카드 상태 라벨을 todo/in_progress/done 상태별 한국어 문구로 
구분함
+- Verification: build/test/lint는 현재 프롬프트에서 자동 실행 지시가 없어 실행하지 않음
+- Excluded: DB schema 변경, 저장 구조 변경, 새 화면 추가, 대규모 리팩터링, git commit 없음
diff --git a/src/utils/taskLabels.ts b/src/utils/taskLabels.ts
index 1beb326e6b30ca0a59c582dfef00543eb33f4f67..4c11ca74020845258297cb362dd8dfd25bda5be9
--- a/src/utils/taskLabels.ts
+++ b/src/utils/taskLabels.ts
@@ -14,5 +14,14 @@
 }
 
 export function getStatusLabel(status: Task["status"]) {
-  return status === "done" ? "완료" : "미완료";
+  switch (status) {
+    case "in_progress":
+      return "진행 중";
+    case "done":
+      return "완료";
+    case "todo":
+      return "남은 업무";
+    default:
+      return status;
+  }
 }
diff --git a/src/views/TasksView.tsx b/src/views/TasksView.tsx
index f23e7cd889a557887c26f9e201c00aa5c2de6553..2f3f8557146e85ad61334edd99d79444b0fc0229
--- a/src/views/TasksView.tsx
+++ b/src/views/TasksView.tsx
@@ -94,6 +94,13 @@
   const hasSearchQuery = taskSearchQuery.trim().length > 0;
   const hasProjectFilter = selectedProjectFilter !== "all";
   const hasVisibilityFilter = !showCompletedTasks;
+  const completedTaskCount = filteredTasks.filter(
+    (task) => task.status === "done",
+  ).length;
+  const inProgressTaskCount = filteredTasks.filter(
+    (task) => task.status === "in_progress",
+  ).length;
+  const remainingTaskCount = filteredTasks.length - completedTaskCount;
   const emptyMessage =
     hasSearchQuery
       ? "검색어와 일치하는 업무가 없어요."
@@ -104,7 +111,10 @@
   return (
     <section className="screen-card">
       <h2>전체 업무</h2>
-      <p className="summary">총 {filteredTasks.length}개</p>
+      <p className="summary">
+        총 {filteredTasks.length}개 · 진행 중 {inProgressTaskCount}개 · 완료{" "}
+        {completedTaskCount}개 · 남은 업무 {remainingTaskCount}개
+      </p>
 
       <label>
         업무 검색

codex
문구 위치와 로그 기록은 의도한 범위에 들어갔습니다. 마지막으로 수정 파일의 핵심 부분만 확인해서 최종 보고에 정확히 반영하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\src\\views\\TasksView.tsx' -Encoding UTF8 | Select-Object -Sk
ip 90 -First 32" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\loop-log.md' -Encoding UTF8 | Select-Object -Last 12
" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\src\\utils\\taskLabels.ts' -Encoding UTF8" in D:\ai-apps\plan
pilot-local
 succeeded in 1791ms:
  onDeleteTask,
  onStartEditTask,
}: TasksViewProps) {
  const hasSearchQuery = taskSearchQuery.trim().length > 0;
  const hasProjectFilter = selectedProjectFilter !== "all";
  const hasVisibilityFilter = !showCompletedTasks;
  const completedTaskCount = filteredTasks.filter(
    (task) => task.status === "done",
  ).length;
  const inProgressTaskCount = filteredTasks.filter(
    (task) => task.status === "in_progress",
  ).length;
  const remainingTaskCount = filteredTasks.length - completedTaskCount;
  const emptyMessage =
    hasSearchQuery
      ? "검색어와 일치하는 업무가 없어요."
      : hasProjectFilter || hasVisibilityFilter
        ? "현재 조건에 맞는 업무가 없어요."
        : "아직 등록된 업무가 없어요.";

  return (
    <section className="screen-card">
      <h2>전체 업무</h2>
      <p className="summary">
        총 {filteredTasks.length}개 · 진행 중 {inProgressTaskCount}개 · 완료{" "}
        {completedTaskCount}개 · 남은 업무 {remainingTaskCount}개
      </p>

      <label>
        업무 검색
        <input
          type="text"

 succeeded in 1724ms:
import type { Task } from "../types";

export function getPriorityLabel(priority: Task["priority"]) {
  switch (priority) {
    case "high":
      return "높음";
    case "medium":
      return "보통";
    case "low":
      return "낮음";
    default:
      return priority;
  }
}

export function getStatusLabel(status: Task["status"]) {
  switch (status) {
    case "in_progress":
      return "진행 중";
    case "done":
      return "완료";
    case "todo":
      return "남은 업무";
    default:
      return status;
  }
}

 succeeded in 1839ms:
## 2026-06-19 22:08:47 - Task completed

- Task: T001 업무 상태 안내 개선 범위 확인
- Result: T001 완료: 업무 상태 안내 개선 범위를 확인하고, 앱 변경 없이 TaskList 중심으로 개선 위치를 정리했으며 build/lint 검증 및 리뷰 p
ass를 확인함
- Next task: T002 업무 흐름 상태 표시 개선

## 2026-06-19 22:10:34 - Task progress

- Task: T002 업무 흐름 상태 표시 개선
- Result: 업무 목록 상단 요약에 진행 중, 완료, 남은 업무 개수를 표시하고 업무 카드 상태 라벨을 todo/in_progress/done 상태별 한국어 문구로 구
분함
- Verification: build/test/lint는 현재 프롬프트에서 자동 실행 지시가 없어 실행하지 않음
- Excluded: DB schema 변경, 저장 구조 변경, 새 화면 추가, 대규모 리팩터링, git commit 없음

diff --git a/.ai-dev/loop-log.md b/.ai-dev/loop-log.md
index 2580698a6cddb192c5cfc98ff5239be81b73d3e9..addb38f81cbf4518b9545d8f3c1dccd757b54f21
--- a/.ai-dev/loop-log.md
+++ b/.ai-dev/loop-log.md
@@ -235,4 +235,11 @@
 
 - Task: T001 업무 상태 안내 개선 범위 확인
 - Result: T001 완료: 업무 상태 안내 개선 범위를 확인하고, 앱 변경 없이 TaskList 중심으로 개선 위치를 정리했으며 build/lint 검증 및 리뷰 
pass를 확인함
-- Next task: T002 업무 흐름 상태 표시 개선
\ No newline at end of file
+- Next task: T002 업무 흐름 상태 표시 개선
+
+## 2026-06-19 22:10:34 - Task progress
+
+- Task: T002 업무 흐름 상태 표시 개선
+- Result: 업무 목록 상단 요약에 진행 중, 완료, 남은 업무 개수를 표시하고 업무 카드 상태 라벨을 todo/in_progress/done 상태별 한국어 문구로 
구분함
+- Verification: build/test/lint는 현재 프롬프트에서 자동 실행 지시가 없어 실행하지 않음
+- Excluded: DB schema 변경, 저장 구조 변경, 새 화면 추가, 대규모 리팩터링, git commit 없음
diff --git a/src/utils/taskLabels.ts b/src/utils/taskLabels.ts
index 1beb326e6b30ca0a59c582dfef00543eb33f4f67..4c11ca74020845258297cb362dd8dfd25bda5be9
--- a/src/utils/taskLabels.ts
+++ b/src/utils/taskLabels.ts
@@ -14,5 +14,14 @@
 }
 
 export function getStatusLabel(status: Task["status"]) {
-  return status === "done" ? "완료" : "미완료";
+  switch (status) {
+    case "in_progress":
+      return "진행 중";
+    case "done":
+      return "완료";
+    case "todo":
+      return "남은 업무";
+    default:
+      return status;
+  }
 }
diff --git a/src/views/TasksView.tsx b/src/views/TasksView.tsx
index f23e7cd889a557887c26f9e201c00aa5c2de6553..2f3f8557146e85ad61334edd99d79444b0fc0229
--- a/src/views/TasksView.tsx
+++ b/src/views/TasksView.tsx
@@ -94,6 +94,13 @@
   const hasSearchQuery = taskSearchQuery.trim().length > 0;
   const hasProjectFilter = selectedProjectFilter !== "all";
   const hasVisibilityFilter = !showCompletedTasks;
+  const completedTaskCount = filteredTasks.filter(
+    (task) => task.status === "done",
+  ).length;
+  const inProgressTaskCount = filteredTasks.filter(
+    (task) => task.status === "in_progress",
+  ).length;
+  const remainingTaskCount = filteredTasks.length - completedTaskCount;
   const emptyMessage =
     hasSearchQuery
       ? "검색어와 일치하는 업무가 없어요."
@@ -104,7 +111,10 @@
   return (
     <section className="screen-card">
       <h2>전체 업무</h2>
-      <p className="summary">총 {filteredTasks.length}개</p>
+      <p className="summary">
+        총 {filteredTasks.length}개 · 진행 중 {inProgressTaskCount}개 · 완료{" "}
+        {completedTaskCount}개 · 남은 업무 {remainingTaskCount}개
+      </p>
 
       <label>
         업무 검색

codex
한 가지 해석을 바로잡겠습니다. 상태 타입이 `todo / in_progress / done`으로 나뉘어 있으므로, 목록 요약의 `남은 업무`는 완료가 아닌 전체가 아니라 
아직 착수 전인 `todo` 개수로 계산하는 편이 더 명확합니다. 이 계산만 조정하겠습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\src\views\TasksView.tsx
diff --git a/.ai-dev/loop-log.md b/.ai-dev/loop-log.md
index 2580698a6cddb192c5cfc98ff5239be81b73d3e9..addb38f81cbf4518b9545d8f3c1dccd757b54f21
--- a/.ai-dev/loop-log.md
+++ b/.ai-dev/loop-log.md
@@ -235,4 +235,11 @@
 
 - Task: T001 업무 상태 안내 개선 범위 확인
 - Result: T001 완료: 업무 상태 안내 개선 범위를 확인하고, 앱 변경 없이 TaskList 중심으로 개선 위치를 정리했으며 build/lint 검증 및 리뷰 
pass를 확인함
-- Next task: T002 업무 흐름 상태 표시 개선
\ No newline at end of file
+- Next task: T002 업무 흐름 상태 표시 개선
+
+## 2026-06-19 22:10:34 - Task progress
+
+- Task: T002 업무 흐름 상태 표시 개선
+- Result: 업무 목록 상단 요약에 진행 중, 완료, 남은 업무 개수를 표시하고 업무 카드 상태 라벨을 todo/in_progress/done 상태별 한국어 문구로 
구분함
+- Verification: build/test/lint는 현재 프롬프트에서 자동 실행 지시가 없어 실행하지 않음
+- Excluded: DB schema 변경, 저장 구조 변경, 새 화면 추가, 대규모 리팩터링, git commit 없음
diff --git a/src/utils/taskLabels.ts b/src/utils/taskLabels.ts
index 1beb326e6b30ca0a59c582dfef00543eb33f4f67..4c11ca74020845258297cb362dd8dfd25bda5be9
--- a/src/utils/taskLabels.ts
+++ b/src/utils/taskLabels.ts
@@ -14,5 +14,14 @@
 }
 
 export function getStatusLabel(status: Task["status"]) {
-  return status === "done" ? "완료" : "미완료";
+  switch (status) {
+    case "in_progress":
+      return "진행 중";
+    case "done":
+      return "완료";
+    case "todo":
+      return "남은 업무";
+    default:
+      return status;
+  }
 }
diff --git a/src/views/TasksView.tsx b/src/views/TasksView.tsx
index f23e7cd889a557887c26f9e201c00aa5c2de6553..2906f8eef2fbf93e78f98d400861c533e017c647
--- a/src/views/TasksView.tsx
+++ b/src/views/TasksView.tsx
@@ -94,6 +94,15 @@
   const hasSearchQuery = taskSearchQuery.trim().length > 0;
   const hasProjectFilter = selectedProjectFilter !== "all";
   const hasVisibilityFilter = !showCompletedTasks;
+  const completedTaskCount = filteredTasks.filter(
+    (task) => task.status === "done",
+  ).length;
+  const inProgressTaskCount = filteredTasks.filter(
+    (task) => task.status === "in_progress",
+  ).length;
+  const remainingTaskCount = filteredTasks.filter(
+    (task) => task.status === "todo",
+  ).length;
   const emptyMessage =
     hasSearchQuery
       ? "검색어와 일치하는 업무가 없어요."
@@ -104,7 +113,10 @@
   return (
     <section className="screen-card">
       <h2>전체 업무</h2>
-      <p className="summary">총 {filteredTasks.length}개</p>
+      <p className="summary">
+        총 {filteredTasks.length}개 · 진행 중 {inProgressTaskCount}개 · 완료{" "}
+        {completedTaskCount}개 · 남은 업무 {remainingTaskCount}개
+      </p>
 
       <label>
         업무 검색

diff --git a/.ai-dev/loop-log.md b/.ai-dev/loop-log.md
index 2580698a6cddb192c5cfc98ff5239be81b73d3e9..addb38f81cbf4518b9545d8f3c1dccd757b54f21
--- a/.ai-dev/loop-log.md
+++ b/.ai-dev/loop-log.md
@@ -235,4 +235,11 @@
 
 - Task: T001 업무 상태 안내 개선 범위 확인
 - Result: T001 완료: 업무 상태 안내 개선 범위를 확인하고, 앱 변경 없이 TaskList 중심으로 개선 위치를 정리했으며 build/lint 검증 및 리뷰 
pass를 확인함
-- Next task: T002 업무 흐름 상태 표시 개선
\ No newline at end of file
+- Next task: T002 업무 흐름 상태 표시 개선
+
+## 2026-06-19 22:10:34 - Task progress
+
+- Task: T002 업무 흐름 상태 표시 개선
+- Result: 업무 목록 상단 요약에 진행 중, 완료, 남은 업무 개수를 표시하고 업무 카드 상태 라벨을 todo/in_progress/done 상태별 한국어 문구로 
구분함
+- Verification: build/test/lint는 현재 프롬프트에서 자동 실행 지시가 없어 실행하지 않음
+- Excluded: DB schema 변경, 저장 구조 변경, 새 화면 추가, 대규모 리팩터링, git commit 없음
diff --git a/src/utils/taskLabels.ts b/src/utils/taskLabels.ts
index 1beb326e6b30ca0a59c582dfef00543eb33f4f67..4c11ca74020845258297cb362dd8dfd25bda5be9
--- a/src/utils/taskLabels.ts
+++ b/src/utils/taskLabels.ts
@@ -14,5 +14,14 @@
 }
 
 export function getStatusLabel(status: Task["status"]) {
-  return status === "done" ? "완료" : "미완료";
+  switch (status) {
+    case "in_progress":
+      return "진행 중";
+    case "done":
+      return "완료";
+    case "todo":
+      return "남은 업무";
+    default:
+      return status;
+  }
 }
diff --git a/src/views/TasksView.tsx b/src/views/TasksView.tsx
index f23e7cd889a557887c26f9e201c00aa5c2de6553..2906f8eef2fbf93e78f98d400861c533e017c647
--- a/src/views/TasksView.tsx
+++ b/src/views/TasksView.tsx
@@ -94,6 +94,15 @@
   const hasSearchQuery = taskSearchQuery.trim().length > 0;
   const hasProjectFilter = selectedProjectFilter !== "all";
   const hasVisibilityFilter = !showCompletedTasks;
+  const completedTaskCount = filteredTasks.filter(
+    (task) => task.status === "done",
+  ).length;
+  const inProgressTaskCount = filteredTasks.filter(
+    (task) => task.status === "in_progress",
+  ).length;
+  const remainingTaskCount = filteredTasks.filter(
+    (task) => task.status === "todo",
+  ).length;
   const emptyMessage =
     hasSearchQuery
       ? "검색어와 일치하는 업무가 없어요."
@@ -104,7 +113,10 @@
   return (
     <section className="screen-card">
       <h2>전체 업무</h2>
-      <p className="summary">총 {filteredTasks.length}개</p>
+      <p className="summary">
+        총 {filteredTasks.length}개 · 진행 중 {inProgressTaskCount}개 · 완료{" "}
+        {completedTaskCount}개 · 남은 업무 {remainingTaskCount}개
+      </p>
 
       <label>
         업무 검색

codex
계산 기준을 상태 enum과 맞췄습니다. 이제 `진행 중`, `완료`, `남은 업무`가 각각 `in_progress`, `done`, `todo`를 의미합니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\src\\views\\TasksView.tsx' -Encoding UTF8 | Select-Object -Sk
ip 94 -First 24" in D:\ai-apps\planpilot-local
 succeeded in 1175ms:
  const hasProjectFilter = selectedProjectFilter !== "all";
  const hasVisibilityFilter = !showCompletedTasks;
  const completedTaskCount = filteredTasks.filter(
    (task) => task.status === "done",
  ).length;
  const inProgressTaskCount = filteredTasks.filter(
    (task) => task.status === "in_progress",
  ).length;
  const remainingTaskCount = filteredTasks.filter(
    (task) => task.status === "todo",
  ).length;
  const emptyMessage =
    hasSearchQuery
      ? "검색어와 일치하는 업무가 없어요."
      : hasProjectFilter || hasVisibilityFilter
        ? "현재 조건에 맞는 업무가 없어요."
        : "아직 등록된 업무가 없어요.";

  return (
    <section className="screen-card">
      <h2>전체 업무</h2>
      <p className="summary">
        총 {filteredTasks.length}개 · 진행 중 {inProgressTaskCount}개 · 완료{" "}
        {completedTaskCount}개 · 남은 업무 {remainingTaskCount}개

diff --git a/.ai-dev/loop-log.md b/.ai-dev/loop-log.md
index 2580698a6cddb192c5cfc98ff5239be81b73d3e9..addb38f81cbf4518b9545d8f3c1dccd757b54f21
--- a/.ai-dev/loop-log.md
+++ b/.ai-dev/loop-log.md
@@ -235,4 +235,11 @@
 
 - Task: T001 업무 상태 안내 개선 범위 확인
 - Result: T001 완료: 업무 상태 안내 개선 범위를 확인하고, 앱 변경 없이 TaskList 중심으로 개선 위치를 정리했으며 build/lint 검증 및 리뷰 
pass를 확인함
-- Next task: T002 업무 흐름 상태 표시 개선
\ No newline at end of file
+- Next task: T002 업무 흐름 상태 표시 개선
+
+## 2026-06-19 22:10:34 - Task progress
+
+- Task: T002 업무 흐름 상태 표시 개선
+- Result: 업무 목록 상단 요약에 진행 중, 완료, 남은 업무 개수를 표시하고 업무 카드 상태 라벨을 todo/in_progress/done 상태별 한국어 문구로 
구분함
+- Verification: build/test/lint는 현재 프롬프트에서 자동 실행 지시가 없어 실행하지 않음
+- Excluded: DB schema 변경, 저장 구조 변경, 새 화면 추가, 대규모 리팩터링, git commit 없음
diff --git a/src/utils/taskLabels.ts b/src/utils/taskLabels.ts
index 1beb326e6b30ca0a59c582dfef00543eb33f4f67..4c11ca74020845258297cb362dd8dfd25bda5be9
--- a/src/utils/taskLabels.ts
+++ b/src/utils/taskLabels.ts
@@ -14,5 +14,14 @@
 }
 
 export function getStatusLabel(status: Task["status"]) {
-  return status === "done" ? "완료" : "미완료";
+  switch (status) {
+    case "in_progress":
+      return "진행 중";
+    case "done":
+      return "완료";
+    case "todo":
+      return "남은 업무";
+    default:
+      return status;
+  }
 }
diff --git a/src/views/TasksView.tsx b/src/views/TasksView.tsx
index f23e7cd889a557887c26f9e201c00aa5c2de6553..2906f8eef2fbf93e78f98d400861c533e017c647
--- a/src/views/TasksView.tsx
+++ b/src/views/TasksView.tsx
@@ -94,6 +94,15 @@
   const hasSearchQuery = taskSearchQuery.trim().length > 0;
   const hasProjectFilter = selectedProjectFilter !== "all";
   const hasVisibilityFilter = !showCompletedTasks;
+  const completedTaskCount = filteredTasks.filter(
+    (task) => task.status === "done",
+  ).length;
+  const inProgressTaskCount = filteredTasks.filter(
+    (task) => task.status === "in_progress",
+  ).length;
+  const remainingTaskCount = filteredTasks.filter(
+    (task) => task.status === "todo",
+  ).length;
   const emptyMessage =
     hasSearchQuery
       ? "검색어와 일치하는 업무가 없어요."
@@ -104,7 +113,10 @@
   return (
     <section className="screen-card">
       <h2>전체 업무</h2>
-      <p className="summary">총 {filteredTasks.length}개</p>
+      <p className="summary">
+        총 {filteredTasks.length}개 · 진행 중 {inProgressTaskCount}개 · 완료{" "}
+        {completedTaskCount}개 · 남은 업무 {remainingTaskCount}개
+      </p>
 
       <label>
         업무 검색

codex
구현 완료했습니다.

**변경 파일**
- [TasksView.tsx](D:/ai-apps/planpilot-local/src/views/TasksView.tsx:97)
- [taskLabels.ts](D:/ai-apps/planpilot-local/src/utils/taskLabels.ts:16)
- [loop-log.md](D:/ai-apps/planpilot-local/.ai-dev/loop-log.md:240)

**요약**
- 업무 목록 상단 요약을 `총 n개 · 진행 중 n개 · 완료 n개 · 남은 업무 n개`로 개선했습니다.
- 상태 라벨을 `todo = 남은 업무`, `in_progress = 진행 중`, `done = 완료`로 구분했습니다.
- DB schema, 저장 구조, 서버/API, 새 화면 추가는 건드리지 않았습니다.
- `.ai-dev/loop-log.md`에 T002 작업 진행 기록을 남겼습니다.

**검증**
- 수정 파일을 다시 읽어 JSX 구조와 상태 계산 기준을 확인했습니다.
- `npm run build`, `npm run lint`, `npm run test`는 현재 프롬프트에서 자동 실행 지시가 없어 실행하지 않았습니다.
- git 명령은 프로젝트 규칙상 커밋 요청이 없으면 실행할 수 없어 최종 dirty 상태 확인은 하지 않았습니다.

**남은 위험**
- 실제 화면 렌더링과 빌드 검증은 사람이 별도로 실행해야 합니다.
- 공식 리뷰 pass는 아직 기록하지 않았습니다.

**다음 task 여부**
- 구현 자체는 T002 범위 안에서 완료됐지만, 다음 task로 넘어가려면 build/lint 또는 리뷰 pass 기록이 추가로 필요합니다.

**loop-log 기록 요약**
- “업무 목록 상단 요약에 진행 중, 완료, 남은 업무 개수를 표시하고 업무 카드 상태 라벨을 상태별 한국어 문구로 구분함”으로 기록했습니다.
diff --git a/.ai-dev/loop-log.md b/.ai-dev/loop-log.md
index 2580698a6cddb192c5cfc98ff5239be81b73d3e9..addb38f81cbf4518b9545d8f3c1dccd757b54f21
--- a/.ai-dev/loop-log.md
+++ b/.ai-dev/loop-log.md
@@ -235,4 +235,11 @@
 
 - Task: T001 업무 상태 안내 개선 범위 확인
 - Result: T001 완료: 업무 상태 안내 개선 범위를 확인하고, 앱 변경 없이 TaskList 중심으로 개선 위치를 정리했으며 build/lint 검증 및 리뷰 
pass를 확인함
-- Next task: T002 업무 흐름 상태 표시 개선
\ No newline at end of file
+- Next task: T002 업무 흐름 상태 표시 개선
+
+## 2026-06-19 22:10:34 - Task progress
+
+- Task: T002 업무 흐름 상태 표시 개선
+- Result: 업무 목록 상단 요약에 진행 중, 완료, 남은 업무 개수를 표시하고 업무 카드 상태 라벨을 todo/in_progress/done 상태별 한국어 문구로 
구분함
+- Verification: build/test/lint는 현재 프롬프트에서 자동 실행 지시가 없어 실행하지 않음
+- Excluded: DB schema 변경, 저장 구조 변경, 새 화면 추가, 대규모 리팩터링, git commit 없음
diff --git a/src/utils/taskLabels.ts b/src/utils/taskLabels.ts
index 1beb326e6b30ca0a59c582dfef00543eb33f4f67..4c11ca74020845258297cb362dd8dfd25bda5be9
--- a/src/utils/taskLabels.ts
+++ b/src/utils/taskLabels.ts
@@ -14,5 +14,14 @@
 }
 
 export function getStatusLabel(status: Task["status"]) {
-  return status === "done" ? "완료" : "미완료";
+  switch (status) {
+    case "in_progress":
+      return "진행 중";
+    case "done":
+      return "완료";
+    case "todo":
+      return "남은 업무";
+    default:
+      return status;
+  }
 }
diff --git a/src/views/TasksView.tsx b/src/views/TasksView.tsx
index f23e7cd889a557887c26f9e201c00aa5c2de6553..2906f8eef2fbf93e78f98d400861c533e017c647
--- a/src/views/TasksView.tsx
+++ b/src/views/TasksView.tsx
@@ -94,6 +94,15 @@
   const hasSearchQuery = taskSearchQuery.trim().length > 0;
   const hasProjectFilter = selectedProjectFilter !== "all";
   const hasVisibilityFilter = !showCompletedTasks;
+  const completedTaskCount = filteredTasks.filter(
+    (task) => task.status === "done",
+  ).length;
+  const inProgressTaskCount = filteredTasks.filter(
+    (task) => task.status === "in_progress",
+  ).length;
+  const remainingTaskCount = filteredTasks.filter(
+    (task) => task.status === "todo",
+  ).length;
   const emptyMessage =
     hasSearchQuery
       ? "검색어와 일치하는 업무가 없어요."
@@ -104,7 +113,10 @@
   return (
     <section className="screen-card">
       <h2>전체 업무</h2>
-      <p className="summary">총 {filteredTasks.length}개</p>
+      <p className="summary">
+        총 {filteredTasks.length}개 · 진행 중 {inProgressTaskCount}개 · 완료{" "}
+        {completedTaskCount}개 · 남은 업무 {remainingTaskCount}개
+      </p>
 
       <label>
         업무 검색

tokens used
42,440
구현 완료했습니다.

**변경 파일**
- [TasksView.tsx](D:/ai-apps/planpilot-local/src/views/TasksView.tsx:97)
- [taskLabels.ts](D:/ai-apps/planpilot-local/src/utils/taskLabels.ts:16)
- [loop-log.md](D:/ai-apps/planpilot-local/.ai-dev/loop-log.md:240)

**요약**
- 업무 목록 상단 요약을 `총 n개 · 진행 중 n개 · 완료 n개 · 남은 업무 n개`로 개선했습니다.
- 상태 라벨을 `todo = 남은 업무`, `in_progress = 진행 중`, `done = 완료`로 구분했습니다.
- DB schema, 저장 구조, 서버/API, 새 화면 추가는 건드리지 않았습니다.
- `.ai-dev/loop-log.md`에 T002 작업 진행 기록을 남겼습니다.

**검증**
- 수정 파일을 다시 읽어 JSX 구조와 상태 계산 기준을 확인했습니다.
- `npm run build`, `npm run lint`, `npm run test`는 현재 프롬프트에서 자동 실행 지시가 없어 실행하지 않았습니다.
- git 명령은 프로젝트 규칙상 커밋 요청이 없으면 실행할 수 없어 최종 dirty 상태 확인은 하지 않았습니다.

**남은 위험**
- 실제 화면 렌더링과 빌드 검증은 사람이 별도로 실행해야 합니다.
- 공식 리뷰 pass는 아직 기록하지 않았습니다.

**다음 task 여부**
- 구현 자체는 T002 범위 안에서 완료됐지만, 다음 task로 넘어가려면 build/lint 또는 리뷰 pass 기록이 추가로 필요합니다.

**loop-log 기록 요약**
- “업무 목록 상단 요약에 진행 중, 완료, 남은 업무 개수를 표시하고 업무 카드 상태 라벨을 상태별 한국어 문구로 구분함”으로 기록했습니다.

```