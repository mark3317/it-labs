import SwiftUI

class HomeProcessor: HomeViewModel {
    @ObservedObject private var ops: CostControlOps
    @Published private(set) var uiState: HomeUIState
    private(set) var addTransactionViewModel: AddTransactionProcessor
    
    init(ops: CostControlOps) {
        self.ops = ops
        addTransactionViewModel = AddTransactionProcessor(ops: ops)
        uiState = .init(
            currency: ops.settings.currency,
            totalIncome: ops.transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount },
            totalExpense: ops.transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount },
            balance: ops.transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount } -
            ops.transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount },
            transactions: ops.transactions
        )
    }
}
