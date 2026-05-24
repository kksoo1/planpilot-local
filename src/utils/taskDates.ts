import type { Task } from "../types";
import { parseDueDate } from "./dateUtils";

export function getOverdueTasks(tasks: Task[], today: Date) {
  return tasks.filter((task) => {
    if (task.status === "done") return false;
    const dueDate = parseDueDate(task.dueDate);
    return Boolean(dueDate && dueDate < today);
  });
}

export function getUpcomingTasks(tasks: Task[], today: Date, days: number) {
  const daysLater = new Date(today);
  daysLater.setDate(today.getDate() + days);

  return tasks.filter((task) => {
    if (task.status === "done") return false;
    const dueDate = parseDueDate(task.dueDate);
    return Boolean(dueDate && dueDate >= today && dueDate <= daysLater);
  });
}
