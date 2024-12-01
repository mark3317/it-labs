import SwiftUI

struct AddCategoryView<ViewModel>: View where ViewModel: AddCategoryViewModel {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            Text("Категории")
            .navigationBarTitle("Добавление категории")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddCategoryView(viewModel: AddCategoryProcessor())
}
