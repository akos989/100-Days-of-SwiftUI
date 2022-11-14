//
//  ContentView.swift
//  People Photos
//
//  Created by Morvai Ákos on 2022. 10. 27..
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var people: FetchedResults<Person>
    
    @State private var isShowingAddSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(people, id: \.self) { person in
                    Text(person.wrappedName)
                }
                .onDelete(perform: onPersonDelete)
            }
            .navigationTitle("People Photos")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingAddSheet = true
//                        var person = Person(context: moc)
//                        person.name = "valami"
//                        person.imageName = "imageName"
//                        try? moc.save()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddSheet) {
                AddView()
            }
        }
    }
    
    func onPersonDelete(at offsets: IndexSet) {
        for offset in offsets {
            let person = people[offset]
            moc.delete(person)
        }
        try? moc.save()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
