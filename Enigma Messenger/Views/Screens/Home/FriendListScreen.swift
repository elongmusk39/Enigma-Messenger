//
//  FriendListScreen.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 5/14/24.
//

import SwiftUI

struct FriendListScreen: View {
    
    @Binding var showFriendList: Bool
    @State var searchText: String = ""
    @State var userArr: [User] = []
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Suggested friends:")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                }
                .padding()
                
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(userArr, id: \.self) { user in
                            NavigationLink {
                                ChatScreen(chatter: user)
                            } label: {
                                FriendListCell(imgName: "person.circle", name: user.uniqueName, color: .gray)
                            }
                                
                            Divider().padding(.horizontal)
                        }
                    }
                    .padding(.top, 8) //not hug the tabBar
                }
            }
            .navigationTitle("Friend List")
            .navigationBarTitleDisplayMode(.inline)
            .tint(.black)
            .onAppear {
                Task {
                    await fetchAllUsers()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showFriendList.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                            .foregroundStyle(.red)
                    }
                }
            }
        }
        .searchable(text: $searchText)
    }
    
//MARK: Function ----------------------------------
    
    private func fetchAllUsers() async {
        userArr = await ServiceFetch.shared.fetchAllOtherUsers()
    }
    
}

#Preview {
    FriendListScreen(showFriendList: .constant(false))
}

//MARK: -----------------------------------------------

struct FriendListCell: View {
    
    var imgName: String = "a.circle.fill"
    var name: String = "Larry"
    var color: Color = .blue
    
    var body: some View {
        HStack {
            Image(systemName: imgName)
                .resizable()
                .frame(width: 48, height: 48)
                .foregroundStyle(color)
            
            Text(name)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
            
            Spacer()

            Text("Chat")
                .font(.headline)
                .fontWeight(.regular)
                .foregroundStyle(.blue)
            
            Image(systemName: "chevron.right")
                .imageScale(.medium)
                .foregroundStyle(.gray)
                .padding(.vertical)
        }
        .padding(.horizontal)
    }
}
