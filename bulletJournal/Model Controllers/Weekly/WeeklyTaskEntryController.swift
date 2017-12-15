//
//  WeeklyTaskEntryController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/14/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import CloudKit

class WeeklyTaskEntryController {
    
    static let shared = WeeklyTaskEntryController()
    
    //MARK: - Properties
    let cloudKitManager: CloudKitManager
    let privateDatabase = CKContainer.default().privateCloudDatabase
    
    //MARK: - Source of Truth
    var weeklyTaskEntries: [WeeklyTaskEntry] = [] {
        didSet {
            NotificationCenter.default.post(name: Notifications.weeklyTaskWasUpdatedNotification, object: nil)
        }
    }
    
    init() {
        self.cloudKitManager = CloudKitManager()
    }
    
    //MARK: - Functions
    //CREATE
    func createWeeklyTaskEntryWith(name: String, bulletType: String) {
        WeeklyTaskEntry(name: name, bulletType: bulletType)
        
        let weeklyTaskEntry = WeeklyTaskEntry(name: name, bulletType: bulletType)
        weeklyTaskEntries.append(weeklyTaskEntry)
        
        cloudKitManager.saveRecord(weeklyTaskEntry.cloudKitRecord) { (record, error) in
            if let error = error {
                print("Error saving Weekly Task Entry to cloudKit: \(error.localizedDescription) in file: \(#file)")
                return
            }
            return
        }
    }
    
    //UPDATE
    func updateWeeklyTaskEntryWith(weeklyTaskEntry: WeeklyTaskEntry, name: String, bulletType: String, completion: @escaping (WeeklyTaskEntry?) -> Void) {
        
        weeklyTaskEntry.name = name
        weeklyTaskEntry.bulletType = bulletType
        
        cloudKitManager.modifyRecords([weeklyTaskEntry.cloudKitRecord], perRecordCompletion: nil) { (records, error) in
            
            if let error = error {
                print("Error saving new Weekly Task Entry: \(error.localizedDescription) in file: \(#file)")
                completion(nil)
                return
            }
            
            // Update the first Account
            guard let record = records?.first else {return}
            let updatedWeeklyTaskEntry = WeeklyTaskEntry(cloudKitRecord: record)
            completion(updatedWeeklyTaskEntry)
        }
        
    }
    
    //DELETE
    func delete(weeklyTaskEntry: WeeklyTaskEntry) {
        
        cloudKitManager.deleteRecordWithID(weeklyTaskEntry.recordID) { (recordID, error) in
            
            if let error = error {
                print("Error deleting Weekly Task Entry: \(error.localizedDescription) in file: \(#file)")
                return
            }
        }
    }
    
    // MARK: - Fetch Data from CloudKit
    func fetchWeeklyTaskEntriesFromCloudKit() {
        
        // Get all of the accounts
        let predicate = NSPredicate(value: true)
        
        // Create a query
        let query = CKQuery(recordType: Keys.recordWeeklyTaskEntryType, predicate: predicate)
        
        // Fetch the data form cloudkit
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            // Check for an errror
            if let error = error {
                print("Error fetching the Accounts Data: \(error.localizedDescription) in file: \(#file)")
            }
            
            guard let records = records else {return}
            
            // Send the accounts through the cloudKit Initializer
            let weeklyTaskEntry = records.flatMap( {WeeklyTaskEntry(cloudKitRecord: $0)})
            
            self.weeklyTaskEntries = weeklyTaskEntry
        }
    }
    
    /// This function takes an input of array of Transactions and returns a ordered dictionary of transactions key value pairs of the date/month of the transaction as the key and an array of transactions as the value
    //    func returnDictionary(fromArray array: [Transaction]) -> [(key: Date, value: [Transaction])] {
    //
    //        var dictionary: [(key: Date, value: [Transaction])]?
    //        let dictionaryOfArray = Dictionary(grouping:array){ $0.monthYearDate}
    //        let sortedArray = dictionaryOfArray.sorted(by: { $0.0 > $1.0 })
    //        dictionary = sortedArray
    //        guard let finalDictionary = dictionary else { return [] }
    //        return finalDictionary
    //    }
    //
    //    func monthYearTuple(fromDate date: Date) -> (Int, Int) {
    //        let month = Calendar.current.component(.month, from: Date())
    //        let year = Calendar.current.component(.year, from: Date())
    //        return (month, year)
    //    }
    
}

