import LocalAuthentication

class AuthRepo : IAuthRepo {
    
    func authenticate() async -> Bool {
        let context = LAContext()
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            print(error?.localizedDescription ?? "Неизвестная ошибка")
            return false
        }
        
        do {
            try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Авторизуйтесь с помощью Face ID или Touch ID.")
            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }
}
