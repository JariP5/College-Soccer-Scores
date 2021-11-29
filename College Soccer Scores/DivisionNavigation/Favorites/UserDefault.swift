//
//  UserDefault.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 25.11.21.
//

import Foundation


func save(_ confs: [Conference], _ key: String) {
    let data = confs.map { try? JSONEncoder().encode($0) }
    UserDefaults.standard.set(data, forKey: key)
}

func load(_ key: String) -> [Conference] {
    guard let encodedData = UserDefaults.standard.array(forKey: key) as? [Data] else {
        return []
    }

    return encodedData.map { try! JSONDecoder().decode(Conference.self, from: $0) }
}
