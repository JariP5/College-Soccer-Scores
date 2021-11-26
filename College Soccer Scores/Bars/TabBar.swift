//
//  TabBar.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 25.11.21.
//

import SwiftUI

struct TabBar: View {
    @Binding var current: String
    @Namespace var animation
    var headers: [String]

    var body: some View {
        // Tab Bar...
        HStack(spacing: 0){
            ForEach(headers, id: \.self) { header in
                TabBarButtonDivision(current: $current, headerText: header, animation: animation)
            }
        }
        .padding(.horizontal)
    }
}
