//
//  LoadingView.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 5/14/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.black).opacity(0.5)
                .ignoresSafeArea()
            
            ProgressView {
                Text("Loading")
                    .font(.subheadline)
                    .fontWeight(.regular)
            }
            .foregroundStyle(.white)
            .tint(.white) //for spinner
        }
        
    }
}

#Preview {
    LoadingView()
}
