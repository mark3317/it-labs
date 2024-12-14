import SwiftUI

@main
struct CostControlApp: App {
    @StateObject var costControlOps = CostControlOps(settingsRepo: SettingsRepo())
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentProcessor(ops: costControlOps))
        }
    }
}
