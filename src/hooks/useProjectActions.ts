import type { FormEvent } from "react";
import type { Project } from "../types";

type ProjectActionStore = {
  addProject: (input: { name: string; description?: string }) => Promise<void>;
  updateProject: (project: Project) => Promise<void>;
};

type ProjectActionFormState = {
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

  return {
    handleAddProject,
    handleSaveEditProject,
  };
}
