//
//  TaskEntryController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/6/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import CoreData

class TaskEntryController {
    
    static let shared = TaskEntryController()
    
    //MARK: - Source of Truth
    var taskEntries: [TaskEntry] = []

    init(){
        taskEntries = fetchTaskEntry()
    }
    
    private func fetchTaskEntry() -> [TaskEntry] {
        let request: NSFetchRequest<TaskEntry> = TaskEntry.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    //MARK: - Functions
    func createTaskEntryWith(name: String) {
        let taskEntry = TaskEntry(name: name)
        taskEntries.append(taskEntry)
        
        saveToPersistentStore()
    }

    func delete(taskEntry: TaskEntry) {
        guard let moc = taskEntry.managedObjectContext else { return }
        moc.delete(taskEntry)
        taskEntries = fetchTaskEntry()
        
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

