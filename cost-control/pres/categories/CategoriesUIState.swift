import Foundation
import SwiftUI

struct CategoriesUIState {
    let typeInput: TypeTransaction
    let expandedCategory: Category?
    let categories: [Category]
    let transactions: [Transaction]
}

extension CategoriesUIState {
    static let initial = CategoriesUIState(
        typeInput: .expense,
        expandedCategory: nil,
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
            typeInput: typeInput ?? self.typeInput,
            expandedCategory: expandedCategory,
            categories: categories ?? self.categories,
            transactions: transactions ?? self.transactions
        )
        print(newUiState)
        return newUiState
    }
}
