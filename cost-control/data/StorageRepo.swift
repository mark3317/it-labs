import Foundation
import SwiftData

@MainActor
class StorageRepo : IStorageRepo {
    private let modelContainer: ModelContainer
    private var modelContext: ModelContext
    
    init() {
        modelContainer = try! ModelContainer(for: CategoryEntity.self, TransactionEntity.self)
        modelContext = modelContainer.mainContext
    }
    
    func createTransaction(transaction: Transaction) async {
        modelContext.insert(TransactionEntity(from: transaction))
    }
    
    func fetchTransactions() async -> [Transaction] {
        let fetchDescriptor = FetchDescriptor<TransactionEntity>(
            sortBy: [SortDescriptor(\TransactionEntity.date)]
        )
        let transactions = try? modelContext.fetch(fetchDescriptor)
        return transactions?.map(Transaction.init) ?? []
    }
    
    func deleteTransaction(id: UUID) async {
        let fetchDescriptor = FetchDescriptor<TransactionEntity>(
            predicate: #Predicate { $0.id == id }
        )
        if let transaction = try? modelContext.fetch(fetchDescriptor).first {
            modelContext.delete(transaction)
        }
    }
    
    func createCategory(category: Category) async {
        modelContext.insert(CategoryEntity(from: category))
    }
    
    func fetchCategories() async -> [Category] {
        let fetchDescriptor = FetchDescriptor<CategoryEntity>(
            sortBy: [SortDescriptor(\CategoryEntity.name)]
        )
        let categories = try? modelContext.fetch(fetchDescriptor)
        return categories?.map(Category.init) ?? []
    }
    
    func deleteCategory(id: UUID) async {
        let fetchDescriptor = FetchDescriptor<CategoryEntity>(
            predicate: #Predicate { $0.id == id }
        )
        if let category = try? modelContext.fetch(fetchDescriptor).first {
            modelContext.delete(category)
        }
    }
    
    func clearAllData() async {
        let transactionFetchDescriptor = FetchDescriptor<TransactionEntity>()
        if let transactions = try? modelContext.fetch(transactionFetchDescriptor) {
            for transaction in transactions {
                modelContext.delete(transaction)
            }
        }
        let categoryFetchDescriptor = FetchDescriptor<CategoryEntity>()
        if let categories = try? modelContext.fetch(categoryFetchDescriptor) {
            for category in categories {
                modelContext.delete(category)
            }
        }
    }
}
