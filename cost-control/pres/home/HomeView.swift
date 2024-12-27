import SwiftUI

struct HomeView<ViewModel: HomeViewModel>: View {
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
                            Text("\(viewModel.uiState.totalExpense, specifier: "%.2f") \(viewModel.uiState.currency)")
                                .font(.title)
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
                            Text("\(viewModel.uiState.totalIncome, specifier: "%.2f") \(viewModel.uiState.currency)")
                                .font(.title)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                        }
                        .padding()
                        .frame(maxWidth: 200)
                        Spacer()
                    }
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(50)
                    .padding()
                    
                    VStack {
                        Text("Остаток")
                            .font(.headline)
                        Text("\(viewModel.uiState.balance, specifier: "%.2f") \(viewModel.uiState.currency)")
                            .font(.title)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.3))
                    .cornerRadius(50)
                    .padding()
                    
                    TransactionListView(
                        title: "Последние операции",
                        transactions: viewModel.uiState.transactions,
                        currency: viewModel.uiState.currency
                    )
                }
            }
            .navigationBarTitle("Главная")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: NavigationLink(
                    destination: AddTransactionView(viewModel: viewModel.addTransactionViewModel)
                ) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
            )
        }
    }
}

#Preview {
    HomeView(
        viewModel: HomeProcessor(ops: CostControlOps(
            settingsRepo: SettingsRepo(),
            storageRepo: StorageRepo(),
            authRepo: AuthRepo()
        ))
    )
}
