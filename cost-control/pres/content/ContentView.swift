import SwiftUI

struct ContentView<ViewModel: ContentViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    
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
        .colorScheme(viewModel.uiState.darkMode ? .dark : .light)
    }
}

#Preview {
    ContentView(
        viewModel: ContentProcessor(ops: CostControlOps(
            settingsRepo: SettingsRepo(),
            storageRepo: StorageRepo()
        ))
    )
}
