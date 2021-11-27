//
//  D2.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 02.11.21.
//

import Foundation

//let D2Confs = ["CACC", "CC", "CCAA" ,"ECC", "G-MAC", "GAC", "GLIAC", "GLVC", "Great Northwest", "Gulf South", "Lone Star", "MEC", "NE10", "PacWest", "Peach Belt", "PSAC", "RMAC", "SAC", "SSC", "Filler", "Filler"]
let startD2 = "08/20/2021"

let D2_Men =   [SSC_M]
let D2_Women = [SSC_W]

let SSC_M = Conference(link: "sunshinestateconference.com", sport_id: "16", school_id: "0", start: startD2, end: "11/05/2021", standings: "path=msoc", name: "SSC", confTournEnd: stringToDate2(dateString: "11/15/2021"), division: .DII, gender: .men)
let SSC_W = Conference(link: "sunshinestateconference.com", sport_id: "6", school_id: "0", start: startD2, end: "11/05/2021", standings: "path=wsoc", name: "SSC", confTournEnd: stringToDate2(dateString: "11/15/2021"), division: .DII, gender: .women)
