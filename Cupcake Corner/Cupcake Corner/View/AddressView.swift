//
//  SwiftUIView.swift
//  Cupcake Corner
//
//  Created by Morvai Ákos on 2022. 09. 17..
//

import SwiftUI

struct AddressView: View {    
    @ObservedObject var orderWrapper: OrderWrapper
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderWrapper.order.name)
                TextField("Street adress", text: $orderWrapper.order.streetAddress)
                TextField("City", text: $orderWrapper.order.city)
                TextField("Zip code", text: $orderWrapper.order.zip)
            }
            Section {
                NavigationLink {
                    CheckoutView(orderWrapper: orderWrapper)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(!orderWrapper.order.hasValidAddress)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(orderWrapper: OrderWrapper())
    }
}
