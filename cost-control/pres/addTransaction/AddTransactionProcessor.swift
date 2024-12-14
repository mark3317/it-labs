import SwiftUI

class AddTransactionProcessor: AddTransactionViewModel {
    @ObservedObject private var ops: CostControlOps
    @Published private(set) var uiState: AddTransactionUIState
    
    init(ops: CostControlOps) {
        self.ops = ops
        uiState = .init(
            currency: ops.settings.currency,
            amount: 0,
            description: "",
            date: Date(),
            type: TransactionType.expense,
            selectedCategory: nil,
            categories: ops.categories
        )
    }
    
    func editAmount(_ amount: Double) {
        let roundedAmount = (amount * 100).rounded() / 100
        uiState = uiState.copy(
            amount: roundedAmount,
            category: uiState.selectedCategory
        )
    }
    
    func editDescription(_ description: String) {
        uiState = uiState.copy(
            description: description,
            category: uiState.selectedCategory
        )
    }
    
    func editDate(_ date: Date) {
        uiState = uiState.copy(
            date: date,
            category: uiState.selectedCategory
        )
    }
    
    func editType(_ type: TransactionType) {
        uiState = uiState.copy(
            type: type,
            category: nil
        )
    }
    
    func editCategory(_ category: Category) {
        if (category == uiState.selectedCategory) {
            uiState = uiState.copy(category: nil)
        } else {
            uiState = uiState.copy(category: category)
        }
    }
    
    func onClickAddTransaction() {
        Task {
            await ops.saveTransaction(transaction: Transaction(
                amount: uiState.amount,
                description: uiState.description,
                date: uiState.date,
                type: uiState.type,
                category: uiState.selectedCategory
            ))
        }
    }
}
