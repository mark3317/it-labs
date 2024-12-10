import SwiftUI
import Foundation

class NotificationsProcessor: NotificationsViewModel {
    @Published var uiState = NotificationsUIState.initial
    
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
    
    func editSelectedPeriod(_ period: Period) {
        uiState = uiState.copy(
            selectedPeriod: period
        )
    }
}
