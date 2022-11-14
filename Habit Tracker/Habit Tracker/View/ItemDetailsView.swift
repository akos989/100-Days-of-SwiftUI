//
//  ItemDetailsView.swift
//  Habit Tracker
//
//  Created by Morvai Ákos on 2022. 09. 14..
//

import SwiftUI

struct ItemDetailsView: View {
    @State var habit: HabitItem
    @ObservedObject var habits: Habits
    
    var body: some View {
        VStack {
            Spacer()
            Text(habit.description)
                .font(.headline)
            Spacer()
            Spacer()
            Text("Times of completion: \(habit.numberOfCompletions)")
            Spacer()
            Button("Add to completion") {
                var newHabit = HabitItem(id: habit.id, name: habit.name, description: habit.description, numberOfCompletions: habit.numberOfCompletions + 1)
                let index = habits.items.firstIndex(of: habit)
                if let index = index {
                    habits.items[index] = newHabit
                }
                habit = newHabit
            }
            Spacer()
        }
        .navigationTitle(habit.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ItemDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailsView(habit: HabitItem(name: "Name", description: "Desction on ", numberOfCompletions: 8), habits: Habits())
    }
}
