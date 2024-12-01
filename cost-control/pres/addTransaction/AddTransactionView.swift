import SwiftUI

struct AddTransactionView<ViewModel>: View where ViewModel: AddTransactionViewModel {
    @ObservedObject var viewModel: ViewModel
    @State private var amountInput: Double = 0
    @State private var descriptionInput: String = ""
    @State private var typeInput: TypeTransaction = .expense
    @State private var dateInput: Date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Сумма")) {
                    TextField("Введите сумму операции", value: $amountInput, format: .number)
                        .keyboardType(.decimalPad)
                        .onChange(of: self.amountInput) {
                            viewModel.editAmount(self.amountInput)
                            self.amountInput = viewModel.uiState.amount
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
                        .onChange(of: self.descriptionInput) {
                            viewModel.editDescription(self.descriptionInput)
                            self.descriptionInput = viewModel.uiState.description
                        }
                }
                
                Section(header: Text("Дата операции")) {
                    DatePicker("Выберите дату", selection: $dateInput, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .environment(\.locale, Locale(identifier: "ru_RU"))
                        .onChange(of: dateInput ) {
                            viewModel.editDate(self.dateInput)
                            self.dateInput = viewModel.uiState.date
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
                        viewModel.editType(self.typeInput)
                        self.typeInput = viewModel.uiState.type
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
                                        .fill(viewModel.uiState.category == category ? category.color : Color.gray.opacity(0.3))
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
                
                Section {
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
                }
                .listRowBackground(Color.clear)
            }
            .navigationBarTitle("Добавление операции", displayMode: .inline)
            .onAppear {
                self.amountInput = viewModel.uiState.amount
                self.descriptionInput = viewModel.uiState.description
                self.typeInput = viewModel.uiState.type
                self.dateInput = viewModel.uiState.date
            }
        }
    }
}

#Preview {
    AddTransactionView(viewModel: AddTransactionProcessor())
}
