import SwiftUI

@main
struct CostControlApp: App {
    @StateObject var costControlOps = CostControlOps(
        settingsRepo: SettingsRepo(),
        storageRepo: StorageRepo()
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentProcessor(ops: costControlOps))
        }
    }
}
