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
            ScrollView {
                
                if confTournModel.internetConn {
                    
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 0)
                    
                    if !confTournModel.fetching {
                        
                        if confTournModel.games.count > 0{
                            VStack {

                                ForEach(datesInWeek(selectedGames: confTournModel.games), id: \.self) { date in
                                    
                                    // header of each group is the date
                                    Text(dateToString2(date: date))
                                        .padding(.top, 30)
                                        .font(.system(size: 25))
                                    
                                    // group games by date
                                    VStack{
                                        // find every game that matches the date
                                        ForEach(confTournModel.games) { game in
                                            if (game.trimmedDate == date) {
                                                GameRowView(game: game, postSeason: true)
                                            }
                                        }
                                    }
                                    .background(Color.white.shadow(radius: 2))
                                }
                            }
                            .padding(.bottom, 20)
                        } else {
                            NoGames(message: errorMessage)
                        }
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
        .background(.bar)
        .frame(maxWidth: .infinity)
    }
}
