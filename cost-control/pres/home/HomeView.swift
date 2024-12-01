import SwiftUI

struct HomeView<ViewModel>: View where ViewModel: HomeViewModel {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Расходы")
                                .font(.headline)
                                .foregroundColor(Color.black)
                            Text("\(viewModel.uiState.totalExpense, specifier: "%.2f") ₽")
                                .font(.title)
                                .foregroundColor(Color.black)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                        }
                        .padding()
                        .frame(maxWidth: 200)
                        Spacer()
                        Divider()
                            .frame(height: 50)
                            .background(Color.gray)
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Доходы")
                                .font(.headline)
                                .foregroundColor(Color.black)
                            Text("\(viewModel.uiState.totalIncome, specifier: "%.2f") ₽")
                                .font(.title)
                                .foregroundColor(Color.black)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                        }
                        .padding()
                        .frame(maxWidth: 200)
                        Spacer()
                    }
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(50)
                    .padding()
                    
                    VStack {
                        Text("Остаток")
                            .font(.headline)
                        Text("\(viewModel.uiState.balance, specifier: "%.2f") ₽")
                            .font(.title)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(50)
                    .padding()
                    
                    Text("Последние операции")
                        .font(.headline)
                        .padding()
                    
                    Divider()
                    
                    
                    ForEach(viewModel.uiState.transactions.indices, id: \.self) { index in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(viewModel.uiState.transactions[index].description)
                                    .font(.headline)
                                Text("\(viewModel.uiState.transactions[index].date, formatter: DateFormatter.shortDate)")
                                    .font(.subheadline)
                            }
                            Spacer()
                            Text("\(viewModel.uiState.transactions[index].amount, specifier: "%.2f") ₽")
                                .font(.headline)
                                .foregroundColor(viewModel.uiState.transactions[index].type == .income ? .green : .red)
                        }
                        .padding()
                        
                        if index < viewModel.uiState.transactions.count - 1 {
                            Divider()
                        }
                    }
                }
            }
            .navigationBarTitle("Главная")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: NavigationLink(
                    destination: AddTransactionView(viewModel: AddTransactionProcessor())
                ) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
            )
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

#Preview {
    HomeView(viewModel: HomeProcessor())
}
