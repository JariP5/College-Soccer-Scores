//
//  AppBar.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 25.11.21.
//

import SwiftUI

struct AppBar: View {
    
    var title: String
    @Binding var selectedGender: Gender
    @Binding var current: String
    var headers: [String]
    @Binding var selectedPage: Int

    
    var body: some View {
        // App Bar...
        VStack(spacing: 0){
            
            Text(title)
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.blue)
                .padding(.vertical, 15)

            TabBar(current: $current, headers: headers, selectedPage: $selectedPage)
        }
        .background(Color.white)
        
        // Picker to Choose between men's and women's soccer
        // same picker on each view of division navigation
        Picker("Choose", selection: $selectedGender){
            ForEach(Gender.allCases, id: \.self){
                Text($0.rawValue)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal, 70)
        .padding(.vertical, 20)
        .background(.yellow)
    }
}
