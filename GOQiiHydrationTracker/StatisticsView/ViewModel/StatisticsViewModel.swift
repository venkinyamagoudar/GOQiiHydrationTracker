//
//  StatisticsViewModel.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/6/24.
//

import SwiftUI
import CoreData

class StatisticsViewModel: ObservableObject {
    @Published var lastSevenDaysData: [DailyHydration] = []
    @Published var lastThirtyDaysData: [DailyHydration] = []
    @Published var averageGlasses: Double = 0
    @Published var maxGlasses: Int = 0
    @Published var daysCompletedTarget: Int = 0
    
    
    @Published var selectedIndex = 0
    
    let coreDataManager = CoreDataManager.shared
    
    var hasItems: Bool {
        return true
    }
    
    var hasLastSevenDaysData: Bool {
        return !lastSevenDaysData.isEmpty
    }
    
    var hasLastThirtyDays: Bool {
        return !lastThirtyDaysData.isEmpty
    }
    
    func fetchStatistics() {
        fetchLastSevenDaysData()
        fetchLastThirtyDaysData()
        fetchAverageGlasses()
        fetchMaxGlasses()
        fetchDaysCompletedTarget()
    }
    
    private func fetchLastSevenDaysData() {
        let currentDate = Date()
        guard let startDate = Calendar.current.date(byAdding: .day, value: -6, to: currentDate) else {
            return
        }
        lastSevenDaysData = fetchDailyHydrationData(startDate: startDate, endDate: currentDate)
    }
    
    private func fetchLastThirtyDaysData() {
        let currentDate = Date()
        guard let startDate = Calendar.current.date(byAdding: .day, value: -29, to: currentDate) else {
            return
        }
        lastThirtyDaysData = fetchDailyHydrationData(startDate: startDate, endDate: currentDate)
    }
    
    private func fetchDailyHydrationData(startDate: Date, endDate: Date) -> [DailyHydration] {
        var data: [DailyHydration] = []
        
        let fetchRequest: NSFetchRequest<DailyHydration> = DailyHydration.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", startDate as NSDate, endDate as NSDate)
        
        do {
            let result = try coreDataManager.viewContext.fetch(fetchRequest)
            data = result
        } catch {
            print("Error fetching daily hydration data: \(error)")
        }
        
        return data
    }
    
    private func fetchAverageGlasses() {
        let fetchRequest: NSFetchRequest<DailyHydration> = DailyHydration.fetchRequest()
        
        do {
            let result = try coreDataManager.viewContext.fetch(fetchRequest)
            let totalGlasses = result.reduce(0, { $0 + Double($1.currentHydration) })
            averageGlasses = totalGlasses / Double(result.count)
        } catch {
            print("Error fetching average glasses consumed: \(error)")
        }
    }
    
    private func fetchMaxGlasses() {
        let fetchRequest: NSFetchRequest<DailyHydration> = DailyHydration.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "currentHydration", ascending: false)]
        
        do {
            let result = try coreDataManager.viewContext.fetch(fetchRequest)
            if let maxEntry = result.first {
                maxGlasses = Int(maxEntry.currentHydration)
            }
        } catch {
            print("Error fetching max glasses consumed: \(error)")
        }
    }
    
    private func fetchDaysCompletedTarget() {
        let fetchRequest: NSFetchRequest<DailyHydration> = DailyHydration.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "currentHydration >= targetHydration")
        
        do {
            let result = try coreDataManager.viewContext.fetch(fetchRequest)
            daysCompletedTarget = result.count
        } catch {
            print("Error fetching days completed target: \(error)")
        }
    }
}
