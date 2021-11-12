//
//  StandingsViewModel.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 10.11.21.
//

import Foundation

class StandingsViewModel: ObservableObject {
  @Published var teams = [Standing]()
  @Published var fetching = false
  
    func fetchData(conf: Conference) {
      fetching = true
      
        let url = "https://" + conf.link + "/standings.aspx?path=msoc"
        fetchStandings(url: url) { standing in
          DispatchQueue.main.async {
              self.teams = standing
              self.fetching = false
          }
      }
  }
}
