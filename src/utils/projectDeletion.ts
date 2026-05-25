import type { Project, Task } from "../types";
import { getProjectTaskStats } from "./projectStats";

export type ProjectDeleteBlockReason = "default-project" | "has-tasks";

export function getProjectDeleteBlockReason(
  project: Project,
  tasks: Task[],
): ProjectDeleteBlockReason | null {
  if (project.id === "default") {
    return "default-project";
  }

  const stats = getProjectTaskStats(tasks, project.id);
  if (stats.totalTasks > 0) {
    return "has-tasks";
  }

  return null;
}

export function canDeleteProject(project: Project, tasks: Task[]) {
  return getProjectDeleteBlockReason(project, tasks) === null;
}
