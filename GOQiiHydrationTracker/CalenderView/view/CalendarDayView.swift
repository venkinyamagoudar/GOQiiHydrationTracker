//
//  CalendarDayView.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/7/24.
//

import SwiftUI

struct CalendarDayView: View {
    let date: Date
    let hydration: DailyHydration?
    
    var hydrationPercentage: Double {
        guard let hydration = hydration else { return 0 }
        if hydration.targetHydration == 0 { return 0 }
        return min(Double(hydration.currentHydration) / Double(hydration.targetHydration), 1.0)
    }
    
    var body: some View {
        VStack {
            Text(date, formatter: dayFormatter)
                .font(.caption)
                .foregroundColor(.gray)
            
            if let hydration = hydration {
                Text("\(hydration.currentHydration) glasses")
                    .font(.footnote)
                    .padding(5)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(5)
            } else {
                Text("0 glasses")
                    .font(.footnote)
                    .padding(5)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(5)
            }
        }
        .frame(height: 100)
        .padding(5)
        .background(
            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    Color.gray.opacity(0.1) // Background color
                    CircleWaveView(percent: Int(hydrationPercentage * 100))
                        .frame(height: geometry.size.height)
                }
                .cornerRadius(5)
                .shadow(radius: 2)
            }
        )
    }
}

fileprivate let dayFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "d"
    return formatter
}()
