//
//  ConferenceStandings.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 29.10.21.
//

import Foundation
import SwiftUI
import SwiftfulLoadingIndicators

// Present the Standings of the Conference
struct ConferenceStandings: View {
    
    @ObservedObject var viewModel: StandingsViewModel // store and download data
    var conf: Conference // conference details
    
    var body: some View {
        
        ScrollView {
            
            if viewModel.internetConn {
                VStack{
                    
                    // present when data is loaded
                    if !viewModel.fetching {
                        // check if conference is seperated into regions
                        if (!partedConference(teams: viewModel.teams)) {
                           StandingsHeader()
                        }
                        StandingsBody(viewModel: viewModel)
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color.white.shadow(radius: 2))
                .padding(.vertical, 20)
            } else {
                BadConnection()
            }
        }
        .background(.bar)
        .overlay {
            if viewModel.fetching {
                LoadingIndicator(animation: .circleTrim, color: .blue, size: .medium, speed: .normal)
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
struct StandingsRowView: View {
    
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

