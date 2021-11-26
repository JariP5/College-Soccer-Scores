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
    @Published var internetConn = true
    var url: String
    
    init(_ url: String) {
        self.url = url
    }
  
    func fetchData() {
        fetching = true
        internetConn = true
        guard let url = URL(string: url) else {return}
        Task{
            do {
                self.rankings = try await fetchRankings(url: url)
                self.fetching = false
            } catch {
                print("Request failed with error: \(error)")
                self.fetching = false
                self.internetConn = false
            }
        }
    }
}
