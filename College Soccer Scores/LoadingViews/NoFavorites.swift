//
//  NoFavorites.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 25.11.21.
//

import SwiftUI

struct NoFavorites: View {
    var body: some View {
        VStack{
            Image(systemName: "xmark")
                .resizable()
                .shadow(radius: 10)
                .scaledToFit()
                .frame(width: 200)
            Text("No selection")
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight - 344)
    }
}

struct NoFavorites_Previews: PreviewProvider {
    static var previews: some View {
        NoFavorites()
    }
}
