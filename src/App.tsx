import { useEffect, useMemo, useState } from "react";
import { RuleBasedAIProvider } from "./ai/RuleBasedAIProvider";
import { useStore } from "./store";
import type { Task } from "./types";
import "./App.css";

type Tab = "today" | "tasks" | "projects" | "settings";

function App() {
  const [activeTab, setActiveTab] = useState<Tab>("today");
  const [recommendedTasks, setRecommendedTasks] = useState<Task[]>([]);
  const [newTaskTitle, setNewTaskTitle] = useState("");
  const [newTaskDueDate, setNewTaskDueDate] = useState("");
  const [newTaskPriority, setNewTaskPriority] = useState<Task["priority"]>("medium");

  const { tasks, projects, appSettings, initializeApp, addTask } = useStore();

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
      dueDate: newTaskDueDate || undefined,
      priority: newTaskPriority,
    });

    setNewTaskTitle("");
    setNewTaskDueDate("");
    setNewTaskPriority("medium");
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
            <p className="summary">추천 업무 {recommendedTasks.length}개</p>

            {recommendedTasks.length === 0 ? (
              <p className="empty">아직 추천할 업무가 없습니다.</p>
            ) : (
              <ul className="task-list">
                {recommendedTasks.map((task) => (
                  <li key={task.id} className="task-card">
                    <strong>{task.title}</strong>
                    <span>
                      중요도: {task.priority} · 상태: {task.status}
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
            <p className="summary">총 {tasks.length}개</p>

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

              <button type="submit">업무 추가</button>
            </form>

            {tasks.length === 0 ? (
              <p className="empty">등록된 업무가 없습니다.</p>
            ) : (
              <ul className="task-list">
                {tasks.map((task) => (
                  <li key={task.id} className="task-card">
                    <strong>{task.title}</strong>
                    <span>
                      중요도: {task.priority} · 상태: {task.status}
                    </span>
                    <span>{task.dueDate ? `마감일: ${task.dueDate}` : "마감일 없음"}</span>
                  </li>
                ))}
              </ul>
            )}
          </section>
        )}

        {activeTab === "projects" && (
          <section className="screen-card">
            <h2>프로젝트</h2>
            <p className="summary">총 {projects.length}개</p>

            {projects.length === 0 ? (
              <p className="empty">프로젝트가 없습니다.</p>
            ) : (
              <ul className="task-list">
                {projects.map((project) => (
                  <li key={project.id} className="task-card">
                    <strong>{project.name}</strong>
                    <span>{project.description || "설명 없음"}</span>
                  </li>
                ))}
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