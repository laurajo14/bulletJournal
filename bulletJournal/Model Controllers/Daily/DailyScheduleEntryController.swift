//
//  DailyScheduleEntryController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/7/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import CloudKit

class DailyScheduleEntryController {
    
    static let shared = DailyScheduleEntryController()
    
    //MARK: - Properties
    let cloudKitManager: CloudKitManager
    let privateDatabase = CKContainer.default().privateCloudDatabase
    
    //MARK: - Source of Truth
    var dailyScheduleEntries: [DailyScheduleEntry] = [] {
        didSet {
            NotificationCenter.default.post(name: Notifications.dailyScheduleEntryWasUpdatedNotification, object: nil)
        }
    }
    
    init() {
        self.cloudKitManager = CloudKitManager()
    }
    
    //MARK: - Functions
    //CREATE
    func createDailyScheduleEntryWith(name: String) {
        DailyScheduleEntry(name: name)
        
        let dailyScheduleEntry = DailyScheduleEntry(name: name)
        dailyScheduleEntries.append(dailyScheduleEntry)
        
        cloudKitManager.saveRecord(dailyScheduleEntry.cloudKitRecord) { (record, error) in
            
            if let error = error {
                print("Error saving Daily Schedule Entry to cloudKit: \(error.localizedDescription) in file: \(#file)")
                return
            }
            return
        }
    }
    
    //UPDATE
    func updateDailyScheduleEntryWith(dailyScheduleEntry: DailyScheduleEntry, name: String, completion: @escaping (DailyScheduleEntry?) -> Void) {
        
        dailyScheduleEntry.name = name
        
        cloudKitManager.modifyRecords([dailyScheduleEntry.cloudKitRecord], perRecordCompletion: nil) { (records, error) in
            
            if let error = error {
                print("Error saving new Daily Schedule Entry: \(error.localizedDescription) in file: \(#file)")
                completion(nil)
                return
            }
            
            // Update the first Account
            guard let record = records?.first else {return}
            let updatedDailyScheduleEntry = DailyScheduleEntry(cloudKitRecord: record)
            completion(updatedDailyScheduleEntry)
        }
        
    }
    
    //DELETE
    func delete(dailyScheduleEntry: DailyScheduleEntry) {
        
        cloudKitManager.deleteRecordWithID(dailyScheduleEntry.recordID) { (recordID, error) in
            
            if let error = error {
                print("Error deleting Daily Schedule Entry: \(error.localizedDescription) in file: \(#file)")
                return
            }
        }
    }
    
    // MARK: - Fetch Data from CloudKit
    func fetchDailyScheduleEntriesFromCloudKit() {
        
        // Get all of the accounts
        let predicate = NSPredicate(value: true)
        
        // Create a query
        let query = CKQuery(recordType: Keys.recordDailyScheduleEntryType, predicate: predicate)
        
        // Fetch the data form cloudkit
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            // Check for an errror
            if let error = error {
                print("Error fetching the Daily Schedule Entries Data: \(error.localizedDescription) in file: \(#file)")
            }
            
            guard let records = records else {return}
            
            // Send the accounts through the cloudKit Initializer
            let dailyScheduleEntry = records.flatMap( {DailyScheduleEntry(cloudKitRecord: $0)})
            
            self.dailyScheduleEntries = dailyScheduleEntry
        }
    }
}
