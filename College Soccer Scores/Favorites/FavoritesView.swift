//
//  Favorites.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 24.11.21.
//

import SwiftUI
import NavigationStack

struct FavoritesView: View {
    @State private var selectedGender: Gender = .men // selected gender
    @State var current = D1String // variable to keep track of active tab, starting on conference
    @State var isHide = false // used to hide top of screen when scroll view is higher than certain poiint
    @EnvironmentObject var favoritesModel: FavoritesModel
    
    var body: some View {
        
        NavigationStackView{
            VStack(spacing: 0){
                
                AppBar(title: "Your Favorites", isHide: isHide, selectedGender: $selectedGender, current: $current, headers: [D1String, D2String, D3String])
                                
                // Content...
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 0){
                        
                        GeoReader(isHide: $isHide)                        
                    
                        // Content
                        switch current{
                            case D1String:
                            
                            if selectedGender == .men {
                                let rows = Int(ceil(Double(favoritesModel.d1Men.count) / 3.0))
                                Division(conf: favoritesModel.d1Men, rows: rows)
                            } else {
                                let rows = Int(ceil(Double(favoritesModel.d1Women.count) / 3.0))
                                Division(conf: favoritesModel.d1Women, rows: rows)
                            }
                            
                            case D2String:
                            if selectedGender == .men {
                                let rows = Int(ceil(Double(favoritesModel.d2Men.count) / 3.0))
                                Division(conf: favoritesModel.d2Men, rows: rows)
                            } else {
                                let rows = Int(ceil(Double(favoritesModel.d2Women.count) / 3.0))
                                Division(conf: favoritesModel.d2Women, rows: rows)
                            }
                                
                            case D3String:
                            if selectedGender == .men {
                                let rows = Int(ceil(Double(favoritesModel.d3Men.count) / 3.0))
                                Division(conf: favoritesModel.d3Men, rows: rows)
                            } else {
                                let rows = Int(ceil(Double(favoritesModel.d3Women.count) / 3.0))
                                Division(conf: favoritesModel.d3Women, rows: rows)
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
