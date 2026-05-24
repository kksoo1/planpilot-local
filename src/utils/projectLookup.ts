import type { Project } from "../types";

export function getProjectName(projects: Project[], projectId: string) {
  return projects.find((project) => project.id === projectId)?.name ?? "프로젝트 없음";
}
