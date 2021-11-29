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
        
        VStack {
            if viewModel.internetConn {
                VStack{
                    
                    // present when data is loaded
                    if !viewModel.fetching {
                        // check if conference is seperated into regions
                        if viewModel.teams.count > 0 {
                            VStack{
                                // show header like points conf and overall
                                // except if conference is seperated into regions
                                // then the design is done in standings body itself
                                if (!partedConference(teams: viewModel.teams)) {
                                   StandingsHeader()
                                }
                                StandingsBody(viewModel: viewModel)
                            }
                            .background(Color.white.shadow(radius: 2))
                        } else {
                            NoStandings()
                        }
                    } else {
                        Text("")
                            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight - heightAppBarAndTabView)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
            } else {
                BadConnection()
            }
        }
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

