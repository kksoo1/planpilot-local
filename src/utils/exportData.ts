import type { AppSettings, Project, Task } from "../types";

type PlanPilotExportData = {
  tasks: Task[];
  projects: Project[];
  appSettings: AppSettings;
};

export function exportPlanPilotData({
  tasks,
  projects,
  appSettings,
}: PlanPilotExportData) {
  const exportedAt = new Date().toISOString();
  const fileDate = exportedAt.slice(0, 10);
  const filename = `planpilot-backup-${fileDate}.json`;
  const backup = {
    format: "planpilot-local-backup",
    schemaVersion: 1,
    exportedAt,
    tasks,
    projects,
    appSettings,
  };

  const blob = new Blob([JSON.stringify(backup, null, 2)], {
    type: "application/json",
  });
  const url = URL.createObjectURL(blob);
  const link = document.createElement("a");

  try {
    link.href = url;
    link.download = filename;
    document.body.appendChild(link);
    link.click();
  } finally {
    link.remove();
    URL.revokeObjectURL(url);
  }

  return { filename };
}
