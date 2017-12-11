//
//  bulletEntryController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/6/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import CoreData

class ThoughtEntryController {
    
    static let shared = ThoughtEntryController()

    //MARK: - Source of Truth
    var thoughtEntries: [ThoughtEntry] = []
    
    init(){
        thoughtEntries = fetchThoughtEntry()
    }
    
    private func fetchThoughtEntry() -> [ThoughtEntry] {
        let request: NSFetchRequest<ThoughtEntry> = ThoughtEntry.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    //MARK: - Functions
    func createThoughtEntryWith(name: String) {
        let thoughtEntry = ThoughtEntry(name: name)
        thoughtEntries.append(thoughtEntry)
        
        saveToPersistentStore()
    }
    
    func delete(thoughtEntry: ThoughtEntry) {
        guard let moc = thoughtEntry.managedObjectContext else { return }
        moc.delete(thoughtEntry)
        thoughtEntries = fetchThoughtEntry()
        
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

