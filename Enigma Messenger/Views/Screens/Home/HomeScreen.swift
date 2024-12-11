//
//  HomeScreen.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 5/14/24.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct HomeScreen: View {
    
    @Binding var isLoggedIn: Bool
    @State var showFriendList: Bool = false
    @State var showSetting: Bool = false
    @State var searchText: String = ""
    @State var user: User = User.initUser
    
    @State var converArr: [Conversation] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        if converArr.count == 0 {
                            Text("No conversations yet.")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(.gray)
                                .padding(.vertical, 32)
                                .padding()
                        } else {
                            ForEach(converArr, id: \.self) { conver in
                                NavigationLink {
                                    ChatScreen(chatter: configChatter(conver))
                                } label: {
                                    ConversationCell(conver: conver)
                                }
                                Divider().padding(.horizontal)
                            }
                        }
                    }
                    .padding(.top, 8) //not hug the tabBar
                }
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button {
                            showFriendList.toggle()
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 64, height: 64)
                                    .foregroundStyle(.blue)
                                    .shadow(color: .black, radius: 5, x: 2, y: 2)
                                
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.white)
                            }
                            .padding(.all, 32)
                        }
                    }
                    
                }
            }
            
            .navigationTitle(user.uniqueName)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                //fetch user info
                Task {
                    await fetchUserInfo()
                    fetchConversations()
                }
            }
            .fullScreenCover(isPresented: $showFriendList, content: {
                FriendListScreen(showFriendList: $showFriendList)
            })
            .sheet(isPresented: $showSetting, content: {
                SettingScreen(isLoggedIn: $isLoggedIn, showSetting: $showSetting)
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        //edit
                    } label: {
                        Text("Edit")
                            .font(.subheadline)
                            .fontWeight(.regular)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSetting.toggle()
                    } label: {
                        Image(systemName: "gear")
                            .imageScale(.large)
                            .foregroundStyle(.blue)
                    }
                }
            }
        }
        .searchable(text: $searchText)
    }
    
//MARK: Function -------------------------------------------
    
    private func fetchUserInfo() async {
        user = await AuthServices.shared.loadUserData()
        USER_LOADED = user
        print("DEBUG: current user is \(user)")
    }
    
    private func configChatter(_ conver: Conversation) -> User {
        return User(uniqueName: conver.chatterName, PIN: "", ID: "", email: conver.chatterEmail)
    }
    
    private func fetchConversations() {
        ServiceFetch.shared.fetchConversations(userEmail: user.email) { conversations in
            self.converArr = conversations
        }
    }
    
}

#Preview {
    HomeScreen(isLoggedIn: .constant(true))
}

//MARK: ------------------------------------------------

struct ConversationCell: View {
    
    var messStatusStr: String = "bubble.fill"
    
    @State var conver: Conversation = Conversation.converExp
    
    
    var body: some View {
        HStack {
            Image(systemName: profileImgStr(username: conver.chatterName))
                .resizable()
                .frame(width: 48, height: 48)
                .foregroundStyle(profileColor(username: conver.chatterName))
            
            VStack(alignment: .leading) {
                Text(conver.chatterName)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                HStack {
                    Image(systemName: conver.unread == 0 ? "bubble" : "envelope.badge.fill")
                        .imageScale(.small)
                    Text(conver.unread == 0 ? "All read!" : "Unread")
                        .font(.footnote)
                        .fontWeight(.regular)
                }
                .foregroundStyle(.gray)
            }
            
            Spacer()
            
            if conver.unread != 0 {
                ZStack {
                    Circle()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.blue)
                    Text("\(conver.unread)")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                }
            }
            
            Image(systemName: "chevron.right")
                .imageScale(.medium)
                .foregroundStyle(.gray)
                .padding(.vertical)
        }
        .padding(.horizontal)
        .onAppear {
            fetchUnread()
        }
    }
    
//MARK: - Function
    
    private func fetchUnread() {
        ServiceFetch.shared.fetchUnreadMessOfAConver(userEmail: USER_LOADED.email, chatterName: conver.chatterName) { unreadInt in
            self.conver.unread = unreadInt
            print("DEBUG: Unread is \(unreadInt)")
        }
    }
    
}
