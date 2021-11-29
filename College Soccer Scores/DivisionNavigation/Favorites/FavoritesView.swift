//
//  Favorites.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 24.11.21.
//

import SwiftUI
import NavigationStack

struct FavoritesView: View {
    @State private var selectedGender: Gender = .men
    @State var selectedPage = 0 // page for the page view
    @State var current = "Division 1" // track active tab
    var tabs = ["Division 1", "Division 2", "Division 3"]
    @EnvironmentObject var favoritesModel: FavoritesModel
    
    var body: some View {
        
        NavigationStackView{
            VStack(spacing: 0){
                
                AppBar(title: "Your Favorites", selectedGender: $selectedGender, current: $current, headers: tabs, selectedPage: $selectedPage)
                                
                // Page View
                TabView (selection: $selectedPage){
                    ZStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            if selectedGender == .men {
                                let rows = Int(ceil(Double(favoritesModel.d1Men.count) / 3.0))
                                Division(conf: favoritesModel.d1Men, rows: rows)
                            } else {
                                let rows = Int(ceil(Double(favoritesModel.d1Women.count) / 3.0))
                                Division(conf: favoritesModel.d1Women, rows: rows)
                            }
                        }
                    }.tag(0)
                    ZStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            if selectedGender == .men {
                                let rows = Int(ceil(Double(favoritesModel.d2Men.count) / 3.0))
                                Division(conf: favoritesModel.d2Men, rows: rows)
                            } else {
                                let rows = Int(ceil(Double(favoritesModel.d2Women.count) / 3.0))
                                Division(conf: favoritesModel.d2Women, rows: rows)
                            }
                               
                        }
                    }.tag(1)
                    ZStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            if selectedGender == .men {
                                let rows = Int(ceil(Double(favoritesModel.d3Men.count) / 3.0))
                                Division(conf: favoritesModel.d3Men, rows: rows)
                            } else {
                                let rows = Int(ceil(Double(favoritesModel.d3Women.count) / 3.0))
                                Division(conf: favoritesModel.d3Women, rows: rows)
                            }
                        }
                    }.tag(2)
                }
                .frame(width: UIScreen.screenWidth)
                .background(Color.yellow)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // hide dots of page view
                .onChange(of: selectedPage) { newIdx in
                    withAnimation{current = tabs[newIdx]} // change current tab when page view is scrolled
                }
            }
        }
    }
}
