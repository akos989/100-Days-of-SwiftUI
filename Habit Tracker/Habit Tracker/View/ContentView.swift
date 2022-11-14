//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Morvai Ákos on 2022. 09. 14..
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    @State var isAddViewShowing = false
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(habits.items) { habit in
                    NavigationLink {
                        ItemDetailsView(habit: habit, habits: habits)
                    } label: {
                        HStack(spacing: 5) {
                            Text(habit.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(habit.numberOfCompletions) times")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
                .onDelete(perform: deleteItem)
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAddViewShowing = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddViewShowing) {
                AddView(habits: habits)
            }
        }
    }
    
    func deleteItem(_ indexSet: IndexSet) {
        habits.items.remove(atOffsets: indexSet)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
