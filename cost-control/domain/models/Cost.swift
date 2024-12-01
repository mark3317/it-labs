//
//  Cost.swift
//  cost-control
//
//  Created by Mark Nokhrin on 01.12.2024.
//

import Foundation

struct Cost: Identifiable {
    let id: UUID
    let amount: Double
    let description: String
    let date: Date
    let type: TransactionType

    init(amount: Double, description: String, date: Date, type: TransactionType) {
        self.id = UUID()
        self.amount = amount
        self.description = description
        self.date = date
        self.type = type
    }
}
