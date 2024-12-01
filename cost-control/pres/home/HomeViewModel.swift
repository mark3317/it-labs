//
//  HomeViewModel.swift
//  cost-control
//
//  Created by Mark Nokhrin on 01.12.2024.
//

// HomeViewModel.swift
import Foundation
import Combine

class HomeViewModel: HomeActions, ObservableObject {
    @Published var uiState = HomeUIState.initial

    init() {
        loadData()
    }

    func loadData() {
        // Пример данных
        let transactions = [
            Cost(amount: 100.0, description: "Salary", date: Date(), type: .income),
            Cost(amount: 50.0, description: "Groceries", date: Date(), type: .expense),
            Cost(amount: 150.0, description: "Groceries", date: Date(), type: .income)
        ]

        self.uiState = self.uiState.copy(
            totalIncome: transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount },
            totalExpense: transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount },
            balance: transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount } -
            transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount },
            recentTransactions: transactions
        )
    }
}
