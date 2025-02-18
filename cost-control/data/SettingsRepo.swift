import SwiftUI

class SettingsRepo : ISettingsRepo {
    private let userDefaults = UserDefaults.standard
    
    private let enableBiometricsKey = "enableBiometrics"
    private let darkModeKey = "darkMode"
    private let currencyKey = "currency"
    private let viewedOnboardingKey = "viewedOnboarding"
    
    func saveSettings(settings: AppSettings) {
        userDefaults.set(settings.enableBiometrics, forKey: enableBiometricsKey)
        userDefaults.set(settings.darkMode, forKey: darkModeKey)
        userDefaults.set(settings.currency, forKey: currencyKey)
        userDefaults.set(settings.viewedOnboarding, forKey: viewedOnboardingKey)
    }
    
    func getSettings() -> AppSettings {
        return AppSettings(
            currency: userDefaults.string(forKey: currencyKey) ?? "₽",
            darkMode: userDefaults.bool(forKey: darkModeKey),
            enableBiometrics: userDefaults.bool(forKey: enableBiometricsKey),
            viewedOnboarding: userDefaults.bool(forKey: viewedOnboardingKey)
        )
    }
}
