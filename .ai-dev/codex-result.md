# Codex Implementation Result

## Run

- Started at: 2026-06-14 23:26:13
- Ended at: 2026-06-14 23:27:25
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
session id: 019ec686-a76a-7d80-b42f-79651f541582
--------
user
Read and follow the full task prompt at this absolute file path: D:\ai-apps\planpilot-local\.ai-dev\
current-task-prompt.md
codex
작업 프롬프트를 직접 읽어 요구사항과 수정 범위를 확인하겠습니다. 아직 파일 수정이나 빌드/테스트는 실행하지 않습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\.ai-dev\\current-task-prompt.md'" in D:\ai-apps\planpilot-local
 succeeded in 962ms:
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
업무 카드의 보조 안내 문구 또는 aria-label을 더 자연스러운 한국어로 미세 개선한다.

## 배경
현재 업무 카드에 표시되거나 보조 기술에 전달되는 일부 안내 문구가 다소 어색할 수 있다. 기능 동작은 유지하면서 사용자-facing 문구만 작게 다듬는다.

## 성공 기준
- 업무 카드 관련 보조 안내 문구 또는 aria-label이 자연스러운 한국어로 개선된다.
- 기능 로직, 상태 관리, 저장 구조는 변경하지 않는다.
- 변경 범위는 UI 문구 수준의 최소 수정으로 제한한다.
- 기존 JSX 구조를 중복 생성하지 않는다.

## 제약사항
- 기본적으로 한 파일만 수정한다.
- src/App.css는 수정하지 않는다.
- localStorage를 사용하지 않는다.
- IndexedDB/Dexie schema는 변경하지 않는다.
- 빌드와 lint는 사용자 허용이 있을 때만 실행한다.

## 범위 제외
- 새 기능 추가
- 화면 구조 개편
- 상태 관리 변경
- 데이터 모델 변경
- 알림 기능 추가

## 수동 검증
- 업무 카드가 표시되는 화면에서 안내 문구가 자연스럽게 보이는지 확인한다.
- 버튼 또는 카드의 aria-label이 문맥에 맞는 한국어인지 확인한다.
- 기존 업무 카드 동작이 그대로 유지되는지 확인한다.

## Current Task

- Task ID: T001
- Title: 업무 카드 문구 확인 및 최소 수정
- Description: 업무 카드의 보조 안내 문구와 aria-label을 확인하고, 기능 로직을 바꾸지 않는 범위에서 자연스러운 한국어로 미세 조정한다.
- Type: implementation
- Status: in_progress
- Priority: P1
- Depends on:
- 없음

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

- src/App.tsx

## Verification

- 변경된 문구가 업무 카드 문맥에 자연스럽게 맞는지 확인한다.
- 기능 로직이나 데이터 저장 관련 코드가 변경되지 않았는지 확인한다.

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
요구사항은 `src/App.tsx`의 업무 카드 관련 문구만 최소 수정하는 것입니다. 이제 해당 파일에서 업무 카드와 `aria-label` 문구가 있는 위치만 찾아 확인하겠습니다
.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'rg -n "aria-label|업무|카드|t
ask|Task|완료|삭제|수정" src/App.tsx' in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\src\\App.tsx' -TotalCount 240" in D:\ai-apps\planpilot-local
 succeeded in 1272ms:
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
import { filterTasks, sortTasks, type TaskSortOrder } from "./utils/taskFilters";
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
  const [selectedProjectFilter, setSelectedProjectFilter] = useState("all");
  const [showCompletedTasks, setShowCompletedTasks] = useState(true);
  const [taskSortOrder, setTaskSortOrder] = useState<TaskSortOrder>("none");
  const [taskSearchQuery, setTaskSearchQuery] = useState("");

  const { tasks, projects, appSettings, initializeApp, addTask, updateTask, deleteTask, deleteProjec
t, addProject, updateProject } = useStore();
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
  const { handleAddTask, handleSaveEditTask, handleToggleTaskDone, handleDeleteTask } = useTaskActio
ns({
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
  const { handleAddProject, handleSaveEditProject, handleDeleteProject } = useProjectActions({
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
        <p>?쒕쾭 ?놁씠 濡쒖뺄????λ릺??媛쒖씤 ?쇱젙쨌?낅Т 愿由???/p>
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
            getProjectName={(projectId) => getProjectName(projects, projectId)}
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

 succeeded in 1517ms:
5:import { useTaskActions } from "./hooks/useTaskActions";
6:import { useTaskFormState } from "./hooks/useTaskFormState";
10:import { getOverdueTasks, getUpcomingTasks } from "./utils/taskDates";
11:import { filterTasks, sortTasks, type TaskSortOrder } from "./utils/taskFilters";
12:import { getTaskSummary } from "./utils/taskSummary";
14:import { TasksView } from "./views/TasksView";
17:import type { Task } from "./types";
20:type Tab = "today" | "tasks" | "projects" | "settings";
24:  const [recommendedTasks, setRecommendedTasks] = useState<Task[]>([]);
26:  const [showCompletedTasks, setShowCompletedTasks] = useState(true);
27:  const [taskSortOrder, setTaskSortOrder] = useState<TaskSortOrder>("none");
28:  const [taskSearchQuery, setTaskSearchQuery] = useState("");
30:  const { tasks, projects, appSettings, initializeApp, addTask, updateTask, deleteTask, deletePro
ject, addProject, updateProject } = useStore();
31:  const taskFormState = useTaskFormState();
33:    editingTaskId,
34:    editTaskTitle,
35:    editTaskDueDate,
36:    editTaskPriority,
37:    editTaskMemo,
38:    editTaskProjectId,
39:    newTaskTitle,
40:    newTaskDueDate,
41:    newTaskPriority,
42:    newTaskProjectId,
43:    newTaskMemo,
44:    isTaskFormOpen,
45:    setEditTaskTitle,
46:    setEditTaskDueDate,
47:    setEditTaskPriority,
48:    setEditTaskMemo,
49:    setEditTaskProjectId,
50:    setNewTaskTitle,
51:    setNewTaskDueDate,
52:    setNewTaskPriority,
53:    setNewTaskProjectId,
54:    setNewTaskMemo,
55:    setIsTaskFormOpen,
56:    resetNewTaskForm,
57:    resetEditTaskForm,
58:    startEditTask,
59:  } = taskFormState;
60:  const { handleAddTask, handleSaveEditTask, handleToggleTaskDone, handleDeleteTask } = useTaskAc
tions({
61:    addTask,
62:    updateTask,
63:    deleteTask,
64:    newTaskTitle,
65:    newTaskDueDate,
66:    newTaskPriority,
67:    newTaskProjectId,
68:    newTaskMemo,
69:    editTaskTitle,
70:    editTaskDueDate,
71:    editTaskPriority,
72:    editTaskMemo,
73:    editTaskProjectId,
74:    resetNewTaskForm,
75:    resetEditTaskForm,
97:    tasks,
108:  const overdueTasks = getOverdueTasks(tasks, today);
109:  const upcomingTasks = getUpcomingTasks(tasks, today, 7);
110:  const taskSummary = getTaskSummary(tasks);
112:  const filteredTasks = filterTasks(tasks, {
114:    showCompletedTasks,
115:    taskSearchQuery,
119:  const sortedTasks = sortTasks(filteredTasks, taskSortOrder);
128:    void aiProvider.suggestTodayTasks(tasks, 3).then(setRecommendedTasks);
129:  }, [aiProvider, tasks]);
136:        <p>서버 없이 로컬에 저장되는 개인 일정·업무 관리 앱</p>
142:    totalTasks={taskSummary.totalTasks}
143:    completedTasks={taskSummary.completedTasks}
144:    recommendedTasks={recommendedTasks}
145:    overdueTasks={overdueTasks}
146:    upcomingTasks={upcomingTasks}
151:        {activeTab === "tasks" && (
152:          <TasksView
154:            filteredTasks={filteredTasks}
155:            sortedTasks={sortedTasks}
157:            showCompletedTasks={showCompletedTasks}
158:            taskSortOrder={taskSortOrder}
159:            taskSearchQuery={taskSearchQuery}
160:            isTaskFormOpen={isTaskFormOpen}
161:            newTaskTitle={newTaskTitle}
162:            newTaskMemo={newTaskMemo}
163:            newTaskDueDate={newTaskDueDate}
164:            newTaskPriority={newTaskPriority}
165:            newTaskProjectId={newTaskProjectId}
166:            editingTaskId={editingTaskId}
167:            editTaskTitle={editTaskTitle}
168:            editTaskMemo={editTaskMemo}
169:            editTaskDueDate={editTaskDueDate}
170:            editTaskPriority={editTaskPriority}
171:            editTaskProjectId={editTaskProjectId}
173:            onTaskSearchQueryChange={setTaskSearchQuery}
174:            onShowCompletedTasksChange={setShowCompletedTasks}
175:            onTaskSortOrderChange={setTaskSortOrder}
177:            onTaskFormOpenChange={setIsTaskFormOpen}
178:            onNewTaskTitleChange={setNewTaskTitle}
179:            onNewTaskMemoChange={setNewTaskMemo}
180:            onNewTaskDueDateChange={setNewTaskDueDate}
181:            onNewTaskPriorityChange={setNewTaskPriority}
182:            onNewTaskProjectIdChange={setNewTaskProjectId}
183:            onEditTaskTitleChange={setEditTaskTitle}
184:            onEditTaskMemoChange={setEditTaskMemo}
185:            onEditTaskDueDateChange={setEditTaskDueDate}
186:            onEditTaskPriorityChange={setEditTaskPriority}
187:            onEditTaskProjectIdChange={setEditTaskProjectId}
188:            onAddTask={handleAddTask}
189:            onSaveEditTask={handleSaveEditTask}
190:            onCancelEditTask={resetEditTaskForm}
191:            onToggleTaskDone={handleToggleTaskDone}
192:            onDeleteTask={handleDeleteTask}
193:            onStartEditTask={startEditTask}
200:            tasks={tasks}
221:            tasks={tasks}
227:      <nav className="bottom-nav" aria-label="하단 메뉴">
235:          className={activeTab === "tasks" ? "active" : ""}
236:          onClick={() => setActiveTab("tasks")}
238:          업무

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\src\\App.tsx' | Select-Object -Skip 240 -First 120" in D:\ai-apps\pla
npilot-local
 succeeded in 977ms:
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

codex
`App.tsx`는 업무 화면에 props를 전달할 뿐이고, 실제 업무 카드 문구는 분리된 `TasksView`에 있을 가능성이 큽니다. 문구만 최소 수정하려면 실제 렌더링 파일을
 확인해야 해서 `src/views/TasksView.tsx`를 읽겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'rg -n "aria-label|업무|카드|완
료|삭제|수정|메모|마감|없습니다|task" src/views/TasksView.tsx' in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\src\\views\\TasksView.tsx' -TotalCount 260" in D:\ai-apps\planpilot-l
ocal
 succeeded in 1315ms:
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

 succeeded in 1497ms:
5:import type { TaskSortOrder } from "../utils/taskFilters";
13:  taskSortOrder: TaskSortOrder;
14:  taskSearchQuery: string;
44:  onSaveEditTask: (task: Task) => void;
46:  onToggleTaskDone: (task: Task) => void;
47:  onDeleteTask: (task: Task) => void;
48:  onStartEditTask: (task: Task) => void;
57:  taskSortOrder,
58:  taskSearchQuery,
94:  const hasSearchQuery = taskSearchQuery.trim().length > 0;
99:      ? "검색어와 일치하는 업무가 없어요."
101:        ? "현재 조건에 맞는 업무가 없어요."
102:        : "아직 등록된 업무가 없어요.";
106:      <h2>전체 업무</h2>
110:        업무 검색
113:          value={taskSearchQuery}
115:          placeholder="업무 제목 또는 메모 내용을 검색하세요"
125:        완료 업무 표시
131:          value={taskSortOrder}
137:          <option value="dueDateAsc">마감일 빠른 순</option>
160:        {isTaskFormOpen ? "새 업무 추가 닫기" : "새 업무 추가"}
165:          title="새 업무 추가"
166:          ariaLabel="업무 추가"
167:          taskTitle={newTaskTitle}
173:          submitLabel="업무 추가"
189:        <ul className="task-list">
190:          {sortedTasks.map((task) => {
191:            if (editingTaskId === task.id) {
193:                <li key={task.id} className="task-card">
195:                    title="업무 수정"
196:                    ariaLabel="업무 수정"
197:                    taskTitle={editTaskTitle}
211:                      onSaveEditTask(task);
222:                key={task.id}
223:                task={task}
224:                projectName={getProjectName(task.projectId)}

codex
`TasksView`는 업무 목록의 빈 상태와 폼 문구를 포함하고 있지만, 카드 자체의 버튼 `aria-label`은 `TaskCard` 컴포넌트에 있습니다. 업무 카드 범위를 정
확히 잡기 위해 `src/components/TaskCard.tsx`만 추가로 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'rg -n "aria-label|완료|삭제|수
정|메모|마감|프로젝트|없음|button|task" src/components/TaskCard.tsx' in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\src\\components\\TaskCard.tsx'" in D:\ai-apps\planpilot-local
 succeeded in 1290ms:
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
          aria-label="留덇컧?쇱씠 媛源뚯슫 ?낅Т"
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
        以묒슂?? {getPriorityLabel(task.priority)} 쨌 ?곹깭: {getStatusLabel(task.status)} 쨌 ?꾨줈?앺듃: {proj
ectName}
      </span>
      <span>{task.dueDate ? `留덇컧?? ${task.dueDate}` : "留덇컧???놁쓬"}</span>
      <button
        type="button"
        aria-label={
          task.status === "done"
            ? `${task.title} ?낅Т ?꾨즺 痍⑥냼`
            : `${task.title} ?낅Т ?꾨즺 泥섎━`
        }
        onClick={() => onToggleDone(task)}
      >
        {task.status === "done" ? "?꾨즺 痍⑥냼" : "?꾨즺 泥섎━"}
      </button>
      <button
        type="button"
        aria-label={`${task.title} ?낅Т ??젣`}
        onClick={() => onDelete(task)}
      >
        ??젣
      </button>
      <button
        type="button"
        aria-label={`${task.title} ?낅Т ?섏젙`}
        onClick={() => onStartEdit(task)}
      >
        ?섏젙
      </button>
    </li>
  );
}

 succeeded in 1532ms:
1:import { getPriorityLabel, getStatusLabel } from "../utils/taskLabels";
6:  task: Task;
8:  onToggleDone: (task: Task) => void;
9:  onDelete: (task: Task) => void;
10:  onStartEdit: (task: Task) => void;
14:  task,
20:  const showDueSoonBadge = isUpcomingTask(task);
23:    <li className="task-card">
24:      <strong>{task.title}</strong>
27:          aria-label="마감일이 가까운 업무"
38:          마감 임박
41:      {task.memo && <span>메모: {task.memo}</span>}
43:        중요도: {getPriorityLabel(task.priority)} · 상태: {getStatusLabel(task.status)} · 프로젝트: {proje
ctName}
45:      <span>{task.dueDate ? `마감일: ${task.dueDate}` : "마감일 없음"}</span>
46:      <button
47:        type="button"
48:        aria-label={
49:          task.status === "done"
50:            ? `${task.title} 업무 완료 취소`
51:            : `${task.title} 업무 완료 처리`
53:        onClick={() => onToggleDone(task)}
55:        {task.status === "done" ? "완료 취소" : "완료 처리"}
56:      </button>
57:      <button
58:        type="button"
59:        aria-label={`${task.title} 업무 삭제`}
60:        onClick={() => onDelete(task)}
62:        삭제
63:      </button>
64:      <button
65:        type="button"
66:        aria-label={`${task.title} 업무 수정`}
67:        onClick={() => onStartEdit(task)}
69:        수정
70:      </button>

codex
실제 수정 대상은 `src/components/TaskCard.tsx`입니다. 기능 로직은 그대로 두고, 카드 배지와 버튼의 표시 문구 및 `aria-label`만 더 자연스럽게 
조정하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\src\\components\\TaskCard.tsx' -Encoding UTF8" in D:\ai-apps\planpilo
t-local
 succeeded in 960ms:
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
          aria-label="마감일이 가까운 업무"
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
        중요도: {getPriorityLabel(task.priority)} · 상태: {getStatusLabel(task.status)} · 프로젝트: {projectN
ame}
      </span>
      <span>{task.dueDate ? `마감일: ${task.dueDate}` : "마감일 없음"}</span>
      <button
        type="button"
        aria-label={
          task.status === "done"
            ? `${task.title} 업무 완료 취소`
            : `${task.title} 업무 완료 처리`
        }
        onClick={() => onToggleDone(task)}
      >
        {task.status === "done" ? "완료 취소" : "완료 처리"}
      </button>
      <button
        type="button"
        aria-label={`${task.title} 업무 삭제`}
        onClick={() => onDelete(task)}
      >
        삭제
      </button>
      <button
        type="button"
        aria-label={`${task.title} 업무 수정`}
        onClick={() => onStartEdit(task)}
      >
        수정
      </button>
    </li>
  );
}

codex
카드의 보조 문구만 바꿉니다: 마감 배지 설명을 더 구체적으로 만들고, 완료 토글/삭제/수정 버튼의 `aria-label`을 한국어 동작 표현으로 다듬겠습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\src\components\TaskCard.tsx
diff --git a/src/components/TaskCard.tsx b/src/components/TaskCard.tsx
index d9d377f66ac54d544c272f2073c134ebe2a57bb3..aff165e7788f4b45f447011d8af645cf5ca54e42
--- a/src/components/TaskCard.tsx
+++ b/src/components/TaskCard.tsx
@@ -24,7 +24,7 @@
       <strong>{task.title}</strong>
       {showDueSoonBadge && (
         <span
-          aria-label="마감일이 가까운 업무"
+          aria-label="마감일이 곧 다가오는 업무"
           style={{
             alignSelf: "flex-start",
             border: "1px solid #d97706",
@@ -47,23 +47,23 @@
         type="button"
         aria-label={
           task.status === "done"
-            ? `${task.title} 업무 완료 취소`
-            : `${task.title} 업무 완료 처리`
+            ? `${task.title} 업무를 미완료로 되돌리기`
+            : `${task.title} 업무를 완료로 표시하기`
         }
         onClick={() => onToggleDone(task)}
       >
-        {task.status === "done" ? "완료 취소" : "완료 처리"}
+        {task.status === "done" ? "미완료로 되돌리기" : "완료로 표시"}
       </button>
       <button
         type="button"
-        aria-label={`${task.title} 업무 삭제`}
+        aria-label={`${task.title} 업무 삭제하기`}
         onClick={() => onDelete(task)}
       >
         삭제
       </button>
       <button
         type="button"
-        aria-label={`${task.title} 업무 수정`}
+        aria-label={`${task.title} 업무 수정하기`}
         onClick={() => onStartEdit(task)}
       >
         수정

diff --git a/src/components/TaskCard.tsx b/src/components/TaskCard.tsx
index d9d377f66ac54d544c272f2073c134ebe2a57bb3..aff165e7788f4b45f447011d8af645cf5ca54e42
--- a/src/components/TaskCard.tsx
+++ b/src/components/TaskCard.tsx
@@ -24,7 +24,7 @@
       <strong>{task.title}</strong>
       {showDueSoonBadge && (
         <span
-          aria-label="마감일이 가까운 업무"
+          aria-label="마감일이 곧 다가오는 업무"
           style={{
             alignSelf: "flex-start",
             border: "1px solid #d97706",
@@ -47,23 +47,23 @@
         type="button"
         aria-label={
           task.status === "done"
-            ? `${task.title} 업무 완료 취소`
-            : `${task.title} 업무 완료 처리`
+            ? `${task.title} 업무를 미완료로 되돌리기`
+            : `${task.title} 업무를 완료로 표시하기`
         }
         onClick={() => onToggleDone(task)}
       >
-        {task.status === "done" ? "완료 취소" : "완료 처리"}
+        {task.status === "done" ? "미완료로 되돌리기" : "완료로 표시"}
       </button>
       <button
         type="button"
-        aria-label={`${task.title} 업무 삭제`}
+        aria-label={`${task.title} 업무 삭제하기`}
         onClick={() => onDelete(task)}
       >
         삭제
       </button>
       <button
         type="button"
-        aria-label={`${task.title} 업무 수정`}
+        aria-label={`${task.title} 업무 수정하기`}
         onClick={() => onStartEdit(task)}
       >
         수정

codex
수정은 `TaskCard.tsx` 한 파일에만 적용했습니다. 이제 변경된 문구가 의도대로 들어갔는지 파일 내용만 다시 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'rg -n "마감일이|미완료|완료로 표시|삭제
하기|수정하기" src/components/TaskCard.tsx' in D:\ai-apps\planpilot-local
 succeeded in 1152ms:
27:          aria-label="마감일이 곧 다가오는 업무"
50:            ? `${task.title} 업무를 미완료로 되돌리기`
51:            : `${task.title} 업무를 완료로 표시하기`
55:        {task.status === "done" ? "미완료로 되돌리기" : "완료로 표시"}
59:        aria-label={`${task.title} 업무 삭제하기`}
66:        aria-label={`${task.title} 업무 수정하기`}

diff --git a/src/components/TaskCard.tsx b/src/components/TaskCard.tsx
index d9d377f66ac54d544c272f2073c134ebe2a57bb3..aff165e7788f4b45f447011d8af645cf5ca54e42
--- a/src/components/TaskCard.tsx
+++ b/src/components/TaskCard.tsx
@@ -24,7 +24,7 @@
       <strong>{task.title}</strong>
       {showDueSoonBadge && (
         <span
-          aria-label="마감일이 가까운 업무"
+          aria-label="마감일이 곧 다가오는 업무"
           style={{
             alignSelf: "flex-start",
             border: "1px solid #d97706",
@@ -47,23 +47,23 @@
         type="button"
         aria-label={
           task.status === "done"
-            ? `${task.title} 업무 완료 취소`
-            : `${task.title} 업무 완료 처리`
+            ? `${task.title} 업무를 미완료로 되돌리기`
+            : `${task.title} 업무를 완료로 표시하기`
         }
         onClick={() => onToggleDone(task)}
       >
-        {task.status === "done" ? "완료 취소" : "완료 처리"}
+        {task.status === "done" ? "미완료로 되돌리기" : "완료로 표시"}
       </button>
       <button
         type="button"
-        aria-label={`${task.title} 업무 삭제`}
+        aria-label={`${task.title} 업무 삭제하기`}
         onClick={() => onDelete(task)}
       >
         삭제
       </button>
       <button
         type="button"
-        aria-label={`${task.title} 업무 수정`}
+        aria-label={`${task.title} 업무 수정하기`}
         onClick={() => onStartEdit(task)}
       >
         수정

codex
변경 완료했습니다.

변경한 파일:
- [src/components/TaskCard.tsx](D:/ai-apps/planpilot-local/src/components/TaskCard.tsx:27)

요약:
- 마감 임박 배지 `aria-label`: `마감일이 가까운 업무` → `마감일이 곧 다가오는 업무`
- 완료 토글 버튼 문구/`aria-label`을 더 자연스러운 동작 표현으로 조정
- 삭제/수정 버튼 `aria-label`에 `삭제하기`, `수정하기` 표현 적용
- 기능 로직, 상태 관리, 저장 구조는 변경하지 않았습니다.

검증:
- `rg`로 변경 문구가 정확히 반영된 것만 확인했습니다.
- 사용자 허용이 없어 `npm run build`, `npm run lint`, 브라우저 검증은 실행하지 않았습니다.

남은 위험:
- 실제 화면에서 버튼 폭이 충분한지는 수동 확인이 필요합니다. 문구가 조금 길어진 버튼은 `미완료로 되돌리기`입니다.

다음 task 진행 여부:
- 현재 task 범위는 완료되어 다음 task로 넘어가도 됩니다.

`.ai-dev/loop-log.md` 기록용 요약:
- `T001`: `src/components/TaskCard.tsx`의 업무 카드 보조 문구와 버튼 `aria-label`을 자연스러운 한국어로 최소 수정했다. 기능 로직과 데이
터 구조 변경은 없으며, 빌드/lint는 사용자 허용이 없어 실행하지 않았다.
diff --git a/src/components/TaskCard.tsx b/src/components/TaskCard.tsx
index d9d377f66ac54d544c272f2073c134ebe2a57bb3..aff165e7788f4b45f447011d8af645cf5ca54e42
--- a/src/components/TaskCard.tsx
+++ b/src/components/TaskCard.tsx
@@ -24,7 +24,7 @@
       <strong>{task.title}</strong>
       {showDueSoonBadge && (
         <span
-          aria-label="마감일이 가까운 업무"
+          aria-label="마감일이 곧 다가오는 업무"
           style={{
             alignSelf: "flex-start",
             border: "1px solid #d97706",
@@ -47,23 +47,23 @@
         type="button"
         aria-label={
           task.status === "done"
-            ? `${task.title} 업무 완료 취소`
-            : `${task.title} 업무 완료 처리`
+            ? `${task.title} 업무를 미완료로 되돌리기`
+            : `${task.title} 업무를 완료로 표시하기`
         }
         onClick={() => onToggleDone(task)}
       >
-        {task.status === "done" ? "완료 취소" : "완료 처리"}
+        {task.status === "done" ? "미완료로 되돌리기" : "완료로 표시"}
       </button>
       <button
         type="button"
-        aria-label={`${task.title} 업무 삭제`}
+        aria-label={`${task.title} 업무 삭제하기`}
         onClick={() => onDelete(task)}
       >
         삭제
       </button>
       <button
         type="button"
-        aria-label={`${task.title} 업무 수정`}
+        aria-label={`${task.title} 업무 수정하기`}
         onClick={() => onStartEdit(task)}
       >
         수정

tokens used
46,337
변경 완료했습니다.

변경한 파일:
- [src/components/TaskCard.tsx](D:/ai-apps/planpilot-local/src/components/TaskCard.tsx:27)

요약:
- 마감 임박 배지 `aria-label`: `마감일이 가까운 업무` → `마감일이 곧 다가오는 업무`
- 완료 토글 버튼 문구/`aria-label`을 더 자연스러운 동작 표현으로 조정
- 삭제/수정 버튼 `aria-label`에 `삭제하기`, `수정하기` 표현 적용
- 기능 로직, 상태 관리, 저장 구조는 변경하지 않았습니다.

검증:
- `rg`로 변경 문구가 정확히 반영된 것만 확인했습니다.
- 사용자 허용이 없어 `npm run build`, `npm run lint`, 브라우저 검증은 실행하지 않았습니다.

남은 위험:
- 실제 화면에서 버튼 폭이 충분한지는 수동 확인이 필요합니다. 문구가 조금 길어진 버튼은 `미완료로 되돌리기`입니다.

다음 task 진행 여부:
- 현재 task 범위는 완료되어 다음 task로 넘어가도 됩니다.

`.ai-dev/loop-log.md` 기록용 요약:
- `T001`: `src/components/TaskCard.tsx`의 업무 카드 보조 문구와 버튼 `aria-label`을 자연스러운 한국어로 최소 수정했다. 기능 로직과 데이터 구조 변경은 없으며, 빌드/lint는 사용자 허용이 없어 실행하지 않았다.

```