//
//  DataController.swift
//  Friendface
//
//  Created by Morvai Ákos on 2022. 09. 28..
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Friendface")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load Core Data with error: \(error.localizedDescription)")
            }
        }
    }
}
