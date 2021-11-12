//
//  CalculateWeeks.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 02.11.21.
//

import Foundation

// HELPER METHODS FOR CONFERENCE SCHEDULE

// get the current week of the year from the day when called
func currentWeek() -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.weekOfYear], from: Date())
    let weekOfTheYear = components.weekOfYear
    return weekOfTheYear!
}

// get the current week of season
func currentWeekOfSeason(weeks: [Week]) -> Week {
    let weekOfTheYear = currentWeek()
    for week in weeks {
        if (week.weekOfTheYear == weekOfTheYear) {
            return week
        }
    }
    return weeks[0]
}


// create an array of weeks starting monday and ending sunday
// all weeks between the starting and ending string passed as arguments
func convertToWeeks (start: String, end: String) -> [Week]{
    
    // covert strings to date objects
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    let startDate = dateFormatter.date(from: start)
    let endDate = dateFormatter.date(from: end)
    
    // initalize empty week array
    var weeks = [Week]()
    
    // get the monday of the first week
    let calendar = Calendar.current
    let components = calendar.dateComponents([.weekday], from: (startDate ?? dateFormatter.date(from: "09/02/2021"))!)
    let dayOfWeek = components.weekday
    var monday = calendar.date(byAdding: .day, value: -dayOfWeek! + 2, to: startDate!) // monday is titled with day 2 since sunday is 1
    
    // keeping track of week of the season
    var counter = 1
    
    // loop over all weeks until end date is reached
    while (monday! < endDate!) {
        // get the sunday of that week
        let sunday = calendar.date(byAdding: .day, value: +6, to: monday!)
        
        // get the week of the year for current week
        // useful to track back later what is the active week of the season from the current date
        let comp = calendar.dateComponents([.weekOfYear], from: monday!)
        let weekOfTheYear = comp.weekOfYear
        
        // add week to the end of array
        weeks.append(Week(startDate: monday!, endDate: sunday!, weekOfSeason: counter, weekOfTheYear: weekOfTheYear!))
        
        // skip seven days ahead to monday of next week
        monday = calendar.date(byAdding: .day, value: 7, to: monday!)
        
        // increase counter for week of season
        counter += 1
    }
    return weeks
}

// find all dates where games are payed from games array
// (basically games that are played in selected week)
func datesInWeek(selectedGames: [Game]) -> [Date]{
    var dates = [Date]() // initalize date array
    for game in selectedGames {
        if (!dates.contains(game.trimmedDate)) { // if date not in array
            dates.append(game.trimmedDate) // add date of game
        }
    }
    return dates
}

// convert date to string of format "MM/dd/yyyy"
func dateToString1 (date: Date) -> String {
    // Create Date Formatter
    let dateFormatter = DateFormatter()
    // Set Date Format
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter.string(from: date)
}

// convert date to string of format "MM/dd/yyyy"
func dateToString2 (date: Date) -> String {
    // Create Date Formatter
    let dateFormatter = DateFormatter()
    // Set Date Format
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
}


