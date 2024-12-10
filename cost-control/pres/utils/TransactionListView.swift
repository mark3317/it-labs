import SwiftUI

struct TransactionListView: View {
    let title: String
    let transactions: [Transaction]
    
    var body: some View {
        let groupedTransactions = Dictionary(grouping: transactions) { transaction in
            Calendar.current.startOfDay(for: transaction.date)
        }
        
        VStack {
            Text(title)
                .font(.headline)
                .padding()
            
            ForEach(groupedTransactions.keys.sorted(by: >), id: \.self) { date in
                VStack(alignment: .leading) {
                    Text("\(date, formatter: DateFormatter.dayMonth)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(8)
                    ForEach(groupedTransactions[date] ?? []) { transaction in
                        Divider()
                        HStack {
                            if let category = transaction.category {
                                Image(systemName: category.icon)
                                    .foregroundColor(Color(hex: category.colorHex))
                                    .frame(width: 24)
                                    .padding(.trailing, 8)
                            }
                            VStack(alignment: .leading) {
                                Text(transaction.description)
                                    .font(.headline)
                                Text(
                                    "\(transaction.date, formatter: DateFormatter.shortDate)"
                                )
                                .font(.subheadline)
                            }
                            Spacer()
                            Text("\(transaction.amount, specifier: "%.2f") ₽")
                                .font(.headline)
                                .foregroundColor(
                                    transaction.type == .income ? .green : .red)
                        }
                        .padding()
                    }
                    Divider()
                }
            }
        }
    }
}

#Preview {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    let foodCategory = Category(name: "Еда", colorHex: Color.red.toHex(), type: .expense, icon: "fork.knife")
    let salaryCategory = Category(name: "Зарплата", colorHex: Color.green.toHex(), type: .income, icon: "dollarsign.circle")
    let entertainmentCategory = Category(name: "Развлечения", colorHex: Color.blue.toHex(), type: .expense, icon: "gamecontroller")
    let investmentCategory = Category(name: "Инвестиции", colorHex: Color.purple.toHex(), type: .income, icon: "chart.bar")
    // Пример данных
    let transactions = [
        Transaction(amount: 100.0, description: "Salary", date: dateFormatter.date(from: "2023-10-01")!, type: .income, category: salaryCategory),
        Transaction(amount: 50.0, description: "Food", date: Date(), type: .expense, category: foodCategory),
        Transaction(amount: 150.0, description: "Entertainment", date: dateFormatter.date(from: "2023-11-20")!, type: .expense, category: entertainmentCategory),
        Transaction(amount: 150.0, description: "Investment", date: dateFormatter.date(from: "2023-12-6")!, type: .income, category: nil),
        Transaction(amount: 150.0, description: "Investment", date: dateFormatter.date(from: "2023-12-6")!, type: .income, category: investmentCategory)
    ]
    
    return TransactionListView(title: "Последние операции", transactions: transactions)
}
