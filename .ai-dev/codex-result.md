# Codex Implementation Result

## Run

- Started at: 2026-07-21 15:30:05
- Ended at: 2026-07-21 15:32:28
- Exit code: 0
- Prompt: .ai-dev/current-task-prompt.md
- Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty

## Output

```text
node.exe : OpenAI Codex v0.133.0
At C:\Users\SECUI\AppData\Roaming\npm\codex.ps1:24 char:5
+     & "node$exe"  "$basedir/node_modules/@openai/codex/bin/codex.js"  ...
+     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (OpenAI Codex v0.133.0:String) 
    [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 
--------
workdir: D:\ai-apps\planpilot-local
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: medium
reasoning summaries: none
session id: 019f835e-0ad3-7bb1-9620-7a4686fac562
--------
user
Read and follow the full task prompt at this absolute file path: D:\ai-apps
\planpilot-local\.ai-dev\current-task-prompt.md

Additional safety rules for this local AI Dev Loop run:
- Do not run git commit, git reset, git checkout, git clean, git rebase, gi
t merge, or git push.
- Do not run npm install.
- Do not modify package.json, package-lock.json, node_modules, dist, or .gi
t.
- Do not broaden the current task scope beyond the prompt file.
- If the task requirements conflict with repository rules, stop and report 
the conflict.
codex
작업 프롬프트를 먼저 읽고, 범위와 충돌 여부를 확인하겠습니다. 지정된 파일만 읽는 단계입니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath .ai-dev\\current-task-prompt.md" in D:\ai-apps\pla
npilot-local
 succeeded in 1757ms:
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
병렬 task 실행 가능성 검토

## 배경
현재 PlanPilot Local의 task 처리 구조에서 여러 task를 동시에 진행하거나 표시할 수 있는지 확인하고, 실제 구현 전
에 필요한 변경 범위와 위험 요소를 작게 정리한다.

## 성공 기준
- 현재 task 데이터 구조와 화면 흐름에서 병렬 task 개념을 수용할 수 있는 지점을 확인한다.
- 병렬 task 실행을 위해 변경이 필요한 파일과 상태 흐름을 최소 범위로 정리한다.
- 즉시 구현 가능한 작은 후속 작업과 보류해야 할 항목을 구분한다.

## 제약사항
- 기존 사용자 데이터를 깨뜨리지 않는다.
- 기존 타입, store 액션, DB 구조를 우선 확인한다.
- 한 번에 하나의 기능만 다룬다.
- 큰 구조 변경이 필요하면 구현보다 검토 결과 정리를 우선한다.

## 범위 제외
- 실제 병렬 실행 UI 구현은 제외한다.
- 데이터 구조 변경은 제외한다.
- 알림 기능 추가는 제외한다.
- 대규모 화면 재구성은 제외한다.

## 수동 검증
- 관련 task 타입과 상태 흐름을 읽고 병렬 task 요구사항과 충돌하는 부분이 있는지 확인한다.
- 검토 결과가 작은 후속 구현 작업으로 이어질 만큼 구체적인지 확인한다.

## Current Task

- Task ID: T001
- Title: 현재 task 흐름 검토
- Description: task 타입, store 상태, 화면 렌더링 흐름을 확인해 병렬 task 개념을 적용할 수 있는지 검토한다
.
- Type: analysis
- Status: in_progress
- Priority: P2
- Depends on:
- 없음

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

- 없음

## Verification

- task 관련 타입과 상태 관리 위치를 확인한다.
- 병렬 task 적용 시 필요한 최소 변경 범위를 메모한다.

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
프롬프트상 이번 작업은 구현이 아니라 분석입니다. 이제 `src` 안에서 task 타입, store, 화면 렌더링 흐름이 어디에 있는지
 좁혀서 읽겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '
rg -n "Task|task|tasks|TaskStatus|status" src' in D:\ai-apps\planpilot-loca
l
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '
rg --files src' in D:\ai-apps\planpilot-local
 succeeded in 3508ms:
src\types.ts
src\store.ts
src\App.tsx
src\App.css
src\main.tsx
src\index.css
src\db.ts
src\views\TodayView.tsx
src\views\TasksView.tsx
src\views\SettingsView.tsx
src\views\ProjectsView.tsx
src\ai\RuleBasedAIProvider.ts
src\ai\recommendationScore.ts
src\ai\AIProvider.ts
src\utils\exportData.ts
src\utils\dateUtils.ts
src\utils\importValidation.ts
src\utils\projectDeletion.ts
src\utils\taskSummary.ts
src\utils\taskLabels.ts
src\utils\taskFilters.ts
src\utils\taskDates.ts
src\utils\projectStats.ts
src\utils\projectLookup.ts
src\components\TaskForm.tsx
src\components\TaskCard.tsx
src\components\ProjectForm.tsx
src\components\ProjectCard.tsx
src\assets\react.svg
src\assets\hero.png
src\assets\vite.svg
src\hooks\useTaskFormState.ts
src\hooks\useTaskActions.ts
src\hooks\useProjectFormState.ts
src\hooks\useProjectActions.ts

 succeeded in 3861ms:
src\App.css:110:.task-list {
src\App.css:119:.task-card {
src\App.css:130:.task-card strong {
src\App.css:135:.task-card span {
src\App.css:141:form.task-card,
src\App.css:142:.task-card form {
src\App.css:204:.task-card button + button,
src\App.css:205:.task-card form button + button {
src\App.css:209:.task-card button[type="button"] {
src\App.css:215:.task-card button[type="button"]:hover {
src\App.css:219:.task-card button[type="button"]:last-child {
src\App.css:223:.task-card button[disabled] {
src\App.css:291:  .task-card {
src\ai\AIProvider.ts:3:import type { Task } from "../types";
src\ai\AIProvider.ts:6:  suggestTodayTasks(tasks: Task[], limit?: number): 
Promise<Task[]>;
src\ai\AIProvider.ts:7:  findOverdueTasks(tasks: Task[]): Promise<Task[]>;
src\ai\AIProvider.ts:8:  findUpcomingTasks(tasks: Task[], days?: number): P
romise<Task[]>;
src\ai\AIProvider.ts:9:  summarizeTasks(tasks: Task[]): Promise<string>;
src\ai\recommendationScore.ts:1:import type { Task } from "../types";
src\ai\recommendationScore.ts:4:export function priorityScore(priority: Tas
k["priority"]): number {
src\ai\recommendationScore.ts:17:export function getTaskScore(task: Task): 
number {
src\ai\recommendationScore.ts:19:  const dueDate = parseDueDate(task.dueDat
e);
src\ai\recommendationScore.ts:27:  return priorityScore(task.priority) + du
eDateScore;
src\ai\recommendationScore.ts:30:export function compareRecommendedTasks(a:
 Task, b: Task): number {
src\ai\recommendationScore.ts:31:  const scoreA = getTaskScore(a);
src\ai\recommendationScore.ts:32:  const scoreB = getTaskScore(b);
src\App.tsx:5:import { useTaskActions } from "./hooks/useTaskActions";
src\App.tsx:6:import { useTaskFormState } from "./hooks/useTaskFormState";
src\App.tsx:10:import { getOverdueTasks, getUpcomingTasks } from "./utils/t
askDates";
src\App.tsx:11:import { filterTasks, sortTasks, type TaskSortOrder } from "
./utils/taskFilters";
src\App.tsx:12:import { getTaskSummary } from "./utils/taskSummary";
src\App.tsx:14:import { TasksView } from "./views/TasksView";
src\App.tsx:17:import type { Task } from "./types";
src\App.tsx:20:type Tab = "today" | "tasks" | "projects" | "settings";
src\App.tsx:24:  const [recommendedTasks, setRecommendedTasks] = useState<T
ask[]>([]);
src\App.tsx:26:  const [showCompletedTasks, setShowCompletedTasks] = useSta
te(true);
src\App.tsx:27:  const [taskSortOrder, setTaskSortOrder] = useState<TaskSor
tOrder>("none");
src\App.tsx:28:  const [taskSearchQuery, setTaskSearchQuery] = useState("")
;
src\App.tsx:30:  const { tasks, projects, appSettings, initializeApp, addTa
sk, updateTask, deleteTask, deleteProject, addProject, updateProject } = us
eStore();
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
src\App.tsx:60:  const { handleAddTask, handleSaveEditTask, handleToggleTas
kDone, handleDeleteTask } = useTaskActions({
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
src\App.tsx:119:  const summaryTasks = filterTasks(tasks, {
src\App.tsx:121:    showCompletedTasks: true,
src\App.tsx:122:    taskSearchQuery,
src\App.tsx:126:  const sortedTasks = sortTasks(filteredTasks, taskSortOrde
r);
src\App.tsx:135:    void aiProvider.suggestTodayTasks(tasks, 3).then(setRec
ommendedTasks);
src\App.tsx:136:  }, [aiProvider, tasks]);
src\App.tsx:149:    totalTasks={taskSummary.totalTasks}
src\App.tsx:150:    completedTasks={taskSummary.completedTasks}
src\App.tsx:151:    recommendedTasks={recommendedTasks}
src\App.tsx:152:    overdueTasks={overdueTasks}
src\App.tsx:153:    upcomingTasks={upcomingTasks}
src\App.tsx:158:        {activeTab === "tasks" && (
src\App.tsx:159:          <TasksView
src\App.tsx:161:            filteredTasks={filteredTasks}
src\App.tsx:162:            summaryTasks={summaryTasks}
src\App.tsx:163:            sortedTasks={sortedTasks}
src\App.tsx:165:            showCompletedTasks={showCompletedTasks}
src\App.tsx:166:            taskSortOrder={taskSortOrder}
src\App.tsx:167:            taskSearchQuery={taskSearchQuery}
src\App.tsx:168:            isTaskFormOpen={isTaskFormOpen}
src\App.tsx:169:            newTaskTitle={newTaskTitle}
src\App.tsx:170:            newTaskMemo={newTaskMemo}
src\App.tsx:171:            newTaskDueDate={newTaskDueDate}
src\App.tsx:172:            newTaskPriority={newTaskPriority}
src\App.tsx:173:            newTaskProjectId={newTaskProjectId}
src\App.tsx:174:            editingTaskId={editingTaskId}
src\App.tsx:175:            editTaskTitle={editTaskTitle}
src\App.tsx:176:            editTaskMemo={editTaskMemo}
src\App.tsx:177:            editTaskDueDate={editTaskDueDate}
src\App.tsx:178:            editTaskPriority={editTaskPriority}
src\App.tsx:179:            editTaskProjectId={editTaskProjectId}
src\App.tsx:181:            onTaskSearchQueryChange={setTaskSearchQuery}
src\App.tsx:182:            onShowCompletedTasksChange={setShowCompletedTas
ks}
src\App.tsx:183:            onTaskSortOrderChange={setTaskSortOrder}
src\App.tsx:185:            onTaskFormOpenChange={setIsTaskFormOpen}
src\App.tsx:186:            onNewTaskTitleChange={setNewTaskTitle}
src\App.tsx:187:            onNewTaskMemoChange={setNewTaskMemo}
src\App.tsx:188:            onNewTaskDueDateChange={setNewTaskDueDate}
src\App.tsx:189:            onNewTaskPriorityChange={setNewTaskPriority}
src\App.tsx:190:            onNewTaskProjectIdChange={setNewTaskProjectId}
src\App.tsx:191:            onEditTaskTitleChange={setEditTaskTitle}
src\App.tsx:192:            onEditTaskMemoChange={setEditTaskMemo}
src\App.tsx:193:            onEditTaskDueDateChange={setEditTaskDueDate}
src\App.tsx:194:            onEditTaskPriorityChange={setEditTaskPriority}
src\App.tsx:195:            onEditTaskProjectIdChange={setEditTaskProjectId
}
src\App.tsx:196:            onAddTask={handleAddTask}
src\App.tsx:197:            onSaveEditTask={handleSaveEditTask}
src\App.tsx:198:            onCancelEditTask={resetEditTaskForm}
src\App.tsx:199:            onToggleTaskDone={handleToggleTaskDone}
src\App.tsx:200:            onDeleteTask={handleDeleteTask}
src\App.tsx:201:            onStartEditTask={startEditTask}
src\App.tsx:208:            tasks={tasks}
src\App.tsx:229:            tasks={tasks}
src\App.tsx:243:          className={activeTab === "tasks" ? "active" : ""}
src\App.tsx:244:          onClick={() => setActiveTab("tasks")}
src\ai\RuleBasedAIProvider.ts:4:import type { Task } from "../types";
src\ai\RuleBasedAIProvider.ts:5:import { compareRecommendedTasks } from "./
recommendationScore";
src\ai\RuleBasedAIProvider.ts:7:  isOverdueTask,
src\ai\RuleBasedAIProvider.ts:8:  isUpcomingTask,
src\ai\RuleBasedAIProvider.ts:13:  async suggestTodayTasks(tasks: Task[], l
imit = 3): Promise<Task[]> {
src\ai\RuleBasedAIProvider.ts:14:    const filteredTasks = tasks
src\ai\RuleBasedAIProvider.ts:15:      .filter(task => task.status !== "don
e")
src\ai\RuleBasedAIProvider.ts:16:      .sort(compareRecommendedTasks);
src\ai\RuleBasedAIProvider.ts:18:    return filteredTasks.slice(0, limit);
src\ai\RuleBasedAIProvider.ts:21:  async findOverdueTasks(tasks: Task[]): P
romise<Task[]> {
src\ai\RuleBasedAIProvider.ts:23:    return tasks.filter((task) => isOverdu
eTask(task, today));
src\ai\RuleBasedAIProvider.ts:26:  async findUpcomingTasks(tasks: Task[], d
ays = 7): Promise<Task[]> {
src\ai\RuleBasedAIProvider.ts:28:    return tasks.filter((task) => isUpcomi
ngTask(task, today, days));
src\ai\RuleBasedAIProvider.ts:31:  async summarizeTasks(tasks: Task[]): Pro
mise<string> {
src\ai\RuleBasedAIProvider.ts:32:    const totalTasks = tasks.length;
src\ai\RuleBasedAIProvider.ts:33:    const completedTasks = tasks.filter(ta
sk => task.status === "done").length;
src\ai\RuleBasedAIProvider.ts:34:    const incompleteTasks = totalTasks - c
ompletedTasks;
src\ai\RuleBasedAIProvider.ts:35:    const overdueTasks = await this.findOv
erdueTasks(tasks);
src\ai\RuleBasedAIProvider.ts:36:    const upcomingTasks = await this.findU
pcomingTasks(tasks, 7);
src\ai\RuleBasedAIProvider.ts:38:    return `총 업무 수: ${totalTasks}, 완료 업무 수
: ${completedTasks}, 미완료 업무 수: ${incompleteTasks}, 지난 마감 업무 수: ${overdueTas
ks.length}, 7일 이내 마감 업무 수: ${upcomingTasks.length}`;
src\components\ProjectCard.tsx:4:type ProjectTaskStats = {
src\components\ProjectCard.tsx:5:  totalTasks: number;
src\components\ProjectCard.tsx:6:  completedTasks: number;
src\components\ProjectCard.tsx:7:  incompleteTasks: number;
src\components\ProjectCard.tsx:12:  stats: ProjectTaskStats;
src\components\ProjectCard.tsx:26:    <li className="task-card">
src\components\ProjectCard.tsx:30:        전체 업무: {stats.totalTasks}개<br />
src\components\ProjectCard.tsx:31:        완료: {stats.completedTasks}개<br />
src\components\ProjectCard.tsx:32:        미완료: {stats.incompleteTasks}개
src\components\ProjectCard.tsx:39:        {deleteBlockReason === "default-p
roject" ? "기본 프로젝트" : deleteBlockReason === "has-tasks" ? "업무 있음" : "삭제"}
src\db.ts:5:import type { Task, Project, StoredAppSettings } from "./types"
;
src\db.ts:8:  tasks!: Table<Task, string>;
src\db.ts:15:      tasks: "id,projectId,status,sortOrder",
src\components\ProjectForm.tsx:26:  className = "task-card",
src\hooks\useProjectActions.ts:2:import type { Project, Task } from "../typ
es";
src\hooks\useProjectActions.ts:13:  tasks: Task[];
src\hooks\useProjectActions.ts:29:  tasks,
src\hooks\useProjectActions.ts:67:    if (getProjectDeleteBlockReason(proje
ct, tasks)) return;
src\components\TaskCard.tsx:1:import { getPriorityLabel, getStatusLabel } f
rom "../utils/taskLabels";
src\components\TaskCard.tsx:2:import { isUpcomingTask } from "../utils/date
Utils";
src\components\TaskCard.tsx:3:import type { Task } from "../types";
src\components\TaskCard.tsx:5:type TaskCardProps = {
src\components\TaskCard.tsx:6:  task: Task;
src\components\TaskCard.tsx:8:  onToggleDone: (task: Task) => void;
src\components\TaskCard.tsx:9:  onDelete: (task: Task) => void;
src\components\TaskCard.tsx:10:  onStartEdit: (task: Task) => void;
src\components\TaskCard.tsx:13:export function TaskCard({
src\components\TaskCard.tsx:14:  task,
src\components\TaskCard.tsx:19:}: TaskCardProps) {
src\components\TaskCard.tsx:20:  const showDueSoonBadge = isUpcomingTask(ta
sk);
src\components\TaskCard.tsx:23:    <li className="task-card">
src\components\TaskCard.tsx:24:      <strong>{task.title}</strong>
src\components\TaskCard.tsx:41:      {task.memo && <span>메모: {task.memo}</s
pan>}
src\components\TaskCard.tsx:43:        중요도: {getPriorityLabel(task.priority
)} · 상태: {getStatusLabel(task.status)} · 프로젝트: {projectName}
src\components\TaskCard.tsx:45:      <span>{task.dueDate ? `마감일: ${task.due
Date}` : "마감일 없음"}</span>
src\components\TaskCard.tsx:49:          task.status === "done"
src\components\TaskCard.tsx:50:            ? `'${task.title}' 업무를 미완료로 되돌리기
`
src\components\TaskCard.tsx:51:            : `'${task.title}' 업무를 완료로 표시하기`
src\components\TaskCard.tsx:53:        onClick={() => onToggleDone(task)}
src\components\TaskCard.tsx:55:        {task.status === "done" ? "미완료로 되돌리기
" : "업무 완료로 표시"}
src\components\TaskCard.tsx:59:        aria-label={`'${task.title}' 업무 삭제하기
`}
src\components\TaskCard.tsx:60:        onClick={() => onDelete(task)}
src\components\TaskCard.tsx:66:        aria-label={`'${task.title}' 업무 수정하기
`}
src\components\TaskCard.tsx:67:        onClick={() => onStartEdit(task)}
src\components\TaskForm.tsx:2:import type { Project, Task } from "../types"
;
src\components\TaskForm.tsx:4:type TaskFormProps = {
src\components\TaskForm.tsx:7:  taskTitle: string;
src\components\TaskForm.tsx:10:  priority: Task["priority"];
src\components\TaskForm.tsx:17:  onPriorityChange: (value: Task["priority"]
) => void;
src\components\TaskForm.tsx:24:export function TaskForm({
src\components\TaskForm.tsx:27:  taskTitle,
src\components\TaskForm.tsx:41:  className = "task-card",
src\components\TaskForm.tsx:42:}: TaskFormProps) {
src\components\TaskForm.tsx:51:          value={taskTitle}
src\components\TaskForm.tsx:82:          onChange={(event) => onPriorityCha
nge(event.target.value as Task["priority"])}
src\store.ts:5:import type { Task, Project, AppSettings } from "./types";
src\store.ts:16:  tasks: Task[];
src\store.ts:23:  fetchTasks: () => Promise<void>;
src\store.ts:26:  addTask: (input: CreateTaskInput) => Promise<void>;
src\store.ts:27:  updateTask: (task: Task) => Promise<void>;
src\store.ts:28:  deleteTask: (taskId: string) => Promise<void>;
src\store.ts:35:type CreateTaskInput = {
src\store.ts:39:  priority?: Task["priority"];
src\store.ts:40:  status?: Task["status"];
src\store.ts:54:  tasks: [],
src\store.ts:73:    await get().fetchTasks();
src\store.ts:77:  fetchTasks: async () => {
src\store.ts:78:    const tasks = await db.tasks.toArray();
src\store.ts:79:    set({ tasks });
src\store.ts:100:  addTask: async (input) => {
src\store.ts:103:    const task: Task = {
src\store.ts:107:      status: input.status ?? "todo",
src\store.ts:114:    if (input.memo) task.memo = input.memo;
src\store.ts:115:    if (input.dueDate) task.dueDate = input.dueDate;
src\store.ts:116:    if (input.estimatedMinutes !== undefined) task.estimat
edMinutes = input.estimatedMinutes;
src\store.ts:117:    if (input.sortOrder !== undefined) task.sortOrder = in
put.sortOrder;
src\store.ts:119:    await db.tasks.add(task);
src\store.ts:120:    set((state) => ({ tasks: [...state.tasks, task] }));
src\store.ts:122:  updateTask: async (task) => {
src\store.ts:123:    const updatedTask: Task = {
src\store.ts:124:      ...task,
src\store.ts:128:    if (updatedTask.status === "done") {
src\store.ts:129:      updatedTask.completedAt = updatedTask.completedAt ||
 new Date().toISOString();
src\store.ts:131:      delete updatedTask.completedAt;
src\store.ts:134:    await db.tasks.put(updatedTask);
src\store.ts:136:      tasks: state.tasks.map((t) => (t.id === task.id ? up
datedTask : t)),
src\store.ts:139:  deleteTask: async (taskId) => {
src\store.ts:140:    await db.tasks.delete(taskId);
src\store.ts:141:    set((state) => ({ tasks: state.tasks.filter((t) => t.i
d !== taskId) }));
src\hooks\useTaskActions.ts:2:import type { Task } from "../types";
src\hooks\useTaskActions.ts:4:type TaskActionStore = {
src\hooks\useTaskActions.ts:5:  addTask: (input: {
src\hooks\useTaskActions.ts:9:    priority: Task["priority"];
src\hooks\useTaskActions.ts:12:  updateTask: (task: Task) => Promise<void>;
src\hooks\useTaskActions.ts:13:  deleteTask: (taskId: string) => Promise<vo
id>;
src\hooks\useTaskActions.ts:16:type TaskActionFormState = {
src\hooks\useTaskActions.ts:17:  newTaskTitle: string;
src\hooks\useTaskActions.ts:18:  newTaskDueDate: string;
src\hooks\useTaskActions.ts:19:  newTaskPriority: Task["priority"];
src\hooks\useTaskActions.ts:20:  newTaskProjectId: string;
src\hooks\useTaskActions.ts:21:  newTaskMemo: string;
src\hooks\useTaskActions.ts:22:  editTaskTitle: string;
src\hooks\useTaskActions.ts:23:  editTaskDueDate: string;
src\hooks\useTaskActions.ts:24:  editTaskPriority: Task["priority"];
src\hooks\useTaskActions.ts:25:  editTaskMemo: string;
src\hooks\useTaskActions.ts:26:  editTaskProjectId: string;
src\hooks\useTaskActions.ts:27:  resetNewTaskForm: () => void;
src\hooks\useTaskActions.ts:28:  resetEditTaskForm: () => void;
src\hooks\useTaskActions.ts:31:type UseTaskActionsParams = TaskActionStore 
& TaskActionFormState;
src\hooks\useTaskActions.ts:33:export function useTaskActions({
src\hooks\useTaskActions.ts:34:  addTask,
src\hooks\useTaskActions.ts:35:  updateTask,
src\hooks\useTaskActions.ts:36:  deleteTask,
src\hooks\useTaskActions.ts:37:  newTaskTitle,
src\hooks\useTaskActions.ts:38:  newTaskDueDate,
src\hooks\useTaskActions.ts:39:  newTaskPriority,
src\hooks\useTaskActions.ts:40:  newTaskProjectId,
src\hooks\useTaskActions.ts:41:  newTaskMemo,
src\hooks\useTaskActions.ts:42:  editTaskTitle,
src\hooks\useTaskActions.ts:43:  editTaskDueDate,
src\hooks\useTaskActions.ts:44:  editTaskPriority,
src\hooks\useTaskActions.ts:45:  editTaskMemo,
src\hooks\useTaskActions.ts:46:  editTaskProjectId,
src\hooks\useTaskActions.ts:47:  resetNewTaskForm,
src\hooks\useTaskActions.ts:48:  resetEditTaskForm,
src\hooks\useTaskActions.ts:49:}: UseTaskActionsParams) {
src\hooks\useTaskActions.ts:50:  async function handleAddTask(event: FormEv
ent<HTMLFormElement>) {
src\hooks\useTaskActions.ts:53:    const title = newTaskTitle.trim();
src\hooks\useTaskActions.ts:56:    if (newTaskDueDate && newTaskDueDate.len
gth !== 10) return;
src\hooks\useTaskActions.ts:58:    await addTask({
src\hooks\useTaskActions.ts:60:      memo: newTaskMemo.trim() || undefined,
src\hooks\useTaskActions.ts:61:      dueDate: newTaskDueDate || undefined,
src\hooks\useTaskActions.ts:62:      priority: newTaskPriority,
src\hooks\useTaskActions.ts:63:      projectId: newTaskProjectId,
src\hooks\useTaskActions.ts:66:    resetNewTaskForm();
src\hooks\useTaskActions.ts:69:  function handleSaveEditTask(task: Task) {
src\hooks\useTaskActions.ts:70:    const title = editTaskTitle.trim();
src\hooks\useTaskActions.ts:73:    if (editTaskDueDate && editTaskDueDate.l
ength !== 10) return;
src\hooks\useTaskActions.ts:75:    void updateTask({
src\hooks\useTaskActions.ts:76:      ...task,
src\hooks\useTaskActions.ts:78:      memo: editTaskMemo.trim() || undefined
,
src\hooks\useTaskActions.ts:79:      dueDate: editTaskDueDate || undefined,
src\hooks\useTaskActions.ts:80:      priority: editTaskPriority,
src\hooks\useTaskActions.ts:81:      projectId: editTaskProjectId,
src\hooks\useTaskActions.ts:83:    resetEditTaskForm();
src\hooks\useTaskActions.ts:86:  function handleToggleTaskDone(task: Task) 
{
src\hooks\useTaskActions.ts:87:    const nextStatus = task.status === "done
" ? "todo" : "done";
src\hooks\useTaskActions.ts:88:    void updateTask({ ...task, status: nextS
tatus });
src\hooks\useTaskActions.ts:91:  function handleDeleteTask(task: Task) {
src\hooks\useTaskActions.ts:93:      void deleteTask(task.id);
src\hooks\useTaskActions.ts:98:    handleAddTask,
src\hooks\useTaskActions.ts:99:    handleSaveEditTask,
src\hooks\useTaskActions.ts:100:    handleToggleTaskDone,
src\hooks\useTaskActions.ts:101:    handleDeleteTask,
src\types.ts:3:export type Task = {
src\types.ts:9:  status: "todo" | "in_progress" | "done";
src\hooks\useTaskFormState.ts:2:import type { Task } from "../types";
src\hooks\useTaskFormState.ts:4:export function useTaskFormState() {
src\hooks\useTaskFormState.ts:5:  const [editingTaskId, setEditingTaskId] =
 useState<string | null>(null);
src\hooks\useTaskFormState.ts:6:  const [editTaskTitle, setEditTaskTitle] =
 useState("");
src\hooks\useTaskFormState.ts:7:  const [editTaskDueDate, setEditTaskDueDat
e] = useState("");
src\hooks\useTaskFormState.ts:8:  const [editTaskPriority, setEditTaskPrior
ity] = useState<Task["priority"]>("medium");
src\hooks\useTaskFormState.ts:9:  const [editTaskMemo, setEditTaskMemo] = u
seState("");
src\hooks\useTaskFormState.ts:10:  const [editTaskProjectId, setEditTaskPro
jectId] = useState("default");
src\hooks\useTaskFormState.ts:11:  const [newTaskTitle, setNewTaskTitle] = 
useState("");
src\hooks\useTaskFormState.ts:12:  const [newTaskDueDate, setNewTaskDueDate
] = useState("");
src\hooks\useTaskFormState.ts:13:  const [newTaskPriority, setNewTaskPriori
ty] = useState<Task["priority"]>("medium");
src\hooks\useTaskFormState.ts:14:  const [newTaskProjectId, setNewTaskProje
ctId] = useState("default");
src\hooks\useTaskFormState.ts:15:  const [newTaskMemo, setNewTaskMemo] = us
eState("");
src\hooks\useTaskFormState.ts:16:  const [isTaskFormOpen, setIsTaskFormOpen
] = useState(false);
src\hooks\useTaskFormState.ts:18:  function resetNewTaskForm() {
src\hooks\useTaskFormState.ts:19:    setIsTaskFormOpen(false);
src\hooks\useTaskFormState.ts:20:    setNewTaskTitle("");
src\hooks\useTaskFormState.ts:21:    setNewTaskDueDate("");
src\hooks\useTaskFormState.ts:22:    setNewTaskPriority("medium");
src\hooks\useTaskFormState.ts:23:    setNewTaskProjectId("default");
src\hooks\useTaskFormState.ts:24:    setNewTaskMemo("");
src\hooks\useTaskFormState.ts:27:  function resetEditTaskForm() {
src\hooks\useTaskFormState.ts:28:    setEditingTaskId(null);
src\hooks\useTaskFormState.ts:29:    setEditTaskTitle("");
src\hooks\useTaskFormState.ts:30:    setEditTaskMemo("");
src\hooks\useTaskFormState.ts:31:    setEditTaskDueDate("");
src\hooks\useTaskFormState.ts:32:    setEditTaskPriority("medium");
src\hooks\useTaskFormState.ts:33:    setEditTaskProjectId("default");
src\hooks\useTaskFormState.ts:36:  function startEditTask(task: Task) {
src\hooks\useTaskFormState.ts:37:    setEditingTaskId(task.id);
src\hooks\useTaskFormState.ts:38:    setEditTaskTitle(task.title);
src\hooks\useTaskFormState.ts:39:    setEditTaskMemo(task.memo || "");
src\hooks\useTaskFormState.ts:40:    setEditTaskDueDate(task.dueDate || "")
;
src\hooks\useTaskFormState.ts:41:    setEditTaskPriority(task.priority);
src\hooks\useTaskFormState.ts:42:    setEditTaskProjectId(task.projectId);
src\hooks\useTaskFormState.ts:46:    editingTaskId,
src\hooks\useTaskFormState.ts:47:    editTaskTitle,
src\hooks\useTaskFormState.ts:48:    editTaskDueDate,
src\hooks\useTaskFormState.ts:49:    editTaskPriority,
src\hooks\useTaskFormState.ts:50:    editTaskMemo,
src\hooks\useTaskFormState.ts:51:    editTaskProjectId,
src\hooks\useTaskFormState.ts:52:    newTaskTitle,
src\hooks\useTaskFormState.ts:53:    newTaskDueDate,
src\hooks\useTaskFormState.ts:54:    newTaskPriority,
src\hooks\useTaskFormState.ts:55:    newTaskProjectId,
src\hooks\useTaskFormState.ts:56:    newTaskMemo,
src\hooks\useTaskFormState.ts:57:    isTaskFormOpen,
src\hooks\useTaskFormState.ts:58:    setEditTaskTitle,
src\hooks\useTaskFormState.ts:59:    setEditTaskDueDate,
src\hooks\useTaskFormState.ts:60:    setEditTaskPriority,
src\hooks\useTaskFormState.ts:61:    setEditTaskMemo,
src\hooks\useTaskFormState.ts:62:    setEditTaskProjectId,
src\hooks\useTaskFormState.ts:63:    setNewTaskTitle,
src\hooks\useTaskFormState.ts:64:    setNewTaskDueDate,
src\hooks\useTaskFormState.ts:65:    setNewTaskPriority,
src\hooks\useTaskFormState.ts:66:    setNewTaskProjectId,
src\hooks\useTaskFormState.ts:67:    setNewTaskMemo,
src\hooks\useTaskFormState.ts:68:    setIsTaskFormOpen,
src\hooks\useTaskFormState.ts:69:    resetNewTaskForm,
src\hooks\useTaskFormState.ts:70:    resetEditTaskForm,
src\hooks\useTaskFormState.ts:71:    startEditTask,
src\views\ProjectsView.tsx:5:import { getProjectTaskStats } from "../utils/
projectStats";
src\views\ProjectsView.tsx:6:import type { Project, Task } from "../types";
src\views\ProjectsView.tsx:10:  tasks: Task[];
src\views\ProjectsView.tsx:29:  tasks,
src\views\ProjectsView.tsx:64:        <ul className="task-list">
src\views\ProjectsView.tsx:66:            const stats = getProjectTaskStats
(tasks, project.id);
src\views\ProjectsView.tsx:67:            const deleteBlockReason = getProj
ectDeleteBlockReason(project, tasks);
src\views\ProjectsView.tsx:71:                <li key={project.id} classNam
e="task-card">
src\utils\dateUtils.ts:1:import type { Task } from "../types";
src\utils\dateUtils.ts:23:export function isOverdueTask(task: Task, today =
 startOfToday()) {
src\utils\dateUtils.ts:24:  if (task.status === "done") return false;
src\utils\dateUtils.ts:25:  const dueDate = parseDueDate(task.dueDate);
src\utils\dateUtils.ts:29:export function isUpcomingTask(task: Task, today 
= startOfToday(), days = 7) {
src\utils\dateUtils.ts:30:  if (task.status === "done") return false;
src\utils\dateUtils.ts:32:  const dueDate = parseDueDate(task.dueDate);
src\views\SettingsView.tsx:2:import type { AppSettings, Project, Task } fro
m "../types";
src\views\SettingsView.tsx:11:  tasks: Task[];
src\views\SettingsView.tsx:15:export function SettingsView({ appSettings, t
asks, projects }: SettingsViewProps) {
src\views\SettingsView.tsx:23:      const { filename } = exportPlanPilotDat
a({ tasks, projects, appSettings });
src\views\SettingsView.tsx:82:            <p>업무: {importResult.summary.task
Count}개</p>
src\utils\exportData.ts:1:import type { AppSettings, Project, Task } from "
../types";
src\utils\exportData.ts:4:  tasks: Task[];
src\utils\exportData.ts:10:  tasks,
src\utils\exportData.ts:21:    tasks,
src\utils\importValidation.ts:1:import type { AppSettings, Project, Task } 
from "../types";
src\utils\importValidation.ts:6:const TASK_PRIORITIES: Task["priority"][] =
 ["low", "medium", "high"];
src\utils\importValidation.ts:7:const TASK_STATUSES: Task["status"][] = ["t
odo", "in_progress", "done"];
src\utils\importValidation.ts:10:  taskCount: number;
src\utils\importValidation.ts:26:  tasks?: unknown;
src\utils\importValidation.ts:43:  const tasks = Array.isArray(backup.tasks
) ? backup.tasks : [];
src\utils\importValidation.ts:46:  if (!Array.isArray(backup.tasks)) {
src\utils\importValidation.ts:47:    errors.push("tasks는 배열이어야 합니다.");
src\utils\importValidation.ts:59:  validateTasks(tasks, projects, errors);
src\utils\importValidation.ts:70:      taskCount: tasks.length,
src\utils\importValidation.ts:91:function validateTasks(
src\utils\importValidation.ts:92:  tasks: unknown[],
src\utils\importValidation.ts:99:  const taskIds = new Set<string>();
src\utils\importValidation.ts:101:  tasks.forEach((task, index) => {
src\utils\importValidation.ts:102:    const label = `tasks[${index}]`;
src\utils\importValidation.ts:104:    if (!isRecord(task)) {
src\utils\importValidation.ts:109:    validateRequiredString(task, "id", la
bel, errors);
src\utils\importValidation.ts:110:    validateRequiredString(task, "title",
 label, errors);
src\utils\importValidation.ts:111:    validateRequiredString(task, "project
Id", label, errors);
src\utils\importValidation.ts:112:    validateRequiredString(task, "created
At", label, errors);
src\utils\importValidation.ts:113:    validateRequiredString(task, "updated
At", label, errors);
src\utils\importValidation.ts:115:    if (!TASK_PRIORITIES.includes(task.pr
iority as Task["priority"])) {
src\utils\importValidation.ts:119:    if (!TASK_STATUSES.includes(task.stat
us as Task["status"])) {
src\utils\importValidation.ts:120:      errors.push(`${label}.status는 todo,
 in_progress, done 중 하나여야 합니다.`);
src\utils\importValidation.ts:123:    if (!Array.isArray(task.tags)) {
src\utils\importValidation.ts:127:    validateOptionalString(task, "dueDate
", label, errors);
src\utils\importValidation.ts:128:    validateOptionalString(task, "complet
edAt", label, errors);
src\utils\importValidation.ts:130:    if (isString(task.id)) {
src\utils\importValidation.ts:131:      if (taskIds.has(task.id)) {
src\utils\importValidation.ts:134:      taskIds.add(task.id);
src\utils\importValidation.ts:137:    if (isString(task.projectId) && !proj
ectIds.has(task.projectId)) {
src\utils\importValidation.ts:203:  key: keyof (Task & Project & AppSetting
s),
src\utils\importValidation.ts:214:  key: keyof (Task & Project),
src\utils\importValidation.ts:229:      taskCount: 0,
src\views\TasksView.tsx:2:import { TaskCard } from "../components/TaskCard"
;
src\views\TasksView.tsx:3:import { TaskForm } from "../components/TaskForm"
;
src\views\TasksView.tsx:4:import type { Project, Task } from "../types";
src\views\TasksView.tsx:5:import type { TaskSortOrder } from "../utils/task
Filters";
src\views\TasksView.tsx:7:type TasksViewProps = {
src\views\TasksView.tsx:9:  filteredTasks: Task[];
src\views\TasksView.tsx:10:  summaryTasks: Task[];
src\views\TasksView.tsx:11:  sortedTasks: Task[];
src\views\TasksView.tsx:13:  showCompletedTasks: boolean;
src\views\TasksView.tsx:14:  taskSortOrder: TaskSortOrder;
src\views\TasksView.tsx:15:  taskSearchQuery: string;
src\views\TasksView.tsx:16:  isTaskFormOpen: boolean;
src\views\TasksView.tsx:17:  newTaskTitle: string;
src\views\TasksView.tsx:18:  newTaskMemo: string;
src\views\TasksView.tsx:19:  newTaskDueDate: string;
src\views\TasksView.tsx:20:  newTaskPriority: Task["priority"];
src\views\TasksView.tsx:21:  newTaskProjectId: string;
src\views\TasksView.tsx:22:  editingTaskId: string | null;
src\views\TasksView.tsx:23:  editTaskTitle: string;
src\views\TasksView.tsx:24:  editTaskMemo: string;
src\views\TasksView.tsx:25:  editTaskDueDate: string;
src\views\TasksView.tsx:26:  editTaskPriority: Task["priority"];
src\views\TasksView.tsx:27:  editTaskProjectId: string;
src\views\TasksView.tsx:29:  onTaskSearchQueryChange: (value: string) => vo
id;
src\views\TasksView.tsx:30:  onShowCompletedTasksChange: (value: boolean) =
> void;
src\views\TasksView.tsx:31:  onTaskSortOrderChange: (value: TaskSortOrder) 
=> void;
src\views\TasksView.tsx:33:  onTaskFormOpenChange: (updater: (current: bool
ean) => boolean) => void;
src\views\TasksView.tsx:34:  onNewTaskTitleChange: (value: string) => void;
src\views\TasksView.tsx:35:  onNewTaskMemoChange: (value: string) => void;
src\views\TasksView.tsx:36:  onNewTaskDueDateChange: (value: string) => voi
d;
src\views\TasksView.tsx:37:  onNewTaskPriorityChange: (value: Task["priorit
y"]) => void;
src\views\TasksView.tsx:38:  onNewTaskProjectIdChange: (value: string) => v
oid;
src\views\TasksView.tsx:39:  onEditTaskTitleChange: (value: string) => void
;
src\views\TasksView.tsx:40:  onEditTaskMemoChange: (value: string) => void;
src\views\TasksView.tsx:41:  onEditTaskDueDateChange: (value: string) => vo
id;
src\views\TasksView.tsx:42:  onEditTaskPriorityChange: (value: Task["priori
ty"]) => void;
src\views\TasksView.tsx:43:  onEditTaskProjectIdChange: (value: string) => 
void;
src\views\TasksView.tsx:44:  onAddTask: (event: FormEvent<HTMLFormElement>)
 => void;
src\views\TasksView.tsx:45:  onSaveEditTask: (task: Task) => void;
src\views\TasksView.tsx:46:  onCancelEditTask: () => void;
src\views\TasksView.tsx:47:  onToggleTaskDone: (task: Task) => void;
src\views\TasksView.tsx:48:  onDeleteTask: (task: Task) => void;
src\views\TasksView.tsx:49:  onStartEditTask: (task: Task) => void;
src\views\TasksView.tsx:52:export function TasksView({
src\views\TasksView.tsx:54:  filteredTasks,
src\views\TasksView.tsx:55:  summaryTasks,
src\views\TasksView.tsx:56:  sortedTasks,
src\views\TasksView.tsx:58:  showCompletedTasks,
src\views\TasksView.tsx:59:  taskSortOrder,
src\views\TasksView.tsx:60:  taskSearchQuery,
src\views\TasksView.tsx:61:  isTaskFormOpen,
src\views\TasksView.tsx:62:  newTaskTitle,
src\views\TasksView.tsx:63:  newTaskMemo,
src\views\TasksView.tsx:64:  newTaskDueDate,
src\views\TasksView.tsx:65:  newTaskPriority,
src\views\TasksView.tsx:66:  newTaskProjectId,
src\views\TasksView.tsx:67:  editingTaskId,
src\views\TasksView.tsx:68:  editTaskTitle,
src\views\TasksView.tsx:69:  editTaskMemo,
src\views\TasksView.tsx:70:  editTaskDueDate,
src\views\TasksView.tsx:71:  editTaskPriority,
src\views\TasksView.tsx:72:  editTaskProjectId,
src\views\TasksView.tsx:74:  onTaskSearchQueryChange,
src\views\TasksView.tsx:75:  onShowCompletedTasksChange,
src\views\TasksView.tsx:76:  onTaskSortOrderChange,
src\views\TasksView.tsx:78:  onTaskFormOpenChange,
src\views\TasksView.tsx:79:  onNewTaskTitleChange,
src\views\TasksView.tsx:80:  onNewTaskMemoChange,
src\views\TasksView.tsx:81:  onNewTaskDueDateChange,
src\views\TasksView.tsx:82:  onNewTaskPriorityChange,
src\views\TasksView.tsx:83:  onNewTaskProjectIdChange,
src\views\TasksView.tsx:84:  onEditTaskTitleChange,
src\views\TasksView.tsx:85:  onEditTaskMemoChange,
src\views\TasksView.tsx:86:  onEditTaskDueDateChange,
src\views\TasksView.tsx:87:  onEditTaskPriorityChange,
src\views\TasksView.tsx:88:  onEditTaskProjectIdChange,
src\views\TasksView.tsx:89:  onAddTask,
src\views\TasksView.tsx:90:  onSaveEditTask,
src\views\TasksView.tsx:91:  onCancelEditTask,
src\views\TasksView.tsx:92:  onToggleTaskDone,
src\views\TasksView.tsx:93:  onDeleteTask,
src\views\TasksView.tsx:94:  onStartEditTask,
src\views\TasksView.tsx:95:}: TasksViewProps) {
src\views\TasksView.tsx:96:  const hasSearchQuery = taskSearchQuery.trim().
length > 0;
src\views\TasksView.tsx:98:  const hasVisibilityFilter = !showCompletedTask
s;
src\views\TasksView.tsx:99:  const completedTaskCount = summaryTasks.filter
(
src\views\TasksView.tsx:100:    (task) => task.status === "done",
src\views\TasksView.tsx:102:  const inProgressTaskCount = summaryTasks.filt
er(
src\views\TasksView.tsx:103:    (task) => task.status === "in_progress",
src\views\TasksView.tsx:105:  const remainingTaskCount = summaryTasks.filte
r(
src\views\TasksView.tsx:106:    (task) => task.status === "todo",
src\views\TasksView.tsx:108:  const totalTaskSummary = showCompletedTasks
src\views\TasksView.tsx:109:    ? `총 ${summaryTasks.length}개`
src\views\TasksView.tsx:110:    : `표시 ${filteredTasks.length}개 / 조건 일치 ${su
mmaryTasks.length}개`;
src\views\TasksView.tsx:111:  const completedTaskSummary = showCompletedTas
ks
src\views\TasksView.tsx:112:    ? `완료 ${completedTaskCount}개`
src\views\TasksView.tsx:113:    : `완료 ${completedTaskCount}개(숨김)`;
src\views\TasksView.tsx:135:        {totalTaskSummary} · 진행 중 {inProgressTa
skCount}개 ·{" "}
src\views\TasksView.tsx:136:        {completedTaskSummary} · 남은 업무 {remaini
ngTaskCount}개
src\views\TasksView.tsx:143:          value={taskSearchQuery}
src\views\TasksView.tsx:144:          onChange={(event) => onTaskSearchQuer
yChange(event.target.value)}
src\views\TasksView.tsx:152:          checked={showCompletedTasks}
src\views\TasksView.tsx:153:          onChange={(event) => onShowCompletedT
asksChange(event.target.checked)}
src\views\TasksView.tsx:161:          value={taskSortOrder}
src\views\TasksView.tsx:163:            onTaskSortOrderChange(event.target.
value as TaskSortOrder)
src\views\TasksView.tsx:188:        onClick={() => onTaskFormOpenChange((cu
rrent) => !current)}
src\views\TasksView.tsx:190:        {isTaskFormOpen ? "작은 업무 추가 닫기" : "작은 업
무 추가"}
src\views\TasksView.tsx:193:      {isTaskFormOpen && (
src\views\TasksView.tsx:194:        <TaskForm
src\views\TasksView.tsx:197:          taskTitle={newTaskTitle}
src\views\TasksView.tsx:198:          memo={newTaskMemo}
src\views\TasksView.tsx:199:          dueDate={newTaskDueDate}
src\views\TasksView.tsx:200:          priority={newTaskPriority}
src\views\TasksView.tsx:201:          projectId={newTaskProjectId}
src\views\TasksView.tsx:204:          onTitleChange={onNewTaskTitleChange}
src\views\TasksView.tsx:205:          onMemoChange={onNewTaskMemoChange}
src\views\TasksView.tsx:206:          onDueDateChange={onNewTaskDueDateChan
ge}
src\views\TasksView.tsx:207:          onPriorityChange={onNewTaskPriorityCh
ange}
src\views\TasksView.tsx:208:          onProjectIdChange={onNewTaskProjectId
Change}
src\views\TasksView.tsx:209:          onSubmit={onAddTask}
src\views\TasksView.tsx:213:      {filteredTasks.length === 0 ? (
src\views\TasksView.tsx:219:        <ul className="task-list">
src\views\TasksView.tsx:220:          {sortedTasks.map((task) => {
src\views\TasksView.tsx:221:            if (editingTaskId === task.id) {
src\views\TasksView.tsx:223:                <li key={task.id} className="ta
sk-card">
src\views\TasksView.tsx:224:                  <TaskForm
src\views\TasksView.tsx:227:                    taskTitle={editTaskTitle}
src\views\TasksView.tsx:228:                    memo={editTaskMemo}
src\views\TasksView.tsx:229:                    dueDate={editTaskDueDate}
src\views\TasksView.tsx:230:                    priority={editTaskPriority}
src\views\TasksView.tsx:231:                    projectId={editTaskProjectI
d}
src\views\TasksView.tsx:234:                    onTitleChange={onEditTaskTi
tleChange}
src\views\TasksView.tsx:235:                    onMemoChange={onEditTaskMem
oChange}
src\views\TasksView.tsx:236:                    onDueDateChange={onEditTask
DueDateChange}
src\views\TasksView.tsx:237:                    onPriorityChange={onEditTas
kPriorityChange}
src\views\TasksView.tsx:238:                    onProjectIdChange={onEditTa
skProjectIdChange}
src\views\TasksView.tsx:241:                      onSaveEditTask(task);
src\views\TasksView.tsx:243:                    onCancel={onCancelEditTask}
src\views\TasksView.tsx:251:              <TaskCard
src\views\TasksView.tsx:252:                key={task.id}
src\views\TasksView.tsx:253:                task={task}
src\views\TasksView.tsx:254:                projectName={getProjectName(tas
k.projectId)}
src\views\TasksView.tsx:255:                onToggleDone={onToggleTaskDone}
src\views\TasksView.tsx:256:                onDelete={onDeleteTask}
src\views\TasksView.tsx:257:                onStartEdit={onStartEditTask}
src\utils\projectDeletion.ts:1:import type { Project, Task } from "../types
";
src\utils\projectDeletion.ts:2:import { getProjectTaskStats } from "./proje
ctStats";
src\utils\projectDeletion.ts:4:export type ProjectDeleteBlockReason = "defa
ult-project" | "has-tasks";
src\utils\projectDeletion.ts:8:  tasks: Task[],
src\utils\projectDeletion.ts:14:  const stats = getProjectTaskStats(tasks, 
project.id);
src\utils\projectDeletion.ts:15:  if (stats.totalTasks > 0) {
src\utils\projectDeletion.ts:16:    return "has-tasks";
src\utils\projectDeletion.ts:22:export function canDeleteProject(project: P
roject, tasks: Task[]) {
src\utils\projectDeletion.ts:23:  return getProjectDeleteBlockReason(projec
t, tasks) === null;
src\views\TodayView.tsx:1:import { getPriorityLabel, getStatusLabel } from 
"../utils/taskLabels";
src\views\TodayView.tsx:2:import type { Task } from "../types";
src\views\TodayView.tsx:5:  totalTasks: number;
src\views\TodayView.tsx:6:  completedTasks: number;
src\views\TodayView.tsx:7:  recommendedTasks: Task[];
src\views\TodayView.tsx:8:  overdueTasks: Task[];
src\views\TodayView.tsx:9:  upcomingTasks: Task[];
src\views\TodayView.tsx:14:  totalTasks,
src\views\TodayView.tsx:15:  completedTasks,
src\views\TodayView.tsx:16:  recommendedTasks,
src\views\TodayView.tsx:17:  overdueTasks,
src\views\TodayView.tsx:18:  upcomingTasks,
src\views\TodayView.tsx:25:        전체 업무 수: {totalTasks}개<br />
src\views\TodayView.tsx:26:        완료 업무 수: {completedTasks}개<br />
src\views\TodayView.tsx:27:        지난 마감 업무 수: {overdueTasks.length}개<br />
src\views\TodayView.tsx:28:        7일 이내 마감 업무 수: {upcomingTasks.length}개
src\views\TodayView.tsx:30:      <p className="summary">추천 업무 {recommendedT
asks.length}개</p>
src\views\TodayView.tsx:32:      {recommendedTasks.length === 0 ? (
src\views\TodayView.tsx:35:        <ul className="task-list">
src\views\TodayView.tsx:36:          {recommendedTasks.map((task) => (
src\views\TodayView.tsx:37:            <li key={task.id} className="task-ca
rd">
src\views\TodayView.tsx:38:              <strong>{task.title}</strong>
src\views\TodayView.tsx:39:              {task.memo && <span>메모: {task.memo
}</span>}
src\views\TodayView.tsx:41:                중요도: {getPriorityLabel(task.prio
rity)} · 상태: {getStatusLabel(task.status)} · 프로젝트: {getProjectName(task.pro
jectId)}
src\views\TodayView.tsx:43:              <span>{task.dueDate ? `마감일: ${task
.dueDate}` : "마감일 없음"}</span>
src\views\TodayView.tsx:50:      {overdueTasks.length === 0 ? (
src\views\TodayView.tsx:53:        <ul className="task-list">
src\views\TodayView.tsx:54:          {overdueTasks.map((task) => (
src\views\TodayView.tsx:55:            <li key={task.id} className="task-ca
rd">
src\views\TodayView.tsx:56:              <strong>{task.title}</strong>
src\views\TodayView.tsx:57:              {task.memo && <span>메모: {task.memo
}</span>}
src\views\TodayView.tsx:59:                프로젝트: {getProjectName(task.proje
ctId)} · 마감일: {task.dueDate}
src\views\TodayView.tsx:67:      {upcomingTasks.length === 0 ? (
src\views\TodayView.tsx:70:        <ul className="task-list">
src\views\TodayView.tsx:71:          {upcomingTasks.map((task) => (
src\views\TodayView.tsx:72:            <li key={task.id} className="task-ca
rd">
src\views\TodayView.tsx:73:              <strong>{task.title}</strong>
src\views\TodayView.tsx:74:              {task.memo && <span>메모: {task.memo
}</span>}
src\views\TodayView.tsx:76:                프로젝트: {getProjectName(task.proje
ctId)} · 마감일: {task.dueDate}
src\utils\projectStats.ts:1:import type { Task } from "../types";
src\utils\projectStats.ts:3:export function getProjectTaskStats(tasks: Task
[], projectId: string) {
src\utils\projectStats.ts:4:  const projectTasks = tasks.filter((task) => t
ask.projectId === projectId);
src\utils\projectStats.ts:5:  const totalTasks = projectTasks.length;
src\utils\projectStats.ts:6:  const completedTasks = projectTasks.filter((t
ask) => task.status === "done").length;
src\utils\projectStats.ts:7:  const incompleteTasks = totalTasks - complete
dTasks;
src\utils\projectStats.ts:9:  return { totalTasks, completedTasks, incomple
teTasks };
src\utils\taskDates.ts:1:import type { Task } from "../types";
src\utils\taskDates.ts:2:import { isOverdueTask, isUpcomingTask } from "./d
ateUtils";
src\utils\taskDates.ts:4:export function getOverdueTasks(tasks: Task[], tod
ay: Date) {
src\utils\taskDates.ts:5:  return tasks.filter((task) => isOverdueTask(task
, today));
src\utils\taskDates.ts:8:export function getUpcomingTasks(tasks: Task[], to
day: Date, days: number) {
src\utils\taskDates.ts:9:  return tasks.filter((task) => isUpcomingTask(tas
k, today, days));
src\utils\taskFilters.ts:1:import type { Project, Task } from "../types";
src\utils\taskFilters.ts:3:export type TaskSortOrder = "none" | "dueDateAsc
";
src\utils\taskFilters.ts:5:type FilterTasksOptions = {
src\utils\taskFilters.ts:7:  showCompletedTasks: boolean;
src\utils\taskFilters.ts:8:  taskSearchQuery: string;
src\utils\taskFilters.ts:12:export function filterTasks(
src\utils\taskFilters.ts:13:  tasks: Task[],
src\utils\taskFilters.ts:16:    showCompletedTasks,
src\utils\taskFilters.ts:17:    taskSearchQuery,
src\utils\taskFilters.ts:19:  }: FilterTasksOptions,
src\utils\taskFilters.ts:25:  return tasks.filter((task) => {
src\utils\taskFilters.ts:27:      selectedProjectFilter === "all" || task.p
rojectId === selectedProjectFilter;
src\utils\taskFilters.ts:29:    const searchText = taskSearchQuery.trim().t
oLowerCase();
src\utils\taskFilters.ts:31:      task.title,
src\utils\taskFilters.ts:32:      task.memo ?? "",
src\utils\taskFilters.ts:33:      projectNameById.get(task.projectId) ?? ""
,
src\utils\taskFilters.ts:38:    const matchesStatus = showCompletedTasks ||
 task.status !== "done";
src\utils\taskFilters.ts:44:export function sortTasks(tasks: Task[], taskSo
rtOrder: TaskSortOrder) {
src\utils\taskFilters.ts:45:  return [...tasks].sort((a, b) => {
src\utils\taskFilters.ts:46:    if (taskSortOrder === "none") return 0;
src\utils\taskFilters.ts:48:    if (taskSortOrder === "dueDateAsc") {
src\utils\taskLabels.ts:1:import type { Task } from "../types";
src\utils\taskLabels.ts:3:export function getPriorityLabel(priority: Task["
priority"]) {
src\utils\taskLabels.ts:16:export function getStatusLabel(status: Task["sta
tus"]) {
src\utils\taskLabels.ts:17:  switch (status) {
src\utils\taskLabels.ts:25:      return status;
src\utils\taskSummary.ts:1:import type { Task } from "../types";
src\utils\taskSummary.ts:3:export function getTaskSummary(tasks: Task[]) {
src\utils\taskSummary.ts:4:  const totalTasks = tasks.length;
src\utils\taskSummary.ts:5:  const completedTasks = tasks.filter((task) => 
task.status === "done").length;
src\utils\taskSummary.ts:7:  return { totalTasks, completedTasks };

codex
검색 결과상 핵심은 `types.ts`, `store.ts`, `db.ts`, task 관련 hook/view/util입니다. 병렬 t
ask를 “동시에 여러 개 표시/진행 상태로 둘 수 있는가” 관점에서 이 파일들만 읽겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath src\\store.ts" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath src\\types.ts" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath src\\db.ts" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath src\\hooks\\useTaskActions.ts" in D:\ai-apps\planp
ilot-local
 succeeded in 3141ms:
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

 succeeded in 3217ms:
// src/store.ts

import { create } from "zustand";
import { db } from "./db";
import type { Task, Project, AppSettings } from "./types";

// Helper function to create a unique ID
function createId() {
  if (globalThis.crypto?.randomUUID) {
    return globalThis.crypto.randomUUID();
  }
  return Date.now().toString();
}

interface StoreState {
  tasks: Task[];
  projects: Project[];
  appSettings: AppSettings;
}

interface StoreActions {
  initializeApp: () => Promise<void>;
  fetchTasks: () => Promise<void>;
  fetchProjects: () => Promise<void>;
  fetchAppSettings: () => Promise<void>;
  addTask: (input: CreateTaskInput) => Promise<void>;
  updateTask: (task: Task) => Promise<void>;
  deleteTask: (taskId: string) => Promise<void>;
  addProject: (input: CreateProjectInput) => Promise<void>;
  updateProject: (project: Project) => Promise<void>;
  deleteProject: (projectId: string) => Promise<void>;
  updateAppSettings: (settings: AppSettings) => Promise<void>;
}

type CreateTaskInput = {
  title: string;
  memo?: string;
  dueDate?: string;
  priority?: Task["priority"];
  status?: Task["status"];
  projectId?: string;
  tags?: string[];
  estimatedMinutes?: number;
  sortOrder?: number;
};

type CreateProjectInput = {
  name: string;
  description?: string;
  color?: string;
};

const initialState: StoreState = {
  tasks: [],
  projects: [],
  appSettings: {
    theme: "light",
    language: "ko",
    aiProvider: "rule_based",
    enableNotifications: false,
    firstLaunchCompleted: false,
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
};

type Store = StoreState & StoreActions;

export const useStore = create<Store>((set, get) => ({
  ...initialState,
  initializeApp: async () => {
    await db.ensureDefaultData();
    await get().fetchTasks();
    await get().fetchProjects();
    await get().fetchAppSettings();
  },
  fetchTasks: async () => {
    const tasks = await db.tasks.toArray();
    set({ tasks });
  },
  fetchProjects: async () => {
    const projects = await db.projects.toArray();
    set({ projects });
  },
  fetchAppSettings: async () => {
    const settings = await db.appSettings.get("app-settings");
    if (settings) {
      const appSettings: AppSettings = {
        theme: settings.theme,
        language: settings.language,
        aiProvider: settings.aiProvider,
        enableNotifications: settings.enableNotifications,
        firstLaunchCompleted: settings.firstLaunchCompleted,
        createdAt: settings.createdAt,
        updatedAt: settings.updatedAt,
      };
      set({ appSettings });
    }
  },
  addTask: async (input) => {
    const id = createId();
    const now = new Date().toISOString();
    const task: Task = {
      id,
      title: input.title,
      priority: input.priority ?? "medium",
      status: input.status ?? "todo",
      projectId: input.projectId ?? "default",
      tags: input.tags ?? [],
      createdAt: now,
      updatedAt: now,
    };

    if (input.memo) task.memo = input.memo;
    if (input.dueDate) task.dueDate = input.dueDate;
    if (input.estimatedMinutes !== undefined) task.estimatedMinutes = input
.estimatedMinutes;
    if (input.sortOrder !== undefined) task.sortOrder = input.sortOrder;

    await db.tasks.add(task);
    set((state) => ({ tasks: [...state.tasks, task] }));
  },
  updateTask: async (task) => {
    const updatedTask: Task = {
      ...task,
      updatedAt: new Date().toISOString(),
    };

    if (updatedTask.status === "done") {
      updatedTask.completedAt = updatedTask.completedAt || new Date().toISO
String();
    } else {
      delete updatedTask.completedAt;
    }

    await db.tasks.put(updatedTask);
    set((state) => ({
      tasks: state.tasks.map((t) => (t.id === task.id ? updatedTask : t)),
    }));
  },
  deleteTask: async (taskId) => {
    await db.tasks.delete(taskId);
    set((state) => ({ tasks: state.tasks.filter((t) => t.id !== taskId) }))
;
  },
  addProject: async (input) => {
    const id = createId();
    const now = new Date().toISOString();
    const project: Project = {
      id,
      name: input.name,
      description: input.description ?? "",
      color: input.color ?? "",
      createdAt: now,
      updatedAt: now,
    };

    await db.projects.add(project);
    set((state) => ({ projects: [...state.projects, project] }));
  },
  updateProject: async (project) => {
    const updatedProject = {
      ...project,
      updatedAt: new Date().toISOString(),
    };
    await db.projects.put(updatedProject);
    set((state) => ({
      projects: state.projects.map((p) => (p.id === project.id ? updatedPro
ject : p)),
    }));
  },
  deleteProject: async (projectId) => {
    if (projectId === "default") {
      throw new Error("Cannot delete the default project");
    }
    await db.projects.delete(projectId);
    set((state) => ({ projects: state.projects.filter((p) => p.id !== proje
ctId) }));
  },
  updateAppSettings: async (settings) => {
    const updatedSettings: AppSettings = {
      ...settings,
      updatedAt: new Date().toISOString(),
    };

    await db.appSettings.put({ ...updatedSettings, id: "app-settings" });
    set({ appSettings: updatedSettings });
  },
}));

 succeeded in 3383ms:
// src/db.ts

import Dexie from "dexie";
import type { Table } from "dexie";
import type { Task, Project, StoredAppSettings } from "./types";

export class PlanPilotDatabase extends Dexie {
  tasks!: Table<Task, string>;
  projects!: Table<Project, string>;
  appSettings!: Table<StoredAppSettings, string>;

  constructor() {
    super("PlanPilotDatabase");
    this.version(1).stores({
      tasks: "id,projectId,status,sortOrder",
      projects: "id",
      appSettings: "id",
    });
  }

  async ensureDefaultData() {
    const defaultProjectId = "default";
    const defaultSettingsId = "app-settings";

    const projectExists = await this.projects.get(defaultProjectId);
    const settingsExists = await this.appSettings.get(defaultSettingsId);

    if (!projectExists) {
      await this.projects.add({
        id: defaultProjectId,
        name: "湲곕낯",
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
      });
    }

    if (!settingsExists) {
      await this.appSettings.add({
        id: defaultSettingsId,
        theme: "light",
        language: "ko",
        aiProvider: "rule_based",
        enableNotifications: false,
        firstLaunchCompleted: false,
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
      });
    }
  }
}

export const db = new PlanPilotDatabase();

 succeeded in 3465ms:
import type { FormEvent } from "react";
import type { Task } from "../types";

type TaskActionStore = {
  addTask: (input: {
    title: string;
    memo?: string;
    dueDate?: string;
    priority: Task["priority"];
    projectId: string;
  }) => Promise<void>;
  updateTask: (task: Task) => Promise<void>;
  deleteTask: (taskId: string) => Promise<void>;
};

type TaskActionFormState = {
  newTaskTitle: string;
  newTaskDueDate: string;
  newTaskPriority: Task["priority"];
  newTaskProjectId: string;
  newTaskMemo: string;
  editTaskTitle: string;
  editTaskDueDate: string;
  editTaskPriority: Task["priority"];
  editTaskMemo: string;
  editTaskProjectId: string;
  resetNewTaskForm: () => void;
  resetEditTaskForm: () => void;
};

type UseTaskActionsParams = TaskActionStore & TaskActionFormState;

export function useTaskActions({
  addTask,
  updateTask,
  deleteTask,
  newTaskTitle,
  newTaskDueDate,
  newTaskPriority,
  newTaskProjectId,
  newTaskMemo,
  editTaskTitle,
  editTaskDueDate,
  editTaskPriority,
  editTaskMemo,
  editTaskProjectId,
  resetNewTaskForm,
  resetEditTaskForm,
}: UseTaskActionsParams) {
  async function handleAddTask(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    const title = newTaskTitle.trim();
    if (!title) return;

    if (newTaskDueDate && newTaskDueDate.length !== 10) return;

    await addTask({
      title,
      memo: newTaskMemo.trim() || undefined,
      dueDate: newTaskDueDate || undefined,
      priority: newTaskPriority,
      projectId: newTaskProjectId,
    });

    resetNewTaskForm();
  }

  function handleSaveEditTask(task: Task) {
    const title = editTaskTitle.trim();
    if (!title) return;

    if (editTaskDueDate && editTaskDueDate.length !== 10) return;

    void updateTask({
      ...task,
      title,
      memo: editTaskMemo.trim() || undefined,
      dueDate: editTaskDueDate || undefined,
      priority: editTaskPriority,
      projectId: editTaskProjectId,
    });
    resetEditTaskForm();
  }

  function handleToggleTaskDone(task: Task) {
    const nextStatus = task.status === "done" ? "todo" : "done";
    void updateTask({ ...task, status: nextStatus });
  }

  function handleDeleteTask(task: Task) {
    if (window.confirm("?뺣쭚濡????낅Т瑜???젣?섏떆寃좎뒿?덇퉴?")) {
      void deleteTask(task.id);
    }
  }

  return {
    handleAddTask,
    handleSaveEditTask,
    handleToggleTaskDone,
    handleDeleteTask,
  };
}

codex
현재 타입에는 이미 `in_progress` 상태가 있고 store도 여러 task를 배열로 보관합니다. 다음으로 실제 화면에서 이 상
태가 어떻게 계산·표시되는지 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath src\\views\\TodayView.tsx" in D:\ai-apps\planpilot
-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath src\\hooks\\useTaskFormState.ts" in D:\ai-apps\pla
npilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath src\\components\\TaskCard.tsx" in D:\ai-apps\planp
ilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath src\\views\\TasksView.tsx" in D:\ai-apps\planpilot
-local
 succeeded in 3313ms:
import type { FormEvent } from "react";
import { TaskCard } from "../components/TaskCard";
import { TaskForm } from "../components/TaskForm";
import type { Project, Task } from "../types";
import type { TaskSortOrder } from "../utils/taskFilters";

type TasksViewProps = {
  projects: Project[];
  filteredTasks: Task[];
  summaryTasks: Task[];
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
  summaryTasks,
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
  const completedTaskCount = summaryTasks.filter(
    (task) => task.status === "done",
  ).length;
  const inProgressTaskCount = summaryTasks.filter(
    (task) => task.status === "in_progress",
  ).length;
  const remainingTaskCount = summaryTasks.filter(
    (task) => task.status === "todo",
  ).length;
  const totalTaskSummary = showCompletedTasks
    ? `珥?${summaryTasks.length}媛?
    : `?쒖떆 ${filteredTasks.length}媛?/ 議곌굔 ?쇱튂 ${summaryTasks.length}媛?;
  const completedTaskSummary = showCompletedTasks
    ? `?꾨즺 ${completedTaskCount}媛?
    : `?꾨즺 ${completedTaskCount}媛??④?)`;
  const emptyMessage =
    hasSearchQuery
      ? "寃??寃곌낵??留욌뒗 ?낅Т媛 ?놁뼱??"
      : hasProjectFilter || hasVisibilityFilter
        ? "?좏깮??議곌굔???쒖떆???낅Т媛 ?놁뼱??"
        : "?꾩쭅 ?깅줉???낅Т媛 ?놁뼱??";
  const emptyActionMessage =
    hasSearchQuery
      ? "寃?됱뼱瑜?以꾩씠嫄곕굹 鍮꾩슫 ???ㅼ떆 ?뺤씤?대낫?몄슂."
      : hasProjectFilter && hasVisibilityFilter
        ? "?꾨줈?앺듃瑜??꾩껜濡?諛붽씀嫄곕굹 ?꾨즺 ?낅Т ?쒖떆瑜?耳쒖꽌 ?⑥? ?낅Т瑜??뺤씤?대낫?몄슂."
        : hasProjectFilter
          ? "?꾨줈?앺듃瑜??꾩껜濡?諛붽씀硫??ㅻⅨ ?낅Т瑜??뺤씤?????덉뼱??"
          : hasVisibilityFilter
            ? "?꾨즺 ?낅Т ?쒖떆瑜?耳쒕㈃ ?⑥? ?꾨즺 ?낅Т瑜??뺤씤?????덉뼱??"
            : "?묒? ?낅Т瑜??섎굹 異붽??섎㈃ ??湲곌린 ?덉뿉 諛붾줈 ??λ뤌??";

  return (
    <section className="screen-card">
      <h2>?꾩껜 ?낅Т</h2>
      <p className="summary">
        {totalTaskSummary} 쨌 吏꾪뻾 以?{inProgressTaskCount}媛?쨌{" "}
        {completedTaskSummary} 쨌 ?⑥? ?낅Т {remainingTaskCount}媛?
      </p>

      <label>
        ?낅Т 寃??
        <input
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
          onChange={(event) => onShowCompletedTasksChange(event.target.chec
ked)}
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
          onChange={(event) => onSelectedProjectFilterChange(event.target.v
alue)}
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
        {isTaskFormOpen ? "?묒? ?낅Т 異붽? ?リ린" : "?묒? ?낅Т 異붽?"}
      </button>

      {isTaskFormOpen && (
        <TaskForm
          title="???묒? ?낅Т 異붽?"
          ariaLabel="???묒? ?낅Т 異붽?"
          taskTitle={newTaskTitle}
          memo={newTaskMemo}
          dueDate={newTaskDueDate}
          priority={newTaskPriority}
          projectId={newTaskProjectId}
          projects={projects}
          submitLabel="濡쒖뺄???낅Т 異붽?"
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
          <p>{emptyActionMessage}</p>
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
                    submitLabel="?섏젙 ???
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

 succeeded in 3328ms:
import { useState } from "react";
import type { Task } from "../types";

export function useTaskFormState() {
  const [editingTaskId, setEditingTaskId] = useState<string | null>(null);
  const [editTaskTitle, setEditTaskTitle] = useState("");
  const [editTaskDueDate, setEditTaskDueDate] = useState("");
  const [editTaskPriority, setEditTaskPriority] = useState<Task["priority"]
>("medium");
  const [editTaskMemo, setEditTaskMemo] = useState("");
  const [editTaskProjectId, setEditTaskProjectId] = useState("default");
  const [newTaskTitle, setNewTaskTitle] = useState("");
  const [newTaskDueDate, setNewTaskDueDate] = useState("");
  const [newTaskPriority, setNewTaskPriority] = useState<Task["priority"]>(
"medium");
  const [newTaskProjectId, setNewTaskProjectId] = useState("default");
  const [newTaskMemo, setNewTaskMemo] = useState("");
  const [isTaskFormOpen, setIsTaskFormOpen] = useState(false);

  function resetNewTaskForm() {
    setIsTaskFormOpen(false);
    setNewTaskTitle("");
    setNewTaskDueDate("");
    setNewTaskPriority("medium");
    setNewTaskProjectId("default");
    setNewTaskMemo("");
  }

  function resetEditTaskForm() {
    setEditingTaskId(null);
    setEditTaskTitle("");
    setEditTaskMemo("");
    setEditTaskDueDate("");
    setEditTaskPriority("medium");
    setEditTaskProjectId("default");
  }

  function startEditTask(task: Task) {
    setEditingTaskId(task.id);
    setEditTaskTitle(task.title);
    setEditTaskMemo(task.memo || "");
    setEditTaskDueDate(task.dueDate || "");
    setEditTaskPriority(task.priority);
    setEditTaskProjectId(task.projectId);
  }

  return {
    editingTaskId,
    editTaskTitle,
    editTaskDueDate,
    editTaskPriority,
    editTaskMemo,
    editTaskProjectId,
    newTaskTitle,
    newTaskDueDate,
    newTaskPriority,
    newTaskProjectId,
    newTaskMemo,
    isTaskFormOpen,
    setEditTaskTitle,
    setEditTaskDueDate,
    setEditTaskPriority,
    setEditTaskMemo,
    setEditTaskProjectId,
    setNewTaskTitle,
    setNewTaskDueDate,
    setNewTaskPriority,
    setNewTaskProjectId,
    setNewTaskMemo,
    setIsTaskFormOpen,
    resetNewTaskForm,
    resetEditTaskForm,
    startEditTask,
  };
}

 succeeded in 3393ms:
import { getPriorityLabel, getStatusLabel } from "../utils/taskLabels";
import type { Task } from "../types";

type TodayViewProps = {
  totalTasks: number;
  completedTasks: number;
  recommendedTasks: Task[];
  overdueTasks: Task[];
  upcomingTasks: Task[];
  getProjectName: (projectId: string) => string;
};

export function TodayView({
  totalTasks,
  completedTasks,
  recommendedTasks,
  overdueTasks,
  upcomingTasks,
  getProjectName,
}: TodayViewProps) {
  return (
    <section className="screen-card">
      <h2>?ㅻ뒛</h2>
      <p className="summary">
        ?꾩껜 ?낅Т ?? {totalTasks}媛?br />
        ?꾨즺 ?낅Т ?? {completedTasks}媛?br />
        吏??留덇컧 ?낅Т ?? {overdueTasks.length}媛?br />
        7???대궡 留덇컧 ?낅Т ?? {upcomingTasks.length}媛?      </p>
      <p className="summary">異붿쿇 ?낅Т {recommendedTasks.length}媛?/p>

      {recommendedTasks.length === 0 ? (
        <p className="empty">異붿쿇??誘몄셿猷??낅Т媛 ?놁뒿?덈떎.</p>
      ) : (
        <ul className="task-list">
          {recommendedTasks.map((task) => (
            <li key={task.id} className="task-card">
              <strong>{task.title}</strong>
              {task.memo && <span>硫붾え: {task.memo}</span>}
              <span>
                以묒슂?? {getPriorityLabel(task.priority)} 쨌 ?곹깭: {getStatusLa
bel(task.status)} 쨌 ?꾨줈?앺듃: {getProjectName(task.projectId)}
              </span>
              <span>{task.dueDate ? `留덇컧?? ${task.dueDate}` : "留덇컧???놁쓬"}</
span>
            </li>
          ))}
        </ul>
      )}

      <h3>吏??留덇컧 ?낅Т</h3>
      {overdueTasks.length === 0 ? (
        <p className="empty">吏??留덇컧?쇱쓣 ?섍릿 誘몄셿猷??낅Т媛 ?놁뒿?덈떎.</p>
      ) : (
        <ul className="task-list">
          {overdueTasks.map((task) => (
            <li key={task.id} className="task-card">
              <strong>{task.title}</strong>
              {task.memo && <span>硫붾え: {task.memo}</span>}
              <span>
                ?꾨줈?앺듃: {getProjectName(task.projectId)} 쨌 留덇컧?? {task.dueD
ate}
              </span>
            </li>
          ))}
        </ul>
      )}

      <h3>7???대궡 留덇컧 ?낅Т</h3>
      {upcomingTasks.length === 0 ? (
        <p className="empty">7???대궡??留덇컧?섎뒗 誘몄셿猷??낅Т媛 ?놁뒿?덈떎.</p>
      ) : (
        <ul className="task-list">
          {upcomingTasks.map((task) => (
            <li key={task.id} className="task-card">
              <strong>{task.title}</strong>
              {task.memo && <span>硫붾え: {task.memo}</span>}
              <span>
                ?꾨줈?앺듃: {getProjectName(task.projectId)} 쨌 留덇컧?? {task.dueD
ate}
              </span>
            </li>
          ))}
        </ul>
      )}
    </section>
  );
}

 succeeded in 3405ms:
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
          aria-label="留덇컧?쇱씠 怨??ㅺ??ㅻ뒗 ?낅Т?낅땲??
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
          留덇컧 ?꾨컯
        </span>
      )}
      {task.memo && <span>硫붾え: {task.memo}</span>}
      <span>
        以묒슂?? {getPriorityLabel(task.priority)} 쨌 ?곹깭: {getStatusLabel(task
.status)} 쨌 ?꾨줈?앺듃: {projectName}
      </span>
      <span>{task.dueDate ? `留덇컧?? ${task.dueDate}` : "留덇컧???놁쓬"}</span>
      <button
        type="button"
        aria-label={
          task.status === "done"
            ? `'${task.title}' ?낅Т瑜?誘몄셿猷뚮줈 ?섎룎由ш린`
            : `'${task.title}' ?낅Т瑜??꾨즺濡??쒖떆?섍린`
        }
        onClick={() => onToggleDone(task)}
      >
        {task.status === "done" ? "誘몄셿猷뚮줈 ?섎룎由ш린" : "?낅Т ?꾨즺濡??쒖떆"}
      </button>
      <button
        type="button"
        aria-label={`'${task.title}' ?낅Т ??젣?섍린`}
        onClick={() => onDelete(task)}
      >
        ?낅Т ??젣
      </button>
      <button
        type="button"
        aria-label={`'${task.title}' ?낅Т ?섏젙?섍린`}
        onClick={() => onStartEdit(task)}
      >
        ?낅Т ?섏젙
      </button>
    </li>
  );
}

codex
화면 쪽에서는 목록 렌더링 자체는 이미 배열 기반이고 `in_progress` 카운트도 계산합니다. 다만 카드 액션은 완료/미완료 토글
만 있어 진행 중으로 전환하는 사용자 흐름은 아직 없어 보입니다. 관련 유틸과 App 연결부를 더 확인합니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath src\\utils\\taskFilters.ts" in D:\ai-apps\planpilo
t-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath src\\App.tsx" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath src\\utils\\dateUtils.ts" in D:\ai-apps\planpilot-
local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath src\\utils\\taskLabels.ts" in D:\ai-apps\planpilot
-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath src\\utils\\importValidation.ts" in D:\ai-apps\pla
npilot-local
 succeeded in 3859ms:
import type { Project, Task } from "../types";

export type TaskSortOrder = "none" | "dueDateAsc";

type FilterTasksOptions = {
  selectedProjectFilter: string;
  showCompletedTasks: boolean;
  taskSearchQuery: string;
  projects?: Project[];
};

export function filterTasks(
  tasks: Task[],
  {
    selectedProjectFilter,
    showCompletedTasks,
    taskSearchQuery,
    projects = [],
  }: FilterTasksOptions,
) {
  const projectNameById = new Map(
    projects.map((project) => [project.id, project.name.toLowerCase()]),
  );

  return tasks.filter((task) => {
    const matchesProject =
      selectedProjectFilter === "all" || task.projectId === selectedProject
Filter;

    const searchText = taskSearchQuery.trim().toLowerCase();
    const searchableText = [
      task.title,
      task.memo ?? "",
      projectNameById.get(task.projectId) ?? "",
    ].join(" ");
    const matchesSearch =
      !searchText || searchableText.toLowerCase().includes(searchText);

    const matchesStatus = showCompletedTasks || task.status !== "done";

    return matchesProject && matchesSearch && matchesStatus;
  });
}

export function sortTasks(tasks: Task[], taskSortOrder: TaskSortOrder) {
  return [...tasks].sort((a, b) => {
    if (taskSortOrder === "none") return 0;

    if (taskSortOrder === "dueDateAsc") {
      if (!a.dueDate && !b.dueDate) return 0;
      if (!a.dueDate) return 1;
      if (!b.dueDate) return -1;
      return new Date(a.dueDate).getTime() - new Date(b.dueDate).getTime();
    }

    return 0;
  });
}

 succeeded in 3958ms:
import type { Task } from "../types";

export function startOfToday() {
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  return today;
}

export function parseDueDate(dueDate?: string) {
  if (!dueDate) return null;

  const dateOnlyMatch = /^(\d{4})-(\d{2})-(\d{2})$/.exec(dueDate);
  const parsed = dateOnlyMatch
    ? new Date(
        Number(dateOnlyMatch[1]),
        Number(dateOnlyMatch[2]) - 1,
        Number(dateOnlyMatch[3]),
      )
    : new Date(dueDate);
  return Number.isNaN(parsed.getTime()) ? null : parsed;
}

export function isOverdueTask(task: Task, today = startOfToday()) {
  if (task.status === "done") return false;
  const dueDate = parseDueDate(task.dueDate);
  return Boolean(dueDate && dueDate < today);
}

export function isUpcomingTask(task: Task, today = startOfToday(), days = 7
) {
  if (task.status === "done") return false;

  const dueDate = parseDueDate(task.dueDate);
  if (!dueDate) return false;

  const daysLater = new Date(today);
  daysLater.setDate(today.getDate() + days);

  return dueDate >= today && dueDate <= daysLater;
}

 succeeded in 3970ms:
import type { Task } from "../types";

export function getPriorityLabel(priority: Task["priority"]) {
  switch (priority) {
    case "high":
      return "?믪쓬";
    case "medium":
      return "蹂댄넻";
    case "low":
      return "??쓬";
    default:
      return priority;
  }
}

export function getStatusLabel(status: Task["status"]) {
  switch (status) {
    case "in_progress":
      return "吏꾪뻾 以?;
    case "done":
      return "?꾨즺";
    case "todo":
      return "?⑥? ?낅Т";
    default:
      return status;
  }
}

 succeeded in 4038ms:
import { useEffect, useMemo, useState } from "react";
import { RuleBasedAIProvider } from "./ai/RuleBasedAIProvider";
import { useProjectActions } from "./hooks/useProjectActions";
import { useProjectFormState } from "./hooks/useProjectFormState";
import { useTaskActions } from "./hooks/useTaskActions";
import { useTaskFormState } from "./hooks/useTaskFormState";
import { useStore } from "./store";
import { startOfToday } from "./utils/dateUtils";
import { getProjectName } from "./utils/projectLookup";
import { getOverdueTasks, getUpcomingTasks } from "./utils/taskDates";
import { filterTasks, sortTasks, type TaskSortOrder } from "./utils/taskFil
ters";
import { getTaskSummary } from "./utils/taskSummary";
import { SettingsView } from "./views/SettingsView";
import { TasksView } from "./views/TasksView";
import { ProjectsView } from "./views/ProjectsView";
import { TodayView } from "./views/TodayView";
import type { Task } from "./types";
import "./App.css";

type Tab = "today" | "tasks" | "projects" | "settings";

function App() {
  const [activeTab, setActiveTab] = useState<Tab>("today");
  const [recommendedTasks, setRecommendedTasks] = useState<Task[]>([]);
  const [selectedProjectFilter, setSelectedProjectFilter] = useState("all")
;
  const [showCompletedTasks, setShowCompletedTasks] = useState(true);
  const [taskSortOrder, setTaskSortOrder] = useState<TaskSortOrder>("none")
;
  const [taskSearchQuery, setTaskSearchQuery] = useState("");

  const { tasks, projects, appSettings, initializeApp, addTask, updateTask,
 deleteTask, deleteProject, addProject, updateProject } = useStore();
  const taskFormState = useTaskFormState();
  const {
    editingTaskId,
    editTaskTitle,
    editTaskDueDate,
    editTaskPriority,
    editTaskMemo,
    editTaskProjectId,
    newTaskTitle,
    newTaskDueDate,
    newTaskPriority,
    newTaskProjectId,
    newTaskMemo,
    isTaskFormOpen,
    setEditTaskTitle,
    setEditTaskDueDate,
    setEditTaskPriority,
    setEditTaskMemo,
    setEditTaskProjectId,
    setNewTaskTitle,
    setNewTaskDueDate,
    setNewTaskPriority,
    setNewTaskProjectId,
    setNewTaskMemo,
    setIsTaskFormOpen,
    resetNewTaskForm,
    resetEditTaskForm,
    startEditTask,
  } = taskFormState;
  const { handleAddTask, handleSaveEditTask, handleToggleTaskDone, handleDe
leteTask } = useTaskActions({
    addTask,
    updateTask,
    deleteTask,
    newTaskTitle,
    newTaskDueDate,
    newTaskPriority,
    newTaskProjectId,
    newTaskMemo,
    editTaskTitle,
    editTaskDueDate,
    editTaskPriority,
    editTaskMemo,
    editTaskProjectId,
    resetNewTaskForm,
    resetEditTaskForm,
  });
  const projectFormState = useProjectFormState();
  const {
    editingProjectId,
    editProjectName,
    editProjectDescription,
    newProjectName,
    newProjectDescription,
    setEditProjectName,
    setEditProjectDescription,
    setNewProjectName,
    setNewProjectDescription,
    resetNewProjectForm,
    resetEditProjectForm,
    startEditProject,
  } = projectFormState;
  const { handleAddProject, handleSaveEditProject, handleDeleteProject } = 
useProjectActions({
    addProject,
    updateProject,
    deleteProject,
    projects,
    tasks,
    newProjectName,
    newProjectDescription,
    editProjectName,
    editProjectDescription,
    resetNewProjectForm,
    resetEditProjectForm,
  });

  const today = startOfToday();

  const overdueTasks = getOverdueTasks(tasks, today);
  const upcomingTasks = getUpcomingTasks(tasks, today, 7);
  const taskSummary = getTaskSummary(tasks);

  const filteredTasks = filterTasks(tasks, {
    selectedProjectFilter,
    showCompletedTasks,
    taskSearchQuery,
    projects,
  });

  const summaryTasks = filterTasks(tasks, {
    selectedProjectFilter,
    showCompletedTasks: true,
    taskSearchQuery,
    projects,
  });

  const sortedTasks = sortTasks(filteredTasks, taskSortOrder);

  const aiProvider = useMemo(() => new RuleBasedAIProvider(), []);

  useEffect(() => {
    void initializeApp();
  }, [initializeApp]);

  useEffect(() => {
    void aiProvider.suggestTodayTasks(tasks, 3).then(setRecommendedTasks);
  }, [aiProvider, tasks]);

  return (
    <div className="app-shell">
      <header className="app-header">
        <p className="eyebrow">Privacy-first local planner</p>
        <h1>PlanPilot Local</h1>
        <p>?쒕쾭 ?놁씠 ??湲곌린 ?덉뿉 ??λ릺??媛쒖씤 ?쇱젙쨌?낅Т 愿由???/p>
      </header>

      <main className="app-main">
{activeTab === "today" && (
  <TodayView
    totalTasks={taskSummary.totalTasks}
    completedTasks={taskSummary.completedTasks}
    recommendedTasks={recommendedTasks}
    overdueTasks={overdueTasks}
    upcomingTasks={upcomingTasks}
    getProjectName={(projectId) => getProjectName(projects, projectId)}
  />
)}

        {activeTab === "tasks" && (
          <TasksView
            projects={projects}
            filteredTasks={filteredTasks}
            summaryTasks={summaryTasks}
            sortedTasks={sortedTasks}
            selectedProjectFilter={selectedProjectFilter}
            showCompletedTasks={showCompletedTasks}
            taskSortOrder={taskSortOrder}
            taskSearchQuery={taskSearchQuery}
            isTaskFormOpen={isTaskFormOpen}
            newTaskTitle={newTaskTitle}
            newTaskMemo={newTaskMemo}
            newTaskDueDate={newTaskDueDate}
            newTaskPriority={newTaskPriority}
            newTaskProjectId={newTaskProjectId}
            editingTaskId={editingTaskId}
            editTaskTitle={editTaskTitle}
            editTaskMemo={editTaskMemo}
            editTaskDueDate={editTaskDueDate}
            editTaskPriority={editTaskPriority}
            editTaskProjectId={editTaskProjectId}
            getProjectName={(projectId) => getProjectName(projects, project
Id)}
            onTaskSearchQueryChange={setTaskSearchQuery}
            onShowCompletedTasksChange={setShowCompletedTasks}
            onTaskSortOrderChange={setTaskSortOrder}
            onSelectedProjectFilterChange={setSelectedProjectFilter}
            onTaskFormOpenChange={setIsTaskFormOpen}
            onNewTaskTitleChange={setNewTaskTitle}
            onNewTaskMemoChange={setNewTaskMemo}
            onNewTaskDueDateChange={setNewTaskDueDate}
            onNewTaskPriorityChange={setNewTaskPriority}
            onNewTaskProjectIdChange={setNewTaskProjectId}
            onEditTaskTitleChange={setEditTaskTitle}
            onEditTaskMemoChange={setEditTaskMemo}
            onEditTaskDueDateChange={setEditTaskDueDate}
            onEditTaskPriorityChange={setEditTaskPriority}
            onEditTaskProjectIdChange={setEditTaskProjectId}
            onAddTask={handleAddTask}
            onSaveEditTask={handleSaveEditTask}
            onCancelEditTask={resetEditTaskForm}
            onToggleTaskDone={handleToggleTaskDone}
            onDeleteTask={handleDeleteTask}
            onStartEditTask={startEditTask}
          />
        )}

        {activeTab === "projects" && (
          <ProjectsView
            projects={projects}
            tasks={tasks}
            editingProjectId={editingProjectId}
            editProjectName={editProjectName}
            editProjectDescription={editProjectDescription}
            newProjectName={newProjectName}
            newProjectDescription={newProjectDescription}
            onNewProjectNameChange={setNewProjectName}
            onNewProjectDescriptionChange={setNewProjectDescription}
            onEditProjectNameChange={setEditProjectName}
            onEditProjectDescriptionChange={setEditProjectDescription}
            onAddProject={handleAddProject}
            onSaveEditProject={handleSaveEditProject}
            onCancelEditProject={resetEditProjectForm}
            onDeleteProject={handleDeleteProject}
            onStartEditProject={startEditProject}
          />
        )}

        {activeTab === "settings" && (
          <SettingsView
            appSettings={appSettings}
            tasks={tasks}
            projects={projects}
          />
        )}
      </main>

      <nav className="bottom-nav" aria-label="?섎떒 硫붾돱">
        <button
          className={activeTab === "today" ? "active" : ""}
          onClick={() => setActiveTab("today")}
        >
          ?ㅻ뒛
        </button>
        <button
          className={activeTab === "tasks" ? "active" : ""}
          onClick={() => setActiveTab("tasks")}
        >
          ?낅Т
        </button>
        <button
          className={activeTab === "projects" ? "active" : ""}
          onClick={() => setActiveTab("projects")}
        >
          ?꾨줈?앺듃
        </button>
        <button
          className={activeTab === "settings" ? "active" : ""}
          onClick={() => setActiveTab("settings")}
        >
          ?ㅼ젙
        </button>
      </nav>
    </div>
  );
}

export default App;

 succeeded in 3943ms:
import type { AppSettings, Project, Task } from "../types";

const BACKUP_FORMAT = "planpilot-local-backup";
const BACKUP_SCHEMA_VERSION = 1;

const TASK_PRIORITIES: Task["priority"][] = ["low", "medium", "high"];
const TASK_STATUSES: Task["status"][] = ["todo", "in_progress", "done"];

export type BackupValidationSummary = {
  taskCount: number;
  projectCount: number;
  hasAppSettings: boolean;
};

export type BackupValidationResult = {
  valid: boolean;
  errors: string[];
  warnings: string[];
  summary: BackupValidationSummary;
};

type BackupLike = {
  format?: unknown;
  schemaVersion?: unknown;
  exportedAt?: unknown;
  tasks?: unknown;
  projects?: unknown;
  appSettings?: unknown;
};

export function validateBackupData(input: unknown): BackupValidationResult 
{
  const errors: string[] = [];
  const warnings: string[] = [];

  if (!isRecord(input)) {
    return createResult(["諛깆뾽 ?뚯씪??理쒖긽??媛믪? 媛앹껜?ъ빞 ?⑸땲??"], warnings);
  }

  const backup: BackupLike = input;

  validateBackupMetadata(backup, errors);

  const tasks = Array.isArray(backup.tasks) ? backup.tasks : [];
  const projects = Array.isArray(backup.projects) ? backup.projects : [];

  if (!Array.isArray(backup.tasks)) {
    errors.push("tasks??諛곗뿴?댁뼱???⑸땲??");
  }

  if (!Array.isArray(backup.projects)) {
    errors.push("projects??諛곗뿴?댁뼱???⑸땲??");
  }

  if (!isRecord(backup.appSettings)) {
    errors.push("appSettings??媛앹껜?ъ빞 ?⑸땲??");
  }

  validateProjects(projects, errors, warnings);
  validateTasks(tasks, projects, errors);

  if (isRecord(backup.appSettings)) {
    validateAppSettings(backup.appSettings, errors);
  }

  return {
    valid: errors.length === 0,
    errors,
    warnings,
    summary: {
      taskCount: tasks.length,
      projectCount: projects.length,
      hasAppSettings: isRecord(backup.appSettings),
    },
  };
}

function validateBackupMetadata(backup: BackupLike, errors: string[]) {
  if (backup.format !== BACKUP_FORMAT) {
    errors.push(`format? "${BACKUP_FORMAT}"?댁뼱???⑸땲??`);
  }

  if (backup.schemaVersion !== BACKUP_SCHEMA_VERSION) {
    errors.push(`schemaVersion? ${BACKUP_SCHEMA_VERSION}?댁뼱???⑸땲??`);
  }

  if (!isNonEmptyString(backup.exportedAt)) {
    errors.push("exportedAt? 鍮꾩뼱 ?덉? ?딆? 臾몄옄?댁씠?댁빞 ?⑸땲??");
  }
}

function validateTasks(
  tasks: unknown[],
  projects: unknown[],
  errors: string[],
) {
  const projectIds = new Set(
    projects.filter(isRecord).map((project) => project.id).filter(isString)
,
  );
  const taskIds = new Set<string>();

  tasks.forEach((task, index) => {
    const label = `tasks[${index}]`;

    if (!isRecord(task)) {
      errors.push(`${label}??媛앹껜?ъ빞 ?⑸땲??`);
      return;
    }

    validateRequiredString(task, "id", label, errors);
    validateRequiredString(task, "title", label, errors);
    validateRequiredString(task, "projectId", label, errors);
    validateRequiredString(task, "createdAt", label, errors);
    validateRequiredString(task, "updatedAt", label, errors);

    if (!TASK_PRIORITIES.includes(task.priority as Task["priority"])) {
      errors.push(`${label}.priority??low, medium, high 以??섎굹?ъ빞 ?⑸땲??`);
    }

    if (!TASK_STATUSES.includes(task.status as Task["status"])) {
      errors.push(`${label}.status??todo, in_progress, done 以??섎굹?ъ빞 ?⑸땲??`
);
    }

    if (!Array.isArray(task.tags)) {
      errors.push(`${label}.tags??諛곗뿴?댁뼱???⑸땲??`);
    }

    validateOptionalString(task, "dueDate", label, errors);
    validateOptionalString(task, "completedAt", label, errors);

    if (isString(task.id)) {
      if (taskIds.has(task.id)) {
        errors.push(`${label}.id媛 諛깆뾽 ?뚯씪 ?덉뿉??以묐났?섏뿀?듬땲??`);
      }
      taskIds.add(task.id);
    }

    if (isString(task.projectId) && !projectIds.has(task.projectId)) {
      errors.push(`${label}.projectId媛 諛깆뾽 ?뚯씪??projects??議댁옱?섏? ?딆뒿?덈떎.`)
;
    }
  });
}

function validateProjects(projects: unknown[], errors: string[], warnings: 
string[]) {
  const projectIds = new Set<string>();

  projects.forEach((project, index) => {
    const label = `projects[${index}]`;

    if (!isRecord(project)) {
      errors.push(`${label}??媛앹껜?ъ빞 ?⑸땲??`);
      return;
    }

    validateRequiredString(project, "id", label, errors);
    validateRequiredString(project, "name", label, errors);
    validateRequiredString(project, "createdAt", label, errors);
    validateRequiredString(project, "updatedAt", label, errors);

    validateOptionalString(project, "description", label, errors);
    validateOptionalString(project, "color", label, errors);
    validateOptionalString(project, "archivedAt", label, errors);

    if (isString(project.id)) {
      if (projectIds.has(project.id)) {
        errors.push(`${label}.id媛 諛깆뾽 ?뚯씪 ?덉뿉??以묐났?섏뿀?듬땲??`);
      }
      projectIds.add(project.id);
    }
  });

  if (!projectIds.has("default")) {
    warnings.push("諛깆뾽 ?뚯씪??湲곕낯 ?꾨줈?앺듃媛 ?놁뼱 蹂듭썝 ???뺤콉 ?뺤씤???꾩슂?⑸땲??");
  }
}

function validateAppSettings(settings: Record<string, unknown>, errors: str
ing[]) {
  if (settings.theme !== "light") {
    errors.push('appSettings.theme? "light"?ъ빞 ?⑸땲??');
  }

  if (settings.language !== "ko") {
    errors.push('appSettings.language??"ko"?ъ빞 ?⑸땲??');
  }

  if (settings.aiProvider !== "rule_based") {
    errors.push('appSettings.aiProvider??"rule_based"?ъ빞 ?⑸땲??');
  }

  if (settings.enableNotifications !== false) {
    errors.push("appSettings.enableNotifications??false?ъ빞 ?⑸땲??");
  }

  if (typeof settings.firstLaunchCompleted !== "boolean") {
    errors.push("appSettings.firstLaunchCompleted??boolean?댁뼱???⑸땲??");
  }

  validateRequiredString(settings, "createdAt", "appSettings", errors);
  validateRequiredString(settings, "updatedAt", "appSettings", errors);
}

function validateRequiredString(
  record: Record<string, unknown>,
  key: keyof (Task & Project & AppSettings),
  label: string,
  errors: string[],
) {
  if (!isString(record[key])) {
    errors.push(`${label}.${String(key)}??臾몄옄?댁씠?댁빞 ?⑸땲??`);
  }
}

function validateOptionalString(
  record: Record<string, unknown>,
  key: keyof (Task & Project),
  label: string,
  errors: string[],
) {
  if (record[key] !== undefined && !isString(record[key])) {
    errors.push(`${label}.${String(key)}??臾몄옄?댁씠?댁빞 ?⑸땲??`);
  }
}

function createResult(errors: string[], warnings: string[]): BackupValidati
onResult {
  return {
    valid: false,
    errors,
    warnings,
    summary: {
      taskCount: 0,
      projectCount: 0,
      hasAppSettings: false,
    },
  };
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(valu
e);
}

function isString(value: unknown): value is string {
  return typeof value === "string";
}

function isNonEmptyString(value: unknown): value is string {
  return isString(value) && value.trim().length > 0;
}

codex
필요한 구조는 확인했습니다. 마지막으로 라인 번호 기준으로 근거를 정리하기 위해 핵심 파일의 관련 위치만 다시 조회하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Select-String -Path src\\db.ts -Pattern \"version|tasks:\"" in D:\ai-apps\p
lanpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Select-String -Path src\\types.ts -Pattern \"export type Task|status:|estim
atedMinutes|sortOrder\"" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Select-String -Path src\\store.ts -Pattern \"tasks: Task\\[\\]|fetchTasks|a
ddTask|updateTask|status: input.status|completedAt|db.tasks\"" in D:\ai-app
s\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Select-String -Path src\\hooks\\useTaskActions.ts -Pattern \"handleToggleTa
skDone|nextStatus|updateTask\"" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Select-String -Path src\\views\\TasksView.tsx -Pattern \"inProgressTaskCoun
t|remainingTaskCount|sortedTasks.map|TaskCard|onToggleTaskDone\"" in D:\ai-
apps\planpilot-local
 succeeded in 3685ms:

src\types.ts:3:export type Task = {
src\types.ts:9:  status: "todo" | "in_progress" | "done";
src\types.ts:12:  estimatedMinutes?: number;
src\types.ts:16:  sortOrder?: number;



 succeeded in 3793ms:

src\store.ts:16:  tasks: Task[];
src\store.ts:23:  fetchTasks: () => Promise<void>;
src\store.ts:26:  addTask: (input: CreateTaskInput) => Promise<void>;
src\store.ts:27:  updateTask: (task: Task) => Promise<void>;
src\store.ts:73:    await get().fetchTasks();
src\store.ts:77:  fetchTasks: async () => {
src\store.ts:78:    const tasks = await db.tasks.toArray();
src\store.ts:100:  addTask: async (input) => {
src\store.ts:107:      status: input.status ?? "todo",
src\store.ts:119:    await db.tasks.add(task);
src\store.ts:122:  updateTask: async (task) => {
src\store.ts:129:      updatedTask.completedAt = updatedTask.completedAt ||
 new Date().toISOString();
src\store.ts:131:      delete updatedTask.completedAt;
src\store.ts:134:    await db.tasks.put(updatedTask);
src\store.ts:140:    await db.tasks.delete(taskId);



 succeeded in 3840ms:

src\db.ts:14:    this.version(1).stores({
src\db.ts:15:      tasks: "id,projectId,status,sortOrder",



 succeeded in 3714ms:

src\hooks\useTaskActions.ts:12:  updateTask: (task: Task) => Promise<void>;
src\hooks\useTaskActions.ts:35:  updateTask,
src\hooks\useTaskActions.ts:75:    void updateTask({
src\hooks\useTaskActions.ts:86:  function handleToggleTaskDone(task: Task) 
{
src\hooks\useTaskActions.ts:87:    const nextStatus = task.status === "done
" ? "todo" : "done";
src\hooks\useTaskActions.ts:88:    void updateTask({ ...task, status: nextS
tatus });
src\hooks\useTaskActions.ts:100:    handleToggleTaskDone,



 succeeded in 3793ms:

src\views\TasksView.tsx:2:import { TaskCard } from "../components/TaskCard"
;
src\views\TasksView.tsx:47:  onToggleTaskDone: (task: Task) => void;
src\views\TasksView.tsx:92:  onToggleTaskDone,
src\views\TasksView.tsx:102:  const inProgressTaskCount = summaryTasks.filt
er(
src\views\TasksView.tsx:105:  const remainingTaskCount = summaryTasks.filte
r(
src\views\TasksView.tsx:135:        {totalTaskSummary} · 진행 중 {inProgressTa
skCount}개 ·{" "}
src\views\TasksView.tsx:136:        {completedTaskSummary} · 남은 업무 {remaini
ngTaskCount}개
src\views\TasksView.tsx:220:          {sortedTasks.map((task) => {
src\views\TasksView.tsx:251:              <TaskCard
src\views\TasksView.tsx:255:                onToggleDone={onToggleTaskDone}



exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Select-String -Path src\\utils\\taskLabels.ts -Pattern \"getStatusLabel|in_
progress\"" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Select-String -Path src\\views\\TodayView.tsx -Pattern \"recommendedTasks|o
verdueTasks|upcomingTasks|map\"" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Select-String -Path src\\ai\\RuleBasedAIProvider.ts -Pattern \"suggestToday
Tasks|status "'!==|slice"' in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Select-String -Path src\\utils\\taskFilters.ts -Pattern \"showCompletedTask
s|matchesStatus|sortTasks\"" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Select-String -Path src\\utils\\importValidation.ts -Pattern \"TASK_STATUSE
S|in_progress\"" in D:\ai-apps\planpilot-local
 succeeded in 3818ms:

src\views\TodayView.tsx:7:  recommendedTasks: Task[];
src\views\TodayView.tsx:8:  overdueTasks: Task[];
src\views\TodayView.tsx:9:  upcomingTasks: Task[];
src\views\TodayView.tsx:16:  recommendedTasks,
src\views\TodayView.tsx:17:  overdueTasks,
src\views\TodayView.tsx:18:  upcomingTasks,
src\views\TodayView.tsx:27:        지난 마감 업무 수: {overdueTasks.length}개<br />
src\views\TodayView.tsx:28:        7일 이내 마감 업무 수: {upcomingTasks.length}개
src\views\TodayView.tsx:30:      <p className="summary">추천 업무 {recommendedT
asks.length}개</p>
src\views\TodayView.tsx:32:      {recommendedTasks.length === 0 ? (
src\views\TodayView.tsx:36:          {recommendedTasks.map((task) => (
src\views\TodayView.tsx:50:      {overdueTasks.length === 0 ? (
src\views\TodayView.tsx:54:          {overdueTasks.map((task) => (
src\views\TodayView.tsx:67:      {upcomingTasks.length === 0 ? (
src\views\TodayView.tsx:71:          {upcomingTasks.map((task) => (



 succeeded in 3848ms:

src\ai\RuleBasedAIProvider.ts:13:  async suggestTodayTasks(tasks: Task[], l
imit = 3): Promise<Task[]> {
src\ai\RuleBasedAIProvider.ts:15:      .filter(task => task.status !== "don
e")
src\ai\RuleBasedAIProvider.ts:18:    return filteredTasks.slice(0, limit);



 succeeded in 3875ms:

src\utils\importValidation.ts:7:const TASK_STATUSES: Task["status"][] = ["t
odo", "in_progress", "done"];
src\utils\importValidation.ts:119:    if (!TASK_STATUSES.includes(task.stat
us as Task["status"])) {
src\utils\importValidation.ts:120:      errors.push(`${label}.status는 todo,
 in_progress, done 중 하나여야 합니다.`);



 succeeded in 4004ms:

src\utils\taskLabels.ts:16:export function getStatusLabel(status: Task["sta
tus"]) {
src\utils\taskLabels.ts:18:    case "in_progress":



 succeeded in 4028ms:

src\utils\taskFilters.ts:7:  showCompletedTasks: boolean;
src\utils\taskFilters.ts:16:    showCompletedTasks,
src\utils\taskFilters.ts:38:    const matchesStatus = showCompletedTasks ||
 task.status !== "done";
src\utils\taskFilters.ts:40:    return matchesProject && matchesSearch && m
atchesStatus;
src\utils\taskFilters.ts:44:export function sortTasks(tasks: Task[], taskSo
rtOrder: TaskSortOrder) {



codex
변경한 파일: 없음.

분석 결과, 현재 구조는 “여러 task가 동시에 `in_progress` 상태일 수 있는가”라는 의미의 병렬 task 개념을 데이터 
차원에서 이미 수용할 수 있습니다. [types.ts](D:/ai-apps/planpilot-local/src/types.ts:9)에 
`todo | in_progress | done` 상태가 있고, [store.ts](D:/ai-apps/planpilot-local/s
rc/store.ts:16)는 task를 배열로 관리하며 [updateTask](D:/ai-apps/planpilot-local/src
/store.ts:122)에서 단일 진행 task만 허용하는 제약을 두지 않습니다. Dexie schema도 [db.ts](D:/ai-
apps/planpilot-local/src/db.ts:15)에서 `status` 인덱스를 가지고 있어 상태 기반 조회 확장 여지도 있
습니다.

다만 화면 흐름은 아직 병렬 “실행” 기능이라고 보기 어렵습니다. [TasksView.tsx](D:/ai-apps/planpilot-l
ocal/src/views/TasksView.tsx:102)는 `in_progress` 개수를 계산해 표시하지만, [useTaskAct
ions.ts](D:/ai-apps/planpilot-local/src/hooks/useTaskActions.ts:86)의 액션은 `d
one`/`todo` 토글뿐이라 사용자가 task를 `in_progress`로 전환하는 경로가 없습니다. [TodayView.tsx](
D:/ai-apps/planpilot-local/src/views/TodayView.tsx:36)는 추천/마감 목록을 여러 개 표시하지
만 읽기 전용입니다.

즉시 구현 가능한 작은 후속 작업:
- task 카드에 “진행 시작 / 대기 전환 / 완료” 같은 상태 변경 액션 추가
- `handleToggleTaskDone`을 범용 `handleChangeTaskStatus(task, status)` 흐름으로 작게
 확장
- `TasksView`에 `in_progress` task를 별도 필터 또는 섹션으로 표시

보류해야 할 항목:
- `startedAt`, `activeSessionId`, 동시 실행 순서, 타이머 등 새 필드 추가
- Dexie schema version 증가와 마이그레이션
- Today 화면 전면 재구성
- 알림, 백그라운드 실행, 실제 병렬 처리 엔진

검증은 관련 타입, store, DB schema, task action, Tasks/Today 렌더링 흐름을 읽어서 수행했습니다. `
npm run build`, `npm run lint`, `npm run test`는 프롬프트가 요구하지 않았고 사용자 허용도 없어서 
실행하지 않았습니다.

남은 위험: 일부 소스의 한국어 문자열이 도구 출력에서 깨져 보입니다. 이번 분석 범위와 직접 충돌하지는 않지만, 후속 UI 문구 수정
 시 인코딩 확인이 필요합니다.

다음 task로 넘어가도 됩니다. 데이터 구조 변경 없이 “진행 중 상태로 바꾸는 최소 UI/액션 추가”를 다음 작은 작업으로 잡는 것
이 적절합니다.

`.ai-dev/loop-log.md`에 기록할 작업 요약:
`T001 현재 task 흐름 검토 완료. Task 타입은 todo/in_progress/done을 이미 지원하고, store/Inde
xedDB는 여러 in_progress task를 제한하지 않는다. 화면은 여러 task 표시와 in_progress 카운트는 가능하지
만, 사용자가 in_progress로 전환하는 액션이 없어 병렬 실행 UI는 아직 미구현 상태다. 다음 작업은 DB 변경 없이 상태 변
경 액션과 최소 UI를 추가하는 방향이 적절하다.`
tokens used
59,162
변경한 파일: 없음.

분석 결과, 현재 구조는 “여러 task가 동시에 `in_progress` 상태일 수 있는가”라는 의미의 병렬 task 개념을 데이터 차원에서 이미 수용할 수 있습니다. [types.ts](D:/ai-apps/planpilot-local/src/types.ts:9)에 `todo | in_progress | done` 상태가 있고, [store.ts](D:/ai-apps/planpilot-local/src/store.ts:16)는 task를 배열로 관리하며 [updateTask](D:/ai-apps/planpilot-local/src/store.ts:122)에서 단일 진행 task만 허용하는 제약을 두지 않습니다. Dexie schema도 [db.ts](D:/ai-apps/planpilot-local/src/db.ts:15)에서 `status` 인덱스를 가지고 있어 상태 기반 조회 확장 여지도 있습니다.

다만 화면 흐름은 아직 병렬 “실행” 기능이라고 보기 어렵습니다. [TasksView.tsx](D:/ai-apps/planpilot-local/src/views/TasksView.tsx:102)는 `in_progress` 개수를 계산해 표시하지만, [useTaskActions.ts](D:/ai-apps/planpilot-local/src/hooks/useTaskActions.ts:86)의 액션은 `done`/`todo` 토글뿐이라 사용자가 task를 `in_progress`로 전환하는 경로가 없습니다. [TodayView.tsx](D:/ai-apps/planpilot-local/src/views/TodayView.tsx:36)는 추천/마감 목록을 여러 개 표시하지만 읽기 전용입니다.

즉시 구현 가능한 작은 후속 작업:
- task 카드에 “진행 시작 / 대기 전환 / 완료” 같은 상태 변경 액션 추가
- `handleToggleTaskDone`을 범용 `handleChangeTaskStatus(task, status)` 흐름으로 작게 확장
- `TasksView`에 `in_progress` task를 별도 필터 또는 섹션으로 표시

보류해야 할 항목:
- `startedAt`, `activeSessionId`, 동시 실행 순서, 타이머 등 새 필드 추가
- Dexie schema version 증가와 마이그레이션
- Today 화면 전면 재구성
- 알림, 백그라운드 실행, 실제 병렬 처리 엔진

검증은 관련 타입, store, DB schema, task action, Tasks/Today 렌더링 흐름을 읽어서 수행했습니다. `npm run build`, `npm run lint`, `npm run test`는 프롬프트가 요구하지 않았고 사용자 허용도 없어서 실행하지 않았습니다.

남은 위험: 일부 소스의 한국어 문자열이 도구 출력에서 깨져 보입니다. 이번 분석 범위와 직접 충돌하지는 않지만, 후속 UI 문구 수정 시 인코딩 확인이 필요합니다.

다음 task로 넘어가도 됩니다. 데이터 구조 변경 없이 “진행 중 상태로 바꾸는 최소 UI/액션 추가”를 다음 작은 작업으로 잡는 것이 적절합니다.

`.ai-dev/loop-log.md`에 기록할 작업 요약:
`T001 현재 task 흐름 검토 완료. Task 타입은 todo/in_progress/done을 이미 지원하고, store/IndexedDB는 여러 in_progress task를 제한하지 않는다. 화면은 여러 task 표시와 in_progress 카운트는 가능하지만, 사용자가 in_progress로 전환하는 액션이 없어 병렬 실행 UI는 아직 미구현 상태다. 다음 작업은 DB 변경 없이 상태 변경 액션과 최소 UI를 추가하는 방향이 적절하다.`

```