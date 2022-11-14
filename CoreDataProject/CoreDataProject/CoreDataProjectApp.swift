//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Morvai Ákos on 2022. 09. 20..
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .onAppear(perform: asd)
        }
    }
    
    func asd() {
        dataController.container.performBackgroundTask { context in
            let movie = Movie(context: context)
            try? context.save()
        }
    }
}
