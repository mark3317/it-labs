import SwiftUI

class AddCategoryViewModel: ObservableObject {
    @ObservedObject private var ops: CostControlOps
    @Published private(set) var uiState: AddCategoryUIState
    
    init(ops: CostControlOps) {
        self.ops = ops
        uiState = .init(
            name: "",
            color: Category.colors[0],
            type: TransactionType.expense,
            icon: Category.icons[0],
            isSaved: false
        )
    }
    
    func editName(_ name: String) {
        uiState = uiState.copy(name: name)
    }
    
    func editColor(_ color: Color) {
        uiState = uiState.copy(color: color)
    }
    
    func editType(_ type: TransactionType) {
        uiState = uiState.copy(type: type)
    }
    
    func editIcon(_ icon: String) {
        uiState = uiState.copy(icon: icon)
    }
    
    func onClickAddCategory() {
        Task {
            await ops.saveCategory(category: Category(
                name: uiState.name,
                colorHex: uiState.color.toHex(),
                type: uiState.type,
                icon: uiState.icon
            ))
        }
        uiState = uiState.copy(isSaved: true)
    }
}
