enum BankAccountError: Error {
    case insufficientFunds
    case invalidAmount
    case transferFailed
}

class BankAccount {
    let owner: String
    // Лимит на снятие средств
    let withdrawalLimit: Double = 1000.0
    private(set) var balance: Double
    
    init(owner: String, balance: Double = 0.0) {
        self.owner = owner
        self.balance = balance
    }
    
    func deposit(amount: Double) throws {
        defer {
            print("Deposit operation completed.")
        }
        
        guard amount > 0 else {
            throw BankAccountError.invalidAmount
        }
        
        balance += amount
    }
    
    func withdraw(amount: Double) throws {
        defer {
            print("Withdraw operation completed.")
        }
        
        guard amount > 0 else {
            throw BankAccountError.invalidAmount
        }
        
        guard amount <= withdrawalLimit else {
            throw BankAccountError.invalidAmount
        }
        
        guard balance >= amount else {
            throw BankAccountError.insufficientFunds
        }
        
        balance -= amount
    }
    
    // Функция перевода средств между счетами
    func transfer(amount: Double, to account: BankAccount) throws {
        defer {
            print("Transfer operation completed.")
        }
        
        do {
            try self.withdraw(amount: amount)
            try account.deposit(amount: amount)
        } catch {
            throw BankAccountError.transferFailed
        }
    }
}

// Создаем несколько банковских счетов
let account1 = BankAccount(owner: "Alice", balance: 1000)
let account2 = BankAccount(owner: "Bob", balance: 500)

// Пополняем счет через try!
try! account1.deposit(amount: 200)
print("Deposit successful. New balance of \(account1.owner): \(account1.balance)")

// Снимаем деньги с использованием try?
if let _ = try? account1.withdraw(amount: 300) {
    print("Withdrawal successful. New balance of \(account1.owner): \(account1.balance)")
} else {
    print("Failed to withdraw money.")
}

// Пробуем снять больше денег, чем есть на счете, и обрабатываем ситуацию через do-catch
do {
    try account2.withdraw(amount: 600)
    print("Withdrawal successful. New balance of \(account2.owner): \(account2.balance)")
} catch BankAccountError.insufficientFunds {
    print("Error: Insufficient funds.")
} catch BankAccountError.invalidAmount {
    print("Error: Invalid amount.")
} catch {
    print("An unexpected error occurred: \(error)")
}

// Пробуем перевести деньги между счетами
do {
    try account1.transfer(amount: 500, to: account2)
    print("Transfer successful.")
    print("New balance of \(account1.owner): \(account1.balance)")
    print("New balance of \(account2.owner): \(account2.balance)")
} catch {
    print("Failed to transfer money: \(error)")
}
