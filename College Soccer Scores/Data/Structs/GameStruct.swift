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
    }
    
    // init function is used when "an object of the Game struct" is created
    // json is decoded using the init function in this case
    
    // FUNCTION NEEDS TO BE SAFER FOR NULL VALUEA
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        // school and opponent need to be made optional
        self.school = try values.decode(schoolStruct.self, forKey: .school)
        self.opponent = try values.decode(opponentStruct.self, forKey: .opponent)
        
        // result_text contains either the result or the time the game is going to be played
        self.result_text = try values.decode(String.self, forKey: .result_text)
        
        self.result = resultStruct(opponent_score: "-", team_score: "-")
        
        if result_text != nil {
            if result_text!.contains("-") {
                // Get the result
                self.result = try values.decode(resultStruct.self, forKey: .result)
            }
        }
        
        
        // date in from of a string
        self.date = try values.decode(String.self, forKey: .date)
        // create an date object of the string date returned from the json
        self.trimmedDate = stringToDate(dateString: self.date ?? "2021-09-02T18:00:00")
    }
}


// Helper Methods
// make the string from the date property of game structure to a Date
// remove time stamp from date of the game
// to be able to group games together if they have the same date

func stringToDate (dateString: String) -> Date {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    let defaultDate = dateFormatter.date(from: "2021-09-02T18:00:00")! // Default Date
    let date = dateFormatter.date(from: dateString) ?? defaultDate
    let trimmedDate = removeTimeStamp(fromDate: date)
    return trimmedDate
}

func removeTimeStamp(fromDate: Date) -> Date {
    guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: fromDate)) else {
        fatalError("Failed to strip time from Date object")
    }
    return date
}
