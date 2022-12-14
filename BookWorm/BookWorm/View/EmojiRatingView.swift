//
//  EmojiRatingView.swift
//  BookWorm
//
//  Created by Morvai Ãkos on 2022. 09. 19..
//

import SwiftUI

struct EmojiRatingView: View {
    var rating: Int16
    
    var body: some View {
        switch rating {
            case 1:
                return Text("ð©")
            case 2:
                return Text("ð")
            case 3:
                return Text("ð")
            case 4:
                return Text("ð")
            default:
                return Text("ð¤©")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
