//
//  ScheduleViewModel.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 10.11.21.
//

import Foundation

// Schedule View Model
// Fetches the games from the api schedule
// Can be used to store the games
// Also stores the active games selected for that week
class ScheduleViewModel: ObservableObject {
    @Published var games = [Game]() // all games for the whole season
    @Published var selectedGames = [Game]() // games for selected week
    @Published var seasonWeeks: [Week] = [Week]() // all weeks of the season --- I think @ Published can be removed
    @Published var selectedWeek = Week() // selected week by user
    @Published var fetching = true
    @Published var internetConn = true
    @Published var confTourn = [Game]()
    var gamesToWeek: [Week:[Game]] = [:] // is not gonna change 
    
  
    // get the games from the api
    // needs internet connection
    func fetchSeasonSchedule(conf: Conference) async -> Date{
        fetching = true
        internetConn = true
        do {
            self.games = try await fetchSchedule(conf: conf, start: conf.start, end: conf.end)
            self.fetching = false
        } catch {
            print("Request failed with error: \(error)")
            self.internetConn = false
            self.fetching = false
        }
        
        if games.count > 0 {
            return games[0].trimmedDate
        } else {
            return createDefaultDate()
        }
    }
    
    // METHOD 1 to find the games for the selected Week
    // the user can select a week in each conference
    // find the games that are being played in that week
    // CURRENTLY NOT USED
    func findGamesForWeek() {
        var selectedGames = [Game]()

        for game in games {
            if (game.trimmedDate > selectedWeek.startDate && game.trimmedDate <= selectedWeek.endDate) {
                selectedGames.append(game)
            }
        }
        self.selectedGames = selectedGames
    }
    
    
    // METHOD 2 to find the games for the selected week
    // after fetching all games use a dictionary to sort an array of games to a week
    func sortGamesToWeek() {
        var counter = 0
        
        // normal schedule
        gamesToWeek = [:]
        for week in self.seasonWeeks {
            var gamesInWeek = [Game]()
            while (counter < games.count && self.games[counter].trimmedDate <= week.endDate) {
                gamesInWeek.append(self.games[counter])
                counter = counter + 1;
            }
            gamesToWeek[week] = gamesInWeek
        }
    }
    
    func findSelectedGames() {
        self.selectedGames = gamesToWeek[self.selectedWeek] ?? [Game]()
    }
}


