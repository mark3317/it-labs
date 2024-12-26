import SwiftUI

struct AddCategoryView<ViewModel: AddCategoryViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    
    @Environment(\.presentationMode) var presentationMode
    @FocusState private var focusedField: Field?
    private enum Field: Int, CaseIterable {
        case name
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Название категории")) {
                    TextField("Введите название категории", text: Binding(
                        get: { viewModel.uiState.name },
                        set: { viewModel.editName($0) }
                    ))
                    .focused($focusedField, equals: Field.name)
                }

                Section(header: Text("Тип категории")) {
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

                Section(header: Text("Иконка")) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))], spacing: 16) {
                        ForEach(Category.icons, id: \.self) { icon in
                            ZStack {
                                Circle()
                                    .fill(viewModel.uiState.icon == icon ? viewModel.uiState.color : Color.gray.opacity(0.3))
                                    .frame(width: 50, height: 50)
                                Image(systemName: icon)
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                            }
                            .onTapGesture {
                                viewModel.editIcon(icon)
                            }
                        }
                    }
                }

                Section(header: Text("Цвет")) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))], spacing: 16) {
                        ForEach(Category.colors, id: \.self) { color in
                            Circle()
                                .fill(color)
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: viewModel.uiState.color == color ? 3 : 0)
                                )
                                .onTapGesture {
                                    viewModel.editColor(color)
                                }
                        }
                    }
                }
            }
            .navigationBarTitle("Новая категория", displayMode: .inline)
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
                        viewModel.onClickAddCategory()
                    }) {
                        Text("Добавить категорию")
                            .padding()
                            .background(viewModel.uiState.name.isEmpty ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                            .font(.headline)
                    }
                    .padding()
                    .disabled(viewModel.uiState.name.isEmpty)
                }
            }
            .onChange(of: viewModel.uiState.isSaved) {
                if viewModel.uiState.isSaved {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

#Preview {
    AddCategoryView(
        viewModel: AddCategoryProcessor(ops: CostControlOps(
            settingsRepo: SettingsRepo(),
            storageRepo: StorageRepo()
        ))
    )
}
