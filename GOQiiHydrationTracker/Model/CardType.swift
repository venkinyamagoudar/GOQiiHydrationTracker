//
//  CardType.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/6/24.
//

import Foundation

enum HomeCardType: CaseIterable {
    case hydrationTarget
    case curretHydration
    case progressCircleView
    var title: String {
        switch self {
        case .hydrationTarget:
            return "Hydration Target"
        case .curretHydration:
            return "Current Hydration"
        case .progressCircleView:
            return ""
        }
    }
    
    func content(viewModel: HomeViewModel) -> String {
        switch self {
        case .hydrationTarget:
            let target = viewModel.dailyHydration?.targetHydration ?? 0
            return "\(target) \(target == 1 ? "glass" : "glasses")"
        case .curretHydration:
            let current = viewModel.dailyHydration?.currentHydration ?? 0
            return "\(current) \(current == 1 ? "glass" : "glasses")"
        case .progressCircleView:
            return ""
        }
    }
}

enum ActivityCardType {
    case average
    case max
    case daysCompletedTarget
}
