# Codex Implementation Result

## Run

- Started at: 2026-06-14 20:15:50
- Ended at: 2026-06-14 20:17:06
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
session id: 019ec5d8-58ad-7f93-a4e6-a806e819cc48
--------
user
Read and follow the full task prompt at this absolute file path: D:\ai-apps\planpilot-local\.ai-dev\current-task-prompt
.md
codex
작업 지시 파일을 먼저 읽어 범위와 제약을 확인하겠습니다. 지정된 프롬프트 파일만 대상으로 읽습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 'D:\\ai-apps\\planp
ilot-local\\.ai-dev\\current-task-prompt.md'" in D:\ai-apps\planpilot-local
 succeeded in 967ms:
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
업무 카드에서 마감일이 오늘부터 7일 이내인 미완료 업무에 `마감 임박` 배지를 표시한다.

## 배경
사용자가 가까운 마감 업무를 목록에서 빠르게 식별할 수 있도록, 기존 업무 카드 UI에 최소한의 시각적 표시를 추가한다.

## 성공 기준
- 마감일이 오늘부터 7일 이내인 미완료 업무 카드에 `마감 임박` 배지가 표시된다.
- 완료된 업무에는 `마감 임박` 배지가 표시되지 않는다.
- 마감일이 없거나 7일 범위를 벗어난 업무에는 배지가 표시되지 않는다.
- 기존 업무 생성, 수정, 완료 로직은 변경하지 않는다.
- UI 변경은 업무 카드 주변의 최소 범위로 유지한다.
- 허용된 build 검증을 통과한다.

## 제약사항
- React + Vite + TypeScript 기존 구조를 따른다.
- 상태 관리는 기존 Zustand store와 타입을 우선 사용한다.
- 로컬 저장 구조나 Dexie schema는 변경하지 않는다.
- `src/App.css`는 수정하지 않는다.
- 불필요한 컴포넌트 분리나 대규모 재작성은 하지 않는다.

## 범위 제외
- 업무 생성/수정/완료 동작 변경
- 새 설정 추가
- 알림 기능 추가
- 데이터 마이그레이션
- 전체 UI 재설계

## 수동 검증
- 오늘부터 7일 이내 마감일을 가진 미완료 업무 카드에 `마감 임박` 배지가 보이는지 확인한다.
- 완료 처리된 같은 업무에는 배지가 사라지는지 확인한다.
- 마감일이 없거나 8일 이후인 업무에는 배지가 보이지 않는지 확인한다.

## Current Task

- Task ID: T001
- Title: 마감 임박 배지 표시 구현
- Description: 업무 카드 렌더링 위치를 확인하고, 마감일이 오늘부터 7일 이내인 미완료 업무에만 `마감 임박` 배지를 최소 UI 변경으로 표시한다.
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

- 허용 시 npm run build 실행
- 미완료 업무 중 마감일이 오늘부터 7일 이내인 카드에만 배지가 표시되는지 확인
- 완료 업무와 범위 밖 업무에는 배지가 표시되지 않는지 확인

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
프롬프트 기준으로 이번 작업은 `src/App.tsx`의 업무 카드 렌더링만 최소 수정하는 범위입니다. 이제 해당 파일에서 마감일 표시와 카드 구조를 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 'src\\App.tsx' -Tot
alCount 220" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -Path 'src\\App.tsx' -Pattern 
'due|deadline|Task|task|완료|마감' -CaseSensitive:"'$false' in D:\ai-apps\planpilot-local
 succeeded in 1238ms:
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

  const { tasks, projects, appSettings, initializeApp, addTask, updateTask, deleteTask, deleteProject, addProject, upda
teProject } = useStore();
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
  const { handleAddTask, handleSaveEditTask, handleToggleTaskDone, handleDeleteTask } = useTaskActions({
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

 succeeded in 1366ms:

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
src\App.tsx:30:  const { tasks, projects, appSettings, initializeApp, addTask, updateTask, deleteTask, deleteProject, a
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
src\App.tsx:60:  const { handleAddTask, handleSaveEditTask, handleToggleTaskDone, handleDeleteTask } = useTaskActions({
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



codex
`App.tsx`는 이미 `TasksView`로 화면이 분리되어 있어 실제 카드 JSX는 `src/views/TasksView.tsx`에 있을 가능성이 큽니다. 업무 카드 주변만 바꾸기 위해 그 파일을 확인하겠습니
다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 'src\\views\\TasksV
iew.tsx'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -Path 'src\\views\\TasksView.t
sx' -Pattern 'due|task-card|className|마감|완료|done' -CaseSensitive:"'$false' in D:\ai-apps\planpilot-local
 succeeded in 1487ms:
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
      ? "寃??寃곌낵媛 ?놁뒿?덈떎."
      : hasProjectFilter || hasVisibilityFilter
        ? "?꾩옱 ?꾪꽣 議곌굔??留욌뒗 ?낅Т媛 ?놁뒿?덈떎."
        : "?깅줉???낅Т媛 ?놁뒿?덈떎.";

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

 succeeded in 1494ms:

src\views\TasksView.tsx:18:  newTaskDueDate: string;
src\views\TasksView.tsx:24:  editTaskDueDate: string;
src\views\TasksView.tsx:35:  onNewTaskDueDateChange: (value: string) => void;
src\views\TasksView.tsx:40:  onEditTaskDueDateChange: (value: string) => void;
src\views\TasksView.tsx:46:  onToggleTaskDone: (task: Task) => void;
src\views\TasksView.tsx:62:  newTaskDueDate,
src\views\TasksView.tsx:68:  editTaskDueDate,
src\views\TasksView.tsx:79:  onNewTaskDueDateChange,
src\views\TasksView.tsx:84:  onEditTaskDueDateChange,
src\views\TasksView.tsx:90:  onToggleTaskDone,
src\views\TasksView.tsx:105:    <section className="screen-card">
src\views\TasksView.tsx:107:      <p className="summary">총 {filteredTasks.length}개</p>
src\views\TasksView.tsx:125:        완료 업무 표시
src\views\TasksView.tsx:137:          <option value="dueDateAsc">마감일 빠른 순</option>
src\views\TasksView.tsx:169:          dueDate={newTaskDueDate}
src\views\TasksView.tsx:176:          onDueDateChange={onNewTaskDueDateChange}
src\views\TasksView.tsx:184:        <div className="empty">
src\views\TasksView.tsx:189:        <ul className="task-list">
src\views\TasksView.tsx:193:                <li key={task.id} className="task-card">
src\views\TasksView.tsx:199:                    dueDate={editTaskDueDate}
src\views\TasksView.tsx:206:                    onDueDateChange={onEditTaskDueDateChange}
src\views\TasksView.tsx:214:                    className=""
src\views\TasksView.tsx:225:                onToggleDone={onToggleTaskDone}



codex
업무 카드 자체는 `TaskCard` 컴포넌트로 분리되어 있습니다. 배지 조건과 표시 위치를 카드 내부에만 추가하면 생성/수정/완료 로직과 DB 구조를 건드리지 않고 끝낼 수 있습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 'src\\components\\T
askCard.tsx'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -Path 'src\\**\\*.ts*' -Patter
n 'startOfToday|getUpcomingTasks|dueDate' -CaseSensitive:"'$false' in D:\ai-apps\planpilot-local
 succeeded in 1329ms:
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
          aria-label="留덇컧 ?꾨컯 諛곗?"
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
        以묒슂?? {getPriorityLabel(task.priority)} 쨌 ?곹깭: {getStatusLabel(task.status)} 쨌 ?꾨줈?앺듃: {projectName}
      </span>
      <span>{task.dueDate ? `留덇컧?? ${task.dueDate}` : "留덇컧???놁쓬"}</span>
      <button type="button" onClick={() => onToggleDone(task)}>
        {task.status === "done" ? "誘몄셿猷뚮줈 蹂寃? : "?낅Т ?꾨즺 泥섎━"}
      </button>
      <button type="button" onClick={() => onDelete(task)}>
        ??젣
      </button>
      <button type="button" onClick={() => onStartEdit(task)}>
        ?섏젙
      </button>
    </li>
  );
}

 succeeded in 1468ms:

src\ai\recommendationScore.ts:2:import { parseDueDate, startOfToday } from "../utils/dateUtils";
src\ai\recommendationScore.ts:18:  const today = startOfToday();
src\ai\recommendationScore.ts:19:  const dueDate = parseDueDate(task.dueDate);
src\ai\recommendationScore.ts:20:  let dueDateScore = 0;
src\ai\recommendationScore.ts:21:  if (dueDate) {
src\ai\recommendationScore.ts:22:    const daysUntilDue = Math.floor((dueDate.getTime() - today.getTime()) / (1000 * 60
 * 60 * 24));
src\ai\recommendationScore.ts:23:    if (daysUntilDue < 0) dueDateScore += 10;
src\ai\recommendationScore.ts:24:    if (daysUntilDue === 0) dueDateScore += 5;
src\ai\recommendationScore.ts:27:  return priorityScore(task.priority) + dueDateScore;
src\ai\recommendationScore.ts:38:  const aDue = parseDueDate(a.dueDate);
src\ai\recommendationScore.ts:39:  const bDue = parseDueDate(b.dueDate);
src\ai\RuleBasedAIProvider.ts:9:  startOfToday,
src\ai\RuleBasedAIProvider.ts:22:    const today = startOfToday();
src\ai\RuleBasedAIProvider.ts:27:    const today = startOfToday();
src\components\TaskCard.tsx:45:      <span>{task.dueDate ? `마감일: ${task.dueDate}` : "마감일 없음"}</span>
src\components\TaskForm.tsx:9:  dueDate: string;
src\components\TaskForm.tsx:16:  onDueDateChange: (value: string) => void;
src\components\TaskForm.tsx:29:  dueDate,
src\components\TaskForm.tsx:36:  onDueDateChange,
src\components\TaskForm.tsx:71:          value={dueDate}
src\components\TaskForm.tsx:74:          onChange={(event) => onDueDateChange(event.target.value)}
src\hooks\useTaskActions.ts:8:    dueDate?: string;
src\hooks\useTaskActions.ts:18:  newTaskDueDate: string;
src\hooks\useTaskActions.ts:23:  editTaskDueDate: string;
src\hooks\useTaskActions.ts:38:  newTaskDueDate,
src\hooks\useTaskActions.ts:43:  editTaskDueDate,
src\hooks\useTaskActions.ts:56:    if (newTaskDueDate && newTaskDueDate.length !== 10) return;
src\hooks\useTaskActions.ts:61:      dueDate: newTaskDueDate || undefined,
src\hooks\useTaskActions.ts:73:    if (editTaskDueDate && editTaskDueDate.length !== 10) return;
src\hooks\useTaskActions.ts:79:      dueDate: editTaskDueDate || undefined,
src\hooks\useTaskFormState.ts:7:  const [editTaskDueDate, setEditTaskDueDate] = useState("");
src\hooks\useTaskFormState.ts:12:  const [newTaskDueDate, setNewTaskDueDate] = useState("");
src\hooks\useTaskFormState.ts:21:    setNewTaskDueDate("");
src\hooks\useTaskFormState.ts:31:    setEditTaskDueDate("");
src\hooks\useTaskFormState.ts:40:    setEditTaskDueDate(task.dueDate || "");
src\hooks\useTaskFormState.ts:48:    editTaskDueDate,
src\hooks\useTaskFormState.ts:53:    newTaskDueDate,
src\hooks\useTaskFormState.ts:59:    setEditTaskDueDate,
src\hooks\useTaskFormState.ts:64:    setNewTaskDueDate,
src\utils\dateUtils.ts:3:export function startOfToday() {
src\utils\dateUtils.ts:9:export function parseDueDate(dueDate?: string) {
src\utils\dateUtils.ts:10:  if (!dueDate) return null;
src\utils\dateUtils.ts:12:  const dateOnlyMatch = /^(\d{4})-(\d{2})-(\d{2})$/.exec(dueDate);
src\utils\dateUtils.ts:19:    : new Date(dueDate);
src\utils\dateUtils.ts:23:export function isOverdueTask(task: Task, today = startOfToday()) {
src\utils\dateUtils.ts:25:  const dueDate = parseDueDate(task.dueDate);
src\utils\dateUtils.ts:26:  return Boolean(dueDate && dueDate < today);
src\utils\dateUtils.ts:29:export function isUpcomingTask(task: Task, today = startOfToday(), days = 7) {
src\utils\dateUtils.ts:32:  const dueDate = parseDueDate(task.dueDate);
src\utils\dateUtils.ts:33:  if (!dueDate) return false;
src\utils\dateUtils.ts:38:  return dueDate >= today && dueDate <= daysLater;
src\utils\importValidation.ts:127:    validateOptionalString(task, "dueDate", label, errors);
src\utils\taskDates.ts:8:export function getUpcomingTasks(tasks: Task[], today: Date, days: number) {
src\utils\taskFilters.ts:3:export type TaskSortOrder = "none" | "dueDateAsc";
src\utils\taskFilters.ts:48:    if (taskSortOrder === "dueDateAsc") {
src\utils\taskFilters.ts:49:      if (!a.dueDate && !b.dueDate) return 0;
src\utils\taskFilters.ts:50:      if (!a.dueDate) return 1;
src\utils\taskFilters.ts:51:      if (!b.dueDate) return -1;
src\utils\taskFilters.ts:52:      return new Date(a.dueDate).getTime() - new Date(b.dueDate).getTime();
src\views\TasksView.tsx:18:  newTaskDueDate: string;
src\views\TasksView.tsx:24:  editTaskDueDate: string;
src\views\TasksView.tsx:35:  onNewTaskDueDateChange: (value: string) => void;
src\views\TasksView.tsx:40:  onEditTaskDueDateChange: (value: string) => void;
src\views\TasksView.tsx:62:  newTaskDueDate,
src\views\TasksView.tsx:68:  editTaskDueDate,
src\views\TasksView.tsx:79:  onNewTaskDueDateChange,
src\views\TasksView.tsx:84:  onEditTaskDueDateChange,
src\views\TasksView.tsx:137:          <option value="dueDateAsc">마감일 빠른 순</option>
src\views\TasksView.tsx:169:          dueDate={newTaskDueDate}
src\views\TasksView.tsx:176:          onDueDateChange={onNewTaskDueDateChange}
src\views\TasksView.tsx:199:                    dueDate={editTaskDueDate}
src\views\TasksView.tsx:206:                    onDueDateChange={onEditTaskDueDateChange}
src\views\TodayView.tsx:43:              <span>{task.dueDate ? `마감일: ${task.dueDate}` : "마감일 없음"}</span>
src\views\TodayView.tsx:59:                프로젝트: {getProjectName(task.projectId)} · 마감일: {task.dueDate}
src\views\TodayView.tsx:76:                프로젝트: {getProjectName(task.projectId)} · 마감일: {task.dueDate}



codex
`TaskCard`에 이미 `isUpcomingTask(task)` 기반 배지 로직이 들어가 있습니다. 요구조건과 정확히 맞는지 확인하기 위해 날짜 유틸만 추가로 읽고, 필요한 경우 카드 파일만 조정하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 'src\\utils\\taskDa
tes.ts'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 'src\\types.ts'" in
 D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 'src\\utils\\dateUt
ils.ts'" in D:\ai-apps\planpilot-local
 succeeded in 1550ms:
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

export function isUpcomingTask(task: Task, today = startOfToday(), days = 7) {
  if (task.status === "done") return false;

  const dueDate = parseDueDate(task.dueDate);
  if (!dueDate) return false;

  const daysLater = new Date(today);
  daysLater.setDate(today.getDate() + days);

  return dueDate >= today && dueDate <= daysLater;
}

 succeeded in 1600ms:
import type { Task } from "../types";
import { isOverdueTask, isUpcomingTask } from "./dateUtils";

export function getOverdueTasks(tasks: Task[], today: Date) {
  return tasks.filter((task) => isOverdueTask(task, today));
}

export function getUpcomingTasks(tasks: Task[], today: Date, days: number) {
  return tasks.filter((task) => isUpcomingTask(task, today, days));
}

 succeeded in 1645ms:
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

codex
현재 구현은 조건 자체가 요구사항과 일치합니다. 출력 인코딩이 PowerShell에서 깨져 보이는 부분이 있어, 실제 파일의 UTF-8 문자열이 올바른지 확인한 뒤 수정 여부를 결정하겠습니다.
mcp: node_repl/js started
mcp: node_repl/js (completed)
codex
확인 결과 실제 UTF-8 파일에는 `마감 임박` 문자열이 정상 저장되어 있고, `isUpcomingTask`가 완료 업무와 마감일 없는 업무를 제외합니다. 추가 수정이 필요한지 판단하려고 `TaskCard` 사용
 범위만 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -Path 'src\\**\\*.tsx' -Patter
n '<TaskCard|TaskCard' -CaseSensitive" in D:\ai-apps\planpilot-local
 succeeded in 1112ms:

src\components\TaskCard.tsx:5:type TaskCardProps = {
src\components\TaskCard.tsx:13:export function TaskCard({
src\components\TaskCard.tsx:19:}: TaskCardProps) {
src\views\TasksView.tsx:2:import { TaskCard } from "../components/TaskCard";
src\views\TasksView.tsx:221:              <TaskCard



codex
지정된 프롬프트를 읽고 범위를 확인했습니다. 현재 코드에는 이미 요구사항이 구현되어 있어 추가 수정은 하지 않았습니다.

변경한 파일 목록: 없음

구현/분석 요약:
`src/components/TaskCard.tsx`에서 `isUpcomingTask(task)`를 사용해 `마감 임박` 배지를 표시하고 있습니다. `src/utils/dateUtils.ts`의 `isUpcomin
gTask`는 다음 조건을 만족합니다.

- 완료 업무(`status === "done"`)는 제외
- 마감일 없음은 제외
- 오늘부터 7일 이내 마감일만 포함
- 과거 마감일은 제외

검증 방법:
코드 기준으로 `TaskCard` 렌더링 조건과 날짜 유틸을 확인했습니다. `npm run build`는 사용자 명시 허용이 없어 실행하지 않았습니다.

남은 위험:
빌드 검증과 브라우저 수동 확인은 아직 수행되지 않았습니다.

다음 task로 넘어가도 되는지:
코드 기준으로는 넘어가도 됩니다. 다만 최종 완료 판정 전 `npm run build`와 수동 UI 확인을 권장합니다.

`.ai-dev/loop-log.md`에 기록할 작업 요약:
`T001 마감 임박 배지 표시 구현` 확인 완료. `TaskCard`에 `isUpcomingTask` 기반 `마감 임박` 배지 로직이 이미 존재하며, 완료 업무/마감일 없음/7일 범위 밖 업무는 제외된다. 추가 
파일 수정 없음. Build는 사용자 허용이 없어 미실행.
tokens used
29,357
지정된 프롬프트를 읽고 범위를 확인했습니다. 현재 코드에는 이미 요구사항이 구현되어 있어 추가 수정은 하지 않았습니다.

변경한 파일 목록: 없음

구현/분석 요약:
`src/components/TaskCard.tsx`에서 `isUpcomingTask(task)`를 사용해 `마감 임박` 배지를 표시하고 있습니다. `src/utils/dateUtils.ts`의 `isUpcomingTask`는 다음 조건을 만족합니다.

- 완료 업무(`status === "done"`)는 제외
- 마감일 없음은 제외
- 오늘부터 7일 이내 마감일만 포함
- 과거 마감일은 제외

검증 방법:
코드 기준으로 `TaskCard` 렌더링 조건과 날짜 유틸을 확인했습니다. `npm run build`는 사용자 명시 허용이 없어 실행하지 않았습니다.

남은 위험:
빌드 검증과 브라우저 수동 확인은 아직 수행되지 않았습니다.

다음 task로 넘어가도 되는지:
코드 기준으로는 넘어가도 됩니다. 다만 최종 완료 판정 전 `npm run build`와 수동 UI 확인을 권장합니다.

`.ai-dev/loop-log.md`에 기록할 작업 요약:
`T001 마감 임박 배지 표시 구현` 확인 완료. `TaskCard`에 `isUpcomingTask` 기반 `마감 임박` 배지 로직이 이미 존재하며, 완료 업무/마감일 없음/7일 범위 밖 업무는 제외된다. 추가 파일 수정 없음. Build는 사용자 허용이 없어 미실행.

```