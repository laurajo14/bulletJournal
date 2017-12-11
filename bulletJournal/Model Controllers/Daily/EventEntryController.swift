//
//  EventEntryController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/6/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import CoreData

class EventEntryController {
    
    static let shared = EventEntryController()
    
    //MARK: - Source of Truth
    var eventEntries: [EventEntry] = []
    
    init(){
        eventEntries = fetchEventEntry()
    }
    
    private func fetchEventEntry() -> [EventEntry] {
        let request: NSFetchRequest<EventEntry> = EventEntry.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    
    //MARK: - Functions
    func createEventEntryWith(name: String) {
        let eventEntry = EventEntry(name: name)
        eventEntries.append(eventEntry)
        
        saveToPersistentStore()
    }
    
    func delete(eventEntry: EventEntry) {
        guard let moc = eventEntry.managedObjectContext else { return }
        moc.delete(eventEntry)
        eventEntries = fetchEventEntry()
        
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

