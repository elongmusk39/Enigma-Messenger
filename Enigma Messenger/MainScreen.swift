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
                TabScreen(isLoggedIn: $isLoggedIn)
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

struct TabScreen: View {
    
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        TabView {
            HomeScreen(isLoggedIn: $isLoggedIn)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            StatusScreen()
                .tabItem {
                    Label("Status", systemImage: "circle.dashed")
                }
            
            SettingScreen(isLoggedIn: $isLoggedIn)
                .tabItem {
                    Label("Setting", systemImage: "gear")
                }
        }
        .tint(.blue)
    }
}
