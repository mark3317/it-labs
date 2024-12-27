import SwiftUI

@main
struct CostControlApp: App {
    @StateObject var costControlOps = CostControlOps(
        settingsRepo: SettingsRepo(),
        storageRepo: StorageRepo(),
        authRepo: AuthRepo()
    )
    
    var body: some Scene {
        WindowGroup {
            Group {
                if (costControlOps.isAuthorized || !costControlOps.settings.enableBiometrics) {
                    MainTabView(viewModel: MainTabProcessor(ops: costControlOps))
                } else {
                    AuthView(viewModel: AuthProcessor(ops: costControlOps))
                }
            }
            .colorScheme(costControlOps.settings.darkMode ? .dark : .light)
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.5), value: (costControlOps.isAuthorized || !costControlOps.settings.enableBiometrics))
        }
    }
}
