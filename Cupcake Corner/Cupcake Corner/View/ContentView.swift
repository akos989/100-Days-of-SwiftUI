//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Morvai Ákos on 2022. 09. 17..
//

import SwiftUI

struct ContentView: View {
    @StateObject var orderWrapper = OrderWrapper()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select the cake type", selection: $orderWrapper.order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes: \(orderWrapper.order.quantity)", value: $orderWrapper.order.quantity, in: 3...20)
                }
                Section {
                    Toggle("Do you want special orders", isOn: $orderWrapper.order.specialRequest.animation())
                    if orderWrapper.order.specialRequest {
                        Toggle("Add extra frosting", isOn: $orderWrapper.order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $orderWrapper.order.extraSprinkles)
                    }
                }
                Section {
                    NavigationLink {
                        AddressView(orderWrapper: orderWrapper)
                    } label: {
                        Text("Delivery details")
                    }

                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
