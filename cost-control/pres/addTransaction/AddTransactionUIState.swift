import Foundation
import SwiftUI

struct AddTransactionUIState: Equatable {
    let amount: Double
    let description: String
    let date: Date
    let type: TypeTransaction
    let category: CategoryTransaction?
    let categories: [CategoryTransaction]
}

extension AddTransactionUIState {
    static let initial = AddTransactionUIState(
        amount: 0,
        description: "",
        date: Date(),
        type: TypeTransaction.expense,
        category: nil,
        categories: []
    )
}

extension AddTransactionUIState {
    func copy(
        amount: Double? = nil,
        description: String? = nil,
        date: Date? = nil,
        type: TypeTransaction? = nil,
        category: CategoryTransaction?,
        categories: [CategoryTransaction]? = nil
    ) -> AddTransactionUIState {
        let newUiState = AddTransactionUIState(
            amount: amount ?? self.amount,
            description: description ?? self.description,
            date: date ?? self.date,
            type: type ?? self.type,
            category: category,
            categories: categories ?? self.categories
        )
        print(newUiState)
        return newUiState
    }
}
