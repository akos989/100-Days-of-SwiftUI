//
//  Location.swift
//  Bucket List
//
//  Created by Morvai Ákos on 2022. 10. 17..
//

import MapKit
import Foundation

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    static let example = Location(id: UUID(), name: "Buckinghame Palace", description: "Where Queen Elizabeth lived with her dorgies", latitude: 51.501, longitude: -0.141)
}
