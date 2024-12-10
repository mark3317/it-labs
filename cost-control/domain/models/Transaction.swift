import Foundation

struct Transaction: Equatable, Identifiable {
    let id = UUID()
    let amount: Double
    let description: String
    let date: Date
    let type: TypeTransaction
    let category: Category?
}
