import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView(viewModel: HomeProcessor())
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Главная")
                }
            CategoriesView(viewModel: CategoriesProcessor())
                .tabItem {
                    Image(systemName: "list.bullet.rectangle.fill")
                    Text("Категории")
                }
            SettingsView(viewModel: SettingsProcessor())
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Настройки")
                }
        }
    }
}

#Preview {
    ContentView()
}
