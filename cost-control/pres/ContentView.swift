import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView(viewModel: HomeProcessor())
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Главная")
                }
        }
    }
}

#Preview {
    ContentView()
}
