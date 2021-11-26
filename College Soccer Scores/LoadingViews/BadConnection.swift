//
//  BadConnection.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 23.11.21.
//

import SwiftUI

struct BadConnection: View {
    var body: some View {
        VStack{
            Image(systemName: "wifi.slash")
                .resizable()
                .shadow(radius: 10)
                .scaledToFit()
                .frame(width: 200)
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight - 344)
    }
}
