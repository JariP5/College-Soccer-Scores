//
//  RankingsViewModel.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 10.11.21.
//

import Foundation

// class to store and fetch data
// observable to automatically update views when varables change
class RankingsViewModel: ObservableObject {
    @Published var rankings = [Ranking]() // all team rankings
    @Published var fetching = false // used in RankingsView to show loading indicator
  
    func fetchData(url: String) {
        
        fetching = true // fetching is true until all rankings are downloaded
        
        // download the rankings from html
        fetchRankings(url: url) { rankings in
            // waiting until main queue is ready
            // to update variables when fetching was finished
            DispatchQueue.main.async {
                self.rankings = rankings
                self.fetching = false
            }
        }
    }
}
