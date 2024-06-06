//
//  BarChartActivityView.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/6/24.
//

import SwiftUI
import Charts

struct BarChartActivityView: View {
    var data: [DailyHydration]
    var title: String
    var height: CGFloat
    
    var body: some View {
        GroupBox(title) {
            ScrollView(.horizontal) {
                Chart {
                    ForEach(data, id: \.id) { item in
                        BarMark(x: .value("Date", "\(item.date!.toString(dateStyle: .short, timeStyle: .none))"),
                                y: .value("Amount", item.currentHydration))
                        .cornerRadius(12.0)
                    }
                }
            }
            .frame(height: height)
            .chartPlotStyle { plotArea in
                plotArea
                    .background(.orange.opacity(0.1))
                    .border(.orange, width: 2)
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
        }
    }
}

#Preview {
    BarChartActivityView(data: [], title: "", height: CGFloat(300))
}
