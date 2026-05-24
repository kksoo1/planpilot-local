import type { Task } from "../types";

export function startOfToday() {
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  return today;
}

export function parseDueDate(dueDate?: string) {
  if (!dueDate) return null;

  const parsed = new Date(dueDate);
  return Number.isNaN(parsed.getTime()) ? null : parsed;
}

export function isOverdueTask(task: Task, today = startOfToday()) {
  if (task.status === "done") return false;
  const dueDate = parseDueDate(task.dueDate);
  return Boolean(dueDate && dueDate < today);
}

export function isUpcomingTask(task: Task, today = startOfToday(), days = 7) {
  if (task.status === "done") return false;

  const dueDate = parseDueDate(task.dueDate);
  if (!dueDate) return false;

  const daysLater = new Date(today);
  daysLater.setDate(today.getDate() + days);

  return dueDate >= today && dueDate <= daysLater;
}
