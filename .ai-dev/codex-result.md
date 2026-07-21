# Codex Implementation Result

## Run

- Started at: 2026-07-21 15:34:00
- Ended at: 2026-07-21 15:36:25
- Exit code: 0
- Prompt: .ai-dev/current-task-prompt.md
- Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty

## Output

```text
node.exe : OpenAI Codex v0.133.0
At C:\Users\SECUI\AppData\Roaming\npm\codex.ps1:24 char:5
+     & "node$exe"  "$basedir/node_modules/@openai/codex/bin/codex.js"  ...
+     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (OpenAI Codex v0.133.0:String) 
    [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 
--------
workdir: D:\ai-apps\planpilot-local
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: medium
reasoning summaries: none
session id: 019f8361-9ed6-7b51-8153-d6ad01a4729f
--------
user
Read and follow the full task prompt at this absolute file path: D:\ai-apps
\planpilot-local\.ai-dev\current-task-prompt.md

Additional safety rules for this local AI Dev Loop run:
- Do not run git commit, git reset, git checkout, git clean, git rebase, gi
t merge, or git push.
- Do not run npm install.
- Do not modify package.json, package-lock.json, node_modules, dist, or .gi
t.
- Do not broaden the current task scope beyond the prompt file.
- If the task requirements conflict with repository rules, stop and report 
the conflict.
codex
작업 프롬프트 파일만 먼저 읽어서 요구 범위와 충돌 여부를 확인하겠습니다. 이후 필요한 파일만 추가로 읽겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\current-ta
sk-prompt.md'" in D:\ai-apps\planpilot-local
 succeeded in 1671ms:
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
병렬 task 실행 가능성 검토

## 배경
현재 PlanPilot Local의 task 처리 구조에서 여러 task를 동시에 진행하거나 표시할 수 있는지 확인하고, 실제 구현 전
에 필요한 변경 범위와 위험 요소를 작게 정리한다.

## 성공 기준
- 현재 task 데이터 구조와 화면 흐름에서 병렬 task 개념을 수용할 수 있는 지점을 확인한다.
- 병렬 task 실행을 위해 변경이 필요한 파일과 상태 흐름을 최소 범위로 정리한다.
- 즉시 구현 가능한 작은 후속 작업과 보류해야 할 항목을 구분한다.

## 제약사항
- 기존 사용자 데이터를 깨뜨리지 않는다.
- 기존 타입, store 액션, DB 구조를 우선 확인한다.
- 한 번에 하나의 기능만 다룬다.
- 큰 구조 변경이 필요하면 구현보다 검토 결과 정리를 우선한다.

## 범위 제외
- 실제 병렬 실행 UI 구현은 제외한다.
- 데이터 구조 변경은 제외한다.
- 알림 기능 추가는 제외한다.
- 대규모 화면 재구성은 제외한다.

## 수동 검증
- 관련 task 타입과 상태 흐름을 읽고 병렬 task 요구사항과 충돌하는 부분이 있는지 확인한다.
- 검토 결과가 작은 후속 구현 작업으로 이어질 만큼 구체적인지 확인한다.

## Current Task

- Task ID: T002
- Title: 검토 결과 정리
- Description: 병렬 task 실행 가능성, 필요한 후속 작업, 제외할 범위를 짧은 문서로 정리한다.
- Type: documentation
- Status: in_progress
- Priority: P2
- Depends on:
- T001

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

- .ai-dev/goal.md

## Verification

- 성공 기준과 제약사항이 검토 결과에 반영되어 있는지 확인한다.

- 필요한 경우 `npm run build`는 사람이 별도로 실행한다.
- 이 프롬프트는 자동으로 build, test, lint를 실행하라고 지시하지 않는다.

## Required Output

- 변경한 파일 목록
- 구현 또는 분석 내용 요약
- 검증 방법
- 남은 위험
- 다음 task로 넘어가도 되는지 여부
- `.ai-dev/loop-log.md`에 기록할 작업 요약

## Hard Rules

- `src` 외 파일을 수정해야 하는 경우 이유를 기록한다.
- `package.json`과 `package-lock.json`은 수정하지 않는다. 꼭 필요하면 중단하고 이유만 기록한다.
- 실제 DB 삭제 또는 초기화를 하지 않는다.
- 사용자 데이터 복원 또는 덮어쓰기를 하지 않는다.
- 현재 task와 무관한 UI 전면 개편을 하지 않는다.
- 대규모 리팩터링을 하지 않는다.
- git commit을 실행하지 않는다.
- git reset, git checkout, git clean을 실행하지 않는다.
- npm install을 실행하지 않는다.

## Stop Conditions

- 요구사항이 충돌하는 경우
- 현재 task 범위 밖 수정이 필요한 경우
- 패키지 추가가 필요한 경우
- 데이터 삭제 또는 마이그레이션이 필요한 경우
- 같은 오류가 반복되는 경우

codex
프롬프트상 산출물은 짧은 검토 문서이고, 예상 수정 파일은 `.ai-dev/goal.md`입니다. 병렬 task 수용 지점을 확인하려면
 타입, store, DB, 주요 화면 흐름을 읽어야 해서 해당 파일들만 좁게 탐색하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
rg --files -g '"'!node_modules'"' -g '"'!dist'"' -g '"'!*package-lock.json'
"'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\goal.md'" 
in D:\ai-apps\planpilot-local
 succeeded in 2174ms:
# 목표
병렬 task 실행 가능성 검토

## 배경
현재 PlanPilot Local의 task 처리 구조에서 여러 task를 동시에 진행하거나 표시할 수 있는지 확인하고, 실제 구현 전
에 필요한 변경 범위와 위험 요소를 작게 정리한다.

## 성공 기준
- 현재 task 데이터 구조와 화면 흐름에서 병렬 task 개념을 수용할 수 있는 지점을 확인한다.
- 병렬 task 실행을 위해 변경이 필요한 파일과 상태 흐름을 최소 범위로 정리한다.
- 즉시 구현 가능한 작은 후속 작업과 보류해야 할 항목을 구분한다.

## 제약사항
- 기존 사용자 데이터를 깨뜨리지 않는다.
- 기존 타입, store 액션, DB 구조를 우선 확인한다.
- 한 번에 하나의 기능만 다룬다.
- 큰 구조 변경이 필요하면 구현보다 검토 결과 정리를 우선한다.

## 범위 제외
- 실제 병렬 실행 UI 구현은 제외한다.
- 데이터 구조 변경은 제외한다.
- 알림 기능 추가는 제외한다.
- 대규모 화면 재구성은 제외한다.

## 수동 검증
- 관련 task 타입과 상태 흐름을 읽고 병렬 task 요구사항과 충돌하는 부분이 있는지 확인한다.
- 검토 결과가 작은 후속 구현 작업으로 이어질 만큼 구체적인지 확인한다.

 succeeded in 2731ms:
README.md
tsconfig.json
index.html
eslint.config.js
tsconfig.app.json
tsconfig.node.json
package.json
vite.config.ts
ROADMAP.md
AGENTS.md
scripts\monitor-and-dev-loop.ps1
scripts\ai-dev-status.ps1
scripts\ai-dev-save-review.ps1
scripts\ai-dev-save-diff.ps1
scripts\ai-dev-run-review-codex.ps1
scripts\ai-dev-run-codex.ps1
scripts\ai-dev-next.ps1
scripts\ai-dev-manual-cycle.ps1
scripts\ai-dev-make-revise-prompt.ps1
scripts\ai-dev-make-review-prompt.ps1
scripts\ai-dev-make-prompt.ps1
scripts\ai-dev-init.ps1
scripts\ai-dev-env.ps1
scripts\ai-dev-current-task.ps1
scripts\ai-dev-copy-review-prompt.ps1
scripts\ai-dev-complete-task.ps1
scripts\ai-dev-commit.ps1
scripts\ai-dev-check.ps1
scripts\ai-dev-autopilot.ps1
scripts\ai-dev-auto-step.ps1
scripts\ai-dev-auto-goal.ps1
scripts\ai-dev-auto-cycle.ps1
scripts\ai-dev-auto-cycle-full.ps1
public\icons.svg
public\favicon.svg
docs\manual-test-checklist.md
docs\manual-regression-test-result.md
docs\error-loading-state-policy.md
docs\data-import-restore-policy.md
docs\data-backup-export-policy.md
docs\codex-cli-automation-policy.md
docs\ai-dev-loop-policy.md
docs\ai-dev-loop-operation.md
memory-bank\productContext.md
memory-bank\activeContext.md
memory-bank\progress.md
memory-bank\technicalContext.md
src\App.css
src\App.tsx
src\db.ts
src\types.ts
src\store.ts
src\main.tsx
src\index.css
src\ai\RuleBasedAIProvider.ts
src\ai\recommendationScore.ts
src\ai\AIProvider.ts
src\assets\hero.png
src\components\TaskForm.tsx
src\components\TaskCard.tsx
src\components\ProjectForm.tsx
src\components\ProjectCard.tsx
src\assets\react.svg
src\assets\vite.svg
src\hooks\useTaskFormState.ts
src\hooks\useTaskActions.ts
src\hooks\useProjectFormState.ts
src\hooks\useProjectActions.ts
src\views\SettingsView.tsx
src\views\ProjectsView.tsx
src\views\TasksView.tsx
src\views\TodayView.tsx
src\utils\taskSummary.ts
src\utils\taskLabels.ts
src\utils\taskFilters.ts
src\utils\taskDates.ts
src\utils\projectStats.ts
src\utils\projectLookup.ts
src\utils\projectDeletion.ts
src\utils\importValidation.ts
src\utils\exportData.ts
src\utils\dateUtils.ts

codex
`.ai-dev/goal.md`는 목표 수준만 담고 있어, 현재 task 문서화를 위해 실제 코드 흐름에서 근거를 뽑아야 합니다. 이제
 task 타입, DB 스키마, store 액션, 화면에서 상태를 바꾸는 지점을 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath 'D:\\ai-apps\\planpilot-local\\src\\store.ts'" in 
D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath 'D:\\ai-apps\\planpilot-local\\src\\db.ts'" in D:\
ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath 'D:\\ai-apps\\planpilot-local\\src\\types.ts'" in 
D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '
rg -n "status|TaskStatus|in_progress|done|start|complete|active|tasks" src'
 in D:\ai-apps\planpilot-local
 succeeded in 3203ms:
// src/db.ts

import Dexie from "dexie";
import type { Table } from "dexie";
import type { Task, Project, StoredAppSettings } from "./types";

export class PlanPilotDatabase extends Dexie {
  tasks!: Table<Task, string>;
  projects!: Table<Project, string>;
  appSettings!: Table<StoredAppSettings, string>;

  constructor() {
    super("PlanPilotDatabase");
    this.version(1).stores({
      tasks: "id,projectId,status,sortOrder",
      projects: "id",
      appSettings: "id",
    });
  }

  async ensureDefaultData() {
    const defaultProjectId = "default";
    const defaultSettingsId = "app-settings";

    const projectExists = await this.projects.get(defaultProjectId);
    const settingsExists = await this.appSettings.get(defaultSettingsId);

    if (!projectExists) {
      await this.projects.add({
        id: defaultProjectId,
        name: "湲곕낯",
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
      });
    }

    if (!settingsExists) {
      await this.appSettings.add({
        id: defaultSettingsId,
        theme: "light",
        language: "ko",
        aiProvider: "rule_based",
        enableNotifications: false,
        firstLaunchCompleted: false,
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
      });
    }
  }
}

export const db = new PlanPilotDatabase();

 succeeded in 3215ms:
// src/types.ts

export type Task = {
  id: string;
  title: string;
  memo?: string;
  dueDate?: string;
  priority: "low" | "medium" | "high";
  status: "todo" | "in_progress" | "done";
  projectId: string;
  tags: string[];
  estimatedMinutes?: number;
  createdAt: string;
  updatedAt: string;
  completedAt?: string;
  sortOrder?: number;
};

export type Project = {
  id: string;
  name: string;
  description?: string;
  color?: string;
  createdAt: string;
  updatedAt: string;
  archivedAt?: string;
};

export type AppSettings = {
  theme: "light";
  language: "ko";
  aiProvider: "rule_based";
  enableNotifications: false;
  firstLaunchCompleted: boolean;
  createdAt: string;
  updatedAt: string;
};

export type StoredAppSettings = AppSettings & {
  id: string;
};

 succeeded in 3314ms:
// src/store.ts

import { create } from "zustand";
import { db } from "./db";
import type { Task, Project, AppSettings } from "./types";

// Helper function to create a unique ID
function createId() {
  if (globalThis.crypto?.randomUUID) {
    return globalThis.crypto.randomUUID();
  }
  return Date.now().toString();
}

interface StoreState {
  tasks: Task[];
  projects: Project[];
  appSettings: AppSettings;
}

interface StoreActions {
  initializeApp: () => Promise<void>;
  fetchTasks: () => Promise<void>;
  fetchProjects: () => Promise<void>;
  fetchAppSettings: () => Promise<void>;
  addTask: (input: CreateTaskInput) => Promise<void>;
  updateTask: (task: Task) => Promise<void>;
  deleteTask: (taskId: string) => Promise<void>;
  addProject: (input: CreateProjectInput) => Promise<void>;
  updateProject: (project: Project) => Promise<void>;
  deleteProject: (projectId: string) => Promise<void>;
  updateAppSettings: (settings: AppSettings) => Promise<void>;
}

type CreateTaskInput = {
  title: string;
  memo?: string;
  dueDate?: string;
  priority?: Task["priority"];
  status?: Task["status"];
  projectId?: string;
  tags?: string[];
  estimatedMinutes?: number;
  sortOrder?: number;
};

type CreateProjectInput = {
  name: string;
  description?: string;
  color?: string;
};

const initialState: StoreState = {
  tasks: [],
  projects: [],
  appSettings: {
    theme: "light",
    language: "ko",
    aiProvider: "rule_based",
    enableNotifications: false,
    firstLaunchCompleted: false,
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
};

type Store = StoreState & StoreActions;

export const useStore = create<Store>((set, get) => ({
  ...initialState,
  initializeApp: async () => {
    await db.ensureDefaultData();
    await get().fetchTasks();
    await get().fetchProjects();
    await get().fetchAppSettings();
  },
  fetchTasks: async () => {
    const tasks = await db.tasks.toArray();
    set({ tasks });
  },
  fetchProjects: async () => {
    const projects = await db.projects.toArray();
    set({ projects });
  },
  fetchAppSettings: async () => {
    const settings = await db.appSettings.get("app-settings");
    if (settings) {
      const appSettings: AppSettings = {
        theme: settings.theme,
        language: settings.language,
        aiProvider: settings.aiProvider,
        enableNotifications: settings.enableNotifications,
        firstLaunchCompleted: settings.firstLaunchCompleted,
        createdAt: settings.createdAt,
        updatedAt: settings.updatedAt,
      };
      set({ appSettings });
    }
  },
  addTask: async (input) => {
    const id = createId();
    const now = new Date().toISOString();
    const task: Task = {
      id,
      title: input.title,
      priority: input.priority ?? "medium",
      status: input.status ?? "todo",
      projectId: input.projectId ?? "default",
      tags: input.tags ?? [],
      createdAt: now,
      updatedAt: now,
    };

    if (input.memo) task.memo = input.memo;
    if (input.dueDate) task.dueDate = input.dueDate;
    if (input.estimatedMinutes !== undefined) task.estimatedMinutes = input
.estimatedMinutes;
    if (input.sortOrder !== undefined) task.sortOrder = input.sortOrder;

    await db.tasks.add(task);
    set((state) => ({ tasks: [...state.tasks, task] }));
  },
  updateTask: async (task) => {
    const updatedTask: Task = {
      ...task,
      updatedAt: new Date().toISOString(),
    };

    if (updatedTask.status === "done") {
      updatedTask.completedAt = updatedTask.completedAt || new Date().toISO
String();
    } else {
      delete updatedTask.completedAt;
    }

    await db.tasks.put(updatedTask);
    set((state) => ({
      tasks: state.tasks.map((t) => (t.id === task.id ? updatedTask : t)),
    }));
  },
  deleteTask: async (taskId) => {
    await db.tasks.delete(taskId);
    set((state) => ({ tasks: state.tasks.filter((t) => t.id !== taskId) }))
;
  },
  addProject: async (input) => {
    const id = createId();
    const now = new Date().toISOString();
    const project: Project = {
      id,
      name: input.name,
      description: input.description ?? "",
      color: input.color ?? "",
      createdAt: now,
      updatedAt: now,
    };

    await db.projects.add(project);
    set((state) => ({ projects: [...state.projects, project] }));
  },
  updateProject: async (project) => {
    const updatedProject = {
      ...project,
      updatedAt: new Date().toISOString(),
    };
    await db.projects.put(updatedProject);
    set((state) => ({
      projects: state.projects.map((p) => (p.id === project.id ? updatedPro
ject : p)),
    }));
  },
  deleteProject: async (projectId) => {
    if (projectId === "default") {
      throw new Error("Cannot delete the default project");
    }
    await db.projects.delete(projectId);
    set((state) => ({ projects: state.projects.filter((p) => p.id !== proje
ctId) }));
  },
  updateAppSettings: async (settings) => {
    const updatedSettings: AppSettings = {
      ...settings,
      updatedAt: new Date().toISOString(),
    };

    await db.appSettings.put({ ...updatedSettings, id: "app-settings" });
    set({ appSettings: updatedSettings });
  },
}));

 succeeded in 3851ms:
src\App.css:192:button:active {
src\App.css:273:.bottom-nav button.active {
src\App.tsx:8:import { startOfToday } from "./utils/dateUtils";
src\App.tsx:20:type Tab = "today" | "tasks" | "projects" | "settings";
src\App.tsx:23:  const [activeTab, setActiveTab] = useState<Tab>("today");
src\App.tsx:30:  const { tasks, projects, appSettings, initializeApp, addTa
sk, updateTask, deleteTask, deleteProject, addProject, updateProject } = us
eStore();
src\App.tsx:58:    startEditTask,
src\App.tsx:90:    startEditProject,
src\App.tsx:97:    tasks,
src\App.tsx:106:  const today = startOfToday();
src\App.tsx:108:  const overdueTasks = getOverdueTasks(tasks, today);
src\App.tsx:109:  const upcomingTasks = getUpcomingTasks(tasks, today, 7);
src\App.tsx:110:  const taskSummary = getTaskSummary(tasks);
src\App.tsx:112:  const filteredTasks = filterTasks(tasks, {
src\App.tsx:119:  const summaryTasks = filterTasks(tasks, {
src\App.tsx:135:    void aiProvider.suggestTodayTasks(tasks, 3).then(setRec
ommendedTasks);
src\App.tsx:136:  }, [aiProvider, tasks]);
src\App.tsx:147:{activeTab === "today" && (
src\App.tsx:150:    completedTasks={taskSummary.completedTasks}
src\App.tsx:158:        {activeTab === "tasks" && (
src\App.tsx:201:            onStartEditTask={startEditTask}
src\App.tsx:205:        {activeTab === "projects" && (
src\App.tsx:208:            tasks={tasks}
src\App.tsx:222:            onStartEditProject={startEditProject}
src\App.tsx:226:        {activeTab === "settings" && (
src\App.tsx:229:            tasks={tasks}
src\App.tsx:237:          className={activeTab === "today" ? "active" : ""}
src\App.tsx:243:          className={activeTab === "tasks" ? "active" : ""}
src\App.tsx:244:          onClick={() => setActiveTab("tasks")}
src\App.tsx:249:          className={activeTab === "projects" ? "active" : 
""}
src\App.tsx:255:          className={activeTab === "settings" ? "active" : 
""}
src\db.ts:8:  tasks!: Table<Task, string>;
src\db.ts:15:      tasks: "id,projectId,status,sortOrder",
src\store.ts:16:  tasks: Task[];
src\store.ts:40:  status?: Task["status"];
src\store.ts:54:  tasks: [],
src\store.ts:78:    const tasks = await db.tasks.toArray();
src\store.ts:79:    set({ tasks });
src\store.ts:107:      status: input.status ?? "todo",
src\store.ts:119:    await db.tasks.add(task);
src\store.ts:120:    set((state) => ({ tasks: [...state.tasks, task] }));
src\store.ts:128:    if (updatedTask.status === "done") {
src\store.ts:129:      updatedTask.completedAt = updatedTask.completedAt ||
 new Date().toISOString();
src\store.ts:131:      delete updatedTask.completedAt;
src\store.ts:134:    await db.tasks.put(updatedTask);
src\store.ts:136:      tasks: state.tasks.map((t) => (t.id === task.id ? up
datedTask : t)),
src\store.ts:140:    await db.tasks.delete(taskId);
src\store.ts:141:    set((state) => ({ tasks: state.tasks.filter((t) => t.i
d !== taskId) }));
src\ai\recommendationScore.ts:2:import { parseDueDate, startOfToday } from 
"../utils/dateUtils";
src\ai\recommendationScore.ts:18:  const today = startOfToday();
src\ai\AIProvider.ts:6:  suggestTodayTasks(tasks: Task[], limit?: number): 
Promise<Task[]>;
src\ai\AIProvider.ts:7:  findOverdueTasks(tasks: Task[]): Promise<Task[]>;
src\ai\AIProvider.ts:8:  findUpcomingTasks(tasks: Task[], days?: number): P
romise<Task[]>;
src\ai\AIProvider.ts:9:  summarizeTasks(tasks: Task[]): Promise<string>;
src\types.ts:9:  status: "todo" | "in_progress" | "done";
src\types.ts:15:  completedAt?: string;
src\ai\RuleBasedAIProvider.ts:9:  startOfToday,
src\ai\RuleBasedAIProvider.ts:13:  async suggestTodayTasks(tasks: Task[], l
imit = 3): Promise<Task[]> {
src\ai\RuleBasedAIProvider.ts:14:    const filteredTasks = tasks
src\ai\RuleBasedAIProvider.ts:15:      .filter(task => task.status !== "don
e")
src\ai\RuleBasedAIProvider.ts:21:  async findOverdueTasks(tasks: Task[]): P
romise<Task[]> {
src\ai\RuleBasedAIProvider.ts:22:    const today = startOfToday();
src\ai\RuleBasedAIProvider.ts:23:    return tasks.filter((task) => isOverdu
eTask(task, today));
src\ai\RuleBasedAIProvider.ts:26:  async findUpcomingTasks(tasks: Task[], d
ays = 7): Promise<Task[]> {
src\ai\RuleBasedAIProvider.ts:27:    const today = startOfToday();
src\ai\RuleBasedAIProvider.ts:28:    return tasks.filter((task) => isUpcomi
ngTask(task, today, days));
src\ai\RuleBasedAIProvider.ts:31:  async summarizeTasks(tasks: Task[]): Pro
mise<string> {
src\ai\RuleBasedAIProvider.ts:32:    const totalTasks = tasks.length;
src\ai\RuleBasedAIProvider.ts:33:    const completedTasks = tasks.filter(ta
sk => task.status === "done").length;
src\ai\RuleBasedAIProvider.ts:34:    const incompleteTasks = totalTasks - c
ompletedTasks;
src\ai\RuleBasedAIProvider.ts:35:    const overdueTasks = await this.findOv
erdueTasks(tasks);
src\ai\RuleBasedAIProvider.ts:36:    const upcomingTasks = await this.findU
pcomingTasks(tasks, 7);
src\ai\RuleBasedAIProvider.ts:38:    return `총 업무 수: ${totalTasks}, 완료 업무 수
: ${completedTasks}, 미완료 업무 수: ${incompleteTasks}, 지난 마감 업무 수: ${overdueTas
ks.length}, 7일 이내 마감 업무 수: ${upcomingTasks.length}`;
src\components\ProjectCard.tsx:6:  completedTasks: number;
src\components\ProjectCard.tsx:7:  incompleteTasks: number;
src\components\ProjectCard.tsx:31:        완료: {stats.completedTasks}개<br />
src\components\ProjectCard.tsx:32:        미완료: {stats.incompleteTasks}개
src\components\ProjectCard.tsx:39:        {deleteBlockReason === "default-p
roject" ? "기본 프로젝트" : deleteBlockReason === "has-tasks" ? "업무 있음" : "삭제"}
src\components\TaskCard.tsx:29:            alignSelf: "flex-start",
src\components\TaskCard.tsx:43:        중요도: {getPriorityLabel(task.priority
)} · 상태: {getStatusLabel(task.status)} · 프로젝트: {projectName}
src\components\TaskCard.tsx:49:          task.status === "done"
src\components\TaskCard.tsx:55:        {task.status === "done" ? "미완료로 되돌리기
" : "업무 완료로 표시"}
src\hooks\useProjectActions.ts:13:  tasks: Task[];
src\hooks\useProjectActions.ts:29:  tasks,
src\hooks\useProjectActions.ts:67:    if (getProjectDeleteBlockReason(proje
ct, tasks)) return;
src\utils\exportData.ts:4:  tasks: Task[];
src\utils\exportData.ts:10:  tasks,
src\utils\exportData.ts:21:    tasks,
src\hooks\useTaskActions.ts:87:    const nextStatus = task.status === "done
" ? "todo" : "done";
src\hooks\useTaskActions.ts:88:    void updateTask({ ...task, status: nextS
tatus });
src\utils\dateUtils.ts:3:export function startOfToday() {
src\utils\dateUtils.ts:23:export function isOverdueTask(task: Task, today =
 startOfToday()) {
src\utils\dateUtils.ts:24:  if (task.status === "done") return false;
src\utils\dateUtils.ts:29:export function isUpcomingTask(task: Task, today 
= startOfToday(), days = 7) {
src\utils\dateUtils.ts:30:  if (task.status === "done") return false;
src\hooks\useProjectFormState.ts:22:  function startEditProject(project: Pr
oject) {
src\hooks\useProjectFormState.ts:40:    startEditProject,
src\views\ProjectsView.tsx:10:  tasks: Task[];
src\views\ProjectsView.tsx:29:  tasks,
src\views\ProjectsView.tsx:66:            const stats = getProjectTaskStats
(tasks, project.id);
src\views\ProjectsView.tsx:67:            const deleteBlockReason = getProj
ectDeleteBlockReason(project, tasks);
src\views\SettingsView.tsx:11:  tasks: Task[];
src\views\SettingsView.tsx:15:export function SettingsView({ appSettings, t
asks, projects }: SettingsViewProps) {
src\views\SettingsView.tsx:23:      const { filename } = exportPlanPilotDat
a({ tasks, projects, appSettings });
src\hooks\useTaskFormState.ts:36:  function startEditTask(task: Task) {
src\hooks\useTaskFormState.ts:71:    startEditTask,
src\utils\importValidation.ts:7:const TASK_STATUSES: Task["status"][] = ["t
odo", "in_progress", "done"];
src\utils\importValidation.ts:26:  tasks?: unknown;
src\utils\importValidation.ts:43:  const tasks = Array.isArray(backup.tasks
) ? backup.tasks : [];
src\utils\importValidation.ts:46:  if (!Array.isArray(backup.tasks)) {
src\utils\importValidation.ts:47:    errors.push("tasks는 배열이어야 합니다.");
src\utils\importValidation.ts:59:  validateTasks(tasks, projects, errors);
src\utils\importValidation.ts:70:      taskCount: tasks.length,
src\utils\importValidation.ts:92:  tasks: unknown[],
src\utils\importValidation.ts:101:  tasks.forEach((task, index) => {
src\utils\importValidation.ts:102:    const label = `tasks[${index}]`;
src\utils\importValidation.ts:119:    if (!TASK_STATUSES.includes(task.stat
us as Task["status"])) {
src\utils\importValidation.ts:120:      errors.push(`${label}.status는 todo,
 in_progress, done 중 하나여야 합니다.`);
src\utils\importValidation.ts:128:    validateOptionalString(task, "complet
edAt", label, errors);
src\utils\projectDeletion.ts:4:export type ProjectDeleteBlockReason = "defa
ult-project" | "has-tasks";
src\utils\projectDeletion.ts:8:  tasks: Task[],
src\utils\projectDeletion.ts:14:  const stats = getProjectTaskStats(tasks, 
project.id);
src\utils\projectDeletion.ts:16:    return "has-tasks";
src\utils\projectDeletion.ts:22:export function canDeleteProject(project: P
roject, tasks: Task[]) {
src\utils\projectDeletion.ts:23:  return getProjectDeleteBlockReason(projec
t, tasks) === null;
src\views\TasksView.tsx:99:  const completedTaskCount = summaryTasks.filter
(
src\views\TasksView.tsx:100:    (task) => task.status === "done",
src\views\TasksView.tsx:103:    (task) => task.status === "in_progress",
src\views\TasksView.tsx:106:    (task) => task.status === "todo",
src\views\TasksView.tsx:111:  const completedTaskSummary = showCompletedTas
ks
src\views\TasksView.tsx:112:    ? `완료 ${completedTaskCount}개`
src\views\TasksView.tsx:113:    : `완료 ${completedTaskCount}개(숨김)`;
src\views\TasksView.tsx:136:        {completedTaskSummary} · 남은 업무 {remaini
ngTaskCount}개
src\views\TodayView.tsx:6:  completedTasks: number;
src\views\TodayView.tsx:15:  completedTasks,
src\views\TodayView.tsx:26:        완료 업무 수: {completedTasks}개<br />
src\views\TodayView.tsx:41:                중요도: {getPriorityLabel(task.prio
rity)} · 상태: {getStatusLabel(task.status)} · 프로젝트: {getProjectName(task.pro
jectId)}
src\utils\projectStats.ts:3:export function getProjectTaskStats(tasks: Task
[], projectId: string) {
src\utils\projectStats.ts:4:  const projectTasks = tasks.filter((task) => t
ask.projectId === projectId);
src\utils\projectStats.ts:6:  const completedTasks = projectTasks.filter((t
ask) => task.status === "done").length;
src\utils\projectStats.ts:7:  const incompleteTasks = totalTasks - complete
dTasks;
src\utils\projectStats.ts:9:  return { totalTasks, completedTasks, incomple
teTasks };
src\utils\taskDates.ts:4:export function getOverdueTasks(tasks: Task[], tod
ay: Date) {
src\utils\taskDates.ts:5:  return tasks.filter((task) => isOverdueTask(task
, today));
src\utils\taskDates.ts:8:export function getUpcomingTasks(tasks: Task[], to
day: Date, days: number) {
src\utils\taskDates.ts:9:  return tasks.filter((task) => isUpcomingTask(tas
k, today, days));
src\utils\taskFilters.ts:13:  tasks: Task[],
src\utils\taskFilters.ts:25:  return tasks.filter((task) => {
src\utils\taskFilters.ts:38:    const matchesStatus = showCompletedTasks ||
 task.status !== "done";
src\utils\taskFilters.ts:44:export function sortTasks(tasks: Task[], taskSo
rtOrder: TaskSortOrder) {
src\utils\taskFilters.ts:45:  return [...tasks].sort((a, b) => {
src\utils\taskLabels.ts:16:export function getStatusLabel(status: Task["sta
tus"]) {
src\utils\taskLabels.ts:17:  switch (status) {
src\utils\taskLabels.ts:18:    case "in_progress":
src\utils\taskLabels.ts:20:    case "done":
src\utils\taskLabels.ts:25:      return status;
src\utils\taskSummary.ts:3:export function getTaskSummary(tasks: Task[]) {
src\utils\taskSummary.ts:4:  const totalTasks = tasks.length;
src\utils\taskSummary.ts:5:  const completedTasks = tasks.filter((task) => 
task.status === "done").length;
src\utils\taskSummary.ts:7:  return { totalTasks, completedTasks };

codex
핵심 구조는 `Task.status`가 이미 `todo | in_progress | done`이고 DB 인덱스도 `status`를 포함
합니다. 이제 상태 변경 UI가 실제로 `in_progress`를 쓰는지, 목록/추천/요약이 여러 진행 중 업무를 막는지 확인하겠습니다
.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath 'D:\\ai-apps\\planpilot-local\\src\\hooks\\useTask
Actions.ts'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath 'D:\\ai-apps\\planpilot-local\\src\\views\\TasksVi
ew.tsx'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath 'D:\\ai-apps\\planpilot-local\\src\\components\\Ta
skCard.tsx'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath 'D:\\ai-apps\\planpilot-local\\src\\views\\TodayVi
ew.tsx'" in D:\ai-apps\planpilot-local
 succeeded in 3087ms:
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
  deleteTask: (taskId: string) => Promise<void>;
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
  deleteTask,
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

  function handleDeleteTask(task: Task) {
    if (window.confirm("?뺣쭚濡????낅Т瑜???젣?섏떆寃좎뒿?덇퉴?")) {
      void deleteTask(task.id);
    }
  }

  return {
    handleAddTask,
    handleSaveEditTask,
    handleToggleTaskDone,
    handleDeleteTask,
  };
}

 succeeded in 3187ms:
import { getPriorityLabel, getStatusLabel } from "../utils/taskLabels";
import { isUpcomingTask } from "../utils/dateUtils";
import type { Task } from "../types";

type TaskCardProps = {
  task: Task;
  projectName: string;
  onToggleDone: (task: Task) => void;
  onDelete: (task: Task) => void;
  onStartEdit: (task: Task) => void;
};

export function TaskCard({
  task,
  projectName,
  onToggleDone,
  onDelete,
  onStartEdit,
}: TaskCardProps) {
  const showDueSoonBadge = isUpcomingTask(task);

  return (
    <li className="task-card">
      <strong>{task.title}</strong>
      {showDueSoonBadge && (
        <span
          aria-label="留덇컧?쇱씠 怨??ㅺ??ㅻ뒗 ?낅Т?낅땲??
          style={{
            alignSelf: "flex-start",
            border: "1px solid #d97706",
            borderRadius: "999px",
            color: "#92400e",
            fontSize: "0.78rem",
            fontWeight: 700,
            padding: "0.15rem 0.5rem",
          }}
        >
          留덇컧 ?꾨컯
        </span>
      )}
      {task.memo && <span>硫붾え: {task.memo}</span>}
      <span>
        以묒슂?? {getPriorityLabel(task.priority)} 쨌 ?곹깭: {getStatusLabel(task
.status)} 쨌 ?꾨줈?앺듃: {projectName}
      </span>
      <span>{task.dueDate ? `留덇컧?? ${task.dueDate}` : "留덇컧???놁쓬"}</span>
      <button
        type="button"
        aria-label={
          task.status === "done"
            ? `'${task.title}' ?낅Т瑜?誘몄셿猷뚮줈 ?섎룎由ш린`
            : `'${task.title}' ?낅Т瑜??꾨즺濡??쒖떆?섍린`
        }
        onClick={() => onToggleDone(task)}
      >
        {task.status === "done" ? "誘몄셿猷뚮줈 ?섎룎由ш린" : "?낅Т ?꾨즺濡??쒖떆"}
      </button>
      <button
        type="button"
        aria-label={`'${task.title}' ?낅Т ??젣?섍린`}
        onClick={() => onDelete(task)}
      >
        ?낅Т ??젣
      </button>
      <button
        type="button"
        aria-label={`'${task.title}' ?낅Т ?섏젙?섍린`}
        onClick={() => onStartEdit(task)}
      >
        ?낅Т ?섏젙
      </button>
    </li>
  );
}

 succeeded in 3235ms:
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
    ? `珥?${summaryTasks.length}媛?
    : `?쒖떆 ${filteredTasks.length}媛?/ 議곌굔 ?쇱튂 ${summaryTasks.length}媛?;
  const completedTaskSummary = showCompletedTasks
    ? `?꾨즺 ${completedTaskCount}媛?
    : `?꾨즺 ${completedTaskCount}媛??④?)`;
  const emptyMessage =
    hasSearchQuery
      ? "寃??寃곌낵??留욌뒗 ?낅Т媛 ?놁뼱??"
      : hasProjectFilter || hasVisibilityFilter
        ? "?좏깮??議곌굔???쒖떆???낅Т媛 ?놁뼱??"
        : "?꾩쭅 ?깅줉???낅Т媛 ?놁뼱??";
  const emptyActionMessage =
    hasSearchQuery
      ? "寃?됱뼱瑜?以꾩씠嫄곕굹 鍮꾩슫 ???ㅼ떆 ?뺤씤?대낫?몄슂."
      : hasProjectFilter && hasVisibilityFilter
        ? "?꾨줈?앺듃瑜??꾩껜濡?諛붽씀嫄곕굹 ?꾨즺 ?낅Т ?쒖떆瑜?耳쒖꽌 ?⑥? ?낅Т瑜??뺤씤?대낫?몄슂."
        : hasProjectFilter
          ? "?꾨줈?앺듃瑜??꾩껜濡?諛붽씀硫??ㅻⅨ ?낅Т瑜??뺤씤?????덉뼱??"
          : hasVisibilityFilter
            ? "?꾨즺 ?낅Т ?쒖떆瑜?耳쒕㈃ ?⑥? ?꾨즺 ?낅Т瑜??뺤씤?????덉뼱??"
            : "?묒? ?낅Т瑜??섎굹 異붽??섎㈃ ??湲곌린 ?덉뿉 諛붾줈 ??λ뤌??";

  return (
    <section className="screen-card">
      <h2>?꾩껜 ?낅Т</h2>
      <p className="summary">
        {totalTaskSummary} 쨌 吏꾪뻾 以?{inProgressTaskCount}媛?쨌{" "}
        {completedTaskSummary} 쨌 ?⑥? ?낅Т {remainingTaskCount}媛?
      </p>

      <label>
        ?낅Т 寃??
        <input
          type="text"
          value={taskSearchQuery}
          onChange={(event) => onTaskSearchQueryChange(event.target.value)}
          placeholder="?낅Т ?쒕ぉ ?먮뒗 硫붾え ?댁슜??寃?됲븯?몄슂"
        />
      </label>

      <label>
        <input
          type="checkbox"
          checked={showCompletedTasks}
          onChange={(event) => onShowCompletedTasksChange(event.target.chec
ked)}
        />
        ?꾨즺 ?낅Т ?쒖떆
      </label>

      <label>
        ?뺣젹
        <select
          value={taskSortOrder}
          onChange={(event) =>
            onTaskSortOrderChange(event.target.value as TaskSortOrder)
          }
        >
          <option value="none">湲곕낯 ?쒖꽌</option>
          <option value="dueDateAsc">留덇컧??鍮좊Ⅸ ??/option>
        </select>
      </label>

      <label>
        ?꾨줈?앺듃 ?꾪꽣
        <select
          value={selectedProjectFilter}
          onChange={(event) => onSelectedProjectFilterChange(event.target.v
alue)}
        >
          <option value="all">?꾩껜 ?꾨줈?앺듃</option>
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
        {isTaskFormOpen ? "?묒? ?낅Т 異붽? ?リ린" : "?묒? ?낅Т 異붽?"}
      </button>

      {isTaskFormOpen && (
        <TaskForm
          title="???묒? ?낅Т 異붽?"
          ariaLabel="???묒? ?낅Т 異붽?"
          taskTitle={newTaskTitle}
          memo={newTaskMemo}
          dueDate={newTaskDueDate}
          priority={newTaskPriority}
          projectId={newTaskProjectId}
          projects={projects}
          submitLabel="濡쒖뺄???낅Т 異붽?"
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
                    title="?낅Т ?섏젙"
                    ariaLabel="?낅Т ?섏젙"
                    taskTitle={editTaskTitle}
                    memo={editTaskMemo}
                    dueDate={editTaskDueDate}
                    priority={editTaskPriority}
                    projectId={editTaskProjectId}
                    projects={projects}
                    submitLabel="?섏젙 ???
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

 succeeded in 3293ms:
import { getPriorityLabel, getStatusLabel } from "../utils/taskLabels";
import type { Task } from "../types";

type TodayViewProps = {
  totalTasks: number;
  completedTasks: number;
  recommendedTasks: Task[];
  overdueTasks: Task[];
  upcomingTasks: Task[];
  getProjectName: (projectId: string) => string;
};

export function TodayView({
  totalTasks,
  completedTasks,
  recommendedTasks,
  overdueTasks,
  upcomingTasks,
  getProjectName,
}: TodayViewProps) {
  return (
    <section className="screen-card">
      <h2>?ㅻ뒛</h2>
      <p className="summary">
        ?꾩껜 ?낅Т ?? {totalTasks}媛?br />
        ?꾨즺 ?낅Т ?? {completedTasks}媛?br />
        吏??留덇컧 ?낅Т ?? {overdueTasks.length}媛?br />
        7???대궡 留덇컧 ?낅Т ?? {upcomingTasks.length}媛?      </p>
      <p className="summary">異붿쿇 ?낅Т {recommendedTasks.length}媛?/p>

      {recommendedTasks.length === 0 ? (
        <p className="empty">異붿쿇??誘몄셿猷??낅Т媛 ?놁뒿?덈떎.</p>
      ) : (
        <ul className="task-list">
          {recommendedTasks.map((task) => (
            <li key={task.id} className="task-card">
              <strong>{task.title}</strong>
              {task.memo && <span>硫붾え: {task.memo}</span>}
              <span>
                以묒슂?? {getPriorityLabel(task.priority)} 쨌 ?곹깭: {getStatusLa
bel(task.status)} 쨌 ?꾨줈?앺듃: {getProjectName(task.projectId)}
              </span>
              <span>{task.dueDate ? `留덇컧?? ${task.dueDate}` : "留덇컧???놁쓬"}</
span>
            </li>
          ))}
        </ul>
      )}

      <h3>吏??留덇컧 ?낅Т</h3>
      {overdueTasks.length === 0 ? (
        <p className="empty">吏??留덇컧?쇱쓣 ?섍릿 誘몄셿猷??낅Т媛 ?놁뒿?덈떎.</p>
      ) : (
        <ul className="task-list">
          {overdueTasks.map((task) => (
            <li key={task.id} className="task-card">
              <strong>{task.title}</strong>
              {task.memo && <span>硫붾え: {task.memo}</span>}
              <span>
                ?꾨줈?앺듃: {getProjectName(task.projectId)} 쨌 留덇컧?? {task.dueD
ate}
              </span>
            </li>
          ))}
        </ul>
      )}

      <h3>7???대궡 留덇컧 ?낅Т</h3>
      {upcomingTasks.length === 0 ? (
        <p className="empty">7???대궡??留덇컧?섎뒗 誘몄셿猷??낅Т媛 ?놁뒿?덈떎.</p>
      ) : (
        <ul className="task-list">
          {upcomingTasks.map((task) => (
            <li key={task.id} className="task-card">
              <strong>{task.title}</strong>
              {task.memo && <span>硫붾え: {task.memo}</span>}
              <span>
                ?꾨줈?앺듃: {getProjectName(task.projectId)} 쨌 留덇컧?? {task.dueD
ate}
              </span>
            </li>
          ))}
        </ul>
      )}
    </section>
  );
}

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath 'D:\\ai-apps\\planpilot-local\\src\\components\\Ta
skForm.tsx'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath 'D:\\ai-apps\\planpilot-local\\src\\App.tsx'" in D
:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath 'D:\\ai-apps\\planpilot-local\\src\\utils\\taskFil
ters.ts'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath 'D:\\ai-apps\\planpilot-local\\src\\utils\\taskLab
els.ts'" in D:\ai-apps\planpilot-local
 succeeded in 3324ms:
import type { Project, Task } from "../types";

export type TaskSortOrder = "none" | "dueDateAsc";

type FilterTasksOptions = {
  selectedProjectFilter: string;
  showCompletedTasks: boolean;
  taskSearchQuery: string;
  projects?: Project[];
};

export function filterTasks(
  tasks: Task[],
  {
    selectedProjectFilter,
    showCompletedTasks,
    taskSearchQuery,
    projects = [],
  }: FilterTasksOptions,
) {
  const projectNameById = new Map(
    projects.map((project) => [project.id, project.name.toLowerCase()]),
  );

  return tasks.filter((task) => {
    const matchesProject =
      selectedProjectFilter === "all" || task.projectId === selectedProject
Filter;

    const searchText = taskSearchQuery.trim().toLowerCase();
    const searchableText = [
      task.title,
      task.memo ?? "",
      projectNameById.get(task.projectId) ?? "",
    ].join(" ");
    const matchesSearch =
      !searchText || searchableText.toLowerCase().includes(searchText);

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

 succeeded in 3330ms:
import type { Task } from "../types";

export function getPriorityLabel(priority: Task["priority"]) {
  switch (priority) {
    case "high":
      return "?믪쓬";
    case "medium":
      return "蹂댄넻";
    case "low":
      return "??쓬";
    default:
      return priority;
  }
}

export function getStatusLabel(status: Task["status"]) {
  switch (status) {
    case "in_progress":
      return "吏꾪뻾 以?;
    case "done":
      return "?꾨즺";
    case "todo":
      return "?⑥? ?낅Т";
    default:
      return status;
  }
}

 succeeded in 3422ms:
import type { FormEvent } from "react";
import type { Project, Task } from "../types";

type TaskFormProps = {
  title: string;
  ariaLabel: string;
  taskTitle: string;
  memo: string;
  dueDate: string;
  priority: Task["priority"];
  projectId: string;
  projects: Project[];
  submitLabel: string;
  onTitleChange: (value: string) => void;
  onMemoChange: (value: string) => void;
  onDueDateChange: (value: string) => void;
  onPriorityChange: (value: Task["priority"]) => void;
  onProjectIdChange: (value: string) => void;
  onSubmit: (event: FormEvent<HTMLFormElement>) => void;
  onCancel?: () => void;
  className?: string;
};

export function TaskForm({
  title,
  ariaLabel,
  taskTitle,
  memo,
  dueDate,
  priority,
  projectId,
  projects,
  submitLabel,
  onTitleChange,
  onMemoChange,
  onDueDateChange,
  onPriorityChange,
  onProjectIdChange,
  onSubmit,
  onCancel,
  className = "task-card",
}: TaskFormProps) {
  return (
    <form onSubmit={onSubmit} className={className} aria-label={ariaLabel}>
      <strong>{title}</strong>

      <label>
        ?쒕ぉ
        <input
          type="text"
          value={taskTitle}
          onChange={(event) => onTitleChange(event.target.value)}
          placeholder="?? ?ъ뾽怨꾪쉷??珥덉븞 ?묒꽦"
        />
      </label>

      <label>
        硫붾え
        <input
          type="text"
          value={memo}
          onChange={(event) => onMemoChange(event.target.value)}
          placeholder="?? 李멸퀬???댁슜"
        />
      </label>

      <label>
        留덇컧??
        <input
          type="date"
          value={dueDate}
          min="1900-01-01"
          max="9999-12-31"
          onChange={(event) => onDueDateChange(event.target.value)}
        />
      </label>

      <label>
        以묒슂??
        <select
          value={priority}
          onChange={(event) => onPriorityChange(event.target.value as Task[
"priority"])}
        >
          <option value="low">??쓬</option>
          <option value="medium">蹂댄넻</option>
          <option value="high">?믪쓬</option>
        </select>
      </label>

      <label>
        ?꾨줈?앺듃
        <select
          value={projectId}
          onChange={(event) => onProjectIdChange(event.target.value)}
        >
          {projects.map((project) => (
            <option key={project.id} value={project.id}>
              {project.name}
            </option>
          ))}
        </select>
      </label>

      <button type="submit">{submitLabel}</button>
      {onCancel && (
        <button type="button" onClick={onCancel}>
          痍⑥냼
        </button>
      )}
    </form>
  );
}

 succeeded in 3543ms:
import { useEffect, useMemo, useState } from "react";
import { RuleBasedAIProvider } from "./ai/RuleBasedAIProvider";
import { useProjectActions } from "./hooks/useProjectActions";
import { useProjectFormState } from "./hooks/useProjectFormState";
import { useTaskActions } from "./hooks/useTaskActions";
import { useTaskFormState } from "./hooks/useTaskFormState";
import { useStore } from "./store";
import { startOfToday } from "./utils/dateUtils";
import { getProjectName } from "./utils/projectLookup";
import { getOverdueTasks, getUpcomingTasks } from "./utils/taskDates";
import { filterTasks, sortTasks, type TaskSortOrder } from "./utils/taskFil
ters";
import { getTaskSummary } from "./utils/taskSummary";
import { SettingsView } from "./views/SettingsView";
import { TasksView } from "./views/TasksView";
import { ProjectsView } from "./views/ProjectsView";
import { TodayView } from "./views/TodayView";
import type { Task } from "./types";
import "./App.css";

type Tab = "today" | "tasks" | "projects" | "settings";

function App() {
  const [activeTab, setActiveTab] = useState<Tab>("today");
  const [recommendedTasks, setRecommendedTasks] = useState<Task[]>([]);
  const [selectedProjectFilter, setSelectedProjectFilter] = useState("all")
;
  const [showCompletedTasks, setShowCompletedTasks] = useState(true);
  const [taskSortOrder, setTaskSortOrder] = useState<TaskSortOrder>("none")
;
  const [taskSearchQuery, setTaskSearchQuery] = useState("");

  const { tasks, projects, appSettings, initializeApp, addTask, updateTask,
 deleteTask, deleteProject, addProject, updateProject } = useStore();
  const taskFormState = useTaskFormState();
  const {
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
  } = taskFormState;
  const { handleAddTask, handleSaveEditTask, handleToggleTaskDone, handleDe
leteTask } = useTaskActions({
    addTask,
    updateTask,
    deleteTask,
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
  });
  const projectFormState = useProjectFormState();
  const {
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
  } = projectFormState;
  const { handleAddProject, handleSaveEditProject, handleDeleteProject } = 
useProjectActions({
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
  });

  const today = startOfToday();

  const overdueTasks = getOverdueTasks(tasks, today);
  const upcomingTasks = getUpcomingTasks(tasks, today, 7);
  const taskSummary = getTaskSummary(tasks);

  const filteredTasks = filterTasks(tasks, {
    selectedProjectFilter,
    showCompletedTasks,
    taskSearchQuery,
    projects,
  });

  const summaryTasks = filterTasks(tasks, {
    selectedProjectFilter,
    showCompletedTasks: true,
    taskSearchQuery,
    projects,
  });

  const sortedTasks = sortTasks(filteredTasks, taskSortOrder);

  const aiProvider = useMemo(() => new RuleBasedAIProvider(), []);

  useEffect(() => {
    void initializeApp();
  }, [initializeApp]);

  useEffect(() => {
    void aiProvider.suggestTodayTasks(tasks, 3).then(setRecommendedTasks);
  }, [aiProvider, tasks]);

  return (
    <div className="app-shell">
      <header className="app-header">
        <p className="eyebrow">Privacy-first local planner</p>
        <h1>PlanPilot Local</h1>
        <p>?쒕쾭 ?놁씠 ??湲곌린 ?덉뿉 ??λ릺??媛쒖씤 ?쇱젙쨌?낅Т 愿由???/p>
      </header>

      <main className="app-main">
{activeTab === "today" && (
  <TodayView
    totalTasks={taskSummary.totalTasks}
    completedTasks={taskSummary.completedTasks}
    recommendedTasks={recommendedTasks}
    overdueTasks={overdueTasks}
    upcomingTasks={upcomingTasks}
    getProjectName={(projectId) => getProjectName(projects, projectId)}
  />
)}

        {activeTab === "tasks" && (
          <TasksView
            projects={projects}
            filteredTasks={filteredTasks}
            summaryTasks={summaryTasks}
            sortedTasks={sortedTasks}
            selectedProjectFilter={selectedProjectFilter}
            showCompletedTasks={showCompletedTasks}
            taskSortOrder={taskSortOrder}
            taskSearchQuery={taskSearchQuery}
            isTaskFormOpen={isTaskFormOpen}
            newTaskTitle={newTaskTitle}
            newTaskMemo={newTaskMemo}
            newTaskDueDate={newTaskDueDate}
            newTaskPriority={newTaskPriority}
            newTaskProjectId={newTaskProjectId}
            editingTaskId={editingTaskId}
            editTaskTitle={editTaskTitle}
            editTaskMemo={editTaskMemo}
            editTaskDueDate={editTaskDueDate}
            editTaskPriority={editTaskPriority}
            editTaskProjectId={editTaskProjectId}
            getProjectName={(projectId) => getProjectName(projects, project
Id)}
            onTaskSearchQueryChange={setTaskSearchQuery}
            onShowCompletedTasksChange={setShowCompletedTasks}
            onTaskSortOrderChange={setTaskSortOrder}
            onSelectedProjectFilterChange={setSelectedProjectFilter}
            onTaskFormOpenChange={setIsTaskFormOpen}
            onNewTaskTitleChange={setNewTaskTitle}
            onNewTaskMemoChange={setNewTaskMemo}
            onNewTaskDueDateChange={setNewTaskDueDate}
            onNewTaskPriorityChange={setNewTaskPriority}
            onNewTaskProjectIdChange={setNewTaskProjectId}
            onEditTaskTitleChange={setEditTaskTitle}
            onEditTaskMemoChange={setEditTaskMemo}
            onEditTaskDueDateChange={setEditTaskDueDate}
            onEditTaskPriorityChange={setEditTaskPriority}
            onEditTaskProjectIdChange={setEditTaskProjectId}
            onAddTask={handleAddTask}
            onSaveEditTask={handleSaveEditTask}
            onCancelEditTask={resetEditTaskForm}
            onToggleTaskDone={handleToggleTaskDone}
            onDeleteTask={handleDeleteTask}
            onStartEditTask={startEditTask}
          />
        )}

        {activeTab === "projects" && (
          <ProjectsView
            projects={projects}
            tasks={tasks}
            editingProjectId={editingProjectId}
            editProjectName={editProjectName}
            editProjectDescription={editProjectDescription}
            newProjectName={newProjectName}
            newProjectDescription={newProjectDescription}
            onNewProjectNameChange={setNewProjectName}
            onNewProjectDescriptionChange={setNewProjectDescription}
            onEditProjectNameChange={setEditProjectName}
            onEditProjectDescriptionChange={setEditProjectDescription}
            onAddProject={handleAddProject}
            onSaveEditProject={handleSaveEditProject}
            onCancelEditProject={resetEditProjectForm}
            onDeleteProject={handleDeleteProject}
            onStartEditProject={startEditProject}
          />
        )}

        {activeTab === "settings" && (
          <SettingsView
            appSettings={appSettings}
            tasks={tasks}
            projects={projects}
          />
        )}
      </main>

      <nav className="bottom-nav" aria-label="?섎떒 硫붾돱">
        <button
          className={activeTab === "today" ? "active" : ""}
          onClick={() => setActiveTab("today")}
        >
          ?ㅻ뒛
        </button>
        <button
          className={activeTab === "tasks" ? "active" : ""}
          onClick={() => setActiveTab("tasks")}
        >
          ?낅Т
        </button>
        <button
          className={activeTab === "projects" ? "active" : ""}
          onClick={() => setActiveTab("projects")}
        >
          ?꾨줈?앺듃
        </button>
        <button
          className={activeTab === "settings" ? "active" : ""}
          onClick={() => setActiveTab("settings")}
        >
          ?ㅼ젙
        </button>
      </nav>
    </div>
  );
}

export default App;

codex
확인 결과 병렬 task는 새 DB 필드 없이도 `status === "in_progress"`를 여러 task에 허용하는 방식으로 시
작할 여지가 있습니다. 다만 현재 UI 액션은 완료 토글만 제공하고 있어, 구현 전 문서에는 이 간극과 후속 작업을 분리해 기록하겠습니
다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\.ai-dev\goal.md
diff --git a/.ai-dev/goal.md b/.ai-dev/goal.md
index 14e23c4b57c2edb273cc992671655dea3970c32e..80a0805b4b8d9c7b1adb7326b4b
b7ac57afec247
--- a/.ai-dev/goal.md
+++ b/.ai-dev/goal.md
@@ -23,4 +23,50 @@
 
 ## 수동 검증
 - 관련 task 타입과 상태 흐름을 읽고 병렬 task 요구사항과 충돌하는 부분이 있는지 확인한다.
-- 검토 결과가 작은 후속 구현 작업으로 이어질 만큼 구체적인지 확인한다.
\ No newline at end of file
+- 검토 결과가 작은 후속 구현 작업으로 이어질 만큼 구체적인지 확인한다.
+
+## T002 검토 결과
+
+### 수정 파일과 이유
+- `.ai-dev/goal.md`: 현재 작업의 결과물은 구현이 아니라 병렬 task 실행 가능성 검토 문서이므로 `src`가 아닌
 AI Dev Loop 목표 문서에만 정리한다.
+
+### 현재 구조에서 수용 가능한 지점
+- `src/types.ts`의 `Task.status`는 이미 `"todo" | "in_progress" | "done"`을 허용한
다.
+- `src/db.ts`의 Dexie v1 schema는 `tasks: "id,projectId,status,sortOrder"`로 
`status` 인덱스를 가지고 있어 여러 `in_progress` task 저장 자체를 막지 않는다.
+- `src/store.ts`의 `addTask`와 `updateTask`는 단일 active task 제약을 두지 않는다. 따라서 
같은 시점에 여러 task가 `in_progress`가 되는 데이터 상태는 현재 store/DB 흐름과 충돌하지 않는다.
+- `src/views/TasksView.tsx`는 `in_progress` 개수를 요약에 포함한다. 병렬 진행 상태를 읽어서 표시하
는 최소 기반은 이미 있다.
+- `src/utils/taskLabels.ts`, `src/utils/importValidation.ts`는 `in_progress
` 상태를 기존 enum 값으로 인식한다.
+
+### 현재 흐름의 제한
+- `src/hooks/useTaskActions.ts`의 `handleToggleTaskDone`은 `done`과 `todo` 사이
만 전환한다. 사용자가 task를 `in_progress`로 시작하거나 되돌리는 액션은 없다.
+- `src/components/TaskCard.tsx`는 완료/미완료 토글만 제공한다. 진행 시작/진행 해제/진행 중 여러 개 표시
 같은 명시적 조작 UI는 없다.
+- `src/components/TaskForm.tsx`는 생성/수정 폼에서 status를 편집하지 않는다. 새 task는 기본적으로
 `todo`로 생성된다.
+- `src/views/TodayView.tsx`의 추천 업무는 최대 3개를 보여주지만, 이것은 추천 표시 제한일 뿐 병렬 실행 상태
 모델은 아니다.
+- `src/utils/taskFilters.ts`는 완료 숨김만 지원한다. `in_progress`만 따로 보는 필터는 없다.
+
+### 병렬 task 실행을 위한 최소 변경 범위
+- 작은 구현 1: `TaskCard`에 `todo <-> in_progress` 전환 버튼을 추가하고, 기존 `done` 토글과 역
할을 분리한다.
+- 작은 구현 2: `useTaskActions`에 `handleToggleTaskInProgress` 같은 액션을 추가한다. 이 액
션은 다른 `in_progress` task를 자동으로 `todo`로 되돌리지 않아야 병렬 실행을 유지할 수 있다.
+- 작은 구현 3: `TasksView`에 진행 중 개수를 이미 계산하고 있으므로, 필요하면 진행 중 task를 시각적으로 구분하는 
표시만 추가한다.
+- 작은 구현 4: `TodayView`에서 진행 중 task 섹션을 별도로 보여줄지 검토한다. 단, 첫 후속 작업에서는 전체 업무 
화면의 상태 전환만 다루는 편이 범위가 작다.
+
+### 데이터와 마이그레이션 판단
+- 새 필드나 schema version 증가는 필요하지 않다.
+- 기존 `status` 값 중 `in_progress`를 더 적극적으로 사용하는 변경이므로 기존 사용자 데이터는 그대로 유지할 수 
있다.
+- import 검증은 이미 `in_progress`를 허용하므로 백업/복원 형식 변경도 필요하지 않다.
+
+### 보류해야 할 항목
+- 실제 병렬 실행 UI의 큰 재구성, 타이머, 칸반 보드, 드래그 앤 드롭은 보류한다.
+- 알림 기능, Android notification 권한, 백그라운드 실행 추적은 범위 밖이다.
+- task 간 의존성, 동시 실행 개수 제한, 자동 스케줄링은 현재 MVP 흐름보다 큰 정책 결정이 필요하므로 보류한다.
+- DB schema 변경이나 migration은 현재 검토 기준에서는 불필요하므로 진행하지 않는다.
+
+### 남은 위험
+- 화면 문자열 일부가 깨져 보이는 파일이 있어 UI 문구를 함께 건드리면 범위가 커질 수 있다. 병렬 task 후속 작업은 상태 전
환 로직과 최소 UI만 별도 task로 다루는 것이 안전하다.
+- `in_progress`의 제품 의미가 아직 명확하지 않다. 예를 들어 "진행 중"을 여러 개 허용할지, 오늘 진행 목록인지, 실
제 실행 세션인지에 따라 UI 명칭과 액션이 달라질 수 있다.
+- 현재 `completedAt`만 store에서 자동 관리한다. `startedAt` 같은 실행 이력은 없으므로 실제 실행 시간 기
록까지 요구하면 데이터 구조 변경 검토가 필요하다.
+
+### 다음 task 제안
+- 다음 task로 넘어가도 된다.
+- 우선순위가 가장 낮은 위험의 후속 작업은 `TaskCard`와 `useTaskActions` 중심으로 "진행 중으로 표시/해제"를
 추가하는 것이다.
+- 이 후속 작업은 DB schema 변경 없이 가능하며, 다른 진행 중 task를 강제로 변경하지 않는 정책을 명시해야 한다.

diff --git a/.ai-dev/goal.md b/.ai-dev/goal.md
index 14e23c4b57c2edb273cc992671655dea3970c32e..80a0805b4b8d9c7b1adb7326b4b
b7ac57afec247
--- a/.ai-dev/goal.md
+++ b/.ai-dev/goal.md
@@ -23,4 +23,50 @@
 
 ## 수동 검증
 - 관련 task 타입과 상태 흐름을 읽고 병렬 task 요구사항과 충돌하는 부분이 있는지 확인한다.
-- 검토 결과가 작은 후속 구현 작업으로 이어질 만큼 구체적인지 확인한다.
\ No newline at end of file
+- 검토 결과가 작은 후속 구현 작업으로 이어질 만큼 구체적인지 확인한다.
+
+## T002 검토 결과
+
+### 수정 파일과 이유
+- `.ai-dev/goal.md`: 현재 작업의 결과물은 구현이 아니라 병렬 task 실행 가능성 검토 문서이므로 `src`가 아닌
 AI Dev Loop 목표 문서에만 정리한다.
+
+### 현재 구조에서 수용 가능한 지점
+- `src/types.ts`의 `Task.status`는 이미 `"todo" | "in_progress" | "done"`을 허용한
다.
+- `src/db.ts`의 Dexie v1 schema는 `tasks: "id,projectId,status,sortOrder"`로 
`status` 인덱스를 가지고 있어 여러 `in_progress` task 저장 자체를 막지 않는다.
+- `src/store.ts`의 `addTask`와 `updateTask`는 단일 active task 제약을 두지 않는다. 따라서 
같은 시점에 여러 task가 `in_progress`가 되는 데이터 상태는 현재 store/DB 흐름과 충돌하지 않는다.
+- `src/views/TasksView.tsx`는 `in_progress` 개수를 요약에 포함한다. 병렬 진행 상태를 읽어서 표시하
는 최소 기반은 이미 있다.
+- `src/utils/taskLabels.ts`, `src/utils/importValidation.ts`는 `in_progress
` 상태를 기존 enum 값으로 인식한다.
+
+### 현재 흐름의 제한
+- `src/hooks/useTaskActions.ts`의 `handleToggleTaskDone`은 `done`과 `todo` 사이
만 전환한다. 사용자가 task를 `in_progress`로 시작하거나 되돌리는 액션은 없다.
+- `src/components/TaskCard.tsx`는 완료/미완료 토글만 제공한다. 진행 시작/진행 해제/진행 중 여러 개 표시
 같은 명시적 조작 UI는 없다.
+- `src/components/TaskForm.tsx`는 생성/수정 폼에서 status를 편집하지 않는다. 새 task는 기본적으로
 `todo`로 생성된다.
+- `src/views/TodayView.tsx`의 추천 업무는 최대 3개를 보여주지만, 이것은 추천 표시 제한일 뿐 병렬 실행 상태
 모델은 아니다.
+- `src/utils/taskFilters.ts`는 완료 숨김만 지원한다. `in_progress`만 따로 보는 필터는 없다.
+
+### 병렬 task 실행을 위한 최소 변경 범위
+- 작은 구현 1: `TaskCard`에 `todo <-> in_progress` 전환 버튼을 추가하고, 기존 `done` 토글과 역
할을 분리한다.
+- 작은 구현 2: `useTaskActions`에 `handleToggleTaskInProgress` 같은 액션을 추가한다. 이 액
션은 다른 `in_progress` task를 자동으로 `todo`로 되돌리지 않아야 병렬 실행을 유지할 수 있다.
+- 작은 구현 3: `TasksView`에 진행 중 개수를 이미 계산하고 있으므로, 필요하면 진행 중 task를 시각적으로 구분하는 
표시만 추가한다.
+- 작은 구현 4: `TodayView`에서 진행 중 task 섹션을 별도로 보여줄지 검토한다. 단, 첫 후속 작업에서는 전체 업무 
화면의 상태 전환만 다루는 편이 범위가 작다.
+
+### 데이터와 마이그레이션 판단
+- 새 필드나 schema version 증가는 필요하지 않다.
+- 기존 `status` 값 중 `in_progress`를 더 적극적으로 사용하는 변경이므로 기존 사용자 데이터는 그대로 유지할 수 
있다.
+- import 검증은 이미 `in_progress`를 허용하므로 백업/복원 형식 변경도 필요하지 않다.
+
+### 보류해야 할 항목
+- 실제 병렬 실행 UI의 큰 재구성, 타이머, 칸반 보드, 드래그 앤 드롭은 보류한다.
+- 알림 기능, Android notification 권한, 백그라운드 실행 추적은 범위 밖이다.
+- task 간 의존성, 동시 실행 개수 제한, 자동 스케줄링은 현재 MVP 흐름보다 큰 정책 결정이 필요하므로 보류한다.
+- DB schema 변경이나 migration은 현재 검토 기준에서는 불필요하므로 진행하지 않는다.
+
+### 남은 위험
+- 화면 문자열 일부가 깨져 보이는 파일이 있어 UI 문구를 함께 건드리면 범위가 커질 수 있다. 병렬 task 후속 작업은 상태 전
환 로직과 최소 UI만 별도 task로 다루는 것이 안전하다.
+- `in_progress`의 제품 의미가 아직 명확하지 않다. 예를 들어 "진행 중"을 여러 개 허용할지, 오늘 진행 목록인지, 실
제 실행 세션인지에 따라 UI 명칭과 액션이 달라질 수 있다.
+- 현재 `completedAt`만 store에서 자동 관리한다. `startedAt` 같은 실행 이력은 없으므로 실제 실행 시간 기
록까지 요구하면 데이터 구조 변경 검토가 필요하다.
+
+### 다음 task 제안
+- 다음 task로 넘어가도 된다.
+- 우선순위가 가장 낮은 위험의 후속 작업은 `TaskCard`와 `useTaskActions` 중심으로 "진행 중으로 표시/해제"를
 추가하는 것이다.
+- 이 후속 작업은 DB schema 변경 없이 가능하며, 다른 진행 중 task를 강제로 변경하지 않는 정책을 명시해야 한다.

codex
문서 수정은 `.ai-dev/goal.md` 한 파일에만 적용했습니다. 이제 성공 기준과 제약사항이 빠짐없이 들어갔는지 파일 내용을 다
시 읽어 검증하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "
Get-Content -LiteralPath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\goal.md'" 
in D:\ai-apps\planpilot-local
 succeeded in 1633ms:
# 목표
병렬 task 실행 가능성 검토

## 배경
현재 PlanPilot Local의 task 처리 구조에서 여러 task를 동시에 진행하거나 표시할 수 있는지 확인하고, 실제 구현 전
에 필요한 변경 범위와 위험 요소를 작게 정리한다.

## 성공 기준
- 현재 task 데이터 구조와 화면 흐름에서 병렬 task 개념을 수용할 수 있는 지점을 확인한다.
- 병렬 task 실행을 위해 변경이 필요한 파일과 상태 흐름을 최소 범위로 정리한다.
- 즉시 구현 가능한 작은 후속 작업과 보류해야 할 항목을 구분한다.

## 제약사항
- 기존 사용자 데이터를 깨뜨리지 않는다.
- 기존 타입, store 액션, DB 구조를 우선 확인한다.
- 한 번에 하나의 기능만 다룬다.
- 큰 구조 변경이 필요하면 구현보다 검토 결과 정리를 우선한다.

## 범위 제외
- 실제 병렬 실행 UI 구현은 제외한다.
- 데이터 구조 변경은 제외한다.
- 알림 기능 추가는 제외한다.
- 대규모 화면 재구성은 제외한다.

## 수동 검증
- 관련 task 타입과 상태 흐름을 읽고 병렬 task 요구사항과 충돌하는 부분이 있는지 확인한다.
- 검토 결과가 작은 후속 구현 작업으로 이어질 만큼 구체적인지 확인한다.

## T002 검토 결과

### 수정 파일과 이유
- `.ai-dev/goal.md`: 현재 작업의 결과물은 구현이 아니라 병렬 task 실행 가능성 검토 문서이므로 `src`가 아닌 
AI Dev Loop 목표 문서에만 정리한다.

### 현재 구조에서 수용 가능한 지점
- `src/types.ts`의 `Task.status`는 이미 `"todo" | "in_progress" | "done"`을 허용한다
.
- `src/db.ts`의 Dexie v1 schema는 `tasks: "id,projectId,status,sortOrder"`로 `
status` 인덱스를 가지고 있어 여러 `in_progress` task 저장 자체를 막지 않는다.
- `src/store.ts`의 `addTask`와 `updateTask`는 단일 active task 제약을 두지 않는다. 따라서 같
은 시점에 여러 task가 `in_progress`가 되는 데이터 상태는 현재 store/DB 흐름과 충돌하지 않는다.
- `src/views/TasksView.tsx`는 `in_progress` 개수를 요약에 포함한다. 병렬 진행 상태를 읽어서 표시하는
 최소 기반은 이미 있다.
- `src/utils/taskLabels.ts`, `src/utils/importValidation.ts`는 `in_progress`
 상태를 기존 enum 값으로 인식한다.

### 현재 흐름의 제한
- `src/hooks/useTaskActions.ts`의 `handleToggleTaskDone`은 `done`과 `todo` 사이만
 전환한다. 사용자가 task를 `in_progress`로 시작하거나 되돌리는 액션은 없다.
- `src/components/TaskCard.tsx`는 완료/미완료 토글만 제공한다. 진행 시작/진행 해제/진행 중 여러 개 표시 
같은 명시적 조작 UI는 없다.
- `src/components/TaskForm.tsx`는 생성/수정 폼에서 status를 편집하지 않는다. 새 task는 기본적으로 
`todo`로 생성된다.
- `src/views/TodayView.tsx`의 추천 업무는 최대 3개를 보여주지만, 이것은 추천 표시 제한일 뿐 병렬 실행 상태 
모델은 아니다.
- `src/utils/taskFilters.ts`는 완료 숨김만 지원한다. `in_progress`만 따로 보는 필터는 없다.

### 병렬 task 실행을 위한 최소 변경 범위
- 작은 구현 1: `TaskCard`에 `todo <-> in_progress` 전환 버튼을 추가하고, 기존 `done` 토글과 역할
을 분리한다.
- 작은 구현 2: `useTaskActions`에 `handleToggleTaskInProgress` 같은 액션을 추가한다. 이 액션
은 다른 `in_progress` task를 자동으로 `todo`로 되돌리지 않아야 병렬 실행을 유지할 수 있다.
- 작은 구현 3: `TasksView`에 진행 중 개수를 이미 계산하고 있으므로, 필요하면 진행 중 task를 시각적으로 구분하는 표
시만 추가한다.
- 작은 구현 4: `TodayView`에서 진행 중 task 섹션을 별도로 보여줄지 검토한다. 단, 첫 후속 작업에서는 전체 업무 화
면의 상태 전환만 다루는 편이 범위가 작다.

### 데이터와 마이그레이션 판단
- 새 필드나 schema version 증가는 필요하지 않다.
- 기존 `status` 값 중 `in_progress`를 더 적극적으로 사용하는 변경이므로 기존 사용자 데이터는 그대로 유지할 수 있
다.
- import 검증은 이미 `in_progress`를 허용하므로 백업/복원 형식 변경도 필요하지 않다.

### 보류해야 할 항목
- 실제 병렬 실행 UI의 큰 재구성, 타이머, 칸반 보드, 드래그 앤 드롭은 보류한다.
- 알림 기능, Android notification 권한, 백그라운드 실행 추적은 범위 밖이다.
- task 간 의존성, 동시 실행 개수 제한, 자동 스케줄링은 현재 MVP 흐름보다 큰 정책 결정이 필요하므로 보류한다.
- DB schema 변경이나 migration은 현재 검토 기준에서는 불필요하므로 진행하지 않는다.

### 남은 위험
- 화면 문자열 일부가 깨져 보이는 파일이 있어 UI 문구를 함께 건드리면 범위가 커질 수 있다. 병렬 task 후속 작업은 상태 전환
 로직과 최소 UI만 별도 task로 다루는 것이 안전하다.
- `in_progress`의 제품 의미가 아직 명확하지 않다. 예를 들어 "진행 중"을 여러 개 허용할지, 오늘 진행 목록인지, 실제
 실행 세션인지에 따라 UI 명칭과 액션이 달라질 수 있다.
- 현재 `completedAt`만 store에서 자동 관리한다. `startedAt` 같은 실행 이력은 없으므로 실제 실행 시간 기록
까지 요구하면 데이터 구조 변경 검토가 필요하다.

### 다음 task 제안
- 다음 task로 넘어가도 된다.
- 우선순위가 가장 낮은 위험의 후속 작업은 `TaskCard`와 `useTaskActions` 중심으로 "진행 중으로 표시/해제"를 
추가하는 것이다.
- 이 후속 작업은 DB schema 변경 없이 가능하며, 다른 진행 중 task를 강제로 변경하지 않는 정책을 명시해야 한다.

diff --git a/.ai-dev/goal.md b/.ai-dev/goal.md
index 14e23c4b57c2edb273cc992671655dea3970c32e..80a0805b4b8d9c7b1adb7326b4b
b7ac57afec247
--- a/.ai-dev/goal.md
+++ b/.ai-dev/goal.md
@@ -23,4 +23,50 @@
 
 ## 수동 검증
 - 관련 task 타입과 상태 흐름을 읽고 병렬 task 요구사항과 충돌하는 부분이 있는지 확인한다.
-- 검토 결과가 작은 후속 구현 작업으로 이어질 만큼 구체적인지 확인한다.
\ No newline at end of file
+- 검토 결과가 작은 후속 구현 작업으로 이어질 만큼 구체적인지 확인한다.
+
+## T002 검토 결과
+
+### 수정 파일과 이유
+- `.ai-dev/goal.md`: 현재 작업의 결과물은 구현이 아니라 병렬 task 실행 가능성 검토 문서이므로 `src`가 아닌
 AI Dev Loop 목표 문서에만 정리한다.
+
+### 현재 구조에서 수용 가능한 지점
+- `src/types.ts`의 `Task.status`는 이미 `"todo" | "in_progress" | "done"`을 허용한
다.
+- `src/db.ts`의 Dexie v1 schema는 `tasks: "id,projectId,status,sortOrder"`로 
`status` 인덱스를 가지고 있어 여러 `in_progress` task 저장 자체를 막지 않는다.
+- `src/store.ts`의 `addTask`와 `updateTask`는 단일 active task 제약을 두지 않는다. 따라서 
같은 시점에 여러 task가 `in_progress`가 되는 데이터 상태는 현재 store/DB 흐름과 충돌하지 않는다.
+- `src/views/TasksView.tsx`는 `in_progress` 개수를 요약에 포함한다. 병렬 진행 상태를 읽어서 표시하
는 최소 기반은 이미 있다.
+- `src/utils/taskLabels.ts`, `src/utils/importValidation.ts`는 `in_progress
` 상태를 기존 enum 값으로 인식한다.
+
+### 현재 흐름의 제한
+- `src/hooks/useTaskActions.ts`의 `handleToggleTaskDone`은 `done`과 `todo` 사이
만 전환한다. 사용자가 task를 `in_progress`로 시작하거나 되돌리는 액션은 없다.
+- `src/components/TaskCard.tsx`는 완료/미완료 토글만 제공한다. 진행 시작/진행 해제/진행 중 여러 개 표시
 같은 명시적 조작 UI는 없다.
+- `src/components/TaskForm.tsx`는 생성/수정 폼에서 status를 편집하지 않는다. 새 task는 기본적으로
 `todo`로 생성된다.
+- `src/views/TodayView.tsx`의 추천 업무는 최대 3개를 보여주지만, 이것은 추천 표시 제한일 뿐 병렬 실행 상태
 모델은 아니다.
+- `src/utils/taskFilters.ts`는 완료 숨김만 지원한다. `in_progress`만 따로 보는 필터는 없다.
+
+### 병렬 task 실행을 위한 최소 변경 범위
+- 작은 구현 1: `TaskCard`에 `todo <-> in_progress` 전환 버튼을 추가하고, 기존 `done` 토글과 역
할을 분리한다.
+- 작은 구현 2: `useTaskActions`에 `handleToggleTaskInProgress` 같은 액션을 추가한다. 이 액
션은 다른 `in_progress` task를 자동으로 `todo`로 되돌리지 않아야 병렬 실행을 유지할 수 있다.
+- 작은 구현 3: `TasksView`에 진행 중 개수를 이미 계산하고 있으므로, 필요하면 진행 중 task를 시각적으로 구분하는 
표시만 추가한다.
+- 작은 구현 4: `TodayView`에서 진행 중 task 섹션을 별도로 보여줄지 검토한다. 단, 첫 후속 작업에서는 전체 업무 
화면의 상태 전환만 다루는 편이 범위가 작다.
+
+### 데이터와 마이그레이션 판단
+- 새 필드나 schema version 증가는 필요하지 않다.
+- 기존 `status` 값 중 `in_progress`를 더 적극적으로 사용하는 변경이므로 기존 사용자 데이터는 그대로 유지할 수 
있다.
+- import 검증은 이미 `in_progress`를 허용하므로 백업/복원 형식 변경도 필요하지 않다.
+
+### 보류해야 할 항목
+- 실제 병렬 실행 UI의 큰 재구성, 타이머, 칸반 보드, 드래그 앤 드롭은 보류한다.
+- 알림 기능, Android notification 권한, 백그라운드 실행 추적은 범위 밖이다.
+- task 간 의존성, 동시 실행 개수 제한, 자동 스케줄링은 현재 MVP 흐름보다 큰 정책 결정이 필요하므로 보류한다.
+- DB schema 변경이나 migration은 현재 검토 기준에서는 불필요하므로 진행하지 않는다.
+
+### 남은 위험
+- 화면 문자열 일부가 깨져 보이는 파일이 있어 UI 문구를 함께 건드리면 범위가 커질 수 있다. 병렬 task 후속 작업은 상태 전
환 로직과 최소 UI만 별도 task로 다루는 것이 안전하다.
+- `in_progress`의 제품 의미가 아직 명확하지 않다. 예를 들어 "진행 중"을 여러 개 허용할지, 오늘 진행 목록인지, 실
제 실행 세션인지에 따라 UI 명칭과 액션이 달라질 수 있다.
+- 현재 `completedAt`만 store에서 자동 관리한다. `startedAt` 같은 실행 이력은 없으므로 실제 실행 시간 기
록까지 요구하면 데이터 구조 변경 검토가 필요하다.
+
+### 다음 task 제안
+- 다음 task로 넘어가도 된다.
+- 우선순위가 가장 낮은 위험의 후속 작업은 `TaskCard`와 `useTaskActions` 중심으로 "진행 중으로 표시/해제"를
 추가하는 것이다.
+- 이 후속 작업은 DB schema 변경 없이 가능하며, 다른 진행 중 task를 강제로 변경하지 않는 정책을 명시해야 한다.

codex
작업 완료했습니다.

변경한 파일: [.ai-dev/goal.md](D:/ai-apps/planpilot-local/.ai-dev/goal.md)

분석 요약:
- 현재 `Task.status`가 이미 `todo | in_progress | done`을 지원하고, Dexie schema도 `st
atus` 인덱스를 가지고 있어 여러 task를 `in_progress`로 저장하는 것은 현재 구조와 충돌하지 않습니다.
- 제한점은 UI/액션 흐름입니다. 현재는 완료/미완료 토글만 있고, “진행 중으로 표시/해제” 액션이 없습니다.
- DB schema 변경이나 migration 없이 `TaskCard`와 `useTaskActions` 중심의 작은 후속 작업으로 시
작할 수 있다고 정리했습니다.
- 타이머, 알림, 실행 이력, 대규모 화면 재구성은 보류 항목으로 분리했습니다.

검증 방법:
- `src/types.ts`, `src/db.ts`, `src/store.ts`, `src/hooks/useTaskActions.ts
`, `src/components/TaskCard.tsx`, `src/components/TaskForm.tsx`, `src/views
/TasksView.tsx`, `src/views/TodayView.tsx`, 관련 utils를 읽고 상태 흐름을 확인했습니다.
- 문서 수정 후 `.ai-dev/goal.md`를 다시 읽어 성공 기준과 제약사항 반영 여부를 확인했습니다.
- 프롬프트상 지시가 없어 build/test/lint는 실행하지 않았습니다.

남은 위험:
- `in_progress`의 제품 의미가 아직 확정되지 않았습니다.
- 실제 실행 시간 기록이 필요해지면 `startedAt` 등 데이터 구조 변경 검토가 필요합니다.
- 일부 UI 문자열 깨짐이 보여 병렬 task 구현과 문구 정리는 분리하는 편이 안전합니다.

다음 task로 넘어가도 됩니다.

`.ai-dev/loop-log.md` 기록용 요약:
`T002 검토 결과 정리 완료. 현재 Task.status와 Dexie status 인덱스는 여러 in_progress task를 저
장할 수 있으며, 단일 active task 제약은 없음. 최소 후속 작업은 TaskCard/useTaskActions에 진행 중 표시
/해제 액션을 추가하는 것. DB schema 변경, 알림, 타이머, 대규모 UI 재구성은 보류.`
diff --git a/.ai-dev/goal.md b/.ai-dev/goal.md
index 14e23c4b57c2edb273cc992671655dea3970c32e..80a0805b4b8d9c7b1adb7326b4b
b7ac57afec247
--- a/.ai-dev/goal.md
+++ b/.ai-dev/goal.md
@@ -23,4 +23,50 @@
 
 ## 수동 검증
 - 관련 task 타입과 상태 흐름을 읽고 병렬 task 요구사항과 충돌하는 부분이 있는지 확인한다.
-- 검토 결과가 작은 후속 구현 작업으로 이어질 만큼 구체적인지 확인한다.
\ No newline at end of file
+- 검토 결과가 작은 후속 구현 작업으로 이어질 만큼 구체적인지 확인한다.
+
+## T002 검토 결과
+
+### 수정 파일과 이유
+- `.ai-dev/goal.md`: 현재 작업의 결과물은 구현이 아니라 병렬 task 실행 가능성 검토 문서이므로 `src`가 아닌
 AI Dev Loop 목표 문서에만 정리한다.
+
+### 현재 구조에서 수용 가능한 지점
+- `src/types.ts`의 `Task.status`는 이미 `"todo" | "in_progress" | "done"`을 허용한
다.
+- `src/db.ts`의 Dexie v1 schema는 `tasks: "id,projectId,status,sortOrder"`로 
`status` 인덱스를 가지고 있어 여러 `in_progress` task 저장 자체를 막지 않는다.
+- `src/store.ts`의 `addTask`와 `updateTask`는 단일 active task 제약을 두지 않는다. 따라서 
같은 시점에 여러 task가 `in_progress`가 되는 데이터 상태는 현재 store/DB 흐름과 충돌하지 않는다.
+- `src/views/TasksView.tsx`는 `in_progress` 개수를 요약에 포함한다. 병렬 진행 상태를 읽어서 표시하
는 최소 기반은 이미 있다.
+- `src/utils/taskLabels.ts`, `src/utils/importValidation.ts`는 `in_progress
` 상태를 기존 enum 값으로 인식한다.
+
+### 현재 흐름의 제한
+- `src/hooks/useTaskActions.ts`의 `handleToggleTaskDone`은 `done`과 `todo` 사이
만 전환한다. 사용자가 task를 `in_progress`로 시작하거나 되돌리는 액션은 없다.
+- `src/components/TaskCard.tsx`는 완료/미완료 토글만 제공한다. 진행 시작/진행 해제/진행 중 여러 개 표시
 같은 명시적 조작 UI는 없다.
+- `src/components/TaskForm.tsx`는 생성/수정 폼에서 status를 편집하지 않는다. 새 task는 기본적으로
 `todo`로 생성된다.
+- `src/views/TodayView.tsx`의 추천 업무는 최대 3개를 보여주지만, 이것은 추천 표시 제한일 뿐 병렬 실행 상태
 모델은 아니다.
+- `src/utils/taskFilters.ts`는 완료 숨김만 지원한다. `in_progress`만 따로 보는 필터는 없다.
+
+### 병렬 task 실행을 위한 최소 변경 범위
+- 작은 구현 1: `TaskCard`에 `todo <-> in_progress` 전환 버튼을 추가하고, 기존 `done` 토글과 역
할을 분리한다.
+- 작은 구현 2: `useTaskActions`에 `handleToggleTaskInProgress` 같은 액션을 추가한다. 이 액
션은 다른 `in_progress` task를 자동으로 `todo`로 되돌리지 않아야 병렬 실행을 유지할 수 있다.
+- 작은 구현 3: `TasksView`에 진행 중 개수를 이미 계산하고 있으므로, 필요하면 진행 중 task를 시각적으로 구분하는 
표시만 추가한다.
+- 작은 구현 4: `TodayView`에서 진행 중 task 섹션을 별도로 보여줄지 검토한다. 단, 첫 후속 작업에서는 전체 업무 
화면의 상태 전환만 다루는 편이 범위가 작다.
+
+### 데이터와 마이그레이션 판단
+- 새 필드나 schema version 증가는 필요하지 않다.
+- 기존 `status` 값 중 `in_progress`를 더 적극적으로 사용하는 변경이므로 기존 사용자 데이터는 그대로 유지할 수 
있다.
+- import 검증은 이미 `in_progress`를 허용하므로 백업/복원 형식 변경도 필요하지 않다.
+
+### 보류해야 할 항목
+- 실제 병렬 실행 UI의 큰 재구성, 타이머, 칸반 보드, 드래그 앤 드롭은 보류한다.
+- 알림 기능, Android notification 권한, 백그라운드 실행 추적은 범위 밖이다.
+- task 간 의존성, 동시 실행 개수 제한, 자동 스케줄링은 현재 MVP 흐름보다 큰 정책 결정이 필요하므로 보류한다.
+- DB schema 변경이나 migration은 현재 검토 기준에서는 불필요하므로 진행하지 않는다.
+
+### 남은 위험
+- 화면 문자열 일부가 깨져 보이는 파일이 있어 UI 문구를 함께 건드리면 범위가 커질 수 있다. 병렬 task 후속 작업은 상태 전
환 로직과 최소 UI만 별도 task로 다루는 것이 안전하다.
+- `in_progress`의 제품 의미가 아직 명확하지 않다. 예를 들어 "진행 중"을 여러 개 허용할지, 오늘 진행 목록인지, 실
제 실행 세션인지에 따라 UI 명칭과 액션이 달라질 수 있다.
+- 현재 `completedAt`만 store에서 자동 관리한다. `startedAt` 같은 실행 이력은 없으므로 실제 실행 시간 기
록까지 요구하면 데이터 구조 변경 검토가 필요하다.
+
+### 다음 task 제안
+- 다음 task로 넘어가도 된다.
+- 우선순위가 가장 낮은 위험의 후속 작업은 `TaskCard`와 `useTaskActions` 중심으로 "진행 중으로 표시/해제"를
 추가하는 것이다.
+- 이 후속 작업은 DB schema 변경 없이 가능하며, 다른 진행 중 task를 강제로 변경하지 않는 정책을 명시해야 한다.

tokens used
51,650
작업 완료했습니다.

변경한 파일: [.ai-dev/goal.md](D:/ai-apps/planpilot-local/.ai-dev/goal.md)

분석 요약:
- 현재 `Task.status`가 이미 `todo | in_progress | done`을 지원하고, Dexie schema도 `status` 인덱스를 가지고 있어 여러 task를 `in_progress`로 저장하는 것은 현재 구조와 충돌하지 않습니다.
- 제한점은 UI/액션 흐름입니다. 현재는 완료/미완료 토글만 있고, “진행 중으로 표시/해제” 액션이 없습니다.
- DB schema 변경이나 migration 없이 `TaskCard`와 `useTaskActions` 중심의 작은 후속 작업으로 시작할 수 있다고 정리했습니다.
- 타이머, 알림, 실행 이력, 대규모 화면 재구성은 보류 항목으로 분리했습니다.

검증 방법:
- `src/types.ts`, `src/db.ts`, `src/store.ts`, `src/hooks/useTaskActions.ts`, `src/components/TaskCard.tsx`, `src/components/TaskForm.tsx`, `src/views/TasksView.tsx`, `src/views/TodayView.tsx`, 관련 utils를 읽고 상태 흐름을 확인했습니다.
- 문서 수정 후 `.ai-dev/goal.md`를 다시 읽어 성공 기준과 제약사항 반영 여부를 확인했습니다.
- 프롬프트상 지시가 없어 build/test/lint는 실행하지 않았습니다.

남은 위험:
- `in_progress`의 제품 의미가 아직 확정되지 않았습니다.
- 실제 실행 시간 기록이 필요해지면 `startedAt` 등 데이터 구조 변경 검토가 필요합니다.
- 일부 UI 문자열 깨짐이 보여 병렬 task 구현과 문구 정리는 분리하는 편이 안전합니다.

다음 task로 넘어가도 됩니다.

`.ai-dev/loop-log.md` 기록용 요약:
`T002 검토 결과 정리 완료. 현재 Task.status와 Dexie status 인덱스는 여러 in_progress task를 저장할 수 있으며, 단일 active task 제약은 없음. 최소 후속 작업은 TaskCard/useTaskActions에 진행 중 표시/해제 액션을 추가하는 것. DB schema 변경, 알림, 타이머, 대규모 UI 재구성은 보류.`

```