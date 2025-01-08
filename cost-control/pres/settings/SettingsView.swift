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
                        NavigationLink(destination: NotificationsView(viewModel: viewModel.notificationsViewModel)) {
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
                        Button(action: {
                            viewModel.editAppDescriptionAlertShowed(true)
                        }) {
                            HStack {
                                Image(systemName: "info.circle.fill")
                                    .foregroundStyle(.gray)
                                Text("О приложении")
                            }
                        }
                        .foregroundColor(.primary)
                        .alert(isPresented: Binding(
                            get: { viewModel.uiState.isAppDescriptionAlertShowed },
                            set: { viewModel.editAppDescriptionAlertShowed($0) }
                        )) {
                            Alert(
                                title: Text("О приложении"),
                                message: Text("Это приложение позволяет отслеживать ваши доходы и расходы, а также управлять бюджетом. Вы можете добавлять операции, создавать категории и получать уведомления."),
                                dismissButton: .default(Text("Ок"))
                            )
                        }
                        
                        Button(action: {
                            viewModel.editPrivacyPolicyAlertShowed(true)
                        }) {
                            HStack {
                                Image(systemName: "lock.shield.fill")
                                    .foregroundColor(.green)
                                Text("Политика конфиденциальности")
                            }
                        }
                        .foregroundColor(.primary)
                        .alert(isPresented: Binding(
                            get: { viewModel.uiState.isPrivacyPolicyAlertShowed },
                            set: { viewModel.editPrivacyPolicyAlertShowed($0) }
                        )) {
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
