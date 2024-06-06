//
//  CalendarView.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/7/24.
//

import SwiftUI

struct CalendarView: View {
    @StateObject var viewModel = CalendarViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    viewModel.currentMonth = Calendar.current.date(byAdding: .month, value: -1, to: viewModel.currentMonth)!
                    viewModel.fetchHydrationData()
                }) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text(viewModel.currentMonth, formatter: monthYearFormatter)
                Spacer()
                Button(action: {
                    viewModel.currentMonth = Calendar.current.date(byAdding: .month, value: 1, to: viewModel.currentMonth)!
                    viewModel.fetchHydrationData()
                }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding()
            ScrollView(.vertical) {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 5), spacing: 10) {
                    ForEach(viewModel.daysInMonth, id: \.self) { date in
                        CalendarDayView(date: date, hydration: viewModel.dailyHydration(for: date))
                    }
                }
                .padding()
            }
            .onAppear {
                viewModel.fetchHydrationData()
            }
        }
    }
}

fileprivate let monthYearFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM yyyy"
    return formatter
}()

#Preview {
    CalendarView()
}
