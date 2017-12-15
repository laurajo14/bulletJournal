//
//  WeeklyEntryController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/15/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import CloudKit

class WeeklyEntryController {
    
    static let shared = WeeklyEntryController()
    
    //MARK: - Properties
    let cloudKitManager: CloudKitManager
    let privateDatabase = CKContainer.default().privateCloudDatabase
    
    //MARK: - Source of Truth
    var weeklyEntries: [WeeklyEntry] = [] {
        didSet {
            NotificationCenter.default.post(name: Notifications.weeklyEntryWasUpdatedNotification, object: nil)
        }
    }
    
    init() {
        self.cloudKitManager = CloudKitManager()
    }
    
    //MARK: - Functions
    //CREATE
    func createWeeklyEntryWith(weeklyGoalEntry: String, weeklyPlanEntry: String, weeklyReviewEntry: String, weeklyJournalEntry: String) {
        WeeklyEntry(weeklyGoalEntry: weeklyGoalEntry, weeklyPlanEntry: weeklyPlanEntry, weeklyReviewEntry: weeklyReviewEntry, weeklyJournalEntry: weeklyJournalEntry)
        
        let weeklyEntry = WeeklyEntry(weeklyGoalEntry: weeklyGoalEntry, weeklyPlanEntry: weeklyPlanEntry, weeklyReviewEntry: weeklyReviewEntry, weeklyJournalEntry: weeklyJournalEntry)
        weeklyEntries.append(weeklyEntry)
        
        cloudKitManager.saveRecord(weeklyEntry.cloudKitRecord) { (record, error) in
            if let error = error {
                print("Error saving Weekly Entry to cloudKit: \(error.localizedDescription) in file: \(#file)")
                return
            }
            return
        }
    }
    
    //UPDATE
    func updateWeeklyEntryWith(weeklyEntry: WeeklyEntry, weeklyGoalEntry: String, weeklyPlanEntry: String, weeklyReviewEntry: String, weeklyJournalEntry: String) {
        
        weeklyEntry.weeklyGoalEntry = weeklyGoalEntry
        weeklyEntry.weeklyPlanEntry = weeklyPlanEntry
        weeklyEntry.weeklyReviewEntry = weeklyReviewEntry
        weeklyEntry.weeklyJournalEntry = weeklyJournalEntry
        
        cloudKitManager.modifyRecords([weeklyEntry.cloudKitRecord], perRecordCompletion: nil) { (records, error) in
            
            if let error = error {
                print("Error saving new Weekly Entry: \(error.localizedDescription) in file: \(#file)")
                return
            }
            
            // Update the first Account
            guard let record = records?.first else {return}
            let updatedWeeklyEntry = WeeklyEntry(cloudKitRecord: record)
        }
        
    }
    
    //DELETE
    func delete(weeklyEntry: WeeklyEntry) {
        
        cloudKitManager.deleteRecordWithID(weeklyEntry.recordID) { (recordID, error) in
            
            if let error = error {
                print("Error deleting Weekly Task Entry: \(error.localizedDescription) in file: \(#file)")
                return
            }
        }
    }
    
    // MARK: - Fetch Data from CloudKit
    func fetchWeeklyEntriesFromCloudKit() {
        
        // Get all of the accounts
        let predicate = NSPredicate(value: true)
        
        // Create a query
        let query = CKQuery(recordType: Keys.recordWeeklyEntryType, predicate: predicate)
        
        // Fetch the data form cloudkit
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            // Check for an errror
            if let error = error {
                print("Error fetching the Weekly Entry Data: \(error.localizedDescription) in file: \(#file)")
            }
            
            guard let records = records else {return}
            
            // Send the accounts through the cloudKit Initializer
            let weeklyEntry = records.flatMap( {WeeklyEntry(cloudKitRecord: $0)})
            
            self.weeklyEntries = weeklyEntry
        }
    }
}
