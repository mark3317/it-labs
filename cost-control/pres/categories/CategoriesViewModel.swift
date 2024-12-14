import SwiftUI

protocol CategoriesViewModel : ObservableObject {
    var uiState: CategoriesUIState { get }
    var addCategoryViewModel: AddCategoryProcessor { get }
    func editType(_ type: TypeTransaction)
    func editExpandedCategory(_ category: Category)
}
