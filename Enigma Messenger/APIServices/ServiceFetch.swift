//
//  ServiceFetch.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 12/8/24.
//

import Foundation

class ServiceFetch {
    
    static let shared = ServiceFetch()
    
//MARK: - Function
    
    func fetchAllOtherUsers() async -> [User] {
        
        var userArr: [User] = []
        var currentUser = USER_LOADED
        
        do {
            let queryArr = try await DB_USER.getDocuments()
            for doc in queryArr.documents {
                if let name = doc.get("uniqueName") as? String,
                   let id = doc.get("ID") as? String,
                   let email = doc.get("email") as? String,
                   let pin = doc.get("PIN") as? String {
                    if currentUser.ID != id {
                        userArr.append(User(uniqueName: name, PIN: pin, ID: id, email: email))
                    }
                } else {
                    print("DEBUG: cannot get user ID")
                }
            }
            
        } catch {
            print("DEBUG: err featching user data,  \(error.localizedDescription)")
        }
        
        return userArr
    }
}
