//
//  Navigation.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 10.09.21.
//

import SwiftUI
import NavigationStack

struct DivisionNavigation: View {
    
    var div: DivisionStruct // Data of Division
    @State var isHide = false // used to hide top of screen when scroll view is higher than certain poiint
    // top edge value
    @State var top = UIApplication.shared.windows.first?.safeAreaInsets.top
    @State var current = "Conferences" // variable to keep track of active tab, starting on conference
    @Namespace var animation // animation to switch between view through tap bar
    @State private var selectedGender: Gender = .men // selected gender
    
    var body: some View {
        
        // Embed in Navigation View to be able to go back when
        // going into conferences, navigation view is messing with layout
        // of navigation link views
//        NavigationView{
        NavigationStackView{
            VStack(spacing: 0){
                // App Bar...
                VStack(spacing: 22){
                    
                    if !isHide{
                        Text("NCAA")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.blue)
                    }

                    // Tab Bar...
                    HStack(spacing: 0){
                        TabBarButtonDivision(current: $current, headerText: "Conferences", animation: animation)
                        TabBarButtonDivision(current: $current, headerText: "Rankings", animation: animation)
                        TabBarButtonDivision(current: $current, headerText: "Championship", animation: animation)
                    }
                    .padding(.horizontal)
                }
                .background(Color.white)
                
                // Picker to Choose between men's and women's soccer
                // same picker on each view of division navigation
                Picker("Choose", selection: $selectedGender){
                    ForEach(Gender.allCases, id: \.self){
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 70)
                .padding(.vertical, 20)
                .background(.yellow)
                
                // Content...
                ScrollView(.vertical, showsIndicators: false) {
                
                    VStack(spacing: 0){
                        
                        // geometry reader for getting for location values...
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
                        
                        // Content
                        switch current{
                            case "Conferences":
                                Division(conf: div.confs, amountOfRows: Int(ceil(Double(div.confs.count) / 3.0)))
                            case "Rankings":
                                Rankings(div: div)
                            case "Championship":
                                Text("Championship")
                            default:
                                Text("Not ready yet")
                        }
                    }
                }
                .background(Color.yellow) // background for scrollView
            }
        }
    }
}


struct DivisionNavigation_Previews: PreviewProvider {
    static var previews: some View {
        DivisionNavigation(div: D1)
    }
}
