import Foundation
import SwiftUI

struct AddCategoryUIState : Equatable {
    let name: String
    let color: Color
    let type: TypeTransaction
    let icon: String
}

extension AddCategoryUIState {
    static let initial = AddCategoryUIState(
        name: "",
        color: Category.colors[0],
        type: TypeTransaction.expense,
        icon: Category.icons[0]
    )
}

extension AddCategoryUIState {
    func copy(
        name: String? = nil,
        color: Color? = nil,
        type: TypeTransaction? = nil,
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
