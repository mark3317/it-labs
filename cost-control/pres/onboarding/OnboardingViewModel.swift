import SwiftUI

class OnboardingViewModel: ObservableObject {
    @ObservedObject private var ops: CostControlOps
    @Published private(set) var uiState: OnboardingUIState
    
    init(ops: CostControlOps) {
        self.ops = ops
        uiState = .init(
            currentPage: 0,
            viewedLastPage: false,
            viewedOnboarding: ops.settings.viewedOnboarding
        )
    }
    
    func editCurrentPage(_ currentPage: Int) {
        uiState = uiState.copy(
            currentPage: currentPage,
            viewedLastPage: uiState.viewedLastPage ? true : (currentPage == 2 ? true : false)
        )
    }
    
    func markViewOnboarding() {
        ops.markViewOnboarding(viewedOnboarding: true)
    }
}
