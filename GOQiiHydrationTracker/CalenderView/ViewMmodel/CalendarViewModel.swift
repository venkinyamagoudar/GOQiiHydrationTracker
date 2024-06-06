//
//  CalendarViewModel.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/7/24.
//

import SwiftUI
import CoreData

class CalendarViewModel: ObservableObject {
    @Published var currentMonth: Date = Date()
    @Published var daysInMonth: [Date] = []
    private var dailyHydrations: [Date: DailyHydration] = [:]

    init() {
        fetchHydrationData()
    }

    func fetchHydrationData() {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: currentMonth)!
        daysInMonth = range.compactMap { day -> Date? in
            let components = DateComponents(year: calendar.component(.year, from: currentMonth),
                                            month: calendar.component(.month, from: currentMonth),
                                            day: day)
            return calendar.date(from: components)
        }
        for date in daysInMonth {
            dailyHydrations[date] = CoreDataManager.shared.fetchDailyHydration(for: date)
        }
    }

    func dailyHydration(for date: Date) -> DailyHydration? {
        return dailyHydrations[date]
    }
}
