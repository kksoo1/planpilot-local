// src/ai/AIProvider.ts

import type { Task } from "../types";

export interface AIProvider {
  suggestTodayTasks(tasks: Task[], limit?: number): Promise<Task[]>;
  findOverdueTasks(tasks: Task[]): Promise<Task[]>;
  findUpcomingTasks(tasks: Task[], days?: number): Promise<Task[]>;
  summarizeTasks(tasks: Task[]): Promise<string>;
  getProviderName(): string;
}