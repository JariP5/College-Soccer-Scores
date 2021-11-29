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

// Present a row in the standings meaning one team
private struct StandingsRowView: View {
    
  var team: Standing
  
  var body: some View {
      
      HStack{
          // display team position
          // if team position not greater than 0 it can be assumed to be a regional header
          if (team.position > 0){
              Text("\(team.position)")
                  .fontWeight(.bold)
                  .frame(width: 20)
          } else {
              Text("")
                  .frame(width: 20)
          }

          // team name
          Text(team.name)
              .frame(maxWidth: .infinity, alignment: .leading)
              .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
              .minimumScaleFactor(0.3)
              .lineLimit(2)
          
          // present team points
          // if points smaller than 0 just present points as a header
          if (team.points >= 0) {
              Text("\(team.points)")
                  .frame(width: 50)
          } else {
              Text("Points")
                  .frame(width: 50)
          }
          
          Text(team.conferenceRecord)
              .frame(width: 70)
          Text(team.overallRecord)
              .frame(width: 70)
      }
      .padding(.vertical, 5)
      .padding(.horizontal, 10)
  }
}
