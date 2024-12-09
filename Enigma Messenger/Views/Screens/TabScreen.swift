//
//  TabScreen.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 12/8/24.
//

import SwiftUI

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
