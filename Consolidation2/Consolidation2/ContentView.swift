//
//  ContentView.swift
//  Consolidation2
//
//  Created by Ákos Morvai on 2022. 08. 22..
//

import SwiftUI

enum Result: String {
    case win, lose
}

enum HandGesture: String, CaseIterable {
    case rock, paper, scissors
}

struct GameImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 80, height: 80)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
    }
}

extension View {
    func titledStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    @State var task: Result = Int.random(in: 0...1) == 0 ? .lose : .win
    
    @State var enemyGesture: HandGesture = .allCases[Int.random(in: 0...2)]
    
    @State var score: Int = 0
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    Text("Enemy gesture:")
                    GameImage(imageName: enemyGesture.rawValue)
                }
                Spacer()
                Spacer()
                VStack {
                    Text("Task:")
                    Text(task.rawValue.capitalized)
                        .font(.title.bold())
                        .foregroundColor(task == .lose ? .red : .green)
                }
                .font(.title)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            
            Spacer()
            
            Text("Choose your move!")
                .font(.title)
            
            VStack(spacing: 30) {
                ForEach(HandGesture.allCases, id: \.self) { gesture in
                    Button {
                        gestureButtonTapped(gesture)
                    } label: {
                        GameImage(imageName: gesture.rawValue)
                    }
                }
            }
            
            Text("Score: \(score)")
                .font(.title)
                .padding()
            Spacer()
        }
    }
    
    func gestureButtonTapped(_ gesture: HandGesture) {
        switch enemyGesture {
            case .rock:
                if task == .win {
                    score += gesture == .paper ? 1 : -1
                } else {
                    score += gesture == .scissors ? 1 : -1
                }
            case .paper:
                if task == .win {
                    score += gesture == .scissors ? 1 : -1
                } else {
                    score += gesture == .rock ? 1 : -1
                }
            case .scissors:
                if task == .win {
                    score += gesture == .rock ? 1 : -1
                } else {
                    score += gesture == .paper ? 1 : -1
                }
        }
        
        newMove()
    }
    
    func newMove() {
        task = Int.random(in: 0...1) == 0 ? .lose : .win
        let allcases = HandGesture.allCases
        enemyGesture = allcases[Int.random(in: 0...2)]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
