//
//  Structs.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 10.11.21.
//

import Foundation


struct DivisionStruct {
    var urlString: String // link to the rankings retrieved from unitedsoccercoaches
    var name: String
    var abbreviation: String
    var confs: [Conference] // all conferences in division
}

struct Conference {
    var link: String // for schedule api
    // parameters of api
    var sport_id: String
    var school_id: String
    var start: String
    var end: String
    var standingsURL: String // for standings html
    var name: String
}

struct Ranking: Identifiable, Equatable, Hashable {
    var id = UUID()
    var rank : Int
    var name : String
    var record : String
}

struct Standing: Identifiable, Equatable, Hashable{
    var id = UUID()
    var name: String
    var conferenceRecord: String
    var overallRecord: String
    var points: Int
    var position: Int
}

struct Week: Hashable {
    var startDate: Date = Date()
    var endDate: Date = Date()
    var weekOfSeason: Int = 1
    var weekOfTheYear: Int = 1
}

enum Gender: String, CaseIterable{
    case men = "Men"
    case women = "Women"
}
