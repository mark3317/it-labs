import SwiftUI

struct AddTransactionView: View {
    @ObservedObject var viewModel: AddTransactionViewModel
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    private enum Field: Int, CaseIterable {
        case amount, description
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Сумма")) {
                    TextField("Введите сумму операции", value: Binding(
                        get: { viewModel.uiState.amount },
                        set: { viewModel.editAmount($0) }
                    ), format: .number)
                    .keyboardType(.decimalPad)
                    .focused($focusedField, equals: Field.amount)
                    .overlay(
                        HStack {
                            Spacer()
                            Text(viewModel.uiState.currency)
                                .foregroundColor(.gray)
                        }
                    )
                }
                
                Section(header: Text("Описание")) {
                    TextField("Введите описание", text: Binding(
                        get: { viewModel.uiState.description },
                        set: { viewModel.editDescription($0) }
                    ))
                    .focused($focusedField, equals: Field.description)
                }
                
                Section(header: Text("Дата операции")) {
                    DatePicker("Выберите дату", selection: Binding(
                        get: { viewModel.uiState.date },
                        set: { viewModel.editDate($0) }
                    ), displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .environment(\.locale, Locale(identifier: "ru_RU"))
                }
                
                Section(header: Text("Тип операции")) {
                    Picker("Тип", selection: Binding(
                        get: { viewModel.uiState.type },
                        set: { viewModel.editType($0) }
                    )) {
                        ForEach(TransactionType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                let categoriesOfSelectedType = viewModel.uiState.categories.filter {
                    $0.type == viewModel.uiState.type
                }
                if (!categoriesOfSelectedType.isEmpty) {
                    Section(header: Text("Категория")) {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 16) {
                            ForEach(categoriesOfSelectedType) { category in
                                VStack {
                                    ZStack {
                                        Circle()
                                            .fill(viewModel.uiState.selectedCategory == category ? Color(hex: category.colorHex) : Color.gray.opacity(0.3))
                                            .frame(width: 60, height: 60)
                                        Image(systemName: category.icon)
                                            .foregroundColor(.white)
                                            .font(.system(size: 24))
                                    }
                                    Text(category.name)
                                        .font(.caption)
                                        .foregroundColor(.primary)
                                }
                                .onTapGesture {
                                    viewModel.editCategory(category)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Добавление операции", displayMode: .inline)
            .toolbar(.hidden, for: .tabBar)
            .toolbarBackground(Color.clear, for: .bottomBar)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Готово") {
                        focusedField = nil
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        viewModel.onClickAddTransaction()
                        dismiss()
                    }) {
                        Text("Добавить операцию")
                            .padding()
                            .background(viewModel.uiState.amount.isZero || viewModel.uiState.description.isEmpty ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                            .font(.headline)
                    }
                    .padding()
                    .disabled(viewModel.uiState.amount.isZero || viewModel.uiState.description.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddTransactionView(
        viewModel: AddTransactionViewModel(ops: CostControlOps(
            settingsRepo: SettingsRepo(),
            storageRepo: StorageRepo(),
            authRepo: AuthRepo()
        ))
    )
}
