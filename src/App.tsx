import { useEffect, useMemo, useState } from "react";
import { RuleBasedAIProvider } from "./ai/RuleBasedAIProvider";
import { useStore } from "./store";
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

  function getProjectTaskStats(projectId: string) {
    const projectTasks = tasks.filter((task) => task.projectId === projectId);
    const totalTasks = projectTasks.length;
    const completedTasks = projectTasks.filter((task) => task.status === "done").length;
    const incompleteTasks = totalTasks - completedTasks;

    return { totalTasks, completedTasks, incompleteTasks };
  }

  function getProjectName(projectId: string) {
    return projects.find((project) => project.id === projectId)?.name ?? "프로젝트 없음";
  }

  const today = new Date();
  today.setHours(0, 0, 0, 0);

  const sevenDaysLater = new Date(today);
  sevenDaysLater.setDate(today.getDate() + 7);

  const overdueTasks = tasks.filter((task) => {
    if (!task.dueDate || task.status === "done") return false;
    return new Date(task.dueDate) < today;
  });

  const upcomingTasks = tasks.filter((task) => {
    if (!task.dueDate || task.status === "done") return false;
    const dueDate = new Date(task.dueDate);
    return dueDate >= today && dueDate <= sevenDaysLater;
  });

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
    const stats = getProjectTaskStats(projectId);
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
          <section className="screen-card">
            <h2>오늘</h2>
            <p className="summary">
              전체 업무 수: {tasks.length}개<br />
              완료 업무 수: {tasks.filter((task) => task.status === "done").length}개<br />
              지난 마감 업무 수: {overdueTasks.length}개<br />
              7일 이내 마감 업무 수: {upcomingTasks.length}개
            </p>
            <p className="summary">추천 업무 {recommendedTasks.length}개</p>

            {recommendedTasks.length === 0 ? (
              <p className="empty">아직 추천할 업무가 없습니다.</p>
            ) : (
              <ul className="task-list">
                {recommendedTasks.map((task) => (
                  <li key={task.id} className="task-card">
                    <strong>{task.title}</strong>
                    <span>
                      중요도: {task.priority} · 상태: {task.status} · 프로젝트: {getProjectName(task.projectId)}
                    </span>
                    <span>{task.dueDate ? `마감일: ${task.dueDate}` : "마감일 없음"}</span>
                  </li>
                ))}
              </ul>
            )}
          </section>
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
              <form onSubmit={handleAddTask} className="task-card" aria-label="업무 추가">
                <strong>새 업무 추가</strong>

                <label>
                  제목
                  <input
                    type="text"
                    value={newTaskTitle}
                    onChange={(event) => setNewTaskTitle(event.target.value)}
                    placeholder="예: 사업계획서 초안 작성"
                  />
                </label>

                <label>
                  메모
                  <input
                    type="text"
                    value={newTaskMemo}
                    onChange={(event) => setNewTaskMemo(event.target.value)}
                    placeholder="예: 참고할 내용"
                  />
                </label>

                <label>
                  마감일
                  <input
                    type="date"
                    value={newTaskDueDate}
                    onChange={(event) => setNewTaskDueDate(event.target.value)}
                  />
                </label>

                <label>
                  중요도
                  <select
                    value={newTaskPriority}
                    onChange={(event) =>
                      setNewTaskPriority(event.target.value as Task["priority"])
                    }
                  >
                    <option value="low">낮음</option>
                    <option value="medium">보통</option>
                    <option value="high">높음</option>
                  </select>
                </label>

                <label>
                  프로젝트
                  <select
                    value={newTaskProjectId}
                    onChange={(event) => setNewTaskProjectId(event.target.value)}
                  >
                    {projects.map((project) => (
                      <option key={project.id} value={project.id}>
                        {project.name}
                      </option>
                    ))}
                  </select>
                </label>

                <button type="submit">업무 추가</button>
              </form>
            )}

            {filteredTasks.length === 0 ? (
              <p className="empty">등록된 업무가 없습니다.</p>
            ) : (
              <ul className="task-list">
                {sortedTasks.map((task) => {
                  if (editingTaskId === task.id) {
                    return (
                      <li key={task.id} className="task-card">
                        <form
                          onSubmit={(event) => {
                            event.preventDefault();
                            handleSaveEditTask(task);
                          }}
                          aria-label="업무 수정"
                        >
                          <strong>업무 수정</strong>

                          <label>
                            제목
                            <input
                              type="text"
                              value={editTaskTitle}
                              onChange={(event) => setEditTaskTitle(event.target.value)}
                              placeholder="예: 사업계획서 초안 작성"
                            />
                          </label>

                          <label>
                            메모
                            <input
                              type="text"
                              value={editTaskMemo}
                              onChange={(event) => setEditTaskMemo(event.target.value)}
                              placeholder="예: 참고할 내용"
                            />
                          </label>

                          <label>
                            마감일
                            <input
                              type="date"
                              value={editTaskDueDate}
                              onChange={(event) => setEditTaskDueDate(event.target.value)}
                            />
                          </label>

                          <label>
                            중요도
                            <select
                              value={editTaskPriority}
                              onChange={(event) =>
                                setEditTaskPriority(event.target.value as Task["priority"])
                              }
                            >
                              <option value="low">낮음</option>
                              <option value="medium">보통</option>
                              <option value="high">높음</option>
                            </select>
                          </label>

                          <label>
                            프로젝트
                            <select
                              value={editTaskProjectId}
                              onChange={(event) => setEditTaskProjectId(event.target.value)}
                            >
                              {projects.map((project) => (
                                <option key={project.id} value={project.id}>
                                  {project.name}
                                </option>
                              ))}
                            </select>
                          </label>

                          <button type="submit">저장</button>
                          <button type="button" onClick={handleCancelEditTask}>
                            취소
                          </button>
                        </form>
                      </li>
                    );
                  }

                  return (
                    <li key={task.id} className="task-card">
                      <strong>{task.title}</strong>
                      {task.memo && <span>메모: {task.memo}</span>}
                      <span>
                        중요도: {task.priority} · 상태: {task.status} · 프로젝트: {getProjectName(task.projectId)}
                      </span>
                      <span>{task.dueDate ? `마감일: ${task.dueDate}` : "마감일 없음"}</span>
                      <button type="button" onClick={() => handleToggleTaskDone(task)}>
                        {task.status === "done" ? "미완료로 변경" : "완료"}
                      </button>
                      <button type="button" onClick={() => handleDeleteTask(task)}>
                        삭제
                      </button>
                      <button type="button" onClick={() => handleStartEditTask(task)}>
                        수정
                      </button>
                    </li>
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

            <form onSubmit={handleAddProject} className="task-card" aria-label="프로젝트 추가">
              <strong>새 프로젝트 추가</strong>

              <label>
                프로젝트명
                <input
                  type="text"
                  value={newProjectName}
                  onChange={(event) => setNewProjectName(event.target.value)}
                  placeholder="예: 프로젝트 이름"
                />
              </label>

              <label>
                설명
                <input
                  type="text"
                  value={newProjectDescription}
                  onChange={(event) => setNewProjectDescription(event.target.value)}
                  placeholder="예: 프로젝트 설명"
                />
              </label>

              <button type="submit">프로젝트 추가</button>
            </form>

            {projects.length === 0 ? (
              <p className="empty">프로젝트가 없습니다.</p>
            ) : (
              <ul className="task-list">
                {projects.map((project) => {
                  const stats = getProjectTaskStats(project.id);

                  if (editingProjectId === project.id) {
                    return (
                      <li key={project.id} className="task-card">
                        <form
                          onSubmit={(event) => {
                            event.preventDefault();
                            handleSaveEditProject(project);
                          }}
                          aria-label="프로젝트 수정"
                        >
                          <strong>프로젝트 수정</strong>

                          <label>
                            프로젝트명
                            <input
                              type="text"
                              value={editProjectName}
                              onChange={(event) => setEditProjectName(event.target.value)}
                              placeholder="예: 프로젝트 이름"
                            />
                          </label>

                          <label>
                            설명
                            <input
                              type="text"
                              value={editProjectDescription}
                              onChange={(event) => setEditProjectDescription(event.target.value)}
                              placeholder="예: 프로젝트 설명"
                            />
                          </label>

                          <button type="submit">저장</button>
                          <button type="button" onClick={handleCancelEditProject}>
                            취소
                          </button>
                        </form>
                      </li>
                    );
                  }

                  return (
                    <li key={project.id} className="task-card">
                      <strong>{project.name}</strong>
                      <span>{project.description || "설명 없음"}</span>
                      <span>
                        전체 업무: {stats.totalTasks}개<br />
                        완료: {stats.completedTasks}개<br />
                        미완료: {stats.incompleteTasks}개
                      </span>
                      <button
                        type="button"
                        onClick={() => handleDeleteProject(project.id)}
                        disabled={project.id === "default" || stats.totalTasks > 0}
                      >
                        {project.id === "default" ? "기본 프로젝트" : stats.totalTasks > 0 ? "업무 있음" : "삭제"}
                      </button>
                      <button type="button" onClick={() => handleStartEditProject(project)}>
                        수정
                      </button>
                    </li>
                  );
                })}
              </ul>
            )}
          </section>
        )}

        {activeTab === "settings" && (
          <section className="screen-card">
            <h2>설정</h2>
            <div className="settings-list">
              <p>테마: {appSettings.theme}</p>
              <p>언어: {appSettings.language}</p>
              <p>AI Provider: {appSettings.aiProvider}</p>
              <p>알림: {appSettings.enableNotifications ? "사용" : "MVP에서는 사용하지 않음"}</p>
              <p>첫 실행 완료: {String(appSettings.firstLaunchCompleted)}</p>
            </div>
          </section>
        )}
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