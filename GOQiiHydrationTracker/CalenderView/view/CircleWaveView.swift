//
//  CircleWaveView.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/7/24.
//

import SwiftUI

struct CircleWaveView: View {
    @State private var waveOffset = Angle(degrees: 0)
    let percent: Int
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle()
                    .stroke(Color.blue)
                    .overlay(
                        Wave(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(percent) / 100)
                            .fill(Color.blue)
                            .clipShape(Rectangle())
                    )
            }
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
            }
        }
    }
}

struct Wave: Shape {
    var offset: Angle
    var percent: Double
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(offset.degrees, percent) }
        set {
            offset = Angle(degrees: newValue.first)
            percent = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let waveHeight = rect.height / 20
        let yOffset = CGFloat(1 - percent) * rect.height
        
        path.move(to: CGPoint(x: 0, y: yOffset))
        for angle in stride(from: 0, through: rect.width, by: 1) {
            let x = angle
            let y = waveHeight * sin((angle / rect.width) * 2 * .pi + offset.radians) + yOffset
            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    CircleWaveView(percent: 89)
}
