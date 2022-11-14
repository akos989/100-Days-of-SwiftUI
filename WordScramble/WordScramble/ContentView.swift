//
//  ContentView.swift
//  WordScramble
//
//  Created by Ákos Morvai on 2022. 08. 25..
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var errorShowing = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Text("Score: \(score)")
                    .font(.title2)
                
                Section("Used words") {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .listStyle(.grouped)
            .navigationTitle(rootWord)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: startGame) {
//                    Image(systemName: "refresh")
                        Text("Refresh")
                    }
                }
            }
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $errorShowing) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
        }
//        .navigationViewStyle(.stack)
    }
    
    func startGame() {
        guard let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt"),
              let startWords = try? String(contentsOf: startWordsUrl) else { fatalError("Could not load word file from bundle") }
        
        let allWords = startWords.components(separatedBy: .newlines)
        rootWord = allWords.randomElement() ?? "silkworm"
        withAnimation {
            usedWords = []
            newWord = ""
            score = 0
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 2 else {
            wordError(title: "Too short", message: "Must be longer than 2 letters!")
            return
        }
        
        guard answer != rootWord else {
            wordError(title: "Same as start word", message: "Solutions mustn't be the starting word!")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that from \(rootWord)!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't make up words!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
            score += answer.count
        }
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorMessage = message
        errorTitle = title
        errorShowing = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
