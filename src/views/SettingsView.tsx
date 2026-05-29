import { useState } from "react";
import type { AppSettings, Project, Task } from "../types";
import { exportPlanPilotData } from "../utils/exportData";

type SettingsViewProps = {
  appSettings: AppSettings;
  tasks: Task[];
  projects: Project[];
};

export function SettingsView({ appSettings, tasks, projects }: SettingsViewProps) {
  const [exportMessage, setExportMessage] = useState("");

  const handleExportData = () => {
    try {
      const { filename } = exportPlanPilotData({ tasks, projects, appSettings });
      setExportMessage(`JSON 백업 파일을 만들었습니다: ${filename}`);
    } catch {
      setExportMessage("JSON 파일을 만들지 못했습니다. 잠시 후 다시 시도하세요.");
    }
  };

  return (
    <section className="screen-card">
      <h2>설정</h2>
      <div className="settings-list">
        <h3>현재 설정 상태</h3>
        <p>현재 MVP에서는 설정 값을 읽기 전용으로 확인합니다.</p>
        <p>테마: {appSettings.theme}</p>
        <p>언어: {appSettings.language}</p>
        <p>AI Provider: {appSettings.aiProvider}</p>
        <p>알림: {appSettings.enableNotifications ? "사용" : "MVP에서는 사용하지 않음"}</p>
        <p>첫 실행 완료: {String(appSettings.firstLaunchCompleted)}</p>
      </div>

      <div className="settings-list">
        <h3>데이터 백업</h3>
        <p>업무, 프로젝트, 설정 데이터를 로컬 JSON 파일로 내보냅니다.</p>
        <button type="button" onClick={handleExportData}>
          데이터 내보내기
        </button>
        {exportMessage && <p className="summary">{exportMessage}</p>}
      </div>
    </section>
  );
}
