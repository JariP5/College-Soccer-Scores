//
//  DivisionChampionship.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 19.11.21.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct DivisionChampionship: View {
    
    var url: String
    @StateObject var champs = ChampsViewModel()
    
    var body: some View {
        
        ScrollView {
            if (!champs.fetching) {
                if (champs.data != nil) {
                    PDFKitRepresentedView(data: champs.data!)
                        .frame(height: UIScreen.screenHeight - heightAppBarAndTabView)
                        .shadow(radius: 2)
                } // maybe add else statement with "something went wrong" view
            } else {
                Text("")
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight - heightAppBarAndTabView)
            }
            if !champs.internetConn {
                BadConnection()
            }
        }
        .overlay {
            if champs.fetching {
                LoadingIndicator(animation: .circleTrim, color: .blue, size: .medium, speed: .normal)
            }
        }
        .task {
            champs.fetchData(url: url)
        }
    }
}
