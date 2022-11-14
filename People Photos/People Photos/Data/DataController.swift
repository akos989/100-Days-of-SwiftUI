//
//  File.swift
//  People Photos
//
//  Created by Morvai Ákos on 2022. 10. 27..
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "PeoplePhotoModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load Core Data with error: \(error.localizedDescription)")
            }
        }
    }
}
