//
//  ConferenceSchedule.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 31.10.21.
//

import SwiftUI
import SwiftfulLoadingIndicators
import NavigationStack


struct ConferenceSchedule: View {
    
    // create instance of class to hold games after fetching
    // even when view is switched inside of the conference
    @ObservedObject var scheduleModel: ScheduleViewModel
    var conf: Conference // hold the data for the conference passed by calling view
    @Binding var scrollTarget: Int
    let errorMessage = "Game schedule is not out yet."



    
    var body: some View {
        VStack{
            if scheduleModel.internetConn {
                if !scheduleModel.fetching {
                    if scheduleModel.games.count <= 0 {
                        NoGames(message: errorMessage)
                    } else {
                        VStack{
                            DropDown(scheduleModel: scheduleModel, scrollTo: $scrollTarget)
                            GameSchedule(scheduleModel: scheduleModel)
                        }
                        .padding(.vertical, 20)
                    }
                } else {
                    Text("")
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight - heightAppBarAndTabView)
                }
            }
            else {
              BadConnection()
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
                scheduleModel.sortGamesToWeek() // set up dictionary key: week, value: games
                scheduleModel.findSelectedGames() // find games for selected week
            }
        }
    }
}

// Presentation of a single game
struct GameRowView: View {
    
    var game: Game
    var postSeason: Bool
    
    var body: some View {
        
        let resultText = game.result_text ?? "Not Found"
        
        VStack(alignment: .trailing, spacing: 0) {
            
            // in case a game in the conference tournament was decided in penalties
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
