//
//  GameSchedule.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 24.11.21.
//

import SwiftUI

struct GameSchedule: View {
    @ObservedObject var scheduleModel: ScheduleViewModel
    var body: some View {
        // get all dates where games are played in selected week
        // using the helper method datesInWeek
        // loop over all dates
        ForEach(datesInWeek(selectedGames: scheduleModel.selectedGames), id: \.self) { date in
            
            // header of each group is the date
            Text(dateToString2(date: date))
                .padding(.top, 30)
                .font(.system(size: 25))
            
            // group games by date
            VStack{
                // find every game that matches the date
                ForEach(scheduleModel.selectedGames) { game in
                    if (game.trimmedDate == date) {
                        GameRowView(game: game, postSeason: false)
                    }
                }
            }
            .background(Color.white.shadow(radius: 2))
        }
    }
}
