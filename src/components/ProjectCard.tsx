import type { Project } from "../types";

type ProjectTaskStats = {
  totalTasks: number;
  completedTasks: number;
  incompleteTasks: number;
};

type ProjectCardProps = {
  project: Project;
  stats: ProjectTaskStats;
  onDelete: (projectId: string) => void;
  onStartEdit: (project: Project) => void;
};

export function ProjectCard({
  project,
  stats,
  onDelete,
  onStartEdit,
}: ProjectCardProps) {
  return (
    <li className="task-card">
      <strong>{project.name}</strong>
      <span>{project.description || "설명 없음"}</span>
      <span>
        전체 업무: {stats.totalTasks}개<br />
        완료: {stats.completedTasks}개<br />
        미완료: {stats.incompleteTasks}개
      </span>
      <button
        type="button"
        onClick={() => onDelete(project.id)}
        disabled={project.id === "default" || stats.totalTasks > 0}
      >
        {project.id === "default" ? "기본 프로젝트" : stats.totalTasks > 0 ? "업무 있음" : "삭제"}
      </button>
      <button type="button" onClick={() => onStartEdit(project)}>
        수정
      </button>
    </li>
  );
}
