//
//  Message.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 5/14/24.
//

import Foundation

//Hashable is for ForEach
struct Message: Codable, Hashable {
    
    var id: String
    var date: Date
    var encryptedText: String
    var senderName: String
    var receiverName: String
    var status: String
    
    static var messExample: Message {
        Message(id: "", date: Date.now, encryptedText: "Hello World", senderName: "Joker", receiverName: "Batman", status: "read")
    }
    
    static var arrExample: [Message] = [
        Message(id: "", date: Date.now, encryptedText: "Hello boys", senderName: "elongmusk39", receiverName: "Batman", status: "read"),
        Message(id: "", date: Date.now, encryptedText: "What's up, man", senderName: "Joker@gmail.com", receiverName: "ahah", status: "read"),
        Message(id: "", date: Date.now, encryptedText: "How you doing?", senderName: "Joker@gmail.com", receiverName: "ahah", status: "read"),
        Message(id: "", date: Date.now, encryptedText: "Feel like shit, man...", senderName: "elongmusk39", receiverName: "as", status: "read"),
        Message(id: "", date: Date.now, encryptedText: "Been through some rough shit", senderName: "arcteryx@gmail.com", receiverName: "Batman", status: "read")
    ]
}

enum MessageStatus {
    case sent
    case seen
    case unread
    case read
    
    var status: String {
        switch self {
        case .sent:
            return "Sent"
        case .seen:
            return "Seen"
        case .unread:
            return "Unread"
        case .read:
            return "Read"
        }
    }
}
