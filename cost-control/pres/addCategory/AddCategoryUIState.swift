import Foundation
import SwiftUI

struct AddCategoryUIState : Equatable {
    let name: String
    let color: Color
    let type: TransactionType
    let icon: String
}

extension AddCategoryUIState {
    func copy(
        name: String? = nil,
        color: Color? = nil,
        type: TransactionType? = nil,
        icon: String? = nil
    ) -> AddCategoryUIState {
        let newUiState = AddCategoryUIState(
            name: name ?? self.name,
            color: color ?? self.color,
            type: type ?? self.type,
            icon: icon ?? self.icon
        )
        print(newUiState)
        return newUiState
    }
}
