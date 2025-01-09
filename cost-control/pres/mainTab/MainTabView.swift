import SwiftUI

struct MainTabView: View {
    @ObservedObject var viewModel: MainTabViewModel
    
    var body: some View {
        TabView {
            HomeView(viewModel: viewModel.homeVM)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Главная")
                }
            CategoriesView(viewModel: viewModel.categoriesVM)
                .tabItem {
                    Image(systemName: "list.bullet.rectangle.fill")
                    Text("Категории")
                }
            SettingsView(viewModel: viewModel.settingsVM)
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
