//
//  HabitItem.swift
//  Habit Tracker
//
//  Created by Morvai Ákos on 2022. 09. 14..
//

import Foundation

struct HabitItem: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var description: String
    var numberOfCompletions: Int
}
