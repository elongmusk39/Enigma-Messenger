
import SwiftUI

struct EnterPINScreen: View {
        
    @Binding var isLoggedIn: Bool
    @Binding var user: User
    @FocusState private var keyboardFocused: Bool //keyboard
    
    var body: some View {
        VStack {
            Text("Create your 6-digit PIN")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("You will use this PIN to verify your identity in case you forgot your unique ID")
                .font(.footnote)
                .foregroundStyle(.gray)
                .padding(.horizontal, 24)
            
            //userInput is store in viewModel.email
            TextField("Enter a 6-digit PIN", text: $user.PIN)
                .textInputAutocapitalization(.never)
                .modifier(TxtFieldModifier())
                .keyboardType(.numberPad)
                .focused($keyboardFocused)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            keyboardFocused = true
                    }
                }
            
            NavigationLink(destination: {
                FinalDisplayScreen(isLoggedIn: $isLoggedIn, user: $user)
            }, label: {
                StandardBtnLbl(title: "Next", background: user.PIN.count != 6 ? .gray : .blue)
            })
            .padding(.vertical)
            .disabled(user.PIN.count != 6)
            
            Spacer()

        }
        .navigationTitle("Name")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    EnterPINScreen(isLoggedIn: .constant(false), user: .constant(User.initUser))
}
