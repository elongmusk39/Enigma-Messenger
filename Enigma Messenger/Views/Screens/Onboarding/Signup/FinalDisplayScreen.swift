
import SwiftUI

struct FinalDisplayScreen: View {
    
    @Binding var isLoggedIn: Bool
    @Binding var user: User
    @State var showLoading = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(spacing: 24) {
                
                infoLabel(context: "uniqueName", user: user)
                infoLabel(context: "ID", user: user)
                infoLabel(context: "PIN", user: user)
                
                Spacer()
                
                Button {
                    Task {
                        await signUpUser()
                    }
                } label: {
                    StandardBtnLbl(title: "Let's go", background: .blue)
                }
                .padding(.vertical)
            }
            .padding()
            
            if showLoading {
                LoadingView()
            }
        }
        .navigationTitle("Your Information")
        .navigationBarTitleDisplayMode(.inline)
    }
    
//MARK: Function -------------------------------------------
    
    private func signUpUser() async {
        showLoading = true
        
        try? await Task.sleep(nanoseconds: 0_100_000_000)//delay
        await AuthServices.shared.signUpUser(user: user)
        isLoggedIn = true
        
        showLoading = false
    }
}

#Preview {
    FinalDisplayScreen(isLoggedIn: .constant(false), user: .constant(User.initUser))
}

//MARK: -------------------------------------------

struct infoLabel: View {
    
    var context: String
    var user: User
    
    var body: some View {
        Text("\(context): \(configContext())")
            .font(.title3)
            .fontWeight(.regular)
            .foregroundStyle(.black)
            .padding()
            .overlay(content: {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 0.5)
                    .foregroundStyle(Color(.systemGray4))
                    .shadow(color: .black.opacity(0.4), radius: 2)
            })
    }
    
    private func configContext() -> String {
        if context == "uniqueName" {
            return user.uniqueName
        } else if context == "ID" {
            return user.ID
        } else if context == "PIN" {
            return user.PIN
        } else {
            return "nil"
        }
    }
}
