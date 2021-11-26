//
//  ConferenceSchedule.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 31.10.21.
//

import SwiftUI
import SwiftfulLoadingIndicators


struct ConferenceSchedule: View {
    
    // create instance of class to hold games after fetching
    // even when view is switched inside of the conference
    @ObservedObject var scheduleModel: ScheduleViewModel
    var conf: Conference // hold the data for the conference passed by calling view
    @State private var scrollTarget = 1
    let errorMessage = "Game schedule is not out yet."
    
    var body: some View {
      VStack{
          // necessary to be able to jump on scroll view
          // to specific id
          ScrollViewReader { reader in
              ScrollView {
                  
                  if scheduleModel.internetConn {
                                                    
                          // Drop Down Menu
                          // Drop Down() should be implemented in another file
                          // but scroll view reader cannot be passed as an argument
                        if !scheduleModel.fetching {
                            if scheduleModel.games.count <= 0 {
                                NoGames(message: errorMessage)
                            } else {
                                VStack{
                                    DropDown(scheduleModel: scheduleModel, scrollTo: $scrollTarget)
                                    GameSchedule(scheduleModel: scheduleModel)
                                }
                                .padding(.vertical, 20)
                                .id(0)
                            }
                              
                        } else {
                            // keep scrollview from collapsing
                            Rectangle()
                                .fill(.bar)
                                .frame(maxWidth: .infinity, maxHeight: 0)
                        } 
                  }
                  else {
                      BadConnection()
                  }
                }
              // Scroll to the desired row when the @State variable changes
              .onChange(of: scrollTarget) { target in
                  scrollTarget = 1
                  withAnimation {
                      reader.scrollTo(target, anchor: .top)
                  }
              }
                .overlay {
                    if scheduleModel.fetching {
                        LoadingIndicator(animation: .circleTrim, color: .blue, size: .medium, speed: .normal)
                    }
                }
                .animation(.default, value: scheduleModel.selectedGames)
                .task {
                    // load content if link is valid and it was not loaded before
                    if (conf.link != "" && scheduleModel.games.count <= 0){
                        let startDate = await scheduleModel.fetchSeasonSchedule(conf: conf) // load game schedule
                        // get all weeks in season, starting on monday ending in sunday
                        scheduleModel.seasonWeeks = convertToWeeks(start: startDate, end: conf.end)
                        // selected week set to current week; if current week is out of season selected week is set to 1
                        scheduleModel.selectedWeek = currentWeekOfSeason(weeks: scheduleModel.seasonWeeks)
                        scheduleModel.sortGamesToWeek()
                        scheduleModel.findSelectedGames()
                    }
                }
            }
        }
        .background(.bar) // total V Stack background
    }
}

// Presentation of a single game
struct GameRowView: View {
    var game: Game
    var postSeason: Bool
    var body: some View {
        
        let resultText = game.result_text ?? "Not Found"
        
        VStack(alignment: .trailing, spacing: 0) {
            if resultText.prefix(2).contains("T") && postSeason && game.result?.postscore_info != nil{
                Text((game.result?.postscore_info)!)
                    .padding(.top, 15)
                    .padding(.horizontal)
            }
            
            HStack{
                // Present both teams divided by horizontal line
                VStack(alignment: .leading){
                    Text(game.opponent?.title ?? "Not Found")
                        .lineLimit(1)
                        .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .minimumScaleFactor(0.5)
                    Divider() // horizontal divider
                    Text(game.school?.title ?? "Not Found")
                        .lineLimit(1)
                        .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .minimumScaleFactor(0.5)
                }
                
                Divider() // vertical divider since embed in HStack
                
                // Check if game was already played or is just scheduled
                if (game.result == nil) {
                    // if game is just scheduled result_text represents scheduled time
                    Text(resultText)
                        .frame(maxWidth: 80)
                        .lineLimit(1)
                        .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .minimumScaleFactor(0.5)
                } else {
                    // Present Results
                    VStack(alignment: .trailing){ // use trailing in vstack to align subviews
                        Text(game.result!.opponent_score ?? "Not Found")
                            .frame(width: 80)
                            .multilineTextAlignment(.center)
                        Divider() // horizontal divider
                        Text(game.result!.team_score ?? "Not Found")
                            .frame(width: 80)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: 80)
                }
            }
            .padding()
        }
    }
}
