//
//  Navigation.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 10.09.21.
//

import SwiftUI
import NavigationStack

struct ConferenceNavigation: View {
    
    @State var current = "Schedule" // active tab bar
    @State private var offset = CGSize.zero
    // stores and downloads data for standings and schedule, keeps data as long navigating in conference
    @StateObject var scheduleModel = ScheduleViewModel()
    @StateObject var standingsModel = StandingsViewModel()
    @StateObject var confTournModel = ConfTournViewModel()
    
    var tabs = ["Schedule", "Standings", "Championship"]
    
    @State var isFavConf = false
    @EnvironmentObject var favModel: FavoritesModel
    @EnvironmentObject private var navigationStack: NavigationStack
    
    var conf: Conference

    
    var body: some View {
        VStack(spacing: 0){
            // App Bar...
            VStack(spacing: 22){
                HStack{
                    
                    // back button
                    PopView {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.blue)
                            .frame(width: 30)
                    }
                    
                    // spacers and empty text are used to keep image in the name
                    // and back button to the left
                    Spacer()
                    Image(conf.name)
                       .resizable()
                       .shadow(radius: 10)
                       .aspectRatio(contentMode: .fit)
                       .frame(minWidth: 0, maxWidth: 150, minHeight: 0, maxHeight: 60)
                    Spacer()
                    
                    Button(action: {
                        if isFavConf {
                            favModel.remove(conf: conf)
                        } else {
                            favModel.append(conf: conf)
                        }
                        isFavConf.toggle()
                    } ){
                        Image(systemName: isFavConf ? "star.fill" : "star")
                    }
                    .frame(width: 30)
                }
                .padding(.horizontal)

                TabBar(current: $current, headers: tabs)
                
            }
            .padding(.top, 15)
            .background(Color.white)
            
            
            // Content...
            switch current{
                case tabs[0]:
                    ConferenceSchedule(scheduleModel: scheduleModel, conf: conf)
                    
                case tabs[1]:
                    ConferenceStandings(viewModel: standingsModel, conf: conf)
                    
                case tabs[2]:
                    ConferenceChampionship(confTournModel: confTournModel, conf: conf)
                    
                default:
                    Text("Not ready yet")
            }
        }
        .onAppear {
            isFavConf = favModel.isFavorized(conf: conf)
        }
        .gesture(
            DragGesture()
                    .onChanged { gesture in
                        self.offset = gesture.translation
                    }

                    .onEnded { value in
                        
                        if abs(self.offset.width) > 100 {
                            if value.startLocation.x < 20 {
                                self.navigationStack.pop()
                            } else if value.startLocation.x > 50 && value.startLocation.x < UIScreen.screenWidth - 50 {
                                // left swipe
                                var index = 0;
                                var searching = true
                                while searching && index < tabs.count{
                                    if current == tabs[index]{
                                        searching = false
                                    } else {
                                        index += 1
                                    }
                                }
                                
                                if (value.startLocation.x > value.location.x) {
                                    if index < tabs.count {
                                        withAnimation{current = tabs[index + 1]}
                                    }
                                } else {
                                    if index > 0 {
                                        withAnimation{current = tabs[index - 1]}
                                    }
                                }
                            }
                        } else {
                            self.offset = .zero
                        }
                    }
        )
    }
}
