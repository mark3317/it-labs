import SwiftUI

protocol AddCategoryViewModel : ObservableObject {
    var uiState: AddCategoryUIState { get }
    func editName(_ name: String)
    func editColor(_ color: Color)
    func editType(_ type: TransactionType)
    func editIcon(_ icon: String)
    func onClickAddCategory()
}
