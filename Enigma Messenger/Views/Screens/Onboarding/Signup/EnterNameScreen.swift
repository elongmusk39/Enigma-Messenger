

import SwiftUI

struct EnterNameScreen: View {
        
    @State var user = User.emptyUser
    @FocusState private var keyboardFocused: Bool //keyboard popup
    
    var body: some View {
        VStack {
            Text("What's your name?")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("We will use this name to call you")
                .font(.footnote)
                .foregroundStyle(.gray)
                .padding(.horizontal, 24)
            
            //userInput is store in viewModel.email
            TextField("Name", text: $user.uniqueName)
                .textInputAutocapitalization(.never)
                .modifier(TxtFieldModifier())
                .focused($keyboardFocused)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            keyboardFocused = true
                    }
                }
                        
            NavigationLink(destination: {
                GenerateIDScreen(user: $user)
            }, label: {
                StandardBtnLbl(title: "Next", background: user.uniqueName.isEmpty ? .gray : .blue)
            })
            .padding(.vertical)
            .disabled(user.uniqueName.isEmpty)
            
            Spacer()

        }
        .navigationTitle("Name")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EnterNameScreen()
}
