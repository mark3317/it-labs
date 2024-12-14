import Foundation

extension Category {
    init(from entity: CategoryEntity) {
        self.id = entity.id
        self.name = entity.name
        self.colorHex = entity.colorHex
        self.type = TransactionType(rawValue: entity.type) ?? .expense
        self.icon = entity.icon
    }
}

extension CategoryEntity {
    convenience init(from category: Category) {
        self.init(
            id: category.id,
            name: category.name,
            colorHex: category.colorHex,
            type: category.type,
            icon: category.icon
        )
    }
}

extension Transaction {
    init(from entity: TransactionEntity) {
        self.id = entity.id
        self.amount = entity.amount
        self.description = entity.desc
        self.date = entity.date
        self.type = TransactionType(rawValue: entity.type) ?? .expense
        self.category = entity.category.map(Category.init)
    }
}

extension TransactionEntity {
    convenience init(from transaction: Transaction) {
        self.init(
            id: transaction.id,
            amount: transaction.amount,
            desc: transaction.description,
            date: transaction.date,
            type: transaction.type,
            category: transaction.category.map(CategoryEntity.init)
        )
    }
}

