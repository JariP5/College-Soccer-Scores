//
//  File.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 29.10.21.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct Rankings: View {
    
    @ObservedObject var viewModel: RankingsViewModel // class to download and trck data updates
    var name: String // Example: "Division 1"
    
    var body: some View {
        
        // Scrollview just looks and feels better than list
        ScrollView {
            
            if viewModel.internetConn {
                // set spacing to 0 so list can end in a divider
                // use more padding to make it look good
                VStack(spacing: 5){
                    
                    // wait until data is fetched to show division name
                    // makes it look cleaner
                    if !viewModel.fetching {
                        Text("\(name) Rankings")
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    
                    // viewModel.rankings is automatically updated when content loading is completed
                    ForEach(viewModel.rankings, id: \.self) { ranking in
                        Divider()
                        RankingsRowView(ranking: ranking)
                    }
                    
                    if viewModel.fetching {
                    // have invisble rectangle to keep the scroll view from callopsing while
                    // loading contents, would like that to be solved differently
                        Rectangle()
                            .fill(.yellow) // same color ascolor behind the list
                            .frame(maxWidth: .infinity, idealHeight: 400, maxHeight: 400)
                    }
                }
                .padding(.bottom)
            } else {
                BadConnection()
            }
        }
        
        // overlay is like a zstack, show progress view until download completed
        .overlay {
          if viewModel.fetching {
              LoadingIndicator(animation: .circleTrim, color: .blue, size: .medium, speed: .normal)
          }
        }
        .animation(.default, value: viewModel.rankings) // present rankings with animation
        .task {
            if (viewModel.rankings.count <= 0) {
                viewModel.fetchData() // when view is called, data task is set up
            }
        }
    }
}

// Row of a Ranking
private struct RankingsRowView: View {
    
  var ranking: Ranking // Ranking of one team
    
  var body: some View {
      // Creating the row for one rank using HStack
      HStack{
          Text("\(ranking.rank)")
              .frame(width: 50)
              
          Text(ranking.name) // autmoatically fills space left
          Spacer() // pushes next Text all the way to the side
          Text(ranking.record)
              .frame(width: 80)
      }
      .padding(.horizontal)
      .padding(.vertical, 5)
  }
}

