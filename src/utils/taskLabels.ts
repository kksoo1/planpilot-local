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
  switch (status) {
    case "in_progress":
      return "진행 중";
    case "done":
      return "완료";
    case "todo":
      return "남은 업무";
    default:
      return status;
  }
}
