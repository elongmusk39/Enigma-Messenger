//
//  ServiceFetch.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 12/8/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class ServiceFetch {
    
    static let shared = ServiceFetch()
    
//MARK: - Function
    
    func fetchAllOtherUsers() async -> [User] {
        
        var userArr: [User] = []
        let currentUser = USER_LOADED
        
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
    
    func fetchChat(userEmail: String, chatterName: String, completion: @escaping([Message]) -> Void) {
        let ref = DB_USER.document(userEmail).collection(DB_PATH_CONVER).document("with \(chatterName)").collection(DB_PATH_MESS)
        
        //descending=F: last element of arr is most recent
        ref.order(by: "date", descending: false).addSnapshotListener { snapshot, error in
            
            print("DEBUG: fetching chat with \(chatterName)")
            if let e = error?.localizedDescription {
                print("DEBUG: Err fetching chats, \(e)")
                completion([])
                return
            }
            guard let docs = snapshot?.documents else {
                print("DEBUG: Err fetching chat docs")
                completion([])
                return
            }
            let arr = self.getMessFromSnapshot(docArr: docs)
            completion(arr)
        }
    }
    
    private func getMessFromSnapshot(docArr: [QueryDocumentSnapshot]) -> [Message] {
        var arr = [Message]()
        
        for doc in docArr {
            let id = doc.get("id") as? String ?? "nil"
            let date = doc.get("date") as? Date ?? Date.now
            let encryptedText = doc.get("encryptedText") as? String ?? "nil"
            let senderName = doc.get("senderName") as? String ?? "nil"
            let receiverName = doc.get("receiverName") as? String ?? "nil"
            let status = doc.get("status") as? String ?? "nil"
            
            let mess = Message(id: id, date: date, encryptedText: encryptedText, senderName: senderName, receiverName: receiverName, status: status)
            arr.append(mess)
        }
        
        return arr
    }
    
    func fetchConversations(userEmail: String, completion: @escaping([Conversation]) -> Void) {
        let ref = DB_USER.document(userEmail).collection(DB_PATH_CONVER)
        
        //descending=F: last element of arr is most recent
        ref.order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            
            if let e = error?.localizedDescription {
                print("DEBUG: Err fetching conver, \(e)")
                completion([])
                return
            }
            guard let docs = snapshot?.documents else {
                print("DEBUG: Err fetching conver docs")
                completion([])
                return
            }
            let arr = self.getConverFromSnapshot(userEmail: userEmail, docArr: docs)
            completion(arr)
        }
    }
    
    private func getConverFromSnapshot(userEmail: String, docArr: [QueryDocumentSnapshot]) -> [Conversation] {
        var arr = [Conversation]()
        
        for doc in docArr {
            let chatterName = doc.get("chatterName") as? String ?? "nil"
            let date = doc.get("date") as? Date ?? Date.now
            let chatterEmail = doc.get("chatterEmail") as? String ?? "nil"
            let messageStatus = doc.get("messageStatus") as? String ?? "nil"
            var unread = doc.get("unread") as? Int ?? 0
            
            let conv = Conversation(chatterName: chatterName, chatterEmail: chatterEmail, messageStatus: messageStatus, unread: unread, date: date)
            arr.append(conv)
        }
        
        return arr
    }
    
    func fetchUnreadMessOfAConver(userEmail: String, chatterName: String, completion: @escaping(Int) -> Void) {
        let ref = DB_USER.document(userEmail).collection(DB_PATH_CONVER).document("with \(chatterName)").collection(DB_PATH_MESS).whereField("status", isEqualTo: "Unread")
        
        ref.addSnapshotListener { snapshot, error in
            
            if let e = error?.localizedDescription {
                print("DEBUG: Err fetching conver, \(e)")
                completion(0)
                return
            }
            guard let docs = snapshot?.documents else {
                print("DEBUG: Err fetching conver docs")
                completion(0)
                return
            }
            completion(docs.count)
        }
    }
    
}
