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
        typeInput: TransactionType? = nil,
        expandedCategory: Category?,
        categories: [Category]? = nil,
        transactions: [Transaction]? = nil
    ) -> CategoriesUIState {
        let newUiState = CategoriesUIState(
            currency: self.currency,
            type: typeInput ?? self.type,
            selectedCategory: expandedCategory,
            categories: categories ?? self.categories,
            transactions: transactions ?? self.transactions
        )
        print(newUiState)
        return newUiState
    }
}
