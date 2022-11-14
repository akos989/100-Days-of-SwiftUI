//
//  ContentView.swift
//  iExpense
//
//  Created by Ákos Morvai on 2022. 08. 30..
//

import SwiftUI

struct ExpenseItemBackground: ViewModifier {
    let amount: Double
    
    func body(content: Content) -> some View {
        let color: Color
        switch amount {
            case 0..<10:
                color = .green
            case 10...100:
                color = .yellow
            default:
                color = .red
        }
        
        return content
            .background(color)
    }
}

extension View {
    func expenseItemBackground(amount: Double) -> some View {
        return modifier(ExpenseItemBackground(amount: amount))
    }
}

struct ExpenseItemView: View {
    let item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            Spacer()
            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
        }
        .expenseItemBackground(amount: item.amount)
    }
}

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(expenses.items.filter({ $0.type == "Personal" })) { item in
                        ExpenseItemView(item: item)
                    }
                    .onDelete {
                        removeBusinessItems(at: $0)
                    }
                } header: {
                    Text("Personal expenses")
                }
                
                Section {
                    ForEach(expenses.items.filter({ $0.type == "Business" })) { item in
                        ExpenseItemView(item: item)
                    }
                    .onDelete(perform: removeBusinessItems)
                } header: {
                    Text("Business expenses")
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
                EditButton()
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        let removableIds = expenses.items
            .filter { $0.type == "Personal" }
            .enumerated()
            .filter { (index, _) in
                return offsets.contains(index)
            }
            .map { $1.id }
        
        expenses.items.removeAll { removableIds.contains($0.id) }
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        let removableIds = expenses.items
            .filter { $0.type == "Business" }
            .enumerated()
            .filter { (index, _) in
                return offsets.contains(index)
            }
            .map { $1.id }
        
        expenses.items.removeAll { removableIds.contains($0.id) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
