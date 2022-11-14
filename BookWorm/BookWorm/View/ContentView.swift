//
//  ContentView.swift
//  BookWorm
//
//  Created by Morvai Ákos on 2022. 09. 18..
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: [
//        SortDescriptor(\.title),
//        SortDescriptor(\.author, order: .reverse)
//    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    func createPredicate() -> NSCompoundPredicate {
        let predicate1 = NSPredicate(filterKey: "title", filterValue: "Red", filter: "BEGINSWITH")
        let predicate2 = NSPredicate(filterKey: "rating", filterValue: "3", filter: ">=")
        
        return NSCompoundPredicate(orPredicateWithSubpredicates: [predicate1, predicate2])
    }
    
    var body: some View {
        NavigationView {
            FilteredList(compoundPredicate: createPredicate(), content: { (book: Book) in
                NavigationLink {
                    DetailView(book: book)
                } label: {
                    HStack {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown title")
                                .font(.headline)
                                .foregroundColor(book.rating == 1 ? .red : .primary)
                            Text(book.author ?? "Unknown author")
                                .foregroundColor(.secondary)
                        }
                        if book.rating == 1 {
                            Text("This book sucks!")
                        }
                    }
                }
            })
            
//            List {
//                ForEach(books) { book in
//                    NavigationLink {
//                        DetailView(book: book)
//                    } label: {
//                        HStack {
//                            EmojiRatingView(rating: book.rating)
//                                .font(.largeTitle)
//                            VStack(alignment: .leading) {
//                                Text(book.title ?? "Unknown title")
//                                    .font(.headline)
//                                    .foregroundColor(book.rating == 1 ? .red : .primary)
//                                Text(book.author ?? "Unknown author")
//                                    .foregroundColor(.secondary)
//                            }
//                            if book.rating == 1 {
//                                Text("This book sucks!")
//                            }
//                        }
//                    }
//                }
//                .onDelete(perform: deleteBooks)
//            }
            .navigationTitle("Book Worm")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add book", systemImage: "plus")
                    }
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Filter", systemImage: "slider.vertical.3")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
//    func deleteBooks(at offsets: IndexSet) {
//        for offset in offsets {
//            let book = books[offset]
//            moc.delete(book)
//        }
//        try? moc.save()
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
