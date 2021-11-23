//
//  Scraper.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 27.10.21.
//

import Foundation
import SwiftSoup

// use api to get all the games of a conference in an array
// data is in json format
@MainActor func fetchSchedule(conf: Conference, scheduleModel: ScheduleViewModel) async throws -> [Game]{
    
    // change date to the end of the day to include all game on the conf.end date
    let extendedEnd = conf.end + " 23:59:59"
    
    // set up url
    var components = URLComponents()
        components.scheme = "https"
        components.host = conf.link
        components.path = "/services/responsive-calendar.ashx"
        
        // api parameters
        // school_id == 0 means that all schools are included
        components.queryItems = [
            URLQueryItem(name: "start", value: conf.start),
            URLQueryItem(name: "end", value: extendedEnd),
            URLQueryItem(name: "sport_id", value: conf.sport_id),
            URLQueryItem(name: "school_id", value: conf.school_id)
        ]
    
    let url = components.url
    var request = URLRequest(url: url!)
    
    // header fields where found out using the cURL of api request in developer tools in google chrome
    request.allHTTPHeaderFields = [
        "Connection": "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"94\", \"Google Chrome\";v=\"94\", \";Not A Brand\";v=\"99\"",
        "Accept": "application/json, text/javascript, */*; q=0.01",
        "X-Requested-With": "XMLHttpRequest",
        "sec-ch-ua-mobile": "?0",
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36",
        "sec-ch-ua-platform": "\"macOS\"",
        "Sec-Fetch-Site": "same-origin",
        "Sec-Fetch-Mode": "cors",
        "Sec-Fetch-Dest": "empty",
        "Referer": "https://" + conf.link + "/calendar.aspx?path=msoc",
        "Accept-Language": "en-US,en;q=0.9,de;q=0.8"
    ]
    
    let (data, _) = try await URLSession.shared.data(for: request)
    let fetchedGames = try JSONDecoder().decode([Game].self, from: data)
    return fetchedGames
}




