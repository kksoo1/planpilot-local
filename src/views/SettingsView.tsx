import type { AppSettings } from "../types";

type SettingsViewProps = {
  appSettings: AppSettings;
  onUpdateAppSettings: (settings: AppSettings) => Promise<void>;
};

export function SettingsView({ appSettings, onUpdateAppSettings }: SettingsViewProps) {
  function handleThemeChange(theme: AppSettings["theme"]) {
    if (theme === appSettings.theme) {
      return;
    }

    void onUpdateAppSettings({
      ...appSettings,
      theme,
    });
  }

  return (
    <section className="screen-card">
      <h2>설정</h2>
      <div className="settings-list">
        <p>테마: {appSettings.theme}</p>
        <label>
          테마
          <select
            value={appSettings.theme}
            onChange={(event) => handleThemeChange(event.target.value as AppSettings["theme"])}
          >
            <option value="light">light</option>
          </select>
        </label>
        <p>언어: {appSettings.language}</p>
        <p>AI Provider: {appSettings.aiProvider}</p>
        <p>알림: {appSettings.enableNotifications ? "사용" : "MVP에서는 사용하지 않음"}</p>
        <p>첫 실행 완료: {String(appSettings.firstLaunchCompleted)}</p>
      </div>
    </section>
  );
}
