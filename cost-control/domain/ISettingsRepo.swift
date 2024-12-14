import Combine

protocol ISettingsRepo {
    func saveSettings(settings: AppSettings)
    func getSettings() -> AppSettings
}
