
import SwiftUI

struct EnterPINScreen: View {
    
    @Binding var showAuthScr: Bool
    
    @State var PIN: String = ""
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
            TextField("Enter a 6-digit PIN", text: $PIN)
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
                FinalDisplayScreen(showAuthScr: $showAuthScr)
            }, label: {
                StandardBtnLbl(title: "Next")
            })
            .padding(.vertical)
            
            Spacer()

        }
        .navigationTitle("Name")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EnterPINScreen(showAuthScr: .constant(false))
}
