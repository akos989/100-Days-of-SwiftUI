//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Ákos Morvai on 2022. 08. 30..
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
