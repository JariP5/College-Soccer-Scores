//
//  Structs.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 10.11.21.
//

import Foundation


struct DivisionStruct {
    var rankingURLmen: String // link to the rankings retrieved from unitedsoccercoaches
    var rankingURLwomen: String
    var championshipURLmen: String
    var championshipURLwomen: String
    var name: String
    var men: [Conference] // all conferences in division
    var women: [Conference] // all conferences in division
    var championshipStartMen: String
    var championshipStartWomen: String
}


struct Conference: Equatable, Codable {
    var link: String // for schedule api
    // parameters of api for both genders
    // set a default value since not all conferences have men and women soccer
    var sport_id: String
    var school_id: String
    var start: String
    var end: String
    // for fetching standings
    var standings: String
    var name: String // normal name Example: "SSC"
    var confTournEnd: Date
    var division: DivisionEnum
    var gender: Gender
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

enum Gender: String, CaseIterable, Codable{
    case men = "Men"
    case women = "Women"
}

enum DivisionEnum: String, CaseIterable, Codable {
    case DI = "D1"
    case DII = "D2"
    case DIII = "D3"
}
