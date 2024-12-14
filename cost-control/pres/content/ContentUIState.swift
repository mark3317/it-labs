import Foundation

struct ContentUIState : Equatable {
    let darkMode: Bool
}

extension ContentUIState {
    static let initial = ContentUIState(
        darkMode: false
    )
}

extension ContentUIState {
    func copy(
        darkMode: Bool? = nil
    ) -> ContentUIState {
        let newUiState = ContentUIState(
            darkMode: darkMode ?? self.darkMode
        )
        print(newUiState)
        return newUiState
    }
}
