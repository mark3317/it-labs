import Combine

protocol AuthViewModel : ObservableObject {
    func authenticateUser()
}
