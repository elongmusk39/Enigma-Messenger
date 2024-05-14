//
//  TxtModifier.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 5/14/24.
//

import SwiftUI

struct TxtFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .clipShape(.buttonBorder)
            .padding(.horizontal)
    }
}
