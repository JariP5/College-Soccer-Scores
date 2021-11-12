//
//  ConferenceSchedule.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 31.10.21.
//

import Foundation
import SwiftUI


struct ConferenceSchedule: View {
    
    // create instance of class to hold games after fetching
    // even when view is switched inside of the conference
    @StateObject var scheduleModel: ScheduleViewModel
    var conf: Conference // hold the data for the conference passed by calling view
    @State var expand = false // observing if weeks are expanded ore not
    
    var body: some View {
      VStack{
          // necessary to be able to jump on scroll view
          // to specific id
          ScrollViewReader { reader in
              ScrollView {
                  VStack {
                      
                      // Drop Down Menu
                      // Drop Down() should be implemented in another file
                      // but scroll view reader cannot be passed as an argument
                      VStack{
                          // Top of the drop down menu
                          HStack(){
                              // Title to show active week
                              Text("Week \(scheduleModel.selectedWeek.weekOfSeason)")
                                  .fontWeight(.bold)
                                  .foregroundColor(.black)
                              // Switch between arrow up and down depending if the drop down menu is expanded
                              Image(systemName: expand ? "chevron.up" : "chevron.down")
                                  .resizable()
                                  .frame(width: 13, height: 6)
                                  .foregroundColor(.black)
                          }.onTapGesture {
                              self.expand.toggle() // switch the expand value between false and true
                          }
                          // id used to be able to scroll up programmatically
                          // to this specififc point
                          .id(0)
                          
                          // Show the dates of the active week
                          Text(dateToString1(date: scheduleModel.selectedWeek.startDate) + " - " + dateToString1(date: scheduleModel.selectedWeek.endDate))
                        }
                      .frame(maxWidth: .infinity) // use full space
                      
                      // dropw down menu activated
                      if expand {
                          // use scrollview to go thorugh all weeks
                          ForEach(scheduleModel.seasonWeeks, id: \.self) { week in
                              // show each week in form of a button
                              Button(action: {
                                  // minimize drop down again when new week was selected
                                  self.expand.toggle()
                                  
                                  // update the selected week
                                  scheduleModel.selectedWeek = week
                                  // then find the games for that week
                                  scheduleModel.findGamesForWeek()
                                  reader.scrollTo(0, anchor: .top) // move scroll up to the top when new view is selected
                              }) {
                                  // Show all weeks of the season with its dates
                                  VStack{
                                      Text("Week \(week.weekOfSeason)")
                                      Text(dateToString1(date: week.startDate) + " - " + dateToString1(date: week.endDate))
                                  }
                                  .padding()
                              }
                          }
                      }
                  }
                  .background(.bar)
                  
                  // get all dates where games are played in selected week
                  // using the helper method datesInWeek
                  // loop over all dates
                  ForEach(datesInWeek(selectedGames: scheduleModel.selectedGames), id: \.self) { date in
                      // group games by date
                      VStack{
                          
                          // header of each group is the date
                          Text(dateToString2(date: date))
                          
                          // find every game that matches the date
                          ForEach(scheduleModel.selectedGames) { game in
                              if (game.trimmedDate == date) {
                                  ScheduleRowView(game: game)
                              }
                          }
                      }
                      .background(.bar)
                      .padding(.top, 30)
                    }
                }
                // show progress view while loading game schedule
                .overlay {
                    if scheduleModel.fetching {
                        ProgressView("Fetching data, please wait...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                    }
                }
                .animation(.default, value: scheduleModel.selectedGames)
                .task {
                    // load content if link is valid and it was not loaded before
                    if (conf.link != "" && scheduleModel.games.count <= 0){
                        // get all weeks in season, starting on monday ending in sunday
                        scheduleModel.seasonWeeks = convertToWeeks(start: conf.start, end: conf.end)
                        // selected week set to current week; if current week is out of season selected week is set to 1
                        scheduleModel.selectedWeek = currentWeekOfSeason(weeks: scheduleModel.seasonWeeks)
                        scheduleModel.fetchData(conf: conf) // load game schedule
                    }
                }
            }
        }
    }
}

// Presentation of a single game
private struct ScheduleRowView: View {
    var game: Game
    var body: some View {
        HStack{
            // Present both teams divided by horizontal line
            VStack(alignment: .leading){
                Text(game.opponent.title)
                    .lineLimit(1)
                    .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(0.5)
                Divider() // horizontal divider
                Text(game.school.title)
                    .lineLimit(1)
                    .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(0.5)
            }
            
            Divider() // vertical divider since embed in HStack
            
            // Check if game was already played or is just scheduled
            if (game.result.opponent_score == "-" && game.result.team_score == "-") {
                // if game is just scheduled result_text represents scheduled time
                Text(game.result_text)
                    .frame(maxWidth: 80)
                    .lineLimit(1)
                    .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(0.5)
            } else {
                // Present Results
                VStack(alignment: .trailing){ // use trailing in vstack to align subviews
                    Text(game.result.opponent_score ?? "?")
                        .frame(width: 80)
                        .multilineTextAlignment(.center)
                    Divider() // horizontal divider
                    Text(game.result.team_score ?? "?")
                        .frame(width: 80)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: 80)
            }
        }
        .padding()
    }
}








