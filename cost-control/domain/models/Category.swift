import Foundation
import SwiftUI

struct Category: Equatable, Identifiable {
    let id: UUID
    let name: String
    let colorHex: String
    let type: TransactionType
    let icon: String
    
    init(name: String, colorHex: String, type: TransactionType, icon: String) {
        self.id = UUID()
        self.name = name
        self.colorHex = colorHex
        self.type = type
        self.icon = icon
    }
}

extension Category {
    static let colors: [Color] = [
        .blue, .red, .green, .yellow, .orange, .pink,
        .purple, .teal, .brown, .indigo, .cyan, .mint
    ]
    static let icons = [
        "star", "dollarsign.circle", "cart", "house", "gift",
        "gamecontroller","book", "car", "bag", "bicycle",
        "camera", "music.note", "wrench", "briefcase", "creditcard",
        "chart.bar", "tv", "fork.knife", "tshirt", "film",
        "umbrella", "flame", "drop", "pawprint", "stethoscope"
    ]
}
