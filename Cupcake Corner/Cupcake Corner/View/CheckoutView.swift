//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Morvai Ákos on 2022. 09. 17..
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderWrapper: OrderWrapper
    
    @State var confirmationMessage = ""
    @State var showingConfirmationMessage = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(orderWrapper.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
            
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you", isPresented: $showingConfirmationMessage) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encodedData = try? JSONEncoder().encode(orderWrapper.order) else {
            print("Could not encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encodedData)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x\(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmationMessage = true
        } catch {
            confirmationMessage = "Checkout failed"
            showingConfirmationMessage = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(orderWrapper: OrderWrapper())
    }
}
