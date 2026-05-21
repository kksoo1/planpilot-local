import { getPriorityLabel, getStatusLabel } from "../utils/taskLabels";
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
  return (
    <li className="task-card">
      <strong>{task.title}</strong>
      {task.memo && <span>메모: {task.memo}</span>}
      <span>
        중요도: {getPriorityLabel(task.priority)} · 상태: {getStatusLabel(task.status)} · 프로젝트: {projectName}
      </span>
      <span>{task.dueDate ? `마감일: ${task.dueDate}` : "마감일 없음"}</span>
      <button type="button" onClick={() => onToggleDone(task)}>
        {task.status === "done" ? "미완료로 변경" : "완료"}
      </button>
      <button type="button" onClick={() => onDelete(task)}>
        삭제
      </button>
      <button type="button" onClick={() => onStartEdit(task)}>
        수정
      </button>
    </li>
  );
}
