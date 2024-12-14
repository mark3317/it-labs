import Foundation

struct HomeUIState : Equatable {
    let currency: String
    let totalIncome: Double
    let totalExpense: Double
    let balance: Double
    let transactions: [Transaction]
}

extension HomeUIState {
    func copy(
        totalIncome: Double? = nil,
        totalExpense: Double? = nil,
        balance: Double? = nil,
        transactions: [Transaction]? = nil
    ) -> HomeUIState {
        let newUiState = HomeUIState(
            currency: self.currency,
            totalIncome: totalIncome ?? self.totalIncome,
            totalExpense: totalExpense ?? self.totalExpense,
            balance: balance ?? self.balance,
            transactions: transactions ?? self.transactions
        )
        print(newUiState)
        return newUiState
    }
}
