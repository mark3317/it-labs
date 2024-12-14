import SwiftUI

class CategoriesProcessor: CategoriesViewModel {
    @ObservedObject private var ops: CostControlOps
    @Published private(set) var uiState: CategoriesUIState
    private(set) var addCategoryViewModel: AddCategoryProcessor
    
    init(ops: CostControlOps) {
        self.ops = ops
        addCategoryViewModel = AddCategoryProcessor(ops: ops)
        uiState = .init(
            currency: ops.settings.currency,
            type: .expense,
            selectedCategory: nil,
            categories: ops.categories,
            transactions: ops.transactions
        )
    }
    
    func editType(_ type: TransactionType) {
        uiState = uiState.copy(
            typeInput: type,
            expandedCategory: nil
        )
    }
    
    func editExpandedCategory(_ category: Category) {
        uiState = uiState.copy(
            expandedCategory: category == uiState.selectedCategory ? nil : category
        )
    }
}
