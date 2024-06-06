//
//  ProgressCircleView.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/6/24.
//

import SwiftUI

struct ProgressCircleView: View {
    var progress: Double
    var isCompleted: Bool
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.3)
                .foregroundColor(isCompleted ? .green : .blue)
                .shadow(color: isCompleted ? .green : .blue, radius: 5)
            
            if !isCompleted {
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.blue)
                    .rotationEffect(.degrees(-90))
                    .animation(.linear, value: progress)
            }
            
            VStack(alignment: .center ,spacing: 8) {
                HStack {
                    Text(String(format: "%.0f%%", min(progress, 1.0) * 100))
                        .font(.largeTitle)
                        .bold()
                    Image(systemName: "drop.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                }
                Text("of daily goal")
                    .font(.caption)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    ProgressCircleView(progress: 10, isCompleted: true)
}
