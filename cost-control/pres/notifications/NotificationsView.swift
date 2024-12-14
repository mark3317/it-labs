import SwiftUI

struct NotificationsView<ViewModel: NotificationsViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    
    @State private var isReminderEnabled: Bool
    @State private var isLimitExceededNotificationEnabled: Bool
    @State private var isRandomReportEnabled: Bool
    @State private var limitAmount: Double
    @State private var selectedPeriod: Period
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.isReminderEnabled = viewModel.uiState.isReminderEnabled
        self.isLimitExceededNotificationEnabled = viewModel.uiState.isLimitExceededNotificationEnabled
        self.isRandomReportEnabled = viewModel.uiState.isRandomReportEnabled
        self.limitAmount = viewModel.uiState.limitAmount
        self.selectedPeriod = viewModel.uiState.selectedPeriod
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // Секция напоминаний
                Section(
                    header: Text("Напоминания"),
                    footer: Text("Если в течение дня не было добавлений новых операций, в 8 вечера будет отправлено уведомление")
                ) {
                    Toggle(isOn: $isReminderEnabled) {
                        Text("Учет операций")
                    }
                    .onChange(of: isReminderEnabled) {
                        viewModel.editReminderEnabled(isReminderEnabled)
                    }
                }
                
                // Секция уведомлений о превышении лимита
                Section(
                    header: Text("Предупреждения"),
                    footer: Text("Уведомления о превышении лимита по сумме за указанный период")
                ) {
                    Toggle(isOn: $isLimitExceededNotificationEnabled) {
                        Text("Превышение лимита")
                    }
                    .onChange(of: isLimitExceededNotificationEnabled) {
                        viewModel.editLimitExceededNotificationEnabled(isLimitExceededNotificationEnabled)
                    }
                    
                    if viewModel.uiState.isLimitExceededNotificationEnabled {
                        VStack {
                            HStack {
                                Text("Сумма лимита:")
                                Spacer()
                                Text("\(viewModel.uiState.limitAmount, specifier: "%.2f") ₽")
                            }
                            Slider(value: $limitAmount, in: 0...10000, step: 100)
                                .accentColor(.blue)
                                .onChange(of: limitAmount) {
                                    viewModel.editLimitAmount(limitAmount)
                                }
                            HStack {
                                Text("Период:")
                                Spacer()
                                Picker("Выберите период", selection: $selectedPeriod) {
                                    ForEach(Period.allCases) { period in
                                        Text(period.rawValue).tag(period)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .onChange(of: selectedPeriod) {
                                    viewModel.editSelectedPeriod(selectedPeriod)
                                }
                            }
                        }
                    }
                }
                
                // Секция случайных отчетов
                Section(
                    header: Text("Отчеты"),
                    footer: Text("В конце каждой недели будет отправлен случайный короткий отчет по вашим операциям")
                ) {
                    Toggle(isOn: $isRandomReportEnabled) {
                        Text("Случайные отчеты")
                    }
                    .onChange(of: isRandomReportEnabled) {
                        viewModel.editRandomReportEnabled(isRandomReportEnabled)
                    }
                }
            }
            .navigationBarTitle("Уведомления", displayMode: .inline)
            .toolbar(.hidden, for: .tabBar)
        }
        .onChange(of: viewModel.uiState) {
            isReminderEnabled = viewModel.uiState.isReminderEnabled
            isLimitExceededNotificationEnabled = viewModel.uiState.isLimitExceededNotificationEnabled
            isRandomReportEnabled = viewModel.uiState.isRandomReportEnabled
            limitAmount = viewModel.uiState.limitAmount
            selectedPeriod = viewModel.uiState.selectedPeriod
        }
    }
}

#Preview {
    NotificationsView(
        viewModel: NotificationsProcessor(ops: CostControlOps(settingsRepo: SettingsRepo()))
    )
}
