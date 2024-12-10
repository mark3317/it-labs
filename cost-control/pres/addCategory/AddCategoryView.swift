import SwiftUI

struct AddCategoryView<ViewModel>: View where ViewModel: AddCategoryViewModel {
    @ObservedObject var viewModel: ViewModel
    @State private var nameInput: String
    @State private var typeInput: TypeTransaction
    @State private var selectedIcon: String
    @State private var selectedColor: Color
    
    private enum Field: Int, CaseIterable {
        case name
    }
    @FocusState private var focusedField: Field?
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.nameInput = viewModel.uiState.name
        self.typeInput = viewModel.uiState.type
        self.selectedIcon = viewModel.uiState.icon
        self.selectedColor = viewModel.uiState.color
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Название категории")) {
                    TextField("Введите название категории", text: $nameInput)
                        .focused($focusedField, equals: Field.name)
                        .onChange(of: nameInput) {
                            viewModel.editName(nameInput)
                        }
                }
                
                Section(header: Text("Тип категории")) {
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
                
                Section(header: Text("Иконка")) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))], spacing: 16) {
                        ForEach(viewModel.uiState.availableIcons, id: \.self) { icon in
                            ZStack {
                                Circle()
                                    .fill(selectedIcon == icon ? selectedColor : Color.gray.opacity(0.3))
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
                        ForEach(viewModel.uiState.availableColors, id: \.self) { color in
                            Circle()
                                .fill(color)
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: selectedColor == color ? 3 : 0)
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
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                            .font(.headline)
                    }
                }
            }
        }
        .onChange(of: viewModel.uiState) {
            nameInput = viewModel.uiState.name
            typeInput = viewModel.uiState.type
            selectedIcon = viewModel.uiState.icon
            selectedColor = viewModel.uiState.color
        }
    }
}

#Preview {
    AddCategoryView(viewModel: AddCategoryProcessor())
}
