import SwiftUI

class AddTransactionProcessor: AddTransactionViewModel {
    @Published var uiState = AddTransactionUIState.initial
    
    init() {
        // Пример данных
        let foodCategory = Category(name: "Еда", colorHex: Color.red.toHex(), type: .expense, icon: "fork.knife")
        let salaryCategory = Category(name: "Зарплата", colorHex: Color.green.toHex(), type: .income, icon: "dollarsign.circle")
        let entertainmentCategory = Category(name: "Развлечения", colorHex: Color.blue.toHex(), type: .expense, icon: "gamecontroller")
        let investmentCategory = Category(name: "Инвестиции", colorHex: Color.purple.toHex(), type: .income, icon: "chart.bar")
        
        uiState = uiState.copy(
            category: uiState.selectedCategory,
            categories: [foodCategory, salaryCategory, entertainmentCategory, investmentCategory]
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
    
    func editType(_ type: TypeTransaction) {
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
        print(uiState)
    }
}
