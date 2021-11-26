//
//  ConferencesRow.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 08.09.21.
//

import SwiftUI

struct ConferencesRow: View {

    // usually including three conferences
    // if last row might be one or two
    var confs: [Conference]
    
    var body: some View {

        HStack {
            ConferenceLogo(conf: confs[0]) // first one
            
            // second and third conference if applicable
            if (confs.count > 1){
                ConferenceLogo(conf: confs[1])
                if (confs.count > 2){
                    ConferenceLogo(conf: confs[2])
                }
            }
        }
        .frame(height: 130)
        .padding()
    }
}
