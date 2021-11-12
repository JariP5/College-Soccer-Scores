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
    @Published var seasonWeeks: [Week] = [Week]() // all weeks of the season
    @Published var selectedWeek = Week() // selected week by user
    @Published var fetching = false
  
    // get the games from the api
    // needs internet connection
    func fetchData(conf: Conference) {
        fetching = true
        fetchSchedule(conf: conf) { games in
            DispatchQueue.main.async {
                self.games = games
                self.fetching = false
                self.findGamesForWeek()
            }
        }
    }
    
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
}
