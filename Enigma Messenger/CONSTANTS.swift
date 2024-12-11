//
//  CONSTANTS.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 5/14/24.
//

import FirebaseAuth
import FirebaseFirestore

var USER_LOADED: User = User.emptyUser //unversal var
let DB_USER = Firestore.firestore().collection("users")

let DB_PATH_CONVER = "conversations"
let DB_PATH_MESS = "messages"

