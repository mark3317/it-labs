import Foundation

struct Transaction: Equatable {
    let amount: Double
    let description: String
    let date: Date
    let type: TypeTransaction
    let category: CategoryTransaction?
}
