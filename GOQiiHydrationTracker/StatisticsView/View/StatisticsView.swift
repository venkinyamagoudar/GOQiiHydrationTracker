//
//  StatisticsView.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/6/24.
//

import SwiftUI

struct StatisticsView: View {
    @StateObject var viewModel: StatisticsViewModel = StatisticsViewModel()
    var body: some View {
        ScrollView {
            VStack {
                VStack{
                    HStack{
                        StatisticsCardView(cardType: .average, viewModel: viewModel)
                        StatisticsCardView(cardType: .max, viewModel: viewModel)
                    }
                    StatisticsCardView(cardType: .daysCompletedTarget, viewModel: viewModel)
                }
                .padding()
                Picker(selection: $viewModel.selectedIndex, label: Text("Statistics")) {
                    Text("Last 7 Days").tag(0)
                    Text("Last 30 Days").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                GeometryReader { geometry in
                    VStack {
                        if viewModel.selectedIndex == 0 {
                            if viewModel.hasLastSevenDaysData {
                                BarChartActivityView(data: viewModel.lastSevenDaysData, title: "Last 7 Days Stats", height: geometry.size.height * 0.7)
                            } else {
                                AddLottieView(lottieFileName: LottieFiles.noDataFound)
                            }
                        } else {
                            if viewModel.hasLastThirtyDays {
                                BarChartActivityView(data: viewModel.lastThirtyDaysData, title: "Previous 30 Days Stats", height: geometry.size.height * 0.7)
                            } else {
                                AddLottieView(lottieFileName: LottieFiles.noDataFound)
                            }
                        }
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 0.7)
                .onAppear {
                    viewModel.fetchStatistics()
                }
                .navigationTitle("Statistics")
            }
        }
    }
}

#Preview {
    StatisticsView()
}
