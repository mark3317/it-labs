import SwiftUI

class CategoriesViewModel: ObservableObject {
    @ObservedObject private var ops: CostControlOps
    @Published private(set) var uiState: CategoriesUIState
    private(set) var addCategoryVM: AddCategoryViewModel
    
    init(ops: CostControlOps) {
        self.ops = ops
        addCategoryVM = AddCategoryViewModel(ops: ops)
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
            selectedCategory: nil
        )
    }
    
    func editExpandedCategory(_ category: Category) {
        uiState = uiState.copy(
            selectedCategory: category == uiState.selectedCategory ? nil : category
        )
    }
}
