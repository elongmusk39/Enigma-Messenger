
import SwiftUI

struct FinalDisplayScreen: View {
    
    @Binding var isLoggedIn: Bool
    @Binding var user: User
    
    @State var showLoading = false
    @State var showAlert = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(spacing: 20) {
                
                infoLabel(context: "Name", user: user)
                    .padding(.top, 24)
                infoLabel(context: "ID", user: user)
                infoLabel(context: "PIN#", user: user)
                
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
        .alert("Duplicated!", isPresented: $showAlert) {
            Button("OK", role: .cancel, action: {})
        } message: {
            Text("This name is already taken. Please choose a different name.")
        }
    }
    
//MARK: Function -------------------------------------------
    
    private func signUpUser() async {
        showLoading = true
        
        try? await Task.sleep(nanoseconds: 0_100_000_000)//delay
        
        let yesDupl = await AuthServices.shared.didFindDuplName(uniqueName: user.uniqueName)
        if yesDupl {
            showAlert.toggle()
        } else {
            await AuthServices.shared.signUpUser(user: user)
            isLoggedIn = true
        }
        
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
        HStack {
            Text("\(context):")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.black)
                .padding(.horizontal)
            
            Text("\(configContext())")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
            
            Spacer()
        }
        .frame(width: 360, height: 48)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 0.5)
                .foregroundStyle(Color(.systemGray4))
                .shadow(color: .black.opacity(0.4), radius: 2)
        })
            
    }
    
    private func configContext() -> String {
        if context == "Name" {
            return user.uniqueName
        } else if context == "ID" {
            return user.ID
        } else if context == "PIN#" {
            return user.PIN
        } else {
            return "nil"
        }
    }
}
