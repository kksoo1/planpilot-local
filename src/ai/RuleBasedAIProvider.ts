// src/ai/RuleBasedAIProvider.ts

import type { AIProvider } from "./AIProvider";
import type { Task } from "../types";
import { compareRecommendedTasks } from "./recommendationScore";
import {
  isOverdueTask,
  isUpcomingTask,
  startOfToday,
} from "../utils/dateUtils";

export class RuleBasedAIProvider implements AIProvider {
  async suggestTodayTasks(tasks: Task[], limit = 3): Promise<Task[]> {
    const filteredTasks = tasks
      .filter(task => task.status !== "done")
      .sort(compareRecommendedTasks);

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
