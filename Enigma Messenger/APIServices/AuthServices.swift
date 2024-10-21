//
//  AuthServices.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 10/19/24.
//

import Foundation
import FirebaseAuth
import Firebase

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
}
