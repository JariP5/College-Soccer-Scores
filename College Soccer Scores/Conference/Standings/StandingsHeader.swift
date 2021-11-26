//
//  StandingsHeader.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 24.11.21.
//

import SwiftUI

struct StandingsHeader: View {
    var body: some View {
        HStack{
            Text("Points")
                // center is necessary since hstack alignment is set to trailing
                .frame(width: 50)
                .multilineTextAlignment(.center)
            
            Text("Conf")
                // center is necessary since hstack alignment is set to trailing
                .frame(width: 70)
                .multilineTextAlignment(.center)
            
            Text("Overall")
                // center is necessary since hstack alignment is set to trailing
                .frame(width: 70)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal, 10)
        .padding(.top, 20)
    }
}
