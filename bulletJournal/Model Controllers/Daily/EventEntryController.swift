//
//  EventEntryController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/6/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import CloudKit

class EventEntryController {
    
    static let shared = EventEntryController()
    
    //MARK: - Properties
    let cloudKitManager: CloudKitManager
    let privateDatabase = CKContainer.default().privateCloudDatabase
    
    //MARK: - Source of Truth
    var eventEntries: [EventEntry] = [] {
        didSet {
            NotificationCenter.default.post(name: Notifications.eventEntryWasUpdatedNotification, object: nil)
        }
    }
    
    init() {
        self.cloudKitManager = CloudKitManager()
    }
    
    //MARK: - Functions
    //CREATE
    func createEventEntryWith(name: String) {
        EventEntry(name: name)
        
        let eventEntry = EventEntry(name: name)
        eventEntries.append(eventEntry)
        
        cloudKitManager.saveRecord(eventEntry.cloudKitRecord) { (record, error) in
            
            if let error = error {
                print("Error saving Monthly Event Entry to cloudKit: \(error.localizedDescription) in file: \(#file)")
                return
            }
            return
        }
    }
    
    //UPDATE
    func updateEventEntryWith(eventEntry: EventEntry, name: String, completion: @escaping (EventEntry?) -> Void) {
        
        eventEntry.name = name
        
        cloudKitManager.modifyRecords([eventEntry.cloudKitRecord], perRecordCompletion: nil) { (records, error) in
            
            if let error = error {
                print("Error saving new Event Entry: \(error.localizedDescription) in file: \(#file)")
                completion(nil)
                return
            }
            
            // Update the first Account
            guard let record = records?.first else {return}
            let updatedEventEntry = EventEntry(cloudKitRecord: record)
            completion(updatedEventEntry)
        }
        
    }
    
    //DELETE
    func delete(eventEntry: EventEntry) {
        
        cloudKitManager.deleteRecordWithID(eventEntry.recordID) { (recordID, error) in
            
            if let error = error {
                print("Error deleting Event Entry: \(error.localizedDescription) in file: \(#file)")
                return
            }
        }
    }
    
    // MARK: - Fetch Data from CloudKit
    func fetchEventEntriesFromCloudKit() {
        
        // Get all of the accounts
        let predicate = NSPredicate(value: true)
        
        // Create a query
        let query = CKQuery(recordType: Keys.recordEventEntryType, predicate: predicate)
        
        // Fetch the data form cloudkit
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            // Check for an errror
            if let error = error {
                print("Error fetching the Event Entries Data: \(error.localizedDescription) in file: \(#file)")
            }
            
            guard let records = records else {return}
            
            // Send the accounts through the cloudKit Initializer
            let eventEntry = records.flatMap( {EventEntry(cloudKitRecord: $0)})
            
            self.eventEntries = eventEntry
        }
    }
}
