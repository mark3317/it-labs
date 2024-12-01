import SwiftUI

struct AddCategoryView: View {
    @StateObject private var viewModel = AddCategoryViewModel()
    
    var body: some View {
        NavigationStack {
            Text("Категории")
            .navigationBarTitle("Добавление категории")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddCategoryView()
}
