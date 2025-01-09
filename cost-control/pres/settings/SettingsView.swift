import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Общие")) {
                        Button(action: {
                            viewModel.editCurrencyPickerShowed(true)
                        }) {
                            HStack {
                                Text("Валюта")
                                Spacer()
                                Text(String(viewModel.uiState.currency))
                                    .foregroundColor(.gray)
                            }
                        }
                        .foregroundColor(.primary)
                        .actionSheet(isPresented: Binding(
                            get: { viewModel.uiState.isCurrencyPickerShowed },
                            set: { viewModel.editCurrencyPickerShowed($0) }
                        )) {
                            ActionSheet(
                                title: Text("Выберите валюту"),
                                buttons: AppSettings.currencySymbols.map { symbol in
                                        .default(Text(symbol)) {
                                            viewModel.editCurrencySymbol(symbol)
                                        }
                                }
                            )
                        }
                        
                        Button(action: {
                            viewModel.editResetConfirmationShowed(true)
                        }) {
                            Text("Сбросить данные")
                                .foregroundColor(.red)
                        }
                        .alert(isPresented: Binding(
                            get: { viewModel.uiState.isResetConfirmationShowed },
                            set: { viewModel.editResetConfirmationShowed($0) }
                        )) {
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
                        NavigationLink(destination: NotificationsView(viewModel: viewModel.notificationsVM)) {
                            HStack {
                                Image(systemName: "bell.fill")
                                    .foregroundColor(.blue)
                                Text("Уведомления")
                            }
                        }
                        Toggle(isOn: Binding(
                            get: { viewModel.uiState.isBiometricsEnabled },
                            set: { viewModel.editBiometricsEnabled($0) }
                        )) {
                            HStack {
                                Image(systemName: "faceid")
                                    .foregroundColor(.green)
                                Text("Face ID / Touch ID")
                            }
                        }
                        Toggle(isOn: Binding(
                            get: { viewModel.uiState.isDarkModeEnabled },
                            set: { newValue in withAnimation {
                                viewModel.editDarkModeEnabled(newValue)
                            }}
                        )) {
                            HStack {
                                Image(systemName: "moon.fill")
                                    .foregroundColor(.yellow)
                                Text("Темная тема")
                            }
                        }
                    }
                    
                    Section(header: Text("Конфиденциальность")) {
                        NavigationLink(destination: OnboardingView(viewModel: viewModel.onboardingVM)) {
                            HStack {
                                Image(systemName: "info.circle.fill")
                                    .foregroundStyle(.gray)
                                Text("О приложении")
                            }
                        }
                        
                        NavigationLink(destination: PDFKitView(url: viewModel.uiState.urlPrivacyPolicy)) {
                            HStack {
                                Image(systemName: "lock.shield.fill")
                                    .foregroundColor(.green)
                                Text("Политика конфиденциальности")
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Настройки", displayMode: .inline)
        }
        .colorScheme(viewModel.uiState.isDarkModeEnabled ? .dark : .light)
    }
}

#Preview {
    SettingsView(
        viewModel: SettingsViewModel(ops: CostControlOps(
            settingsRepo: SettingsRepo(),
            storageRepo: StorageRepo(),
            authRepo: AuthRepo()
        ))
    )
}
