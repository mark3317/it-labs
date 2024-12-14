import Combine

final class CostControlOps : ObservableObject {
    private var settingsRepo: any ISettingsRepo
    @Published private(set) var settings: AppSettings
    
    init(settingsRepo: any ISettingsRepo) {
        self.settingsRepo = settingsRepo
        self.settings = settingsRepo.getSettings()
    }
    
    func saveSetting(settings: AppSettings) {
        settingsRepo.saveSettings(settings: settings)
        self.settings = settings
    }
}
