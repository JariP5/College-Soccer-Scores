//
//  StandingsBody.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 24.11.21.
//

import SwiftUI

struct StandingsBody: View {
    @StateObject var viewModel: StandingsViewModel
    var body: some View {
        VStack {
            // loop over teams in conference with their standings data
            ForEach(viewModel.teams, id: \.self) { team in
                
                // team.points == -1 means that it is the first region header
                if (team.points == -1) {
                    StandingsRowView(team: team)
                        .padding(.top, 20)
                        .padding(.bottom, 5)
                    
                // team.points == -1 indicates following region headers
                // to seperate between regions a rectangle is used
                } else if (team.points < -1) {
                    Rectangle()
                        .fill(.bar)
                        .frame(maxWidth: .infinity, idealHeight: 30, maxHeight: 30)
                        .shadow(radius: 2)
                    StandingsRowView(team: team)
                        .padding(.vertical, 5)
                // normal row for a team in the standings
                } else {
                    Divider() // divider between rows
                    StandingsRowView(team: team)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.bottom, 10)
    }
}

