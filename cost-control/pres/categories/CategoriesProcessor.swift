import SwiftUI
import Foundation

class CategoriesProcessor: CategoriesViewModel {
    @ObservedObject private var ops: CostControlOps
    @Published private(set) var uiState: CategoriesUIState
    private(set) var addCategoryViewModel: AddCategoryProcessor
    
    init(ops: CostControlOps) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let foodCategory = Category(name: "Еда", colorHex: Color.red.toHex(), type: .expense, icon: "fork.knife")
        let salaryCategory = Category(name: "Зарплата", colorHex: Color.green.toHex(), type: .income, icon: "dollarsign.circle")
        let entertainmentCategory = Category(name: "Развлечения", colorHex: Color.blue.toHex(), type: .expense, icon: "gamecontroller")
        let investmentCategory = Category(name: "Инвестиции", colorHex: Color.purple.toHex(), type: .income, icon: "chart.bar")
        
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
        self.ops = ops
        addCategoryViewModel = AddCategoryProcessor(ops: ops)
        uiState = CategoriesUIState(
            currency: ops.settings.currency,
            type: .expense,
            selectedCategory: nil,
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
