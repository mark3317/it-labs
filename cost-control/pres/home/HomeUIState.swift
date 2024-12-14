import Foundation

struct HomeUIState : Equatable {
    let currency: String
    let totalIncome: Double
    let totalExpense: Double
    let balance: Double
    let transactions: [Transaction]
}

extension HomeUIState {
    static let initial = HomeUIState(
        currency: "₽",
        totalIncome: 0,
        totalExpense: 0,
        balance: 0,
        transactions: []
    )
}

extension HomeUIState {
    func copy(
        totalIncome: Double? = nil,
        totalExpense: Double? = nil,
        balance: Double? = nil,
        recentTransactions: [Transaction]? = nil
    ) -> HomeUIState {
        let newUiState = HomeUIState(
            currency: self.currency,
            totalIncome: totalIncome ?? self.totalIncome,
            totalExpense: totalExpense ?? self.totalExpense,
            balance: balance ?? self.balance,
            transactions: recentTransactions ?? self.transactions
        )
        print(newUiState)
        return newUiState
    }
}
