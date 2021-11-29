//
//  DropDown.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 24.11.21.
//

import SwiftUI

struct DropDown: View {
    
    @ObservedObject var scheduleModel: ScheduleViewModel
    @State var expand = false
    @Binding var scrollTo: Int
    
    var body: some View {
        VStack(spacing: 0){
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
                .frame(maxWidth: .infinity)

                // Show the dates of the active week
                Text(dateToString1(date: scheduleModel.selectedWeek.startDate) + " - " + dateToString1(date: scheduleModel.selectedWeek.endDate))
        }
        .frame(maxWidth: .infinity) // use full space
        .padding()
        .background(Color.white.shadow(radius: 2))
        
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
                    withAnimation{scrollTo = 0} // when new week is selected, scroll up to top
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
}

