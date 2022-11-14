//
//  Habits.swift
//  Habit Tracker
//
//  Created by Morvai Ákos on 2022. 09. 14..
//

import Foundation

class Habits: ObservableObject {
    private let userDefaultsHabitItemsKey = "HabitItems"
    
    @Published var items = [HabitItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: userDefaultsHabitItemsKey)
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: userDefaultsHabitItemsKey),
           let decodedItems = try? JSONDecoder().decode([HabitItem].self, from: savedItems) {
            items = decodedItems
        }
//        items = [
//            HabitItem(name: "Driving", description: "Going with a car somewhere", numberOfCompletions: 2),
//            HabitItem(name: "Learing", description: "Going with a car somewhere", numberOfCompletions: 5),
//            HabitItem(name: "Sport", description: "Going with a car somewhere", numberOfCompletions: 99),
//            HabitItem(name: "Something", description: "Going with a car somewhere", numberOfCompletions: 5),
//            HabitItem(name: "Reading", description: "Going with a car somewhere", numberOfCompletions: 14)
//        ]
    }
}
