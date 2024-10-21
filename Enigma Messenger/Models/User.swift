//
//  User.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 5/14/24.
//

import Foundation

struct User {
    var uniqueName: String
    var PIN: String
    var ID: String
    
    var email: String
    
    static var emptyUser: User = User(uniqueName: "", PIN: "", ID: "", email: "")
    
    static var initUser: User = User(uniqueName: "Elon Musk", PIN: "1234", ID: "1234567890", email: "user1@gmail.com")
    
}
