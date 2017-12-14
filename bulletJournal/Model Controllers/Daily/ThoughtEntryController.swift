//
//  bulletEntryController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/6/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import CloudKit

class ThoughtEntryController {
    
    static let shared = ThoughtEntryController()
    
    //MARK: - Properties
    let cloudKitManager: CloudKitManager
    let privateDatabase = CKContainer.default().privateCloudDatabase
    
    //MARK: - Source of Truth
    var thoughtEntries: [ThoughtEntry] = [] {
        didSet {
            NotificationCenter.default.post(name: Notifications.thoughtEntryWasUpdatedNotification, object: nil)
        }
    }
    
    init() {
        self.cloudKitManager = CloudKitManager()
    }
    
    //MARK: - Functions
    //CREATE
    func createThoughtEntryWith(name: String) {
        ThoughtEntry(name: name)
        
        let thoughtEntry = ThoughtEntry(name: name)
        thoughtEntries.append(thoughtEntry)
        
        cloudKitManager.saveRecord(thoughtEntry.cloudKitRecord) { (record, error) in
            
            if let error = error {
                print("Error saving Thought Entry to cloudKit: \(error.localizedDescription) in file: \(#file)")
                return
            }
            return
        }
    }
    
    //UPDATE
    func updateThoughtEntryWith(thoughtEntry: ThoughtEntry, name: String, completion: @escaping (ThoughtEntry?) -> Void) {
        
        thoughtEntry.name = name
        
        cloudKitManager.modifyRecords([thoughtEntry.cloudKitRecord], perRecordCompletion: nil) { (records, error) in
            
            if let error = error {
                print("Error saving new Thought Entry: \(error.localizedDescription) in file: \(#file)")
                completion(nil)
                return
            }
            
            // Update the first Account
            guard let record = records?.first else {return}
            let updatedThoughtEntry = ThoughtEntry(cloudKitRecord: record)
            completion(updatedThoughtEntry)
        }
        
    }
    
    //DELETE
    func delete(thoughtEntry: ThoughtEntry) {
        
        cloudKitManager.deleteRecordWithID(thoughtEntry.recordID) { (recordID, error) in
            
            if let error = error {
                print("Error deleting Thought Entry: \(error.localizedDescription) in file: \(#file)")
                return
            }
        }
    }
    
    // MARK: - Fetch Data from CloudKit
    func fetchThoughtEntriesFromCloudKit() {
        
        // Get all of the accounts
        let predicate = NSPredicate(value: true)
        
        // Create a query
        let query = CKQuery(recordType: Keys.recordThoughtEntryType, predicate: predicate)
        
        // Fetch the data form cloudkit
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            // Check for an errror
            if let error = error {
                print("Error fetching the Thought Entries Data: \(error.localizedDescription) in file: \(#file)")
            }
            
            guard let records = records else {return}
            
            // Send the accounts through the cloudKit Initializer
            let thoughtEntry = records.flatMap( {ThoughtEntry(cloudKitRecord: $0)})
            
            self.thoughtEntries = thoughtEntry
        }
    }
}
