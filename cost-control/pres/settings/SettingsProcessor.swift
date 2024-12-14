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
            selectedCurrencySymbol: ops.settings.currency
        )
    }
    
    func editBiometricsEnabled(_ enabled: Bool) {
        ops.saveSetting(settings: AppSettings(
            currency: uiState.selectedCurrencySymbol, darkMode: uiState.isDarkModeEnabled, enableBiometrics: enabled
        ))
        uiState = uiState.copy(
            isBiometricsEnabled: enabled
        )
    }
    
    func editDarkModeEnabled(_ enabled: Bool) {
        ops.saveSetting(settings: AppSettings(
            currency: uiState.selectedCurrencySymbol, darkMode: enabled, enableBiometrics: uiState.isBiometricsEnabled
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
            selectedCurrencySymbol: symbol
        )
    }
    
    func resetSettings() {
        let newState = SettingsUIState.initial
        ops.saveSetting(settings: AppSettings(
            currency: newState.selectedCurrencySymbol, darkMode: newState.isDarkModeEnabled, enableBiometrics: newState.isBiometricsEnabled
        ))
        uiState = newState
    }
}
