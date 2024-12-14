enum TransactionType: String, CaseIterable, Identifiable {
    case expense = "Расходы"
    case income = "Доходы"
    
    var id: String { self.rawValue }
}
