//
//  Conversation.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 12/9/24.
//

import Foundation

struct Conversation: Hashable, Codable { //for fetching
    
    var chatterName: String
    var chatterEmail: String
    var messageStatus: String
    var unread: Int
    var date: Date
    
    static var converExp: Conversation = Conversation(chatterName: "Bruce Wayne", chatterEmail: "brucewayne@gmail.com", messageStatus: "read", unread: 0, date: Date.now)
    
}
