//
//  DailyScheduleEntryController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/7/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import CoreData

class DailyScheduleEntryController {
    
    static let shared = DailyScheduleEntryController()
    
    //MARK: - Source of Truth
    var dailyScheduleEntries: [DailyScheduleEntry] = []
    
    init(){
        dailyScheduleEntries = fetchDailyScheduleEntry()
    }
    
    private func fetchDailyScheduleEntry() -> [DailyScheduleEntry] {
        let request: NSFetchRequest<DailyScheduleEntry> = DailyScheduleEntry.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    //MARK: - Functions
    func createDailyScheduleEntryWith(name: String) {
        let dailyScheduleEntry = DailyScheduleEntry(name: name)
        dailyScheduleEntries.append(dailyScheduleEntry)
        
        saveToPersistentStore()
    }
    
    func delete(dailyScheduleEntry: DailyScheduleEntry) {
        guard let moc = dailyScheduleEntry.managedObjectContext else { return }
        moc.delete(dailyScheduleEntry)
        dailyScheduleEntries = fetchDailyScheduleEntry()
        
        saveToPersistentStore()
    }
    
    //Save
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch let error {
            print("There was a problem saving to the persistent store: error \(error).")
        }
    }
    
}
