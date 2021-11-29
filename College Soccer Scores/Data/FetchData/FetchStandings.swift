//
//  NewFiel.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 30.10.21.
//

import Foundation
import SwiftSoup


// get html content of standings
// all standings html seem to be set up the same way for all conferences
@MainActor func fetchStandings(url: URL) async throws -> [Standing]{
    let (data, _) = try await URLSession.shared.data(from: url)
    let contents = String(data: data, encoding: .ascii)
    let fetchedStandings = try readStandingsHTML(html: contents!)
    return fetchedStandings
}


func readStandingsHTML(html: String) throws -> [Standing] {
    let document = try SwiftSoup.parse(html)
    let teams = try document.select("tbody").first()
    var standings: [Standing] = []
    
    var position = 1 // position in table, html does not include that
    var seperator = -1 // used to indicate that conference is split into regions
    
    if teams != nil {
        // loop over each team
        for team in teams!.children(){
            
            let data = try team.select("td.hide-on-large") // all necessary data are included in the hide-on-large class
            
            // check if more than one hide-on-large classes are exisiting for this team
            // if not it might not be a team, but a region seperating a conference
            if data.count > 1 {
                // set up data for a Standing
                var name = ""
                var confRec = ""
                var overallRec = ""
                var points = 0
                
                // use counter to select correct data in tags
                var counter = 0
                
                // loop over hide-on-large tags
                for dataPoint in data {
                    // first one is the name
                    if (counter == 0) {
                        if (try dataPoint.text() == "") {// only applicable for NEC conference since HTML differs
                            counter = -1
                        }
                        name = try dataPoint.text()
                    // second one is the conference record
                    } else if (counter == 1) {
                        confRec = try dataPoint.text()
                        // calulate points in conference from conference record
                        var array = confRec.components(separatedBy: "-")
                        
                        // confirm that the array only is out of integers
                        // if not set points to 0
                        if (!confirmArrayIsValid(array: array)) {
                            array[0] = "0"
                        }
                        
                        points = Int(array[0])! * 3
                        // check for draws since records can look like 3-2 or 2-0-4 to include 4 draws
                        if array.count > 2 {
                            points += Int(array[2])!
                        }
                        // third one is the overall record
                    } else if (counter == 2) {
                        if (try !dataPoint.text().contains("-")) { // only applicable for NEC conference since HTML differs
                            counter = 1
                        }
                        overallRec = try dataPoint.text()
                    }
                    counter += 1
                }
                // add team to standings array
                standings.append(Standing(name: name, conferenceRecord: confRec, overallRecord: overallRec, points: points, position: position))
                position += 1
            } else {
                // get name of region
                let header = try team.select("th.hide-on-large")
                let headerName = try header.text()
                standings.append(Standing(name: headerName, conferenceRecord: "Conf", overallRecord: "Overall", points: seperator, position: 0))
                position = 1 // reset position to one, since teams a positioned in region
                seperator -= 1 // change seperator value, so the first region can be identified using the standing struct, useful for layout later
            }
        }
    }
    
    return standings
}

// check that only integers and at least one integer is in the array
func confirmArrayIsValid (array: [String]) -> Bool {
    
    if array.isEmpty {
        return false
    }
    
    for data in array {
        if !data.isInt {
            return false
        }
    }
    return true
}

// check if string is convertible to integer
extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}


