//
//  ChatScreen.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 10/21/24.
//

import SwiftUI

struct ChatScreen: View {
    
    var chatter: User = User.emptyUser
    @State var message: String = ""
    @FocusState private var keyboardFocused: Bool //keyboard popup

    @State var messageArr: [Message] = Message.arrExample
    
    var body: some View {
        VStack {
            ScrollView {
                Text("Hello, this is your chat screen with \(chatter.uniqueName).")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundStyle(.black)
                    .padding()
                
                ForEach(messageArr, id: \.self) { mess in
                    messageBubble(message: mess)
                        .padding(.horizontal)
                }
            }
            
            Spacer()
            
            ChatTxtField.padding(.vertical, 8)
        }
        .navigationTitle(chatter.uniqueName)
    }
}

#Preview {
    ChatScreen()
}

extension ChatScreen {
    
    var ChatTxtField: some View {
        HStack {
            TextField("Enter your Chat here", text: $message)
                .textInputAutocapitalization(.never)
                .modifier(TxtFieldModifier())
                .focused($keyboardFocused)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        keyboardFocused = true
                    }
                }
            
            Button {
                print("DEBUG: mess: \(message)")
                Task {
                    await sendMessage()
                }
            } label: {
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.blue)
                    .padding(.trailing)
                    .padding(.leading, -4)
            }
            
        }
    }
    
    //MARK: - Function
    
    private func sendMessage() async {
        
    }
    
}


//MARK: - Message Bubble View -----------------------------

struct messageBubble: View {
    
    var message: Message = Message.messExample
    
    var body: some View {
        HStack {
            
            if weDidSend() {
                Spacer()
            }
            
            Text("\(message.text)")
                .font(.subheadline)
                .fontWeight(.regular)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .foregroundStyle(weDidSend() ? .white : .black)
                .background(weDidSend() ? .blue : .gray.opacity(0.5))
                .clipShape(.capsule)
                
            
            if !weDidSend() {
                Spacer()
            }
        }
    }
    
    private func weDidSend() -> Bool {
        return message.senderEmail == USER_LOADED.email
    }
}
