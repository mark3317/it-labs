import SwiftUI

class ContentProcessor: ContentViewModel {    
    @ObservedObject private var ops: CostControlOps
    @Published private(set) var uiState: ContentUIState
    private(set) var homeViewModel: HomeProcessor
    private(set) var categoriesViewModel: CategoriesProcessor
    private(set) var settingsViewModel: SettingsProcessor
    
    init(ops: CostControlOps) {
        self.ops = ops
        homeViewModel = HomeProcessor(ops: ops)
        categoriesViewModel = CategoriesProcessor(ops: ops)
        settingsViewModel = SettingsProcessor(ops: ops)
        uiState = .init(darkMode: ops.settings.darkMode)
    }
}
