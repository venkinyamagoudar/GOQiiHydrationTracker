//
//  ContentView.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/6/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: TabImages = .house
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Image(systemName: TabImages.house.rawValue)
                Text("Home")
            }
            .tag(TabImages.house)
            
            NavigationView {
//                CalanderView()
            }
            .tabItem {
                Image(systemName: TabImages.statistics.rawValue)
                Text("Calender")
            }
            .tag(TabImages.calendar)
            
            NavigationView {
                StatisticsView(viewModel: StatisticsViewModel())
            }
            .tabItem {
                Image(systemName: TabImages.statistics.rawValue)
                Text("Activity")
            }
            .tag(TabImages.statistics)
        }
    }
}

#Preview {
    MainTabView()
}

enum TabImages: String, CaseIterable {
    case house = "house"
    case statistics = "chart.bar.xaxis"
    case calendar = "calendar"
}

