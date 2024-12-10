import SwiftUI
import Foundation

class CategoriesProcessor: CategoriesViewModel {
    
    @Published var uiState = CategoriesUIState.initial
    
    init() {
        
        let foodCategory = Category(name: "Еда", colorHex: Color.red.toHex(), type: .expense, icon: "fork.knife")
        let salaryCategory = Category(name: "Зарплата", colorHex: Color.green.toHex(), type: .income, icon: "dollarsign.circle")
        let entertainmentCategory = Category(name: "Развлечения", colorHex: Color.blue.toHex(), type: .expense, icon: "gamecontroller")
        let investmentCategory = Category(name: "Инвестиции", colorHex: Color.purple.toHex(), type: .income, icon: "chart.bar")
        
        let transactions = [
            Transaction(amount: 100.0, description: "Salary", date: Date(), type: .income, category: salaryCategory),
            Transaction(amount: 50.0, description: "Food", date: Date(), type: .expense, category: foodCategory),
            Transaction(amount: 150.0, description: "Entertainment", date: Date(), type: .expense, category: entertainmentCategory),
            Transaction(amount: 150.0, description: "Investment", date: Date(), type: .income, category: investmentCategory)
        ]
        
        uiState = uiState.copy(
            expandedCategory: self.uiState.selectedCategory,
            categories: [foodCategory, salaryCategory, entertainmentCategory, investmentCategory],
            transactions: transactions
        )
    }
    
    func editType(_ type: TypeTransaction) {
        uiState = uiState.copy(
            typeInput: type,
            expandedCategory: nil
        )
    }
    
    func editExpandedCategory(_ category: Category) {
        let d = category == uiState.selectedCategory ? nil : category
        uiState = uiState.copy(
            expandedCategory: d
        )
    }
}
