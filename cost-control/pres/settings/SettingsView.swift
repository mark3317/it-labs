import SwiftUI

struct SettingsView<ViewModel: SettingsViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    
    @State private var isBiometricsEnabled: Bool
    @State private var isDarkModeEnabled: Bool
    @State private var selectedCurrencySymbol: String
    
    @State private var showCurrencyPicker: Bool = false
    @State private var showResetConfirmation: Bool = false
    @State private var showAppDescriptionAlert: Bool = false
    @State private var showPrivacyPolicyAlert: Bool = false
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.isBiometricsEnabled = viewModel.uiState.isBiometricsEnabled
        self.isDarkModeEnabled = viewModel.uiState.isDarkModeEnabled
        self.selectedCurrencySymbol = viewModel.uiState.selectedCurrencySymbol
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Общие")) {
                        Button(action: {
                            showCurrencyPicker.toggle()
                        }) {
                            HStack {
                                Text("Валюта")
                                Spacer()
                                Text(String(selectedCurrencySymbol))
                                    .foregroundColor(.gray)
                            }
                        }
                        .foregroundColor(.primary)
                        .actionSheet(isPresented: $showCurrencyPicker) {
                            ActionSheet(
                                title: Text("Выберите валюту"),
                                buttons: viewModel.uiState.currencySymbols.map { symbol in
                                        .default(Text(symbol)) {
                                            viewModel.editCurrencySymbol(symbol)
                                        }
                                }
                            )
                        }
                        
                        Button(action: {
                            showResetConfirmation = true
                        }) {
                            Text("Сбросить данные")
                                .foregroundColor(.red)
                        }
                        .alert(isPresented: $showResetConfirmation) {
                            Alert(
                                title: Text("Подтвердите сброс"),
                                message: Text("Вы уверены, что хотите сбросить все данные приложения? Это действие нельзя отменить."),
                                primaryButton: .destructive(Text("Сбросить")) {
                                    withAnimation {
                                        viewModel.resetSettings()
                                    }
                                },
                                secondaryButton: .cancel(Text("Отмена"))
                            )
                        }
                    }
                    
                    Section(header: Text("Системные настройки")) {
                        NavigationLink(destination: NotificationsView(viewModel: viewModel.notificationsViewModel)) {
                            HStack {
                                Image(systemName: "bell.fill")
                                    .foregroundColor(.blue)
                                Text("Уведомления")
                            }
                        }
                        Toggle(isOn: $isBiometricsEnabled) {
                            HStack {
                                Image(systemName: "faceid")
                                    .foregroundColor(.green)
                                Text("Face ID / Touch ID")
                            }
                        }
                        .onChange(of: isBiometricsEnabled) {
                            viewModel.editBiometricsEnabled(isBiometricsEnabled)
                        }
                        Toggle(isOn: $isDarkModeEnabled) {
                            HStack {
                                Image(systemName: "moon.fill")
                                    .foregroundColor(.yellow)
                                Text("Темная тема")
                            }
                        }
                        .onChange(of: isDarkModeEnabled) {
                            withAnimation {
                                viewModel.editDarkModeEnabled(isDarkModeEnabled)
                            }
                        }
                    }
                    
                    Section(header: Text("Конфиденциальность")) {
                        Button(action: {
                            showAppDescriptionAlert = true
                        }) {
                            HStack {
                                Image(systemName: "info.circle.fill")
                                    .foregroundStyle(.gray)
                                Text("О приложении")
                            }
                        }
                        .foregroundColor(.primary)
                        .alert(isPresented: $showAppDescriptionAlert) {
                            Alert(
                                title: Text("О приложении"),
                                message: Text("Это приложение позволяет отслеживать ваши доходы и расходы, а также управлять бюджетом. Вы можете добавлять операции, создавать категории и получать уведомления."),
                                dismissButton: .default(Text("Ок"))
                            )
                        }
                        
                        Button(action: {
                            showPrivacyPolicyAlert = true
                        }) {
                            HStack {
                                Image(systemName: "lock.shield.fill")
                                    .foregroundColor(.green)
                                Text("Политика конфиденциальности")
                            }
                        }
                        .foregroundColor(.primary)
                        .alert(isPresented: $showPrivacyPolicyAlert) {
                            Alert(
                                title: Text("Политика конфиденциальности"),
                                message: Text("Мы ценим вашу конфиденциальность и не передаем ваши данные третьим лицам. Все данные хранятся локально на вашем устройстве."),
                                dismissButton: .default(Text("Ок"))
                            )
                        }
                    }
                }
            }
            .navigationBarTitle("Настройки", displayMode: .inline)
        }
        .colorScheme(viewModel.uiState.isDarkModeEnabled ? .dark : .light)
        .onChange(of: viewModel.uiState) {
            withAnimation {
                isBiometricsEnabled = viewModel.uiState.isBiometricsEnabled
                isDarkModeEnabled = viewModel.uiState.isDarkModeEnabled
                selectedCurrencySymbol = viewModel.uiState.selectedCurrencySymbol
            }
        }
    }
}

#Preview {
    SettingsView(
        viewModel: SettingsProcessor(ops: CostControlOps(settingsRepo: SettingsRepo()))
    )
}
