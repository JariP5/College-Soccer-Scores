//
//  FetchRankings.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 30.10.21.
//

import Foundation
import SwiftSoup

// get the html content of the rankings website to create an object of rankings struct
@MainActor func fetchRankings(url: URL) async throws -> [Ranking]{
    let (data, _) = try await URLSession.shared.data(from: url)
    let contents = String(data: data, encoding: .ascii)
    let fetchedRankings = try readRankingsHTML(html: contents!)
    return fetchedRankings
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



