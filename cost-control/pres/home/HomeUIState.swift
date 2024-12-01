//
//  HomeUIState.swift
//  cost-control
//
//  Created by Mark Nokhrin on 01.12.2024.
//

import Foundation

struct HomeUIState {
    let totalIncome: Double
    let totalExpense: Double
    let balance: Double
    let recentTransactions: [Cost]
}

extension HomeUIState {
    static let initial = HomeUIState(
        totalIncome: 0,
        totalExpense: 0,
        balance: 0,
        recentTransactions: []
    )
}

extension HomeUIState {
    func copy(
        totalIncome: Double? = nil,
        totalExpense: Double? = nil,
        balance: Double? = nil,
        recentTransactions: [Cost]? = nil
    ) -> HomeUIState {
        return HomeUIState(
            totalIncome: totalIncome ?? self.totalIncome,
            totalExpense: totalExpense ?? self.totalExpense,
            balance: balance ?? self.balance,
            recentTransactions: recentTransactions ?? self.recentTransactions
        )
    }
}
