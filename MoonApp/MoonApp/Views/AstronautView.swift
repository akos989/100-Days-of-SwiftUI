//
//  AstronautView.swift
//  MoonApp
//
//  Created by Morvai Ákos on 2022. 09. 07..
//

import SwiftUI

struct AstronautView: View {
    let crewMember: MissionView.CrewMember
    
    var body: some View {
        HStack {
            Image(crewMember.astronaut.id)
                .resizable()
                .frame(width: 104, height: 72)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .strokeBorder(.white, lineWidth: 1)
                )
            
            VStack(alignment: .leading) {
                Text(crewMember.astronaut.name)
                    .foregroundColor(.white)
                    .font(.headline)
                Text(crewMember.role)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal)
    }
}
