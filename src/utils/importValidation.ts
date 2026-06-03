import type { AppSettings, Project, Task } from "../types";

const BACKUP_FORMAT = "planpilot-local-backup";
const BACKUP_SCHEMA_VERSION = 1;

const TASK_PRIORITIES: Task["priority"][] = ["low", "medium", "high"];
const TASK_STATUSES: Task["status"][] = ["todo", "in_progress", "done"];

export type BackupValidationSummary = {
  taskCount: number;
  projectCount: number;
  hasAppSettings: boolean;
};

export type BackupValidationResult = {
  valid: boolean;
  errors: string[];
  warnings: string[];
  summary: BackupValidationSummary;
};

type BackupLike = {
  format?: unknown;
  schemaVersion?: unknown;
  exportedAt?: unknown;
  tasks?: unknown;
  projects?: unknown;
  appSettings?: unknown;
};

export function validateBackupData(input: unknown): BackupValidationResult {
  const errors: string[] = [];
  const warnings: string[] = [];

  if (!isRecord(input)) {
    return createResult(["백업 파일의 최상위 값은 객체여야 합니다."], warnings);
  }

  const backup: BackupLike = input;

  validateBackupMetadata(backup, errors);

  const tasks = Array.isArray(backup.tasks) ? backup.tasks : [];
  const projects = Array.isArray(backup.projects) ? backup.projects : [];

  if (!Array.isArray(backup.tasks)) {
    errors.push("tasks는 배열이어야 합니다.");
  }

  if (!Array.isArray(backup.projects)) {
    errors.push("projects는 배열이어야 합니다.");
  }

  if (!isRecord(backup.appSettings)) {
    errors.push("appSettings는 객체여야 합니다.");
  }

  validateProjects(projects, errors, warnings);
  validateTasks(tasks, projects, errors);

  if (isRecord(backup.appSettings)) {
    validateAppSettings(backup.appSettings, errors);
  }

  return {
    valid: errors.length === 0,
    errors,
    warnings,
    summary: {
      taskCount: tasks.length,
      projectCount: projects.length,
      hasAppSettings: isRecord(backup.appSettings),
    },
  };
}

function validateBackupMetadata(backup: BackupLike, errors: string[]) {
  if (backup.format !== BACKUP_FORMAT) {
    errors.push(`format은 "${BACKUP_FORMAT}"이어야 합니다.`);
  }

  if (backup.schemaVersion !== BACKUP_SCHEMA_VERSION) {
    errors.push(`schemaVersion은 ${BACKUP_SCHEMA_VERSION}이어야 합니다.`);
  }

  if (!isNonEmptyString(backup.exportedAt)) {
    errors.push("exportedAt은 비어 있지 않은 문자열이어야 합니다.");
  }
}

function validateTasks(
  tasks: unknown[],
  projects: unknown[],
  errors: string[],
) {
  const projectIds = new Set(
    projects.filter(isRecord).map((project) => project.id).filter(isString),
  );
  const taskIds = new Set<string>();

  tasks.forEach((task, index) => {
    const label = `tasks[${index}]`;

    if (!isRecord(task)) {
      errors.push(`${label}는 객체여야 합니다.`);
      return;
    }

    validateRequiredString(task, "id", label, errors);
    validateRequiredString(task, "title", label, errors);
    validateRequiredString(task, "projectId", label, errors);
    validateRequiredString(task, "createdAt", label, errors);
    validateRequiredString(task, "updatedAt", label, errors);

    if (!TASK_PRIORITIES.includes(task.priority as Task["priority"])) {
      errors.push(`${label}.priority는 low, medium, high 중 하나여야 합니다.`);
    }

    if (!TASK_STATUSES.includes(task.status as Task["status"])) {
      errors.push(`${label}.status는 todo, in_progress, done 중 하나여야 합니다.`);
    }

    if (!Array.isArray(task.tags)) {
      errors.push(`${label}.tags는 배열이어야 합니다.`);
    }

    validateOptionalString(task, "dueDate", label, errors);
    validateOptionalString(task, "completedAt", label, errors);

    if (isString(task.id)) {
      if (taskIds.has(task.id)) {
        errors.push(`${label}.id가 백업 파일 안에서 중복되었습니다.`);
      }
      taskIds.add(task.id);
    }

    if (isString(task.projectId) && !projectIds.has(task.projectId)) {
      errors.push(`${label}.projectId가 백업 파일의 projects에 존재하지 않습니다.`);
    }
  });
}

function validateProjects(projects: unknown[], errors: string[], warnings: string[]) {
  const projectIds = new Set<string>();

  projects.forEach((project, index) => {
    const label = `projects[${index}]`;

    if (!isRecord(project)) {
      errors.push(`${label}는 객체여야 합니다.`);
      return;
    }

    validateRequiredString(project, "id", label, errors);
    validateRequiredString(project, "name", label, errors);
    validateRequiredString(project, "createdAt", label, errors);
    validateRequiredString(project, "updatedAt", label, errors);

    validateOptionalString(project, "description", label, errors);
    validateOptionalString(project, "color", label, errors);
    validateOptionalString(project, "archivedAt", label, errors);

    if (isString(project.id)) {
      if (projectIds.has(project.id)) {
        errors.push(`${label}.id가 백업 파일 안에서 중복되었습니다.`);
      }
      projectIds.add(project.id);
    }
  });

  if (!projectIds.has("default")) {
    warnings.push("백업 파일에 기본 프로젝트가 없어 복원 전 정책 확인이 필요합니다.");
  }
}

function validateAppSettings(settings: Record<string, unknown>, errors: string[]) {
  if (settings.theme !== "light") {
    errors.push('appSettings.theme은 "light"여야 합니다.');
  }

  if (settings.language !== "ko") {
    errors.push('appSettings.language는 "ko"여야 합니다.');
  }

  if (settings.aiProvider !== "rule_based") {
    errors.push('appSettings.aiProvider는 "rule_based"여야 합니다.');
  }

  if (settings.enableNotifications !== false) {
    errors.push("appSettings.enableNotifications는 false여야 합니다.");
  }

  if (typeof settings.firstLaunchCompleted !== "boolean") {
    errors.push("appSettings.firstLaunchCompleted는 boolean이어야 합니다.");
  }

  validateRequiredString(settings, "createdAt", "appSettings", errors);
  validateRequiredString(settings, "updatedAt", "appSettings", errors);
}

function validateRequiredString(
  record: Record<string, unknown>,
  key: keyof (Task & Project & AppSettings),
  label: string,
  errors: string[],
) {
  if (!isString(record[key])) {
    errors.push(`${label}.${String(key)}는 문자열이어야 합니다.`);
  }
}

function validateOptionalString(
  record: Record<string, unknown>,
  key: keyof (Task & Project),
  label: string,
  errors: string[],
) {
  if (record[key] !== undefined && !isString(record[key])) {
    errors.push(`${label}.${String(key)}는 문자열이어야 합니다.`);
  }
}

function createResult(errors: string[], warnings: string[]): BackupValidationResult {
  return {
    valid: false,
    errors,
    warnings,
    summary: {
      taskCount: 0,
      projectCount: 0,
      hasAppSettings: false,
    },
  };
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function isString(value: unknown): value is string {
  return typeof value === "string";
}

function isNonEmptyString(value: unknown): value is string {
  return isString(value) && value.trim().length > 0;
}
