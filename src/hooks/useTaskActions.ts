import type { FormEvent } from "react";
import type { Task } from "../types";

type TaskActionStore = {
  addTask: (input: {
    title: string;
    memo?: string;
    dueDate?: string;
    priority: Task["priority"];
    projectId: string;
  }) => Promise<void>;
  updateTask: (task: Task) => Promise<void>;
};

type TaskActionFormState = {
  newTaskTitle: string;
  newTaskDueDate: string;
  newTaskPriority: Task["priority"];
  newTaskProjectId: string;
  newTaskMemo: string;
  editTaskTitle: string;
  editTaskDueDate: string;
  editTaskPriority: Task["priority"];
  editTaskMemo: string;
  editTaskProjectId: string;
  resetNewTaskForm: () => void;
  resetEditTaskForm: () => void;
};

type UseTaskActionsParams = TaskActionStore & TaskActionFormState;

export function useTaskActions({
  addTask,
  updateTask,
  newTaskTitle,
  newTaskDueDate,
  newTaskPriority,
  newTaskProjectId,
  newTaskMemo,
  editTaskTitle,
  editTaskDueDate,
  editTaskPriority,
  editTaskMemo,
  editTaskProjectId,
  resetNewTaskForm,
  resetEditTaskForm,
}: UseTaskActionsParams) {
  async function handleAddTask(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    const title = newTaskTitle.trim();
    if (!title) return;

    if (newTaskDueDate && newTaskDueDate.length !== 10) return;

    await addTask({
      title,
      memo: newTaskMemo.trim() || undefined,
      dueDate: newTaskDueDate || undefined,
      priority: newTaskPriority,
      projectId: newTaskProjectId,
    });

    resetNewTaskForm();
  }

  function handleSaveEditTask(task: Task) {
    const title = editTaskTitle.trim();
    if (!title) return;

    if (editTaskDueDate && editTaskDueDate.length !== 10) return;

    void updateTask({
      ...task,
      title,
      memo: editTaskMemo.trim() || undefined,
      dueDate: editTaskDueDate || undefined,
      priority: editTaskPriority,
      projectId: editTaskProjectId,
    });
    resetEditTaskForm();
  }

  function handleToggleTaskDone(task: Task) {
    const nextStatus = task.status === "done" ? "todo" : "done";
    void updateTask({ ...task, status: nextStatus });
  }

  return {
    handleAddTask,
    handleSaveEditTask,
    handleToggleTaskDone,
  };
}
