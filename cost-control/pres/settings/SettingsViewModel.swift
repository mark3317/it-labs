import Combine

protocol SettingsViewModel : ObservableObject {
    var uiState: SettingsUIState { get }
    func editNotificationsEnabled(_ enabled: Bool)
    func editBiometricsEnabled(_ enabled: Bool)
    func editDarkModeEnabled(_ enabled: Bool)
    func editCurrencySymbol(_ symbol: String)
    func resetSettings()
}
