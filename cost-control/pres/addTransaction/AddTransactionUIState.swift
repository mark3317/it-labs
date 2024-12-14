import Foundation
import SwiftUI

struct AddTransactionUIState: Equatable {
    let currency: String
    let amount: Double
    let description: String
    let date: Date
    let type: TypeTransaction
    let selectedCategory: Category?
    let categories: [Category]
}

extension AddTransactionUIState {
    static let initial = AddTransactionUIState(
        currency: "₽",
        amount: 0,
        description: "",
        date: Date(),
        type: TypeTransaction.expense,
        selectedCategory: nil,
        categories: []
    )
}

extension AddTransactionUIState {
    func copy(
        amount: Double? = nil,
        description: String? = nil,
        date: Date? = nil,
        type: TypeTransaction? = nil,
        category: Category?,
        categories: [Category]? = nil
    ) -> AddTransactionUIState {
        let newUiState = AddTransactionUIState(
            currency: self.currency,
            amount: amount ?? self.amount,
            description: description ?? self.description,
            date: date ?? self.date,
            type: type ?? self.type,
            selectedCategory: category,
            categories: categories ?? self.categories
        )
        print(newUiState)
        return newUiState
    }
}
