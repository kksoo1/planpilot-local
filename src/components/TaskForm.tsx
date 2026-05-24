import type { FormEvent } from "react";
import type { Project, Task } from "../types";

type TaskFormProps = {
  title: string;
  ariaLabel: string;
  taskTitle: string;
  memo: string;
  dueDate: string;
  priority: Task["priority"];
  projectId: string;
  projects: Project[];
  submitLabel: string;
  onTitleChange: (value: string) => void;
  onMemoChange: (value: string) => void;
  onDueDateChange: (value: string) => void;
  onPriorityChange: (value: Task["priority"]) => void;
  onProjectIdChange: (value: string) => void;
  onSubmit: (event: FormEvent<HTMLFormElement>) => void;
  onCancel?: () => void;
  className?: string;
};

export function TaskForm({
  title,
  ariaLabel,
  taskTitle,
  memo,
  dueDate,
  priority,
  projectId,
  projects,
  submitLabel,
  onTitleChange,
  onMemoChange,
  onDueDateChange,
  onPriorityChange,
  onProjectIdChange,
  onSubmit,
  onCancel,
  className = "task-card",
}: TaskFormProps) {
  return (
    <form onSubmit={onSubmit} className={className} aria-label={ariaLabel}>
      <strong>{title}</strong>

      <label>
        제목
        <input
          type="text"
          value={taskTitle}
          onChange={(event) => onTitleChange(event.target.value)}
          placeholder="예: 사업계획서 초안 작성"
        />
      </label>

      <label>
        메모
        <input
          type="text"
          value={memo}
          onChange={(event) => onMemoChange(event.target.value)}
          placeholder="예: 참고할 내용"
        />
      </label>

      <label>
        마감일
        <input
          type="date"
          value={dueDate}
          min="1900-01-01"
          max="9999-12-31"
          onChange={(event) => onDueDateChange(event.target.value)}
        />
      </label>

      <label>
        중요도
        <select
          value={priority}
          onChange={(event) => onPriorityChange(event.target.value as Task["priority"])}
        >
          <option value="low">낮음</option>
          <option value="medium">보통</option>
          <option value="high">높음</option>
        </select>
      </label>

      <label>
        프로젝트
        <select
          value={projectId}
          onChange={(event) => onProjectIdChange(event.target.value)}
        >
          {projects.map((project) => (
            <option key={project.id} value={project.id}>
              {project.name}
            </option>
          ))}
        </select>
      </label>

      <button type="submit">{submitLabel}</button>
      {onCancel && (
        <button type="button" onClick={onCancel}>
          취소
        </button>
      )}
    </form>
  );
}
