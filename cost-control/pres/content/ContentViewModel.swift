import Combine

protocol ContentViewModel : ObservableObject {
    var uiState: ContentUIState { get }
    var homeViewModel: HomeProcessor { get }
    var categoriesViewModel: CategoriesProcessor { get }
    var settingsViewModel: SettingsProcessor { get }
}
