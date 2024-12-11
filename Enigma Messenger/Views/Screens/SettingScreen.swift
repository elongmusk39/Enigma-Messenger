//
//  SettingScreen.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 5/14/24.
//

import SwiftUI

struct SettingScreen: View {
    
    @Binding var isLoggedIn: Bool
    @Binding var showSetting: Bool
    @State var showAlert: Bool = false
    
    let link = URL(string: "https://www.enigma.com/")!

    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ProfileHeaderView()
                }
                
                Section {
                    HStack(spacing: 8) {
                        Image(systemName: "lock.square")
                            .imageScale(.large)
                        
                        Text("Encryption")
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .imageScale(.medium)
                            .foregroundStyle(.gray)
                    }
                    
                    HStack(spacing: 8) {
                        Image(systemName: "person.crop.square")
                            .imageScale(.large)
                        
                        Text("Friends")
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .imageScale(.medium)
                            .foregroundStyle(.gray)
                    }
                    
                    ShareLink(item: link) {
                        HStack(spacing: 8) {
                            Image(systemName: "arrow.up.right.square")
                                .imageScale(.large)
                            
                            Text("Share Enigma")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundStyle(.black)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .imageScale(.medium)
                                .foregroundStyle(.gray)
                        }
                    }
                    
                }
                
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Logout")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.red)
                        .padding(.all, 6)
                }
                
                Button {
                    
                } label: {
                    Text("Delete Account")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.red)
                        .padding(.all, 6)
                }
            }
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSetting.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                            .foregroundStyle(.red)
                    }
                }
            }
            .alert("Logging out?", isPresented: $showAlert) {
                Button("Logout", role: .destructive, action: {
                    signOut()
                })
                Button("Cancel", role: .cancel, action: {})
            } message: {
                Text("There is a problem logging in.")
            }
        }
        
    }
    
//MARK: Function ------------------------------------------
    
    private func signOut() {
        AuthServices.shared.signOut()
        isLoggedIn = false
    }
}

#Preview {
    SettingScreen(isLoggedIn: .constant(true), showSetting: .constant(false))
}

//MARK: ---------------------------------------------

struct ProfileHeaderView: View {
    
    
    var body: some View {
        HStack {
            Image(systemName: profileImgStr(username: USER_LOADED.uniqueName))
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundStyle(profileColor(username: USER_LOADED.uniqueName))
                .clipShape(.circle)
                .padding()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(USER_LOADED.uniqueName)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundStyle(.black)
                
                Text(USER_LOADED.email)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundStyle(.gray)
                
                Text("CSU Fullerton")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundStyle(.gray)
            }
        }
        
    }
}
