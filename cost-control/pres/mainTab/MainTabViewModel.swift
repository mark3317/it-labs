import SwiftUI

class MainTabViewModel: ObservableObject {    
    @ObservedObject private var ops: CostControlOps
    private(set) var homeVM: HomeViewModel
    private(set) var categoriesVM: CategoriesViewModel
    private(set) var settingsVM: SettingsViewModel
    
    init(ops: CostControlOps) {
        self.ops = ops
        homeVM = HomeViewModel(ops: ops)
        categoriesVM = CategoriesViewModel(ops: ops)
        settingsVM = SettingsViewModel(ops: ops)
    }
}
