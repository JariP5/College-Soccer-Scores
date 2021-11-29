//
//  ReadMe.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 11.11.21.
//

// OVERVIEW AND NEXT STEPS FOR THE APP

// 8. Insert data for api conferences for all divisions
// 10. Try to find a way to include other conferences using their htmls
// 12. Include school logos
// 13. Include security
// 14. Test for different iphones
// 15. Talk to lawyers, conferences, api provider etc.
// 18. What if Rankings are not out yet, same for division championship page and conference standings
// 20. Favorites are added but only display in row right after adding, since view is not reloaded

// Acceptable flaws in software currently
// - NavigationStackView while slowly swiping back to previous view does not follow swipe gesture until finsihed
// - Hiding title in App Bar using Geo Reader seems not compatible with page view
// - Removing favorite over favorites view removes conference view and goes back to favorites view (without animation)
// - Height of appBar + tabView change slightly for different iphones
// - Adding favorites from division, only shows on favorites page if still space in the row until view is reinstantiated


// RESEARCH ON HOW TO GET DATA FOR DIFFERENT CONFERENCES
//API
//D1
//- [ ] ACC
//- [ ] AAC
//- [ ] Big West
//- [ ] MAC
//- [ ] America East
//- [ ] Patriot
//- [ ] SoCon
//- [ ] MVC
//- [ ] NEC
//- [ ] Big East
//- [ ] MAAC
//- [ ] Sun Belt
//- [ ] C-USA
//- [ ] Summit League
//- [ ] Horizon
//- [ ] CAA
//- [ ] Atlantic 10
//- [ ] Big South
//- [ ] WCC
//- [ ] MAAC
//- [ ] Big Ten
//D2
//- [ ] SSC
//- [ ] RMAC
//- [ ] CCAA
//- [ ] Conference Carolinas (CC)
//- [ ] G-MAC
//- [ ] GAC
//- [ ] GLVC
//- [ ] Gulf South
//- [ ] Lone Star
//- [ ] MEC
//- [ ] PacWest
//- [ ] Peach Belt
//- [ ] PSAC
//D3
//- [ ] CUNYAC -> Standings are not working
//- [ ] American Rivers
//- [ ] ASC
//- [ ] Atlantic East
//- [ ] CCIW
//- [ ] CSAC
//- [ ] Empire 8
//- [ ] HCAC
//- [ ] Liberty League
//- [ ] MAC
//- [ ] Little East
//- [ ] MWC
//- [ ] NESCAC
//- [ ] NJAC
//- [ ] NWC
//- [ ] PAC
//- [ ] SAA
//- [ ] Skyline
//- [ ] UMAC
//- [ ] United East
//
//HTML
//Note: HTML seems to be mostly formatted the same and one scraping script might be working for most of them
//D1
//- [ ] ASUN
//- [ ] WAC
//- [ ] SEC
//D2
//- [ ] CACC
//- [ ] ECC
//- [ ] GLIAC
//- [ ] Great Northwest
//- [ ] NE10
//- [ ] SAC
//
//D3
//- [ ] AMCC
//- [ ] C2C
//- [ ] CCC
//- [ ] Centennial
//- [ ] Great Northeast //
//- [ ] Landmark
//- [ ] MASCAC
//- [ ] MIAC
//- [ ] MIAA
//- [ ] NAC
//- [ ] NACC
//- [ ] NCAC
//- [ ] NECC
//- [ ] NEWMAC
//- [ ] OAC
//- [ ] ODAC
//- [ ] SCAC
//- [ ] SCIAC
//- [ ] SLIAC
//- [ ] UAA
//- [ ] USA South
//
//Different API
//Pac-12 (D1)
//SUNYAC (maybe just HTML) (D3)

