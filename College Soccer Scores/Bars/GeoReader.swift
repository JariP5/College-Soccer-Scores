//
//  GeoReader.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 25.11.21.
//

import SwiftUI

struct GeoReader: View {
    @Binding var isHide: Bool
    var body: some View {
        // geometry reader for getting location values...
        GeometryReader{reader -> AnyView in
            
            let yAxis = reader.frame(in: .global).minY

            // logic simple if goes below zero hide nav bar
            // above zeroshow nav bar...
            
            if (yAxis < 0  && !isHide) {
                DispatchQueue.main.async {
                    withAnimation{isHide = true}
                }
            }
            
            if (yAxis > 0 && isHide) {
                DispatchQueue.main.async {
                    withAnimation{isHide = false}
                }
            }
            
            return AnyView(
                Text("")
                    .frame(width: 0, height: 0)
            )
        }
        .frame(width: 0, height: 0)
    }
}
