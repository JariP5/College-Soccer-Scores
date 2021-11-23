//
//  ConferenceStandings.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 29.10.21.
//

import Foundation
import SwiftUI

// Present the Standings of the Conference
struct ConferenceStandings: View {
    
    @StateObject var viewModel: StandingsViewModel // store and download data
    var conf: Conference // conference details
    
    var body: some View {
        
        ScrollView {
            VStack{
                // also helps to keep scrollview from collapsing
                Rectangle()
                    .fill(.bar)
                    .frame(maxWidth: .infinity, idealHeight: 20, maxHeight: 20)
                
                // present when data is loaded
                if !viewModel.fetching {
                    // check if conference is seperated into regions
                    if (!partedConference(teams: viewModel.teams)) {
                        HStack{
                            Text("Points")
                                .frame(width: 50)
                                // center is necessary since hstack alignment is set to trailing
                                .multilineTextAlignment(.center)
                            Text("Conf")
                                .frame(width: 70)
                                .multilineTextAlignment(.center)
                            Text("Overall")
                                .frame(width: 70)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.top, 30)
                        .padding(.horizontal, 10)
                    }
                }
                
                // loop over teams in conference with their standings data
                ForEach(viewModel.teams, id: \.self) { team in
                    
                    // team.points == -1 means that it is the first region header
                    if (team.points == -1) {
                        StandingsRowView(team: team)
                            .padding(.top, 30)
                            .padding(.bottom, 5)
                        
                    // team.points == -1 indicates following region headers
                    // to seperate between regions a rectangle is used
                    } else if (team.points < -1) {
                        Rectangle()
                            .fill(.bar)
                            .frame(maxWidth: .infinity, idealHeight: 30, maxHeight: 30)
                        StandingsRowView(team: team)
                            .padding(.vertical, 5)
                    // normal row for a team in the standings
                    } else {
                        Divider() // divider between rows
                        StandingsRowView(team: team)
                    }
                }
                
                // provide some space under the last team in the standings
                // so it can be read better
                if !viewModel.fetching {
                    Rectangle()
                        .fill(.white)
                        .frame(height: 8)
                }
            }
            .background(.white)
        }
        .background(.bar)
        .overlay {
            if viewModel.fetching {
                ProgressView("Fetching data, please wait...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
            }
        }
        .animation(.default, value: viewModel.teams)
        .task {
            // fetch data if conference link is valid and was not loadede before
            if (conf.link != "" && viewModel.teams.count <= 0){
                viewModel.fetchData(link: conf.link, standingsModel: viewModel)
            }
        }
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


// helper method for ConferenceStandings
// Checking if conference is seperated into regions
func partedConference (teams : [Standing]) -> Bool {
    // looping overall "teams"
    // if a team has -1 points it can be concluded that
    // it is header for a region and not a team
    for team in teams {
        if (team.points == -1) {
            return true
        }
    }
    return false
}

