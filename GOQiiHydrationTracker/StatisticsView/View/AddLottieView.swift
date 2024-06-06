//
//  AddLottieView.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/6/24.
//

import SwiftUI
import Lottie

struct AddLottieView: UIViewRepresentable {
    let lottieFileName: String
    let loopMode: LottieLoopMode
    let contentMode: UIView.ContentMode
    let animationView: LottieAnimationView
    
    init(lottieFileName: String, loopMode: LottieLoopMode = .loop, contentMode: UIView.ContentMode = .scaleAspectFit) {
        self.lottieFileName = lottieFileName
        self.animationView = LottieAnimationView(name: lottieFileName)
        self.loopMode = loopMode
        self.contentMode = contentMode
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        animationView.loopMode = loopMode
        animationView.contentMode = contentMode
        animationView.play()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

#Preview {
    AddLottieView(lottieFileName: LottieFiles.noDataFound)
}
