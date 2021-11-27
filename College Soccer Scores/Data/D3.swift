//
//  D3.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 02.11.21.
//

import Foundation

//let D3Confs = ["AMCC", "American Rivers", "ASC" ,"Atlantic East", "C2C", "CCC", "CCIW", "Centennial", "CSAC", "CUNYAC", "Empire 8", "Great Northeast", "HCAC", "Landmark", "Liberty League", "Little East", "MAC_3", "MASCAC", "MIAC", "MIAA", "MWC", "NAC", "NACC", "NCAC", "NECC", "NESCAC", "NEWMAC", "NJAC", "NWC", "OAC", "ODAC", "PAC", "SAA", "SCAC", "SCIAC", "Skyline", "SLIAC", "SUNYAC", "UAA", "UMAC", "United East", "USA South"]

let startD3 = "08/20/2021"

let D3_Men =   [CUNYAC_M]
let D3_Women = [CUNYAC_W]


let CUNYAC_M = Conference(link: "cunyathletics.com", sport_id: "106", school_id: "0", start: startD3, end: "11/05/2021", standings: "path=msoccer&", name: "CUNYAC", confTournEnd: stringToDate2(dateString: "11/15/2021"), division: .DIII, gender: .men)
let CUNYAC_W = Conference(link: "cunyathletics.com", sport_id: "122", school_id: "0", start: startD3, end: "11/05/2021", standings: "path=wsoccer&", name: "CUNYAC", confTournEnd: stringToDate2(dateString: "11/15/2021"), division: .DIII, gender: .women)
