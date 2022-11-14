//
//  ContentView.swift
//  BetterRest
//
//  Created by Ákos Morvai on 2022. 08. 23..
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmountSelection = 1
    var coffeeAmount: Int {
        return coffeeAmountSelection + 1
    }
    
    var calculatedBedTime: String {
        if let bedTime = calculateBedtime() {
            return bedTime.formatted(date: .omitted, time: .shortened)
        } else {
            return "Error occurred"
        }
    }
    
    @State private var alertTitle = "No data yet"
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
//                VStack(alignment: .leading, spacing: 0) {
//                    Text("When do you want to wake up?")
//                        .font(.headline)
                Section {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } header: {
                    Text("When do you want to wake up?")
                }
//                VStack(alignment: .leading, spacing: 0) {
//                    Text("Desired amount of sleep")
//                        .font(.headline)
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                }
//                VStack(alignment: .leading, spacing: 0) {
//                    Text("Daily coffee intake")
//                        .font(.headline)
                Section {
//                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                    Picker("Number of cups", selection: $coffeeAmountSelection) {
                        ForEach(1..<21) {
                            Text($0 == 1 ? "1 cup" : "\($0) cups")
                        }
                    }
                } header: {
                    Text("Daily coffee intake")
                }
                HStack {
                    Spacer()
                    VStack(alignment: .center, spacing: 15) {
                        Text("Your ideal bedtime is")
                            .font(.headline)
                        Text(calculatedBedTime)
                            .font(.title.bold())
                    }
                    Spacer()
                }
            }
            .navigationTitle("BetterRest")
        }
        .navigationViewStyle(.stack) // in newer versions should use NavigationStack item, as navigationViewStyle is deprecated
    }
    
    func calculateBedtime() -> Date? {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime
//            alertTitle = "Your ideal bedtime is"
//            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
//            alertTitle = "Error"
//            alertMessage = "There was a problem calculating your bedtime."
            return nil
        }
//        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
