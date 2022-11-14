//
//  DetailView.swift
//  BookWorm
//
//  Created by Morvai Ákos on 2022. 09. 19..
//

import SwiftUI

struct DetailView: View {
    var book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(8)
                    .fontWeight(.black)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
            Text(book.date ?? Date(), format: .dateTime)
        }
        .navigationTitle(book.title ?? "Unknown title")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete book", systemImage: "trash")
            }
        }
        .alert("Delete book?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        try? moc.save()
        dismiss()
    }
}
