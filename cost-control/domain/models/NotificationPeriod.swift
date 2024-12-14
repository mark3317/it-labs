import Foundation

enum NotificationPeriod: String, CaseIterable, Identifiable {
    case day = "День"
    case week = "Неделя"
    case month = "Месяц"
    
    var id: String { self.rawValue }
}
