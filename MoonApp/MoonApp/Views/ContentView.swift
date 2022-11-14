//
//  ContentView.swift
//  MoonApp
//
//  Created by Ákos Morvai on 2022. 09. 01..
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State var showGridView = true
    
    var body: some View {
        NavigationView {
            Group {
                if showGridView {
                    ScrollView {
                        GridLayoutView(astronauts: astronauts, missions: missions)
                            .padding([.horizontal, .bottom])
                    }
                } else {
                    ListLayoutView(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    showGridView.toggle()
                } label: {
                    Text("Show in \(showGridView ? "list" : "grid")")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
