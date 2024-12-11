//
//  Encryption.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 12/9/24.
//

import Foundation

struct Encryption {
    
    static func encryptMess(mess: String) -> String {
        var eMessage = ""
        for char in mess {
            eMessage += Encrypted(char: char)
        }
        return eMessage
    }
    
    static func decryptMess(mess: String) -> String { //same as encryption
        var eMessage = ""
        for char in mess {
            eMessage += Encrypted(char: char)
        }
        return eMessage
    }
    
    private static func Encrypted(char: Character) -> String {
        if char == "a" {
            return "z"
        } else if char == "A" {
            return "Z"
        } else if char == "b" {
            return "y"
        } else if char == "B" {
            return "Y"
        } else if char == "c" {
            return "x"
        } else if char == "C" {
            return "X"
        } else if char == "d" {
            return "w"
        } else if char == "D" {
            return "W"
        } else if char == "e" {
            return "v"
        }else if char == "E" {
            return "V"
        } else if char == "f" {
            return "u"
        } else if char == "F" {
            return "U"
        } else if char == "g" {
            return "t"
        } else if char == "G" {
            return "T"
        } else if char == "h" {
            return "s"
        } else if char == "H" {
            return "S"
        } else if char == "i" {
            return "r"
        } else if char == "I" {
            return "R"
        }else if char == "j" {
            return "q"
        } else if char == "J" {
            return "Q"
        } else if char == "k" {
            return "p"
        } else if char == "K" {
            return "P"
        } else if char == "l" {
            return "o"
        } else if char == "L" {
            return "O"
        } else if char == "m" {
            return "n"
        } else if char == "M" {
            return "N"
        } else if char == "n" {
            return "m"
        } else if char == "N" {
            return "M"
        }else if char == "o" {
            return "l"
        } else if char == "O" {
            return "L"
        } else if char == "p" {
            return "k"
        } else if char == "P" {
            return "K"
        } else if char == "q" {
            return "j"
        } else if char == "Q" {
            return "J"
        } else if char == "r" {
            return "i"
        } else if char == "R" {
            return "I"
        } else if char == "s" {
            return "h"
        }else if char == "S" {
            return "H"
        } else if char == "t" {
            return "g"
        } else if char == "T" {
            return "G"
        } else if char == "u" {
            return "f"
        } else if char == "U" {
            return "F"
        } else if char == "v" {
            return "e"
        } else if char == "V" {
            return "E"
        } else if char == "w" {
            return "d"
        } else if char == "W" {
            return "D"
        } else if char == "x" {
            return "c"
        } else if char == "X" {
            return "C"
        } else if char == "y" {
            return "b"
        } else if char == "Y" {
            return "B"
        } else if char == "z" {
            return "a"
        } else if char == "Z" {
            return "A"
        } else {
            return "\(char)"
        }
    }
}

