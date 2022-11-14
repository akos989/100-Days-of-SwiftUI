//
//  ContentView.swift
//  Project2
//
//  Created by Ákos Morvai on 2022. 08. 19..
//

import SwiftUI

struct FlagImage: View {
    var countryName: String
    
    var body: some View {
        Image(countryName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 15)
    }
}

struct Title: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(color)
    }
}

extension View {
    func titledStyle(color: Color) -> some View {
        modifier(Title(color: color))
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var gameRounds = 1
    @State private var showingGameOver = false
    
    @State private var rotationAmount = 0.0
    @State private var scaleAmount = 1.0
    @State private var opacityAmount = 1.0
    @State private var tappedButtonNumber = 0
    @State private var startAnimation = false
    @State private var overlayOpacity = 0.0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack() {
                Spacer()
                
                Text("Guess the Flag")
                    .titledStyle(color: .red)
    
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            tappedButtonNumber = number
//                            withAnimation(.easeInOut(duration: 1)) {
                                rotationAmount += 360
                            scaleAmount = 1.2
//                            }
                            startAnimation.toggle()
                            opacityAmount = 0.25
                            flagTapped(number)
                            overlayOpacity = 0.7
                        } label: {
                            FlagImage(countryName: countries[number])
                        }
                        .scaleEffect(tappedButtonNumber == number ? scaleAmount : 1)
                        .rotation3DEffect(.degrees(tappedButtonNumber == number ? rotationAmount : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(tappedButtonNumber != number ? opacityAmount : 1)
                        .animation(.default, value: startAnimation)
                        .overlay(
                            Color.init(number == correctAnswer ? .green : .red)
                                .opacity(tappedButtonNumber == number ? overlayOpacity : number == correctAnswer ? overlayOpacity : 0)
                                .clipShape(Capsule())
                                .scaleEffect(tappedButtonNumber == number ? scaleAmount : 1)
                        )
                        .animation(
                            .easeInOut(duration: 0.4)
                                .repeatForever(autoreverses: true),
                            value: startAnimation
                        )
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .alert("Game Over", isPresented: $showingGameOver) {
                    Button("Restart", action: resetGame)
                } message: {
                    Text("Your final score is \(score)")
                }
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            score -= 1
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        scaleAmount = 1.0
        rotationAmount = 0.0
        opacityAmount = 1.0
        overlayOpacity = 0.0
        
        gameRounds += 1
        if gameRounds > 8 {
            showingGameOver = true
        } else {
            countries.shuffle()            
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    func resetGame() {
        gameRounds = 0
        score = 0
        
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
