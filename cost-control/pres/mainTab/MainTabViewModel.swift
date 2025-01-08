import SwiftUI

class MainTabViewModel: ObservableObject {    
    @ObservedObject private var ops: CostControlOps
    private(set) var homeViewModel: HomeViewModel
    private(set) var categoriesViewModel: CategoriesViewModel
    private(set) var settingsViewModel: SettingsViewModel
    
    init(ops: CostControlOps) {
        self.ops = ops
        homeViewModel = HomeViewModel(ops: ops)
        categoriesViewModel = CategoriesViewModel(ops: ops)
        settingsViewModel = SettingsViewModel(ops: ops)
    }
}
