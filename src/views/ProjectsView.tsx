import type { FormEvent } from "react";
import { ProjectCard } from "../components/ProjectCard";
import { ProjectForm } from "../components/ProjectForm";
import { getProjectTaskStats } from "../utils/projectStats";
import type { Project, Task } from "../types";

type ProjectsViewProps = {
  projects: Project[];
  tasks: Task[];
  editingProjectId: string | null;
  editProjectName: string;
  editProjectDescription: string;
  newProjectName: string;
  newProjectDescription: string;
  onNewProjectNameChange: (value: string) => void;
  onNewProjectDescriptionChange: (value: string) => void;
  onEditProjectNameChange: (value: string) => void;
  onEditProjectDescriptionChange: (value: string) => void;
  onAddProject: (event: FormEvent<HTMLFormElement>) => void;
  onSaveEditProject: (project: Project) => void;
  onCancelEditProject: () => void;
  onDeleteProject: (projectId: string) => void;
  onStartEditProject: (project: Project) => void;
};

export function ProjectsView({
  projects,
  tasks,
  editingProjectId,
  editProjectName,
  editProjectDescription,
  newProjectName,
  newProjectDescription,
  onNewProjectNameChange,
  onNewProjectDescriptionChange,
  onEditProjectNameChange,
  onEditProjectDescriptionChange,
  onAddProject,
  onSaveEditProject,
  onCancelEditProject,
  onDeleteProject,
  onStartEditProject,
}: ProjectsViewProps) {
  return (
    <section className="screen-card">
      <h2>프로젝트</h2>
      <p className="summary">총 {projects.length}개</p>

      <ProjectForm
        title="새 프로젝트 추가"
        ariaLabel="프로젝트 추가"
        name={newProjectName}
        description={newProjectDescription}
        submitLabel="프로젝트 추가"
        onNameChange={onNewProjectNameChange}
        onDescriptionChange={onNewProjectDescriptionChange}
        onSubmit={onAddProject}
      />

      {projects.length === 0 ? (
        <p className="empty">프로젝트가 없습니다.</p>
      ) : (
        <ul className="task-list">
          {projects.map((project) => {
            const stats = getProjectTaskStats(tasks, project.id);

            if (editingProjectId === project.id) {
              return (
                <li key={project.id} className="task-card">
                  <ProjectForm
                    title="프로젝트 수정"
                    ariaLabel="프로젝트 수정"
                    name={editProjectName}
                    description={editProjectDescription}
                    submitLabel="저장"
                    onNameChange={onEditProjectNameChange}
                    onDescriptionChange={onEditProjectDescriptionChange}
                    onSubmit={(event) => {
                      event.preventDefault();
                      onSaveEditProject(project);
                    }}
                    onCancel={onCancelEditProject}
                    className=""
                  />
                </li>
              );
            }

            return (
              <ProjectCard
                key={project.id}
                project={project}
                stats={stats}
                onDelete={onDeleteProject}
                onStartEdit={onStartEditProject}
              />
            );
          })}
        </ul>
      )}
    </section>
  );
}
