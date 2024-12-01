import Foundation

struct TransactionEntity: Identifiable {
    let id = UUID()
    let amount: Double
    let description: String
    let date: Date
    let type: TypeTransaction
}
