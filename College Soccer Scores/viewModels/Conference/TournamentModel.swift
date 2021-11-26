//
//  College Soccer Scores
//
//  Created by Jari Polm on 10.11.21.
//

import Foundation

class ConfTournViewModel: ObservableObject {
    @Published var games = [Game]() // all games for the whole season
    @Published var fetching = true
    @Published var internetConn = true
    
  
    func fetchTournament(conf: Conference) async{
        fetching = true
        internetConn = true
        do {
            let confTournStart = addOneDay(stringDate: conf.end)
            self.games = try await fetchSchedule(conf: conf, start: confTournStart, end: dateToString1(date: conf.confTournEnd))
            self.fetching = false
        } catch {
            print("Request failed with error: \(error)")
            self.internetConn = false
            self.fetching = false
        }
    }
}

func addOneDay(stringDate: String) -> String {
    let calendar = Calendar.current
    var date = stringToDate2(dateString: stringDate)
    date = calendar.date(byAdding: .day, value: 1, to: date) ?? createDefaultDate()
    return dateToString1(date: date)
}


