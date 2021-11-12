//
//  TabBarButton.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 11.09.21.
//

import SwiftUI

struct TabBarButtonConference: View {
    
    @Binding var current : String
    var headerText : String
    var animation : Namespace.ID
    
    var body: some View {

        Button(action: {
            withAnimation{current = headerText}
        } ){
            VStack(spacing: 5){
                Text(headerText)
                    .foregroundColor(current == headerText ? Color.blue : Color.black.opacity(0.3))
                    .frame(height: 35)
                    .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(0.3)
                
                ZStack{
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 4)
                    
                    if (current == headerText){
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
