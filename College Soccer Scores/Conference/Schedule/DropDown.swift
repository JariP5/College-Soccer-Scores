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
        
        
        // dropw down menu activated
        if expand {
            VStack() {
                // use scrollview to go thorugh all weeks
                ForEach(Array(scheduleModel.seasonWeeks.enumerated()), id: \.element) { index, week in
                    // Show all weeks of the season with its dates
                    VStack(alignment: .leading, spacing: 0){
                        HStack{
                            Text("Week \(week.weekOfSeason)")
                            Spacer()
                        }
                        DateOfWeekView(start: week.startDate, end: week.endDate)
                    }
                    .padding()
                    .background(scrollTo == index + 1 ? .black.opacity(0.2) : .white)
                    .frame(maxWidth: .infinity)
                    .id(index + 1)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        // minimize drop down again when new week was selected
                        self.expand.toggle()
                        
                        // update the selected week
                        scheduleModel.selectedWeek = week
                        // then find the games for that week
                        scheduleModel.findGamesForWeek()
                        scrollTo = 0 // when new week is selected, scroll up to top
                    }
                }
            }
            
        } else {
            VStack(alignment: .leading, spacing: 0){
                // Top of the drop down menu
                HStack(){
                    // Title to show active week
                    Text("Week \(scheduleModel.selectedWeek.weekOfSeason)")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                    // Switch between arrow up and down depending if the drop down menu is expanded
                    Image(systemName: "chevron.down")
                        .resizable()
                        .frame(width: 13, height: 6)
                        .foregroundColor(.black)
                }
                DateOfWeekView(start: scheduleModel.selectedWeek.startDate, end: scheduleModel.selectedWeek.endDate)
            }
            .padding()
            .contentShape(Rectangle())
            .onTapGesture {
                scrollTo = scheduleModel.selectedWeek.weekOfSeason
                self.expand.toggle() // switch the expand value between false and true
            }
        }
    }
}


// Presentation of a single game
struct DateOfWeekView: View {
    var start: Date
    var end: Date
    
    var body: some View {
        HStack {
            let calenderStart = Calendar.current.dateComponents([.day, .month], from: start)
            let calenderEnd = Calendar.current.dateComponents([.day, .month], from: end)
            
            if let dayStart = calenderStart.day, let monthStart = calenderStart.month, let dayEnd = calenderEnd.day, let monthEnd = calenderEnd.month {

                let subMonthStart = monthArray[monthStart - 1].prefix(3)
                let subMonthEnd = monthArray[monthEnd - 1].prefix(3)
                Text("\(dayStart). \(String(subMonthStart)) - \(dayEnd). \(String(subMonthEnd))")
                    .font(.system(size: 14.0))
                    .foregroundColor(.gray)
            }
        }
    }
}

