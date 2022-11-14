//
//  ListLayoutView.swift
//  MoonApp
//
//  Created by Morvai Ákos on 2022. 09. 07..
//

import SwiftUI

struct ListLayoutView: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .padding()

                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(mission.formatterLaunchDate)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.lightBackground)
                    }
                }
            }
            .listRowBackground(Color.darkBackground)
        }
        .listStyle(.plain)
        .listRowSeparatorTint(Color.lightBackground)
    }
}

struct ListLayoutView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        ListLayoutView(astronauts: astronauts, missions: missions)
    }
}
