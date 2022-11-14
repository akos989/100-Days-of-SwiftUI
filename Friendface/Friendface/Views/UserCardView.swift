//
//  UserCardView.swift
//  Friendface
//
//  Created by Morvai Ákos on 2022. 09. 23..
//

import SwiftUI

struct UserCardView: View {
    let user: CachedUser
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: URL(string: "https://100k-faces.glitch.me/random-image")!) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .border(.primary)
                
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundColor(user.isActive ? .green : .red)
                    .padding(5)
            }
            HStack {
                Text(user.name ?? "Unknown name")
                    .font(.headline)
                    .lineLimit(2)
                Spacer()
                Text("\(user.age)")
                    .font(.headline)
            }
        }
        .frame(width: 100)
    }
}
