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
                if (!costControlOps.settings.viewedOnboarding) {
                    OnboardingView(viewModel: OnboardingViewModel(ops: costControlOps))
                }
                else if (costControlOps.isAuthorized || !costControlOps.settings.enableBiometrics) {
                    MainTabView(viewModel: MainTabViewModel(ops: costControlOps))
                } else {
                    AuthView(viewModel: AuthViewModel(ops: costControlOps))
                }
            }
            .colorScheme(costControlOps.settings.darkMode ? .dark : .light)
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.5), value: (costControlOps.isAuthorized || !costControlOps.settings.enableBiometrics))
            .animation(.easeInOut(duration: 0.5), value: costControlOps.settings.viewedOnboarding)
        }
    }
}
