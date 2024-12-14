import Foundation

struct SettingsUIState : Equatable {
    let isBiometricsEnabled: Bool
    let isDarkModeEnabled: Bool
    let selectedCurrencySymbol: String
}

extension SettingsUIState {
    static let initial = SettingsUIState(
        isBiometricsEnabled: false,
        isDarkModeEnabled: false,
        selectedCurrencySymbol: "₽"
    )
}

extension SettingsUIState {
    func copy(
        isBiometricsEnabled: Bool? = nil,
        isDarkModeEnabled: Bool? = nil,
        selectedCurrencySymbol: String? = nil
    ) -> SettingsUIState {
        let newUiState = SettingsUIState(
            isBiometricsEnabled: isBiometricsEnabled ?? self.isBiometricsEnabled,
            isDarkModeEnabled: isDarkModeEnabled ?? self.isDarkModeEnabled,
            selectedCurrencySymbol: selectedCurrencySymbol ?? self.selectedCurrencySymbol
        )
        print(newUiState)
        return newUiState
    }
}
