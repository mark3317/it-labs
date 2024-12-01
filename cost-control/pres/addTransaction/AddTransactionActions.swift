import SwiftUI

protocol AddTransactionActions {
    func editAmount(_ amount: Double)
    func editDescription(_ description: String)
    func editDate(_ date: Date)
    func editType(_ type: TypeTransaction)
    func editCategory(_ category: CategoryTransaction)
    func onClickAddTransaction()
}
