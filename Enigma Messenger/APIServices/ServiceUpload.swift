//
//  ServiceUpload.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 12/9/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class ServiceUpload {
    
    static let shared = ServiceUpload()
    
//MARK: - Function

    func uploadMessageFromSender(message: Message, senderE: String, receiverE: String) async throws {
        var mess = message
        mess.id = generateChatID()
        mess.status = MessageStatus.sent.status
        
        let converSender = Conversation(chatterName: message.receiverName, chatterEmail: receiverE, messageStatus: MessageStatus.sent.status, unread: 0, date: Date.now)
        
        guard let encodedMess = try? Firestore.Encoder().encode(mess) else { return }
        guard let encodedConver = try? Firestore.Encoder().encode(converSender) else { return }
        
        let conRef = DB_USER.document(senderE).collection(DB_PATH_CONVER).document("with \(message.receiverName)")
        try? await conRef.setData(encodedConver)
        try? await conRef.collection(DB_PATH_MESS).document(mess.id).setData(encodedMess)
                
    }
    
    func uploadMessageToReceiver(message: Message, senderE: String, receiverE: String) async throws {
        var mess = message
        mess.id = generateChatID()
        mess.status = MessageStatus.unread.status
        
        let converReceiver = Conversation(chatterName: message.senderName, chatterEmail: senderE, messageStatus: MessageStatus.unread.status, unread: 1, date: Date.now)
        
        guard let encodedMess = try? Firestore.Encoder().encode(mess) else { return }
        guard let encodedConver = try? Firestore.Encoder().encode(converReceiver) else { return }
        
        let conRef = DB_USER.document(receiverE).collection(DB_PATH_CONVER).document("with \(message.senderName)")
        try? await conRef.setData(encodedConver)
        try? await conRef.collection(DB_PATH_MESS).document(mess.id).setData(encodedMess)
                
    }
    
    func updateAReadMess(userEmail: String, message: Message) async throws {
        try? await DB_USER.document(USER_LOADED.email).collection(DB_PATH_CONVER).document("with \(message.senderName)").collection(DB_PATH_MESS).document(message.id).updateData(["status": MessageStatus.read.status])

    }
    
//MARK: --------------------------------------------------
    
    private func generateChatID() -> String {
        let randStr = randomString(length: 9)
        let randInt = Int.random(in: 1..<10000000)
        return "Chat_ID_\(randInt)_\(randStr)_\(randInt)"
    }
    
    private func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" //length = 62
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
