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
      <h2>오늘</h2>
      <p className="summary">
        전체 업무 수: {totalTasks}개<br />
        완료 업무 수: {completedTasks}개<br />
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
              {task.memo && <span>메모: {task.memo}</span>}
              <span>
                중요도: {getPriorityLabel(task.priority)} · 상태: {getStatusLabel(task.status)} · 프로젝트: {getProjectName(task.projectId)}
              </span>
              <span>{task.dueDate ? `마감일: ${task.dueDate}` : "마감일 없음"}</span>
            </li>
          ))}
        </ul>
      )}

      <h3>지난 마감 업무</h3>
      {overdueTasks.length === 0 ? (
        <p className="empty">지난 마감 업무가 없습니다.</p>
      ) : (
        <ul className="task-list">
          {overdueTasks.map((task) => (
            <li key={task.id} className="task-card">
              <strong>{task.title}</strong>
              {task.memo && <span>메모: {task.memo}</span>}
              <span>
                프로젝트: {getProjectName(task.projectId)} · 마감일: {task.dueDate}
              </span>
            </li>
          ))}
        </ul>
      )}

      <h3>7일 이내 마감 업무</h3>
      {upcomingTasks.length === 0 ? (
        <p className="empty">7일 이내 마감 업무가 없습니다.</p>
      ) : (
        <ul className="task-list">
          {upcomingTasks.map((task) => (
            <li key={task.id} className="task-card">
              <strong>{task.title}</strong>
              {task.memo && <span>메모: {task.memo}</span>}
              <span>
                프로젝트: {getProjectName(task.projectId)} · 마감일: {task.dueDate}
              </span>
            </li>
          ))}
        </ul>
      )}
    </section>
  );
}
