//
//  ChatScreen.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 10/21/24.
//

import SwiftUI

struct ChatScreen: View {
    
    var chatter: User = User.emptyUser
    
    var body: some View {
        VStack {
            Text("Hello, this is your chat screen with \(chatter.uniqueName).")
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(.black)
                .padding()
        }
        .navigationTitle(chatter.uniqueName)
    }
}

#Preview {
    ChatScreen()
}
