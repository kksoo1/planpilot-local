import type { Task } from "../types";

export function getTaskSummary(tasks: Task[]) {
  const totalTasks = tasks.length;
  const completedTasks = tasks.filter((task) => task.status === "done").length;

  return { totalTasks, completedTasks };
}
