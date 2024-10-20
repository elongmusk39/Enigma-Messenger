//
//  AuthServices.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 10/19/24.
//

import Foundation
import FirebaseAuth

struct AuthServices {
    
    static let shared = AuthServices()
    
    @MainActor
    func signUpUser(user: User) async {
        do {
            let email = user.email
            let pw = user.ID
            
            let result = try await Auth.auth().createUser(withEmail: email, password: pw)
            
            print("DEBUG: just done signing up user.")
            
        } catch {
            print("DEBUG: error \(error.localizedDescription)")
        }
    }
    
}
