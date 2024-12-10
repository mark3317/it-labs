import SwiftUI

struct CategoriesView<ViewModel>: View where ViewModel: CategoriesViewModel {
    @ObservedObject var viewModel: ViewModel
    @State private var typeInput: TypeTransaction
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.typeInput = viewModel.uiState.typeInput
    }
    
    var filteredCategories: [Category] {
        if let expandedCategory = viewModel.uiState.expandedCategory {
            return [expandedCategory]
        } else {
            return viewModel.uiState.categories.filter { $0.type == viewModel.uiState.typeInput }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Тип", selection: $typeInput) {
                    ForEach(TypeTransaction.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: typeInput) {
                    viewModel.editType(typeInput)
                }
                .padding()
                
                ScrollView {
                    VStack {
                        
                        let totalAmount = viewModel.uiState.transactions
                            .filter {
                                if ($0.category != nil && viewModel.uiState.expandedCategory != nil) {
                                    return $0.category == viewModel.uiState.expandedCategory
                                } else {
                                    return $0.type == viewModel.uiState.typeInput
                                }
                            }
                            .reduce(0) { $0 + $1.amount }
                        
                        Text("Сумма: \(totalAmount, specifier: "%.2f") ₽")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                            .padding()
                        
                        GeometryReader { geometry in
                            HStack(spacing: 0) {
                                ForEach(filteredCategories) { category in
                                    let categoryAmount = viewModel.uiState.transactions
                                        .filter { $0.type == viewModel.uiState.typeInput }
                                        .filter { $0.category == category }
                                        .reduce(0) { $0 + $1.amount }
                                    let width = geometry.size.width * (categoryAmount / totalAmount)
                                    ZStack {
                                        Rectangle()
                                            .fill(Color(hex: category.colorHex))
                                            .frame(width: width)
                                        Text("\(Int((categoryAmount / totalAmount) * 100))%")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .frame(width: width, alignment: .center)
                                    }
                                }
                            }
                        }
                        .frame(height: 25)
                        .cornerRadius(15)
                        .padding()
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.uiState.categories.filter { $0.type == viewModel.uiState.typeInput }) { category in
                                    HStack {
                                        Image(systemName: category.icon)
                                            .foregroundColor(Color(hex: category.colorHex))
                                            .padding(4)
                                            .clipShape(Circle())
                                        VStack(alignment: .leading) {
                                            Text(category.name)
                                                .font(.caption)
                                                .lineLimit(1)
                                            let categoryAmount = viewModel.uiState.transactions
                                                .filter { $0.type == typeInput && $0.category == category }
                                                .reduce(0) { $0 + $1.amount }
                                            Text("\(categoryAmount, specifier: "%.2f") ₽")
                                                .font(.caption2)
                                        }
                                    }
                                    .frame(height: 26)
                                    .padding(8)
                                    .background(Color(hex: category.colorHex).opacity(0.2))
                                    .cornerRadius(30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(viewModel.uiState.expandedCategory == category ? Color(hex: category.colorHex) : Color.clear, lineWidth: 2)
                                    )
                                    .onTapGesture {
                                        withAnimation {
                                            viewModel.editExpandedCategory(category)
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                        
                        TransactionListView(title: "Операции по категориям", transactions: viewModel.uiState.transactions.filter { transaction in
                            filteredCategories.contains { $0 == transaction.category }
                        })
                    }
                }
            }
            .navigationBarTitle("Категории")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: NavigationLink(
                    destination: AddCategoryView(viewModel: AddCategoryProcessor())
                ) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
            )
        }
    }
}

#Preview {
    CategoriesView(viewModel: CategoriesProcessor())
}
