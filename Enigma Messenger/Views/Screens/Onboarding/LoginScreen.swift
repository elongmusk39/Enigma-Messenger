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
    @State var showLoading = false
    @State var showAlert = false
    
    var body: some View {
        ZStack {
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
                    Task {
                        showLoading = true
                        try? await Task.sleep(nanoseconds: 0_100_000_000)//delay
                        
                        if ID.isEmpty {
                            await loginRegular()
                        } else {
                            await loginWithID()
                        }
                    }
                } label: {
                    StandardBtnLbl(title: "Login", background: btnIsValid() ? .blue : .gray)
                        .padding()
                }
                .disabled(!btnIsValid())
            }
            
            if showLoading {
                LoadingView()
            }
        }
        .navigationTitle("Welcome back!")
        .alert("Error Login!", isPresented: $showAlert) {
            Button("OK", role: .cancel, action: {})
        } message: {
            Text("There is a problem logging in.")
        }
    }
    
    //MARK: - Function
    
    private func btnIsValid() -> Bool {
        return !uniqueName.isEmpty && !PIN.isEmpty || !ID.isEmpty
    }
    
    private func loginRegular() async {
        let name = uniqueName.replacingOccurrences(of: " ", with: "").lowercased()
        let mail = "\(name)@gmail.com"
        do {
            try await AuthServices.shared.loginRegular(withEmail: mail, password: PIN)
            isLoggedIn = true
        } catch {
            print("DEBUG: err login with Credentials: \(error.localizedDescription)")
            showAlert.toggle()
        }
        showLoading = false
    }
    
    private func loginWithID() async {
        do {
            try await AuthServices.shared.loginWithID(withID: ID)
            isLoggedIn = true
        } catch {
            print("DEBUG: err login ID: \(error.localizedDescription)")
            showAlert.toggle()
        }
        showLoading = false
    }
    
}

#Preview {
    LoginScreen(isLoggedIn: .constant(false))
}
