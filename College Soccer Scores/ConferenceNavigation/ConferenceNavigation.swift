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
    // stores and downloads data for standings and schedule, keeps data as long navigating in conference
    @StateObject var scheduleModel = ScheduleViewModel()
    @StateObject var standingsModel = StandingsViewModel()
    @StateObject var confTournModel = ConfTournViewModel()
    
    @State var scrollTarget = 1 // used to programmtically scroll scrollview
    
    var tabs = ["Schedule", "Standings", "Championship"]
    
    @State var isFavConf = false
    @State var selectedPage = 0
    @EnvironmentObject var favModel: FavoritesModel // used
    
    var conf: Conference

    
    var body: some View {
        VStack(spacing: 0){
            // App Bar...
            VStack(spacing: 0){
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
                    }){
                        Image(systemName: isFavConf ? "star.fill" : "star")
                    }
                    .frame(width: 30)
                }
                .padding(.horizontal)
                .padding(.bottom)

                TabBar(current: $current, headers: tabs, selectedPage: $selectedPage)
            }
            .padding(.top, 15)
            .background(Color.white)
            
            // Page View
            TabView (selection: $selectedPage){
                ZStack (alignment: .leading){
                    ScrollViewReader { reader in
                        ScrollView(.vertical, showsIndicators: false) {
                            ConferenceSchedule(scheduleModel: scheduleModel, conf: conf, scrollTarget: $scrollTarget)
                                .id(0) // scroll to position at top of view
                        }
                        // Scroll to the desired row when scrollTarget changes
                        .onChange(of: scrollTarget) { target in
                            scrollTarget = 1
                            withAnimation {
                                reader.scrollTo(target, anchor: .top)
                            }
                        }
                    }
                    DragContainer()
                }.tag(0)
                ZStack (alignment: .leading){
                    ScrollView(.vertical, showsIndicators: false) {
                        ConferenceStandings(viewModel: standingsModel, conf: conf)
                    }
                    DragContainer()
                }.tag(1)
                ZStack (alignment: .leading){
                    ScrollView(.vertical, showsIndicators: false) {
                        ConferenceChampionship(confTournModel: confTournModel, conf: conf)
                    }
                    DragContainer()
                }.tag(2)
            }
            .background(.bar)
            .frame(width: UIScreen.screenWidth)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: selectedPage) { newIdx in
                withAnimation{current = tabs[newIdx]}
            }
        }
        .onAppear {
            // check if current conference is favorized by user
            isFavConf = favModel.isFavorized(conf: conf)
        }
    }
}

private struct DragContainer: View {
    @State private var offset = CGSize.zero
    @EnvironmentObject private var navigationStack: NavigationStack
    var body: some View {
        // invisble rectangle overlaying scrollview
        // to be able swipe back and pop view
        Rectangle()
            .fill(.white)
            .opacity(0.001)
            .frame(idealWidth: 20, maxWidth: 20, maxHeight: .infinity)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.offset = gesture.translation
                    }
                    .onEnded { value in
                        if abs(self.offset.width) > 50 {
                            if value.startLocation.x <= 20 {
                                self.navigationStack.pop()
                            }
                        } else {
                            self.offset = .zero
                        }
                    }
            )
    }
}
