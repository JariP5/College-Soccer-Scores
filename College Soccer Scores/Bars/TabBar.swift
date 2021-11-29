//
//  TabBar.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 25.11.21.
//

import SwiftUI

struct TabBar: View {
    @Binding var current: String
    var headers: [String]
    @Binding var selectedPage: Int
    @Namespace var animation // for some reason needs to be passed into view to work

    var body: some View {
        // Tab Bar...
        HStack(spacing: 0){
            
            // use for each enumarted
            ForEach(Array(headers.enumerated()), id: \.element) { index, header in
                TabBarButton(current: $current, header: header, animation: animation, selectedPage: $selectedPage, index: index)
            }
        }
        .padding(.horizontal)
    }
}
