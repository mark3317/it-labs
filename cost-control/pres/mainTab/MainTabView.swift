import SwiftUI

struct MainTabView: View {
    @ObservedObject var viewModel: MainTabViewModel
    
    var body: some View {
        TabView {
            HomeView(viewModel: viewModel.homeViewModel)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Главная")
                }
            CategoriesView(viewModel: viewModel.categoriesViewModel)
                .tabItem {
                    Image(systemName: "list.bullet.rectangle.fill")
                    Text("Категории")
                }
            SettingsView(viewModel: viewModel.settingsViewModel)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Настройки")
                }
        }
    }
}

#Preview {
    MainTabView(
        viewModel: MainTabViewModel(ops: CostControlOps(
            settingsRepo: SettingsRepo(),
            storageRepo: StorageRepo(),
            authRepo: AuthRepo()
        ))
    )
}
