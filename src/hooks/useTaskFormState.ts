import { useState } from "react";
import type { Task } from "../types";

export function useTaskFormState() {
  const [editingTaskId, setEditingTaskId] = useState<string | null>(null);
  const [editTaskTitle, setEditTaskTitle] = useState("");
  const [editTaskDueDate, setEditTaskDueDate] = useState("");
  const [editTaskPriority, setEditTaskPriority] = useState<Task["priority"]>("medium");
  const [editTaskMemo, setEditTaskMemo] = useState("");
  const [editTaskProjectId, setEditTaskProjectId] = useState("default");
  const [newTaskTitle, setNewTaskTitle] = useState("");
  const [newTaskDueDate, setNewTaskDueDate] = useState("");
  const [newTaskPriority, setNewTaskPriority] = useState<Task["priority"]>("medium");
  const [newTaskProjectId, setNewTaskProjectId] = useState("default");
  const [newTaskMemo, setNewTaskMemo] = useState("");
  const [isTaskFormOpen, setIsTaskFormOpen] = useState(false);

  function resetNewTaskForm() {
    setIsTaskFormOpen(false);
    setNewTaskTitle("");
    setNewTaskDueDate("");
    setNewTaskPriority("medium");
    setNewTaskProjectId("default");
    setNewTaskMemo("");
  }

  function resetEditTaskForm() {
    setEditingTaskId(null);
    setEditTaskTitle("");
    setEditTaskMemo("");
    setEditTaskDueDate("");
    setEditTaskPriority("medium");
    setEditTaskProjectId("default");
  }

  function startEditTask(task: Task) {
    setEditingTaskId(task.id);
    setEditTaskTitle(task.title);
    setEditTaskMemo(task.memo || "");
    setEditTaskDueDate(task.dueDate || "");
    setEditTaskPriority(task.priority);
    setEditTaskProjectId(task.projectId);
  }

  return {
    editingTaskId,
    editTaskTitle,
    editTaskDueDate,
    editTaskPriority,
    editTaskMemo,
    editTaskProjectId,
    newTaskTitle,
    newTaskDueDate,
    newTaskPriority,
    newTaskProjectId,
    newTaskMemo,
    isTaskFormOpen,
    setEditTaskTitle,
    setEditTaskDueDate,
    setEditTaskPriority,
    setEditTaskMemo,
    setEditTaskProjectId,
    setNewTaskTitle,
    setNewTaskDueDate,
    setNewTaskPriority,
    setNewTaskProjectId,
    setNewTaskMemo,
    setIsTaskFormOpen,
    resetNewTaskForm,
    resetEditTaskForm,
    startEditTask,
  };
}
