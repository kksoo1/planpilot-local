import type { FormEvent } from "react";

type ProjectFormProps = {
  title: string;
  ariaLabel: string;
  name: string;
  description: string;
  submitLabel: string;
  onNameChange: (value: string) => void;
  onDescriptionChange: (value: string) => void;
  onSubmit: (event: FormEvent<HTMLFormElement>) => void;
  onCancel?: () => void;
  className?: string;
};

export function ProjectForm({
  title,
  ariaLabel,
  name,
  description,
  submitLabel,
  onNameChange,
  onDescriptionChange,
  onSubmit,
  onCancel,
  className = "task-card",
}: ProjectFormProps) {
  return (
    <form onSubmit={onSubmit} className={className} aria-label={ariaLabel}>
      <strong>{title}</strong>

      <label>
        프로젝트명
        <input
          type="text"
          value={name}
          onChange={(event) => onNameChange(event.target.value)}
          placeholder="예: 프로젝트 이름"
        />
      </label>

      <label>
        설명
        <input
          type="text"
          value={description}
          onChange={(event) => onDescriptionChange(event.target.value)}
          placeholder="예: 프로젝트 설명"
        />
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
