import Foundation
import SwiftUI

struct AddCategoryUIState : Equatable {
    let name: String
    let color: Color
    let type: TypeTransaction
    let icon: String
    
    let availableColors: [Color] = [
        .blue, .red, .green, .yellow, .orange, .pink,
        .purple, .teal, .gray, .brown, .indigo, .cyan,
        .mint, .black
    ]
    let availableIcons = [
        "star", "dollarsign.circle", "cart", "house", "gift",
        "gamecontroller","book", "car", "bag", "bicycle",
        "camera", "music.note", "wrench", "briefcase", "creditcard",
        "chart.bar", "tv", "laptopcomputer", "tshirt", "film",
        "umbrella", "flame", "drop", "pawprint", "stethoscope"
    ]
}

extension AddCategoryUIState {
    static let initial = AddCategoryUIState(
        name: "",
        color: Color.blue,
        type: TypeTransaction.expense,
        icon: "star"
    )
}

extension AddCategoryUIState {
    func copy(
        name: String? = nil,
        color: Color? = nil,
        type: TypeTransaction? = nil,
        icon: String? = nil
    ) -> AddCategoryUIState {
        let newUiState = AddCategoryUIState(
            name: name ?? self.name,
            color: color ?? self.color,
            type: type ?? self.type,
            icon: icon ?? self.icon
        )
        print(newUiState)
        return newUiState
    }
}
