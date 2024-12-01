import Foundation

protocol AddTransactionViewModel : ObservableObject {
    var uiState: AddTransactionUIState { get }
    func editAmount(_ amount: Double)
    func editDescription(_ description: String)
    func editDate(_ date: Date)
    func editType(_ type: TypeTransaction)
    func editCategory(_ category: CategoryTransaction)
    func onClickAddTransaction()
}
