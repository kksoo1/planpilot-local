import { useEffect, useMemo, useState } from "react";
import { RuleBasedAIProvider } from "./ai/RuleBasedAIProvider";
import { useStore } from "./store";
import { getProjectName } from "./utils/projectLookup";
import { getProjectTaskStats } from "./utils/projectStats";
import { getOverdueTasks, getUpcomingTasks } from "./utils/taskDates";
import { filterTasks, sortTasks, type TaskSortOrder } from "./utils/taskFilters";
import { getTaskSummary } from "./utils/taskSummary";
import { SettingsView } from "./views/SettingsView";
import { TasksView } from "./views/TasksView";
import { ProjectsView } from "./views/ProjectsView";
import { TodayView } from "./views/TodayView";
import type { Project, Task } from "./types";
import "./App.css";

type Tab = "today" | "tasks" | "projects" | "settings";

function App() {
  const [activeTab, setActiveTab] = useState<Tab>("today");
  const [editingProjectId, setEditingProjectId] = useState<string | null>(null);
  const [editProjectName, setEditProjectName] = useState("");
  const [editProjectDescription, setEditProjectDescription] = useState("");
  const [editingTaskId, setEditingTaskId] = useState<string | null>(null);
  const [editTaskTitle, setEditTaskTitle] = useState("");
  const [editTaskDueDate, setEditTaskDueDate] = useState("");
  const [editTaskPriority, setEditTaskPriority] = useState<Task["priority"]>("medium");
  const [editTaskMemo, setEditTaskMemo] = useState("");
  const [editTaskProjectId, setEditTaskProjectId] = useState("default");
  const [recommendedTasks, setRecommendedTasks] = useState<Task[]>([]);
  const [newTaskTitle, setNewTaskTitle] = useState("");
  const [newTaskDueDate, setNewTaskDueDate] = useState("");
  const [newTaskPriority, setNewTaskPriority] = useState<Task["priority"]>("medium");
  const [newTaskProjectId, setNewTaskProjectId] = useState("default");
  const [newTaskMemo, setNewTaskMemo] = useState("");
  const [newProjectName, setNewProjectName] = useState("");
  const [newProjectDescription, setNewProjectDescription] = useState("");
  const [selectedProjectFilter, setSelectedProjectFilter] = useState("all");
  const [showCompletedTasks, setShowCompletedTasks] = useState(true);
  const [taskSortOrder, setTaskSortOrder] = useState<TaskSortOrder>("none");
  const [taskSearchQuery, setTaskSearchQuery] = useState("");
  const [isTaskFormOpen, setIsTaskFormOpen] = useState(false);

  const { tasks, projects, appSettings, initializeApp, addTask, updateTask, deleteTask, deleteProject, addProject, updateProject } = useStore();

  const today = new Date();
  today.setHours(0, 0, 0, 0);

  const overdueTasks = getOverdueTasks(tasks, today);
  const upcomingTasks = getUpcomingTasks(tasks, today, 7);
  const taskSummary = getTaskSummary(tasks);

  const filteredTasks = filterTasks(tasks, {
    selectedProjectFilter,
    showCompletedTasks,
    taskSearchQuery,
  });

  const sortedTasks = sortTasks(filteredTasks, taskSortOrder);

  const aiProvider = useMemo(() => new RuleBasedAIProvider(), []);

  useEffect(() => {
    void initializeApp();
  }, [initializeApp]);

  useEffect(() => {
    void aiProvider.suggestTodayTasks(tasks, 3).then(setRecommendedTasks);
  }, [aiProvider, tasks]);

  async function handleAddTask(event: React.FormEvent<HTMLFormElement>) {
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

    setIsTaskFormOpen(false);
    setNewTaskTitle("");
    setNewTaskDueDate("");
    setNewTaskPriority("medium");
    setNewTaskProjectId("default");
    setNewTaskMemo("");
  }

  function handleToggleTaskDone(task: Task) {
    const nextStatus = task.status === 'done' ? 'todo' : 'done';
    void updateTask({ ...task, status: nextStatus });
  }

  function handleDeleteTask(task: Task) {
    if (window.confirm('정말로 이 업무를 삭제하시겠습니까?')) {
      void deleteTask(task.id);
    }
  }

  function handleStartEditTask(task: Task) {
    setEditingTaskId(task.id);
    setEditTaskTitle(task.title);
    setEditTaskMemo(task.memo || "");
    setEditTaskDueDate(task.dueDate || "");
    setEditTaskPriority(task.priority);
    setEditTaskProjectId(task.projectId);
  }

  function handleCancelEditTask() {
    setEditingTaskId(null);
    setEditTaskTitle("");
    setEditTaskMemo("");
    setEditTaskDueDate("");
    setEditTaskPriority("medium");
    setEditTaskProjectId("default");
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
    setEditingTaskId(null);
    setEditTaskTitle("");
    setEditTaskMemo("");
    setEditTaskDueDate("");
    setEditTaskPriority("medium");
    setEditTaskProjectId("default");
  }

  function handleDeleteProject(projectId: string) {
    if (projectId === "default") return;
    const stats = getProjectTaskStats(tasks, projectId);
    if (stats.totalTasks > 0) return;
    if (window.confirm('정말로 이 프로젝트를 삭제하시겠습니까?')) {
      void deleteProject(projectId);
    }
  }

  function handleStartEditProject(project: Project) {
    setEditingProjectId(project.id);
    setEditProjectName(project.name);
    setEditProjectDescription(project.description || "");
  }

  function handleCancelEditProject() {
    setEditingProjectId(null);
    setEditProjectName("");
    setEditProjectDescription("");
  }

  function handleSaveEditProject(project: Project) {
    const name = editProjectName.trim();
    if (!name) return;

    void updateProject({
      ...project,
      name,
      description: editProjectDescription.trim() || undefined,
    });

    setEditingProjectId(null);
    setEditProjectName("");
    setEditProjectDescription("");
  }

  async function handleAddProject(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();

    const name = newProjectName.trim();
    if (!name) return;

    await addProject({
      name,
      description: newProjectDescription.trim() || undefined,
    });

    setNewProjectName("");
    setNewProjectDescription("");
  }

  return (
    <div className="app-shell">
      <header className="app-header">
        <p className="eyebrow">Privacy-first local planner</p>
        <h1>PlanPilot Local</h1>
        <p>서버 없이 로컬에 저장되는 개인 일정·업무 관리 앱</p>
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
            onCancelEditTask={handleCancelEditTask}
            onToggleTaskDone={handleToggleTaskDone}
            onDeleteTask={handleDeleteTask}
            onStartEditTask={handleStartEditTask}
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
            onCancelEditProject={handleCancelEditProject}
            onDeleteProject={handleDeleteProject}
            onStartEditProject={handleStartEditProject}
          />
        )}

        {activeTab === "settings" && <SettingsView appSettings={appSettings} />}
      </main>

      <nav className="bottom-nav" aria-label="하단 메뉴">
        <button
          className={activeTab === "today" ? "active" : ""}
          onClick={() => setActiveTab("today")}
        >
          오늘
        </button>
        <button
          className={activeTab === "tasks" ? "active" : ""}
          onClick={() => setActiveTab("tasks")}
        >
          업무
        </button>
        <button
          className={activeTab === "projects" ? "active" : ""}
          onClick={() => setActiveTab("projects")}
        >
          프로젝트
        </button>
        <button
          className={activeTab === "settings" ? "active" : ""}
          onClick={() => setActiveTab("settings")}
        >
          설정
        </button>
      </nav>
    </div>
  );
}

export default App;
