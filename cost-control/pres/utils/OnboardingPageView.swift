import SwiftUI

struct OnboardingPageView: View {
    let imageName: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 400)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 10)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal)
        }
        .padding()
    }
}
