import Foundation

struct OnboardingUIState : Equatable {
    let currentPage: Int
    let viewedLastPage: Bool
    let viewedOnboarding: Bool
}

extension OnboardingUIState {
    func copy(
        currentPage: Int? = nil,
        viewedLastPage: Bool? = nil,
        viewedOnboarding: Bool? = nil
    ) -> OnboardingUIState {
        let newUiState = OnboardingUIState(
            currentPage: currentPage ?? self.currentPage,
            viewedLastPage: viewedLastPage ?? self.viewedLastPage,
            viewedOnboarding: viewedOnboarding ?? self.viewedOnboarding
        )
        print(newUiState)
        return newUiState
    }
}
