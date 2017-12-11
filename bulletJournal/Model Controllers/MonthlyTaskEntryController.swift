//
//  MonthlyTaskEntryController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/9/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import CoreData

class MonthlyTaskEntryController {
    
    static let shared = MonthlyTaskEntryController()
    
    var monthlyTaskEntries: [MonthlyTaskEntry] {
        let request: NSFetchRequest<MonthlyTaskEntry> = MonthlyTaskEntry.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    //MARK: - Source of Truth
    var monthlyTaskEntry: [MonthlyTaskEntry] = []
    
    //MARK: - Functions
    func createMonthlyTaskEntryWith(name: String, bulletType: String) {
        MonthlyTaskEntry(name: name, bulletType: bulletType)
        
        saveToPersistentStore()
    }
    
    func delete(monthlyTaskEntry: MonthlyTaskEntry) {
        guard let moc = monthlyTaskEntry.managedObjectContext else { return }
        moc.delete(monthlyTaskEntry)

        
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
