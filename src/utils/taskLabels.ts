import type { Task } from "../types";

export function getPriorityLabel(priority: Task["priority"]) {
  switch (priority) {
    case "high":
      return "높음";
    case "medium":
      return "보통";
    case "low":
      return "낮음";
    default:
      return priority;
  }
}

export function getStatusLabel(status: Task["status"]) {
  return status === "done" ? "완료" : "미완료";
}
