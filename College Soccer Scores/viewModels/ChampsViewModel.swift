//
//  ChampionshipViewModel.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 20.11.21.
//

import Foundation

class ChampsViewModel: ObservableObject {
    @Published var data: Data?  // all team rankings
    @Published var fetching = true // used in RankingsView to show loading indicator
    // MUST BE SET to true in the beginning otherwise data! fails in other view
   
    func fetchData(url: String) {
        guard let url = URL(string: url) else {return}
        Task{
            do {
                self.data = try await fetchChampionship(url: url)
                self.fetching = false
            } catch {
                print("Request failed with error: \(error)")
                fetching = false
            }
        }
    }
}

// Fetch Champions
@MainActor func fetchChampionship(url: URL) async throws -> Data{
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}
