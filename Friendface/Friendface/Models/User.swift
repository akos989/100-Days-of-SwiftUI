//
//  User.swift
//  Friendface
//
//  Created by Morvai Ákos on 2022. 09. 26..
//

import Foundation

struct User: Decodable, Identifiable {
    let id: String
    let name: String
    let age: Int
    let email: String
    let company: String
    let address: String
    let about: String
    let isActive: Bool
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}
