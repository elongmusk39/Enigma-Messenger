

import SwiftUI

struct WelcomeScreen: View {
        
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Welcome to Enigma Messenger")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black)
                
                Text("The place where we re-define privacy on the internet")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
                
                HStack(spacing: 32) {
                    Image(systemName: "hand.raised.fill")
                        .resizable()
                        .frame(width: 48, height: 56)
                        .foregroundStyle(.red)
                    Image(systemName: "lock.open.fill")
                        .resizable()
                        .frame(width: 48, height: 56)
                        .foregroundStyle(.green)
                    Image(systemName: "lock.fill")
                        .resizable()
                        .frame(width: 48, height: 56)
                        .foregroundStyle(.black)
                }
                .padding(.vertical, 32)
                
                Spacer()
                
                NavigationLink {
                    LoginScreen(isLoggedIn: $isLoggedIn)
                } label: {
                    StandardBtnLbl(title: "Log In", background: .blue)
                }
                
                Divider()
                
                NavigationLink {
                    EnterNameScreen(isLoggedIn: $isLoggedIn)
                } label: {
                    StandardBtnLbl(title: "Sign Up", background: .black)
                        .padding(.bottom)
                }

            }
            .navigationTitle("")
            .padding(.horizontal)
        }
    }
}

#Preview {
    WelcomeScreen(isLoggedIn: .constant(false))
}
