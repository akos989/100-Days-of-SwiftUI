//
//  People_PhotosApp.swift
//  People Photos
//
//  Created by Morvai Ákos on 2022. 10. 27..
//

import SwiftUI

@main
struct People_PhotosApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
