//
//  Order.swift
//  Cupcake Corner
//
//  Created by Morvai Ákos on 2022. 09. 17..
//

import SwiftUI

struct Order: Codable {
    static let types = ["Vanilla", "Stawbarry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequest = false {
        didSet {
            if !specialRequest {
                extraSprinkles = false
                extraFrosting = false
            }
        }
    }    
    
    var extraSprinkles = false
    var extraFrosting = false
    
    var name = ""
    var city = ""
    var zip = ""
    var streetAddress = ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
           city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
           zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
           streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }
    
    var cost: Double {
        // two dollars per cake
        var cost = Double(quantity) * 2
        // complitated cakes cost more
        cost += (Double(type) / 2) * Double(quantity)
        
        if extraFrosting {
            // 1 dollar per extra frosting
            cost += Double(quantity)
        }
        
        if extraSprinkles {
            // 1 dollar per extra sprinkles
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
