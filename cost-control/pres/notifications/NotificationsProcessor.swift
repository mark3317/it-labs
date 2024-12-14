import SwiftUI

class NotificationsProcessor: NotificationsViewModel {
    @ObservedObject private var ops: CostControlOps
    @Published private(set) var uiState: NotificationsUIState
    
    init(ops: CostControlOps) {
        self.ops = ops
        uiState = .init(
            currency: ops.settings.currency,
            isReminderEnabled: false,
            isLimitExceededNotificationEnabled: false,
            isRandomReportEnabled: false,
            limitAmount: 100.0,
            selectedPeriod: NotificationPeriod.day
        )
    }
    
    func editReminderEnabled(_ enabled: Bool) {
        uiState = uiState.copy(
            isReminderEnabled: enabled
        )
    }
    
    func editLimitExceededNotificationEnabled(_ enabled: Bool) {
        uiState = uiState.copy(
            isLimitExceededNotificationEnabled: enabled
        )
    }
    
    func editRandomReportEnabled(_ enabled: Bool) {
        uiState = uiState.copy(
            isRandomReportEnabled: enabled
        )
    }
    
    func editLimitAmount(_ amount: Double) {
        uiState = uiState.copy(
            limitAmount: amount
        )
    }
    
    func editSelectedPeriod(_ period: NotificationPeriod) {
        uiState = uiState.copy(
            selectedPeriod: period
        )
    }
}
