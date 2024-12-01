import Combine

protocol HomeViewModel : ObservableObject {
    var uiState: HomeUIState { get }
    func loadData()
}
