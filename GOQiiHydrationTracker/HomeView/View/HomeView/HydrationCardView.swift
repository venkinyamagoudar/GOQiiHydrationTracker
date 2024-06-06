//
//  HydrationCardView.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/6/24.
//

import SwiftUI

struct HydrationCardView: View {
    let cardType: HomeCardType
    @State var presentEditTargetView: Bool = false
    @StateObject var viewModel: HomeViewModel
    
    var progress: Double {
        guard let current = viewModel.dailyHydration?.currentHydration,
              let target = viewModel.dailyHydration?.targetHydration else { return 0 }
        return Double(current) / Double(target)
    }
    
    var complete: Bool {
        guard let current = viewModel.dailyHydration?.currentHydration,
              let target = viewModel.dailyHydration?.targetHydration else { return false }
        return current >= target
    }
    
    var body: some View {
        let backgroundColor = cardType == .hydrationTarget ? Color.blue.opacity(0.3) : Color.yellow.opacity(0.3)
        
        switch cardType {
        case .progressCircleView:
            HStack {
                Spacer()
                ProgressCircleView(progress: progress, isCompleted: complete)
                Spacer()
            }
            .padding()
            .background(Color.red.opacity(0.3))
            .cornerRadius(10)
        case .hydrationTarget, .curretHydration:
            VStack(alignment: .leading) {
                HStack {
                    Text(cardType.title)
                        .font(.caption)
                    Spacer()
                    if cardType == .hydrationTarget {
                        Button(action: {
                            presentEditTargetView.toggle()
                        }) {
                            Text("Edit")
                                .font(.subheadline)
                                .foregroundColor(Color.black)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.white)
                        .cornerRadius(30)
                    }
                }
                Spacer()
                Text(cardType.content(viewModel: viewModel))
                    .font(.title)
            }
            .padding()
            .background(backgroundColor)
            .cornerRadius(10)
            .sheet(isPresented: $presentEditTargetView, content: {
                EditTargetView(isPresented: $presentEditTargetView, viewModel: viewModel)
                    .presentationDetents([.medium])
                    .presentationBackgroundInteraction(.disabled)
            })
        }
    }
}

#Preview {
    HydrationCardView(cardType: .progressCircleView, viewModel: HomeViewModel())
}
