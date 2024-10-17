

import SwiftUI

struct EnterNameScreen: View {
    
    @Binding var showAuthScr: Bool
    
    @State var name: String = ""
    @FocusState private var keyboardFocused: Bool //keyboard
    
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
            TextField("Name", text: $name)
                .textInputAutocapitalization(.never)
                .modifier(TxtFieldModifier())
                .focused($keyboardFocused)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            keyboardFocused = true
                    }
                }
                        
            NavigationLink(destination: {
                GenerateIDScreen(showAuthScr: $showAuthScr)
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
    EnterNameScreen(showAuthScr: .constant(false))
}
