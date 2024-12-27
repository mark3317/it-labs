import Combine

protocol MainTabViewModel : ObservableObject {
    var homeViewModel: HomeProcessor { get }
    var categoriesViewModel: CategoriesProcessor { get }
    var settingsViewModel: SettingsProcessor { get }
}
