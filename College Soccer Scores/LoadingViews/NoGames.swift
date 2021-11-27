//
//  NoGames.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 24.11.21.
//

import SwiftUI

struct NoGames: View {
    var message: String
    var body: some View {
        Text(message)
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight - heightAppBarAndTabView)
    }
}
