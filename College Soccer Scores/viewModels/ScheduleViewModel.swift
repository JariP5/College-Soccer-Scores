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
    @Published var fetching = false
    var gamesToWeek: [Week:[Game]] = [:]
    var confTournament = [Game]()
  
    // get the games from the api
    // needs internet connection
    func fetchData(conf: Conference, scheduleModel: ScheduleViewModel) async -> Date{
        fetching = true
        do {
            self.games = try await fetchSchedule(conf: conf, scheduleModel: scheduleModel)
            fetching = false
        } catch {
            print("Request failed with error: \(error)")
            fetching = false
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
        gamesToWeek = [:]
        
        for week in self.seasonWeeks {
            var gamesInWeek = [Game]()
            while (counter < games.count) {
                if (self.games[counter].trimmedDate <= week.endDate) {
                    gamesInWeek.append(games[counter])
                } // else if greater than end date of conference and smaller than date of ncaa start -> add into conference tournament
                counter = counter + 1;
            }
            gamesToWeek[week] = gamesInWeek
        }
    }
    
    func findSelectedGames() {
        self.selectedGames = gamesToWeek[self.selectedWeek] ?? [Game]()
    }
}


