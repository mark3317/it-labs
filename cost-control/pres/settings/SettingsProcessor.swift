import SwiftUI
import Foundation

class SettingsProcessor: SettingsViewModel {
    @Published var uiState = SettingsUIState.initial
    
    func editNotificationsEnabled(_ enabled: Bool) {
        uiState = uiState.copy(
            isNotificationsEnabled: enabled
        )
    }
    
    func editBiometricsEnabled(_ enabled: Bool) {
        uiState = uiState.copy(
            isBiometricsEnabled: enabled
        )
    }
    
    func editDarkModeEnabled(_ enabled: Bool) {
        uiState = uiState.copy(
            isDarkModeEnabled: enabled
        )
    }
    
    func editCurrencySymbol(_ symbol: String) {
        uiState = uiState.copy(
            selectedCurrencySymbol: symbol
        )
    }
    
    func resetSettings() {
        uiState = SettingsUIState.initial
    }
}
