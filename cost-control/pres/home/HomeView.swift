//
//  HomeView.swift
//  cost-control
//
//  Created by Mark Nokhrin on 01.12.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Общий доход")
                            .font(.headline)
                        Text("\(viewModel.uiState.totalIncome, specifier: "%.2f") ₽")
                            .font(.title)
                    }
                    .padding()
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Общий расход")
                            .font(.headline)
                        Text("\(viewModel.uiState.totalExpense, specifier: "%.2f") ₽")
                            .font(.title)
                    }
                    .padding()
                }
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
                .padding()

                VStack(alignment: .leading) {
                    Text("Баланс")
                        .font(.headline)
                    Text("\(viewModel.uiState.balance, specifier: "%.2f") ₽")
                        .font(.title)
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(10)
                .padding()

                Text("Последние операции")
                    .font(.headline)
                    .padding()

                List(viewModel.uiState.recentTransactions) { transaction in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(transaction.description)
                                .font(.headline)
                            Text("\(transaction.date, formatter: DateFormatter.shortDate)")
                                .font(.subheadline)
                        }
                        Spacer()
                        Text("\(transaction.amount, specifier: "%.2f") ₽")
                            .font(.headline)
                            .foregroundColor(transaction.type == .income ? .green : .red)
                    }
                    .padding()
                }
            }
            .navigationTitle("Главная")
        }
    }
}

extension DateFormatter {
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}
