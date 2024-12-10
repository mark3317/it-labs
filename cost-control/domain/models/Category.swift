import Foundation

struct Category: Equatable, Identifiable {
    let id = UUID()
    let name: String
    let colorHex: String
    let type: TypeTransaction
    let icon: String
}
