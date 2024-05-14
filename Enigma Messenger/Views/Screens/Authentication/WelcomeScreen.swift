

import SwiftUI

struct WelcomeScreen: View {
    
    @Binding var showAuthScr: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Welcome to Enigma Messenger")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                
                HStack {
                    Text("Where we re-define privacy on the internet")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundStyle(.gray)
                    Spacer()
                }
                
                HStack(spacing: 32) {
                    Image(systemName: "hand.raised.fill")
                        .resizable()
                        .frame(width: 48, height: 56)
                    Image(systemName: "lock.open.fill")
                        .resizable()
                        .frame(width: 48, height: 56)
                    Image(systemName: "lock.fill")
                        .resizable()
                        .frame(width: 48, height: 56)
                }
                .padding(.vertical)
                .foregroundStyle(.blue)
                
                Spacer()
                
                NavigationLink {
                    EnterNameScreen(showAuthScr: $showAuthScr)
                } label: {
                    StandardBtnLbl(title: "Continue")
                        .padding()
                }

            }
            .navigationTitle("Hello")
            .padding(.horizontal)
        }
    }
}

#Preview {
    WelcomeScreen(showAuthScr: .constant(false))
}
