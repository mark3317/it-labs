import Foundation
import SwiftUI

struct AddCategoryUIState {
    let name: String
    let color: Color
    let type: TypeTransaction
    let icon: String
}

extension AddCategoryUIState {
    static let initial = AddCategoryUIState(
        name: "",
        color: Color.white,
        type: TypeTransaction.expense,
        icon: "minus"
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
