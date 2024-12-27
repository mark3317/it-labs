import SwiftUI

class MainTabProcessor: MainTabViewModel {    
    @ObservedObject private var ops: CostControlOps
    private(set) var homeViewModel: HomeProcessor
    private(set) var categoriesViewModel: CategoriesProcessor
    private(set) var settingsViewModel: SettingsProcessor
    
    init(ops: CostControlOps) {
        self.ops = ops
        homeViewModel = HomeProcessor(ops: ops)
        categoriesViewModel = CategoriesProcessor(ops: ops)
        settingsViewModel = SettingsProcessor(ops: ops)
    }
}
