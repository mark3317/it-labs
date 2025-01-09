import SwiftUI

struct CategoriesView: View {
    @ObservedObject var viewModel: CategoriesViewModel
    
    var filteredCategories: [Category] {
        if let selectedCategory = viewModel.uiState.selectedCategory {
            return [selectedCategory]
        } else {
            return viewModel.uiState.categories.filter { $0.type == viewModel.uiState.type }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Тип", selection: Binding(
                    get: { viewModel.uiState.type },
                    set: { viewModel.editType($0) }
                )) {
                    ForEach(TransactionType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                ScrollView {
                    VStack {
                        let totalAmount = viewModel.uiState.transactions
                            .filter {
                                if ($0.category != nil && viewModel.uiState.selectedCategory != nil) {
                                    return $0.category == viewModel.uiState.selectedCategory
                                } else {
                                    return $0.type == viewModel.uiState.type
                                }
                            }
                            .reduce(0) { $0 + $1.amount }
                        
                        Text("Сумма: \(totalAmount, specifier: "%.2f") \(viewModel.uiState.currency)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                            .padding()
                        
                        GeometryReader { geometry in
                            HStack(spacing: 0) {
                                ForEach(filteredCategories) { category in
                                    let categoryAmount = viewModel.uiState.transactions
                                        .filter { $0.type == viewModel.uiState.type }
                                        .filter { $0.category == category }
                                        .reduce(0) { $0 + $1.amount }
                                    if (categoryAmount > 0) {
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
                        }
                        .frame(height: 25)
                        .cornerRadius(15)
                        .padding()
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.uiState.categories.filter { $0.type == viewModel.uiState.type }) { category in
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
                                                .filter { $0.type == viewModel.uiState.type && $0.category == category }
                                                .reduce(0) { $0 + $1.amount }
                                            Text("\(categoryAmount, specifier: "%.2f") \(viewModel.uiState.currency)")
                                                .font(.caption2)
                                        }
                                    }
                                    .frame(height: 26)
                                    .padding(8)
                                    .background(Color(hex: category.colorHex).opacity(0.2))
                                    .cornerRadius(30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(viewModel.uiState.selectedCategory == category ? Color(hex: category.colorHex) : Color.clear, lineWidth: 2)
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
                        
                        TransactionListView(
                            title: "Операции по категориям",
                            transactions: viewModel.uiState.transactions.filter { transaction in
                                filteredCategories.contains { $0 == transaction.category }
                            },
                            currency: viewModel.uiState.currency)
                    }
                }
            }
            .navigationBarTitle("Категории")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: NavigationLink(
                    destination: AddCategoryView(viewModel: viewModel.addCategoryVM)
                ) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
            )
        }
    }
}

#Preview {
    CategoriesView(
        viewModel: CategoriesViewModel(ops: CostControlOps(
            settingsRepo: SettingsRepo(),
            storageRepo: StorageRepo(),
            authRepo: AuthRepo()
        ))
    )
}
