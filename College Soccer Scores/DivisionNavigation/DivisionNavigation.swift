//
//  Navigation.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 10.09.21.
//

import SwiftUI
import NavigationStack

struct DivisionNavigation: View {
    
    @State private var offset = CGSize.zero
    @State var isHide = false // used to hide top of screen when scroll view is higher than certain point
    @State var current = stringConf // variable to keep track of active tab, starting on conference
    @State var selectedGender: Gender = .men
    var tabs = [stringConf, stringRanking, stringChamp]
    
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

                AppBar(title: division.name, isHide: isHide, selectedGender: $selectedGender, current: $current, headers: tabs)
                
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
            .gesture(
                DragGesture()
                        .onChanged { gesture in
                            self.offset = gesture.translation
                        }

                        .onEnded { value in
                            
                            if abs(self.offset.width) > 100 {
                                if value.startLocation.x > 50 && value.startLocation.x < UIScreen.screenWidth - 50 {
                                    // left swipe
                                    var index = 0;
                                    var searching = true
                                    while searching && index < tabs.count{
                                        if current == tabs[index]{
                                            searching = false
                                        } else {
                                            index += 1
                                        }
                                    }
                                    
                                    if (value.startLocation.x > value.location.x) {
                                        if index < tabs.count {
                                            withAnimation{current = tabs[index + 1]}
                                        }
                                    } else {
                                        if index > 0 {
                                            withAnimation{current = tabs[index - 1]}
                                        }
                                    }
                                }
                            } else {
                                self.offset = .zero
                            }
                        }
            )
        }
    }
}
