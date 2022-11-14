//
//  AddView.swift
//  Habit Tracker
//
//  Created by Morvai Ákos on 2022. 09. 14..
//

import SwiftUI

struct AddView: View {
    @ObservedObject var habits: Habits
    
    @Environment(\.dismiss) var dismiss
    
    @State var name = ""
    @State var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Habit name", text: $name)
                        .cornerRadius(5)
                } header: {
                    Text("Name")
                }
                Section {
                    TextEditor(text: $description)
                        .cornerRadius(5)
                } header: {
                    Text("Description")
                }
            }
            .padding()
            .navigationTitle("Add new habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let newHabitItem = HabitItem(name: name, description: description, numberOfCompletions: 0)
                    habits.items.append(newHabitItem)
                    
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits: Habits())
    }
}
