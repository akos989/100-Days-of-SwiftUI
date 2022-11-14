//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Morvai Ákos on 2022. 09. 18..
//

import SwiftUI

@main
struct BookWormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
