//
//  ContentView.swift
//  Unit Converter
//
//  Created by Ákos Morvai on 2022. 08. 18..
//

import SwiftUI

enum LengthUnit: String, CaseIterable {
    case centimetre
    case metre
    case kilometre
    case feet
    case yard
    case mile
    
    var toMetreMultiplier: Double {
        switch self {
            case .metre:
                return 1
            case .kilometre:
                return 1000
            case .feet:
                return 0.3048
            case .mile:
                return 1609.34
            case .centimetre:
                return 0.01
            case .yard:
                return 0.9144
        }
    }
    
    func convert(value: Double, to otherUnit: LengthUnit) -> Double {
        return (value * self.toMetreMultiplier) / otherUnit.toMetreMultiplier
    }
}

struct ContentView: View {
    @State var inputValue = 0.0
    @State var inputUnit = LengthUnit.metre
    @State var outputUnit = LengthUnit.kilometre
    @FocusState private var inputValueIsFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input value", value: $inputValue, format: .number)
                        .keyboardType(.numberPad)
                        .focused($inputValueIsFocused)
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(LengthUnit.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                } header: {
                    Text("Input")
                }
                
                Section {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(LengthUnit.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                } header: {
                    Text("Output unit")
                }
                
                Section {
                    Text("Converted value: \(inputUnit.convert(value: inputValue, to: outputUnit))")
                } header: {
                    Text("Output value")
                }
            }
            .navigationTitle("UnitConverter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputValueIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
