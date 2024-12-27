import SwiftUI
import LocalAuthentication

class AuthProcessor: AuthViewModel {
    @ObservedObject private var ops: CostControlOps
    
    init(ops: CostControlOps) {
        self.ops = ops
    }
    
    func authenticateUser() {
        Task {
            await ops.authenticate()
        }
    }
}
