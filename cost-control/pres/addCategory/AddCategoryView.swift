import SwiftUI

struct AddCategoryView<ViewModel>: View where ViewModel: AddCategoryViewModel {
    @ObservedObject var viewModel: ViewModel
    @State private var nameInput: String = ""
    @State private var typeInput: TypeTransaction = .expense
    @State private var selectedIcon: String = "star"
    @State private var selectedColor: Color = .blue
    
    private enum Field: Int, CaseIterable {
        case name
    }
    @FocusState private var focusedField: Field?
    
    private let availableIcons = [
        "star", "dollarsign.circle", "cart", "house", "gift",
        "gamecontroller","book", "car", "bag", "bicycle",
        "camera", "music.note", "wrench", "briefcase", "creditcard",
        "chart.bar", "tv", "laptopcomputer", "tshirt", "film",
        "umbrella", "flame", "drop", "pawprint", "stethoscope"
    ]
    
    private let availableColors: [Color] = [
        .red, .blue, .green, .yellow, .orange, .pink, .purple, .teal, .gray, .brown, .indigo, .cyan, .mint, .black
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Название категории")) {
                    TextField("Введите название категории", text: $nameInput)
                        .focused($focusedField, equals: Field.name)
                        .onChange(of: nameInput) {
                            viewModel.editName(nameInput)
                            nameInput = viewModel.uiState.name
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
                        ForEach(availableIcons, id: \.self) { icon in
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
                                selectedIcon = viewModel.uiState.icon
                            }
                        }
                    }
                }
                
                Section(header: Text("Цвет")) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))], spacing: 16) {
                        ForEach(availableColors, id: \.self) { color in
                            Circle()
                                .fill(color)
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: selectedColor == color ? 3 : 0)
                                )
                                .onTapGesture {
                                    viewModel.editColor(color)
                                    selectedColor = viewModel.uiState.color
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
    }
}

#Preview {
    AddCategoryView(viewModel: AddCategoryProcessor())
}
