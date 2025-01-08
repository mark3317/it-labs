import SwiftUI

class AuthViewModel: ObservableObject {
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
