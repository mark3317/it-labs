import Combine

protocol NotificationsViewModel : ObservableObject {
    var uiState: NotificationsUIState { get }
    func editReminderEnabled(_ enabled: Bool)
    func editLimitExceededNotificationEnabled(_ enabled: Bool)
    func editRandomReportEnabled(_ enabled: Bool)
    func editLimitAmount(_ amount: Double)
    func editSelectedPeriod(_ period: Period)
}
