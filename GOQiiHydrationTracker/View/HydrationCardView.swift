//
//  HydrationCardView.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/6/24.
//

import SwiftUI

struct HydrationCardView: View {
    let cardType: CardType
    @State var presentEditTargetView:Bool = false
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        let backgroundColor: Color = cardType == .hydrationTarget ? Color.blue.opacity(0.3) : Color.yellow.opacity(0.3)
        
        return VStack(alignment: .leading) {
            HStack {
                Text(cardType == .hydrationTarget ? "Hydration Target" : "Current Hydration")
                    .font(.caption)
                Spacer()
                if cardType == .hydrationTarget {
                    Button(action: {
                        self.presentEditTargetView = true
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
            Text(cardType == .hydrationTarget ? "\(String(viewModel.dailyHydration?.targetHydration ?? 0)) Glass" : "\(String(viewModel.dailyHydration?.currentHydration ?? 0)) Glass")

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

#Preview {
    HydrationCardView(cardType: .hydrationTarget, viewModel: HomeViewModel())
}
