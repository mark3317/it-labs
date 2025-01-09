import SwiftUI

class SettingsViewModel: ObservableObject {
    @ObservedObject private var ops: CostControlOps
    @Published private(set) var uiState: SettingsUIState
    private(set) var notificationsVM: NotificationsViewModel
    private(set) var onboardingVM: OnboardingViewModel
    
    init(ops: CostControlOps) {
        self.ops = ops
        notificationsVM = NotificationsViewModel(ops: ops)
        onboardingVM = OnboardingViewModel(ops: ops)
        uiState = .init(
            isBiometricsEnabled: ops.settings.enableBiometrics,
            isDarkModeEnabled: ops.settings.darkMode,
            currency: ops.settings.currency,
            isCurrencyPickerShowed: false,
            isResetConfirmationShowed: false,
            urlPrivacyPolicy: Bundle.main.url(forResource: "Privacy", withExtension: "pdf")!
        )
    }
    
    func editBiometricsEnabled(_ enabled: Bool) {
        ops.saveSetting(settings: ops.settings.copy(enableBiometrics: enabled))
        uiState = uiState.copy(
            isBiometricsEnabled: enabled
        )
    }
    
    func editDarkModeEnabled(_ enabled: Bool) {
        ops.saveSetting(settings: ops.settings.copy(darkMode: enabled))
        uiState = uiState.copy(
            isDarkModeEnabled: enabled
        )
    }
    
    func editCurrencySymbol(_ symbol: String) {
        ops.saveSetting(settings: ops.settings.copy(currency: symbol))
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
    
    func resetSettings() {
        ops.saveSetting(settings: AppSettings(
            currency: "₽", darkMode: false, enableBiometrics: false, viewedOnboarding: true)
        )
        Task {
            await ops.clearAllData()
        }
        uiState = uiState.copy(
            isBiometricsEnabled: ops.settings.enableBiometrics,
            isDarkModeEnabled: ops.settings.darkMode,
            currency: ops.settings.currency
        )
    }
}
