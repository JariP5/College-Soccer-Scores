//
//  College_Soccer_ScoresApp.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 08.09.21.
//

import SwiftUI

@main
struct College_Soccer_ScoresApp: App {
    @StateObject var favModel = FavoritesModel(load("MenD1"), load("MenD2"), load("MenD3"), load("WomenD1"), load("WomenD2"), load("WomenD3"))
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(favModel)
        }
    }
}
