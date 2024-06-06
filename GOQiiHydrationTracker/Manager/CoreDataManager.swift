//
//  CoreDataManager.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/6/24.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    let viewContext: NSManagedObjectContext
    
    private init() {
        self.persistentContainer = NSPersistentContainer(name: "HydrationModel")
        persistentContainer.loadPersistentStores { desccription, error in
            if let error = error {
                print("Unable to initialise persistent Container: \(error)")
            }
        }
        viewContext = persistentContainer.viewContext
    }
}

extension CoreDataManager {
    
    func fetchDailyHydration(for date: Date) -> DailyHydration? {
        let fetchRequest: NSFetchRequest<DailyHydration> = DailyHydration.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", date as CVarArg)
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            return result.first
        } catch {
            print("Error fetching DailyHydration: \(error)")
            return nil
        }
    }
    
    func fetchDailyHydrationByID(_ id: UUID) -> DailyHydration? {
        let fetchRequest: NSFetchRequest<DailyHydration> = DailyHydration.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            return result.first
        } catch {
            print("Error fetching DailyHydration by ID: \(error)")
            return nil
        }
    }
    
    func createDailyHydrationIfNeeded(for date: Date) -> DailyHydration? {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        
        guard let existingHydration = fetchDailyHydration(for: startOfDay) else {
            let newDailyHydration = DailyHydration(context: viewContext)
            newDailyHydration.date = startOfDay
            newDailyHydration.currentHydration = 0
            newDailyHydration.targetHydration = 0
            newDailyHydration.id = UUID()
            newDailyHydration.waterLogEntryList = []
            saveContext()
            return newDailyHydration
        }
        return existingHydration
    }
    
    func updateHydrationTarget(for dailyHydrationID: UUID, target: Int) -> DailyHydration? {
        guard let updatedDailyHydration = fetchDailyHydrationByID(dailyHydrationID) else { return nil }
        
        updatedDailyHydration.targetHydration = Int16(target)
        saveContext()
        return updatedDailyHydration
    }
    
    func updateCurrentHydration(for dailyHydrationID: UUID, amount: Int16) -> DailyHydration? {
        guard let updatedDailyHydration = fetchDailyHydrationByID(dailyHydrationID) else { return nil }
        
        updatedDailyHydration.currentHydration += amount
        saveContext()
        return updatedDailyHydration
    }
    
    func addWaterLogEntry(in dailyHydrationID: UUID, using numberOfGlasses: Int, timestamp: Date) -> DailyHydration? {
        guard let dailyHydration = fetchDailyHydrationByID(dailyHydrationID) else { return nil}
        
        let newWaterLogEntry = WaterLogEntry(context: viewContext)
        newWaterLogEntry.quantity = Int16(numberOfGlasses)
        newWaterLogEntry.enteredTime = timestamp
        newWaterLogEntry.id = UUID()
        dailyHydration.addToWaterLogEntryList(newWaterLogEntry)
        saveContext()
        return dailyHydration
    }
    
    func deleteWaterLogEntry(in dailyHydrationID: UUID, item: WaterLogEntry) -> DailyHydration? {
        guard let dailyHydration = fetchDailyHydrationByID(dailyHydrationID) else { return nil}
        dailyHydration.currentHydration -= item.quantity
        dailyHydration.removeFromWaterLogEntryList(item)
        saveContext()
        return dailyHydration
    }
    
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error: \(error)")
        }
    }
}

extension CoreDataManager {
    
}

