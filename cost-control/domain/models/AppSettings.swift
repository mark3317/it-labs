struct AppSettings {
    let currency: String
    let darkMode: Bool
    let enableBiometrics: Bool
}

extension AppSettings {
    static let currencySymbols: [String] = ["$", "€", "₽", "¥"]
}
