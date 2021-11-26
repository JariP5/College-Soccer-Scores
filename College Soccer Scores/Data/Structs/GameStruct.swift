//
//  GameStruct.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 10.11.21.
//

import Foundation

// Used to decode the games in the schedule
struct Game: Decodable, Identifiable, Equatable {
    
    var id = UUID()
    let school: schoolStruct?
    let opponent: opponentStruct?
    var result: resultStruct?
    let date: String?
    var trimmedDate: Date
    let result_text: String?
    let tournament: tournamentStruct?
    
    // structs are used to mimic nested jsons
    struct schoolStruct: Decodable, Equatable {
        var title: String?
    }
    struct opponentStruct: Decodable, Equatable {
        var title: String?
    }
    struct resultStruct: Decodable, Equatable {
        var opponent_score: String?
        var team_score: String?
        var postscore_info: String?
    }
    struct tournamentStruct: Decodable, Equatable {
        var title: String?
    }

    // coding keys are necessary to use the init function
    // where hte decoding can be better costumized
    // all coding keys need to be present in the json in the exact same way written
    enum CodingKeys: String, CodingKey {
        case result
        case id
        case school
        case opponent
        case date
        case result_text
        case tournament
    }
    
    // init function is used when "an object of the Game struct" is created
    // json is decoded using the init function in this case
    
    // FUNCTION NEEDS TO BE SAFER FOR NULL VALUEA
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        // school and opponent need to be made optional
        self.school = try values.decodeIfPresent(schoolStruct.self, forKey: .school)
        self.opponent = try values.decodeIfPresent(opponentStruct.self, forKey: .opponent)
        
        // result_text contains either the result or the time the game is going to be played
        self.result_text = try values.decodeIfPresent(String.self, forKey: .result_text)
        self.result = try values.decodeIfPresent(resultStruct.self, forKey: .result)
        self.tournament =  try values.decodeIfPresent(tournamentStruct.self, forKey: .tournament)
        
        // date in from of a string
        self.date = try values.decodeIfPresent(String.self, forKey: .date)
        // create an date object of the string date returned from the json
        self.trimmedDate = stringToDate1(dateString: self.date ?? "2021-09-02T18:00:00")
    }
}
