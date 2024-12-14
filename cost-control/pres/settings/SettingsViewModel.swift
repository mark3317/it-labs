import Combine

protocol SettingsViewModel : ObservableObject {
    var uiState: SettingsUIState { get }
    var notificationsViewModel: NotificationsProcessor { get }
    func editBiometricsEnabled(_ enabled: Bool)
    func editDarkModeEnabled(_ enabled: Bool)
    func editCurrencySymbol(_ symbol: String)
    func editCurrencyPickerShowed(_ enabled: Bool)
    func editResetConfirmationShowed(_ enabled: Bool)
    func editAppDescriptionAlertShowed(_ enabled: Bool)
    func editPrivacyPolicyAlertShowed(_ enabled: Bool)
    func resetSettings()
}
