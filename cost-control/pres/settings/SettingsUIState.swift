import Foundation

struct SettingsUIState : Equatable {
    let isBiometricsEnabled: Bool
    let isDarkModeEnabled: Bool
    let currency: String
    let isCurrencyPickerShowed: Bool
    let isResetConfirmationShowed: Bool
    let isAppDescriptionAlertShowed: Bool
    let isPrivacyPolicyAlertShowed: Bool
}

extension SettingsUIState {
    func copy(
        isBiometricsEnabled: Bool? = nil,
        isDarkModeEnabled: Bool? = nil,
        currency: String? = nil,
        isCurrencyPickerShowed: Bool? = nil,
        isResetConfirmationShowed: Bool? = nil,
        isAppDescriptionAlertShowed: Bool? = nil,
        isPrivacyPolicyAlertShowed: Bool? = nil
    ) -> SettingsUIState {
        let newUiState = SettingsUIState(
            isBiometricsEnabled: isBiometricsEnabled ?? self.isBiometricsEnabled,
            isDarkModeEnabled: isDarkModeEnabled ?? self.isDarkModeEnabled,
            currency: currency ?? self.currency,
            isCurrencyPickerShowed: isCurrencyPickerShowed ?? self.isCurrencyPickerShowed,
            isResetConfirmationShowed: isResetConfirmationShowed ?? self.isResetConfirmationShowed,
            isAppDescriptionAlertShowed: isAppDescriptionAlertShowed ?? self.isAppDescriptionAlertShowed,
            isPrivacyPolicyAlertShowed: isPrivacyPolicyAlertShowed ?? self.isPrivacyPolicyAlertShowed
        )
        print(newUiState)
        return newUiState
    }
}
