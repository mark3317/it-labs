import Foundation

struct Transaction: Equatable, Identifiable {
    let id: UUID
    let amount: Double
    let description: String
    let date: Date
    let type: TransactionType
    let category: Category?
    
    init(amount: Double, description: String, date: Date, type: TransactionType, category: Category?) {
        self.id = UUID()
        self.amount = amount
        self.description = description
        self.date = date
        self.type = type
        self.category = category
    }
}
