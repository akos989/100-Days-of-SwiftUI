//
//  DataController.swift
//  BookWorm
//
//  Created by Morvai Ákos on 2022. 09. 18..
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "BookWorm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load Core Data with error: \(error.localizedDescription)")
            }
        }
    }
}
