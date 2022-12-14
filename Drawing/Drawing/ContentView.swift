//
//  ContentView.swift
//  Drawing
//
//  Created by Morvai Ákos on 2022. 09. 07..
//

import SwiftUI

struct Flower: Shape {
    var petalOffset = -20.0
    var petalWidth = 100.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

                // Count from 0 up to pi * 2, moving up pi / 8 each time
                for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
                    // rotate the petal by the current value of our loop
                    let rotation = CGAffineTransform(rotationAngle: number)

                    // move the petal to be at the center of our view
                    let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))

                    // create a path for this petal using our properties plus a fixed Y and height
                    let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))

                    // apply our rotation/position transformation to the petal
                    let rotatedPetal = originalPetal.applying(position)

                    // add it to our main path
                    path.addPath(rotatedPetal)
                }

                // now send the main path back
                return path
    }
}

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY ))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        
        return path
    }
}

struct ContentView: View {
    @State private var petalOffset = -20.0
        @State private var petalWidth = 100.0

        var body: some View {
            Arrow()
                .frame(width: 300, height: 300)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
