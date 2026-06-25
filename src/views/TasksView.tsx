import type { FormEvent } from "react";
import { TaskCard } from "../components/TaskCard";
import { TaskForm } from "../components/TaskForm";
import type { Project, Task } from "../types";
import type { TaskSortOrder } from "../utils/taskFilters";

type TasksViewProps = {
  projects: Project[];
  filteredTasks: Task[];
  summaryTasks: Task[];
  sortedTasks: Task[];
  selectedProjectFilter: string;
  showCompletedTasks: boolean;
  taskSortOrder: TaskSortOrder;
  taskSearchQuery: string;
  isTaskFormOpen: boolean;
  newTaskTitle: string;
  newTaskMemo: string;
  newTaskDueDate: string;
  newTaskPriority: Task["priority"];
  newTaskProjectId: string;
  editingTaskId: string | null;
  editTaskTitle: string;
  editTaskMemo: string;
  editTaskDueDate: string;
  editTaskPriority: Task["priority"];
  editTaskProjectId: string;
  getProjectName: (projectId: string) => string;
  onTaskSearchQueryChange: (value: string) => void;
  onShowCompletedTasksChange: (value: boolean) => void;
  onTaskSortOrderChange: (value: TaskSortOrder) => void;
  onSelectedProjectFilterChange: (value: string) => void;
  onTaskFormOpenChange: (updater: (current: boolean) => boolean) => void;
  onNewTaskTitleChange: (value: string) => void;
  onNewTaskMemoChange: (value: string) => void;
  onNewTaskDueDateChange: (value: string) => void;
  onNewTaskPriorityChange: (value: Task["priority"]) => void;
  onNewTaskProjectIdChange: (value: string) => void;
  onEditTaskTitleChange: (value: string) => void;
  onEditTaskMemoChange: (value: string) => void;
  onEditTaskDueDateChange: (value: string) => void;
  onEditTaskPriorityChange: (value: Task["priority"]) => void;
  onEditTaskProjectIdChange: (value: string) => void;
  onAddTask: (event: FormEvent<HTMLFormElement>) => void;
  onSaveEditTask: (task: Task) => void;
  onCancelEditTask: () => void;
  onToggleTaskDone: (task: Task) => void;
  onDeleteTask: (task: Task) => void;
  onStartEditTask: (task: Task) => void;
};

export function TasksView({
  projects,
  filteredTasks,
  summaryTasks,
  sortedTasks,
  selectedProjectFilter,
  showCompletedTasks,
  taskSortOrder,
  taskSearchQuery,
  isTaskFormOpen,
  newTaskTitle,
  newTaskMemo,
  newTaskDueDate,
  newTaskPriority,
  newTaskProjectId,
  editingTaskId,
  editTaskTitle,
  editTaskMemo,
  editTaskDueDate,
  editTaskPriority,
  editTaskProjectId,
  getProjectName,
  onTaskSearchQueryChange,
  onShowCompletedTasksChange,
  onTaskSortOrderChange,
  onSelectedProjectFilterChange,
  onTaskFormOpenChange,
  onNewTaskTitleChange,
  onNewTaskMemoChange,
  onNewTaskDueDateChange,
  onNewTaskPriorityChange,
  onNewTaskProjectIdChange,
  onEditTaskTitleChange,
  onEditTaskMemoChange,
  onEditTaskDueDateChange,
  onEditTaskPriorityChange,
  onEditTaskProjectIdChange,
  onAddTask,
  onSaveEditTask,
  onCancelEditTask,
  onToggleTaskDone,
  onDeleteTask,
  onStartEditTask,
}: TasksViewProps) {
  const hasSearchQuery = taskSearchQuery.trim().length > 0;
  const hasProjectFilter = selectedProjectFilter !== "all";
  const hasVisibilityFilter = !showCompletedTasks;
  const completedTaskCount = summaryTasks.filter(
    (task) => task.status === "done",
  ).length;
  const inProgressTaskCount = summaryTasks.filter(
    (task) => task.status === "in_progress",
  ).length;
  const remainingTaskCount = summaryTasks.filter(
    (task) => task.status === "todo",
  ).length;
  const totalTaskSummary = showCompletedTasks
    ? `총 ${summaryTasks.length}개`
    : `표시 ${filteredTasks.length}개 / 조건 일치 ${summaryTasks.length}개`;
  const completedTaskSummary = showCompletedTasks
    ? `완료 ${completedTaskCount}개`
    : `완료 ${completedTaskCount}개(숨김)`;
  const emptyMessage =
    hasSearchQuery
      ? "검색 결과에 맞는 업무가 없어요."
      : hasProjectFilter || hasVisibilityFilter
        ? "선택한 조건에 표시할 업무가 없어요."
        : "아직 등록된 업무가 없어요.";
  const emptyActionMessage =
    hasSearchQuery
      ? "검색어를 줄이거나 비운 뒤 다시 확인해보세요."
      : hasProjectFilter && hasVisibilityFilter
        ? "프로젝트를 전체로 바꾸거나 완료 업무 표시를 켜서 숨은 업무를 확인해보세요."
        : hasProjectFilter
          ? "프로젝트를 전체로 바꾸면 다른 업무를 확인할 수 있어요."
          : hasVisibilityFilter
            ? "완료 업무 표시를 켜면 숨은 완료 업무를 확인할 수 있어요."
            : "작은 업무를 하나 추가하면 이 기기 안에 바로 저장돼요.";

  return (
    <section className="screen-card">
      <h2>전체 업무</h2>
      <p className="summary">
        {totalTaskSummary} · 진행 중 {inProgressTaskCount}개 ·{" "}
        {completedTaskSummary} · 남은 업무 {remainingTaskCount}개
      </p>

      <label>
        업무 검색
        <input
          type="text"
          value={taskSearchQuery}
          onChange={(event) => onTaskSearchQueryChange(event.target.value)}
          placeholder="업무 제목 또는 메모 내용을 검색하세요"
        />
      </label>

      <label>
        <input
          type="checkbox"
          checked={showCompletedTasks}
          onChange={(event) => onShowCompletedTasksChange(event.target.checked)}
        />
        완료 업무 표시
      </label>

      <label>
        정렬
        <select
          value={taskSortOrder}
          onChange={(event) =>
            onTaskSortOrderChange(event.target.value as TaskSortOrder)
          }
        >
          <option value="none">기본 순서</option>
          <option value="dueDateAsc">마감일 빠른 순</option>
        </select>
      </label>

      <label>
        프로젝트 필터
        <select
          value={selectedProjectFilter}
          onChange={(event) => onSelectedProjectFilterChange(event.target.value)}
        >
          <option value="all">전체 프로젝트</option>
          {projects.map((project) => (
            <option key={project.id} value={project.id}>
              {project.name}
            </option>
          ))}
        </select>
      </label>

      <button
        type="button"
        onClick={() => onTaskFormOpenChange((current) => !current)}
      >
        {isTaskFormOpen ? "작은 업무 추가 닫기" : "작은 업무 추가"}
      </button>

      {isTaskFormOpen && (
        <TaskForm
          title="새 작은 업무 추가"
          ariaLabel="새 작은 업무 추가"
          taskTitle={newTaskTitle}
          memo={newTaskMemo}
          dueDate={newTaskDueDate}
          priority={newTaskPriority}
          projectId={newTaskProjectId}
          projects={projects}
          submitLabel="로컬에 업무 추가"
          onTitleChange={onNewTaskTitleChange}
          onMemoChange={onNewTaskMemoChange}
          onDueDateChange={onNewTaskDueDateChange}
          onPriorityChange={onNewTaskPriorityChange}
          onProjectIdChange={onNewTaskProjectIdChange}
          onSubmit={onAddTask}
        />
      )}

      {filteredTasks.length === 0 ? (
        <div className="empty">
          <p>{emptyMessage}</p>
          <p>{emptyActionMessage}</p>
        </div>
      ) : (
        <ul className="task-list">
          {sortedTasks.map((task) => {
            if (editingTaskId === task.id) {
              return (
                <li key={task.id} className="task-card">
                  <TaskForm
                    title="업무 수정"
                    ariaLabel="업무 수정"
                    taskTitle={editTaskTitle}
                    memo={editTaskMemo}
                    dueDate={editTaskDueDate}
                    priority={editTaskPriority}
                    projectId={editTaskProjectId}
                    projects={projects}
                    submitLabel="수정 저장"
                    onTitleChange={onEditTaskTitleChange}
                    onMemoChange={onEditTaskMemoChange}
                    onDueDateChange={onEditTaskDueDateChange}
                    onPriorityChange={onEditTaskPriorityChange}
                    onProjectIdChange={onEditTaskProjectIdChange}
                    onSubmit={(event) => {
                      event.preventDefault();
                      onSaveEditTask(task);
                    }}
                    onCancel={onCancelEditTask}
                    className=""
                  />
                </li>
              );
            }

            return (
              <TaskCard
                key={task.id}
                task={task}
                projectName={getProjectName(task.projectId)}
                onToggleDone={onToggleTaskDone}
                onDelete={onDeleteTask}
                onStartEdit={onStartEditTask}
              />
            );
          })}
        </ul>
      )}
    </section>
  );
}
