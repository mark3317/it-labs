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
            totalIncome: 0,
            totalExpense: 0,
            balance: 0,
            transactions: []
        )
        loadData()
    }
    
    func loadData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let foodCategory = Category(name: "Еда", colorHex: Color.red.toHex(), type: .expense, icon: "fork.knife")
        let salaryCategory = Category(name: "Зарплата", colorHex: Color.green.toHex(), type: .income, icon: "dollarsign.circle")
        let entertainmentCategory = Category(name: "Развлечения", colorHex: Color.blue.toHex(), type: .expense, icon: "gamecontroller")
        let investmentCategory = Category(name: "Инвестиции", colorHex: Color.purple.toHex(), type: .income, icon: "chart.bar")
        // Пример данных
        let transactions = [
            Transaction(amount: 100.0, description: "Salary", date: dateFormatter.date(from: "2023-10-01")!, type: .income, category: salaryCategory),
            Transaction(amount: 50.0, description: "Food", date: Date(), type: .expense, category: foodCategory),
            Transaction(amount: 150.0, description: "Entertainment", date: dateFormatter.date(from: "2023-11-20")!, type: .expense, category: entertainmentCategory),
            Transaction(amount: 150.0, description: "Investment", date: dateFormatter.date(from: "2023-12-6")!, type: .income, category: investmentCategory),
            Transaction(amount: 150.0, description: "Investment", date: dateFormatter.date(from: "2023-12-6")!, type: .income, category: investmentCategory),
            Transaction(amount: 100.0, description: "Salary", date: dateFormatter.date(from: "2023-11-11")!, type: .income, category: salaryCategory),
            Transaction(amount: 50.0, description: "Food", date: dateFormatter.date(from: "2023-12-1")!, type: .expense, category: foodCategory),
            Transaction(amount: 150.0, description: "Entertainment", date: dateFormatter.date(from: "2023-11-29")!, type: .expense, category: entertainmentCategory),
            Transaction(amount: 150.0, description: "Investment", date: dateFormatter.date(from: "2023-12-3")!, type: .income, category: investmentCategory)
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
