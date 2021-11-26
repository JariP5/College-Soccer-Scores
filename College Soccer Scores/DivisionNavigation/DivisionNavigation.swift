//
//  Navigation.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 10.09.21.
//

import SwiftUI
import NavigationStack

struct DivisionNavigation: View {
    
    @State var isHide = false // used to hide top of screen when scroll view is higher than certain point
    @State var top = UIApplication.shared.windows.first?.safeAreaInsets.top
    @State var current = stringConf // variable to keep track of active tab, starting on conference
    @State var selectedGender: Gender = .men
    
    // How can I get the URL in their
    @StateObject var menRankingModel: RankingsViewModel
    @StateObject var womenRankingModel: RankingsViewModel
    
    var division: DivisionStruct // Data of Division
    
    init (_ division: DivisionStruct) {
        self.division = division
        self._menRankingModel = StateObject(wrappedValue: RankingsViewModel(division.rankingURLmen))
        self._womenRankingModel = StateObject(wrappedValue: RankingsViewModel(division.rankingURLwomen))
    }
    
    var body: some View {
        
        // Embed in Navigation View to be able to go back when
        // going into conferences, navigation view is messing with layout
        // of navigation link views
        NavigationStackView{
            VStack(spacing: 0){

                AppBar(title: "NCAA", isHide: isHide, selectedGender: $selectedGender, current: $current, headers: [stringConf, stringRanking, stringChamp])
                
                // Content...
                ScrollView(.vertical, showsIndicators: false) {
                
                    VStack(spacing: 0){
                        
                        // geometry reader for getting location values...
                        GeoReader(isHide: $isHide)
                        
                        // Content
                        switch current{
                            case stringConf:
                            
                            if selectedGender == .men {
                                let rows = Int(ceil(Double(division.men.count) / 3.0))
                                Division(conf: division.men, rows: rows)
                            } else {
                                let rows = Int(ceil(Double(division.women.count) / 3.0))
                                Division(conf: division.women, rows: rows)
                            }
                                
                            case stringRanking:
                            if selectedGender == .men {
                                Rankings(viewModel: menRankingModel, name: division.name)
                            } else {
                                Rankings(viewModel: womenRankingModel, name: division.name)
                            }
                                
                            case stringChamp:
                            if selectedGender == .men {
                                DivisionChampionship(url: division.championshipURLmen)
                            } else {
                                DivisionChampionship(url: division.championshipURLwomen)
                            }

                            default:
                                Text("Not ready yet")
                        }
                    }
                }
                .background(Color.yellow) // background for scrollView
            }
        }
    }
}
