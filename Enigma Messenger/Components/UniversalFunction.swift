//
//  UniversalFunction.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 12/10/24.
//

import SwiftUI

func profileImgStr(username: String) -> String {
    var imgStr = ""
    let firstChar = username.first?.lowercased()
    let CharArr = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r","s", "t", "u", "v", "w", "x", "y", "z"]
    for char in CharArr {
        if firstChar == char {
            imgStr = "\(char).circle.fill"
        }
    }
    return imgStr
}

func profileColor(username: String) -> Color {
    var color = Color.red
    let firstChar = username.first?.lowercased()
    
    if firstChar == "a" {
        color = Color.blue
    } else if firstChar == "b" {
        color = Color.red
    } else if firstChar == "b" {
        color = Color.brown
    } else if firstChar == "c" {
        color = Color.green
    } else if firstChar == "d" {
        color = Color.orange
    } else if firstChar == "e" {
        color = Color.yellow
    } else if firstChar == "f" {
        color = Color.gray
    } else if firstChar == "g" {
        color = Color.cyan
    } else if firstChar == "h" {
        color = Color.indigo
    } else if firstChar == "i" {
        color = Color.mint
    } else if firstChar == "j" {
        color = Color.pink
    } else if firstChar == "k" {
        color = Color.purple
    } else if firstChar == "l" {
        color = Color.teal
    } else if firstChar == "m" {
        color = Color.orange
    } else if firstChar == "n" {
        color = Color.teal.opacity(0.7)
    } else if firstChar == "o" {
        color = Color.black.opacity(0.7)
    } else if firstChar == "p" {
        color = Color.red.opacity(0.7)
    } else if firstChar == "q" {
        color = Color.green.opacity(0.7)
    } else if firstChar == "r" {
        color = Color.brown.opacity(0.7)
    } else if firstChar == "s" {
        color = Color.indigo
    } else if firstChar == "t" {
        color = Color.cyan
    } else if firstChar == "u" {
        color = Color.blue.opacity(0.7)
    } else if firstChar == "v" {
        color = Color.red.opacity(0.7)
    } else if firstChar == "w" {
        color = Color.mint.opacity(0.7)
    } else if firstChar == "x" {
        color = Color.indigo.opacity(0.7)
    } else if firstChar == "y" {
        color = Color.brown
    } else if firstChar == "z" {
        color = Color.orange.opacity(0.7)
    }
    
    return color
}
