//
//  FriendfaceApp.swift
//  Friendface
//
//  Created by Morvai Ákos on 2022. 09. 23..
//

import SwiftUI

@main
struct FriendfaceApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
