import SwiftUI

struct AddTransactionView<ViewModel>: View where ViewModel: AddTransactionViewModel {
    @ObservedObject var viewModel: ViewModel
    @State private var amountInput: Double
    @State private var descriptionInput: String
    @State private var typeInput: TypeTransaction
    @State private var dateInput: Date
    
    private enum Field: Int, CaseIterable {
        case amount, description
    }
    @FocusState private var focusedField: Field?
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.amountInput = viewModel.uiState.amount
        self.descriptionInput = viewModel.uiState.description
        self.typeInput = viewModel.uiState.type
        self.dateInput = viewModel.uiState.date
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Сумма")) {
                    TextField("Введите сумму операции", value: $amountInput, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: Field.amount)
                        .onChange(of: amountInput) {
                            viewModel.editAmount(amountInput)
                        }
                        .overlay(
                            HStack {
                                Spacer()
                                Text("₽")
                                    .foregroundColor(.gray)
                            }
                        )
                }
                
                Section(header: Text("Описание")) {
                    TextField("Введите описание", text: $descriptionInput)
                        .focused($focusedField, equals: Field.description)
                        .onChange(of: descriptionInput) {
                            viewModel.editDescription(descriptionInput)
                        }
                }
                
                Section(header: Text("Дата операции")) {
                    DatePicker("Выберите дату", selection: $dateInput, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .environment(\.locale, Locale(identifier: "ru_RU"))
                        .onChange(of: dateInput ) {
                            viewModel.editDate(dateInput)
                        }
                }
                
                Section(header: Text("Тип операции")) {
                    Picker("Тип", selection: $typeInput) {
                        ForEach(TypeTransaction.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: typeInput) {
                        viewModel.editType(typeInput)
                    }
                }
                
                Section(header: Text("Категория")) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 16) {
                        ForEach(
                            viewModel.uiState.categories.filter { $0.type == viewModel.uiState.type }
                        ) { category in
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
                    }) {
                        Text("Добавить операцию")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                            .font(.headline)
                    }
                    .padding()
                }
            }
        }
        .onChange(of: viewModel.uiState) {
            amountInput = viewModel.uiState.amount
            descriptionInput = viewModel.uiState.description
            typeInput = viewModel.uiState.type
            dateInput = viewModel.uiState.date
        }
    }
}

#Preview {
    AddTransactionView(viewModel: AddTransactionProcessor())
}
