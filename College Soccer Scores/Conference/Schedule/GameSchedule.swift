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
            
            VStack(spacing: 0) {
                
                DateView(date: date)
                    .padding(.horizontal)
                    .padding(.top)
                
                // find every game that matches the date
                ForEach(scheduleModel.selectedGames) { game in
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
}

// Presentation of a single game
struct DateView: View {
    var date: Date
    
    var body: some View {
        HStack {
            let calenderDate = Calendar.current.dateComponents([.weekday, .day, .month], from: date)
            
            VStack(alignment: .leading){
                if let weekday = calenderDate.weekday {
                    Text("\(weekDays[weekday - 1])")
                        .fontWeight(.bold)
                        .font(.system(size: 16.0))
                }
                HStack(){
                    if let day = calenderDate.day, let month = calenderDate.month {
                        Text("\(day). \(monthArray[month - 1])")
                            .font(.system(size: 14.0))
                            .foregroundColor(.gray)
                    }
                }
                Divider()
            }
        }
    }
}
