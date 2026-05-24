import { useEffect, useMemo, useState } from "react";
import { RuleBasedAIProvider } from "./ai/RuleBasedAIProvider";
import { useStore } from "./store";
import { getProjectTaskStats } from "./utils/projectStats";
import { getOverdueTasks, getUpcomingTasks } from "./utils/taskDates";
import { ProjectCard } from "./components/ProjectCard";
import { ProjectForm } from "./components/ProjectForm";
import { TaskCard } from "./components/TaskCard";
import { TaskForm } from "./components/TaskForm";
import { SettingsView } from "./views/SettingsView";
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
  const [taskSortOrder, setTaskSortOrder] = useState<"none" | "dueDateAsc">("none");
  const [taskSearchQuery, setTaskSearchQuery] = useState("");
  const [isTaskFormOpen, setIsTaskFormOpen] = useState(false);

  const { tasks, projects, appSettings, initializeApp, addTask, updateTask, deleteTask, deleteProject, addProject, updateProject } = useStore();

  function getProjectName(projectId: string) {
    return projects.find((project) => project.id === projectId)?.name ?? "프로젝트 없음";
  }

  const today = new Date();
  today.setHours(0, 0, 0, 0);

  const overdueTasks = getOverdueTasks(tasks, today);
  const upcomingTasks = getUpcomingTasks(tasks, today, 7);

  const filteredTasks = tasks.filter((task) => {
    const matchesProject =
      selectedProjectFilter === "all" || task.projectId === selectedProjectFilter;

    const searchText = taskSearchQuery.trim().toLowerCase();
    const matchesSearch =
      !searchText || task.title.toLowerCase().includes(searchText);

    const matchesStatus = showCompletedTasks || task.status !== "done";

    return matchesProject && matchesSearch && matchesStatus;
  });

  const sortedTasks = [...filteredTasks].sort((a, b) => {
    if (taskSortOrder === "none") return 0;

    if (taskSortOrder === "dueDateAsc") {
      if (!a.dueDate && !b.dueDate) return 0;
      if (!a.dueDate) return 1;
      if (!b.dueDate) return -1;
      return new Date(a.dueDate).getTime() - new Date(b.dueDate).getTime();
    }

    return 0;
  });

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
    totalTasks={tasks.length}
    completedTasks={tasks.filter((task) => task.status === "done").length}
    recommendedTasks={recommendedTasks}
    overdueTasks={overdueTasks}
    upcomingTasks={upcomingTasks}
    getProjectName={getProjectName}
  />
)}

        {activeTab === "tasks" && (
          <section className="screen-card">
            <h2>전체 업무</h2>
            <p className="summary">총 {filteredTasks.length}개</p>

            <label>
              업무 검색
              <input
                type="text"
                value={taskSearchQuery}
                onChange={(event) => setTaskSearchQuery(event.target.value)}
                placeholder="업무 제목 검색"
              />
            </label>

            <label>
              <input
                type="checkbox"
                checked={showCompletedTasks}
                onChange={(event) => setShowCompletedTasks(event.target.checked)}
              />
              완료 업무 표시
            </label>

            <label>
              정렬
              <select
                value={taskSortOrder}
                onChange={(event) =>
                  setTaskSortOrder(event.target.value as "none" | "dueDateAsc")
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
                onChange={(event) => setSelectedProjectFilter(event.target.value)}
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
              onClick={() => setIsTaskFormOpen((current) => !current)}
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
                onTitleChange={setNewTaskTitle}
                onMemoChange={setNewTaskMemo}
                onDueDateChange={setNewTaskDueDate}
                onPriorityChange={setNewTaskPriority}
                onProjectIdChange={setNewTaskProjectId}
                onSubmit={handleAddTask}
              />
            )}

            {filteredTasks.length === 0 ? (
              <p className="empty">등록된 업무가 없습니다.</p>
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
                          onTitleChange={setEditTaskTitle}
                          onMemoChange={setEditTaskMemo}
                          onDueDateChange={setEditTaskDueDate}
                          onPriorityChange={setEditTaskPriority}
                          onProjectIdChange={setEditTaskProjectId}
                          onSubmit={(event) => {
                            event.preventDefault();
                            handleSaveEditTask(task);
                          }}
                          onCancel={handleCancelEditTask}
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
                      onToggleDone={handleToggleTaskDone}
                      onDelete={handleDeleteTask}
                      onStartEdit={handleStartEditTask}
                    />
                  );
                })}
              </ul>
            )}
          </section>
        )}

        {activeTab === "projects" && (
          <section className="screen-card">
            <h2>프로젝트</h2>
            <p className="summary">총 {projects.length}개</p>

            <ProjectForm
              title="새 프로젝트 추가"
              ariaLabel="프로젝트 추가"
              name={newProjectName}
              description={newProjectDescription}
              submitLabel="프로젝트 추가"
              onNameChange={setNewProjectName}
              onDescriptionChange={setNewProjectDescription}
              onSubmit={handleAddProject}
            />

            {projects.length === 0 ? (
              <p className="empty">프로젝트가 없습니다.</p>
            ) : (
              <ul className="task-list">
                {projects.map((project) => {
                  const stats = getProjectTaskStats(tasks, project.id);

                  if (editingProjectId === project.id) {
                    return (
                      <li key={project.id} className="task-card">
                        <ProjectForm
                          title="프로젝트 수정"
                          ariaLabel="프로젝트 수정"
                          name={editProjectName}
                          description={editProjectDescription}
                          submitLabel="저장"
                          onNameChange={setEditProjectName}
                          onDescriptionChange={setEditProjectDescription}
                          onSubmit={(event) => {
                            event.preventDefault();
                            handleSaveEditProject(project);
                          }}
                          onCancel={handleCancelEditProject}
                          className=""
                        />
                      </li>
                    );
                  }

                  return (
                    <ProjectCard
                      key={project.id}
                      project={project}
                      stats={stats}
                      onDelete={handleDeleteProject}
                      onStartEdit={handleStartEditProject}
                    />
                  );
                })}
              </ul>
            )}
          </section>
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
