import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: Binding(
                    get: { viewModel.uiState.currentPage },
                    set: { newValue in withAnimation {
                        viewModel.editCurrentPage(newValue)
                    }}
                )) {
                    OnboardingPageView(
                        imageName: "Onboarding1",
                        title: "Отслеживайте операции",
                        description: "Добавляйте свои расходы/доходы и следите за тем, куда уходят ваши деньги."
                    )
                    .tag(0)
                    
                    OnboardingPageView(
                        imageName: "Onboarding2",
                        title: "Создавайте категории",
                        description: "Организуйте свои операции, создавая удобные категории для каждого типа."
                    )
                    .tag(1)
                    
                    OnboardingPageView(
                        imageName: "Onboarding3",
                        title: "Гибкая кастомизация",
                        description: "Настраивайте созданные категории и операции так, как вам удобно, чтобы максимально адаптировать приложение под свои нужды."
                    )
                    .tag(2)
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        if (!viewModel.uiState.viewedLastPage) {
                            viewModel.editCurrentPage(viewModel.uiState.currentPage + 1)
                        } else if (!viewModel.uiState.viewedOnboarding) {
                            viewModel.markViewOnboarding()
                        } else {
                            dismiss()
                        }
                    }
                }) {
                    Text(viewModel.uiState.viewedLastPage ? "Начать" : "Далее")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(30)
                        .padding(.horizontal)
                }
                .padding(.bottom, 20)
            }
        }
        .navigationBarTitle("О приложении", displayMode: .inline)
        .toolbar(.hidden, for: .tabBar)
    }
}


#Preview {
    OnboardingView(
        viewModel: OnboardingViewModel(ops: CostControlOps(
            settingsRepo: SettingsRepo(),
            storageRepo: StorageRepo(),
            authRepo: AuthRepo()
        ))
    )
}
