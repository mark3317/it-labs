import Foundation
import SwiftUI

struct Category: Equatable, Identifiable {
    let id = UUID()
    let name: String
    let colorHex: String
    let type: TypeTransaction
    let icon: String
}

extension Category {
    static let colors: [Color] = [
        .blue, .red, .green, .yellow, .orange, .pink,
        .purple, .teal, .gray, .brown, .indigo, .cyan,
        .mint, .black
    ]
    static let icons = [
        "star", "dollarsign.circle", "cart", "house", "gift",
        "gamecontroller","book", "car", "bag", "bicycle",
        "camera", "music.note", "wrench", "briefcase", "creditcard",
        "chart.bar", "tv", "laptopcomputer", "tshirt", "film",
        "umbrella", "flame", "drop", "pawprint", "stethoscope"
    ]
}
