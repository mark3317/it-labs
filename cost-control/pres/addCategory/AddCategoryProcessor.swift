import SwiftUI
import Foundation

class AddCategoryProcessor: AddCategoryViewModel {
    @Published var uiState = AddCategoryUIState.initial
    
    func editName(_ name: String) {
        uiState = uiState.copy(name: name)
    }
    
    func editColor(_ color: Color) {
        uiState = uiState.copy(color: color)
    }
    
    func editType(_ type: TypeTransaction) {
        uiState = uiState.copy(type: type)
    }
    
    func editIcon(_ icon: String) {
        uiState = uiState.copy(icon: icon)
    }
    
    func onClickAddCategory() {
        print("Add category \(uiState)")
    }
}
