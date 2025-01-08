import SwiftUI

class CategoriesViewModel: ObservableObject {
    @ObservedObject private var ops: CostControlOps
    @Published private(set) var uiState: CategoriesUIState
    private(set) var addCategoryViewModel: AddCategoryViewModel
    
    init(ops: CostControlOps) {
        self.ops = ops
        addCategoryViewModel = AddCategoryViewModel(ops: ops)
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
