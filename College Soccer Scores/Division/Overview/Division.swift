//
//  Conferences.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 08.09.21.
//

import SwiftUI

struct Division: View {
    
    var conf = [Conference]() // array of all conferences in selected divsion
    var amountOfRows: Int // each row shows three conference logos, amount of rows is amount of conferences divided by 3
        
    var body: some View {
        VStack{
            VStack(spacing: 20){
                
                // loop over amount of rows
                ForEach(0 ..< amountOfRows) { num in

                    // check if it is the last row and how many more onferences are left
                    // otherwise always use else statement to include all three conferences for that row
                    if (num == amountOfRows - 1 && conf.count % 3 == 1){
                        ConferencesRow(confs: [conf[num * 3]])
                    } else if (num == amountOfRows - 1 && conf.count % 3 == 2){
                        ConferencesRow(confs: [conf[num * 3], conf[num * 3 + 1]])
                    } else {
                        ConferencesRow(confs: [conf[num * 3], conf[num * 3 + 1], conf[num * 3 + 2]])
                    }
                }
            }
        }
    }
}
