import Combine

final class CostControlOps : ObservableObject {
    private var settingsRepo: any ISettingsRepo
    private var storageRepo: any IStorageRepo
    private var authRepo: any IAuthRepo
    @Published private(set) var isAuthorized: Bool
    @Published private(set) var settings: AppSettings
    @Published private(set) var transactions: [Transaction]
    @Published private(set) var categories: [Category]
    
    init(
        settingsRepo: any ISettingsRepo,
        storageRepo: any IStorageRepo,
        authRepo: any IAuthRepo
    ) {
        self.settingsRepo = settingsRepo
        self.storageRepo = storageRepo
        self.authRepo = authRepo
        self.settings = settingsRepo.getSettings()
        self.isAuthorized = false
        self.transactions = []
        self.categories = []
        Task {
            let transactions = await storageRepo.fetchTransactions()
            let categories = await storageRepo.fetchCategories()
            
            await MainActor.run {
                self.transactions = transactions
                self.categories = categories
            }
        }
    }
    
    func saveTransaction(transaction: Transaction) async {
        await storageRepo.createTransaction(transaction: transaction)
        await MainActor.run {
            transactions.append(transaction)
        }
    }
    
    func saveCategory(category: Category) async {
        await storageRepo.createCategory(category: category)
        await MainActor.run {
            categories.append(category)
        }
    }
    
    func clearAllData() async {
        await storageRepo.clearAllData()
        await MainActor.run {
            self.transactions = []
            self.categories = []
        }
    }
    
    func saveSetting(settings: AppSettings) {
        settingsRepo.saveSettings(settings: settings)
        self.settings = settings
    }
    
    func authenticate() async {
        let result = await authRepo.authenticate()
        
        await MainActor.run {
            self.isAuthorized = result
        }
    }
}
