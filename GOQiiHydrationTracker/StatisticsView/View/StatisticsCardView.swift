//
//  StatisticsCardView.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/6/24.
//

import SwiftUI

struct StatisticsCardView: View {
    let cardType: ActivityCardType
    @StateObject var viewModel: StatisticsViewModel
    var body: some View {
        let backgroundColor: Color = cardType == .average ? Color.blue.opacity(0.3) : cardType == .max ? Color.yellow.opacity(0.3) : Color.pink.opacity(0.3)
        
        return VStack(alignment: .leading) {
            HStack{
                Text(cardType == .average  ? "Average" : cardType == .max ? "Max" : "No.Target Achieved")
                    .font(.caption)
                Spacer()
            }
            Spacer()
            Text(cardType == .average  ? "\(String(viewModel.averageGlasses )) Glass" : cardType == .max ? "\(String(viewModel.maxGlasses)) Glass" : "\(String(viewModel.daysCompletedTarget)) Glass")
                .font(.title)
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(10)
    }
}

#Preview {
    StatisticsCardView(cardType: .average, viewModel: StatisticsViewModel())
}
