//
//  Person+CoreDataProperties.swift
//  People Photos
//
//  Created by Morvai Ákos on 2022. 10. 27..
//
//

import Foundation
import CoreData
import PhotosUI

extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var imageName: String?
    @NSManaged public var name: String?

    public var wrappedName: String {
        name ?? "Unkown name"
    }
}

extension Person : Identifiable {

}
