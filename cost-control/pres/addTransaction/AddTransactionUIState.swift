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
    let isSaved: Bool
}

extension AddTransactionUIState {
    func copy(
        amount: Double? = nil,
        description: String? = nil,
        date: Date? = nil,
        type: TransactionType? = nil,
        category: Category?,
        categories: [Category]? = nil,
        isSaved: Bool? = nil
    ) -> AddTransactionUIState {
        let newUiState = AddTransactionUIState(
            currency: self.currency,
            amount: amount ?? self.amount,
            description: description ?? self.description,
            date: date ?? self.date,
            type: type ?? self.type,
            selectedCategory: category,
            categories: categories ?? self.categories,
            isSaved: isSaved ?? self.isSaved
        )
        print(newUiState)
        return newUiState
    }
}
