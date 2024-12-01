import SwiftUI

class AddTransactionProcessor: AddTransactionViewModel {
    @Published var uiState = AddTransactionUIState.initial
    
    init() {
        // Пример данных
        let foodCategory = CategoryTransaction(name: "Еда", color: .red, type: .expense, icon: "fork.knife")
        let salaryCategory = CategoryTransaction(name: "Зарплата", color: .green, type: .income, icon: "dollarsign.circle")
        let entertainmentCategory = CategoryTransaction(name: "Развлечения", color: .blue, type: .expense, icon: "gamecontroller")
        let investmentCategory = CategoryTransaction(name: "Инвестиции", color: .purple, type: .income, icon: "chart.bar")

        self.uiState = self.uiState.copy(
            category: self.uiState.category,
            categories: [foodCategory, salaryCategory, entertainmentCategory, investmentCategory]
        )
    }

    func editAmount(_ amount: Double) {
        let roundedAmount = (amount * 100).rounded() / 100
        self.uiState = self.uiState.copy(
            amount: roundedAmount,
            category: self.uiState.category
        )
    }
    
    func editDescription(_ description: String) {
        self.uiState = self.uiState.copy(
            description: description,
            category: self.uiState.category
        )
    }
    
    func editDate(_ date: Date) {
        self.uiState = self.uiState.copy(
            date: date,
            category: self.uiState.category
        )
    }
    
    func editType(_ type: TypeTransaction) {
        self.uiState = self.uiState.copy(
            type: type,
            category: nil
        )
    }
    
    func editCategory(_ category: CategoryTransaction) {
        self.uiState = self.uiState.copy(category: category)
    }
    
    func onClickAddTransaction() {
        print(uiState)
    }
}
