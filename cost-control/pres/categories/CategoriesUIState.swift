import Foundation
import SwiftUI

struct CategoriesUIState : Equatable {
    let type: TypeTransaction
    let selectedCategory: Category?
    let categories: [Category]
    let transactions: [Transaction]
}

extension CategoriesUIState {
    static let initial = CategoriesUIState(
        type: .expense,
        selectedCategory: nil,
        categories: [],
        transactions: []
    )
}

extension CategoriesUIState {
    func copy(
        typeInput: TypeTransaction? = nil,
        expandedCategory: Category?,
        categories: [Category]? = nil,
        transactions: [Transaction]? = nil
    ) -> CategoriesUIState {
        let newUiState = CategoriesUIState(
            type: typeInput ?? self.type,
            selectedCategory: expandedCategory,
            categories: categories ?? self.categories,
            transactions: transactions ?? self.transactions
        )
        print(newUiState)
        return newUiState
    }
}
