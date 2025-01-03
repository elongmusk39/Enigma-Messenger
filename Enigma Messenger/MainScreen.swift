//
//  TabScreen.swift
//  Enigma Messenger
//
//

import SwiftUI
import FirebaseAuth

struct MainScreen: View {
    
    var userID: String?
    @State var isLoggedIn: Bool = false
    
//    init() {
//        self.isLoggedIn = didLogin()
//    }
    
//-----------------------------------------
    
    var body: some View {
        ZStack {
            if isLoggedIn {
                HomeScreen(isLoggedIn: $isLoggedIn)
            } else {
                WelcomeScreen(isLoggedIn: $isLoggedIn)
            }
        }
        .onAppear {
            isLoggedIn = didLogin()
        }
    }
    
    private func didLogin() -> Bool {
        if let email = Auth.auth().currentUser?.email {
            print("DEBUG: email is \(email)")
            return true
        } else {
            print("DEBUG: no user logged in")
            return false
        }
    }
}

#Preview {
    MainScreen()
}

//MARK: -------------------------------------------
