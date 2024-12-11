//
//  AuthServices.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 10/19/24.
//

import Foundation
import FirebaseAuth
import Firebase

class AuthServices {
    
    static let shared = AuthServices()
    @Published var currentUser: User? //for fetching user info
    
//MARK: - Function
    
    @MainActor
    func signUpUser(user: User) async {
        do {
            var userPassed = user
            userPassed.email = user.email.replacingOccurrences(of: " ", with: "")
            try await Auth.auth().createUser(withEmail: userPassed.email, password: userPassed.PIN)
            await uploadUserData(user: userPassed)
            print("DEBUG: just done signing up user.")
            
        } catch {
            print("DEBUG: error \(error.localizedDescription), mail \(user.email)")
            
        }
    }
    
    private func uploadUserData(user: User) async {
        let docData: [String: Any] = [
            "uniqueName": user.uniqueName,
            "PIN": user.PIN,
            "ID": user.ID,
            "email": user.email
        ]
        try? await Firestore.firestore().collection("users").document(user.email).setData(docData)
    }
    
    @MainActor
    func loginRegular(withEmail email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
//        do {
//            try await Auth.auth().signIn(withEmail: email, password: password)
//        } catch {
//            print("DEBUG: login error \(error.localizedDescription)")
//        }
    }
    
    @MainActor
    func loginWithID(withID ID: String) async throws {
        let user = await fetchUserInfoByID(ID: ID)
        try await loginRegular(withEmail: user.email, password: user.PIN)
    }
    
    private func fetchUserInfoByID(ID: String) async -> User {
        var user = User.emptyUser
        do {
            let queryArr = try await DB_USER.whereField("ID", isEqualTo: ID).getDocuments()
            for doc in queryArr.documents { //only 1 item
                if let name = doc.get("uniqueName") as? String,
                   let email = doc.get("email") as? String,
                   let pin = doc.get("PIN") as? String {
                    user = User(uniqueName: name, PIN: pin, ID: ID, email: email)
                } else {
                    print("DEBUG: cannot get user ID")
                }
            }
            
        } catch {
            print("DEBUG: err featching user data,  \(error.localizedDescription)")
        }
        
        return user
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        USER_LOADED = User.emptyUser
        print("DEBUG: user just logged out")
    }
    
//MARK: ----------------------------------------
    
    @MainActor //main thread, as all auth service should be
    func loadUserData() async -> User {
        var user = User.emptyUser
        guard let userEmail = Auth.auth().currentUser?.email else {
            print("DEBUG: error finding userEmail")
            return user
        }
        
        do {
            let snapshot = try await DB_USER.document(userEmail).getDocument()
            if let name = snapshot.get("uniqueName") as? String,
               let id = snapshot.get("ID") as? String,
               let pin = snapshot.get("PIN") as? String {
                user = User(uniqueName: name, PIN: pin, ID: id, email: userEmail)
            } else {
                print("DEBUG: cannot get user data")
            }
        } catch {
            print("DEBUG: err featching user data,  \(error.localizedDescription)")
        }
        return user
    }
    
    
    func didFindDuplName(uniqueName: String) async -> Bool {
        var result = false
        do {
            let query = try await DB_USER.whereField("uniqueName", isEqualTo: uniqueName).getDocuments()
            result = query.count != 0
        } catch {
            print("DEBUG: err AuthServices \(error.localizedDescription)")
        }
        
        return result
    }
    
}
