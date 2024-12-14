import SwiftUI

class SettingsProcessor: SettingsViewModel {
    @ObservedObject private var ops: CostControlOps
    @Published private(set) var uiState: SettingsUIState
    private(set) var notificationsViewModel: NotificationsProcessor
    
    init(ops: CostControlOps) {
        self.ops = ops
        notificationsViewModel = NotificationsProcessor(ops: ops)
        uiState = .init(
            isBiometricsEnabled: ops.settings.enableBiometrics,
            isDarkModeEnabled: ops.settings.darkMode,
            currency: ops.settings.currency,
            isCurrencyPickerShowed: false,
            isResetConfirmationShowed: false,
            isAppDescriptionAlertShowed: false,
            isPrivacyPolicyAlertShowed: false
        )
    }
    
    func editBiometricsEnabled(_ enabled: Bool) {
        ops.saveSetting(settings: AppSettings(
            currency: uiState.currency, darkMode: uiState.isDarkModeEnabled, enableBiometrics: enabled
        ))
        uiState = uiState.copy(
            isBiometricsEnabled: enabled
        )
    }
    
    func editDarkModeEnabled(_ enabled: Bool) {
        ops.saveSetting(settings: AppSettings(
            currency: uiState.currency, darkMode: enabled, enableBiometrics: uiState.isBiometricsEnabled
        ))
        uiState = uiState.copy(
            isDarkModeEnabled: enabled
        )
    }
    
    func editCurrencySymbol(_ symbol: String) {
        ops.saveSetting(settings: AppSettings(
            currency: symbol, darkMode: uiState.isDarkModeEnabled, enableBiometrics: uiState.isBiometricsEnabled
        ))
        uiState = uiState.copy(
            currency: symbol
        )
    }
    
    func editCurrencyPickerShowed(_ enabled: Bool) {
        uiState = uiState.copy(
            isCurrencyPickerShowed: enabled
        )
    }
    
    func editResetConfirmationShowed(_ enabled: Bool) {
        uiState = uiState.copy(
            isResetConfirmationShowed: enabled
        )
    }
    
    func editAppDescriptionAlertShowed(_ enabled: Bool) {
        uiState = uiState.copy(
            isAppDescriptionAlertShowed: enabled
        )
    }
    
    func editPrivacyPolicyAlertShowed(_ enabled: Bool) {
        uiState = uiState.copy(
            isPrivacyPolicyAlertShowed: enabled
        )
    }
    
    func resetSettings() {
        ops.saveSetting(settings: AppSettings(
            currency: "₽", darkMode: false, enableBiometrics: false
        ))
        uiState = uiState.copy(
            isBiometricsEnabled: ops.settings.enableBiometrics,
            isDarkModeEnabled: ops.settings.darkMode,
            currency: ops.settings.currency
        )
    }
}
