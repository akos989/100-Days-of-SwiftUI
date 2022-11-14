//
//  AstronautDetailsView.swift
//  MoonApp
//
//  Created by Ákos Morvai on 2022. 09. 01..
//

import SwiftUI

struct AstronautDetailsView: View {
    let astronaut: Astronaut
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.vertical)
                    
                    Text(astronaut.description)
                        .padding(.horizontal)
                }
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautDetailsView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautDetailsView(astronaut: astronauts.first?.value ?? Astronaut(id: "id", name: "name", description: "description"))
    }
}
