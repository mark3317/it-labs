import Foundation
import SwiftData

@Model
class TransactionEntity {
    @Attribute(.unique)
    var id: UUID
    var amount: Double
    var desc: String
    var date: Date
    var type: String
    var category: CategoryEntity?
    
    init(id: UUID = UUID(), amount: Double, desc: String, date: Date, type: TransactionType, category: CategoryEntity? = nil) {
        self.id = id
        self.amount = amount
        self.desc = desc
        self.date = date
        self.type = type.rawValue
        self.category = category
    }
}
