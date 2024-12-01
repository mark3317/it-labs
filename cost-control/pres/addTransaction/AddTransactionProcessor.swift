import SwiftUI

class AddTransactionProcessor: AddTransactionViewModel {
    @Published var uiState = AddTransactionUIState.initial
    
    init() {
        // Пример данных
        let foodCategory = CategoryTransaction(name: "Еда", color: .red, type: .expense, icon: "fork.knife")
        let salaryCategory = CategoryTransaction(name: "Зарплата", color: .green, type: .income, icon: "dollarsign.circle")
        let entertainmentCategory = CategoryTransaction(name: "Развлечения", color: .blue, type: .expense, icon: "gamecontroller")
        let investmentCategory = CategoryTransaction(name: "Инвестиции", color: .purple, type: .income, icon: "chart.bar")

        uiState = uiState.copy(
            category: uiState.category,
            categories: [foodCategory, salaryCategory, entertainmentCategory, investmentCategory]
        )
    }

    func editAmount(_ amount: Double) {
        let roundedAmount = (amount * 100).rounded() / 100
        uiState = uiState.copy(
            amount: roundedAmount,
            category: uiState.category
        )
    }
    
    func editDescription(_ description: String) {
        uiState = uiState.copy(
            description: description,
            category: uiState.category
        )
    }
    
    func editDate(_ date: Date) {
        uiState = uiState.copy(
            date: date,
            category: uiState.category
        )
    }
    
    func editType(_ type: TypeTransaction) {
        uiState = uiState.copy(
            type: type,
            category: nil
        )
    }
    
    func editCategory(_ category: CategoryTransaction) {
        if (category == uiState.category) {
            uiState = uiState.copy(category: nil)
        } else {
            uiState = uiState.copy(category: category)
        }
    }
    
    func onClickAddTransaction() {
        print(uiState)
    }
}
