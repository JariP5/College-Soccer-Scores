//
//  ConferenceChampionship.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 23.11.21.
//

import SwiftUI
import SwiftfulLoadingIndicators

// WHAT IF GAME ENDED IN PENALTIES

struct ConferenceChampionship: View {
    
    @ObservedObject var confTournModel: ConfTournViewModel
    var conf: Conference
    let errorMessage = "Tournament schedule is not out yet."

    var body: some View {
        VStack{
            if confTournModel.internetConn {
                
                // kepp scroll view from collapsing
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 0)
                
                if !confTournModel.fetching {
                    
                    if confTournModel.games.count > 0{
                        VStack {
                            ForEach(datesInWeek(selectedGames: confTournModel.games), id: \.self) { date in
                                VStack(spacing: 0) {
                                    
                                    DateView(date: date)
                                        .padding(.horizontal)
                                        .padding(.top)
                                    
                                    // find every game that matches the date
                                    ForEach(confTournModel.games) { game in
                                        if (game.trimmedDate == date) {
                                            GameRowView(game: game, postSeason: false)
                                                .padding()
                                        }
                                    }
                                }
                                .background(Color.white.shadow(radius: 2))
                                .padding(.top, 30)
                            }
                        }
                        .padding(.bottom, 20)
                    } else {
                        NoGames(message: errorMessage)
                    }
                } else {
                    Text("")
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight - heightAppBarAndTabView)
                }
            } else {
                BadConnection()
            }
        }
        .overlay {
            if confTournModel.fetching {
                LoadingIndicator(animation: .circleTrim, color: .blue, size: .medium, speed: .normal)
            }
        }
        .animation(.default, value: confTournModel.games)
        .task {
            // fetch data if conference link is valid and was not loadede before
            if (conf.link != "" && confTournModel.games.count <= 0){
                await confTournModel.fetchTournament(conf: conf)
            }
        }
    }
}
