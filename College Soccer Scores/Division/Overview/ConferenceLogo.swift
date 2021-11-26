//
//  ConferenceLogo.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 08.09.21.
//

import SwiftUI
import NavigationStack

struct ConferenceLogo: View {
    
    // only need conf name from conference
    var conf: Conference
    
    var body: some View {
        VStack{ // Text underneath image
            
            ZStack{ // for circle around image
                
                // conference logo is the link to the conference data
                // navigation view is including everything but tab view
                PushView(destination: ConferenceNavigation(conf: conf)) {
                    Image(conf.name)
                       .resizable()
                       .shadow(radius: 10)
                       .scaledToFit()
                       .frame(minWidth: 0, maxWidth: 70, minHeight: 0, maxHeight: 70)
                }

                 
                // Fillers are used to have logos appear in same vertical column
                // when only one or two instead of threee logos are left as the last conferences
                if (conf.name != "Filler"){
                    Circle()
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 100)
                } else{
                    Circle()
                        .stroke(Color.gray, lineWidth: 0)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 100)
                }
            }
            
            // D1 and D3 have a conference called MAC, name difference are used to
            // distinguish logos but appearing text should be the same
            if (conf.name == "MAC_1" || conf.name == "MAC_3"){
                    Text("MAC")
            }
            // do not show text if it is a filler
            else if (conf.name != "Filler"){
                Text(conf.name)
                    .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(0.3)
            }
        }
    }
}

