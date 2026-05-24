import type { Task } from "../types";

export type TaskSortOrder = "none" | "dueDateAsc";

type FilterTasksOptions = {
  selectedProjectFilter: string;
  showCompletedTasks: boolean;
  taskSearchQuery: string;
};

export function filterTasks(
  tasks: Task[],
  {
    selectedProjectFilter,
    showCompletedTasks,
    taskSearchQuery,
  }: FilterTasksOptions,
) {
  return tasks.filter((task) => {
    const matchesProject =
      selectedProjectFilter === "all" || task.projectId === selectedProjectFilter;

    const searchText = taskSearchQuery.trim().toLowerCase();
    const matchesSearch =
      !searchText || task.title.toLowerCase().includes(searchText);

    const matchesStatus = showCompletedTasks || task.status !== "done";

    return matchesProject && matchesSearch && matchesStatus;
  });
}

export function sortTasks(tasks: Task[], taskSortOrder: TaskSortOrder) {
  return [...tasks].sort((a, b) => {
    if (taskSortOrder === "none") return 0;

    if (taskSortOrder === "dueDateAsc") {
      if (!a.dueDate && !b.dueDate) return 0;
      if (!a.dueDate) return 1;
      if (!b.dueDate) return -1;
      return new Date(a.dueDate).getTime() - new Date(b.dueDate).getTime();
    }

    return 0;
  });
}
