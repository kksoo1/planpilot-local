import type { Task } from "../types";

export function getOverdueTasks(tasks: Task[], today: Date) {
  return tasks.filter((task) => {
    if (!task.dueDate || task.status === "done") return false;
    return new Date(task.dueDate) < today;
  });
}

export function getUpcomingTasks(tasks: Task[], today: Date, days: number) {
  const daysLater = new Date(today);
  daysLater.setDate(today.getDate() + days);

  return tasks.filter((task) => {
    if (!task.dueDate || task.status === "done") return false;
    const dueDate = new Date(task.dueDate);
    return dueDate >= today && dueDate <= daysLater;
  });
}
