//
//  FilteredList.swift
//  BookWorm
//
//  Created by Morvai Ákos on 2022. 09. 22..
//

import CoreData
import SwiftUI

extension NSPredicate {
    convenience init(filterKey: String, filterValue: String, filter: String) {
        self.init(format: "%K \(filter) %@", filterKey, filterValue)
    }
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    let content: (T) -> Content
    
    var body: some View {
        List {
            ForEach(fetchRequest, id: \.self) { item in
                self.content(item)
            }
            .onDelete(perform: deleteItems)
        }
    }
    
    init(compoundPredicate: NSCompoundPredicate, @ViewBuilder content: @escaping (T) -> Content) {
//        let key = "rating"
//        let value = 3
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "rating >= 3"), animation: .default)
        self.content = content
    }
    
    func deleteItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = fetchRequest[offset]
            moc.delete(item)
        }
        try? moc.save()
    }
}
