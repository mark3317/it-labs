import Combine

protocol HomeViewModel : ObservableObject {
    var uiState: HomeUIState { get }
    var addTransactionViewModel: AddTransactionProcessor { get }
}
