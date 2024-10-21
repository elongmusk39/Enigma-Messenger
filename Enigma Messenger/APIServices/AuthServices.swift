//
//  AuthServices.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 10/19/24.
//

import Foundation
import FirebaseAuth
import Firebase

let DB_USER = Firestore.firestore().collection("users")

struct AuthServices {
    
    static let shared = AuthServices()
    
    @MainActor
    func signUpUser(user: User) async {
        do {
            try await Auth.auth().createUser(withEmail: user.email, password: user.PIN)
            await uploadUserData(user: user)
            print("DEBUG: just done signing up user.")
            
        } catch {
            print("DEBUG: error \(error.localizedDescription)")
        }
    }
    
    
    private func uploadUserData(user: User) async {
        let docData: [String: Any] = [
            "uniqueName": user.uniqueName,
            "PIN": user.email,
            "ID": user.ID,
            "email": user.email
        ]
        try? await Firestore.firestore().collection("users").document(user.ID).setData(docData)
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        print("DEBUG: user just logged out")
    }
    
    //MARK: ----------------------------------------
    
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
