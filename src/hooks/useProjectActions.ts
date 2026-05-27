import type { FormEvent } from "react";
import type { Project, Task } from "../types";
import { getProjectDeleteBlockReason } from "../utils/projectDeletion";

type ProjectActionStore = {
  addProject: (input: { name: string; description?: string }) => Promise<void>;
  updateProject: (project: Project) => Promise<void>;
  deleteProject: (projectId: string) => Promise<void>;
};

type ProjectActionFormState = {
  projects: Project[];
  tasks: Task[];
  newProjectName: string;
  newProjectDescription: string;
  editProjectName: string;
  editProjectDescription: string;
  resetNewProjectForm: () => void;
  resetEditProjectForm: () => void;
};

type UseProjectActionsParams = ProjectActionStore & ProjectActionFormState;

export function useProjectActions({
  addProject,
  updateProject,
  deleteProject,
  projects,
  tasks,
  newProjectName,
  newProjectDescription,
  editProjectName,
  editProjectDescription,
  resetNewProjectForm,
  resetEditProjectForm,
}: UseProjectActionsParams) {
  async function handleAddProject(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    const name = newProjectName.trim();
    if (!name) return;

    await addProject({
      name,
      description: newProjectDescription.trim() || undefined,
    });

    resetNewProjectForm();
  }

  function handleSaveEditProject(project: Project) {
    const name = editProjectName.trim();
    if (!name) return;

    void updateProject({
      ...project,
      name,
      description: editProjectDescription.trim() || undefined,
    });

    resetEditProjectForm();
  }

  function handleDeleteProject(projectId: string) {
    const project = projects.find((item) => item.id === projectId);
    if (!project) return;
    if (getProjectDeleteBlockReason(project, tasks)) return;
    if (window.confirm("정말로 이 프로젝트를 삭제하시겠습니까?")) {
      void deleteProject(projectId);
    }
  }

  return {
    handleAddProject,
    handleSaveEditProject,
    handleDeleteProject,
  };
}
