import SwiftUI

protocol CategoriesViewModel : ObservableObject {
    var uiState: CategoriesUIState { get }
    func editType(_ type: TypeTransaction)
    func editExpandedCategory(_ category: Category)
}
