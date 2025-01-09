import SwiftUI

struct AuthView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Аутентификация")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)
                
                Spacer()
                
                Image(systemName: "faceid")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                
                Spacer()
                
                Button(action: {
                    viewModel.authenticateUser()
                }) {
                    Text("Face/Touch ID")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .font(.headline)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
            }
            .onAppear {
                viewModel.authenticateUser()
            }
        }
    }
}

#Preview {
    AuthView(
        viewModel: AuthViewModel(ops: CostControlOps(
            settingsRepo: SettingsRepo(),
            storageRepo: StorageRepo(),
            authRepo: AuthRepo()
        ))
    )
}
