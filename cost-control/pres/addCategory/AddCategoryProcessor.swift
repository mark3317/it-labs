import SwiftUI

class AddCategoryProcessor: AddCategoryViewModel {
    @ObservedObject private var ops: CostControlOps
    @Published private(set) var uiState: AddCategoryUIState
    
    init(ops: CostControlOps) {
        self.ops = ops
        uiState = .init(
            name: "",
            color: Category.colors[0],
            type: TypeTransaction.expense,
            icon: Category.icons[0]
        )
    }
    
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
