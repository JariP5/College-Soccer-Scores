//
//  Navigation.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 10.09.21.
//

import SwiftUI
import NavigationStack

struct DivisionNavigation: View {
    
    @State var selectedPage = 0
    @State var current = "Conference" // variable to keep track of active tab, starting on conference
    @State var selectedGender: Gender = .men
    var tabs = ["Conference", "Rankings", "Championship"]
    
    // How can I get the URL in their
    @StateObject var menRankingModel: RankingsViewModel
    @StateObject var womenRankingModel: RankingsViewModel
    
    var division: DivisionStruct // Data of Division
    
    // initalize view with the correct rankings according to the division
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

                AppBar(title: division.name, selectedGender: $selectedGender, current: $current, headers: tabs, selectedPage: $selectedPage)
                                        
                        TabView (selection: $selectedPage){
                            ZStack {
                                ScrollView(.vertical, showsIndicators: false) {
                                    if selectedGender == .men {
                                        let rows = Int(ceil(Double(division.men.count) / 3.0))
                                        Division(conf: division.men, rows: rows)
                                    } else {
                                        let rows = Int(ceil(Double(division.women.count) / 3.0))
                                        Division(conf: division.women, rows: rows)
                                    }
                                }
                            }.tag(0)
                            ZStack {
                                ScrollView(.vertical, showsIndicators: false) {
                                    if selectedGender == .men {
                                        Rankings(viewModel: menRankingModel, name: division.name)
                                    } else {
                                        Rankings(viewModel: womenRankingModel, name: division.name)
                                    }
                                }
                            }.tag(1)
                            ZStack {
                                if selectedGender == .men {
                                    DivisionChampionship(url: division.championshipURLmen)
                                } else {
                                    DivisionChampionship(url: division.championshipURLwomen)
                                }
                            }.tag(2)
                        }
                        .frame(width: UIScreen.screenWidth)
                        .background(Color.yellow)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .onChange(of: selectedPage) { newIdx in
                            withAnimation{current = tabs[newIdx]} // change active tab when page view changes
                        }
            }
        }
    }
}
