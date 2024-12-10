import Foundation

struct SettingsUIState : Equatable {
    let isNotificationsEnabled: Bool
    let isBiometricsEnabled: Bool
    let isDarkModeEnabled: Bool
    let selectedCurrencySymbol: String
    let currencySymbols: [String] = ["$", "€", "₽", "¥"]
}

extension SettingsUIState {
    static let initial = SettingsUIState(
        isNotificationsEnabled: true,
        isBiometricsEnabled: false,
        isDarkModeEnabled: false,
        selectedCurrencySymbol: "₽"
    )
}

extension SettingsUIState {
    func copy(
        isNotificationsEnabled: Bool? = nil,
        isBiometricsEnabled: Bool? = nil,
        isDarkModeEnabled: Bool? = nil,
        selectedCurrencySymbol: String? = nil
    ) -> SettingsUIState {
        let newUiState = SettingsUIState(
            isNotificationsEnabled: isNotificationsEnabled ?? self.isNotificationsEnabled,
            isBiometricsEnabled: isBiometricsEnabled ?? self.isBiometricsEnabled,
            isDarkModeEnabled: isDarkModeEnabled ?? self.isDarkModeEnabled,
            selectedCurrencySymbol: selectedCurrencySymbol ?? self.selectedCurrencySymbol
        )
        print(newUiState)
        return newUiState
    }
}
