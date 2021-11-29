//
//  TabBarButton.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 11.09.21.
//

import SwiftUI

struct TabBarButton: View {
    
    @Binding var current : String
    var header : String // active tab
    var animation : Namespace.ID
    @Binding var selectedPage: Int
    var index: Int // index of that page Ex: First tab, the page index for that tab will be 0

    
    var body: some View {

        Button(action: {
            withAnimation{
                current = header
                selectedPage = index // update page view when button is pressed
            }
        }){
            VStack(spacing: 5){
                Text(header)
                    .foregroundColor(current == header ? Color.blue : Color.black.opacity(0.3))
                    .frame(height: 35)
                    .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(0.3)
                
                ZStack{
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 4)
                    
                    if (current == header){
                        Rectangle()
                            .fill(Color.blue)
                            .frame(height: 4)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                }
            }
        }
    }
}

