//
//  RatingView.swift
//  BookWorm
//
//  Created by Morvai Ákos on 2022. 09. 19..
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number <= rating ? onColor : offColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number <= rating {
            return onImage
        } else {
            return offImage ?? onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
