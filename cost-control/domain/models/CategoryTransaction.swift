import SwiftUI
import Foundation

struct CategoryTransaction: Equatable, Identifiable {
    let name: String
    let color: Color
    let type: TypeTransaction
    let icon: String
    
    var id: String { self.name }
}
