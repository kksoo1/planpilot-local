import type { Task } from "../types";
import { isOverdueTask, isUpcomingTask } from "./dateUtils";

export function getOverdueTasks(tasks: Task[], today: Date) {
  return tasks.filter((task) => isOverdueTask(task, today));
}

export function getUpcomingTasks(tasks: Task[], today: Date, days: number) {
  return tasks.filter((task) => isUpcomingTask(task, today, days));
}
