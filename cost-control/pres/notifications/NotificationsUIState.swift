import Foundation

struct NotificationsUIState : Equatable {
    let isReminderEnabled: Bool
    let isLimitExceededNotificationEnabled: Bool
    let isRandomReportEnabled: Bool
    let limitAmount: Double
    let selectedPeriod: Period
}

enum Period: String, CaseIterable, Identifiable {
    case day = "День"
    case week = "Неделя"
    case month = "Месяц"
    
    var id: String { self.rawValue }
}

extension NotificationsUIState {
    static let initial = NotificationsUIState(
        isReminderEnabled: false,
        isLimitExceededNotificationEnabled: false,
        isRandomReportEnabled: false,
        limitAmount: 100.0,
        selectedPeriod: .day
    )
}

extension NotificationsUIState {
    func copy(
        isReminderEnabled: Bool? = nil,
        isLimitExceededNotificationEnabled: Bool? = nil,
        isRandomReportEnabled: Bool? = nil,
        limitAmount: Double? = nil,
        selectedPeriod: Period? = nil
    ) -> NotificationsUIState {
        let newUiState = NotificationsUIState(
            isReminderEnabled: isReminderEnabled ?? self.isReminderEnabled,
            isLimitExceededNotificationEnabled: isLimitExceededNotificationEnabled ?? self.isLimitExceededNotificationEnabled,
            isRandomReportEnabled: isRandomReportEnabled ?? self.isRandomReportEnabled,
            limitAmount: limitAmount ?? self.limitAmount,
            selectedPeriod: selectedPeriod ?? self.selectedPeriod
        )
        print(newUiState)
        return newUiState
    }
}
