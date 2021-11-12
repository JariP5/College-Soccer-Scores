//
//  FetchRankings.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 30.10.21.
//

import Foundation
import SwiftSoup

// get the html content of the rankings website to create an object of rankings struct
func fetchRankings(url: String, completionHandler: @escaping ([Ranking]) -> Void) {
    let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching rankings: \(error)")
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
            return
          }

            if let data = data {
                let contents = String(data: data, encoding: .ascii)
                do {
                    let rankings = try readRankingsHTML(html: contents!)
                    completionHandler(rankings)
                } catch {
                    return
                }
            }
        })
        task.resume()
}

func readRankingsHTML(html: String) throws -> [Ranking] {
    let document = try SwiftSoup.parse(html)
    
    // all rankings are inside the only "tbody" tag in the html
    let teams = try document.select("tbody").first()!
    var rankings: [Ranking] = []
    for team in teams.children(){
        
        let rank = try team.select("td.tdRank").text()
        let name = try team.select("td.tdSchool").text()
        let record = try team.select("td.tdRecord").text()
        
        rankings.append(Ranking(rank: Int(rank) ?? -1, name: name, record: record))
    }
    return rankings
}



