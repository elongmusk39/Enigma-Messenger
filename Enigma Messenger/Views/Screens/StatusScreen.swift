//
//  StatusScreen.swift
//  Enigma Messenger
//
//  Created by Long Nguyen on 5/14/24.
//

import SwiftUI

struct StatusScreen: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ] // 3 columns
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    GridItemView(name: "MockUser A", imgName: "a.circle.fill", status: "Active", color: .green, colorImg: .pink)
                    GridItemView(name: "MockUser B", imgName: "b.circle.fill", status: "Active", color: .green, colorImg: .green)
                    GridItemView(name: "MockUser C", imgName: "c.circle.fill", status: "Off", color: .gray, colorImg: .purple)
                    GridItemView(name: "MockUser D", imgName: "d.circle.fill", status: "Deleted", color: .red, colorImg: .brown)
                }
            }
            .padding(.horizontal)
            .navigationTitle("Friends Status")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    StatusScreen()
}

//MARK: --------------------------------------------------

struct GridItemView: View {
    
    var name: String = "haha"
    var imgName: String = "a.circle.fill"
    var status: String = "Active"
    var color: Color = .red
    var colorImg: Color = .pink
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: imgName)
                .resizable()
                .scaledToFit()
                .frame(width: 84, height: 84)
                .foregroundStyle(colorImg)
            
            Text(name)
                .font(.system(size: 16))
                .fontWeight(.medium)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
            
            Text(status)
                .font(.system(size: 16))
                .fontWeight(.medium)
                .foregroundStyle(color)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 0.5)
                .foregroundStyle(Color(.systemGray4))
                .shadow(color: .black.opacity(0.4), radius: 2)
        } //VStack
    }
}
