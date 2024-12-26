import Foundation

@MainActor
protocol IStorageRepo {
    func createTransaction(transaction: Transaction) async
    func fetchTransactions() async -> [Transaction]
    func deleteTransaction(id: UUID) async
    func createCategory(category: Category) async
    func fetchCategories() async -> [Category]
    func deleteCategory(id: UUID) async
    func clearAllData() async
}
