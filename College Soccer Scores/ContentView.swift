//
//  ContentView.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 08.09.21.
//

import SwiftUI
import NavigationStack

struct ContentView: View {
    
    var body: some View {
        TabView{
            DivisionNavigation(D1)
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Division 1")
                }
            
            DivisionNavigation(D2)
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Division 2")
                }

            DivisionNavigation(D3)
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Division 3")
                }

            FavoritesView()
                .tabItem {
                    Image(systemName: "star")
                    Text("Favorites")
                }
        }
        .onAppear{UITabBar.appearance().backgroundColor = .white}
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
