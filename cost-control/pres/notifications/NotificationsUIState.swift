import Foundation

struct NotificationsUIState : Equatable {
    let currency: String
    let isReminderEnabled: Bool
    let isLimitExceededNotificationEnabled: Bool
    let isRandomReportEnabled: Bool
    let limitAmount: Double
    let selectedPeriod: NotificationPeriod
}

extension NotificationsUIState {
    func copy(
        isReminderEnabled: Bool? = nil,
        isLimitExceededNotificationEnabled: Bool? = nil,
        isRandomReportEnabled: Bool? = nil,
        limitAmount: Double? = nil,
        selectedPeriod: NotificationPeriod? = nil
    ) -> NotificationsUIState {
        let newUiState = NotificationsUIState(
            currency: self.currency,
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
