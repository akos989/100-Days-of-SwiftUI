//
//  AddBookView.swift
//  BookWorm
//
//  Created by Morvai Ákos on 2022. 09. 19..
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State var title = ""
    @State var author = ""
    @State var review = ""
    @State var rating = 3
    @State var genre = "Fantasy"
    
    private var formIsValid: Bool {
        return !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mistery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Book title", text: $title)
                    TextField("Book's author", text: $author)
                    Picker("Book's genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                Section {
                    Button("Submit") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.review = review
                        newBook.genre = genre
                        newBook.rating = Int16(rating)
                        newBook.date = Date()
                        
                        try? moc.save()
                        dismiss()
                    }
                }
                .disabled(!formIsValid)
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
