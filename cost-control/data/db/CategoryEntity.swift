import Foundation
import SwiftData

@Model
class CategoryEntity {
    @Attribute(.unique)
    var id: UUID
    var name: String
    var colorHex: String
    var type: String
    var icon: String
    @Relationship(deleteRule: .nullify, inverse: \TransactionEntity.category)
    var transactions: [TransactionEntity]
    
    init(id: UUID = UUID(), name: String, colorHex: String, type: TransactionType, icon: String) {
        self.id = id
        self.name = name
        self.colorHex = colorHex
        self.type = type.rawValue
        self.icon = icon
        self.transactions = []
    }
}
