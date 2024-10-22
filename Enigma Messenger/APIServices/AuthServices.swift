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

class AuthServices {
    
    static let shared = AuthServices()
    @Published var currentUser: User? //for fetching user info

    
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
            "PIN": user.PIN,
            "ID": user.ID,
            "email": user.email
        ]
        try? await Firestore.firestore().collection("users").document(user.email).setData(docData)
    }
    
    @MainActor
    func loginRegular(withEmail email: String, password: String) async {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
        } catch {
            print("DEBUG: login error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
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
//            if let name = snapshot.get("uniqueName") as? String,
//               let id = snapshot.get("ID") as? String,
//               let pin = snapshot.get("PIN") as? String {
//                user = User(uniqueName: name, PIN: pin, ID: id, email: userEmail)
//            } else {
//                print("DEBUG: cannot get user data")
//            }
            
            DB_USER.document(userEmail).getDocument { snap, err in
                if let doc = snap {
                    let name = doc.get("uniqueName") as? String
                    print("DEBUG: name is \(name ?? "nil")")
                } else {
                    print("DEBUG: damn")
                }
            }
            
            
        } catch {
            print("DEBUG: err featching user data,  \(error.localizedDescription)")
        }
        return user
    }
    
//    func getUserInfo(getUserID userID: String, handler: @escaping(_ name: String?, _ bio: String?) -> ()) {
//        REF_USERS.document(userID).getDocument { snapshot, error in
//            if let doc = snapshot,
//                let name = doc.get(databaseUserField.displayName) as? String,
//               let bio = doc.get(databaseUserField.bio) as? String {
//                print("DEBUG: success getting user info")
//                handler(name, bio)
//                return
//            } else {
//                print("DEBUG: error fetching user")
//                handler(nil, nil)
//                return
//            }
//        }
//    }
    
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
