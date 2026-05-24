import type { Task } from "../types";
import { parseDueDate, startOfToday } from "../utils/dateUtils";

export function priorityScore(priority: Task["priority"]): number {
  switch (priority) {
    case "high":
      return 3;
    case "medium":
      return 2;
    case "low":
      return 1;
    default:
      return 0;
  }
}

export function getTaskScore(task: Task): number {
  const today = startOfToday();
  const dueDate = parseDueDate(task.dueDate);
  let dueDateScore = 0;
  if (dueDate) {
    const daysUntilDue = Math.floor((dueDate.getTime() - today.getTime()) / (1000 * 60 * 60 * 24));
    if (daysUntilDue < 0) dueDateScore += 10;
    if (daysUntilDue === 0) dueDateScore += 5;
  }

  return priorityScore(task.priority) + dueDateScore;
}

export function compareRecommendedTasks(a: Task, b: Task): number {
  const scoreA = getTaskScore(a);
  const scoreB = getTaskScore(b);

  if (scoreA !== scoreB) {
    return scoreB - scoreA;
  }

  const aDue = parseDueDate(a.dueDate);
  const bDue = parseDueDate(b.dueDate);

  if (aDue && bDue) return aDue.getTime() - bDue.getTime();
  if (aDue) return -1;
  if (bDue) return 1;
  return 0;
}
