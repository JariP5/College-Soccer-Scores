//
//  Navigation.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 10.09.21.
//

import SwiftUI
import NavigationStack

struct ConferenceNavigation: View {
    
    // top edge value
    @State var top = UIApplication.shared.windows.first?.safeAreaInsets.top
    @State var current = "Schedule" // active tab bar
    @Namespace var animation // animation to change tab
    // stores and downloads data for standings and schedule, keeps data as long navigating in conference
    @StateObject var scheduleModel = ScheduleViewModel()
    @StateObject var standingsModel = StandingsViewModel()
    @StateObject var confTournModel = ConfTournViewModel()
    
    @State var isFavConf = false
    @EnvironmentObject var favModel: FavoritesModel
    
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

                // Tab Bar...
                HStack(spacing: 0){
                    TabBarButtonConference(current: $current, headerText: "Schedule", animation: animation)
                    TabBarButtonConference(current: $current, headerText: "Standings", animation: animation)
                    TabBarButtonConference(current: $current, headerText: "Championship", animation: animation)
                }
                .padding(.horizontal)
                
            }
            .padding(.top, 15)
            .background(Color.white)
            
            
            // Content...
            switch current{
                case "Schedule":
                    ConferenceSchedule(scheduleModel: scheduleModel, conf: conf)
                    
                case "Standings":
                    ConferenceStandings(viewModel: standingsModel, conf: conf)
                    
                case "Championship":
                    ConferenceChampionship(confTournModel: confTournModel, conf: conf)
                    
                default:
                    Text("Not ready yet")
            }
        }
        .onAppear {
            isFavConf = favModel.isFavorized(conf: conf)
        }
    }
}
