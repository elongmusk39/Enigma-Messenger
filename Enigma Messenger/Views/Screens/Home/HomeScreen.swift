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
    @State var searchText: String = ""
    @State var user: User = User.initUser
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ConversationCell(imgName: "a.circle.fill", messStatusStr: "bubble", messStr: "Received", name: "Alexander", color: .pink)
                    Divider().padding(.horizontal)
                    ConversationCell(imgName: "b.circle.fill", messStatusStr: "paperplane", messStr: "Read", name: "Billy", color: .green)
                    Divider().padding(.horizontal)
                    ConversationCell(imgName: "c.circle.fill", messStatusStr: "paperplane.fill", messStr: "Sent", name: "Cindy", color: .purple)
                    Divider().padding(.horizontal)
                    ConversationCell(imgName: "d.circle.fill", messStatusStr: "paperplane.fill", messStr: "Sent", name: "Dom", color: .brown)
                }
                .padding(.top, 8) //not hug the tabBar
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                //fetch user info
            }
            .fullScreenCover(isPresented: $showFriendList, content: {
                FriendListScreen(showFriendList: $showFriendList)
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        signOut()
                    } label: {
                        Text("Sign Out")
                            .font(.subheadline)
                            .fontWeight(.regular)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showFriendList.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .imageScale(.large)
                            .foregroundStyle(.blue)
                    }
                }
            }
        }
        .searchable(text: $searchText)
    }
    
//MARK: Function -------------------------------------------
    
    private func fetchUserInfo() {
        if let userEmail = Auth.auth().currentUser?.email {
            //fetch
        }
    }
    
    private func signOut() {
        AuthServices.shared.signOut()
        isLoggedIn = false
    }
    
}

#Preview {
    HomeScreen(isLoggedIn: .constant(true))
}

//MARK: ------------------------------------------------

struct ConversationCell: View {
    
    var imgName: String = "a.circle.fill"
    
    var messStatusStr: String = "bubble.fill"
    var messStr: String = "Read"
    
    var name: String = "Larry"
    var color: Color = .blue
    
    var body: some View {
        HStack {
            Image(systemName: imgName)
                .resizable()
                .frame(width: 48, height: 48)
                .foregroundStyle(color)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                HStack {
                    Image(systemName: messStatusStr)
                        .imageScale(.small)
                    Text(messStr)
                        .font(.footnote)
                        .fontWeight(.regular)
                }
                .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .imageScale(.medium)
                .foregroundStyle(.gray)
                .padding(.vertical)
        }
        .padding(.horizontal)
    }
}
