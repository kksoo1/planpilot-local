import { useState } from "react";
import type { Project } from "../types";

export function useProjectFormState() {
  const [editingProjectId, setEditingProjectId] = useState<string | null>(null);
  const [editProjectName, setEditProjectName] = useState("");
  const [editProjectDescription, setEditProjectDescription] = useState("");
  const [newProjectName, setNewProjectName] = useState("");
  const [newProjectDescription, setNewProjectDescription] = useState("");

  function resetNewProjectForm() {
    setNewProjectName("");
    setNewProjectDescription("");
  }

  function resetEditProjectForm() {
    setEditingProjectId(null);
    setEditProjectName("");
    setEditProjectDescription("");
  }

  function startEditProject(project: Project) {
    setEditingProjectId(project.id);
    setEditProjectName(project.name);
    setEditProjectDescription(project.description || "");
  }

  return {
    editingProjectId,
    editProjectName,
    editProjectDescription,
    newProjectName,
    newProjectDescription,
    setEditProjectName,
    setEditProjectDescription,
    setNewProjectName,
    setNewProjectDescription,
    resetNewProjectForm,
    resetEditProjectForm,
    startEditProject,
  };
}
