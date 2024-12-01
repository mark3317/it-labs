import Foundation

class HomeProcessor: HomeViewModel {
    @Published var uiState = HomeUIState.initial
    
    init() {
        loadData()
    }
    
    func loadData() {
        // Пример данных
        let transactions = [
            Transaction(amount: 100.0, description: "Salary", date: Date(), type: .income, category: nil),
            Transaction(amount: 50.0, description: "Groceries", date: Date(), type: .expense, category: nil),
            Transaction(amount: 150.0, description: "Groceries", date: Date(), type: .expense, category: nil),
            Transaction(amount: 150.0, description: "Groceries", date: Date(), type: .expense, category: nil),
            Transaction(amount: 200.0, description: "Groceries", date: Date(), type: .expense, category: nil),
            Transaction(amount: 30.0, description: "Groceries", date: Date(), type: .income, category: nil),
            Transaction(amount: 120.0, description: "Groceries", date: Date(), type: .expense, category: nil),
            Transaction(amount: 50.0, description: "Groceries", date: Date(), type: .expense, category: nil),
            Transaction(amount: 510.0, description: "Groceries", date: Date(), type: .expense, category: nil)
        ]
        
        uiState = uiState.copy(
            totalIncome: transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount },
            totalExpense: transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount },
            balance: transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount } -
            transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount },
            recentTransactions: transactions
        )
    }
}
