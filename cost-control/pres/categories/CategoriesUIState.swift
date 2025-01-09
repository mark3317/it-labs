import Foundation
import SwiftUI

struct CategoriesUIState : Equatable {
    let currency: String
    let type: TransactionType
    let selectedCategory: Category?
    let categories: [Category]
    let transactions: [Transaction]
}

extension CategoriesUIState {
    func copy(
        currency: String? = nil,
        typeInput: TransactionType? = nil,
        selectedCategory: Category?,
        categories: [Category]? = nil,
        transactions: [Transaction]? = nil
    ) -> CategoriesUIState {
        let newUiState = CategoriesUIState(
            currency: currency ?? self.currency,
            type: typeInput ?? self.type,
            selectedCategory: selectedCategory,
            categories: categories ?? self.categories,
            transactions: transactions ?? self.transactions
        )
        print(newUiState)
        return newUiState
    }
}
