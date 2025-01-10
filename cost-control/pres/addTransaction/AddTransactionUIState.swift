import Foundation
import SwiftUI

struct AddTransactionUIState: Equatable {
    let currency: String
    let amount: Double
    let description: String
    let date: Date
    let type: TransactionType
    let selectedCategory: Category?
    let categories: [Category]
}

extension AddTransactionUIState {
    func copy(
        currency: String? = nil,
        amount: Double? = nil,
        description: String? = nil,
        date: Date? = nil,
        type: TransactionType? = nil,
        category: Category?,
        categories: [Category]? = nil
    ) -> AddTransactionUIState {
        let newUiState = AddTransactionUIState(
            currency: currency ?? self.currency,
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
