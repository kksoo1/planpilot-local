import type { Task } from "../types";

export function getProjectTaskStats(tasks: Task[], projectId: string) {
  const projectTasks = tasks.filter((task) => task.projectId === projectId);
  const totalTasks = projectTasks.length;
  const completedTasks = projectTasks.filter((task) => task.status === "done").length;
  const incompleteTasks = totalTasks - completedTasks;

  return { totalTasks, completedTasks, incompleteTasks };
}
