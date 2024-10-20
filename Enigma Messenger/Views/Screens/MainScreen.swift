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
    
    init() {
        self.isLoggedIn = didLogin()
    }
    
//-----------------------------------------
    
    var body: some View {
        if isLoggedIn {
            WelcomeScreen()
        } else {
            TabScreen()
        }
    }
    
    private func didLogin() -> Bool {
        if let userEmail = Auth.auth().currentUser?.email {
            return true
        } else {
            return false
        }
    }
}

#Preview {
    MainScreen()
}

//MARK: -------------------------------------------

struct TabScreen: View {
    
    var body: some View {
        TabView {
            HomeScreen()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            StatusScreen()
                .tabItem {
                    Label("Status", systemImage: "circle.dashed")
                }
            
            SettingScreen()
                .tabItem {
                    Label("Setting", systemImage: "gear")
                }
        }
        .tint(.blue)
    }
}
