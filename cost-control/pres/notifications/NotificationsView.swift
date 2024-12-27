import SwiftUI

struct NotificationsView<ViewModel: NotificationsViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                // Секция напоминаний
                Section(
                    header: Text("Напоминания"),
                    footer: Text("Если в течение дня не было добавлений новых операций, в 8 вечера будет отправлено уведомление")
                ) {
                    Toggle(isOn: Binding(
                        get: { viewModel.uiState.isReminderEnabled },
                        set: { viewModel.editReminderEnabled($0) }
                    )) {
                        Text("Учет операций")
                    }
                }
                
                // Секция уведомлений о превышении лимита
                Section(
                    header: Text("Предупреждения"),
                    footer: Text("Уведомления о превышении лимита по сумме за указанный период")
                ) {
                    Toggle(isOn: Binding(
                        get: { viewModel.uiState.isLimitExceededNotificationEnabled },
                        set: { newValue in withAnimation {
                            viewModel.editLimitExceededNotificationEnabled(newValue)
                        }}
                    )) {
                        Text("Превышение лимита")
                    }
                    
                    if viewModel.uiState.isLimitExceededNotificationEnabled {
                        VStack {
                            HStack {
                                Text("Сумма лимита:")
                                Spacer()
                                Text("\(viewModel.uiState.limitAmount, specifier: "%.2f") \(viewModel.uiState.currency)")
                            }
                            Slider(value: Binding(
                                get: { viewModel.uiState.limitAmount },
                                set: { viewModel.editLimitAmount($0) }
                            ), in: 0...10000, step: 100)
                            .accentColor(.blue)
                            HStack {
                                Text("Период:")
                                Spacer()
                                Picker("Выберите период", selection: Binding(
                                    get: { viewModel.uiState.selectedPeriod },
                                    set: { viewModel.editSelectedPeriod($0) }
                                )) {
                                    ForEach(NotificationPeriod.allCases) { period in
                                        Text(period.rawValue).tag(period)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                        }
                    }
                }
                
                // Секция случайных отчетов
                Section(
                    header: Text("Отчеты"),
                    footer: Text("В конце каждой недели будет отправлен случайный короткий отчет по вашим операциям")
                ) {
                    Toggle(isOn: Binding(
                        get: { viewModel.uiState.isRandomReportEnabled },
                        set: { viewModel.editRandomReportEnabled($0) }
                    )) {
                        Text("Случайные отчеты")
                    }
                }
            }
            .navigationBarTitle("Уведомления", displayMode: .inline)
            .toolbar(.hidden, for: .tabBar)
        }
    }
}

#Preview {
    NotificationsView(
        viewModel: NotificationsProcessor(ops: CostControlOps(
            settingsRepo: SettingsRepo(),
            storageRepo: StorageRepo(),
            authRepo: AuthRepo()
        ))
    )
}
