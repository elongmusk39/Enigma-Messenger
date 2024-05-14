//
//  TabScreen.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 5/14/24.
//

import SwiftUI

struct MainScreen: View {
    
    var userID: String?
    
    var body: some View {
        if userID == nil {
            NavigationView {
                WelcomeScreen()
            }
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
        }
    }
}
