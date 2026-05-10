// src/db.ts

import Dexie from "dexie";
import type { Table } from "dexie";
import type { Task, Project, StoredAppSettings } from "./types";

export class PlanPilotDatabase extends Dexie {
  tasks!: Table<Task, string>;
  projects!: Table<Project, string>;
  appSettings!: Table<StoredAppSettings, string>;

  constructor() {
    super("PlanPilotDatabase");
    this.version(1).stores({
      tasks: "id,projectId,status,sortOrder",
      projects: "id",
      appSettings: "id",
    });
  }

  async ensureDefaultData() {
    const defaultProjectId = "default";
    const defaultSettingsId = "app-settings";

    const projectExists = await this.projects.get(defaultProjectId);
    const settingsExists = await this.appSettings.get(defaultSettingsId);

    if (!projectExists) {
      await this.projects.add({
        id: defaultProjectId,
        name: "기본",
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
      });
    }

    if (!settingsExists) {
      await this.appSettings.add({
        id: defaultSettingsId,
        theme: "light",
        language: "ko",
        aiProvider: "rule_based",
        enableNotifications: false,
        firstLaunchCompleted: false,
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
      });
    }
  }
}

export const db = new PlanPilotDatabase();