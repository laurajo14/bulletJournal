//
//  MonthlyTaskEntryController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/9/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import CloudKit

class MonthlyTaskEntryController {
    
    static let shared = MonthlyTaskEntryController()
    
    //MARK: - Properties
    let cloudKitManager: CloudKitManager
    let privateDatabase = CKContainer.default().privateCloudDatabase
    
    //MARK: - Source of Truth
    var monthlyTaskEntries: [MonthlyTaskEntry] = [] {
        didSet {
            NotificationCenter.default.post(name: Notifications.monthlyTaskWasUpdatedNotification, object: nil)
        }
    }
    
    init() {
        self.cloudKitManager = CloudKitManager()
    }
    
    //MARK: - Functions
    //CREATE
    func createMonthlyTaskEntryWith(name: String, bulletType: String) {
        MonthlyTaskEntry(name: name, bulletType: bulletType)
        
        let monthlyTaskEntry = MonthlyTaskEntry(name: name, bulletType: bulletType)
        monthlyTaskEntries.append(monthlyTaskEntry)
        
        cloudKitManager.saveRecord(monthlyTaskEntry.cloudKitRecord) { (record, error) in
            
            if let error = error {
                print("Error saving Monthly Task Entry to cloudKit: \(error.localizedDescription) in file: \(#file)")
                return
            }
            return
        }
    }
    
    //UPDATE
    func updateMonthlyTaskEntryWith(monthlyTaskEntry: MonthlyTaskEntry, name: String, bulletType: String, completion: @escaping (MonthlyTaskEntry?) -> Void) {
        
        monthlyTaskEntry.name = name
        monthlyTaskEntry.bulletType = bulletType
        
        cloudKitManager.modifyRecords([monthlyTaskEntry.cloudKitRecord], perRecordCompletion: nil) { (records, error) in
            
            if let error = error {
                print("Error saving new Monthly Task Entry: \(error.localizedDescription) in file: \(#file)")
                completion(nil)
                return
            }
            
            // Update the first Account
            guard let record = records?.first else {return}
            let updatedMonthlyTaskEntry = MonthlyTaskEntry(cloudKitRecord: record)
            completion(updatedMonthlyTaskEntry)
        }
        
    }
    
    //DELETE
    func delete(monthlyTaskEntry: MonthlyTaskEntry) {
        
        cloudKitManager.deleteRecordWithID(monthlyTaskEntry.recordID) { (recordID, error) in
            
            if let error = error {
                print("Error deleting Monthly Task Entry: \(error.localizedDescription) in file: \(#file)")
                return
            }
        }
    }

    // MARK: - Fetch Data from CloudKit
    func fetchMonthlyTaskEntriesFromCloudKit() {
        
        // Get all of the accounts
        let predicate = NSPredicate(value: true)
        
        // Create a query
        let query = CKQuery(recordType: Keys.recordMonthlyTaskEntryType, predicate: predicate)
        
        // Fetch the data form cloudkit
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            // Check for an errror
            if let error = error {
                print("Error fetching the Accounts Data: \(error.localizedDescription) in file: \(#file)")
            }
            
            guard let records = records else {return}
            
            // Send the accounts through the cloudKit Initializer
            let monthlyTaskEntry = records.flatMap( {MonthlyTaskEntry(cloudKitRecord: $0)})
            
            self.monthlyTaskEntries = monthlyTaskEntry
        }
    }
}
