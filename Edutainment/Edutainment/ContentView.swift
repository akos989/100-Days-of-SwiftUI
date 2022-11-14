//
//  ContentView.swift
//  Edutainment
//
//  Created by Ákos Morvai on 2022. 08. 29..
//

import SwiftUI

struct ContentView: View {
    @State private var maxNumber = 2
    @State private var selectedNumberOfQuestions = 5
    private var numberOfQuestionOptions = [5, 10, 20]
    
    @State private var generatedQuestions = [(Int, Int)]()
    @State private var gameStarted = false
    
    @State private var answer = "0"
    @State private var currentQuestion = (1, 1)
    @State private var currentQuestionNumber = 0
    
    var body: some View {
        NavigationView {
            if !gameStarted {
                Form {
                    Section("Select the maximum number to practice") {
                        Stepper("Questions for up to \(maxNumber)", value: $maxNumber, in: 2...12, step: 1)
                    }
                    Section("Select the number of questions") {
                        Picker("", selection: $selectedNumberOfQuestions) {
                            ForEach(numberOfQuestionOptions, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                        .pickerStyle(.segmented)
                        .labelsHidden()
                    }
                    Button("Play", action: startGame)
                }
                .navigationTitle("Multiplication table")
            } else {
                VStack {
                    Spacer()
                    Spacer()
                    Text("How much is \(currentQuestion.0) x \(currentQuestion.1)?")
                        .font(.title.bold())
                    Spacer()
                    TextField("Answer", text: $answer)
                        .keyboardType(.numberPad)
                    Spacer()
                    Button("Submit", action: onAnswerSubmitted)
                    Spacer()
                    Spacer()
                }
                .onSubmit(onAnswerSubmitted)
                .navigationTitle("\(currentQuestionNumber)/\(selectedNumberOfQuestions)")
            }
        }
    }
    
    
    func startGame() {
        generateQuestions()
        selectNewQuestion()
        gameStarted = true
    }

    private func selectNewQuestion() {
        currentQuestion = generatedQuestions.randomElement() ?? (2, 3)
        if selectedNumberOfQuestions <= generatedQuestions.count {
            generatedQuestions.removeAll { currentQuestion.0 == $0.0 && currentQuestion.1 == $0.1 }
        }
        currentQuestionNumber += 1
    }
    
    func onAnswerSubmitted() {
        print("Question: \(currentQuestion.0) x \(currentQuestion.1) = \(currentQuestion.0 * currentQuestion.1)")
        print("Answer: \(answer) => \(Int(answer) == currentQuestion.0 * currentQuestion.1)")
        
        answer = ""
        
        selectNewQuestion()
    }
    
    private func generateQuestions() {
        for i in 1...maxNumber {
            for j in 1...maxNumber {
                generatedQuestions.append((i, j))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
