//
//  TabScreen.swift
//  Enigma Messenger
//
//

import SwiftUI

struct MainScreen: View {
    
    var userID: String?
    @State var showAuthScr: Bool = true
    
    var body: some View {
        if showAuthScr {
            WelcomeScreen(showAuthScr: $showAuthScr)
        } else {
            TabScreen()
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
