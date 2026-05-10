// src/store.ts

import { create } from "zustand";
import { db } from "./db";
import type { Task, Project, AppSettings } from "./types";

// Helper function to create a unique ID
function createId() {
  if (globalThis.crypto?.randomUUID) {
    return globalThis.crypto.randomUUID();
  }
  return Date.now().toString();
}

interface StoreState {
  tasks: Task[];
  projects: Project[];
  appSettings: AppSettings;
}

interface StoreActions {
  initializeApp: () => Promise<void>;
  fetchTasks: () => Promise<void>;
  fetchProjects: () => Promise<void>;
  fetchAppSettings: () => Promise<void>;
  addTask: (input: CreateTaskInput) => Promise<void>;
  updateTask: (task: Task) => Promise<void>;
  deleteTask: (taskId: string) => Promise<void>;
  addProject: (input: CreateProjectInput) => Promise<void>;
  updateProject: (project: Project) => Promise<void>;
  deleteProject: (projectId: string) => Promise<void>;
  updateAppSettings: (settings: AppSettings) => Promise<void>;
}

type CreateTaskInput = {
  title: string;
  memo?: string;
  dueDate?: string;
  priority?: Task["priority"];
  status?: Task["status"];
  projectId?: string;
  tags?: string[];
  estimatedMinutes?: number;
  sortOrder?: number;
};

type CreateProjectInput = {
  name: string;
  description?: string;
  color?: string;
};

const initialState: StoreState = {
  tasks: [],
  projects: [],
  appSettings: {
    theme: "light",
    language: "ko",
    aiProvider: "rule_based",
    enableNotifications: false,
    firstLaunchCompleted: false,
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
};

type Store = StoreState & StoreActions;

export const useStore = create<Store>((set, get) => ({
  ...initialState,
  initializeApp: async () => {
    await db.ensureDefaultData();
    await get().fetchTasks();
    await get().fetchProjects();
    await get().fetchAppSettings();
  },
  fetchTasks: async () => {
    const tasks = await db.tasks.toArray();
    set({ tasks });
  },
  fetchProjects: async () => {
    const projects = await db.projects.toArray();
    set({ projects });
  },
  fetchAppSettings: async () => {
    const settings = await db.appSettings.get("app-settings");
    if (settings) {
      const { id: _id, ...appSettings } = settings;
      set({ appSettings });
    }
  },
  addTask: async (input) => {
    const id = createId();
    const now = new Date().toISOString();
    const task: Task = {
      id,
      title: input.title,
      priority: input.priority ?? "medium",
      status: input.status ?? "todo",
      projectId: input.projectId ?? "default",
      tags: input.tags ?? [],
      createdAt: now,
      updatedAt: now,
    };

    if (input.memo) task.memo = input.memo;
    if (input.dueDate) task.dueDate = input.dueDate;
    if (input.estimatedMinutes !== undefined) task.estimatedMinutes = input.estimatedMinutes;
    if (input.sortOrder !== undefined) task.sortOrder = input.sortOrder;

    await db.tasks.add(task);
    set((state) => ({ tasks: [...state.tasks, task] }));
  },
  updateTask: async (task) => {
    const updatedTask: Task = {
      ...task,
      updatedAt: new Date().toISOString(),
    };

    if (updatedTask.status === "done") {
      updatedTask.completedAt = updatedTask.completedAt || new Date().toISOString();
    } else {
      delete updatedTask.completedAt;
    }

    await db.tasks.put(updatedTask);
    set((state) => ({
      tasks: state.tasks.map((t) => (t.id === task.id ? updatedTask : t)),
    }));
  },
  deleteTask: async (taskId) => {
    await db.tasks.delete(taskId);
    set((state) => ({ tasks: state.tasks.filter((t) => t.id !== taskId) }));
  },
  addProject: async (input) => {
    const id = createId();
    const now = new Date().toISOString();
    const project: Project = {
      id,
      name: input.name,
      description: input.description ?? "",
      color: input.color ?? "",
      createdAt: now,
      updatedAt: now,
    };

    await db.projects.add(project);
    set((state) => ({ projects: [...state.projects, project] }));
  },
  updateProject: async (project) => {
    const updatedProject = {
      ...project,
      updatedAt: new Date().toISOString(),
    };
    await db.projects.put(updatedProject);
    set((state) => ({
      projects: state.projects.map((p) => (p.id === project.id ? updatedProject : p)),
    }));
  },
  deleteProject: async (projectId) => {
    if (projectId === "default") {
      throw new Error("Cannot delete the default project");
    }
    await db.projects.delete(projectId);
    set((state) => ({ projects: state.projects.filter((p) => p.id !== projectId) }));
  },
  updateAppSettings: async (settings) => {
    await db.appSettings.put({ ...settings, id: "app-settings" });
    set({ appSettings: settings });
  },
}));