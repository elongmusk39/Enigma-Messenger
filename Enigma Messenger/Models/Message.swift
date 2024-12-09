//
//  Message.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 5/14/24.
//

import Foundation

//Hashable is for ForEach
struct Message: Codable, Hashable {
    var text: String
    var senderEmail: String
    var receiverEmail: String
    var encryptedForm: String
    
    static var messExample: Message {
        Message(text: "Hello World", senderEmail: "Joker", receiverEmail: "Batman", encryptedForm: "Encrypted Form")
    }
    
    static var arrExample: [Message] = [
        Message(text: "Hello boys", senderEmail: "arcteryx@gmail.com", receiverEmail: "Batman", encryptedForm: "Encrypted Form"),
        Message(text: "What's up, man", senderEmail: "Joker@gmail.com", receiverEmail: "ahah", encryptedForm: "Encrypted Form"),
        Message(text: "How you doing?", senderEmail: "Joker@gmail.com", receiverEmail: "ahah", encryptedForm: "Encrypted Form"),
        Message(text: "Feel like shit, man...", senderEmail: "arcteryx@gmail.com", receiverEmail: "Batman", encryptedForm: "Encrypted Form"),
        Message(text: "Been through some rough shit", senderEmail: "arcteryx@gmail.com", receiverEmail: "Batman", encryptedForm: "Encrypted Form")
    ]
}
