//
//  Divisions.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 02.11.21.
//

import Foundation

let startD1 = "08/01/2021"

let D1_Men =   [AAC_M, ACC_M, AmEast_M, Atlantic10_M, BigEast_M, BigSouth_M, BigTen_M, BigWest_M, C_USA_M, CAA_M, Horizon_M, IvyLeague_M, MAAC_M, MAC_1_M, MVC_M, NEC_M, Patriot_M, SoCon_M, SummitLeague_M, WCC_M]
let D1_Women = [AAC_W, ACC_W, AmEast_W, Atlantic10_W, Big12, BigEast_W, BigSky, BigSouth_W, BigTen_W, BigWest_W, C_USA_W, CAA_W, Horizon_W, IvyLeague_W, MAAC_W, MAC_1_W, MVC_W, MountainWest, NEC_W, OhioValley, Patriot_W, SoCon_W, Southland, Southwestern, SummitLeague_W, SunBelt, WCC_W]

// Differentiate between mens and womens divisions because incuding different conferences
let AAC_M = Conference(link: "theamerican.org", sport_id: "10", school_id: "0", start: startD1, end: "11/05/2021", standings: "standings=81", name: "AAC", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let AAC_W = Conference(link: "theamerican.org", sport_id: "11", school_id: "0", start: startD1, end: "10/29/2021", standings: "standings=79", name: "AAC", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let ACC_M = Conference(link: "theacc.com", sport_id: "11", school_id: "0", start: "08/01/2021", end: "11/03/2021", standings: "path=msoc", name: "ACC", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let ACC_W = Conference(link: "theacc.com", sport_id: "23", school_id: "0", start: "08/19/2021", end: "10/29/2021", standings: "path=wsoc", name: "ACC", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let AmEast_M = Conference(link: "americaeast.com", sport_id: "7", school_id: "0", start: startD1, end: "11/07/2021", standings: "path=msoc", name: "American East", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let AmEast_W = Conference(link: "americaeast.com", sport_id: "13", school_id: "0", start: startD1, end: "10/29/2021", standings: "path=wsoc", name: "American East", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

// ASUN cannot be used with API

let Atlantic10_M = Conference(link: "atlantic10.com", sport_id: "7", school_id: "0", start: startD1, end: "11/18/2021", standings: "path=msoc", name: "Atlantic 10", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let Atlantic10_W = Conference(link: "atlantic10.com", sport_id: "16", school_id: "0", start: startD1, end: "11/20/2021", standings: "path=wsoc", name: "Atlantic 10", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let BigEast_M = Conference(link: "www.bigeast.com", sport_id: "9", school_id: "0", start: startD1, end: "11/05/2021", standings: "path=msoc", name: "Big East", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let BigEast_W = Conference(link: "www.bigeast.com", sport_id: "19", school_id: "0", start: startD1, end: "10/28/2021", standings: "path=wsoc", name: "Big East", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)


let BigSouth_M = Conference(link: "bigsouthsports.com", sport_id: "8", school_id: "0", start: startD1, end: "11/06/2021", standings: "path=msoc", name: "Big South", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let BigSouth_W = Conference(link: "bigsouthsports.com", sport_id: "14", school_id: "0", start: startD1, end: "10/28/2021", standings: "path=wsoc", name: "Big South", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let BigTen_M = Conference(link: "bigten.org", sport_id: "12", school_id: "0", start: startD1, end: "11/05/2021", standings: "path=msoc", name: "Big Ten", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let BigTen_W = Conference(link: "bigten.org", sport_id: "23", school_id: "0", start: startD1, end: "10/28/2021", standings: "path=wsoc", name: "Big Ten", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let BigWest_M = Conference(link: "bigwest.org", sport_id: "6", school_id: "0", start: startD1, end: "11/01/2021", standings: "path=msoc", name: "Big West", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let BigWest_W = Conference(link: "bigwest.org", sport_id: "14", school_id: "0", start: startD1, end: "11/01/2021", standings: "path=wsoc", name: "Big West", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let C_USA_M = Conference(link: "conferenceusa.com", sport_id: "7", school_id: "0", start: startD1, end: "11/01/2021", standings: "standings=109", name: "C-USA", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let C_USA_W = Conference(link: "conferenceusa.com", sport_id: "14", school_id: "0", start: startD1, end: "11/01/2021", standings: "standings=110", name: "C-USA", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let CAA_M = Conference(link: "caasports.com", sport_id: "8", school_id: "0", start: startD1, end: "11/01/2021", standings: "path=msoc", name: "CAA", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let CAA_W = Conference(link: "caasports.com", sport_id: "16", school_id: "0", start: startD1, end: "11/01/2021", standings: "path=wsoc", name: "CAA", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let Horizon_M = Conference(link: "horizonleague.org", sport_id: "6", school_id: "0", start: startD1, end: "11/03/2021", standings: "standings=65", name: "Horizon", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let Horizon_W = Conference(link: "horizonleague.org", sport_id: "14", school_id: "0", start: startD1, end: "11/03/2021", standings: "standings=64", name: "Horizon", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let IvyLeague_M = Conference(link: "ivyleague.com", sport_id: "13", school_id: "0", start: startD1, end: "08/03/2021", standings: "path=msoc", name: "Ivy League", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let IvyLeague_W = Conference(link: "ivyleague.com", sport_id: "27", school_id: "0", start: startD1, end: "10/28/2021", standings: "path=wsoc", name: "Ivy League", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let MAAC_M = Conference(link: "maacsports.com", sport_id: "8", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=msoc", name: "MAAC", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let MAAC_W = Conference(link: "maacsports.com", sport_id: "18", school_id: "0", start: startD1, end: "10/27/2021", standings: "path=wsoc", name: "MAAC", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let MAC_1_M = Conference(link: "getsomemaction.com", sport_id: "7", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=msoc", name: "MAC_1", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let MAC_1_W = Conference(link: "getsomemaction.com", sport_id: "14", school_id: "0", start: startD1, end: "10/28/2021", standings: "path=wsoc", name: "MAC_1", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let MVC_M = Conference(link: "mvc-sports.com", sport_id: "6", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=msoc", name: "MVC", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let MVC_W = Conference(link: "mvc-sports.com", sport_id: "12", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=wsoc", name: "MVC", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let NEC_M = Conference(link: "northeastconference.org", sport_id: "247", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=msoc", name: "NEC", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let NEC_W = Conference(link: "northeastconference.org", sport_id: "251", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=wsoc", name: "NEC", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

// PAC 12 uses a different API

let Patriot_M = Conference(link: "patriotleague.org", sport_id: "9", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=msoc", name: "Patriot", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let Patriot_W = Conference(link: "patriotleague.org", sport_id: "19", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=wsoc", name: "Patriot", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let SoCon_M = Conference(link: "soconsports.com", sport_id: "10", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=msoc", name: "SoCon", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let SoCon_W = Conference(link: "soconsports.com", sport_id: "19", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=wsoc", name: "SoCon", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let SummitLeague_M = Conference(link: "thesummitleague.org", sport_id: "6", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=msoc", name: "Summit League", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let SummitLeague_W = Conference(link: "thesummitleague.org", sport_id: "14", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=wsoc", name: "Summit League", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

// WAC cannot be used with API

let WCC_M = Conference(link: "wccsports.com", sport_id: "7", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=msoc", name: "WCC", confTournEnd: stringToDate2(dateString: championshipStartMenD1), division: .DI, gender: .men)
let WCC_W = Conference(link: "wccsports.com", sport_id: "17", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=wsoc", name: "WCC", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)


// Only women conferences
let Big12 = Conference(link: "big12sports.com", sport_id: "31", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=soc", name: "Big 12", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let BigSky = Conference(link: "bigskyconf.com", sport_id: "7", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=wsoc", name: "Big Sky", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let MountainWest = Conference(link: "themw.com", sport_id: "14", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=wsoc", name: "Mountain West", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let OhioValley = Conference(link: "ovcsports.com", sport_id: "15", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=wsoc", name: "Ohio Valley", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

// SEC cannot be used with API

let Southland = Conference(link: "southland.org", sport_id: "16", school_id: "0", start: startD1, end: "11/03/2021", standings: "standings=91", name: "Southland", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let Southwestern = Conference(link: "swac.org", sport_id: "16", school_id: "0", start: startD1, end: "11/03/2021", standings: "standings=36", name: "Southwestern", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)

let SunBelt = Conference(link: "sunbeltsports.org", sport_id: "14", school_id: "0", start: startD1, end: "11/03/2021", standings: "path=wsoc", name: "Sun Belt", confTournEnd: stringToDate2(dateString: championshipStartWomenD1), division: .DI, gender: .women)
