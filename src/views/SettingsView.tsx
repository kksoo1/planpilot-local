import { useState } from "react";
import type { AppSettings, Project, Task } from "../types";
import { exportPlanPilotData } from "../utils/exportData";
import {
  validateBackupData,
  type BackupValidationResult,
} from "../utils/importValidation";

type SettingsViewProps = {
  appSettings: AppSettings;
  tasks: Task[];
  projects: Project[];
};

export function SettingsView({ appSettings, tasks, projects }: SettingsViewProps) {
  const [exportMessage, setExportMessage] = useState("");
  const [importFilename, setImportFilename] = useState("");
  const [importResult, setImportResult] = useState<BackupValidationResult | null>(null);
  const [importParseError, setImportParseError] = useState("");

  const handleExportData = () => {
    try {
      const { filename } = exportPlanPilotData({ tasks, projects, appSettings });
      setExportMessage(`JSON 백업 파일을 만들었습니다: ${filename}`);
    } catch {
      setExportMessage("JSON 파일을 만들지 못했습니다. 잠시 후 다시 시도하세요.");
    }
  };

  const handleImportFile = async (file: File | undefined) => {
    setImportFilename(file?.name ?? "");
    setImportResult(null);
    setImportParseError("");

    if (!file) {
      return;
    }

    try {
      const input: unknown = JSON.parse(await file.text());
      setImportResult(validateBackupData(input));
    } catch {
      setImportParseError("JSON 파일을 읽거나 파싱하지 못했습니다.");
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

      <div className="settings-list">
        <h3>데이터 가져오기 미리보기</h3>
        <p>백업 파일을 검증하고 포함된 데이터만 확인합니다. 기존 데이터는 변경하지 않습니다.</p>
        <input
          type="file"
          accept=".json,application/json"
          onChange={(event) => void handleImportFile(event.target.files?.[0])}
        />
        {importFilename && <p>선택한 파일: {importFilename}</p>}
        {importParseError && <p className="summary">{importParseError}</p>}
        {importResult?.valid && (
          <div className="summary">
            <p>백업 파일 검증에 성공했습니다.</p>
            <p>업무: {importResult.summary.taskCount}개</p>
            <p>프로젝트: {importResult.summary.projectCount}개</p>
            <p>설정 포함: {importResult.summary.hasAppSettings ? "예" : "아니오"}</p>
          </div>
        )}
        {importResult && !importResult.valid && (
          <div className="summary">
            <p>백업 파일 검증에 실패했습니다.</p>
            <ul>
              {importResult.errors.map((error) => (
                <li key={error}>{error}</li>
              ))}
            </ul>
          </div>
        )}
      </div>
    </section>
  );
}
