// src/ai/RuleBasedAIProvider.ts

import type { AIProvider } from "./AIProvider";
import type { Task } from "../types";
import {
  isOverdueTask,
  isUpcomingTask,
  parseDueDate,
  startOfToday,
} from "../utils/dateUtils";

function priorityScore(priority: Task["priority"]): number {
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

function getTaskScore(task: Task): number {
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

export class RuleBasedAIProvider implements AIProvider {
  async suggestTodayTasks(tasks: Task[], limit = 3): Promise<Task[]> {
    const filteredTasks = tasks
      .filter(task => task.status !== "done")
      .sort((a, b) => {
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
      });

    return filteredTasks.slice(0, limit);
  }

  async findOverdueTasks(tasks: Task[]): Promise<Task[]> {
    const today = startOfToday();
    return tasks.filter((task) => isOverdueTask(task, today));
  }

  async findUpcomingTasks(tasks: Task[], days = 7): Promise<Task[]> {
    const today = startOfToday();
    return tasks.filter((task) => isUpcomingTask(task, today, days));
  }

  async summarizeTasks(tasks: Task[]): Promise<string> {
    const totalTasks = tasks.length;
    const completedTasks = tasks.filter(task => task.status === "done").length;
    const incompleteTasks = totalTasks - completedTasks;
    const overdueTasks = await this.findOverdueTasks(tasks);
    const upcomingTasks = await this.findUpcomingTasks(tasks, 7);

    return `총 업무 수: ${totalTasks}, 완료 업무 수: ${completedTasks}, 미완료 업무 수: ${incompleteTasks}, 지난 마감 업무 수: ${overdueTasks.length}, 7일 이내 마감 업무 수: ${upcomingTasks.length}`;
  }

  getProviderName(): string {
    return "RuleBasedAIProvider";
  }
}
