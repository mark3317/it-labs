import SwiftUI
import Foundation

class AddCategoryViewModel: AddCategoryActions, ObservableObject {
    @Published var uiState = AddCategoryUIState.initial
    
    func editName(_ name: String) {
        self.uiState = self.uiState.copy(name: name)
    }
    
    func editColor(_ color: Color) {
        self.uiState = self.uiState.copy(color: color)
    }
    
    func editType(_ type: TypeTransaction) {
        self.uiState = self.uiState.copy(type: type)
    }
    
    func editIcon(_ icon: String) {
        self.uiState = self.uiState.copy(icon: icon)
    }
    
    func onClickAddCategory() {
        
    }
}
