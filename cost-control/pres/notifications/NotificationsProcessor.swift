import SwiftUI
import Foundation

class NotificationsProcessor: NotificationsViewModel {
    @ObservedObject private var ops: CostControlOps
    @Published private(set) var uiState: NotificationsUIState
    
    init(ops: CostControlOps) {
        self.ops = ops
        uiState = .init(
            isReminderEnabled: false,
            isLimitExceededNotificationEnabled: false,
            isRandomReportEnabled: false,
            limitAmount: 100.0,
            selectedPeriod: .day
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
    
    func editSelectedPeriod(_ period: Period) {
        uiState = uiState.copy(
            selectedPeriod: period
        )
    }
}
