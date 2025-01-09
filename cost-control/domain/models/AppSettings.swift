struct AppSettings {
    let currency: String
    let darkMode: Bool
    let enableBiometrics: Bool
    let viewedOnboarding: Bool
}

extension AppSettings {
    static let currencySymbols: [String] = ["$", "€", "₽", "¥"]
    
    func copy(
        currency: String? = nil,
        darkMode: Bool? = nil,
        enableBiometrics: Bool? = nil,
        viewedOnboarding: Bool? = nil
    ) -> AppSettings {
        return AppSettings(
            currency: currency ?? self.currency,
            darkMode: darkMode ?? self.darkMode,
            enableBiometrics: enableBiometrics ?? self.enableBiometrics,
            viewedOnboarding: viewedOnboarding ?? self.viewedOnboarding
        )
    }
}
