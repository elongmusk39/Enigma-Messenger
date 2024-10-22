//
//  LoginScreen.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 10/17/24.
//

import SwiftUI

struct LoginScreen: View {
    
    @Binding var isLoggedIn: Bool
    
    @State var uniqueName: String = ""
    @State var PIN: String = ""
    @State var ID: String = ""
    @FocusState private var keyboardFocused: Bool //keyboard popup
    
    var body: some View {
        VStack {
            Text("Please sign in with your credentials or ID")
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundStyle(.gray)
                .padding()
                .padding(.top)
            
            TextField("Name", text: $uniqueName)
                .textInputAutocapitalization(.never)
                .modifier(TxtFieldModifier())
                .focused($keyboardFocused)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            keyboardFocused = true
                    }
                }
            
            TextField("PIN", text: $PIN)
                .textInputAutocapitalization(.never)
                .modifier(TxtFieldModifier())
                .focused($keyboardFocused)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            keyboardFocused = true
                    }
                }
            
            Text("-- Or --")
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundStyle(.gray)
                .padding()
            
            TextField("Unique ID", text: $ID)
                .textInputAutocapitalization(.never)
                .modifier(TxtFieldModifier())
                .focused($keyboardFocused)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            keyboardFocused = true
                    }
                }
            
            Spacer()
            
            Button {
                //login
                Task {
                    await loginRegular()
                    isLoggedIn = true
                }
            } label: {
                StandardBtnLbl(title: "Login", background: btnIsValid() ? .blue : .gray)
                    .padding()
            }
            .disabled(!btnIsValid())
        }
        .navigationTitle("Welcome back!")
    }
    
    //MARK: - Function
    
    private func btnIsValid() -> Bool {
        return !uniqueName.isEmpty && !PIN.isEmpty || !ID.isEmpty
    }
    
    private func loginRegular() async {
        let mail = "\(uniqueName)@gmail.com"
        await AuthServices.shared.loginRegular(withEmail: mail, password: PIN)
    }
    
}

#Preview {
    LoginScreen(isLoggedIn: .constant(false))
}
