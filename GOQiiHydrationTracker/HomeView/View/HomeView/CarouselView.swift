//
//  CarouselView.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/6/24.
//

import SwiftUI

struct CarouselView: View {
    @StateObject var viewModel: HomeViewModel
    @State private var currentIndex = 0
    @State private var offset: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            let cardCount = HomeCardType.allCases.count
            let cardWidth = geometry.size.width * 0.9
            let spacing: CGFloat = 10
            let totalSpacing = spacing * CGFloat(cardCount - 1)
            let fullWidth = cardWidth * CGFloat(cardCount) + totalSpacing
            let leadingPadding = (geometry.size.width - cardWidth) / 2

            HStack(spacing: spacing) {
                ForEach(HomeCardType.allCases, id: \.self) { cardType in
                    HydrationCardView(cardType: cardType, viewModel: viewModel)
                        .frame(width: cardWidth)
                }
            }
            .padding(.horizontal, leadingPadding)
            .offset(x: self.offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.offset = value.translation.width - CGFloat(self.currentIndex) * (cardWidth + spacing)
                    }
                    .onEnded { value in
                        if value.predictedEndTranslation.width < -geometry.size.width / 2, self.currentIndex < cardCount - 1 {
                            self.currentIndex += 1
                        }
                        if value.predictedEndTranslation.width > geometry.size.width / 2, self.currentIndex > 0 {
                            self.currentIndex -= 1
                        }
                        withAnimation {
                            self.offset = -CGFloat(self.currentIndex) * (cardWidth + spacing)
                        }
                    }
            )
        }
        .frame(height: 200)
        .padding()
    }
}

#Preview {
    CarouselView(viewModel: HomeViewModel())
}

