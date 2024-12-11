//
//  ChatScreen.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 10/21/24.
//

import SwiftUI

struct ChatScreen: View {
    
    var chatter: User = User.emptyUser
    @State var messageTyped: String = ""
    @State var messageArr: [Message] = Message.arrExample
    
    @FocusState private var keyboardFocused: Bool //keyboard popup
    @State var showAlert: Bool = false
    @State var textE: String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                Text("Your chat is End-to-end encrypted.")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundStyle(.gray)
                    .padding()
                    .padding(.bottom)
                
                if messageArr.count == 0 {
                    Text("New friend? Let's send them a text!")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                        .padding(.all, 32)
                        .padding()
                } else {
                    ForEach(messageArr, id: \.self) { mess in
                        messageBubble(message: mess)
                            .padding(.horizontal)
                            .padding(.top, -2)
                    }
                }
            }
            
            Spacer()
            
            ChatTxtField.padding(.vertical, 8)
        }
        .navigationTitle(chatter.uniqueName)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    //edit
                } label: {
                    Image(systemName: profileImgStr(username: chatter.uniqueName))
                        .imageScale(.large)
                        .foregroundStyle(profileColor(username: chatter.uniqueName))
                }
            }
        }
        .onAppear {
            fetchChat()
        }
        .onChange(of: messageArr, {
            Task {
                await updateUnreadChat(messArr: messageArr)
            }
        })
        .alert("Error!", isPresented: $showAlert) {
            Button("OK", role: .cancel, action: {})
        } message: {
            Text(textE)
        }
    }
    
//MARK: - Function
    
    private func fetchChat() {
        ServiceFetch.shared.fetchChat(userEmail: USER_LOADED.email, chatterName: chatter.uniqueName) { messages in
            self.messageArr = messages
        }
    }
    
    private func updateUnreadChat(messArr: [Message]) async {
        for mess in messArr {
            if mess.status == MessageStatus.unread.status {
                do {
                    try await ServiceUpload.shared.updateAReadMess(userEmail: USER_LOADED.email, message: mess)
                } catch {
                    print("DEBUG: err updating read mess")
                }
            }
        }
    }
    
}

#Preview {
    ChatScreen()
}

//MARK: - ChatTxtField

extension ChatScreen {
    
    var ChatTxtField: some View {
        HStack {
            TextField("Enter your Chat here", text: $messageTyped)
                .textInputAutocapitalization(.never)
                .modifier(TxtFieldModifier())
                .focused($keyboardFocused)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        keyboardFocused = true
                    }
                }
            
            Button {
                print("DEBUG: mess: \(messageTyped)")
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
        let eMess = Encryption.encryptMess(mess: messageTyped)
        let mess = Message(id: "", date: Date.now, encryptedText: eMess, senderName: USER_LOADED.uniqueName, receiverName: chatter.uniqueName, status: "")
        do {
            try await ServiceUpload.shared.uploadMessageFromSender(message: mess, senderE: USER_LOADED.email, receiverE: chatter.email)

            try await ServiceUpload.shared.uploadMessageToReceiver(message: mess, senderE: USER_LOADED.email, receiverE: chatter.email)
            print("DEBUG: SENT message to \(chatter.uniqueName)")
        } catch {
            textE = error.localizedDescription
            showAlert.toggle()
        }
        messageTyped = ""
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
            
            Text(decryptedMessage())
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
        return message.senderName == USER_LOADED.uniqueName
    }
    
    private func decryptedMessage() -> String {
        return Encryption.decryptMess(mess: message.encryptedText)
    }
}
