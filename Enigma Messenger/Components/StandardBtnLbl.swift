//
//  StandardButton.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 5/14/24.
//

import SwiftUI

struct StandardBtnLbl: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .frame(width: 360, height: 44)
            .background(Color(.systemBlue))
            .clipShape(.buttonBorder)
    }
}

#Preview {
    StandardBtnLbl(title: "ahha")
}
